<!DOCTYPE html>
<html class="loginHtml">
<head>
    <meta charset="utf-8">
    <title>${site.name}</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" href="${site.logo}">
    <link rel="stylesheet" href="${base}/static/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="${base}/static/css/public.css" media="all" />
</head>
<body class="loginBody">
<form class="layui-form" action="${base}/login/main" method="post">
    <div class="login_face"><img src="<#if (currentUser.icon??)>${currentUser.icon}<#else>${base}/static/images/face.jpg</#if>" class="userAvatar"></div>
    <div class="layui-form-item input-item">
        <label for="username">用户名</label>
        <input type="text" placeholder="请输入用户名" id="username" name="username" class="layui-input" lay-verify="required">
    </div>
    <div class="layui-form-item input-item">
        <label for="password">密码</label>
        <input type="password" placeholder="请输入密码" id="password" name="password" class="layui-input" lay-verify="required">
    </div>
    <div class="layui-form-item input-item" id="imgCode">
        <label for="code">验证码</label>
        <input class="layui-input" name="code" placeholder="验证码" lay-verify="required" type="text" autocomplete="off">
        <div class="code"><img src="${base}/genCaptcha" width="116" height="36" id="mycode"></div>
    </div>
    <div class="layui-form-item">
        <input type="checkbox" name="rememberMe" value="true" lay-skin="primary" checked title="记住帐号?">
    </div>
    <div class="layui-form-item">
        <button class="layui-btn layui-block" lay-filter="login" lay-submit>登录</button>
    </div>
    <#--<div class="layui-form-item layui-row">-->
        <#--<a href="javascript:;" class="seraph icon-qq layui-col-xs4 layui-col-sm4 layui-col-md4 layui-col-lg4"></a>-->
        <#--<a href="javascript:;" class="seraph icon-wechat layui-col-xs4 layui-col-sm4 layui-col-md4 layui-col-lg4"></a>-->
        <#--<a href="javascript:;" class="seraph icon-sina layui-col-xs4 layui-col-sm4 layui-col-md4 layui-col-lg4"></a>-->
    <#--</div>-->
</form>
<script type="text/javascript" src="${base}/static/layui/layui.js"></script>
<script type="text/javascript" src="${base}/static/js/cache.js"></script>
<script type="text/javascript">

    //处理页面超时跳转到登录页面被框架页面嵌套的问题
    if (window.top.location.href != location.href) {
        window.top.location.href = location.href;
    }


    layui.use(['form','layer','jquery'],function(){
        var form = layui.form,
                layer = parent.layer === undefined ? layui.layer : top.layer
        $ = layui.jquery;

        // $(".loginBody .seraph").click(function(){
        //     layer.msg("这只是做个样式，至于功能，你见过哪个后台能这样登录的？还是老老实实的找管理员去注册吧",{
        //         time:5000
        //     });
        // })

        //切换验证码
        $("#mycode").on('click',function(){
            var t = Math.random();
            $("#mycode")[0].src="${base}/genCaptcha?t= "+t;
        });

        form.on('submit(login)', function(data) {
            var loadIndex = layer.load(2, {
                shade: [0.3, '#333']
            });
            if($('form').find('input[type="checkbox"]')[0].checked){
                data.field.rememberMe = true;
            }else{
                data.field.rememberMe = false;
            }
            $.post(data.form.action, data.field, function(res) {
                layer.close(loadIndex);
                if(res.success){
                    location.href="${base}/"+res.data.url;
                }else{
                    layer.msg(res.message);
                    $("#mycode").click();
                }
            });
            return false;
        });

        //表单输入效果
        $(".loginBody .input-item").click(function(e){
            e.stopPropagation();
            $(this).addClass("layui-input-focus").find(".layui-input").focus();
        })
        $(".loginBody .layui-form-item .layui-input").focus(function(){
            $(this).parent().addClass("layui-input-focus");
        })
        $(".loginBody .layui-form-item .layui-input").blur(function(){
            $(this).parent().removeClass("layui-input-focus");
            if($(this).val() != ''){
                $(this).parent().addClass("layui-input-active");
            }else{
                $(this).parent().removeClass("layui-input-active");
            }
        })
    })

</script>
</body>
</html>