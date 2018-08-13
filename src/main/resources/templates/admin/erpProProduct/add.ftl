<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>产品基础信息添加--${site.name}</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <meta name="description" content="${site.description}"/>
    <meta name="keywords" content="${site.keywords}"/>
    <meta name="author" content="${site.author}"/>
    <link rel="icon" href="${site.logo}">
    <link rel="stylesheet" href="${base}/static/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="${base}/static/css/public.css" />
    <style type="text/css">
        .layui-form-item .layui-inline{ width:33.333%; float:left; margin-right:0; }
        @media(max-width:1240px){
            .layui-form-item .layui-inline{ width:100%; float:none; }
        }
        .layui-form-item .role-box {
            position: relative;
        }
        .layui-form-item .role-box .jq-role-inline {
            height: 100%;
            overflow: auto;
        }

    </style>
</head>
<body class="childrenBody">
<form class="layui-form" style="width:80%;">
    <div class="layui-form-item">
        <label class="layui-form-label">产品ID</label>
        <div class="layui-input-block">
            <input  type="text"  class="layui-input" lay-verify="required"  name="productId"  placeholder="请输入产品ID">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">产品名称</label>
        <div class="layui-input-block">

            <input  type="text"  class="layui-input" name="productName"  placeholder="请输入产品名称">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">产品型号</label>
        <div class="layui-input-block">

            <select name="productVersion" >
                <option value="" selected="">请选择产品型号</option>
                <@my type="erp_pro_product_product_version">
                <#list result as r>
                <option value="${r.value}" >${r.label}</option>
                </#list>
                </@my>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">计量单位</label>
        <div class="layui-input-block">

            <select name="productUnit" >
                <option value="" selected="">请选择计量单位</option>
                <@my type="erp_pro_product_product_unit">
                <#list result as r>
                <option value="${r.value}" >${r.label}</option>
                </#list>
                </@my>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">品牌</label>
        <div class="layui-input-block">

            <select name="productBrand" >
                <option value="" selected="">请选择品牌</option>
                <@my type="erp_pro_product_product_brand">
                <#list result as r>
                <option value="${r.value}" >${r.label}</option>
                </#list>
                </@my>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">所属国家</label>
        <div class="layui-input-block">

            <select name="productNation" >
                <option value="" selected="">请选择所属国家</option>
                <@my type="erp_pro_product_product_nation">
                    <#list result as r>
                <option value="${r.value}" >${r.label}</option>
                    </#list>
                </@my>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">所属省</label>
        <div class="layui-input-block">

            <select name="productProvince" >
                <option value="" selected="">请选择所属省</option>
                <@my type="erp_pro_product_product_province">
                <#list result as r>
                <option value="${r.value}" >${r.label}</option>
                </#list>
                </@my>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">所属市</label>
        <div class="layui-input-block">

            <select name="productCity" >
                <option value="" selected="">请选择所属市</option>
                <@my type="erp_pro_product_product_city">
                <#list result as r>
                <option value="${r.value}" >${r.label}</option>
                </#list>
                </@my>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">详细地址</label>
        <div class="layui-input-block">
            <input  type="text"  class="layui-input" lay-verify="required"  name="productAddress"  placeholder="请输入详细地址">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="addErpProProduct">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
<script type="text/javascript" src="${base}/static/layui/layui.js"></script>
<script>
    layui.use(['form','jquery','layer'],function(){
        var form      = layui.form,
                $     = layui.jquery,
                layer = layui.layer;


        form.on("submit(addErpProProduct)",function(data){

            var loadIndex = layer.load(2, {
                shade: [0.3, '#333']
            });
            $.post("${base}/admin/erpProProduct/add",data.field,function(res){
                layer.close(loadIndex);
                if(res.success){
                    parent.layer.msg("产品基础信息添加成功！",{time:1000},function(){
                        parent.layer.close(parent.addIndex);
                        //刷新父页面
                        parent.location.reload();
                    });
                }else{
                    layer.msg(res.message);
                }
            });
            return false;
        });

    });
</script>
</body>
</html>