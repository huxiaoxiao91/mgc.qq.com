/**
 * @Description:   梦工厂web-基础库-tips
 *
 * @author         Xu XiaoJing
 * @version        V1.0
 * @Date           2015/11/25
 * @Company        horizon3d
 */
define(['mgc_popmanager'], function(mgc_popmanager) {
    var mgc_tips = {
        missionTips: function(val, val2, el, mainType, subType) {
            try {
                var _e = el[0];
                var susTips = $(".susw_tips");
                var t = _e.offsetTop + 91;
                var l = _e.offsetLeft + 100;
                var W = 0;
                if (el.parent().attr('data') > 5) {
                    l = _e.offsetLeft + 100 - 490;
                } else if (el.parent().attr('data') > 10) {
                    l = _e.offsetLeft + 100 - 980;
                }
                if (val == '经验') {
                    W = 24;
                } else if (val != undefined && val.indexOf("贵族身份") >= 0) {
                    W = 75;
                } else if (val != undefined && val.indexOf("飞屏喇叭") >= 0) {
                    W = 160;
                } else {
                    W = 180;
                }
                var cssObj;
                if (val != '经验' && tips == "") {
                    cssObj = {
                        "top": t,
                        "left": l,
                        "width": "auto"
                    };
                } else {
                    cssObj = {
                        "top": t,
                        "left": l,
                        "width": W + "px"
                    };
                }
                val = val + '</br>' + val2;
                var tips = $(".susw_tips");
                var pos = null;
                mgc_tips.showTips(val, el, tips, pos, cssObj, mainType, subType);
            } catch (e) {
                console.log(e);
            }
        },
        commonTips: function(val, el, mainType, subType) {
            var tips = $(".common_tips");
            var pos = {
                y: -15,
                x: 20
            };
            mgc_tips.showTips(val, el, tips, pos, null, mainType, subType);
        },
        cssCommonTips: function(val, el, cssObj, mainType, subType) {
            var tips = $(".common_tips");
            var pos = {
                y: -15,
                x: 20
            };
            mgc_tips.showTips(val, el, tips, pos, cssObj, mainType, subType);
        },
        cssFixPosTips: function(val, el, pos, cssObj, mainType, subType) {
            var tips = $(".common_tips");
            mgc_tips.fixTips(val, el, tips, pos, cssObj, mainType, subType);
        },
        showTips: function(val, el, tips, pos, cssObj, mainType, subType) {
            if (!val || val == '' || val == '无') {
                return false;
            }
            if (mainType == undefined) {
                mainType = 1;
            }
            if (subType == undefined) {
                subType = 3;
            }
            el.off('mouseover mouseout').on({
                mouseover: function(e) {
                    tips.css({
                        "width": "auto"
                    });
                    if (pos) {
                        var t = (e.pageY == undefined ? e.clientY : e.pageY) + pos.y;
                        var l = (e.pageX == undefined ? e.clientX : e.pageX) + pos.x;
                        tips.css({
                            "top": t,
                            "left": l
                        });
                    }
                    if (cssObj) {
                        tips.css(cssObj);
                    }
                    tips.html(val);
                    mgc_popmanager.layerControlShow(tips, mainType, subType);
                },
                mouseout: function() {
                    mgc_popmanager.layerControlHide(tips, mainType, subType);
                }
            });
        },
        fixTips: function(val, el, tips, pos, cssObj, mainType, subType) {
            if (!val || val == '' || val == '无') {
                return false;
            }
            if (mainType == undefined) {
                mainType = 1;
            }
            if (subType == undefined) {
                subType = 3;
            }
            el.off('mouseover mouseout').on({
                mouseover: function(e) {
                    tips.css({
                        "width": "auto"
                    });
                    if (pos) {
                        var t = el.offset().top + pos.y;
                        var l = el.offset().left + pos.x;
                        tips.css({
                            "top": t,
                            "left": l
                        });
                    }
                    if (cssObj) {
                        tips.css(cssObj);
                    }
                    tips.html(val);
                    mgc_popmanager.layerControlShow(tips, mainType, subType);
                },
                mouseout: function() {
                    mgc_popmanager.layerControlHide(tips, mainType, subType);
                }
            });
        },
        susTipsHtml: function(e, n, val) {
            if ((n == 1 && val == '') || (n == 1 && val == '无')) {
                return false;
            }
            var susTips = $j(".sus_tips"), t = (e.pageY == undefined ? e.clientY : e.pageY) - 15, l = (e.pageX == undefined ? e.clientX : e.pageX) + 20;
            susTips.css({
                "top": t,
                "left": l
            });
            if (n == 1) {
                if (val != '') {
                    susTips.html(val);
                }
                window.mgc.popmanager.layerControlShow(susTips, 1, 3);
            } else {
                window.mgc.popmanager.layerControlHide(susTips, 1, 3);
            }
        }, susTipsHtmlPop: function(e, n, val) {
            if ((n == 1 && val == '') || (n == 1 && val == '无')) {
                return false;
            }
            var susTips = $j(".sus_badge_tips"), t = (e.pageY == undefined ? e.clientY : e.pageY) - 15, l = (e.pageX == undefined ? e.clientX : e.pageX) + 20;
            susTips.css({ "top": t, "left": l, "text-align": "left" });
            if (n == 1) {
                if (val != '') {
                    susTips.html(val);
                }
                window.mgc.popmanager.layerControlShow(susTips, 4, 3);
                $j(window).scroll(function(e) {
                    window.mgc.popmanager.layerControlHide(susTips, 4, 3);
                });
            } else {
                //susTips.hide();
                window.mgc.popmanager.layerControlHide(susTips, 4, 3);
            }
        },
        susTipsBadge: function(e, n, val) {
            if ((n == 1 && val == '') || (n == 1 && val == '无')) {
                return false;
            }
            var susTips = $j(".sus_badge_tips"), t = (e.pageY == undefined ? e.clientY : e.pageY) - 20, l = (e.pageX == undefined ? e.clientX : e.pageX) + 33;
            susTips.css({ "top": t, "left": l, "text-align": "left" });
            if (n == 1) {
                if (val != '') {
                    susTips.html(val);
                }
                window.mgc.popmanager.layerControlShow(susTips, 4, 3);
                $j(window).scroll(function(e) {
                    window.mgc.popmanager.layerControlHide(susTips, 4, 3);
                });
            } else {
                window.mgc.popmanager.layerControlHide(susTips, 4, 3);
            }
        },
        //临时
        suswTips4: function(e, n, val, tips, panl) {
            if (n == 1 && val == '') {
                return false;
            }
            var susTips = $("." + panl + "_tips"), t, l;
            if (panl == "sign") {
                t = (e.pageY == undefined ? e.clientY : e.pageY) - $(document).scrollTop() - $("#pop_" + panl)[0].offsetTop - 15;
                l = (e.pageX == undefined ? e.clientX : e.pageX) - $(document).scrollLeft() - $("#pop_" + panl)[0].offsetLeft + 23;
                if ($("#pop_" + panl).attr("style").indexOf("absolute") >= 0) {
                    t += window.scrollY || window.screenTop;
                }
            } else {
                t = (e.pageY == undefined ? e.clientY : e.pageY) - $("#pop_" + panl)[0].offsetTop - 25;
                l = (e.pageX == undefined ? e.clientX : e.pageX) - $(".content")[0].offsetLeft + 20;
                var content_left = $("#content")[0].offsetLeft - $("#header").width();
                if ($(".side-left").attr("side_state") == "0") {
                    l += 250 + content_left;
                } else if ($(".side-left").attr("side_state") == "1") {
                    l -= 10 - content_left;
                }
            }
            if (val == '经验') {
                W = 24;
            } else if (val != undefined && val.indexOf("贵族身份") >= 0) {
                W = 75;
            } else if (val != undefined && val.indexOf("飞屏喇叭") >= 0) {
                W = 160;
            } else {
                W = 180;
            }
            if (panl == "punch_card") {
                W = 0;
            }
            if ((val != '经验' || val.indexOf("贵族身份") == -1 || val.indexOf("飞屏喇叭") == -1) && tips == "") {
                susTips.css({ "top": t, "left": l, "width": "auto", "white-space": "nowrap" });
            } else {
                susTips.css({ "top": t, "left": l, "width": W == 0 ? "auto" : W + "px", "white-space": "inherit" });
            }
            if (n == 1) {
                if (val != '') {
                    if (panl == "punch_card") {
                        susTips.html(tips);
                    } else {
                        susTips.html(val + "</br>" + tips);
                    }
                }
                window.mgc.popmanager.layerControlShow(susTips, 5, 3);

                //防止出浏览器
                if (panl == "sign" && (susTips.offset().left + susTips.width()) > $(window).width()) {
                    susTips.offset({ left: $(window).width() - susTips.width() - 30, top: susTips.offset().top + 20 });
                }

            } else {
                window.mgc.popmanager.layerControlHide(susTips, 5, 3);
            }
        },
        suswTips2: function(e, n, val, tips) {
            if (n == 1 && val == '') {
                return false;
            }
            var _e = e.target == undefined ? e.toElement : e.target;
            var susTips = $(".susw_tips");
            var t = _e.offsetTop + 68;
            var l = _e.offsetLeft + 68;
            var W = 0;
            var indexNum = $(_e).parent().parent().attr('data');
            var indexImg = Math.floor(l / 381)
            var ll = l;
            l = l % 392;
            if (indexImg == 1 && ll > 392) {
                l = l + 12;
            } else if (indexImg > 1 && ll > indexImg * 381) {
                l = l + indexImg * 12;
            }

            if ($(_e).hasClass("h88")) {
                t = _e.offsetTop + 57;
            }

            if (val == '经验') {
                W = 24;
            } else if (val != undefined && val.indexOf("贵族身份") >= 0) {
                W = 75;
            } else if (val != undefined && val.indexOf("飞屏喇叭") >= 0) {
                W = 160;
            } else {
                W = 180;
            }
            if ((val != '经验' || val.indexOf("贵族身份") == -1 || val.indexOf("飞屏喇叭") == -1) && tips == "") {
                susTips.css({ "top": t, "left": l, "width": "auto", "white-space": "nowrap" });
            } else {
                susTips.css({ "top": t, "left": l, "width": W + "px", "white-space": "inherit" });
            }
            if (n == 1) {
                if (val != '' && tips != '') {
                    susTips.html(val + '</br>' + tips);
                } else if (val != '' && tips == '') {
                    susTips.html(val);
                }
                window.mgc.popmanager.layerControlShow(susTips, 5, 3);
            } else {
                window.mgc.popmanager.layerControlHide(susTips, 5, 3);
            }
        }
    };
    if (!window.mgc) {
        window.mgc = {};
    }
    window.mgc_tips = mgc_tips;
    return mgc_tips;
});
