/**
 * Created by Zhangqing on 2015/9/28.
 * 定义一些不依赖于其他梦工厂模块即可完成的常用功能。
 */
define(['jquery', 'mgc_consts', 'mgc_config', 'eas', 'tgadshow'], function(jquery, consts, config, eas, tgadshow) {
    var defCard = true;
    if (MgcAPI.SNSBrowser.IsQQGame() || MgcAPI.SNSBrowser.IsX52()) {
        //禁止右键
        $(document).bind("contextmenu", function() { return false; });
        //禁止选中
        //$(document).bind("selectstart", function() { return false; });
    }
    if (MgcAPI.SNSBrowser.IsQQGame()) {
        //监听F5事件，改变QGame大厅原有F5回首页状态
        $("body").keydown(function(e) {
            var ev = window.event || e;
            var code = ev.keyCode || ev.which;
            if (code == 116) {
                // 阻止默认的F5事件
                if (ev.preventDefault) {
                    ev.preventDefault();
                } else {
                    ev.keyCode = 0;
                    ev.returnValue = false;
                }
                window.location.reload();
            }
        });
    }
    var tools = {};
    //在一些老的浏览器上启用 HTML5 的支持
    (function() {
        if (!/*@cc_on!@*/0)
            return;
        var e = "abbr,article,aside,audio,bb,canvas,datagrid,datalist,details,dialog,eventsource,figure,footer,header,hgroup,mark,menu,meter,nav,output,progress,section,time,video".split(','), i = e.length; while (i--) { document.createElement(e[i]) }
    })();
    /**
    *   兼容ie9以下版本
    */
    if (!Array.prototype.indexOf) {
        Array.prototype.indexOf = function(elt /*, from*/) {
            var len = this.length >>> 0;
            var from = Number(arguments[1]) || 0;
            from = (from < 0)
            ? Math.ceil(from)
            : Math.floor(from);
            if (from < 0)
                from += len;
            for (; from < len; from++) {
                if (from in this &&
                this[from] === elt)
                    return from;
            }
            return -1;
        };
    }
    /**
     * 清除dom的容器
     */
    (function($) {
        removeElement = document.createElement('div');

        //兼容IE下的移除DOM方法
        $.fn.removeAll = function() {
            //移除所有子元素的事件
            this.find("*").each(function() {
                if ($._data(this, "events") != undefined) {
                    $(this).off();
                }
            });

            this.each(function() {
                $(this).off();
                $(this).remove();
                if (!+'\v1') {
                    removeElement.appendChild(this);
                    removeElement.innerHTML = "";
                }
            });
        };
    })($);

    /*
    * 检测浏览器是否支持H5
    */
    tools.checkH5 = function() {
        if (typeof (Worker) !== "undefined") {
            //alert("支持HTML5");
            return true;
        } else {
            //alert("不支持HTML5");
            return false;
        }
    };
    /** 
    * 判断浏览器是否支持某一个CSS3属性 
    * @param {String} 属性名称  animation-play-state
    * @return {Boolean} true/false 
    * @version 1.0 
    * alert(mgc.tools.supportCss3('animation-play-state').toString())
    */
    tools.supportCss3 = function(style) {
        var prefix = ['webkit', 'Moz', 'ms', 'o'],
        i,
        humpString = [],
        htmlStyle = document.documentElement.style,
        _toHumb = function(string) {
            return string.replace(/-(\w)/g, function($0, $1) {
                return $1.toUpperCase();
            });
        };
        for (i in prefix) {
            humpString.push(_toHumb(prefix[i] + '-' + style));
        }
        humpString.push(_toHumb(style));
        for (i in humpString) {
            if (humpString[i] in htmlStyle) {
                return true;
            }
        }
        return false;
    };
    /*
    * img load onerror event
    * param : o 当前img对象
    * param : n 重试次数
    */
    tools.imgLoadOnerror = function(o, n) {
        n || (n = 3);
        var _n = parseInt(o.getAttribute("n"), 10) || 0;
        if (_n < n) {
            o.src = o.src;
            o.setAttribute("n", _n + 1);
        }
    }
    /*浏览器类型及其版本*/
    tools.browser = (function() {
        var Sys = {};
        var ua = navigator.userAgent.toLowerCase();
        var s;
        (s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[0] :
        (s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[0] :
        (s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[0] :
        (s = ua.match(/qqbrowser\/([\d.]+)/)) ? Sys.qqbrowser = s[0] :
        (s = ua.match(/msie 6.0/)) ? Sys.ie6 = s[0] :
        (s = ua.match(/msie 7.0/)) ? Sys.ie7 = s[0] :
        (s = ua.match(/msie 8.0/)) ? Sys.ie8 = s[0] :
        (s = ua.match(/msie 9.0/)) ? Sys.ie9 = s[0] :
        (s = ua.match(/msie 10.0/)) ? Sys.ie10 = s[0] :
        (s = ua.match(/rv:11.0/)) ? Sys.ie11 = s[0] :
        //(s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[0] :
        (s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[0] : 0;
        return Sys;
    })();
    /*判断是否IE内核的国产浏览器下，as无法二次呼叫*/
    tools.checkIsIEloadSwfFailed = function() {
        return !!(tools.browser.ie6 || tools.browser.ie7 || tools.browser.ie8 || tools.browser.ie9 || tools.browser.ie10 || tools.browser.ie11 || tools.browser.qqbrowser);
    }
    /**
     * 设置或获取网页cookie
     * @param name      cookie名称
     * @param value     cookie值，不传的话则返回该cookie对应值
     * @param options   cookie的参数
     * @returns {*}
     */
    tools.cookie = function(name, value, options) {
        if (typeof value != consts.classtype.UNDEFINED) {
            options = options || {};
            if (value === null) {
                value = '';
                options.expires = -1;
            }
            var expires = '';
            if (options.expires && (typeof options.expires == consts.classtype.NUMBER || options.expires.toUTCString)) {
                var date;
                if (typeof options.expires == consts.classtype.NUMBER) {
                    date = new Date();
                    date.setTime(date.getTime() + (options.expires * 60 * 1000));
                } else {
                    date = options.expires;
                }
                expires = '; expires=' + date.toUTCString();
            }
            var path = options.path ? '; path=' + options.path : '';
            var domain = options.domain ? '; domain=' + options.domain : '';
            var secure = options.secure ? '; secure' : '';
            document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
        } else {
            var cookieValue = null;
            if (document.cookie && document.cookie != '') {
                var cookies = document.cookie.split(';');
                for (var i = 0; i < cookies.length; i++) {
                    var cookie = $.trim(cookies[i]);
                    if (cookie.substring(0, name.length + 1) == (name + '=')) {
                        cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                        break;
                    }
                }
            }
            return cookieValue;
        }
    };
    /** &特殊符号转换 **/
    //tools.specialCharacter = function(nickname){
    //    return nickname.replace(/&/g,'&amp');
    //};

    /** &特殊符号转换反义 **/
    //tools.specialCharacterAntisense = function(nickname){
    //    return nickname.replace(/&amp;/g,'&');
    //};

    /**
     * 获得页面中的swf元素
     * @param id     页面元素的唯一标识id
     * @returns {*}     返回该flash的object。
     */
    tools.getSWF = function(id) {
        if (navigator.appName.indexOf("Microsoft") != -1) {
            return window[id];
        } else {
            if (window.navigator.userAgent.indexOf("Firefox") != -1) {
                return document[id];
            } else {
                if (window.navigator.userAgent.indexOf("Chrome") != -1) {
                    return document[id];
                } else {
                    if (window.navigator.userAgent.indexOf("Safari") != -1) {
                        return document.getElementById(id);
                    } else {
                        if (window.navigator.userAgent.indexOf("Opera") != -1) {
                            return document[id];
                        }
                    }
                }
            }
            return document[id];
        }
    };
    /*
    * 初始化flash
    */
    tools.initSwf = function(id, tmpl_id, url, w, h) {
        if (!document.getElementById(id)) {
            console.log("找不到这个" + id);
            return;
        }
        var swfVersionStr1 = "11.1.0";
        var xiSwfUrlStr = "";
        var flashvars = {};
        var params = {};
        params.quality = "high";
        params.bgcolor = "#000";
        params.allowscriptaccess = "always";
        params.allowfullscreen = "true";
        params.allowFullScreenInteractive = "true";
        params.wmode = "transparent";
        var attributes = {};
        attributes.id = id;
        attributes.name = id;
        attributes.align = "middle";
        var swfurl = url + "?v=3_8_8_2016_15_4_final_3";
        if (tools.checkIsIEloadSwfFailed())
            swfurl += "&r=" + new Date();
        try {
            swfobject.embedSWF(swfurl, tmpl_id, w || "100%", h || "100%", swfVersionStr1, xiSwfUrlStr, flashvars, params, attributes);
        } catch (e) {
            console.log("swfobject.embedSWF error");
        }
    }
    /*
    *event基础操作
    */
    tools.offsetEvent = {
        /*
        * 获取事件  此处event为引类型，在传递过程中event改变,赋值变量随即改变，因此此处要复制一个event对象指向不同的地址。 兼容ie(ps:update时请与77说一下)
        */
        getEvent: function() {
            if (document.all) {
                return $.extend(true, {}, window.event);// 如果是ie
            }
            var func = this.getEvent.caller;
            while (func != null) {
                var arg0 = func.arguments[0];
                if (arg0) {
                    if ((arg0.constructor == Event || arg0.constructor == MouseEvent) || (typeof (arg0) == "object" && arg0.preventDefault && arg0.stopPropagation)) {
                        return $.extend(true, {}, arg0);
                    }
                }
                func = func.caller;
            }
            return null;
        },
        /*
        * 获取浏览器的宽度和高度
        */
        clientXY: function() {
            var X = document.documentElement.clientWidth || document.body.clientWidth || 0;
            var Y = document.documentElement.clientHeight || document.body.clientHeight || 0;
            return { X: X, Y: Y };
        },
        scrollXY: function() {
            var X = document.documentElement.scrollLeft || document.body.scrolLeft || 0;
            var Y = document.documentElement.scrollTop || document.body.scrollTop || 0;
            return { X: X, Y: Y };
        },
        /*
        * 获取鼠标的位置坐标
        */
        mouseXY: function() {
            var evt = this.getEvent();
            var X, Y;
            if (evt.pageX || evt.pageY) {
                X = evt.pageX;
                Y = evt.pageY;
            } else if (evt.clientX || evt.clientY) {
                X = evt.clientX;
                Y = evt.clientY;
            }
            return { X: X, Y: Y };
        },

        /*
        * 添加事件监听
        */
        addEvent: function(k, v) {
            var me = this;
            if (me.addEventListener)
                me.addEventListener(k, v, false);
            else if (me.attachEvent)
                me.attachEvent("on" + k, v);
            else
                me["on" + k] = v;
        },
        /*
        * 移出事件监听
        */
        removeEvent: function(k, v) {
            var me = this;
            if (me.removeEventListener)
                me.removeEventListener(k, v, false);
            else if (me.detachEvent)
                me.detachEvent("on" + k, v);
            else
                me["on" + k] = null;
        },
        /*
        * 阻止事件冒泡
        */
        stopEvent: function(evt) {
            evt = evt || window.event;
            evt.stopPropagation ? evt.stopPropagation() : evt.cancelBubble = true;
        }
    };
    //tips重新定位
    tools.comm_tips_position = function(obj, position, x, y, w) {
        x = x || 0;
        y = y || 0;
        var _x, _y;
        var mouseXY = tools.offsetEvent.mouseXY();
        var clientXY = tools.offsetEvent.clientXY();
        var scrollXY = tools.offsetEvent.scrollXY();
        var _w = obj.width();
        if (w && _w + obj.offset().left <= clientXY.X) {
            return;
        }
        _x = mouseXY.X + (w || 30);
        _y = mouseXY.Y - (obj.height() / 2);
        if (clientXY.X < _x + _w + 10) {
            if (position) {
                _x = x;
                _y = y;
            } else {
                if (tools.browser.ie6 || tools.browser.ie7 || tools.browser.ie8 || tools.browser.ie9) {
                    _x = clientXY.X - _w - 10 + x;
                    _y = mouseXY.Y + 20 + y + scrollXY.Y;
                } else {
                    _x = clientXY.X - _w - 10 + x;
                    _y = mouseXY.Y + 25 + y;
                }

            }
            obj.css({ "top": _y, "left": _x });
        }
    };
    /**
     * 定制Date的输出格式
     * @param format    字符串样式模板
     * @returns {*}
     */
    Date.prototype.format = function(format) {
        var o = {
            "M+": this.getMonth() + 1, //month
            "d+": this.getDate(), //day
            "h+": this.getHours(), //hour
            "m+": this.getMinutes(), //minute
            "s+": this.getSeconds(), //second
            "q+": Math.floor((this.getMonth() + 3) / 3), //quarter
            "S": this.getMilliseconds() //millisecond
        };
        if (/(y+)/.test(format))
            format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o) {
            if (new RegExp("(" + k + ")").test(format)) {
                format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
            }
        }
        return format;
    };
    /**
     * 复制到剪贴板功能
     * @returns {boolean}
     */
    tools.copyToClipBoard = function() {
        var txt = $(".ni_nick").text();
        if (window.clipboardData) {
            window.clipboardData.clearData();
            if (window.clipboardData.setData("Text", txt)) {
                alert("复制成功！");
            } else {
                alert("对不起，您的浏览器不能使用复制功能，请手动复制！");
            }
        } else if (navigator.userAgent.indexOf("Opera") != -1) {
            window.location = txt;
        } else if (window.netscape) {
            try {
                netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
            } catch (e) {
                alert("对不起，您的浏览器不能使用复制功能，请手动复制！");
            }
            var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);
            if (!clip) {
                return false;
            }
            var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);
            if (!trans) {
                return false;
            }
            trans.addDataFlavor('text/unicode');
            var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
            var copytext = txt;
            str.data = copytext;
            trans.setTransferData("text/unicode", str, copytext.length * 2);
            var clipid = Components.interfaces.nsIClipboard;
            clip.setData(trans, null, clipid.kGlobalClipboard);
            alert("复制成功！");
        } else {
            alert("对不起，您的浏览器不能使用复制功能，请手动复制！");
        }
    };
    /*
     * 轮播滚动
     */
    function mouseover(a, e, func) {
        e = e || window.event;
        var b = e.fromElement || e.relatedTarget;

        mouseoverAndOut(a, b, func);
    }
    function mouseout(a, e, func) {
        e = e || window.event;
        var b = e.toElement || e.relatedTarget;
        mouseoverAndOut(a, b, func);
    }
    function mouseoverOrOut(a, e, func) {
        e = e || window.event;
        var b;
        if (e.type == 'mouseover') {
            b = e.fromElement || e.relatedTarget;
        } else if (e.type == 'mouseout') {
            b = e.toElement || e.relatedTarget;
        }
        mouseoverAndOut(a, e, func);
    }
    function mouseoverAndOut(a, b, func) {
        if (document.all) {
            if (!(a.contains(b))) {
                func();
            }
        } else {
            var res = a.compareDocumentPosition(b);
            if (!(res == 20 || res == 0)) {
                func();
            }
        }
    }
    tools.carousel = function(id, maxItem, minItem, h, tim, dir) {
        var idItem = $("#" + id);
        var defaults = idItem.data("defaults");
        if (typeof defaults == 'undefined') {
            defaults = {
                maxClass: idItem.find("ul"),
                minClass: idItem.find("div"),
                maxCon: h,
                picTimer: null,
                num: 0,
                maxLen: idItem.find("ul li").length
            };
            idItem.data("defaults", defaults);
            clearInterval(defaults.picTimer);
            if (defaults.maxLen <= 1) {
                return;
            }
            //先做事件清除
            idItem.unbind("mouseover").unbind("mouseout").hover(function(e) {
                mouseover(this, e, function() {
                    console.log("轮播图: 父级 :mouseover");
                });
                console.log("轮播图:清除定时器");
                clearInterval(defaults.picTimer);
                e.stopPropagation();
            }, function(e) {
                console.log("轮播图:生成定时器");
                clearInterval(defaults.picTimer);
                if (defaults.maxLen <= 1) {
                    return;
                }
                //每次生成定时器之前，先清除定时器
                defaults.picTimer = setInterval(function() {
                    if (defaults.maxLen <= 1) {
                        clearInterval(defaults.picTimer);
                        return;
                    }
                    if (defaults.num >= defaults.maxLen) {
                        picMoveFirst();
                        defaults.num = 0;
                    } else {
                        picMoves(defaults.num);
                    }
                    defaults.num++;
                }, tim);
                e.stopPropagation();
            }).trigger("mouseout");
        }
        var _this_index = defaults.num - 1 >= 0 ? defaults.num - 1 : defaults.num;
        defaults.minClass.find("span").removeClass("current").eq(_this_index).addClass("current");
        defaults.maxLen = defaults.maxClass.find("li").length;
        defaults.minClass.find("span").each(function(index, o) {
            $(o).attr("i", index);
            console.log("轮播图:按钮事件绑定：" + $(o).attr("i"));
            $(o).unbind("mouseover").bind("mouseover", function(e) {
                mouseover(this, e, function() {
                    console.log("轮播图: 子集 :mouseover");
                });
                console.log("轮播图:按钮：" + $(this).attr("i"));
                picMoves($(this).attr("i"));
                defaults.num = $(this).attr("i");
                e.stopPropagation();
            });
        });
        function picMoves(index) {
            defaults.minClass.find("span").removeClass().eq(index).addClass("current");
            if (dir == "left") {
                defaults.maxClass.stop(true, false).animate({
                    "left": -defaults.maxCon * index
                });
            } else {
                defaults.maxClass.stop(true, false).animate({
                    "top": -defaults.maxCon * index
                });
            }
        }
        function picMoveFirst() {
            defaults.maxClass.append(defaults.maxClass.find("li:first").clone());
            if (dir == "left") {
                defaults.maxClass.stop(true, false).animate({
                    "left": -defaults.maxCon * defaults.maxLen
                }, 300, function() {
                    defaults.maxClass.css("left", "0");
                    defaults.maxClass.find("li:last").remove();
                });
            } else {
                defaults.maxClass.stop(true, false).animate({
                    "top": -defaults.maxCon * defaults.maxLen
                }, 300, function() {
                    defaults.maxClass.css("top", "0");
                    defaults.maxClass.find("li:last").remove();
                });
            }
            defaults.minClass.find("span").removeClass("current").eq(0).addClass("current");
        }
    };
    /*
    * 倒计时
    * param  obj : 当前dom对象
    * param  second : 倒计时刻度
    * param  type : 倒计时类型（0 / 01:01:01  , 1 / 01:01 , 2 / 01）
    * param  callback_s:回调函数 s
    */
    tools.progressCountDown = function(obj, second, type, callback_s) {
        //缓存定时器
        var timer = obj.data("timer");
        if (typeof timer != 'undefined') {
            clearInterval(timer);
        }
        second = second > 0 ? second : 0;
        var hh,//小时dom
            mm,//分钟dom
            ss,//秒钟dom
            h = 0,//小时刻度
            m = 0,//分钟刻度
            s = 0;//秒钟刻度
        if (type == 0) {
            h = Math.floor(second / 3600), m = Math.floor(second % 3600 / 60), s = second % 3600 % 60;
            obj.attr("second", second).html("<span class='hh'>" + tools.fillChar(h, 0, 2, 0) + "</span>:<span class='mm'>" + tools.fillChar(m, 0, 2, 0) + "</span>:<span class='ss'>" + tools.fillChar(s, 0, 2, 0) + "</span>");
        } else if (type == 1) {
            m = Math.floor(second / 60), s = second % 60;
            obj.attr("second", second).html("<span class='mm'>" + tools.fillChar(m, 0, 2, 0) + "</span>:<span class='ss'>" + tools.fillChar(s, 0, 2, 0) + "</span>");
        } else if (type == 2) {
            s = second;
            obj.attr("second", second).html("<span class='ss'>" + s + "</span>");
        }
        if (second <= 0) {
            return;
        }
        hh = obj.find(".hh"), mm = obj.find(".mm"), ss = obj.find(".ss");
        timer = setInterval(function() {
            second--;
            if (second >= 0) {
                if (type == 0) {
                    h = Math.floor(second / 3600), m = Math.floor(second % 3600 / 60), s = second % 3600 % 60;
                    hh.html(tools.fillChar(h, 0, 2, 0)), mm.html(tools.fillChar(m, 0, 2, 0)), ss.html(tools.fillChar(s, 0, 2, 0));
                } else if (type == 1) {
                    m = Math.floor(second / 60), s = second % 60;
                    mm.html(tools.fillChar(m, 0, 2, 0)), ss.html(tools.fillChar(s, 0, 2, 0));
                } else if (type == 2) {
                    s = second;
                    ss.html(s);
                }
            } else {
                clearInterval(timer);
                return;
            }
            //规定时刻内执行回调
            if (callback_s) {
                for (var key in callback_s) {
                    if (second <= key && typeof (callback_s[key]) == "function")
                        callback_s[key](), callback_s[key] = null;
                }
            }
            obj.attr("second", second);
        }, 1000);
        obj.data("timer", timer);
    }
    tools.rDrag = {
        o: null,
        id: null,
        init: function(o, id) {
            o.onmousedown = this.start;
            tools.rDrag.id = id;
        },
        start: function(e) {
            var o;
            e = tools.rDrag.fixEvent(e);
            if (e.target.id != tools.rDrag.id) return true;
            e.preventDefault && e.preventDefault();
            tools.rDrag.o = o = this;
            o.x = e.clientX - tools.rDrag.o.offsetLeft;
            o.y = e.clientY - tools.rDrag.o.offsetTop;
            document.onmousemove = tools.rDrag.move;
            document.onmouseup = tools.rDrag.end;
        },
        move: function(e) {
            e = tools.rDrag.fixEvent(e);
            var oLeft, oTop;
            oLeft = e.clientX - tools.rDrag.o.x;
            oTop = e.clientY - tools.rDrag.o.y;
            tools.rDrag.o.style.left = oLeft + 'px';
            tools.rDrag.o.style.top = oTop + 'px';
        },
        end: function(e) {
            e = tools.rDrag.fixEvent(e);
            tools.rDrag.o = document.onmousemove = document.onmouseup = null;
        },
        fixEvent: function(e) {
            if (!e) {
                e = window.event;
                e.target = e.srcElement;
                e.layerX = e.offsetX;
                e.layerY = e.offsetY;
            }
            return e;
        }
    };
    tools.filename = function(url) {
        if (!url)
            url = location.href;
        var urlArray = url.split("#")[0].split("?")[0].split("/");
        return urlArray[urlArray.length - 1];
    };
    /**
     * 是否是视频房间页面
     * @returns {boolean}
     */
    tools.is_in_room_page = function() {
        return (this.filename() == consts.url.SHOW_ROOM || this.filename() == consts.url.LIVE_ROOM || this.filename() == consts.url.CAVEOLAE_ROOM || this.filename() == consts.url.NEST_ROOM || this.filename() == consts.url.TRANSFER);
    };
    tools.is_show_room = function() {
        return (this.filename() == consts.url.SHOW_ROOM);
    }
    tools.is_live_room = function() {
        return (this.filename() == consts.url.LIVE_ROOM);
    }
    tools.is_caveolae_room = function() {
        return (this.filename() == consts.url.CAVEOLAE_ROOM);
    }
    tools.is_nest_room = function() {
        return (this.filename() == consts.url.NEST_ROOM);
    }
    tools.is_transfer_page = function() {
        return (this.filename() == consts.url.TRANSFER);
    }
    tools.is_home_page = function() {
        return (this.filename() == "index.shtml" || this.filename() == "");
    };
    tools.need_login_page = function() {
        return (this.filename() == "act.shtml" || this.filename() == "personal.shtml" || this.filename() == "group.shtml");
    };
    tools.is_ticket_page = function() {
        return (this.filename() == "ticket.shtml");
    };
    tools.is_ranklist_page = function() {
        return (this.filename() == "ranklist.shtml");
    };
    tools.is_show_page = function() {
        return (this.filename() == "show.shtml");
    };
    tools.is_playback_page = function() {
        return (this.filename() == "playback.shtml");
    };
    tools.is_act_page = function() {
        return (this.filename() == "act.shtml");
    };
    tools.is_group_page = function() {
        return (this.filename() == "group.shtml");
    };
    /*
    * 跳转到指定页面
    * url:     指定跳转地址
    * callback:回调函数
    */
    tools.reload = function(url, callback) {
        if (callback) {
            callback();
        }
        if (url) {
            window.location.href = window.mgc.tools.changeUrlToLivearea(url);
        }
        window.location.reload();
    }
    /*
     *获取地址中的参数
     */
    tools.getUrlVars = function(url) {
        if (!url) {
            url = window.location.href;
        };
        var vars = [], hash;
        var hashes;
        if (MgcAPI.SNSBrowser.IsX52()) {
            hashes = url.slice(url.indexOf('?') + 1).split(/[&#]/);
        } else {
            hashes = url.slice(url.indexOf('?') + 1).split(/[&#|]/);
        }
        for (var i = 0; i < hashes.length; i++) {
            hash = hashes[i].split('=');
            vars.push(hash[0]);
            try {
                vars[hash[0]] = decodeURIComponent(hash[1]);
            } catch (e) {

            }
        }
        return vars;
    };
    tools.encodeJQ = function(str, id) {
        $("#" + id).text(str);
    }
    /*
    var s=document.createElement('script');
    s.charset='gbk';
    var src=document.getElementById('d').src;
    alert(src);
    s.src=src;
    document.body.appendChild(s);
    setTimeout(function(){
    alert(window.a)
    },300)
    */
    tools.urlencode = function(str, charset, callback) {
        //创建form通过accept-charset做encode
        var form = document.createElement('form');
        form.method = 'get';
        form.style.display = 'none';
        form.acceptCharset = charset;
        if (document.all) {
            //如果是IE那么就调用document.charset方法
            window.oldCharset = document.charset;
            document.charset = charset;
        }
        var input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'str';
        input.value = str;
        form.appendChild(input);
        form.target = '_urlEncode_iframe_';
        document.body.appendChild(form);
        //隐藏iframe截获提交的字符串
        if (!window['_urlEncode_iframe_']) {
            var iframe;
            if (document.all) {
                try {
                    iframe = document.createElement('<iframe name="_urlEncode_iframe_"></iframe>');
                } catch (e) {
                    iframe = document.createElement('iframe');
                    //iframe.name = '_urlEncode_iframe_';
                    iframe.setAttribute('name', '_urlEncode_iframe_');
                }
            } else {
                iframe = document.createElement('iframe');
                //iframe.name = '_urlEncode_iframe_';
                iframe.setAttribute('name', '_urlEncode_iframe_');
            }
            iframe.style.display = 'none';
            iframe.width = "0";
            iframe.height = "0";
            iframe.scrolling = "no";
            iframe.allowtransparency = "true";
            iframe.frameborder = "0";
            iframe.src = 'about:blank';
            document.body.appendChild(iframe);
        }
        //
        window._urlEncode_iframe_callback = function(str) {
            callback(str);
            if (document.all) {
                document.charset = window.oldCharset;
            }
        }
        //设置回调编码页面的地址，这里需要用户修改
        form.action = 'getEncodeStr.html';
        form.submit();
        setTimeout(function() {
            form.parentNode.removeChild(form);
            iframe.parentNode.removeChild(iframe);
        }, 500)

    };
    tools.urldecode = function(str, charset, callback) {
        var script = document.createElement('script');
        script.id = '_urlDecodeFn_';
        window._urlDecodeFn_ = callback;
        if (document.all) {
            //隐藏iframe截获提交的字符串 
            if (!window['_urlDecode_iframe_']) {
                var iframe = document.createElement('iframe');
                //iframe.name = '_urlDecode_iframe_'; 
                iframe.setAttribute('name', '_urlDecode_iframe_');
                iframe.style.display = 'none';
                iframe.width = "0";
                iframe.height = "0";
                iframe.scrolling = "no";
                iframe.allowtransparency = "true";
                iframe.frameborder = "0";
                iframe.src = 'about:blank';
                document.body.appendChild(iframe);
            }
            //ie下需要指明charset，然后src=datauri才可以 
            iframe.contentWindow.document.write('<html><scrip' + 't charset="gbk" src="data:text/javascript;charset=gbk,parent._decodeStr_=\'' + str + '\'"></s' + 'cript></html>');
            setTimeout(function() {
                callback(_decodeStr_);
                iframe.parentNode.removeChild(iframe);
            }, 300)
        } else {
            var src = 'data:text/javascript;charset=' + charset + ',_urlDecodeFn_("' + str + '");';
            src += 'document.getElementById("_urlDecodeFn_").parentNode.removeChild(document.getElementById("_urlDecodeFn_"));';
            script.src = src;
            document.body.appendChild(script);
        }
    };
    tools.getUrlParam = function(name, url) {
        return this.getUrlVars(url)[name];
    };
    tools.roomid = function() {
        return this.getUrlParam('roomId');
    };
    //炫舞2平台cookie缓存
    tools.setXW2Cookie = function() {
        tools.cookie("XW2_IED_LOG_INFO2", tools.getUrlParam('userName'), {
            path: '/',
            domain: '.qq.com'
        });
        tools.cookie("XW2_IED_LOG_INFO2_GENDER", 1 - tools.getUrlParam('gender'), {
            path: '/',
            domain: '.qq.com'
        });
        if (typeof (tools.getUrlParam('zoneid')) == 'undefined') {
            tools.cookie("mgc_zoneid", mgc.consts.pageSourceConfig.zoneid, {
                path: '/'
            });
        } else {
            tools.cookie("mgc_zoneid", (parseInt(tools.getUrlParam('zoneid'), 10) + mgc.consts.pageSourceConfig.X52.channel * 10000), {
                path: '/'
            });
        }
        tools.pageSource().zoneid = parseInt(tools.cookie("mgc_zoneid"));
        tools.cookie("x52_uin", tools.getUrlParam('qq'), {
            path: '/',
            domain: '.qq.com'
        });
        tools.cookie("x52_skey", tools.getUrlParam('key'), {
            path: '/',
            domain: '.qq.com'
        });
    };
    //炫舞2大区判断
    tools.isx52Area = function() {
        return ((tools.cookie("mgc_zoneid") > 40000) && !mgc.account.checkGuestStatus(true));
    };
    /*    
    * 字符串补齐
    * param  str:被操作的字符串
    * param  char:要补齐的字符
    * param  len:字符串总长度
    * param  type:0/左补齐，1/右补齐  
    */
    tools.fillChar = function(str, char, len, type) {
        str = String(str), char = String(char);
        if (str.length >= len) return str;
        for (var i = 0, n = len - str.length ; i < n; i++) {
            str = type == 0 ? char + str : str + char;
        }
        return str;
    }
    // 字符串转json
    tools.strToJson = function(responseStr) {
        if (typeof (responseStr) != 'object') {
            var aresponseStr = responseStr.replace(/\r\n/g, "<br>");
            console.log("newreqStr : " + aresponseStr);
            return JSON.parse(aresponseStr);
        } else {
            return responseStr;
        }
    };
    //是否新角色
    tools.isNewRole = function() {
        if (MGC_Comm.CheckGuestStatus(true)) return true;

        if (tools.cookie("mgc_zoneid") == 30889 || window.mgc.tools.cookie("mgc_zoneid") == 888) {
            return true;
        }
        return false;
    }
    //获取接入平台信息
    tools.getPageSource = function() {
        return MgcAPI.SNSBrowser.IsQQGame() ? "QGame" : MgcAPI.SNSBrowser.IsX52() ? "X52" : "mgc";
    }
    //获取pageSource对象
    tools.pageSource = function() {
        return consts.pageSourceConfig[tools.getPageSource()] || consts.pageSourceConfig.mgc;
    }
    //qgame特有：获取urlparam中的roomid
    tools.getRoomIdForQGame = function() {
        var param = tools.getUrlParam("param");
        var roomid = null;
        if (param) {
            roomid = param.split('-')[1];
        }
        return roomid;
    }
    //修改所有链接的跳转
    tools.changeLinkTo = function() {
        if (MgcAPI.SNSBrowser.IsThirdParty()) {
            $("body").delegate("a,form[target='_blank']", "click", function(e) {
                if (($(this).hasClass("target-blank") || this.innerText.indexOf("活动") == 0) && tools.filename($(this).attr("href")) != consts.url.TRANSFER) {
                    //新tab页打开
                    return;
                }
                if ($(this).attr("href") == consts.url.IPAY || $(this).attr("data-href") == consts.url.IPAY) {
                    window.mgc.minipay.show();
                    $(this).attr("href", "javascript:;");
                    $(this).attr("data-href", consts.url.IPAY);
                    return false;
                } else {
                    $(this).removeAttr("target");
                }
                if ($(this).attr("target") == '_blank') {
                    $(this).removeAttr("target");
                    if (MgcAPI.SNSBrowser.IsQQGameLiveArea().indexOf("true") == 0) {
                        var liveAreaUrl = $(this).attr("href") || $(this).attr("data-href") || $(this).attr("action");
                        var paramIndex = liveAreaUrl.indexOf("param=true#");
                        if (typeof (liveAreaUrl) != 'undefined') {
                            if (liveAreaUrl.indexOf("javascript") == -1 && liveAreaUrl.indexOf("param") == -1) {
                                if (liveAreaUrl.indexOf("?") == -1) {
                                    if (MgcAPI.SNSBrowser.IsQQGameLiveArea()) {
                                        liveAreaUrl += "?param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea();
                                    }
                                } else {
                                    if (MgcAPI.SNSBrowser.IsQQGameLiveArea()) {
                                        liveAreaUrl += "&param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea();
                                    }
                                }
                            }
                            else if (paramIndex != -1) {
                                liveAreaUrl = liveAreaUrl.substring(0, paramIndex + 10);
                            }
                        }
                        $(this).attr("href", liveAreaUrl);
                        $(this).attr("data-href", liveAreaUrl);
                    }
                }
                //else {
                //    var liveAreaUrl = $(this).attr("href") || $(this).attr("data-href") || $(this).attr("action");
                //    if (typeof (liveAreaUrl) != 'undefined') {
                //        if (liveAreaUrl.indexOf("javascript") == -1 && liveAreaUrl.indexOf("param") == -1) {
                //            if (liveAreaUrl.indexOf("?") == -1) {
                //                if(MgcAPI.SNSBrowser.IsQQGameLiveArea()) {
                //                    liveAreaUrl += "?param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea();
                //                }
                //            } else {
                //                if(MgcAPI.SNSBrowser.IsQQGameLiveArea()) {
                //                    liveAreaUrl += "&param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea();
                //                }
                //            }
                //        }
                //        $(this).attr("href", liveAreaUrl);
                //        $(this).attr("data-href", liveAreaUrl);
                //    }
                //}
            });
        }
        else if (tools.is_in_room_page()) {
            $("body").delegate("a[target='_blank'],form[target='_blank']", "click", function(e) {
                if (tools.filename($(this).attr("href")) == consts.url.TRANSFER) {
                    $(this).removeAttr("target");
                }
            });
        }
    }
    //中英文字符串长度
    tools.Strlen = function(str) {
        var len = 0;
        for (var i = 0; i < str.length; i++) {
            var c = str.charCodeAt(i);
            //单字节加1
            if ((c >= 0x0001 && c <= 0x007e) || (0xff60 <= c && c <= 0xff9f)) {
                len++;
            } else {
                len += 2;
            }
        }
        return len;
    };
    //中英文字符串长度 :大写字母按双字节计算
    tools.getStrlen = function(str) {
        var len = 0;
        for (var i = 0; i < str.length; i++) {
            var c = str.charCodeAt(i);
            //单字节加1
            if ((c >= 0x0001 && c <= 0x007e) || (0xff60 <= c && c <= 0xff9f)) {
                len++;
            } else {
                len += 2;
            }
        }
        return len;
    };
    //截取字符串：大写字母按两个字节处理
    tools.substring = function(str, len) {
        if (str && tools.getStrlen(str) > len * 2) {
            var _str = "";
            var _len = 0;
            for (var i = 0; i < str.length; i++) {
                var c = str.charCodeAt(i);
                //单字节加1
                if ((c >= 0x0001 && c <= 0x007e) || (0xff60 <= c && c <= 0xff9f)) {
                    _len++;
                } else {
                    _len += 2;
                }
                if (_len > 2 * (len)) {
                    break;
                }
                _str += str[i];
            }
            return _str;
        }
        return str;
    }
    tools.Strcut = function(str, len) {
        var str_length = 0;
        var str_len = 0;
        str_cut = new String();
        str_len = str.length;
        for (var i = 0; i < str_len; i++) {
            a = str.charAt(i);
            str_length++;
            if (escape(a).length > 4) {
                //中文字符的长度经编码之后大于4
                str_length++;
            }
            if (str_length > len) {
                return str_cut;
            } else if (str_length == len) {
                str_cut = str_cut.concat(a);
                return str_cut;
            }
            str_cut = str_cut.concat(a);
        }
        //如果给定字符串小于指定长度，则返回源字符串；
        if (str_length < len) {
            return str;
        }
    };

    tools.mZone = function(mz) {
        return (mz == "梦工厂" || mz.indexOf("QQ游戏") >= 0 ? mz : "炫舞-" + mz);
    };
    //添加了x52显示规则
    tools.myZoneName = function(zonename) {
        return zonename != "" ? (zonename == "梦工厂" || zonename.indexOf("QQ游戏") >= 0 || tools.isx52Area() ? zonename : "炫舞-" + zonename) : "";
    }
    /*
	 * 调用方法
	 */
    tools.callopt = function(_opt) {
        var swfobj = window.mgc.tools.getSWF('x51VideoWeb');
        //swfobj.request_as("{\"op_type\":" + _opt + "}");
        swfobj.request_as(_opt);
    };
    /*
     *showAS
     */
    tools.showAS = function() {
        $('#x51VideoWeb').attr("width", "800px;").attr("height", "200px;").show();
    };
    /*
     *hideAS
     */
    tools.hideAS = function() {
        $('#x51VideoWeb').attr("width", "1px;").attr("height", "1px;").hide();
    };
    tools.susTipsHtmlPop = function(e, n, val) {
        if ((n == 1 && val == '') || (n == 1 && val == '无')) {
            return false;
        }
        var susTips = $(".sus_badge_tips"), t = (e.pageY == undefined ? e.clientY : e.pageY) - 15, l = (e.pageX == undefined ? e.clientX : e.pageX) + 20;
        susTips.css({ "top": t, "left": l, "text-align": "left" });
        if (n == 1) {
            if (val != '') {
                susTips.html(val);
            }
            window.mgc.popmanager.layerControlShow(susTips, 4, 3);
            $(window).scroll(function(e) {
                window.mgc.popmanager.layerControlHide(susTips, 4, 3);
            });
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 4, 3);
        }
    }
    tools.susTipsBadge = function(e, n, val) {
        if ((n == 1 && val == '') || (n == 1 && val == '无')) {
            return false;
        }
        var susTips = $(".sus_badge_tips"), t = (e.pageY == undefined ? e.clientY : e.pageY) - 20, l = (e.pageX == undefined ? e.clientX : e.pageX) + 33;
        var x = (e.pageX == undefined) ? e.clientX : e.pageX;
        if (l < x + 56) {
            l = x + 84;
        }
        susTips.css({ "top": t, "left": l, "text-align": "left" });
        if (n == 1) {
            if (val != '') {
                susTips.html(val);
            }
            window.mgc.popmanager.layerControlShow(susTips, 4, 3);
            $(window).scroll(function(e) {
                window.mgc.popmanager.layerControlHide(susTips, 4, 3);
            });
        } else {
            window.mgc.popmanager.layerControlHide(susTips, 4, 3);
        }
    }
    /*
     *左右切换移动
     *@param id       当前操作的对象
     *@param num      最多显示元素的个数
     *@param left     每次移动的距离
     */
    tools.flipOver = function(id, num, left) {
        var rlCon = $(id + " .task_list"), page = 0, rlPre = $(id + " .task_pre"), rlNext = $(id + " .task_next");
        if (rlCon.find("li").length <= num) {
            rlPre.hide();
            rlNext.hide();
        } else {
            rlPre.removeClass().addClass("task_pre task_pre_un");
            rlNext.removeClass().addClass("task_next");
        }
        rlCon.find("ul").css({ "left": 0 });
        rlPre.click(function() {
            var thisClass = rlPre.attr("class");
            if (thisClass == "task_pre") {
                var rList = rlCon.find("li"), len = rList.length;
                if (len >= num) {
                    page--;
                    if (page == 0) {
                        rlPre.removeClass().addClass("task_pre task_pre_un");
                    }
                    if (page >= 0) {
                        rlCon.find("ul").animate({
                            "left": -left * page
                        });
                        rlNext.removeClass().addClass("task_next");
                    } else {
                        page = 0;
                    }
                }
            }
        });
        rlNext.click(function() {
            var thisClass = rlNext.attr("class");
            if (thisClass == "task_next") {
                var rList = rlCon.find("li"), len = rList.length, total = Math.ceil(len / num);
                if (len >= num) {
                    page++;
                    if (page < total) {
                        rlCon.find("ul").animate({
                            "left": -left * page
                        });
                        rlPre.removeClass().addClass("task_pre");
                    }
                    if (page == total - 1) {
                        rlNext.removeClass().addClass("task_next task_next_un");
                    } else {
                        page = 1;
                    }
                }
            }
        });
    }
    // 判断直播专区 url，加上标识
    tools.changeUrlToLivearea = function(url) {
        var liveareaUrl = url;
        if (liveareaUrl.indexOf("param=") == -1) {
            if (liveareaUrl.indexOf("?") == -1) {
                liveareaUrl = url + "?param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea();
            } else {
                liveareaUrl = url + "&param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea();
            }
        }
        return liveareaUrl;
    }
    /*
     * 通用提示框，后续所有报错均调用次接口
     * DialogObj {
     *     Title:提示框标题,
     *     Note:提示框提示语,
     *     Type:提示框类型, 1：AS调用 2：主动PUSH 3：页面调用
     *     BtnName:提示框第一个按钮名称,
     *     BtnNum:提示框按钮个数, >1 会显示取消按钮
     * }
     *
     * _callback：回调函数 string or function(){}
     */
    tools.commonDialog = function(DialogObj, _callback, _callback2, isNotOnlyOpen, isCloseAll) {
        var m_callback;
        var m_callback2;
        $('#ConfirmBtn').removeAttr('href');
        $('#ConfirmBtn').removeAttr('data-href');
        $('#ConfirmBtn,#CloseBtn,#CancelBtn').unbind("click");
        if (!arguments[3]) {
            isNotOnlyOpen = true;
        }
        if (!arguments[4]) {
            isCloseAll = false;
        }
        DialogObj.Title = DialogObj.Title || "提示";
        if (DialogObj.Title) {
            $('#TitleP').html(DialogObj.Title);
        }
        if (DialogObj.Note) {
            $('#NoteP').html(DialogObj.Note);
        }
        $('#CancelBtn').html("取消").hide();
        if (DialogObj.BtnName) {
            $('#ConfirmBtn').html(DialogObj.BtnName);
        } else {
            $('#ConfirmBtn').html("确定");
        }
        if (isNotOnlyOpen) {
            m_callback = function() {
                tools.hideDialog(isCloseAll);
                if (_callback)
                    _callback();
            };
            m_callback2 = function() {
                tools.hideDialog(isCloseAll);
                if (_callback2)
                    _callback2();
            };
        } else {
            m_callback = function() {
                showDialog.hide();
                if (_callback)
                    _callback();
            };
            m_callback2 = function() {
                showDialog.hide();
                if (_callback2)
                    _callback2();
            };
        }
        if (typeof m_callback == "function") {
            $('#ConfirmBtn').unbind('click').click(function() {
                $(this).unbind("click");
                m_callback();
            });
        } else {
            $('#ConfirmBtn').unbind('click').bind('click', function() {
                $(this).unbind("click");
                console.log('cb');
            });
        }
        if (typeof m_callback == "string") {
            $('#ConfirmBtn').attr("href", "javascript:" + m_callback + "();");
        }
        if (DialogObj.url != undefined && DialogObj.url != "") {
            $('#ConfirmBtn').attr("href", DialogObj.url);
            $('#ConfirmBtn').attr("target", "_blank");
        } else {
            $('#ConfirmBtn').removeAttr("href");
            $('#ConfirmBtn').removeAttr("target");
        }
        if (DialogObj.BtnNum > 1) {
            if (DialogObj.BtnName2) {
                $('#CancelBtn').html(DialogObj.BtnName2);
            }
            $('#CancelBtn').show();
            //避免弹窗中取消按钮显示错误
            $("#CancelBtn").css("display", "inline-block");
            if (typeof m_callback2 == "function") {
                $('#CancelBtn').unbind('click').click(function() {
                    $(this).unbind("click");
                    m_callback2();
                });
                $('#CloseBtn').unbind('click').click(function() {
                    $(this).unbind("click");
                    m_callback2();
                });
            }
            if (typeof m_callback2 == "string") {
                $('#CancelBtn').attr("href", "javascript:" + m_callback2 + "();");
                $('#CloseBtn').attr("href", "javascript:" + m_callback2 + "();");
            }
        } else {
            $('#CancelBtn').hide();
            if (typeof m_callback == "function") {
                $('#CloseBtn').unbind('click').click(function() {
                    $(this).unbind("click");
                    m_callback();
                });
            }
            if (typeof m_callback == "string") {
                $('#CloseBtn').attr("href", "javascript:" + m_callback + "();");
            }
        };
        /*输入框光标移出*/
        $('#SendMsgChatBox').blur();
        window.mgc.popmanager.layerControlShow($("#CommonDialog"), 6, 1, 1);
        $("#CommonDialog").centerDisp();
    };
    tools.hideDialog = function() {
        window.mgc.popmanager.layerControlHide($("#CommonDialog"), 6, 1);
    };
    (function($) {
        $.fn.inViewPort = function(container) {
            var $window = $(window);
            var element = this;
            $.belowthefold = function() {
                var fold;
                if (container === undefined || container === window) {
                    fold = $window.height() + $window.scrollTop();
                } else {
                    fold = $(container).offset().top + $(container).height();
                }
                return fold <= $(element).offset().top;
            };
            $.rightoffold = function() {
                var fold;
                if (container === undefined || container === window) {
                    fold = $window.width() + $window.scrollLeft();
                } else {
                    fold = $(container).offset().left + $(container).width();
                }
                return fold <= $(element).offset().left;
            };
            $.abovethetop = function() {
                var fold;
                if (container === undefined || container === window) {
                    fold = $window.scrollTop();
                } else {
                    fold = $(container).offset().top;
                }
                return fold >= $(element).offset().top + $(element).height();
            };
            $.leftofbegin = function() {
                var fold;
                if (container === undefined || container === window) {
                    fold = $window.scrollLeft();
                } else {
                    fold = $(container).offset().left;
                }
                return fold >= $(element).offset().left + $(element).width();
            };
            return !$.rightoffold() && !$.leftofbegin() && !$.belowthefold() && !$.abovethetop();
        };
        $.fn.centerDisp = function() {
            this.css("left", "50%");
            this.css("top", "50%");
            this.css("marginLeft", -this.outerWidth() / 2 + "px");
            this.css("marginTop", -this.outerHeight() / 2 + "px");
        };
    })(jquery);
    /*
    *侧边栏
    */
    tools.topFun = function() {
        var $$ = tools.topFun.prototype;
        var stag = true;
        var $content = $(".content");
        var $obj = $('.sd_quick');
        //自适应分辨率
        $$.autoClient = function(x) {
            if ($content.length == 0)
                return;
            l = $content.offset().left;
            w = $content.width();
            s = document.body.parentNode.clientWidth;
            z = document.documentElement.clientHeight;
            h = document.body.clientHeight;
            _w = $obj.width();
            _h = $obj.height();
            if (l + w + x + _w > s || s <= 1024) {
                $obj.hide();
            } else {
                $obj.show();
                console.log("侧边栏：" + l + "   " + w + "   " + x);
                if (l != 0)
                    $obj.css('left', (l + w + x) + 'px');
            }
            $obj.css('top', Math.ceil(z - _h / 2) / 2 + 'px');
        }
        //页面文档高度设定
        $$.autoDomHeight = function() {
            z = document.documentElement.clientHeight;
            h = document.body.clientHeight;
            _header = $(".header").height();
            _footer = $(".footer").height();
            _margin_top = parseInt($content.css("margin-top"), 10);
            _margin_bottom = parseInt($content.css("margin-bottom"), 10);
            if (h < z) {
                $content.css("min-height", z - _header - _footer - 2 - _margin_top - _margin_bottom);
            }
        }
        //回顶
        $$.goTop = function() {
            if (stag)
                $('html,body').stop().animate({ scrollTop: '0' }, 200, function() { stag = true; });
            stag = false;
        }
        //展开、收起
        $$.slideToggle = function() {
            $obj.find(".help").parent().slideToggle(50, function() {
                $obj.find(".feedback").parent().slideToggle(50, function() {
                    if ($obj.find(".slideToggle").hasClass("_slideToggle")) {
                        $obj.find(".slideToggle").removeClass("_slideToggle").html("收起");
                    } else {
                        $obj.find(".slideToggle").addClass("_slideToggle").html("展开");
                    }
                });
            });
        }
        //初始化
        $$.Init = function() {
            try {
                $$.autoClient(5); //.sd_quick的div距浏览器底部和页面内容区域右侧的距离
                $$.autoDomHeight();// 界面自使用高度
                //$$.b();
                $obj.find('.top').click(function() {
                    $$.goTop();
                });
                $obj.find(".slideToggle").click(function() {
                    $$.slideToggle();
                });
                $(window).resize(function() {
                    $$.autoClient(5); //.sd_quick的div距浏览器底部和页面内容区域右侧的距离
                    $$.autoDomHeight();// 界面自使用高度
                });
            } catch (e) {
                //**
            }
        }
        $$.Init();
    }
    /*
    * 获取web服务器时间
    */
    tools.getSeverDateTime = function() {
        var xhr = window.ActiveXObject ? new ActiveXObject("Microsoft.XMLHTTP") : new XMLHttpRequest();
        try {
            if (xhr != null) {
                xhr.open("HEAD", window.location.href, false);
                xhr.send(null);
            }
        } catch (e) {
            console.log("error");
        }
        var d = new Date(xhr.getResponseHeader("Date"));
        return d;
    }
    /*
    *活动配置--例如愚人节等
    */
    tools.ACT = {
        //获取当前活动
        GET_ACT: function() {
            var nowDate = tools.getSeverDateTime();
            var act = null;
            for (var i = 0; i < config.ACT_CONFIG.SERIES.length; i++) {
                act = config.ACT_CONFIG.SERIES[i];
                if (act.ACR_STATE == 1) {
                    var act_date = act.ACT_DATE.split('-');
                    var start_act_date = new Date(act_date[0]);
                    var end_act_date = new Date(act_date[1]);
                    if (start_act_date <= nowDate && end_act_date >= nowDate) {
                        console.log("当前活动：" + JSON.stringify(act));
                        break;
                    }
                } else {
                    act = null;
                }
            }
            return act;
        },
        //处理当前活动
        DO_ACT: function() {
            var act;
            try {
                act = tools.ACT.GET_ACT();
            } catch (e) {
                console.log("活动获取失败");
            }
            if (act) {
                switch (act.ACT_ID) {
                    case "01":
                        //todo
                        $('[class*="' + act.ACT_MARK + '"]').addClass("act-dis-block");
                        break;
                    case "02":
                        //todo
                        $('[class*="' + act.ACT_MARK + '"]').show();
                        break;
                }
            } else {
                $('#start_top10_container').find('.fourth .live, .fifth .live, .sixth .live, .seventh .live,.eighth .live, .ninth .live, .tenth .live').css("left", "60px");
            }
        }
    }
    tools.getCaret = function(el) {
        if (el.selectionStart) {//IE9-或者标准浏览器
            return el.selectionStart;
        } else if (document.selection) {//IE8-或者支持selection对象的浏览器
            el.focus();
            var r = document.selection.createRange();
            if (r == null) {
                return 0;
            }
            var re = el.createTextRange(), rc = re.duplicate();
            re.moveToBookmark(r.getBookmark());
            rc.setEndPoint('EndToStart', re);
            return rc.text.length;
        }
        return 0;
    }
    //销毁js对象
    tools.CollectGarbage = function() {
        if (arguments && arguments.length > 0) {
            for (var i = 0; i < arguments.length; i++) {
                arguments[i] = null;
            }
        }
    }
    //初始化EAS
    if (typeof (EAS.Init) == 'function') { EAS.Init(); };
    //数据上报：EAS.SendClick
    tools.EAS = function(opt) {
        try {
            for (var i = 0, len = opt.length; i < len; i++) {
                EAS.SendClick({ 'e_c': opt[i].e_c, 'c_t': opt[i].c_t });
            }
        } catch (e) {
            console.log("EAS.SendClick : error :" + e.message);
        }
    }

    tools.getVideoLog = function() {
        tools.getSWF("LiveVideoSwfContainer").getLog();
    };

    /*debugger for qqGame*/
    tools.mydebugger = function() {
        var mgc_debugger_btn = $("#mgc-debugger-btn");
        var mgc_debugger_panl = $("#mgc-debugger-panl");
        var mgc_debugger_area = $("#mgc-debugger-area");
        var mgc_debugger_txt = $("#mgc-debugger-txt");
        var mgc_debugger_submit = $("#mgc-debugger-submit");
        mgc_debugger_btn.dblclick(function(e) {
            mgc_debugger_panl.toggle();
        });
        mgc_debugger_submit.click(function() {
            try {
                eval(mgc_debugger_txt.val());
            } catch (e) {
                console.log("大哥。。。整错了:" + e.message);
            }
        });
        tools.rDrag.init(mgc_debugger_panl.get(0), "mgc-debugger-panl");
    }
    tools.mydebugger();
    /*调整图片大小
     * @{param} array 需要调整的图片数组
     * @{param} Number 需要调整图片到某一宽度
     * @{param} Number 需要调整图片到某一高度
    */
    tools.adjustPics = function(img) {
        var elms = $(img._img);
        var pNode = $(img._img).parent();
        var vertical_live = elms.attr('vertical_live');
        console.log("vertical_live:"+vertical_live);
        var w = img.width;
        var h = img.height;

        var trueW = parseInt(pNode.css("width"));
        var trueH = parseInt(pNode.css("height"));

        //等比缩到同宽，调整图片垂直居中
        if (trueW / w > trueH / h) {
            var rate = trueW / w;
            var scaleH = parseInt(h * rate);
            if(vertical_live == "true"){  //判断是否竖屏，1：横屏，2：竖屏
                //竖屏时，从图片上面截取，而不是从中间截取
                elms.css({ width: trueW, height: scaleH, marginTop:0 });
            }else{
                elms.css({ width: trueW, height: scaleH, marginTop: -(scaleH - trueH) / 2 });
            }
            //elms.css({ width: trueW, height: scaleH, marginTop: -(scaleH - trueH) / 2 });
        } else if (trueW / w < trueH / h) { // 等比缩到同高，调整图片水平居中
            var rate = trueH / h;
            var scaleW = parseInt(w * rate);
            elms.css({ width: scaleW, height: trueH, marginLeft: -(scaleW - trueW) / 2 });
        } else {
            elms.css({ width: trueW, height: trueH, marginLeft: 0, marginTop: 0 });
        }
    }
    // 演唱会房间人数格式修改
    // 人数最多8位数，极限数字为99999999；超过99999999统一显示为99999999+
    tools.showRoomNumFormat = function(num){
        // num =  100000000;//100;
        var number = tools.getNumberBits(parseInt(num));
        if(number > 8){
            num = "99999999+";
        }
        return num;
    }
    // 房间外人数格式修改
    // 数字位数超过5位后，以w（万）为计量单位，可保留小数点后1位，按照四舍五入显示，如：人数为88888，则显示8.9w，若人数为80000，则显示8w
    tools.roomListNumFormat = function(num){
        // num = 16099500;
        var number = tools.getNumberBits(num);
        if(number >= 5){
            if((num / 1000) % 10 == 0){
                num = parseInt(num / 10000) + "w";
            } else{
                num = (num / 10000).toFixed(1);
                if(num * 10 % 10 == 0){
                    num = parseInt(num * 10 / 10)+ "w";
                } else{
                    num = num + "w";
                }
            }
        }
        return num;
    }
    // 计算给定数据 num 的位数
    // @{param} {Number} 需要操作的数据
    tools.getNumberBits = function(num){
        return num.toString().length;
    }

    /**
     * 切换页签
     * @param  {[String]} id  [description]
     * @param  {[String]} con [description]
     * @param  {[Number]} i   [description]
     */
    tools.tabCut = function(id, con, i, callback) {
        // if (!isLoginCallback) {
        //     return;
        // }
        var tabArr = $("#" + id).find("li a");
        if (tabArr.eq(i).hasClass("current")) {
            return;
        }
        

        tabArr.removeClass("current").eq(i).addClass("current");
        $("#" + con).find("ul").hide().eq(i).show();
        var $scrollAPI;
        if (id == "aninfo_tab1") {
            $scrollAPI = $("#" + con).find(".fans_list").eq(i - 1).data('jsp');
        } else {
            $scrollAPI = $("#" + con).data('jsp');
        }
        //重绘滚动条
        if ($scrollAPI){
            $scrollAPI.initScroll(true);
            if(id == "sc_tab"){
                $("#sc_con .jspDrag").hide();
            }
        }
            
        if (callback) {
            callback(id, con, i);
        }
    }
    /**
     * 滚动条位置
     * @param  {[String]} con
     * @param  {[Number]} i
     */
    tools.dragArr = [];
    tools.dragConArr = [];
    tools.paneArr = [];
    tools.paneConArr = [];
    tools.tabCur = true;
    tools.scrollPosition = function(con, i) {//滚动条位置
        var item = $("#" + con), jspDrag = item.find(".jspDrag"), jspPane = item.find(".jspPane");
        var jspDragTop = jspDrag.css("top"),
            jspPaneTop = jspPane.css("top");
        if (i == 0) {
            tools.dragArr.push(jspDragTop);
            tools.dragConArr.push(jspPaneTop);
        } else {
            tools.paneArr.push(jspDragTop);
            tools.paneConArr.push(jspPaneTop);
        }
        if (i == 0) {
            if (tools.tabCur) {
                jspDrag.css("top", 0);
                jspPane.css("top", 0);
                tools.tabCur = false;
            } else {
                jspDrag.css("top", tools.paneArr[0]);
                jspPane.css("top", tools.paneConArr[0]);
            }
            tools.paneArr.shift();
            tools.paneConArr.shift();
        } else {
            if (tools.tabCur) {
                jspDrag.css("top", 0);
                jspPane.css("top", 0);
                tools.tabCur = false;
            } else {
                jspDrag.css("top", tools.dragArr[0]);
                jspPane.css("top", tools.dragConArr[0]);
            }
            tools.dragArr.shift();
            tools.dragConArr.shift();
        }
    }
    tools.controlCon = function(con, def) {
        var con = $("." + con);
        if (def == true) {
            //con.show();
            window.mgc.popmanager.layerControlShow(con, 1, 2);
        } else if (def == false) {
            //con.hide();
            window.mgc.popmanager.layerControlHide(con, 1, 2);
        } else {
            //con.hide();
            window.mgc.popmanager.layerControlHide(con, 1, 2);
        }
    }
    tools.cardTips = function(evt, con) {
        var posx = 0, posy = 0, l, t, card = jquery(".card_tips");
        if (/firefox/.test(navigator.userAgent.toLowerCase())) {
            evt = evt
        } else {
            evt = evt || window.event;
        }
        //var evt = evt || window.event;
        if (evt == undefined) {
            var Y = jquery('#GiftSwf').offset().top;
            var X = jquery('#GiftSwf').offset().left;
            t = mouseY + Y + 10;
            l = mouseX + X + 20;
        }
        else {
            if (evt.pageX || evt.pageY) {
                posx = evt.pageX;
                posy = evt.pageY;
            } else if (evt.clientX || evt.clientY) {
                posx = evt.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
                posy = evt.clientY + document.documentElement.scrollTop + document.body.scrollTop;
            }
            if (navigator.userAgent.toLocaleLowerCase().indexOf('msie') !== -1) {
                t = posy + 10, l = posx + 20;
            } else {
                t = posy + 10, l = posx + 20;
            }
        }

        //判断是否出边界
        if ((l + 204) > jquery(window).width()) {
            l = l - 204;
        }
        var cardHeight = card.height();
        if ((t + cardHeight) > jquery(window).height()) {
            t = t - cardHeight;
        }
        var sideStat = $(".side-left").attr("side_state");
        var mainType = 3;
        var filename = tools.filename();
        if (filename != "showroom.shtml") {
            //不是演唱会
            if (evt == null) {
                mainType = 3;//之前是2，现在3：bug号：78467
            }
            else {
                var thisEle = evt.srcElement || evt.currentTarget;
                if ($(thisEle).is(".li_player,.li_sz_room,.userbtn") || $(thisEle).parents(".li_player").length > 0 || $(thisEle).parents(".li_sz_room").length > 0) {
                    if (sideStat == "1") {
                        mainType = 3;
                    }
                }
            }

        }

        if (defCard == true) {
            card.css({ "left": l, "top": t });
            window.mgc.popmanager.layerControlShow(card, mainType, 2);
        } else {
            //card.hide();
            window.mgc.popmanager.layerControlHide(card, mainType, 2);
        }
        jquery(document).click(function(e) {
            e = e || window.event; // 兼容IE7
            var obj = jquery(e.srcElement || e.target);
            if (jquery(obj).is("#" + con + ",#" + con + " *   ,.card_tips")) {
                card.css({ "left": l, "top": t });
                window.mgc.popmanager.layerControlShow(card, mainType, 2);
            } else {
                //card.hide();
                window.mgc.popmanager.layerControlHide(card, mainType, 2);
                oldClientWidth = 0;
                oldClientLeft = 0;
                jquery(document).off("click");
            }
        });
        oldClientWidth = document.body.clientWidth;//记录当前浏览器文档宽度 77 review
        oldClientLeft = l;//记录当前鼠标位置 77 review
    }
    tools.susHotTips = function(e, n, val) {
        var t = 35;
        var l = 150;
        if (n == 1 && val == '') {
            return false;
        }
        var susTips = jquery(".hotTips");
        susTips.css({ "top": t, "left": l });
        if (n == 1) {
            if (val != '') {
                susTips.text(val);
            }
            //  susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 1, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 1, 3);
        }

    }
    tools.susHotTitleTips = function(e, n, val, istype) {
        var t;
        var l;

        if (istype == 1) {
            t = 50;
            l = 35;
        }
        else if (istype == 2) {
            t = 50;
            l = 150;
        }
        else {
            t = 35;
            l = 35;
        }

        if (n == 1 && val == '') {
            return false;
        }
        var susTips = jquery(".hot_title_Tips");
        susTips.css({ "top": t, "left": l });
        if (n == 1) {
            if (val != '') {
                susTips.text(val);
            }
            //  susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 1, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 1, 3);
        }
    }
    tools.timer = null;
    // 倒计时
    tools.progressTime = function(id, second) {
        //传入的秒数应该在十分钟以内
        var progressTime = jquery("#" + id);
        var timeArea = progressTime.find("strong");
        var minAndSecs = timeArea.find("i");
        var mins = minAndSecs.eq(0);
        var secs = minAndSecs.eq(1);
        progressTime.show();
        clearInterval(tools.timer);
        var startTime = new Date().getTime();
        var s = second;
        tools.timer = setInterval(function() {
            var nowTime = new Date().getTime();
            var selTime = second - Math.floor((nowTime - startTime)/ 1000);
            if(selTime < s)
            {
                s = selTime;
            }
            if (s >= 0) {
                var min = Math.floor(s / 60) % 60;
                var sec = s % 60;
                var t = "";
                if (sec < 10) {
                    t += "0";
                }
                t += sec;
                mins.html(min), secs.html(t);
            } else {
                clearInterval(tools.timer);
                progressTime.hide();
            }
            s--;
        }, 1000);
    }
    /*图片地址*/
    tools.MsgImgPath = "http://ossweb-img.qq.com/images/mgc/css_img/chat/";
    if (!window.mgc) {
        window.mgc = {};
    }
    //首页、娱乐表演完全脱离老代码
    if (tools.is_home_page() || tools.is_show_page()) {
        jQuery.extend({
            //获取URL参数
            urlGet:function(){
                var aQuery = window.location.href.split("?");
                //取得Get参数
                var aGET = new Array();
                if (aQuery.length > 1) {
                    var aBuf = aQuery[1].split("&");
                    var aBuf = aQuery[1].split("&");
                    for (var i = 0, iLoop = aBuf.length; i < iLoop; i++) {
                        var aTmp = aBuf[i].split("=");
                        //分离key与Value
                        aGET[aTmp[0]] = aTmp[1];
                    }
                }
                return aGET;
            }
        });
        var debug=jQuery.urlGet();
        window.console = window.console || (function() {
            var c = {}; c.log = c.warn = c.debug = c.info = c.error = c.time = c.dir = c.profile = c.clear = c.exception = c.trace = c.assert = function() { };
            return c;
        })();
        //var trunk=false;//判断是否是现网  true：是  false：否
        //if( MgcAPI.SNSBrowser.Host === 'mgc.qq.com'){
        //    trunk=true;
        //}
        window.console._log = window.console.log;
        var $mgc_debugger = $("#mgc-debugger-area");
        window.console.log = function(msg) {
            //if(!trunk){
                _date = new Date();
                var _json={};
                _json.ms=_date.getTime();
                _json.time=_date.getHours() + ":" + _date.getMinutes() + ":" + _date.getSeconds() + "." + _date.getMilliseconds();
                _json.msg=msg;
                msg = "ms " + _json.ms+ "    time:" +_json.time +"    "+ _json.msg ;

                window.console._log(msg);
                if (true && $mgc_debugger.val().length < 50000)
                    $mgc_debugger.val($mgc_debugger.val() + "\r\n" + msg);
                msg = null;
           // }
        }
        window.console.log1 = function(msg) {
            //if(!trunk){
                _date = new Date();
                var _json={};
                _json.ms=_date.getTime();
                _json.time=_date.getHours() + ":" + _date.getMinutes() + ":" + _date.getSeconds() + "." + _date.getMilliseconds();
                _json.msg=msg;
                msg = "ms " + _json.ms+ "    time:" +_json.time +"    "+ _json.msg ;
                $mgc_debugger.val($mgc_debugger.val() + "\r\n" + msg);

                window.console._log(msg);
            //}
        }
    }
    /**
     * 判断是否是移动端管理员
     * @param  {[Array]} arr 需要查找的数组
     * @param  {[Value]} val 查找值
     * @return {[Boolean]}  
     */
    tools.judgeIfUserAdmin = function(arr, val){
        for(var i=0, n=arr.length; i<n; i++){
            if(arr[i] == val){
                return true;
            }
        }
        return false;
    }
    window.mgc.tools = tools;
    return tools;
});