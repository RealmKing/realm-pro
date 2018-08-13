package com.realmcloud.admin.controller;

import com.xiaoleilu.hutool.date.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.realmcloud.admin.entity.ErpProProduct;
import com.realmcloud.admin.service.ErpProProductService;
import com.baomidou.mybatisplus.plugins.Page;
import com.realmcloud.admin.util.LayerData;
import com.realmcloud.admin.util.RestResponse;
import com.realmcloud.admin.annotation.SysLog;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.WebUtils;

import javax.servlet.ServletRequest;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 产品基础信息  前端控制器
 * </p>
 *
 * @author realm
 * @since 2018-07-09
 */
@Controller
@RequestMapping("/admin/erpProProduct")
public class ErpProProductController {
    private static final Logger LOGGER = LoggerFactory.getLogger(ErpProProductController.class);

    @Autowired
    private ErpProProductService erpProProductService;

    @GetMapping("list")
    @SysLog("跳转产品基础信息列表")
    public String list(){
        return "/admin/erpProProduct/list";
    }

    @PostMapping("list")
    @ResponseBody
    @SysLog("请求产品基础信息列表数据")
    public LayerData<ErpProProduct> list(@RequestParam(value = "page",defaultValue = "1")Integer page,
                                      @RequestParam(value = "limit",defaultValue = "10")Integer limit,
                                      ServletRequest request){
        Map map = WebUtils.getParametersStartingWith(request, "s_");
        LayerData<ErpProProduct> layerData = new LayerData<>();
        EntityWrapper<ErpProProduct> wrapper = new EntityWrapper<>();
        wrapper.eq("del_flag",false);
        if(!map.isEmpty()){
            String productId = (String) map.get("productId");
            if(StringUtils.isNotBlank(productId)) {
                wrapper.like("product_id",productId);
            }else{
                map.remove("productId");
            }

            String productName = (String) map.get("productName");
            if(StringUtils.isNotBlank(productName)) {
                wrapper.like("product_name",productName);
            }else{
                map.remove("productName");
            }

            String productBrand = (String) map.get("productBrand");
            if(StringUtils.isNotBlank(productBrand)) {
                wrapper.eq("product_brand",productBrand);
            }else{
                map.remove("productBrand");
            }

        }
        Page<ErpProProduct> pageData = erpProProductService.selectPage(new Page<>(page,limit),wrapper);
        layerData.setData(pageData.getRecords());
        layerData.setCount(pageData.getTotal());
        return layerData;
    }

    @GetMapping("add")
    @SysLog("跳转新增产品基础信息页面")
    public String add(){
        return "/admin/erpProProduct/add";
    }

    @PostMapping("add")
    @SysLog("保存新增产品基础信息数据")
    @ResponseBody
    public RestResponse add(ErpProProduct erpProProduct){
        if(StringUtils.isBlank(erpProProduct.getProductId())){
            return RestResponse.failure("产品ID不能为空");
        }
        erpProProductService.insert(erpProProduct);
        return RestResponse.success();
    }

    @GetMapping("edit")
    @SysLog("跳转编辑产品基础信息页面")
    public String edit(Long id,Model model){
        ErpProProduct erpProProduct = erpProProductService.selectById(id);
        model.addAttribute("erpProProduct",erpProProduct);
        return "/admin/erpProProduct/edit";
    }

    @PostMapping("edit")
    @ResponseBody
    @SysLog("保存编辑产品基础信息数据")
    public RestResponse edit(ErpProProduct erpProProduct){
        if(null == erpProProduct.getId() || 0 == erpProProduct.getId()){
            return RestResponse.failure("ID不能为空");
        }
        if(StringUtils.isBlank(erpProProduct.getProductId())){
            return RestResponse.failure("产品ID不能为空");
        }
        erpProProductService.updateById(erpProProduct);
        return RestResponse.success();
    }

    @PostMapping("delete")
    @ResponseBody
    @SysLog("删除产品基础信息数据")
    public RestResponse delete(@RequestParam(value = "id",required = false)Long id){
        if(null == id || 0 == id){
            return RestResponse.failure("ID不能为空");
        }
        ErpProProduct erpProProduct = erpProProductService.selectById(id);
        erpProProduct.setDelFlag(true);
        erpProProductService.updateById(erpProProduct);
        return RestResponse.success();
    }

}