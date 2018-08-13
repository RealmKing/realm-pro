<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <#include "${base}/projixie/common/header.ftl">
</head>
<body>

<#--头部导航----start-->

<#include "${base}/projixie/common/nav.ftl">

<#--头部导航----end-->

<#--内容--------start---->

<div class="neibanner" style="background:url(${base}/static/projixie/images/banner_contact.jpg) no-repeat 50%; background-size: cover;"></div>
<div class="neipagename">
    <div class="pagename_en">
        contact US
    </div>
    <br />
    <div class="pagename_ch">
        <div>
            联系我们
        </div>
    </div>
</div>
<div class="neimenu">
    <div>
        <a href="#" class="on">联系我们</a>
    </div>
</div>
<div class="con1">
    <div class="con1_nei">
        <div class="con1_xun">
            <div class="con1_xun_img">
                <img src="${base}/static/projixie/images/bg15.png" />
            </div>
            <div class="con1_xun_text">
                <div class="con1_xun_title">
                    公司地址
                </div>
                <div class="con1_xun_zi">
                    ${site.address}
                </div>
            </div>
        </div>
        <div class="con1_xun">
            <div class="con1_xun_img">
                <img src="${base}/static/projixie/images/bg16.png" />
            </div>
            <div class="con1_xun_text">
                <div class="con1_xun_title">
                    联系方式
                </div>
                <div class="con1_xun_zi">
                    电话： ${site.phone}
                </div>
                <div class="con1_xun_zi">
                    邮箱： ${site.email}
                </div>
            </div>
        </div>
        <div class="con1_xun">
            <div class="con1_xun_img">
                <img src="${base}/static/projixie/images/bg17.png" />
            </div>
            <div class="con1_xun_text">
                <div class="con1_xun_zi">
                    <img src="${base}/static/projixie/images/erweima.jpg" />
                </div>
            </div>
        </div>
    </div>
</div>
<div class="message">
    <form action="/plus/diy.php" enctype="multipart/form-data" method="post" class="mess_form">
        <input type="hidden" name="action" value="post" />
        <input type="hidden" name="diyid" value="1" />
        <input type="hidden" name="do" value="2" />
        <div class="fl">
            <input type="text" name="xm" id="xm" placeholder="你的姓名" />
            <input type="text" name="yx" id="yx" placeholder="联系邮箱" />
            <input type="text" name="sj" id="sj" placeholder="联系电话" />
        </div>
        <div class="fr">
            <textarea name="nra" id="nra" placeholder="填写留言"></textarea>
            <input type="hidden" name="dede_fields" value="xm,text;yx,text;nra,multitext;sj,text" />
            <input type="hidden" name="dede_fieldshash" value="5b14cf258b40a319a7de3b8aadf7d6da" />
            <input type="submit" name="submit" class="tj" value="提交留言" />
        </div>
    </form>
</div>

<#-- 内容 -------end---->

<!-- 底部 -------start-->

<#include "${base}/projixie/common/foot.ftl">

<!-- 底部 -------end---->

<script>

    $(document).ready(function(e) {

        $('.tj').click(function(){

            if($('#xm').val()==''){alert('请输入姓名！');return false;}

            if($('#yx').val()==''){alert('请输入邮箱！');return false;}

            if($('#sj').val()==''){alert('请输入手机！');return false;}

            if($('#nra').val()==''){alert('请输入内容！');return false;}

        })

    });


</script>

</body>
</html>