var $t = jQuery.noConflict();
/*
侧边栏
77 review
*/
var topFun = function () {
    var $$ = topFun.prototype;

    var stag = true;
    var $content = $t(".content");
    var $obj = $t('.sd_quick');
    //自适应分辨率
    $$.autoClient = function (x, y) {
        if ($content.length == 0)
            return;
        l = $content.offset().left;
        w = $content.width();
        s = document.body.parentNode.clientWidth;
        z = document.documentElement.clientHeight;
        h = document.body.clientHeight;
        if (l + w + 4 * x + 70 > s) {
            if (h>z)
                $obj.css('left', (s - 80) + 'px');
            else
                $obj.css('left', (s - 95) + 'px');
        } else {
            $obj.css('left', (l + w + x) + 'px');
        }
        $obj.css('bottom', y + 'px');
    }
    //回顶
    $$.goTop = function () {
        if (stag)
            $t('html,body').stop().animate({ scrollTop: '0' }, 200, function () { stag = true; });
        stag = false;
    }
    //展开、收起
    $$.slideToggle = function () {
        $obj.find(".help").parent().slideToggle(50, function () {
            $obj.find(".feedback").parent().slideToggle(50, function () {
                if ($obj.find(".slideToggle").hasClass("_slideToggle")) {
                    $obj.find(".slideToggle").removeClass("_slideToggle").html("收起");
                } else {
                    $obj.find(".slideToggle").addClass("_slideToggle").html("展开");
                }
            });
        });
    }
    //初始化
    $$.Init = function () {
        try {
            $$.autoClient(10, 150); //.sd_quick的div距浏览器底部和页面内容区域右侧的距离
            //$$.b();
            $obj.find('.top').click(function () {
                $$.goTop();
            });
            $obj.find(".slideToggle").click(function () {
                $$.slideToggle();
            });
            $t(window).resize(function () {
                $$.autoClient(10, 150); //.sd_quick的div距浏览器底部和页面内容区域右侧的距离
            });
        } catch (e) {
            //**
        }
    }
}
$t(function () {
    new topFun().Init();
});