package com.realmcloud.admin.service.impl;

import com.realmcloud.admin.entity.ErpProProduct;
import com.realmcloud.admin.dao.ErpProProductDao;
import com.realmcloud.admin.service.ErpProProductService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 * 产品基础信息 服务实现类
 * </p>
 *
 * @author realm
 * @since 2018-07-09
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class ErpProProductServiceImpl extends ServiceImpl<ErpProProductDao, ErpProProduct> implements ErpProProductService {

}
