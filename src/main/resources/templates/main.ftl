<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>${site.name}</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${base}/static/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="//at.alicdn.com/t/font_tnyc012u2rlwstt9.css" media="all" />
    <link rel="stylesheet" href="${base}/static/css/main.css" media="all" />
    <link rel="stylesheet" href="${base}/static/css/index.css" media="all" />
    <link rel="stylesheet" href="${base}/static/css/public.css" media="all" />
</head>
<body class="childrenBody">
<blockquote class="layui-elem-quote layui-bg-green">
    <div id="nowTime"></div>
</blockquote>
<div class="panel_box row">
    <#if (userMenu?size>0 )>
        <#list userMenu as items>
            <div class="panel col <#if (!items_has_next)>max_panel</#if> ">
                <a href="javascript:" data-url="${base}${items.href}">
                    <div class="panel_icon" <#if (items.bgColor != "")>style="background-color: ${items.bgColor}"<#else>style="background-color: #54ade8"</#if>>
                        <i class="layui-icon" data-icon="${items.icon}">${items.icon}</i>
                    </div>
                    <div class="panel_word newMessage">
                        <span>${items.dataCount}</span>
                        <cite>${items.name}</cite>
                    </div>
                </a>
            </div>
        </#list>
    </#if>
</div>
<div class="row">
    <div class="sysNotice col">
        <blockquote class="layui-elem-quote title">系统基本参数</blockquote>
        <table class="layui-table">
            <colgroup>
                <col width="150">
                <col>
            </colgroup>
            <tbody>
            <tr>
                <td>网站名称</td>
                <td class="version">${site.name}</td>
            </tr>
            <tr>
                <td>开发作者</td>
                <td class="author">${site.author}</td>
            </tr>
            <tr>
                <td>当前版本</td>
                <td class="homePage">${site.version}</td>
            </tr>
            <tr>
                <td>服务器环境</td>
                <td class="server">${site.server}</td>
            </tr>
            <tr>
                <td>数据库版本</td>
                <td class="dataBase">${site.database}</td>
            </tr>
            <tr>
                <td>最大上传限制</td>
                <td class="maxUpload">${site.maxUpload}</td>
            </tr>
            <tr>
                <td>当前用户角色</td>
                <td class="userRights">
                    <#if (currentUser.roleLists?? && currentUser.roleLists?size>0)>
                        <#list currentUser.roleLists as items>
                            <span class="layui-badge layui-bg-green">${items.name}</span>
                        </#list>
                    </#if>
                </td>
            </tr>
            </tbody>
        </table>
        <blockquote class="layui-elem-quote title">最新文章<i class="iconfont icon-new1"></i></blockquote>
        <table class="layui-table" lay-skin="line">
            <colgroup>
                <col>
                <col width="110">
            </colgroup>
            <tbody class="hot_news">
                <@myindex limit = "5">
                    <#if (result?size>0)>
                        <#list result as items>
                            <tr><td align="left">${items.title}</td><td>${items.publistTime?string("yyyy-MM-dd")}</td></tr>
                        </#list>
                    </#if>
                </@myindex>
            <#--<@ar channelId = "5">-->
            <#--<#assign articleList = result["articleList"]>-->
            <#--<#if (articleList?size>0)>-->
            <#--<#list articleList as items>-->
            <#--<tr><td align="left">${items.title}</td><td>${items.publistTime?string("yyyy-MM-dd")}</td></tr>-->
            <#--</#list>-->
            <#--</#if>-->
            <#--</@ar>-->
            </tbody>
        </table>
    </div>
    <div class="sysNotice col">
    <blockquote class="layui-elem-quote title">用户访问量</blockquote>
    <div id="container" style="height: 500px"></div>
    <script type="text/javascript" src="${base}/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="${base}/static/js/echarts.min.js"></script>
    <script type="text/javascript">
        var dom = document.getElementById("container");
        var myChart = echarts.init(dom);
        var dateArray = [];
        function getDay(day){
            var today = new Date();

            var targetday_milliseconds=today.getTime() + 1000*60*60*24*day;

            today.setTime(targetday_milliseconds); //注意，这行是关键代码

            var tYear = today.getFullYear();
            var tMonth = today.getMonth();
            var tDate = today.getDate();
            tMonth = doHandleMonth(tMonth + 1);
            tDate = doHandleMonth(tDate);
            return tYear+"-"+tMonth+"-"+tDate;
        }
        function doHandleMonth(month){
            var m = month;
            if(month.toString().length === 1){
                m = "0" + month;
            }
            return m;
        }
        for(i=-14; i<=0;i++){
            // console.log(getDay(i));
            dateArray.push(getDay(i));
        }
        $.get('${base}/admin/system/log/pvs').done(function (res) {
            myChart.setOption({
                tooltip : {
                    show: true,
                    trigger: 'axis',
                    axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                        type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                    }
                },
                xAxis: {
                    type: 'category',
                    data: dateArray
                },
                yAxis: {
                    type: 'value'
                },
                series: [{
                    data: res.data,
                    type: 'bar',
                    name: '日流量',
                    // markPoint : {
                    //     data : [
                    //         {type : 'max', name: '最大值'},
                    //         {type : 'min', name: '最小值'}
                    //     ]
                    // },
                    itemStyle:{
                        normal:{
                            color:'#6d9096'
                        }
                    },
                }]
            });
        });
    </script>
    </div>

</div>
<#--<div class="row">-->
    <#--&lt;#&ndash;<div class="sysNotice col">&ndash;&gt;-->
        <#--&lt;#&ndash;<blockquote class="layui-elem-quote title">更新日志</blockquote>&ndash;&gt;-->
        <#--&lt;#&ndash;<div class="layui-elem-quote layui-quote-nm">&ndash;&gt;-->
            <#--&lt;#&ndash;<@ar channelid="7">&ndash;&gt;-->
                <#--&lt;#&ndash;<#if (result?size>0)>&ndash;&gt;-->
                    <#--&lt;#&ndash;<#list result as item>&ndash;&gt;-->
                        <#--&lt;#&ndash;${item.content}&ndash;&gt;-->
                    <#--&lt;#&ndash;</#list>&ndash;&gt;-->
                <#--&lt;#&ndash;</#if>&ndash;&gt;-->
            <#--&lt;#&ndash;</@ar>&ndash;&gt;-->
        <#--&lt;#&ndash;</div>&ndash;&gt;-->
    <#--&lt;#&ndash;</div>&ndash;&gt;-->

<#--</div>-->

<script type="text/javascript" src="${base}/static/layui/layui.js"></script>
<script>

    //获取系统时间
    var newDate = '';
    getLangDate();
    //值小于10时，在前面补0
    function dateFilter(date){
        if(date < 10){return "0"+date;}
        return date;
    }
    function getLangDate(){
        var dateObj = new Date(); //表示当前系统时间的Date对象
        var year = dateObj.getFullYear(); //当前系统时间的完整年份值
        var month = dateObj.getMonth()+1; //当前系统时间的月份值
        var date = dateObj.getDate(); //当前系统时间的月份中的日
        var day = dateObj.getDay(); //当前系统时间中的星期值
        var weeks = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"];
        var week = weeks[day]; //根据星期值，从数组中获取对应的星期字符串
        var hour = dateObj.getHours(); //当前系统时间的小时值
        var minute = dateObj.getMinutes(); //当前系统时间的分钟值
        var second = dateObj.getSeconds(); //当前系统时间的秒钟值
        var timeValue = "" +((hour >= 12) ? (hour >= 18) ? "晚上" : "下午" : "上午" ); //当前时间属于上午、晚上还是下午
        newDate = dateFilter(year)+"年"+dateFilter(month)+"月"+dateFilter(date)+"日 "+" "+dateFilter(hour)+":"+dateFilter(minute)+":"+dateFilter(second);
        document.getElementById("nowTime").innerHTML = "亲爱的${currentUser.nickName}，"+timeValue+"好！ 欢迎使用${site.name}。当前时间为： "+newDate+"　"+week;
        setTimeout("getLangDate()",1000);
    }

    layui.use(['layer','jquery','form'],function(){
        var layer = layui.layer,
                $ = layui.jquery,
                form = layui.form;

        $(".panel a").on("click",function(){
            window.parent.addTab($(this));
        });
    });
</script>
</body>
</html>