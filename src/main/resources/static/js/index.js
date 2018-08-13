var $, tab, skyconsWeather, _$, _element;
layui.config({
    base: baseUrl + '/static/js/' //假设这是你存放拓展模块的根目录
}).extend({
    bodyTab: 'bodyTab' // {/}的意思即代表采用自有路径，即不跟随 base 路径
});

layui.use(['bodyTab', 'form', 'element', 'layer', 'jquery'], function () {
    var layer = layui.layer,
        $ = layui.jquery,
        form = layui.form,
        element = layui.element;

    _$ = $;
    _element = element;
    tab = layui.bodyTab({
        openTabNum: "50",  //最大可打开窗口数量
        url: baseUrl + "/admin/system/user/getUserMenu" //获取菜单json地址
    });
    // console.log(tab);

    //隐藏左侧导航
    $(".hideMenu").click(function () {
        $(".layui-layout-admin").toggleClass("showMenu");
        //渲染顶部窗口
        tab.tabMove();
    });

    //初始化顶部菜单
    $.get(tab.tabConfig.url, {parentId: null}, function (data) {
        $.each(data, function (index, item) {
            if (index == 0) {
                $(".topLevelMenus").html('').append('<li class="layui-nav-item layui-this" data-menu="' + item.id + '">\n' +
                    '                    <a href="javascript:;"><i class="layui-icon" data-icon="' + item.icon + '">' + item.icon + '</i><cite>' + item.title + '</cite></a>\n' +
                    '                </li>');


                $(".mobileTopLevelMenus dl").html('').append('<dd class="layui-this" data-menu="' + item.id + '"><a href="javascript:;"><i class="layui-icon" data-icon="' + item.icon + '">' + item.icon + '</i><cite>' + item.title + '</cite></a></dd>');
                tab.render(item.id);
            } else {
                $(".topLevelMenus").append('<li class="layui-nav-item " data-menu="' + item.id + '">\n' +
                    '                    <a href="javascript:;"><i class="layui-icon" data-icon="' + item.icon + '">' + item.icon + '</i><cite>' + item.title + '</cite></a>\n' +
                    '                </li>');


                $(".mobileTopLevelMenus dl").append('<dd  data-menu="' + item.id + '"><a href="javascript:;"><i class="layui-icon" data-icon="' + item.icon + '">' + item.icon + '</i><cite>' + item.title + '</cite></a></dd>');
            }
        });


        //页面加载时判断左侧菜单是否显示
        //通过顶部菜单获取左侧菜单
        $(".topLevelMenus li,.mobileTopLevelMenus dd").click(function () {
            if ($(this).parents(".mobileTopLevelMenus").length != "0") {
                $(".topLevelMenus li").eq($(this).index()).addClass("layui-this").siblings().removeClass("layui-this");
                setTimeout(function () {
                    treeMobile.click();
                }, 100);

            } else {
                $(".mobileTopLevelMenus dd").eq($(this).index()).addClass("layui-this").siblings().removeClass("layui-this");

                $(".layui-layout-admin").toggleClass("showMenu");
            }
            $(".layui-layout-admin").removeClass("showMenu");

            // getData($(this).data("menu"));
            //重新渲染左侧菜单
            tab.render($(this).data("menu"));


            //渲染顶部窗口
            tab.tabMove();


        })

    })


    //手机设备的简单适配
    var treeMobile = $('.site-tree-mobile'),
        shadeMobile = $('.site-mobile-shade');

    treeMobile.on('click', function () {
        $('body').addClass('site-mobile');
    });

    shadeMobile.on('click', function () {
        $('body').removeClass('site-mobile');
    });

    // 添加新窗口
    $("body").on("click", ".layui-nav .layui-nav-item a", function () {
        //如果不存在子级
        if ($(this).siblings().length == 0) {
            addTab($(this));
            $('body').removeClass('site-mobile');  //移动端点击菜单关闭菜单层
        }
        $(this).parent("li").siblings().removeClass("layui-nav-itemed");
    });
    //清除缓存
    $(".clearCache").click(function () {
        window.sessionStorage.clear();
        window.localStorage.clear();
        var index = layer.msg('清除缓存中，请稍候', {icon: 16, time: false, shade: 0.8});
        setTimeout(function () {
            layer.close(index);
            layer.msg("缓存清除成功！");
        }, 1000);
    })


    //刷新后还原打开的窗口
    if (window.sessionStorage.getItem("menu") != null) {
        menu = JSON.parse(window.sessionStorage.getItem("menu"));
        curmenu = window.sessionStorage.getItem("curmenu");
        var openTitle = '';
        for (var i = 0; i < menu.length; i++) {
            openTitle = '';
            if (menu[i].icon) {
                if (menu[i].icon.split("-")[0] == 'icon') {
                    openTitle += '<i class="iconfont ' + menu[i].icon + '"></i>';
                } else {
                    openTitle += '<i class="layui-icon">' + menu[i].icon + '</i>';
                }
            }
            openTitle += '<cite>' + menu[i].title + '</cite>';
            openTitle += '<i class="layui-icon layui-unselect layui-tab-close" data-id="' + menu[i].layId + '">&#x1006;</i>';
            element.tabAdd("bodyTab", {
                title: openTitle,
                content: "<iframe src='" + menu[i].href + "' data-id='" + menu[i].layId + "' ></iframe>",
                id: menu[i].layId
            });
            //定位到刷新前的窗口
            if (curmenu != "undefined") {
                if (curmenu == '' || curmenu == "null") {  //定位到后台首页
                    element.tabChange("bodyTab", '');
                } else if (JSON.parse(curmenu).title == menu[i].title) {  //定位到刷新前的页面
                    element.tabChange("bodyTab", menu[i].layId);
                }
            } else {
                element.tabChange("bodyTab", menu[menu.length - 1].layId);
            }
        }
        //渲染顶部窗口
        tab.tabMove();
    }

    //刷新当前
    $(".refresh").on("click", function () {  //此处添加禁止连续点击刷新一是为了降低服务器压力，另外一个就是为了防止超快点击造成chrome本身的一些js文件的报错(不过貌似这个问题还是存在，不过概率小了很多)
        if ($(this).hasClass("refreshThis")) {
            $(this).removeClass("refreshThis");
            $(".clildFrame .layui-tab-item.layui-show").find("iframe")[0].contentWindow.location.reload(true);
            setTimeout(function () {
                $(".refresh").addClass("refreshThis");
            }, 2000)
        } else {
            layer.msg("您点击的速度超过了服务器的响应速度，还是等两秒再刷新吧！");
        }
    });

    //关闭其他
    $(".closePageOther").on("click", function () {
        if ($("#top_tabs li").length > 2 && $("#top_tabs li.layui-this cite").text() != "后台首页") {
            var menu = JSON.parse(window.sessionStorage.getItem("menu"));
            $("#top_tabs li").each(function () {
                if ($(this).attr("lay-id") != '' && !$(this).hasClass("layui-this")) {
                    element.tabDelete("bodyTab", $(this).attr("lay-id")).init();
                    //此处将当前窗口重新获取放入session，避免一个个删除来回循环造成的不必要工作量
                    for (var i = 0; i < menu.length; i++) {
                        if ($("#top_tabs li.layui-this cite").text() == menu[i].title) {
                            menu.splice(0, menu.length, menu[i]);
                            window.sessionStorage.setItem("menu", JSON.stringify(menu));
                        }
                    }
                }
            })
        } else if ($("#top_tabs li.layui-this cite").text() == "后台首页" && $("#top_tabs li").length > 1) {
            $("#top_tabs li").each(function () {
                if ($(this).attr("lay-id") != '' && !$(this).hasClass("layui-this")) {
                    element.tabDelete("bodyTab", $(this).attr("lay-id")).init();
                    window.sessionStorage.removeItem("menu");
                    menu = [];
                    window.sessionStorage.removeItem("curmenu");
                }
            })
        } else {
            layer.msg("没有可以关闭的窗口了@_@");
        }
        //渲染顶部窗口
        tab.tabMove();
    });
    //关闭全部
    $(".closePageAll").on("click", function () {
        if ($("#top_tabs li").length > 1) {
            $("#top_tabs li").each(function () {
                if ($(this).attr("lay-id") != '') {
                    element.tabDelete("bodyTab", $(this).attr("lay-id")).init();
                    window.sessionStorage.removeItem("menu");
                    menu = [];
                    window.sessionStorage.removeItem("curmenu");
                }
            })
        } else {
            layer.msg("没有可以关闭的窗口了@_@");
        }
        //渲染顶部窗口
        tab.tabMove();
    })
});

//打开新窗口
function addTab(_this) {
    tab.tabAdd(_this);
}

//打开我的编辑表单新窗口
function myaddTab(_this) {
    var name = _this.find("cite").text();
    if (_$("#top_tabs li").length > 1) {
        _$("#top_tabs li").each(function () {
            if (_$(this).find("cite").text() == name) {
                _element.tabDelete("bodyTab", _$(this).attr("lay-id")).init();
                window.sessionStorage.removeItem("curmenu");
            }
        })
    }
    tab.tabAdd(_this);
}



