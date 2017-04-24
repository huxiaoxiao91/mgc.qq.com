/**
*   重写alert定义，alert弹出自定义弹框。
*/
if (!window.mgc) {
    window.mgc = {};
}
MGC_CommRequest = {};
MGC_CommResponse = {};

window.alert = function(Str) {
    var strObj = {};
    strObj.Note = Str;
    MGC_Comm.CommonDialog(strObj);
}
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
var labelListArr = [];
var totalPage = 0;;
var currentPage = 0;
//Todo:放到一个数据结构中去，建议房间相关模块MGC_RoomCom。
var isCaveolae = "false";

//是否拥有邀请玩家加入后援团的权限
var canInvite = false;
/**
*   自定义时间格式
*/
Date.prototype.format = function(format) {
    var o = {
        "M+": this.getMonth() + 1, //month
        "d+": this.getDate(),    //day
        "h+": this.getHours(),   //hour
        "m+": this.getMinutes(), //minute
        "s+": this.getSeconds(), //second
        "q+": Math.floor((this.getMonth() + 3) / 3),  //quarter
        "S": this.getMilliseconds() //millisecond
    }
    if (/(y+)/.test(format)) format = format.replace(RegExp.$1,
    (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o) if (new RegExp("(" + k + ")").test(format))
        format = format.replace(RegExp.$1,
        RegExp.$1.length == 1 ? o[k] :
        ("00" + o[k]).substr(("" + o[k]).length));
    return format;
}

/**
*   检测浏览器内核
*   Todo:放到初始化模块中去，建议MGC_Init
*/
; (function($, window, document, undefined) {
    if (!window.browser) {

        var userAgent = navigator.userAgent.toLowerCase(), uaMatch;
        window.browser = {}

        /**
         * 判断是否为ie
         */
        function isIE() {
            return ("ActiveXObject" in window);
        }
        /**
         * 判断是否为谷歌浏览器
         */
        if (!uaMatch) {
            uaMatch = userAgent.match(/chrome\/([\d.]+)/);
            if (uaMatch != null) {
                window.browser['name'] = 'chrome';
                window.browser['version'] = uaMatch[1];
            }
        }
        /**
         * 判断是否为火狐浏览器
         */
        if (!uaMatch) {
            uaMatch = userAgent.match(/firefox\/([\d.]+)/);
            if (uaMatch != null) {
                window.browser['name'] = 'firefox';
                window.browser['version'] = uaMatch[1];
            }
        }
        /**
         * 判断是否为opera浏览器
         */
        if (!uaMatch) {
            uaMatch = userAgent.match(/opera.([\d.]+)/);
            if (uaMatch != null) {
                window.browser['name'] = 'opera';
                window.browser['version'] = uaMatch[1];
            }
        }
        /**
         * 判断是否为Safari浏览器
         */
        if (!uaMatch) {
            uaMatch = userAgent.match(/safari\/([\d.]+)/);
            if (uaMatch != null) {
                window.browser['name'] = 'safari';
                window.browser['version'] = uaMatch[1];
            }
        }
        /**
         * 最后判断是否为IE
         */
        if (!uaMatch) {
            if (userAgent.match(/msie ([\d.]+)/) != null) {
                uaMatch = userAgent.match(/msie ([\d.]+)/);
                window.browser['name'] = 'ie';
                window.browser['version'] = uaMatch[1];
            } else {
                /**
                 * IE10
                 */
                if (isIE() && !!document.attachEvent && (function() { "use strict"; return !this; }())) {
                    window.browser['name'] = 'ie';
                    window.browser['version'] = '10';
                }
                /**
                 * IE11
                 */
                if (isIE() && !document.attachEvent) {
                    window.browser['name'] = 'ie';
                    window.browser['version'] = '11';
                }
            }
        }

        /**
         * 注册判断方法
         */
        if (!$.isIE) {
            $.extend({
                isIE: function() {
                    return (window.browser.name == 'ie');
                }
            });
        }
        if (!$.isChrome) {
            $.extend({
                isChrome: function() {
                    return (window.browser.name == 'chrome');
                }
            });
        }
        if (!$.isFirefox) {
            $.extend({
                isFirefox: function() {
                    return (window.browser.name == 'firefox');
                }
            });
        }
        if (!$.isOpera) {
            $.extend({
                isOpera: function() {
                    return (window.browser.name == 'opera');
                }
            });
        }
        if (!$.isSafari) {
            $.extend({
                isSafari: function() {
                    return (window.browser.name == 'safari');
                }
            });
        }
    }
})(jQuery, window, document);
/**
*   贵族等级定义
*   Todo:放到其他模块中去，建议MGC_Const
*/
var vipLevelTab = {
    0: '无',
    1: '近卫',
    2: '骑士',
    3: '将军',
    4: '亲王',
    5: '皇帝'
}; // 0普通1近卫2 骑士3将军4亲王5皇帝
/**
*   守护等级定义
*   Todo:放到其他模块中去，建议MGC_Const
*/
var guardLevelTab = {
    0: '无',
    10: '初级守护',
    20: '中级守护',
    50: '高级守护',
    100: '天使守护',
    200: '灵魂守护',
    250: '非凡守护',
    300: '至尊守护',
    400: '天尊守护',
    500: '超凡守护'
};

/**
*   视频清晰度定义
*   Todo:放到其他模块中去，建议MGC_Const
*/
var showRoomDefinition = {
    0: '流畅',
    1: '标清',
    2: '高清',
    3: '超清'
};
/**
*   视频清晰度定义
*
*/
var MGC_SWFINIT = {
    "LiveVideo": false,
    "GiftSwf": false,
    playerInfo: null //第一次拉取homepage后，存取
};
var LiveRoomData;
var isLiveRoomData = false;
/**
*   重新设置jquery对象
*/
var $m = jQuery.noConflict();

/**
*   Cookie操作
*/
jQuery.cookie = function(name, value, options) {
    if (typeof value != 'undefined') {
        options = options || {};
        if (value === null) {
            value = '';
            options.expires = -1;
        }
        var expires = '';
        if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
            var date;
            if (typeof options.expires == 'number') {
                date = new Date(); // milo.getSeverDateTime();是否引用milo？(v_binjinluo)
                date.setTime(date.getTime() + (options.expires * 60 * 1000));
            } else {
                date = options.expires;
            }
            expires = '; expires=' + date.toUTCString();
        }
        var path = options.path ? '; path=' + options.path : '';
        var domain = options.domain ? '; domain=' + options.domain : '';
        var secure = options.secure ? '; secure' : '';
        document.cookie = [name, '=', encodeURIComponent(value), expires,
            path, domain, secure
        ].join('');
    } else {
        var cookieValue = null;
        if (document.cookie && document.cookie != '') {
            var cookies = document.cookie.split(';');
            for (var i = 0; i < cookies.length; i++) {
                var cookie = jQuery.trim(cookies[i]);
                if (cookie.substring(0, name.length + 1) == (name + '=')) {
                    cookieValue = decodeURIComponent(cookie
                        .substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }
};

/**
*   获得flash对象
*/
function getSWF(a) {
    if (navigator.appName.indexOf("Microsoft") != -1) {
        return window[a];
    } else {
        if (window.navigator.userAgent.indexOf("Firefox") != -1) {
            return document[a];
        } else {
            if (window.navigator.userAgent.indexOf("Chrome") != -1) {
                return document[a];
            } else {
                if (window.navigator.userAgent.indexOf("Safari") != -1) {
                    return document.getElementById(a);
                } else {
                    if (window.navigator.userAgent.indexOf("Opera") != -1) {
                        return document[a];
                    }
                }
            }
        }
        return document[a];
    }
}

/**
*   小数转百分数
*/
Number.prototype.toPercent = function(len) {
    return (Math.round(this * 10000) / 100).toFixed(len) + '%';
}

/**
*   复制操作
*/
var copy = function(txt) {
    if (window.clipboardData) {
        window.clipboardData.clearData();
        if (window.clipboardData.setData("Text", txt)) {
            alert("复制成功！");
        }
        else {
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
        if (!clip) return;
        var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);
        if (!trans) return;
        trans.addDataFlavor('text/unicode');
        var str = new Object();
        var len = new Object();
        var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
        var copytext = txt;
        str.data = copytext;
        trans.setTransferData("text/unicode", str, copytext.length * 2);
        var clipid = Components.interfaces.nsIClipboard;
        if (!clip) return false;
        clip.setData(trans, null, clipid.kGlobalClipboard);
        alert("复制成功！");
    } else {
        alert("对不起，您的浏览器不能使用复制功能，请手动复制！");
    }
}

//邀请后援团
var inv_from = 3;
var fansInvited = function() {
    var playId = $m("#invitationBtn").attr("data_targetId");
    var showAreaName = $m("#invitationBtn").attr("data_showAreaName");
    var _reqStr = { "op_type": 72, "target_id": playId, "inv_from": inv_from };
    MGC_Comm.sendMsg(_reqStr, "invitationCallBack");
}

var copyToClipBoard = function() {
    var txt = $m(".ni_nick").text();
    if (window.clipboardData) {
        window.clipboardData.clearData();
        if (window.clipboardData.setData("Text", txt)) {
            alert("复制成功！");
        }
        else {
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
        if (!clip) return;
        var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);
        if (!trans) return;
        trans.addDataFlavor('text/unicode');
        var str = new Object();
        var len = new Object();
        var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
        var copytext = txt;
        str.data = copytext;
        trans.setTransferData("text/unicode", str, copytext.length * 2);
        var clipid = Components.interfaces.nsIClipboard;
        if (!clip) return false;
        clip.setData(trans, null, clipid.kGlobalClipboard);
        alert("复制成功！");
    } else {
        alert("对不起，您的浏览器不能使用复制功能，请手动复制！");
    }
}

// 一些公用和需要缓存的数据，统一存储在这里
var MGCData = {
    // 梦工厂的固定大区ID
    mgcZoneId: 888,

    // 是否正在走注册流程
    isRegister: false,

    // 我的playId
    myPlayerId: 0,

    // 我的vip等级
    myVipLevel: 0,

    // 是否关注0-未关注 1-已关注
    followAnchor: 0,
    // 是房间的还是名片的关注 0 - 房间 1-主播名片
    isAnchorOrRoom: 0,
    difFollowAnchor: [{followAnchor:0},{followAnchor:0}],

    //主播id
    anchorID: 0,

    //演唱会视频质量
    showRoomDefinition: 0,

    //是否隐身 true隐身
    invisible: false,

    //是否演唱会
    isConcert: false,

    //主播等级
    anchor_level: 0,

    //主播等级底板
    anchor_level_bg: 0,

    //主播等级瓶颈标识
    is_bottleneck: false,

    //主播等级当前经验
    anchor_exp: 0,

    //主播等级当前经验需要达到下一经验的经验值
    anchor_levelup_exp: 0,

    //主播瓶颈礼物
    bottleneck_gift_name: 0,

    //主播瓶颈送的礼物数量
    bottleneck_count: 0,

    //主播瓶颈需要送的礼物数量
    bottleneck_need_count: 0,

    //主播瓶颈送的礼物ID
    bottleneck_gift_id: 0,

    //主播经验槽百分比
    anchor_Per: 0,

    //送主播最大值上限梦幻币礼物
    max_anchor_exp: 0,

    //目前总共送主播最大值上限梦幻币礼物
    total_anchor_exp: 0,

    //通过星耀值还可为主播增加的经验值上限
    starlight_rest_exp_today: 0,

    //通过收梦幻币礼物还可为主播增加的主播经验上限
    dream_gift_rest_exp_today: 0,
    
    //通过收抽奖为主播增加的主播经验上限
    lucky_draw_rest_exp_today: 0,

    //主播满级标识
    anchor_level_max: false,

    //主播区域加载标识
    anchor_area: true,

    //礼物数据
    giftData: [],

    //圣诞活动礼物id
    activity_gift_id:55,

    //设置礼物数据
    setGiftData: function(data) {
        MGCData.giftData = data;
        MGCData.getFantasyGift(data);
    },
    //梦幻币礼物
    fantasyGiftData: [],
    fantasyGiftData_30: [],
    fantasyGiftData_31: [],
    fantasyGiftData_32: [],
    //设置梦幻币礼物：获取梦幻币礼物给主播的经验值
    getFantasyGift: function(data) {
        $m.each(data, function(k, v) {
            if (MGCData.fantasyGiftData.length != 3) {
                if (v.id == 30) {
                    v.anchorexp;
                    v.name;
                    MGCData.fantasyGiftData_30.push(v.anchorexp);
                    MGCData.fantasyGiftData_30.push(v.name);
                } else if (v.id == 31) {
                    v.anchorexp;
                    v.name;
                    MGCData.fantasyGiftData_31.push(v.anchorexp);
                    MGCData.fantasyGiftData_31.push(v.name);
                } else if (v.id == 32) {
                    v.anchorexp;
                    v.name;
                    MGCData.fantasyGiftData_32.push(v.anchorexp);
                    MGCData.fantasyGiftData_32.push(v.name);
                }

            }
        })

        if (MGCData.fantasyGiftData.length < 3 && MGCData.fantasyGiftData_30.length > 0 && MGCData.fantasyGiftData_31.length > 0 && MGCData.fantasyGiftData_32.length > 0) {

            MGCData.fantasyGiftData.push(MGCData.fantasyGiftData_30);
            MGCData.fantasyGiftData.push(MGCData.fantasyGiftData_31);
            MGCData.fantasyGiftData.push(MGCData.fantasyGiftData_32);
        }
    },
    attention:false,
    //所有房间
    totalRoomList:[],
    //根据id获取礼物数据
    getGiftData:function(id){
        var data;
        for(var i = 0;i<this.giftData.length;i++)
        {
            if(id == this.giftData[i].id)
            {
                data = this.giftData[i];
            }
        }
        return data;
    }
    
};

var loginTest = {
    okcallback: null,
    cancelcallback: null,
    showLoginTest: function(_okcallback, _cancelcallback) {//显示
        okcallback = _okcallback;
        cancelcallback = _cancelcallback
        $m("#loginForTest").show();
    },
    hideLoginTest: function(t) {//隐藏
        $m("#loginForTest").hide();
        if (cancelcallback != null) {
            cancelcallback();
        }
        if (MGC_Comm.getUrlParam("ADUIN") && !t) {
            //QQ tips 页面
            window.location.href = "/";
        } else {
            if (!t && !MGC_Comm.CheckGuestStatus(true)) {
                if (filename == "personal.shtml" || filename == "act.shtml" || filename == "showroom.shtml" || filename == "liveroom.shtml" || filename == "caveolaeroom.shtml" || filename == "nest.shtml") {
                    window.location.href = "/";
                }
            }
        }
    },
    doLoginTest: function() {//login
        if ($m("#txtLoginName").val().length == 0) {
            window.alert("请输入账号");
            return false;
        }
        if (okcallback != null) {
            okcallback();
        }
        this.hideLoginTest(true);
    },
    disableEnter: function(event) {//回车登录
        var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
        if (keyCode == 13) {
            this.doLoginTest(true);
        }
    }
};

var CreateRoleClose = function() {
    //创建角色的时候关闭弹框   
    var nickName = $m('#popSr').val();
    if (nickName == '' || nickName == '输入QQ昵称') {
        try {
            EAS.SendClick({ 'e_c': 'mgc.regist.close', 'c_t': 4 });
        } catch (e) {

        }
    }
}

// ==================公用的方法============================================================
var MGC_Comm = {
    //========================永航测试方法=================================
    //永航内网测试接入接口
    isTransferRequest: false,
    countdownNum: 120,
    countdownId: 0,
    invitationData: null,
    genderInt: 0,

    strEndIndex : 0,
    g_HorizonLoginData: {
        mgcQQ: "0",
        mgcVerify: "test_verify"
    },
    //游客身份
    g_HorizonGuestData: {
        isGuest: false,
        mgc_guest_id: "",
        mgc_guest_token: ""
    },

    g_HorizonChangeLoginUIStatus: function() {
        console.log1("登录态：g_HorizonChangeLoginUIStatus");
        var logined = $j(".logined");
        var unlogined = $j(".unlogin");
        logined.show();
        unlogined.hide();
    },

    g_HorizonLogin: function() {
        console.log1("登录态：g_HorizonLogin");
        var qq = $m("#txtLoginName").val();
        var logined = $j(".logined");
        var unlogined = $j(".unlogin");
        logined.show();
        unlogined.hide();
        MGC_Comm.g_HorizonLoginData.mgcQQ = qq;
        $m.cookie("mgc_login", MGC_Comm.g_HorizonLoginData.mgcQQ);
    },

    g_HorizonLogout: function(_funca) {
        console.log1("登录态：g_HorizonLogout");
        var logined = $j(".logined");
        var unlogined = $j(".unlogin");
        logined.hide();
        unlogined.show();
        if (typeof _funca == 'function') {
            _funca();
        }
    },

    g_HorizonCheckLogin: function(_hasCookieCallback, _noCookieCallback) {
        MGC_Comm.g_HorizonLoginData.mgcQQ = MGC_Comm.commonGetCookie();
        if ((MGC_Comm.g_HorizonLoginData.mgcQQ == null || MGC_Comm.g_HorizonLoginData.mgcQQ.length == 0 || MGC_Comm.g_HorizonLoginData.mgcQQ == "0")) {
            //未登录
            _noCookieCallback();
        }
        else {
            _hasCookieCallback(MGC_Comm.g_HorizonLoginData.mgcQQ, MGC_Comm.g_HorizonLoginData.mgcVerify);
        }
    },

    g_HorizonIsLogin: function() {
        if (MGC_Comm.g_HorizonLoginData.mgcQQ == null || MGC_Comm.g_HorizonLoginData.mgcQQ.length == 0 || MGC_Comm.g_HorizonLoginData.mgcQQ == "0") {
            return false;
        }
        else {
            return true;
        }
    },
    //检查游客身份是否已经登录
    //isDoLogin:是否弹登录框
    CheckGuestStatus: function(isDoLogin) {
        //此处走重构版本游客判定
        return window.mgc.account.checkGuestStatus(isDoLogin);
        if (MGC_Comm.g_HorizonGuestData.isGuest && !isDoLogin) {
            //执行登录
            MGC_Comm.DoLoginFirst();
        }
        return MGC_Comm.g_HorizonGuestData.isGuest;
    },
    // 申请游客账号
    RegisterGuestCard: function() {
        var _reqStr = { "op_type": OpType.VOT_GetGuestInfo };
        console.log("申请游客账号：" + JSON.stringify(_reqStr));
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.RegisterGuestCardCallBack");
    },
    //种下游客cookie
    SetGuestCookie: function(obj) {
        MGC_Comm.g_HorizonGuestData.mgc_guest_id = obj.id;
        MGC_Comm.g_HorizonGuestData.mgc_guest_token = obj.encrypt_identity;
        MGC_Comm.g_HorizonGuestData.isGuest = true;
        $m.cookie("mgc_guest_id", obj.id);
        //$m.cookie("mgc_guest_token", obj.encrypt_identity);
        console.log("种下游客身份cookie：" + JSON.stringify(MGC_Comm.g_HorizonGuestData));
    },
    DelGuestCookie: function() {
        MGC_Comm.g_HorizonGuestData.mgc_guest_id = "";
        MGC_Comm.g_HorizonGuestData.mgc_guest_token = "";
        MGC_Comm.g_HorizonGuestData.isGuest = false;
        console.log("删除游客身份cookie：" + JSON.stringify(MGC_Comm.g_HorizonGuestData));
    },
    //永航自制登入弹框，可以输入QQ号
    g_funcHorizonLoginToast: function(okcallback) {
        //弹loading框
        MGC.popLoading(true);
        //这里应该弹自制组件，输入QQ号然后按确定回调
        //okcallback("2921101974");
        //自制输入框点取消时的回调。
        //cancelcallback();
        loginTest.showLoginTest(okcallback, function() {
            MGC.popLoading(false);
        });
    },
    //测试登录回调  在这里登出游客发送171
    loginToastOk: function() {
        //如果是在游客状态下切换正常玩家时 应先登出游客 发送171
        if (MGC_Comm.CheckGuestStatus(true) && (filename == "liveroom.shtml" || filename == "showroom.shtml" || filename == "caveolaeroom.shtml" || filename == "nest.shtml")) {
            console.log("登出游客171");
            MGC_Comm.sendMsg({ "op_type": 171 });
        } else {
            MGC_Comm.loginInfo();
        }
    },


    //==========================永航测试接口结束=============================

    commonLogin: function(_funca) {
            LoginManager.login(_funca);
            $m("#coverbg").css("z-index", 990000);
            $m("#loginDiv").css("z-index", 990001);
            //第三方登录插件 绑定关闭事件
            if (filename == "" || filename == "index.shtml") {
                //
            } else {
                LoginManager.closeLogin(function() {
                    if (!MGC_Comm.CheckGuestStatus(true))
                        window.location.href = window.mgc.tools.changeUrlToLivearea(home);
                    return true;
                });
            }
    },

    commonCheckLogin: function(_funca, _funcb) {
        //走新框架逻辑
        mgc.account.checkLogin(_funca, _funcb, true);
    },

    // 获得uin
    commonGetUin: function(_funca, _funcb) {
        if (MGC_Comm.CheckGuestStatus(true)) {
            _funca(MGC_Comm.g_HorizonGuestData.mgc_guest_id.toString());
        } else {
                var uin = '';
                MGC_Comm.commonCheckLogin(function() {
                    _funca(LoginManager.getUserUin());
                }, function() {
                    _funca(0);
                });
        }
    },
    commonLogout: function(_funca) {
            LoginManager.logout(_funca);
    },

    commonIsLogin: function() {
            return LoginManager.isLogin();
    },

    // 获得cookie内容
    commonGetCookie: function(cookieName) {
            var _name = (typeof cookieName == 'undefined') ? 'mgc_login' : cookieName;
            return $m.cookie(_name);

    },

    requestLogout: function(_funca) {
            LoginManager.logout(_funca);
    },

    afterLogout: function(type) {
        var _reqStr = "{\"op_type\":171}";
        MGC_Comm.sendMsg(_reqStr);
        MGC_Comm.loginInfo(type);
    },

    //浏览器无登陆态时点击登录调用。
    DoLoginFirst: function() {
        MGC_Comm.commonLogin(function() {
            MGC.popLoading(true);
            //如果是在游客状态下切换正常玩家时 应先登出游客 发送171
            if (MGC_Comm.CheckGuestStatus(true) && (filename == "liveroom.shtml" || filename == "showroom.shtml" || filename == "caveolaeroom.shtml" || filename == "nest.shtml")) {
                console.log("登出游客171");
                MGC_Comm.sendMsg({ "op_type": 171 });
            } else {
                MGC_Comm.loginInfo();
                $m("#coverbg").css("z-index", 990000);
                $m("#loginDiv").css("z-index", 990001);
                try {
                    EAS.SendClick({ 'e_c': 'mgc.login', 'c_t': 4 });
                } catch (e) {

                }
            }
        });
    },

    ToDoClosePage: function() {
        window.onbeforeunload = onbeforeunload_handler;
        function onbeforeunload_handler() {
            try {
                getSWF("x51VideoWeb").UpLoadLog();
                getSWF("LiveVideoSwfContainer").UpLoadLog();
            } catch (e) {

            }
        }
    },

    getUrlVars: function(url) {
        if (!url) {
            url = window.location.href;
        };
        var vars = [], hash;
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
    },

    getUrlParam: function(name, url) {
        return MGC_Comm.getUrlVars(url)[name];
    },


    // 重写jquery的getScript方法，支持浏览器缓存
    getScript: function(url, callback) {
        $m.getScript(url, function() {
            callback();
        });
    },

    // ajax提交方法，默认为不缓存,jsonp协议
    ajax: function(_url, callback) {
        $m.ajax({
            type: 'get',
            url: _url,
            dataType: 'jsonp',
            jsonp: 'jsoncallback',
            success: function(data) {
                callback(data);
            },
            error: function() {
                alert('抱歉，网络繁忙，请稍候再试！');
            }
        });
    },

    // 加载flash
    setSwfObj: function() {
        var swfV = swfobject.getFlashPlayerVersion();
        if (swfV == null || typeof swfV == 'undefined' || swfV.major == 0) {
            var DialogObj = {};
            DialogObj.Note = "您没有安装flash，请安装最新版flash";
            MGC_Comm.CommonDialog(DialogObj, function() {
                /*window.location.reload();*/
            });
        } else if (parseInt(swfV.major) < 14) {
            var DialogObj = {};
            DialogObj.Note = "您的flash版本过低，请您安装最新版flash";
            MGC_Comm.CommonDialog(DialogObj, function() {
                /*window.location.reload();*/
            });
        };
        var swfVersionStr = "11.1.0";
        var xiSwfUrlStr = "http://124.207.138.230/x5videoWeb/playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
        var flashvars = {};
        //区分出新老版本消息发送
        if ((filename == "group.shtml" || filename == "showroom.shtml" || filename == "liveroom.shtml" || filename == "caveolaeroom.shtml" || filename == "nest.shtml")) {
            flashvars.isOldFrame = "true";
        }
        var params = {};
        params.quality = "high";
        params.bgcolor = "#ffffff";
        params.allowscriptaccess = "always";
        params.allowfullscreen = "true";
        var attributes = {};
        attributes.id = "x51VideoWeb";
        attributes.name = "x51VideoWeb";
        attributes.align = "middle";
        if (MGC.checkIsIEloadSwfFailed())
            swfUrl += "&r=" + new Date();
        swfobject.embedSWF(swfUrl, "flashContent", "1", "1", swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);

        swfobject.createCSS("#flashContent", "display:block;text-align:left;");
    },

    // 统一发送接口
    sendMsg: function(_reqStr, callback, param1) {
        try {
            //console.log( ":" + new Date().format("yyyy-MM-dd hh:mm:ss.S"));
            var swfobj = getSWF('x51VideoWeb');
            if (swfobj) {
                //_reqStr = typeof (_reqStr) == "string" ? eval('(' + _reqStr + ')') : _reqStr;
                _reqStr = typeof (_reqStr) == "string" ? JSON.parse(_reqStr) : _reqStr;
                console.log("reqStr has send :reqStr : " + JSON.stringify(_reqStr) + + new Date().format("yyyy-MM-dd hh:mm:ss.S"));
                swfobj.request_as(_reqStr, callback, param1);
                swfobj = null;
                _reqStr = null;
                callback = null;
            }
        } catch (e) {
            console.log(e.message);
            setTimeout(function() {
                MGC_Comm.sendMsg(_reqStr, callback);
            }, 50);
        }
    },

    SendMsgChatInit: function() {
        _receiverId = 0;
        _MsgChannel = 0;
        _receiverName = "";
        _receiverZoneName = "";

        $m('#SendMsgChatBtn').click(function() {
            if (_MsgChannel == 0) {
                MGC.tabCut('sc_tab', 'sc_con', 0);
                MGC.scrollPosition('sc_con', 0);
                // if (wheelStop)//是否允许置底
                //     MGC.chatMessage();
                if (wheelStop && !$chat.isPause){//是 否允许置底
                    MGC.chatMessage();
                    $chat.isPause = true;
                    $chat.newMsg = 0;
                }
            } else if (_MsgChannel == 1) {
                // MGC.tabCut('sc_tab', 'sc_con', 0);
                MGC.scrollPosition('sc_con', 0);
                // if (wheelStop)//是否允许置底
                //     MGC.chatMessage();
                if (wheelStop && !$chat.privateIsPause){//是 否允许置底
                    MGC.chatMessage();
                    $chat.privateIsPause = true;
                    $chat.privateNewMsg = 0;
                }
            }else if (_MsgChannel == 4) {
                // MGC.tabCut('sc_tab', 'sc_con', 0);
                MGC.scrollPosition('sc_con', 0);
                // if (wheelStop)//是否允许置底
                //     MGC.chatMessage();
                if (wheelStop && !$chat.helpIsPause){//是 否允许置底
                    MGC.chatMessage();
                    $chat.helpIsPause = true;
                    $chat.helpNewMsg = 0;
                }
            }

            MGC_CommRequest.SendMsgChat();
            var ojb = { "maxHeight": 2000000, "op_type": 34, "box_data_buf": [{ "boxID": 0, "requireHeight": 30000, "hasBeenOpened": false }, { "boxID": 1, "requireHeight": 60000, "hasBeenOpened": false }, { "boxID": 2, "requireHeight": 150000, "hasBeenOpened": false }, { "boxID": 3, "requireHeight": 300000, "hasBeenOpened": false }, { "boxID": 7, "requireHeight": 30000, "hasBeenOpened": false }, { "boxID": 8, "requireHeight": 60000, "hasBeenOpened": false }, { "boxID": 9, "requireHeight": 150000, "hasBeenOpened": false }, { "boxID": 10, "requireHeight": 300000, "hasBeenOpened": false }, { "boxID": 13, "requireHeight": 75000, "hasBeenOpened": false }, { "boxID": 14, "requireHeight": 150000, "hasBeenOpened": false }, { "boxID": 15, "requireHeight": 300000, "hasBeenOpened": false }, { "boxID": 16, "requireHeight": 500000, "hasBeenOpened": false }], "vip_cnt_info": [{ "count": 2, "level": 5, "vipname": "皇帝" }], "curHeight": 47820, "vip_addition": 200 };
            MGC_Response(ojb);
        });

        $m('#SendMsgChatBox').keydown(function(event) {
            if (event.keyCode == 13) {
                if (_MsgChannel == 0) {
                    MGC.tabCut('sc_tab', 'sc_con', 0);
                    MGC.scrollPosition('sc_con', 0);
                    // if (wheelStop)//是否允许置底
                    //     MGC.chatMessage()
                    if (wheelStop && !$chat.isPause){//是 否允许置底
                        MGC.chatMessage();
                        $chat.isPause = true;
                        $chat.newMsg = 0;
                    }
                } else if (_MsgChannel == 1) {
                    // MGC.tabCut('sc_tab', 'sc_con', 0);
                    MGC.scrollPosition('sc_con', 0);
                    // if (wheelStop)//是否允许置底
                    //     MGC.chatMessage();
                    if (wheelStop && !$chat.privateIsPause){//是 否允许置底
                        MGC.chatMessage();
                        $chat.privateIsPause = true;
                        $chat.privateNewMsg = 0;
                    }
                }else if (_MsgChannel == 4) {
                    // MGC.tabCut('sc_tab', 'sc_con', 0);
                    MGC.scrollPosition('sc_con', 0);
                    // if (wheelStop)//是否允许置底
                    //     MGC.chatMessage();
                    if (wheelStop && !$chat.helpIsPause){//是 否允许置底
                        MGC.chatMessage();
                        $chat.helpIsPause = true;
                        $chat.helpNewMsg = 0;
                    }
                }

                MGC_CommRequest.SendMsgChat();
            }
        })
    },

    // 公用的登陆组件
    loginInfo: function(type) {
        //登录模块，使用重构，此处不再处理
        return;
        //检查是否已经login
        MGC_Comm.commonCheckLogin(
                function() {
                    MGC.popLoading(true);
                    mgc_CheckLogin(function() {
                        MGC_Comm.commonGetUin(function(_uin) {
                            MGC_Comm.getAsCache(_uin);
                        });
                    });
                },
                function() {
                    //强制登出
                    MGC_Comm.DoClear();
                    if ((filename == "group.shtml" || filename == "personal.shtml" || filename == "act.shtml" || filename == "showroom.shtml" || filename == "liveroom.shtml" || filename == "caveolaeroom.shtml" || filename == "nest.shtml" || filename == "transfer.shtml")) {
                        if (type == 1) {
                            window.location.href = window.mgc.tools.changeUrlToLivearea(home);
                        }
                        else {
                            if (MGC_Comm.getUrlParam("ADUIN")) {
                                //执行登录
                                MGC_Comm.DoLoginFirst();
                            } else {
                                // 请求服务区列表接口，弹出来选择框
                                try {
                                    EAS.SendClick({ 'e_c': 'mgc.poparea', 'c_t': 4 });
                                } catch (e) {

                                }
                                MGCLoginRequest.roleList();
                                //MGCLoginRequest.areaLogin(MGCData.mgcZoneId);
                                //MGC_Comm.DoLoginFirst(); //不再弹出登录框
                            }
                        }
                    }
                    else {
                        MGCLoginRequest.noLoginRoleList();
                    }
                });
    },

    getAsCache: function(Uin) {
        var _reqStr = "{\"op_type\":-1,\"qq\":\"" + Uin + "\"}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getAsCacheCallBack");
    },
    getAsGuestCache: function() {
        var _reqStr = "{\"op_type\":204}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getAsGuestCacheCallBack");
    },
    // 显示一个div
    showDiv: function(e) {
        showDialog.show({
            id: e,
            bgcolor: "#fff",
            opacity: 50
        });
    },

    // 隐藏div
    hideDiv: function() {
        showDialog.hide();
    },

    //隐藏功能框
    hideFunctionDialog: function() {
        showDialog.hide();
        $m("#CommonDialog").hide();
    },

    // 字符串转json
    strToJson: function(responseStr) {
        return responseStr;
        //if (typeof (responseStr) != 'object') {
        //    var aresponseStr = responseStr.replace(/\r\n/g, "<br>");
        //    console.log("newreqStr : " + aresponseStr);
        //    return JSON.parse(aresponseStr);
        //} else {
        //    return responseStr;
        //}
    },

    // 聊天信息转换
    MsgToStr: function(chatnods) {
        var MsgStr = "";
        $m.each(chatnods, function(k, v) {
            if (v.nodeType == 0) {
                MsgStr += v.content;
            } else if (v.nodeType == 1) {
                MsgStr += "<img src='" + MsgImgPath + "chat_" + v.content + ".gif?v=3_8_8_2016_15_4_final_3' width='20' height='20' alt='' >";
            };
        });

        return MsgStr;
    },

    // 聊天、飞屏、用户输入请求
    ChenckMsgChat: function(Str) {
        /*if (Str.length > 80) {
            alert("输入过长!");
            return false;
        };*/

        if (!Str) {
            alert("请输入聊天内容!");
            return false;
        };
        if (Str == "和大家聊聊天") {
            alert("请输入聊天内容!");
            return false;
        };

        return true;
    },

    // 选择聊天对象
    PreSendMsgChat: function(MsgChannel, obj, IsFirst) {
        _MsgChannel = MsgChannel;
        if (obj) {
            _receiverName = $m.trim($m("#cardTipContainer .name_info .ni_nick").html()) || $m.trim(obj.innerText) || "";//解决转义字符
            if ($m("#cardTipContainer").css('display') == 'none') {
                _receiverName = $m.trim(obj.attributes[0].nodeValue)
            }
            _receiverId = $c(obj).attr("receiverId") || "";
            _receiverZoneName = $m(obj).attr("receiverZoneName") || "";
            _receiverPlayerType = $m(obj).attr("receiverPlayerType") || "";
        } else {
            _receiverId =0;
            _receiverName = "";
            _receiverZoneName = "";
            _receiverPlayerType = "";
        }
        if (_receiverPlayerType == 2) {
            $m('#SendMsgChatObject').html(_receiverName + "[" + (_receiverZoneName == "梦工厂" ? _receiverZoneName : "炫舞-" + _receiverZoneName) + "]");
        } else {
            $m('#SendMsgChatObject').html(_receiverName);
        };

        if (IsFirst) {
            var MsgChatObject = {};
            MsgChatObject.receiverId = _receiverId;
            MsgChatObject.name = _receiverName;
            MsgChatObject.zonename = _receiverZoneName;
            MsgChatObject.receiverPlayerType = _receiverPlayerType;
            var MsgChatObjectCon = $m('#MsgChatObjectTmpl');
            var MsgChatObjectTmpl;
            var MsgChatObjectContainer = $m('#MsgChatObjectContainer').find('.jspPane');
            MsgChatObjectTmpl = MsgChatObjectCon.tmpl(MsgChatObject);
            MsgChatObjectTmpl.appendTo(MsgChatObjectContainer);
            MsgChatObjectTmpl = null;
            MsgChatObjectCon = null;
        };

        MGC_Comm.ClosePrivateMsgList();
    },
    // 关闭聊天选择框
    ClosePrivateMsgList: function() {
        MGC.controlCon('sc_role_out', false);
        $m('#GetPrivateMsgChatListBtn').attr("onclick", "MGC_CommRequest.GetPrivateMsgChatList();");
    },

    bindSearch: function() {
        $m('#search_con').focus(function() {
            if ($m(this).val() == '请输入房间号') {
                $m(this).val("");
            }
        }).blur(function() {
            if ($m.trim($m(this).val()) == '') {
                $m(this).val("请输入房间号");
            }
        }).keyup(function() {
            if ($m(this).val().length > 20) {
                $m(this).val($m(this).val().substring(0, 20));
            }
        }).keydown(function(event) {
            if (event.keyCode == 13) {
                //event.preventDefault();
                //$m('#submitForm').submit();
                //MGC_Comm.searchSubmit();
                //$m('#searchBtn').trigger("click");
            }
        })
    },
    checkFormSubmit: function() {
        var con = $m('#search_con').val();
        con = $m.trim(con);
        if (con == '' || con == '请输入房间号') {
            alert('想要快速进入房间，必须输入2位以上数字');
            return false;
        } else if (con.length > 20) {
            alert('没有该房间哦');
            return false;
        } else if (!/^\d+$/.test(con)) {
            alert('想要快速进入房间，必须输入2位以上数字');
            return false;
        }
        var roomIdFormat = parseInt(con);
        if (roomIdFormat < 10) {
            alert('想要快速进入房间，必须输入2位以上数字。');
            return false;
        }
        var _url = "transfer.shtml";
        $m('#submitForm').attr('action', _url);
        $m('#formRoomId').val(con);
        try {
            EAS.SendClick({ 'e_c': 'mgc.enterroom.2', 'c_t': 4 });
            EAS.SendClick({ 'e_c': 'mgc.enterroom', 'c_t': 4 });
        } catch (e) {

        }
        return true;
    },

    // 快速进入
    searchSubmit: function() {
        var con = $m('#search_con').val();
        con = $m.trim(con);
        if (con == '' || con == '请输入房间号') {
            alert('想要快速进入房间，必须输入2位以上数字');
            return false;
        } else if (con.length > 20) {
            alert('没有该房间哦');
            return false;
        } else if (!/^\d+$/.test(con)) {
            alert('想要快速进入房间，必须输入2位以上数字');
            return false;
        }
        var roomIdFormat = parseInt(con);
        if (roomIdFormat < 10) {
            alert('想要快速进入房间，必须输入2位以上数字。');
            return false;
        }
        /*window.open(home + 'liveroom.shtml?roomId=' + con);*/
        /*MGC_CommRequest.checkRoomStatus(con);*/
        var _url = "transfer.shtml";
        $m('#submitForm').attr('action', _url);
        $m('#formRoomId').val(con);
        $m('#submitBtn').click();
    },
    searchKeyUp: function(obj) {
        var v = $m.trim($m(obj).val());
        if (MGC_Comm.Strlen(v) > 20) {
            $m(obj).val(MGC_Comm.Strcut(v, 20));
        }
    },
    searchKeyDown: function(obj) {
        var v = $m(obj).val();
        if (MGC_Comm.Strlen(v) >= 20) {
            if (event.keyCode == 13)
                event.returnValue = true;
            else
                event.returnValue = false;
        }
        if (event.keyCode == 8) {
            event.returnValue = true;;
        }
    },
    // 显示角色状态设置框
    showUserStatus: function() {
        var _login_status_div = $m('.logined_status'),
            _other_status = $m('.logined_status ul');
        _login_status_div.on('click', function(e) {
            /*
             * if(_other_status.is(':hidden')){ _other_status.show(); }else{
             * _other_status.hide(); }
             */
            _other_status.toggle();
            e.stopPropagation();
        });
        _other_status.find('li').on(
            'click',
            function(e) {
                var _class = $m(this).attr('class'),
                    _status = _class
                    .substr(_class.length - 1); // 0在线 1隐身
                //如果玩家在座位上要隐身  弹提示
                if (typeof (Seat) != "undefined" && _status == 1)
                {
                    if ((Seat.isSeat(MGCData.myPlayerId)) || (mgc.consts.MGCData.myVipLevel > 0))
                    {
                        var dialog = {};
                        dialog.Title = '提示信息';
                        dialog.BtnNum = 2;
                        dialog.BtnName = '隐身';
                        dialog.BtnName2 = '算了吧';
                        dialog.Note = "亲，您隐身后将会自动离开座位";
                        MGC_Comm.CommonDialog(dialog, MGC_Comm.setUserStatus);
                    }
                    else {
                        MGC_Comm.setUserStatus(_status);
                    }
                }
                else {
                    MGC_Comm.setUserStatus(_status);
                }
                e.stopPropagation();
            })
    },

    // 设置隐身或在线状态
    setUserStatus: function(status) {
        //默认为隐身
        status = status ? status : 1;

        var _status = parseInt(status) == 0 ? false : true, // false在线 true隐身
            _reqStr = "{\"op_type\":140,\"invisible\":" + _status + ",\"client\":false}";
        MGC_Comm.sendMsg(_reqStr, "SetUserStatusCallBack");
    },

    // 初始化视频直播swf
    LiveVideoSwfInit: function() {
        var flashvars = {};
        //是否开启硬件编码
        /*
        flashvars.useHardwareDecoder = true;
        if($m.isSafari())
        {
            flashvars.useHardwareDecoder = false;
        }
        */
        flashvars.useHardwareDecoder = false;
        //区分出新老版本消息发送
        if ((filename == "group.shtml" || filename == "showroom.shtml" || filename == "liveroom.shtml" || filename == "caveolaeroom.shtml" || filename == "nest.shtml")) {
            flashvars.isOldFrame = "true";
        }
        var params = {};
        params.quality = "high";
        params.bgcolor = "#000";
        params.allowscriptaccess = "always";
        params.allowfullscreen = "true";
        params.allowFullScreenInteractive = "true";
        params.wmode = "transparent";
        var attributes = {};

        /*
         * attributes.id = "LiveVideoSwf"; attributes.name = "LiveVideoSwf";
         * attributes.align = "middle";
         * swfobject.embedSWF("http://124.207.138.230/x5videoWeb/x51VideoWeb.swf?v=3_8_8_2016_15_4_final_3",
         * "flashContent", "1", "1", swfVersionStr, xiSwfUrlStr, flashvars,
         * params, attributes);
         */

        /*
         * attributes.id = "LiveVideoSwf"; attributes.name = "LiveVideoSwf";
         * attributes.align = "middle";
         */
        var swfurl = "x51VideoPlayer.swf?v=3_8_8_2016_15_4_final_3";
        if (MGC.checkIsIEloadSwfFailed()) {
            swfurl += "&r=" + Math.random();
        }
        swfobject.embedSWF(swfurl, "LiveVideoSwfContainer",
            "100%", "100%", "11.1.0", '', flashvars, params, attributes);
    },

    // 初始化活动礼物flash
    initEventGift: function() {
        var flashvars = {};
        var params = {};
        params.quality = "high";
        params.bgcolor = "#000";
        params.allowscriptaccess = "always";
        params.allowfullscreen = "true";
        params.allowFullScreenInteractive = "true";
        params.wmode = "transparent";
        var attributes = {};
        var swfurl = "assets/eventGift.swf?v=3_8_8_2016_15_4_final_3";
        swfobject.embedSWF(swfurl, "eventGiftContainer",
            "100%", "100%", "11.1.0", '', flashvars, params, attributes);
    },

    // 开始直播
    /*LiveVideoStart: function(LiveUrl) {
        var swfobj = getSWF('LiveVideoSwfContainer');
        var LiveUrl = "{\"cdnUrls\": [\"http://125.39.127.145:1863/6060491.flv?apptype=live&xHttpTrunk=1&buname=x5h3d_platform&uin=2110989563\"]}";
        if (LiveUrl.length == 0)
            alert("数据错误");
        else
            swfobj.start(LiveUrl);
    },*/
    //格式化时间 00:00
    DateToUnix: function(string) {
        var datetime = new Date();
        datetime.setTime(string);
        var hour = datetime.getHours() < 10 ? "0" + datetime.getHours() : datetime.getHours();
        var minute = datetime.getMinutes() < 10 ? "0" + datetime.getMinutes() : datetime.getMinutes();
        return hour + ":" + minute;
    },
    // 初始化送礼swf
    GiftSwfInit: function() {
        var swfVersionStr = "11.1.0";
        var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
        var flashvars = {};
        flashvars.isCaveolae = isCaveolae;
        if(typeof(SKIN) != "undefined")
        {
            flashvars.skinId = SKIN.id;
            flashvars.skinLevel = SKIN.level;
        }
        //区分出新老版本消息发送
        if ((filename == "group.shtml" || filename == "showroom.shtml" || filename == "liveroom.shtml" || filename == "caveolaeroom.shtml" || filename == "nest.shtml")) {
            flashvars.isOldFrame = "true";
        }
        var params = {};
        params.quality = "high";
        params.bgcolor = "#000";
        params.allowscriptaccess = "always";
        params.allowfullscreen = "true";
        params.allowFullScreenInteractive = "true";
        params.wmode = "transparent";
        var attributes = {};

        attributes.id = "GiftSwf";
        attributes.name = "GiftSwf";
        attributes.align = "middle";
        var swfurl = "http://ossweb-img.qq.com/images/mgc/css_img/swf/x51VideoGift.swf?v=3_8_8_2016_15_4_final_3";
        if (MGC.checkIsIEloadSwfFailed()) {
            swfurl += "&r=" + Math.random();
        }
        swfobject.embedSWF(swfurl, "GiftSwfContainer", "100%", "100%",
            swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
    },

    //是否正在播放入场动画
    isPlayEnterRoonmEffect: false,
    //入场特效队列
    enterRoomEffect: [],

    // 增加入场特效
    addEnterRoomEffect: function(obj) {
        MGC_Comm.enterRoomEffect.push(obj);
        if (!MGC_Comm.isPlayEnterRoonmEffect) {
            MGC_Comm.playEnterRoomEffect();
        }
    },

    // 播放入场特效
    playEnterRoomEffect: function() {
        if (MGC_Comm.enterRoomEffect.length == 0 || MGC_Comm.isPlayEnterRoonmEffect) return;

        MGC_Comm.isPlayEnterRoonmEffect = true;
        var obj = MGC_Comm.enterRoomEffect.shift();

        //高级守护入场效果
        if (obj.guard_level > 300) {
            MGC_Comm.showGuardFlash(obj.player_name, obj.player_zone, obj.vip_level, obj.guard_level);
            obj = null;
            return;
        }

        if (obj.vip_level >= 3) {
            MGC_Comm.nobleSwfInit(obj);
        }
        obj = null;
    },

    // 初始化送礼swf
    nobleSwfInit: function(obj) {

        //if(MGC_Comm.nobleSwfArray.length <= 0)
        //    return;
        //
        //var obj = MGC_Comm.nobleSwfArray[0];
        var vipLevel = obj.vip_level;
        var userName = obj.player_name;
        var userZone = obj.player_zone;
        //MGC_Comm.nobleSwfArray.splice(0,1);
        MGC_Comm.isPlayNobleSwf = true;
        var swfVersionStr = "11.1.0";
        var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
        var flashvars = {};
        flashvars.guardIcon = "http://ossweb-img.qq.com/images/mgc/css_img/flash/icon/identity_vip_lv" + vipLevel + ".png?v=3_8_8_2016_15_4_final_3";
        //防止&不能传入flash
        userName = userName.replace(/&/g,"＆");
        flashvars.userName = userName;
        if (userZone != "梦工厂") {
            flashvars.userZone = "[炫舞-" + userZone + "]";
        }
        else {
            flashvars.userZone = "[" + userZone + "]";
        }

        flashvars.isCaveolae = isCaveolae;
        var params = {};
        params.quality = "high";
        params.bgcolor = "#000";
        params.allowscriptaccess = "always";
        params.allowfullscreen = "true";
        params.allowFullScreenInteractive = "true";
        params.wmode = "transparent";
        var attributes = {};
        attributes.id = "nobleSwf";
        attributes.name = "nobleSwf";
        attributes.align = "middle";

        var swfurl = "http://ossweb-img.qq.com/images/mgc/css_img/swf/" + "noble_" + vipLevel + ".swf?v=3_8_8_2016_15_4_final_3_" + (new Date()).getTime();

        if (MGC.checkIsIEloadSwfFailed())
            swfurl += "&r=" + new Date();
        swfobject.embedSWF(swfurl, "nobleContent", "100%", "100%",
            swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
        //$m('.nobleAnimation').show();
        window.mgc.popmanager.layerControlShow($m('.nobleAnimation'), 2, 2, null, { saveFocus: true });
        obj = null;
    },

    // 高级守护入场动画
    showGuardFlash: function(userName, userZone, vipLevel, guardlevel) {
        var swfVersionStr = "11.1.0";
        var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
        var flashvars = {};
        flashvars.vipIcon = "/assets/icon/identity_vip_lv" + vipLevel + ".png?v=3_8_8_2016_15_4_final_3";
        flashvars.guardIcon = "/assets/icon/identity_guard_lv" + guardlevel + ".png?v=3_8_8_2016_15_4_final_3";
        //防止&不能传入flash
        userName = userName.replace(/&/g,"＆");
        flashvars.userName = userName;
        flashvars.userZone = "[" + $m.mZone(userZone) + "]";
        flashvars.isCaveolae = isCaveolae;
        var params = {};
        params.quality = "high";
        params.bgcolor = "#000";
        params.allowscriptaccess = "always";
        params.allowfullscreen = "true";
        params.allowFullScreenInteractive = "true";
        params.wmode = "transparent";
        var attributes = {};
        attributes.id = "nobleSwf";
        attributes.name = "nobleSwf";
        attributes.align = "middle";

        var swfurl = "/assets/" + "guard_" + guardlevel + ".swf?v=3_8_8_2016_15_4_final_3_" + (new Date()).getTime();

        if (MGC.checkIsIEloadSwfFailed())
            swfurl += "&r=" + new Date();
        swfobject.embedSWF(swfurl, "nobleContent", "100%", "100%",
            swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
        //$m('.nobleAnimation').show();
        window.mgc.popmanager.layerControlShow($m('.nobleAnimation'), 2, 2, null, { saveFocus: true });
    },

    hideNobleSwf: function() {
        window.mgc.popmanager.layerControlHide($m('.nobleAnimation'), 2, 2);
        $m('.nobleAnimation').remove();
        $m('.content').append("<div  class='nobleAnimation'>");
        $m('.nobleAnimation').hide();
        $m('.nobleAnimation').append("<p id='nobleContent'/>");
        MGC_Comm.isPlayEnterRoonmEffect = false;

        setTimeout('MGC_Comm.playEnterRoomEffect()',500);
        //MGC_Comm.playEnterRoomEffect();

        MGC_Comm.resizeGuardFlash();
    },

    //守护入场动画适配
    resizeGuardFlash:function(){
        var h = $m(".layer-video").height() - 348;
        $m('.nobleAnimation').css("top",50 + h);
        //console.log("@@@@@@@@@@@@layer-video@@@@@@@@@@@@@:height:   " + $m(".layer-video").height());
    },
    initSkinGrabFlash: function (index) {
        var swfVersionStr = "11.1.0";
        var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
        var flashvars = {};
        //flashvars.positionNum = positionNum;
        var params = {};
        params.quality = "high";
        params.bgcolor = "#000";
        params.allowscriptaccess = "always";
        params.allowfullscreen = "true";
        params.allowFullScreenInteractive = "true";
        params.wmode = "transparent";
        var attributes = {};
        attributes.id = "gif_skinGrab" + index;
        attributes.name = "gif_skinGrab" + index;
        attributes.align = "middle";

        var swfurl = "";
        swfurl = "/assets/" + "gif_skinGrab.swf?v=3_7_4_2015_34_3_" + (new Date()).getTime();

        if (MGC.checkIsIEloadSwfFailed())
            swfurl += "&r=" + new Date();
        swfobject.embedSWF(swfurl, "grabEffects_con" + index, "100%", "100%", swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
    },
    initGrabFlash: function () {
        var swfVersionStr = "11.1.0";
        var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
        var flashvars = {};
        //flashvars.positionNum = positionNum;
        var params = {};
        params.quality = "high";
        params.bgcolor = "#000";
        params.allowscriptaccess = "always";
        params.allowfullscreen = "true";
        params.allowFullScreenInteractive = "true";
        params.wmode = "transparent";
        var attributes = {};
        attributes.id = "GrabBlockAnimation";
        attributes.name = "GrabBlockAnimation";
        attributes.align = "middle";

        var swfurl = "";
        swfurl = "/assets/" + "GrabBlockAnimationPane.swf?v=3_8_8_2016_15_4_final_3_" + (new Date()).getTime();

        if (MGC.checkIsIEloadSwfFailed())
            swfurl += "&r=" + new Date();
        swfobject.embedSWF(swfurl, "vipGrabContent", "100%", "100%",swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
    },
    // VIP抢座-宝座闪烁-流星-热度宝箱-飞屏-特效动画
    showGrabFlash: function(positionNum) {
        if ($m(".side-left").attr("side_state") == 0) {
            //左侧隐藏状态下不播放动画
            return;
        }
        var swfobj = getSWF('GrabBlockAnimation');
        swfobj.showGrabAni(positionNum);
        $m('.vipGrabFlash').css('width', '260px');
        $m('.vipGrabFlash').css('height', '356px');
        if (mgc.tools.is_nest_room()) {
            $m('.vipGrabFlash').css('top', '16px');
        }
        swfobj = null;
        // window.mgc.popmanager.layerControlShow($m('.vipGrabFlash'), 2, 1, null, { saveFocus: true });
    },

    // 隐藏VIP抢座-宝座闪烁-流星-热度宝箱-飞屏-特效动画
    hideGrabBlockAnimation: function () {   
        
        $m('.vipGrabFlash').css('width', '1px');
        //房间热度条闪烁效果
        Hotbar.showHotBarEffect();        
    },
    skinShowFlashEffects: function () {
        if (SKIN.id == 1) {
            if ($m('.auto_seatVip').width() > 700) {
                $m('.grabEffectsBox').css('top', '-190px');
            } else {
                $m('.grabEffectsBox').css('top', '-107px');
            }
        } else if (SKIN.id == 2) {
            if ($m('.auto_seatVip').width() > 700) {
                $m('.grabEffectsBox').css('top', '-195px');
            } else {
                $m('.grabEffectsBox').css('top', '-103px');
            }
        } else if (SKIN.id == 3) {
            if (SKIN.level >= 7) {
                if ($m('.auto_seatVip').width() > 708) {
                    $m('.grabEffectsBox').css('top', '-199px');
                } else {
                    $m('.grabEffectsBox').css('top', '-107px');
                }
            } else {
                if ($m('.auto_seatVip').width() > 708) {
                    $m('.grabEffectsBox').css('top', '-159px');
                } else {
                    $m('.grabEffectsBox').css('top', '-107px');
                }
            }
        }
    },
    // 换肤抢座-----------VIP抢座-宝座闪烁-流星-热度宝箱-飞屏-特效动画
    showSkinGrabFlash: function (positionNum) {
        clearTimeout(Hotbar.timeid);
        MGC_Comm.skinShowFlashEffects();
        var swfobj = getSWF("gif_skinGrab" + positionNum);
        swfobj.showGrabAni(positionNum);
        swfobj = null;
    },    
    // 换肤抢座-----------隐藏VIP抢座-宝座闪烁-流星-热度宝箱-飞屏-特效动画
    hideSkinGrabBlockAnimation: function () {         
        //房间热度条闪烁效果
        Hotbar.showHotBarEffect();
        //房间热度条闪烁效果   
    },    
    moveGrabFlash: function () {
        // return;
        //$m('.grabEffectsBox').css('display', 'none');
        if ((SKIN.id == 3 && $m('.auto_seatVip').width() > 708) || (SKIN.id != 3 && $m('.auto_seatVip').width() > 700)) {
            $m('.grabEffectsBox').css('top', '-90px');
        } else {
            $m('.grabEffectsBox').css('top', '-5px');
        }
        //$m('.grabEffectsBox').css('display', 'block');
    },
    //缩回去的抢座
    //初始化缩回去抢座特效
    initSkinShrinkGrabFlash: function () {
        var swfVersionStr = "11.1.0";
        var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
        var flashvars = {};
        //flashvars.positionNum = positionNum;
        var params = {};
        params.quality = "high";
        params.bgcolor = "#000";
        params.allowscriptaccess = "always";
        params.allowfullscreen = "true";
        params.allowFullScreenInteractive = "true";
        params.wmode = "transparent";
        var attributes = {};
        attributes.id = "shrinkGrabSeat";
        attributes.name = "shrinkGrabSeat";
        attributes.align = "middle";

        var swfurl = "";
        swfurl = "/assets/" + "shrinkGrabSeat.swf?v=3_7_4_2015_34_3_" + (new Date()).getTime();

        if (MGC.checkIsIEloadSwfFailed())
            swfurl += "&r=" + new Date();
        swfobject.embedSWF(swfurl, "shrinkGrabSeat", "100%", "100%", swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
    },
    // 缩回去-显示-换肤抢座-----------VIP抢座-宝座闪烁-流星-热度宝箱-飞屏-特效动画
    showSkinShrinkTimer:null,
    showSkinShrinkGrabSeat: function () {
        if ($m('.auto_seatVip').width() == 321) {
            if (SKIN.id != 3) {
                $m('.shrinkGrabSeat').css('margin-top', '-109px');
            } else {
                $m('.shrinkGrabSeat').css('margin-top', '-123px');
            }
        }
        $m('.shrinkGrabSeat').css('display', 'block');
        clearTimeout(MGC_Comm.showSkinShrinkTimer);
        MGC_Comm.showSkinShrinkTimer=setTimeout(MGC_Comm.hideSkinShrinkGrabSeat, 1000);

    },

    // 缩回去-隐藏-换肤抢座-----------隐藏VIP抢座-宝座闪烁-流星-热度宝箱-飞屏-特效动画
    hideSkinShrinkGrabSeat: function () {

        //房间热度条闪烁效果
        $m('.shrinkGrabSeat').css('display', 'none');     
        //房间热度条闪烁效果
        Hotbar.showHotBarEffect();
        //房间热度条闪烁效果
        // $m('.grabEffectsBox').css('width', '1px');
        // $m('.auto_seatVip .sv_list .grabEffectsBox li .grabEffects,.auto_seatVip .sv_list .grabEffectsBox li').css('width', '1px');
    },

    // 全屏礼物效果播放完毕
    fullGiftEffectPlayOver: function() {
        //console.log('EffectOver  ---  fullGiftEffectPlayOver');
        var swfobj = getSWF('GiftSwf');
        try {
            swfobj.fullGiftEffectPlayOver();
        } catch (e) {
            console.log(e.message);
        }
        swfobj = null;
    },

    // 显示礼物效果
    showGiftEffect: function(data) {
        var swfVersionStr = "11.1.0";
        var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
        var flashvars = {};
        var params = {};
        params.quality = "high";
        params.bgcolor = "#000";
        params.allowscriptaccess = "always";
        params.allowfullscreen = "true";
        params.allowFullScreenInteractive = "true";
        params.wmode = "transparent";
        var attributes = {};
        attributes.id = "gifteffectswf";
        attributes.name = "gifteffectswf";
        attributes.align = "middle";

        var swfurl;

        if (MgcAPI.SNSBrowser.IsQQGame() || MgcAPI.SNSBrowser.IsX52())
        {
            swfurl = data.path + "?v=3_8_8_2016_15_4_final_3";
        }
        else
        {
            swfurl = data.path + "?v=3_7_4_2015_34_3_" + (new Date()).getTime();
        }

        if (MGC.checkIsIEloadSwfFailed())
            swfurl += "&r=" + new Date();
        swfobject.embedSWF(swfurl, "gifteffectContent", "100%", "100%",
            swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
        //$m('.gifteffectflash').show();

        /*
        if(filename == "showroom.shtml")
        {
            $m('.gifteffectflash').css("top", $m("#LiveVideoSwfContainer").offset().top + 80);
        }
        else
        {
            $m('.gifteffectflash').css("top", $m("#LiveVideoSwfContainer").offset().top);
        }


        $m('.gifteffectflash').css("left", $m("#LiveVideoSwfContainer").offset().left);
         */
        
        window.mgc.popmanager.layerControlShow($m('.gifteffectflash'), 2, 2, null, { saveFocus: true });
    },
    // 隐藏礼物效果
    hideGiftEffect: function() {
        $m('.gifteffectflash').remove();

        //区分演唱会和直播间标签
        if (MGCData.isConcert) {
            $m('.video_flash').append('<div class="gifteffectflash" style="display: none"></div>');
        }
        else {
            $m('.video_flash').append('<div class="gifteffectflash" style="display: none"></div>');
        }

        $m('.gifteffectflash').append("<p id='gifteffectContent'></p>");

        MGC_Comm.resizeGiftEffect();
    },

    //恶魔动画适配
    resizeGiftEffect: function(){

        $m('.gifteffectflash').css("top", $m(".video_flash").height() - $m('.gifteffectflash').height());
        //$m('.gifteffectflash').css("left", $m("#LiveVideoSwfContainer").offset().left);
    },

    //是否正在播放主播经验动画
    isPlayExpEffect: false,
    //主播经验特效队列
    expEffect: [],

    // 增加主播经验特效
    addExpEffect: function(exp) {
        if(!mgc.tools.is_show_room())return;
        MGC_Comm.expEffect.push(exp);
        if (!MGC_Comm.isPlayExpEffect) {
            MGC_Comm.playExpEffect();
        }
    },

    // 播放主播经验特效
    playExpEffect: function() {
        if (MGC_Comm.expEffect.length == 0 || MGC_Comm.isPlayExpEffect) return;

        MGC_Comm.isPlayExpEffect = true;
        var exp = MGC_Comm.expEffect.shift();

        MGC_Comm.showExpEffect(exp);
    },

    // 显示主播经验效果
    showExpEffect: function(exp) {
        var swfVersionStr = "11.1.0";
        var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
        var flashvars = {};
        flashvars.exp = exp;
        var params = {};
        params.quality = "high";
        params.bgcolor = "#000";
        params.allowscriptaccess = "always";
        params.allowfullscreen = "true";
        params.allowFullScreenInteractive = "true";
        params.wmode = "transparent";
        var attributes = {};
        attributes.id = "expeffectswf";
        attributes.name = "expeffectswf";
        attributes.align = "middle";

        var swfurl = "http://ossweb-img.qq.com/images/mgc/css_img/video_room/exp_effect.swf?v=3_8_8_2016_15_4_final_3_";

        if (MGC.checkIsIEloadSwfFailed())
            swfurl += "&r=" + new Date();
        swfobject.embedSWF(swfurl, "expeffectContent", "100%", "100%",
            swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
        $m('.expeffectflash').show();
    },
    // 隐藏主播经验效果
    hideExpEffect: function() {
        $m('.expeffectflash').remove();
        $m('.sl_info').append('<div class="expeffectflash" style="display: none"></div>');
        $m('.expeffectflash').append("<p id='expeffectContent'></p>");

        MGC_Comm.isPlayExpEffect = false;
        MGC_Comm.playExpEffect();
    },

    // 初始化上传头像swf
    AvatarSwfInit: function() {
        var swfUrl = "upimage.swf?v=3_8_8_2016_15_4_final_3";
        var swfVersionStr = "11.1.0";
        var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
        var flashvars = {};
        var params = {};
        params.quality = "high";
        params.bgcolor = "#000";
        params.allowscriptaccess = "always";
        params.allowfullscreen = "true";
        params.allowFullScreenInteractive = "true";
        params.wmode = "opaque";
        var attributes = {};

        attributes.id = "AvatarSwf";
        attributes.name = "AvatarSwf";
        attributes.align = "middle";
        if (MGC.checkIsIEloadSwfFailed())
            swfUrl += "&r=" + new Date();
        swfobject.embedSWF(swfUrl, "AvatarFlashContent", "100%", "100%",
            swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
    },

    Dologout: function(type, i) {
        try {
            EAS.SendClick({ 'e_c': 'mgc.logout', 'c_t': 4 });
        } catch (e) {

        }
        if (i == 1) {
            showDialog.hide();
        }
        if(type==0){            
            $m.cookie("mgc_login_succeed_uin", null, {
                path: '/',
                domain: '.qq.com'
            });
            $m("#reminder").fadeOut();
            MGC_Comm.logFirstTrue = false;
            
        }

        MGC_Comm.commonGetUin(function (_uin) {
            $m.cookie("mgc_login", null, { path: '/', domain: 'mgc.qq.com' });
            $m.cookie("IED_LOG_INFO2", null, { path: '/', domain: '.qq.com' });
            $m('.nd').hide();
            $m.cookie("mgc_logingifts_" + _uin + "_" + $m.cookie("mgcZoneId"), null, {
                path: '/',
                domain: '.qq.com'
            });

            if (type !== 999 && (filename == "liveroom.shtml" || filename == "showroom.shtml" || filename == "caveolaeroom.shtml" || filename == "nest.shtml")) {
                var NoteObj = {
                    "Note": "退出登录后会退出当前视频房间并且回到首页，您确认要更换登录状态吗？",
                    "BtnNum": 2
                };
                MGC_Comm.CommonDialog(NoteObj, function() {
                    MGC_Comm.commonLogout(function() {
                        //请求退出操作
                        MGC_Comm.afterLogout(1);
                    });
                });
            } else if (filename == "act.shtml" || filename == "personal.shtml" || filename == "group.shtml") {
                //无论是否是因为权限退登的，都会回到首页
                MGC_Comm.commonLogout(function() {
                    //请求退出操作
                    MGC_Comm.afterLogout(1);
                });
            } else if (filename == "ticket.shtml") {//这里是不需要回到首页的
                MGC_Comm.commonLogout(function() {
                    //请求退出操作
                    var _reqStr = "{\"op_type\":171}";
                    MGC_Comm.sendMsg(_reqStr);
                    MGC_Comm.DoClear();
                });
            } else {
                MGC_Comm.commonLogout(function() {
                    MGC_Comm.afterLogout(0);
                });
            };
        });
    },

    DoClear: function() {
        var _reqStr = "{\"op_type\":179}";
        MGC_Comm.sendMsg(_reqStr);
    },

    log: function(str, obj) {
        /*console.log(str);
        console.log(obj);*/
    },

    LoginHb: function(LoginHbKey) {
        var _url = "http://apps.game.qq.com/mgc/index.php?m=LoginHb&LoginHbKey=" + LoginHbKey + "&t=" + Math.random();
        MGC_Comm.ajax(_url, function(data) {
            //MGC_Comm.log("续期返回", data.data);
            if (data.ret_code == 0) {
                var _data = data.data;
                $m.cookie("mgc_login", _data.mgc_login, {
                    expires: 60,
                    path: '/',
                    domain: 'mgc.qq.com'
                });
            };
        });
    },

    HideAndClear: function(obj) {
        var pop = $m(obj).parents('.pop');
        if (pop.has('ul').length > 0) {
            pop.find('ul').hide();
        }
        if (pop.has('textarea').length > 0) {
            pop.find('textarea').val('');
        }
        showDialog.hide();
    },

    //中英文字符串长度
    Strlen: function(str,limit) {
        var len = 0;
        MGC_Comm.strEndIndex = 0;
        for (var i = 0; i < str.length; i++) {
            var c = str.charCodeAt(i);
            //单字节加1 
            if ((c >= 0x0001 && c <= 0x007e) || (0xff60 <= c && c <= 0xff9f)) {
                len++;
            } else {
                len += 2;
            }

            if(limit && len <= limit)
            {
                MGC_Comm.strEndIndex++;
            }
        }
        return len;
    },

    Strcut: function(str, len) {
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
            }
            else if (str_length == len) {
                str_cut = str_cut.concat(a);
                return str_cut;
            }
            str_cut = str_cut.concat(a);
        }
        //如果给定字符串小于指定长度，则返回源字符串；  
        if (str_length < len) {
            return str;
        }
    },

    backupInvitationBoxPopUp: function(DialogObj) {
        var isNotOnlyOpen = false;
        if (!arguments[3]) {
            isNotOnlyOpen = true;
        }

        $m('#backupInvitationTitleP').html("后援团邀请");
        $m('#backupInvitationNoteP').html(DialogObj.player_name +  "邀请您加入" + DialogObj.vgname + "，是否接受并加入后援团？");

        $m('#seeSupportGroup').unbind('click').click(function() {
            MGC_CommRequest.getbackupGroupCard(DialogObj.vgid);
        });

        $m('#backupInvitationConfirmBtn').unbind('click').click(function() {
            MGC_Comm.refuseIinvite(DialogObj.vgid, 1);
        });
        $m('#backupInvitationCancelBtn').unbind('click').click(function() {
            MGC_Comm.refuseIinvite(DialogObj.vgid, 2);
        });
        $m('#backupInvitationCloseBtn').unbind('click').click(function() {
            MGC_Comm.refuseIinvite(DialogObj.vgid, 0);
        });

        //if (isNotOnlyOpen)
        //    $m("#backupInvitation").css("z-index", 9998).show();
        if (isNotOnlyOpen)
        {
            //   设定一个cookie到主播名片判断是否有打开
            $m.cookie("mgc_invite_click",1 , {
                path: '/',
                domain: '.qq.com'
            });
            $m('#backupInvitation').centerDisp();
            window.mgc.popmanager.layerControlShow($m('#backupInvitation'), 4, 1, 2);
        }
        MGC_Comm.countdownId = setInterval(MGC_Comm.invitationCountdown, 1000);
    },
    refuseIinvite: function(vgid, is_agree) {
        var _reqStr = { "op_type": 74, "is_agree": is_agree, "vgid": vgid };
        $m.cookie("mgc_invite_click", null, {
            path: '/',
            domain: '.qq.com'
        });
        MGC_Comm.sendMsg(_reqStr);
        MGC_Comm.clearInvitationPopUp();
    },
    backupInvitationCallBack: function(obj) {
        var objLabel = {};
        objLabel.Title = "提示";

        if (obj.accept) {
            objLabel.Note = "邀请成功，" + obj.player_name + "已加入您的后援团~";
            MGC_Comm.CommonDialog(objLabel);
        }
        else {
            objLabel.Note = obj.player_name + "拒绝了您的邀请。";
            MGC_Comm.CommonDialog(objLabel);
        }
    },

    clearInvitationPopUp: function() {
        MGC_Comm.countdownNum = 120;
        //$m("#backupInvitation").hide();
        //$m("#overlay_CommonDialog_backupInvitation").hide();
        window.mgc.popmanager.layerControlHide($m('#backupInvitation'), 4, 1);
        clearInterval(MGC_Comm.countdownId);
    },

    /*
        邀请倒计时
     */
    invitationCountdown: function() {
        MGC_Comm.countdownNum--;
        if (MGC_Comm.countdownNum == 0) {
            MGC_Comm.clearInvitationPopUp();
            return;
        }
        $m('#countdown').html("倒计时：" + MGC_Comm.countdownNum + "秒");
    },

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
    CommonDialog: function(DialogObj, _callback, _callback2, isNotOnlyOpen, isCloseAll) {
        //use the new code
        mgc.tools.commonDialog(DialogObj, _callback, _callback2, isNotOnlyOpen, isCloseAll);
        return;
        $m('#ConfirmBtn,#CancelBtn,#CloseBtn').off("click");
        if (!arguments[3]) {
            isNotOnlyOpen = true;
        }
        if (!arguments[4]) {
            isCloseAll = false;
        }
        if (DialogObj.Title) {
            $m('#TitleP').html(DialogObj.Title);
        };
        if (DialogObj.Note) {
            $m('#NoteP').html(DialogObj.Note);
        };

        $m('#CancelBtn').html("取消").hide();

        if (DialogObj.BtnName) {
            $m('#ConfirmBtn').html(DialogObj.BtnName);
        } else {
            $m('#ConfirmBtn').html("确定");
        };
        if (isNotOnlyOpen) {
            $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(" + isCloseAll + ");");
            $m('#CloseBtn').attr("href", "javascript:MGC_Comm.hideDialog(" + isCloseAll + ");");
            $m('#CancelBtn').attr("href", "javascript:MGC_Comm.hideDialog(" + isCloseAll + ");");
        } else {
            $m('#ConfirmBtn').attr("href", "javascript:showDialog.hide();");
            $m('#CloseBtn').attr("href", "javascript:showDialog.hide();");
            $m('#CancelBtn').attr("href", "javascript:showDialog.hide();");
        }
        if (typeof _callback == "function") {            
            $m('#ConfirmBtn').one("click", function(){
                _callback();    
            });
        }

        if (typeof _callback == "string") {
            $m('#ConfirmBtn').attr("href", "javascript:" + _callback + "();");
        };

        if (DialogObj.url != undefined && DialogObj.url != "") {
            $m('#ConfirmBtn').attr("href", DialogObj.url);
            $m('#ConfirmBtn').attr("target", "_blank");
        };
        //$m('#CloseBtn').attr("href", "javascript:showDialog.hide();");
        if (DialogObj.BtnNum > 1) {
            if (DialogObj.BtnName2) {
                $m('#CancelBtn').html(DialogObj.BtnName2);
            };
            $m('#CancelBtn').show();
            //避免弹窗中取消按钮显示错误
            $("#CancelBtn").css("display", "inline-block");
            if (typeof _callback2 == "function") {
                $m('#CancelBtn,#CloseBtn').one("click", function(){
                    _callback2();    
                });
            };

            if (typeof _callback2 == "string") {
                $m('#CancelBtn').attr("href", "javascript:" + _callback2 + "();");
                $m('#CloseBtn').attr("href", "javascript:" + _callback2 + "();");
            };
        } else {
            $m('#CancelBtn').hide();

            if (typeof _callback == "function") {
                $m('#CloseBtn').one("click", function(){
                    _callback();    
                });
            };

            if (typeof _callback == "string") {
                $m('#CloseBtn').attr("href", "javascript:" + _callback + "();");
            };
        };

        /*输入框光标移出*/
        $m('#SendMsgChatBox').blur();
        window.mgc.popmanager.layerControlShow($m("#CommonDialog"), 5, 1, 1);

        DialogObj = null;
    },
    hideDialog: function(isCloseAll) {
        //use the new code
        mgc.tools.hideDialog(isCloseAll);
        return;
        if (isCloseAll)
            showDialog.hide();
        $m('#ConfirmBtn,#CancelBtn,#CloseBtn').off("click");
        window.mgc.popmanager.layerControlHide($m("#CommonDialog"), 5, 1);
    },

    ChangeClass: function(Id, className) {
        if (typeof (Id) == "string") {
            $m('#' + Id).toggleClass(className);
        } else {
            $m(Id).toggleClass(className);
        };

    },

    ChangeLogin: function(resp) {
        console.log("检测到您的登录状态异常，请重新登录   old :" + JSON.stringify(resp));
        var NoteObj = {};
        if (resp.res == 1) {
            NoteObj.Note = "哎呀，程序哥哥发呆了，快去刷新重试吧";
        } else if (resp.res == 2) {
            NoteObj.Note = "您的登录状态发生了异常，需要重新登录哦";
        } else if (resp.res == 3) {
            NoteObj.Note = "世界那么大，程序哥哥出门散步了~亲！需要刷新重试哦";
        } else {
            NoteObj.Note = "检测到您的登录状态异常，请重新登录";
        }
        if ((MgcAPI.SNSBrowser.IsQQGameLiveArea() == 'true') && (resp.res != 1) && (resp.res != 3)) {
            //检测登录异常时，清除缓存
            mgc.account.hasSkey = false;
            mgc.account.logout();
            mgc.account.clear_cookie();
            mgc.comm_model.getLoginBarModel.toggle(false);
            mgc.callcenter.query_clear_login_cookie(function() {
                console.log("cookie cleared!");
                var myTime = new Date();
                var filename = window.location.href;
                mgc.tools.cookie("mgc_logError_qqaccount_checkLoginCallback", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___Test-the-login-state-expired___web--qqaccount_checkLoginCallback-islogin-false___filename" + filename, {
                    path: '/',
                    domain: '.qq.com'
                });
            });
            MGC_Comm.CommonDialog(NoteObj, function() {
                $("#login-bar-btn").click();
            });
        } else {
            MGC_Comm.CommonDialog(NoteObj, function() {
                /*window.location.href = home + "?isLogin=1";*/
                window.location.href = window.mgc.tools.changeUrlToLivearea(home);
            });
        }
    },

    getRemainDate: function(remainTime) {
        if (remainTime <= 0) return false;
        var _myVipDuration;
        _myVipDuration = Math.ceil(remainTime / 86400);
        _myVipDuration = _myVipDuration + '天';
        return _myVipDuration;
    },

    // 加载飞屏swf
    setFlyScreenSwfObj: function() {
        var swfVersionStr = "11.1.0";
        var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
        var flashvars = {};
        flashvars.isConcert = MGCData.isConcert;
        var params = {};
        params.quality = "high";
        params.bgcolor = "#000";
        params.allowscriptaccess = "always";
        params.allowfullscreen = "true";
        params.allowFullScreenInteractive = "true";
        params.wmode = "transparent";
        // params.wmode = "gpu";
        var attributes = {};

        attributes.id = "FlyMessageModule";
        attributes.name = "FlyMessageModule";
        attributes.align = "middle";
        var swfurl = "/assets/FlyMessageModule.swf?v=3_8_8_2016_15_4_final_3";

        if (MGC.browser().ie7 || MGC.browser().qqbrowser) {
            swfurl += "&r=" + Math.random();
        }
        //FlyScreenSwfContainer 页面上有对应的div
        swfobject.embedSWF(swfurl, "flyScreenContent", "100%", "100%",
            swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
        MGC_Comm.isFlyLayerOpened = false;
    },
    isFlyLayerOpened:false,
    // 重置飞屏组件大小
    showFlyScreenSwf: function () {
        if (MGC_Comm.isFlyLayerOpened) {
            var $flyScreenContent = $m('.flyScreen');

            $flyScreenContent.css('width','100%');
            $flyScreenContent.css('pointer-events', 'none');
            if (MGCData.isConcert) {
                $flyScreenContent.height(250);
            } else {
                $flyScreenContent.height(250);
            }
            $flyScreenContent.show();
            //window.mgc.popmanager.layerControlShow($flyScreenContent, 2, 3);
        }
    },
    // 添加一个补刀王的飞屏
    addLastKingFlyScreenMsg: function(resp, params){
        var data = {};
        data.senderName = resp.nickName;
        data.senderdefend = resp.guardLevel;
        data.viplevel = resp.vipLevel;
        data.wealth_level = resp.wealthLevel;
        data.isTakeVip = false;
        data.isSelf = 3;
        data.lastKing = true;
        var playerId = resp.player_pstid;
        if(resp.invisible){
            if(MGCData.myPlayerId != resp.playerPstid){
                data.senderName = "神秘土豪";
                data.senderdefend = 0;//resp.guardLevel;
                data.viplevel = 0;//resp.vipLevel;
                data.wealth_level = 0;//resp.wealthLevel;
            }
        }
        data.MsgStr = resp.text; //测试数据，需要改成服务器传过来的数据 resp.msgStr

        data.chatnodes = [];
        data.chatnodes[0] = {"content": data.MsgStr, "nodeType": 0};
        data.src = 1;
        MGC_Comm.addFlyScreenMsg(data, true);
        resp = null;
        data = null;
    },
    // 添加一个开通贵族的飞屏
    addOpenVIPFlyScreenMsg: function (resp, params) {
        //player_name, vip_level, wealth_level, anchor_name
        var data = {};
        data.senderName = resp.player_name;
        data.senderdefend = 0;
        data.viplevel = resp.vip_level;
        data.wealth_level = resp.weath_level;
        data.isTakeVip = false;
        data.isSelf = 0;
        if (resp.vip_level > 3) {
            data.MsgStr = "立刻变身【"+window.mgc.consts.vipLevelTab[resp.vip_level]+"】独宠【"+ resp.anchor_name +"】，后宫三千佳丽，请默默哭泣~";
        } else {
            data.MsgStr = "立刻变身【"+window.mgc.consts.vipLevelTab[resp.vip_level]+"】宠幸了【"+ resp.anchor_name +"】";
        }
        data.chatnodes = [];
        data.chatnodes[0] = {"content": data.MsgStr, "nodeType": 0};
        data.src = 1;
        MGC_Comm.addFlyScreenMsg(data, false);
        resp = null;
        data = null;
    },
    //添加飞屏
    addFlyScreenMsg: function (data, isDef) {
        //width:100%; height:630px;
        var swfobj = getSWF('FlyMessageModule');
        
        if (MGC_Comm.isFlyLayerOpened == false) {
            MGC_Comm.isFlyLayerOpened = true;
            MGC_Comm.showFlyScreenSwf();
            swfobj.openModule(MGCData.isConcert);
        }
        data.MsgStr = data.MsgStr.replace(/&lt/g, "<");
        data.MsgStr = data.MsgStr.replace(/&gt/g, ">");
        data.MsgStr = data.MsgStr.replace(/&nbsp/g, " ");
        swfobj.addFlyScreenMsg(data, isDef);
        data = null;
        swfobj = null;
    },
    //添加火箭飞屏
    addRocketScreenMsg: function (data) {
        if (MGC_Comm.isFlyLayerOpened == false) {
            MGC_Comm.isFlyLayerOpened = true;
            MGC_Comm.showFlyScreenSwf();
        }
        var $flyScreenContent = $m('.flyScreen');
        $flyScreenContent.css('pointer-events', '');
        // window.mgc.popmanager.layerControlShow($flyScreenContent, 2, 3);
        var swfobj = getSWF('FlyMessageModule');
        if(data.invisible){
            if(data.player_id != MGCData.myPlayerId){
                data.player_name = "神秘土豪";
                data.guard_level = 0;
                data.vip_level = 0;
                data.wealth_level = 0;
            }
        }
        swfobj.addRocketScreenMsg(data);
        data = null;
        $flyScreenContent = null;
        swfobj = null;
    },
    onRocketScreenMsgClick: function (room_id) {
        //是否游客
        if (MGC_Comm.CheckGuestStatus(false)) return;
        
        if(room_id != MGCData.roomID)
        {
            // 新需求所有跳转都在当前页进行。--XW80582
            // location.href = "transfer.shtml?roomId=" + room_id + "&source=8";
            // if(MgcAPI.SNSBrowser.IsQQGame() || MgcAPI.SNSBrowser.IsX52())
            // {
            window.open("transfer.shtml?roomId=" + room_id + "&source=8&param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea(), "_self&module_type=0&page_capacity=20&room_list_pos=0");
            // }
            // else{
            //     window.open("transfer.shtml?roomId=" + room_id + "&source=8");
            // }
        }
    },
    hideFlyScreenSwf: function () {
        MGC_Comm.isFlyLayerOpened = false;
        var $flyScreenContent = $m('.flyScreen');
        $flyScreenContent.width(1);
        $flyScreenContent.height(1);
    },
    closeRocketPolicy: function() {
        var $flyScreenContent = $m('.flyScreen');
        $flyScreenContent.css('pointer-events', 'none');
    },

    // 通知当前房间中所有移动管理员的pstid信息: 333(62125)
    notifyAllUserAdmin: function(resp, params){
        console.log("通知当前房间中所有移动管理员的pstid信息 allUserAdmins = " + resp.res);
        allUserAdmins = [];
        allUserAdmins = resp.res;
    },

    /**
     * 下发宝箱开启的差值,活动标题和内容
     * @param  
     * diffValue: []
     * title: ""
     * content: ""
     */
    notifySecretHeatBoxInfo: function(resp, params){
        mgc.consts.lastKingNeedData = resp.diffValue;
        mgc.secretOrderModel.set("hoverTipsTitle", resp.title);
        mgc.secretOrderModel.set("hoverTipsContent", resp.content);
    },

    /**
     * 广播补刀王飞屏
     * realLogin:守护等级 wealthLevel:财富等级 vipLevel: vip等级
     * zoneName:大区名    nickName:昵称        text:内容 
     * hasPortrait:是否有头像 playerPstid补刀王id
     */
    WhistleLastHitPlayer: function(resp, params){

    }
};
//申请游客账号回调
MGC_CommResponse.RegisterGuestCardCallBack = function(obj) {
    console.log("申请游客账号回调：" + JSON.stringify(obj));
    if (obj.res == 0) {
        //成功 login
        //种下游客cookie
        MGC_Comm.SetGuestCookie(obj);
        MGCLoginRequest.areaLogin(MGCData.mgcZoneId);
    } else {
        //失败
        console.log("申请游客账号失败!!!!!!!!!!");
    }
}
//获取正常玩家缓存
MGC_CommResponse.getAsCacheCallBack = function(obj) {
    obj = MGC_Comm.strToJson(obj);
    if (obj.hasCookie == true && obj.sameQQ) {
        MGCLoginRequest.doLogin(obj.zoneid);
    } else {
        // 请求服务区列表接口，弹出来选择框
        try {
            EAS.SendClick({ 'e_c': 'mgc.poparea', 'c_t': 4 });
        }
        catch (e) {

        }

        MGCLoginRequest.roleList();
    };
}
//获取游客身份缓存
MGC_CommResponse.getAsGuestCacheCallBack = function(obj) {
    console.log("游客缓存回调204：" + JSON.stringify(obj));
    obj = MGC_Comm.strToJson(obj);
    if (obj.hasCookie) {//有cookie 走-2
        MGC_Comm.SetGuestCookie(obj);
        MGCLoginRequest.doLogin(MGCData.mgcZoneId);
    } else {
        MGCLoginRequest.areaLogin(MGCData.mgcZoneId, "AreaLoginGuestCallBack");
    }
}
/*
// 名片信息回调
MGC_CommResponse.CardInfoCallBack = function(responseStr) {
    console.log("名片信息回调：" + JSON.stringify(responseStr));
    var repStr = MGC_Comm.strToJson(responseStr);
    var _res = parseInt(repStr.res),
        _infoHtml = '';
    if (_res == 0) {
        var _card_info = repStr.playerinfo,
            _followed_anchors = _card_info.followinfo_vec,
            followedTmpl = $m('#followedTmpl'),
            followedContainer = $m('#followedContainer'),
            vipIcon = '',
            _vipLevel = _card_info.vip_level,
            _avatar = _card_info.photo_url;
        if (_avatar == '') {
            if (parseInt(_card_info.sex_male) == 0) {
                _avatar = 'http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_female.png?v=3_8_8_2016_15_4_final_3';
            } else {
                _avatar = 'http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_male.png?v=3_8_8_2016_15_4_final_3';
            }
        }
        $m('#login_qq_face').attr('src', _avatar);
        if (_vipLevel > 0) {
            vipIcon = '<i class="icon_honor icon_honor' + _vipLevel + '"></i>';
            $m('.logined_status').show();
            MGCData.invisible = _card_info.invisible;
            if (_card_info.invisible == true) {
                $m('.logined_status strong').attr('class', 'icon1').html('隐身');
                $m('.logined_status li').attr('class', 'icon0').html('在线');
            } else {
                $m('.logined_status strong').attr('class', 'icon0').html('在线');
                $m('.logined_status li').attr('class', 'icon1').html('隐身');
            }
        }
        _infoHtml = '<ul>\
                            <li>等级：LV' + _card_info.video_level + '</li>\
                            <li class="r">梦幻币：' + _card_info.video_dream_money + '<i class="icon_mhb"></i></li>\
                            <li>财富：<strong onmouseover=MGC.suswTips6(event,1,"财富值:' + _card_info.video_wealth + '");  onmouseout="MGC.suswTips6(event,0);">LV' + _card_info.wealth_level + '<i class="wealth_level_' + _card_info.wealth_level + '"></i></strong></li>\
                            <li class="r">炫豆：' + _card_info.video_money_balance + '<i class="icon_xd"></i></li>\
                            <li>贵族：' + vipLevelTab[_vipLevel] + ' ' + vipIcon + '</li>\
                            <li class="r l">大区：' + (_card_info.zone_name = !"" ? (_card_info.zone_name == "梦工厂" || _card_info.zone_name.indexOf("QQ游戏") >= 0 ? _card_info.zone_name : "炫舞-" + _card_info.zone_name) : "") + '</li>\
                        </ul>';
        var aclen = _followed_anchors.length;
        if (aclen > 0) {
            followedContainer.show().next().hide();
            followedContainer.children().remove();
            followedTmpl.tmpl(_followed_anchors).appendTo(followedContainer);
        } else {
            followedContainer.hide().next().show();
        }
        MGCData.myVipLevel = _vipLevel;
        MGCData.myPlayerId = _card_info.pstid;
        $m('#i_player_name').html(_card_info.nick);
        $m('#i_card_info').html(_infoHtml);
        $m(".icon_mhb").hover(function(e) {
            var _e = e.target == undefined ? e.toElement : e.target;
            var t = _e.offsetTop - 28;
            var l = _e.offsetLeft + 30;

            //$m('.mhb_tips_login').show();
            susTips = $m('.mhb_tips_login');
            susTips.css({ "top": t, "left": l });
            window.mgc.popmanager.layerControlShow(susTips, 1, 3);
        }, function() {
            susTips = $m('.mhb_tips_login');
            //$m('.mhb_tips_login').hide();
            window.mgc.popmanager.layerControlHide(susTips, 1, 3);
        });
        $m(".icon_xd").hover(function(e) {
            var _e = e.target == undefined ? e.toElement : e.target;
            var t = _e.offsetTop - 28;
            var l = _e.offsetLeft + 30;
            susTips = $m('.xd_tips_login');
            susTips.css({ "top": t, "left": l });
            //$m('.xd_tips_login').show();
            window.mgc.popmanager.layerControlShow(susTips, 1, 3);
        }, function() {
            susTips = $m('.xd_tips_login');
            //$m('.xd_tips_login').hide();
            window.mgc.popmanager.layerControlHide(susTips, 1, 3);
        });
    } else if (_res == 3) {
        //异常
        MGC_Comm.Dologout(0);

        var DialogObj = {};
        DialogObj.Note = "程序大叔手滑没拉取到您的信息~~>_<~~快进入游戏内梦工厂任意房间，再回来看我哟 (づ￣3￣)づ";
        MGC_Comm.CommonDialog(DialogObj);
    } else {
        MGC_Comm.Dologout(0);
        alert('抱歉，网络繁忙，请稍候再试。');
    }
};*/
//通过147回调、检测首登签到状态
MGC_CommResponse.CardInfoForSignCallBack = function(responseStr) {
    console.log("名片信息回调for首登、签到：" + JSON.stringify(responseStr));
    if (responseStr.playerinfo.zone_name != '梦工厂') {
        $m('#web_tab').css('display', 'block');
    }
    if (responseStr.res == 0) {
        //每天只弹出一次  记录cookie
        
        
        //如果是首页 首登、签到自动弹出
        if (filename == "" || filename.indexOf("index.shtml") == 0 || filename.indexOf("liveroom.shtml") == 0 || filename.indexOf("caveolaeroom.shtml") == 0 || filename.indexOf("nest.shtml") == 0 || filename.indexOf("showroom.shtml") == 0 || filename.indexOf("show.shtml") == 0 || filename.indexOf("ranklist.shtml") == 0) {
            
            if ($m.cookie("mgc_login_succeed_uin") == null) {

                MGC_CommRequest.checkIsFirstLogin(true);//检查是否首登
                $m.cookie("mgc_login_succeed_uin", new Date().format("yyyy-MM-dd"), {
                    path: '/',
                    domain: '.qq.com'
                });
            } else {
                MGC_CommRequest.checkIsFirstLogin(false);
            }
           
            MGC_Comm.commonGetUin(function (_uin) {
                //今日是否已经自动弹出首登界面
                if ($m.cookie("mgc_logingifts_" + _uin + "_" + $m.cookie("mgcZoneId")) != new Date().format("yyyy-MM-dd")) {
                    //null
                }
                    //如果首登未通过的情况下，执行签到
                else {
                    //今日是否已经自动弹出签到界面
                    if ($m.cookie("mgc_sign_" + _uin + "_" + $m.cookie("mgcZoneId")) != new Date().format("yyyy-MM-dd")) {
                        MGC_CommRequest.checkSign(true);
                    } else {
                        MGC_CommRequest.checkSign(false, true);
                    }
                }
            });
        } else {
            MGC_CommRequest.checkIsFirstLogin(false);//检查是否首登  此处用于服务端做统计
            MGC_CommRequest.checkSign(false, true);
        }
    }
};
//是否有未领奖任务
MGC_CommResponse.hasActCallBack = function(obj) {
    obj = MGC_Comm.strToJson(obj);
    if (obj.count > 0) {
        $m('.logined_nav').find('b').show();
    } else {
        $m('.logined_nav').find('b').hide();
    };
}
MGC_CommResponse.timer=null;
//任务中心-提示引导
MGC_CommResponse.taskCenterGuide = function () {
    
    $('.logined_nav,#h-nav .nav6').find('b').show();
    clearTimeout(MGC_CommResponse.timer);
    $m('#reminder').fadeIn();
    $m('#reminder .close').off('click').on('click', function () {
        $m("#reminder").fadeOut();
    })
    MGC_CommResponse.timer = setTimeout('$m("#reminder").fadeOut();', 30000);

}

//冠名弹框队列
var giftRankList = [];

//冠名成功
MGC_CommResponse.CompleteGiftRank = function (obj) {
    obj = MGC_Comm.strToJson(obj);

    giftRankList = obj.gift_ids;

    showGiftRankDialog();
}

var showGiftRankDialog = function(){
    if(giftRankList.length == 0)return;

    setTimeout(function(){
        var obj = giftRankList.shift();
        var dialog = {};
        dialog.Title = '提示信息';
        dialog.Note = '恭喜您成为了上周周星冠军！获得' + obj.gift_name + '礼物冠名权一周！';
        MGC_Comm.CommonDialog(dialog,showGiftRankDialog);
    },1000);
}

var flashClick = function() {
    var card = $j(".card_tips");
    //card.hide();
    window.mgc.popmanager.layerControlHide(card, 3, 2);
    window.mgc.popmanager.layerControlHide(card, 2, 2);
    window.mgc.popmanager.layerControlHide(card, 1, 2);
    window.mgc.popmanager.layerControlHide($j("#meili_div"), 3, 1);
    MGC.controlCon('sc_face', false);
    MGC.faceSc = true;
    $m(".commTips").hide();
    $m(".commTips_punchCard").hide();
    $m(".commTips_gift").hide();
    GiftRankPane.show(false);
    GiftQuickPane.show(false);
};

var gift_send = function(JsonStr) {
    var swfobj = getSWF('x51VideoWeb');
    try {
        console.log("gift_send ：" + JSON.stringify(JsonStr));
        swfobj.request_as(JsonStr);
    } catch (e) {
        console.log("gift_send 异常：" + JSON.stringify(JsonStr));
    }
    JsonStr = null;
    swfobj = null;
}
var giftSwfObj = null;
var gift_response = function(JsonStr) {
    if (JsonStr.op_type == 36 || JsonStr.op_type == -2 || JsonStr.op_type == 178 || JsonStr.op_type == 236 || JsonStr.op_type == 19 || JsonStr.op_type == 24 ||
        JsonStr.op_type == 30 || JsonStr.op_type == 35 || JsonStr.op_type == 130 || JsonStr.op_type == 154 || JsonStr.op_type == 182 || JsonStr.op_type == 26 ||
        JsonStr.op_type == 147 || JsonStr.op_type == 143 || JsonStr.op_type == 12 || JsonStr.op_type == 142 || JsonStr.op_type == 183 || JsonStr.op_type == 187 ||
        JsonStr.op_type == 197 || JsonStr.op_type == 203 || JsonStr.op_type == 205 || JsonStr.op_type == 87 || JsonStr.op_type == 274 || JsonStr.op_type == 326) {
        if (!giftSwfObj) {
            giftSwfObj = getSWF('GiftSwf');
        }
        giftSwfObj.request_as(JsonStr);
    }
    JsonStr = null;
}
if (!window.mgc) {
    window.mgc = {};
}
window.mgc.gift_response = gift_response;
var video_response = function(JsonStr) {
    //优化:转对象 过滤消息
    var obj;
    if(typeof(JsonStr) == "string")
    {
        obj = JSON.parse(JsonStr);
    }
    else{
        obj = JsonStr;
    }

    if(obj.op_type == 35 ||
        obj.op_type == 52 ||
        obj.op_type == 53 ||
        obj.op_type == 116 ||
        obj.op_type == 117 ||
        obj.op_type == 178 ||
        obj.op_type == 200 ||
        obj.op_type == 201 ||
        obj.op_type == 202 ||
        obj.op_type == 203)
    {
        var swfobj = getSWF('LiveVideoSwfContainer');
        try {
            swfobj.request_as(obj);
        } catch (e) {
            console.log(e.message);
        }
    }
    JsonStr = null;
    obj = null;
    swfobj = null;
}

var eventgift_response = function(JsonStr) {
    //优化:转对象 过滤消息
    var obj;
    if(typeof(JsonStr) == "string")
    {
        obj = JSON.parse(JsonStr);
    }
    else{
        obj = JsonStr;
    }

    if(obj.op_type == 36 ||
        obj.op_type == 35 ||
        obj.op_type == 147)
    {
        //过滤圣诞礼物
        if(obj.op_type == 36)
        {
            if(obj.gift.giftItemID != MGCData.activity_gift_id)return;
        }
        var swfobj = getSWF('eventGiftContainer');
        try {
            swfobj.request_as(obj);
        } catch (e) {
            console.log(e.message);
        }
    }
}
window.mgc.eventgift_response = eventgift_response;

MGC_CommResponse.timerRoom = null;
MGC_CommResponse.timerRoomHide = null;
//房间内引导提示
MGC_CommResponse.roomGuide = function (time, timeTwo) {
    if (MGCData.roomStatus == 1) {
        $m('#reminder_room .close').off('click').on('click', function () {
            $m("#reminder_room").fadeOut();            
        })
        clearTimeout(MGC_CommResponse.timerRoom);
        clearTimeout(MGC_CommResponse.timerRoomHide);
        MGC_CommResponse.timerRoom=setTimeout('$m("#reminder_room").fadeIn();', time);
        MGC_CommResponse.timerRoomHide=setTimeout('$m("#reminder_room").fadeOut();', timeTwo);
    }

}
var SetUserStatusCallBack = function(responseStr) {
    var obj = MGC_Comm.strToJson(responseStr);
    var dialog = {};
    switch (parseInt(obj.res)) {
        case 0:
            var _status = 0,
                _an_stat = 1,
                _s_str = '在线',
                _a_str = '隐身';
            _note = '设置在线成功！';
            mgc.consts.MGCData.invisible = false;
            if (obj.invisble == true) {
                _status = 1;
                _an_stat = 0;
                _s_str = '隐身';
                _a_str = '在线';
                _note = '隐身成功!在隐身状态内，您的大部分操作将不会显示给当前的观众';
                mgc.consts.MGCData.invisible = true;
            }
            $m('.logined_status strong').attr('class', 'icon' + _status).html(_s_str);
            $m('.logined_status li').attr('class',
                'icon' + (parseInt(_status) == 0 ? 1 : 0)).html(_a_str);
            dialog.Note = _note;
            break;
        case 3:
            dialog.Note = '您已经隐身了哦！';
            break;
        case 4:
            dialog.Note = '对不起，您没有隐身的权限，只有将军及以上的贵族玩家才可拥有！';
            break;
        default:
            dialog.Note = '对不起，隐身失败！';
            break;
    }
    MGC_Comm.CommonDialog(dialog);
};
// ==================公用end============================================================

// ==================登陆相关===========================================================
var MGCLoginResponse = {
    // 用户的数据
    roleData: {},

    gameRoleData: [],

    // 判断是否有梦工厂的角色
    hasRole: function(_roomInfos, _zoneid) {
        var bHasRole = false;
        for (var i = 0, j = _roomInfos.length; i < j; i++) {
            if (parseInt(_roomInfos[i]["zoneid"]) == _zoneid) {
                bHasRole = true;
                break;
            }
        }
        return bHasRole;
    }
};
// 请求角色列表的回调方法
var RoleListCallBack = function(responseStr, noLogin) {
    var repStr = MGC_Comm.strToJson(responseStr);
    var _optType = parseInt(repStr.op_type);
    var _err_code = parseInt(repStr.err_code);
    MGC_Comm.g_HorizonLoginData.mgcQQ = MGC_Comm.commonGetCookie();
    if (_err_code == 0 && (MGC_Comm.g_HorizonLoginData.mgcQQ == null || MGC_Comm.g_HorizonLoginData.mgcQQ.length == 0 || MGC_Comm.g_HorizonLoginData.mgcQQ == "0") && (filename == "showroom.shtml" || filename == "liveroom.shtml" || filename == "caveolaeroom.shtml" || filename == "nest.shtml" || filename == "transfer.shtml")) {
        MGC_Comm.getAsGuestCache();
        return;
    }
    if (_err_code != 0 && noLogin != 1) {
        if (_err_code == 1) {
            alert("角色信息加载失败，请稍后重试");
        } else if (_err_code == 2) {
            MGC_Comm.CommonDialog({
                "Title": "提示",
                "Note": "抱歉，您没有登录权限"
            }, function() {
                MGC_Comm.Dologout(999);
                var myTime = new Date();
                var filename = window.location.href;
                $m.cookie("mgc_logError_mgc_common_OLD_RoleListCallBack_logout", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___mgc_common_OLD_RoleListCallBack_logout___web--mgc_common_OLD_RoleListCallBack_logout___filename" + filename, {
                    path: '/',
                    domain: '.qq.com'
                });
            });
        };
        return false;
    };
    MGCLoginResponse.roleData = repStr;
    MGCData.mgcZoneId = 888;
    MGC.popLoading(false);

    if (!MGC_Comm.commonIsLogin()) {
        //没有登陆,连默认大区888
        MGCLoginRequest.roleSelectNoLogin(MGCData.mgcZoneId);
    }
    else {
        if (repStr.succ == true) {
            var _accountInfoss = repStr.account_infos;
            var _zoneInfos = repStr.room_proxy_infos;
            var _zoneInfoLen = _zoneInfos.length;
            if (_zoneInfoLen == 0) {
                alert("没有可以连接的大区");
                return;
            }
            // 显示游戏内的角色
            var _gameRoleList = '';
            var _oldRoleCount = 0;
            for (var m = 0, n = _accountInfoss.length; m < n; m++) {
                if (parseInt(_accountInfoss[m]["zoneid"]) == MGCData.mgcZoneId) {
                    continue;
                }
                var _zoneName = _zoneInfos[m].name;
                ++_oldRoleCount;
                if (_oldRoleCount % 9 == 1) {
                    _gameRoleList += "</ul><ul class=\"current\"><li><a href=\"javascript:;\" onclick=\"MGCLoginRequest.roleSelectLogin(" + _accountInfoss[m]["zoneid"] + ");\">" + _zoneName + "</a></li>";
                } else {
                    _gameRoleList += "<li><a href=\"javascript:;\" onclick=\"MGCLoginRequest.roleSelectLogin(" + _accountInfoss[m]["zoneid"] + ");\">" + _zoneName + "</a></li>";
                }
            }
            var _oldRolePages = Math.ceil(_oldRoleCount / 9);
            var _html = '';
            if (_gameRoleList == '') {
                _html = "<p style='text-align: center;margin-top: 20px;'>暂无炫舞角色</p>";
                $m('.pop_page').hide();
            } else {
                _gameRoleList = _gameRoleList.substr(5) + "</ul>";
                _html = '<div class="pop_precinct_con">' + _gameRoleList + '</div>';
                $m('#role_sum_tips').text('1/' + _oldRolePages);
            }
            $m("#roleListGame").html(_html);
            if (_oldRolePages <= 1) {
                $m('.pop_page').hide();
            } else {
                $m('.pop_page').show();
                MGC.precinctSlide(_oldRolePages, 'role_sum_tips');//翻页
            }
            //显示创建角色或者选择角色
            if (_accountInfoss.length == 0) {
                MGC_Comm.showDiv('pop0');
                $m("#mgcCreateRole").unbind('click').bind('click', function() {
                    MGC_Comm.hideDiv();
                    MGC_Comm.showDiv("pop0");
                }).show();
                $m('#mgcSelectRole').unbind('click').hide();

                LoginManager.getNickName(function(loginInfo) {
                    if (loginInfo.isLogin && loginInfo.nickName && loginInfo.nickName.length > 0) {
                        $m('#popSr').val(loginInfo.nickName);
                    }
                    else {
                        $m('.pop_nick_info').html('获取昵称失败！').css('color', 'red');
                    }
                }
                );
                var _url = "http://apps.game.qq.com/mgc/index.php?m=GetUserGender&t=" + (new Date()).getTime();
                $m("#SelectGender a").removeClass("current");
                $m("#SelectGender a").eq(0).addClass("current");
                MGC_Comm.ajax(_url, function(obj) {
                    if (parseInt(obj.ret_code) == 0) {
                        $m("#SelectGender a").removeClass("current");
                        if (obj.data.UserGender == "男") {
                            $m("#SelectGender a").eq(0).addClass("current");
                            $m("#userGender").val($m("#SelectGender a").eq(0).attr("idx"));
                        }
                        else {
                            $m("#SelectGender a").eq(1).addClass("current");
                            $m("#userGender").val($m("#SelectGender a").eq(1).attr("idx"));
                        }
                    }
                    else {
                        $m("#SelectGender a").removeClass("current");
                        $m("#SelectGender a").eq(1).addClass("current");
                        $m("#userGender").val($m("#SelectGender a").eq(1).attr("idx"));
                    }
                });


                // 动态绑定动作
                $m('#popSr').focus(function() {
                    var v = $m.trim($m(this).val());
                    $m(this).css({
                        "color": "#1c1c1c"
                    });
                    if (v == '输入QQ昵称') {
                        $m(this).val("");
                    }
                    if (MGC_Comm.Strlen(v) > 12) {
                        $m('.pop_nick_info').html('昵称长度限制12个字符').css('color', 'red');
                        $m(this).val(MGC_Comm.Strcut(v, 12));
                    } else {
                        $m('.pop_nick_info').html('点击可修改昵称，最多12位字符').css({
                            "color": "#545454"
                        });
                    }
                }).blur(function() {
                    var v = $m.trim($m(this).val());
                    if (v == '') {
                        $m(this).val('输入QQ昵称').css({
                            "color": "#bcbcbc"
                        });
                    }
                }).keyup(function() {
                    var v = $m.trim($m(this).val());
                    if (MGC_Comm.Strlen(v) > 12) {
                        $m(this).val(MGC_Comm.Strcut(v, 12));
                    }
                }).keydown(function() {
                    var v = $m(this).val();
                    if (MGC_Comm.Strlen(v) >= 12) {
                        event.returnValue = false;
                    }
                    if (event.keyCode == 8) {
                        event.returnValue = true;;
                    }
                })
                //检测重名
                $m('#checkDup').unbind('click').bind('click', function() {
                    var v = $m.trim($m('#popSr').val());
                    if (v == '' || v == '输入QQ昵称' || v == undefined || v == '　' || v == '　　' || v == '　　　' || v == '　　　　' || v == '　　　　　' || v == '　　　　　　' || v == '　　　　　　　' || v == '　　　　　　　　' || v == '　　　　　　　　　' || v == '　　　　　　　　　　' || v == '　　　　　　　　　　　' || v == '　　　　　　　　　　　　') {
                        $m('.pop_nick_info').html('请输入昵称！').css('color', 'red');
                    } else {
                        MGCCheckNickRequest(v);
                    }
                });

                //色子注册点击事件
                $m('.color_words').unbind('click').bind('click', function() {
                    MGCNicknameRequest();
                });

                $m("#doRegister").unbind('click').bind('click', function() {
                    var _userNick = $m.trim($m("#popSr").val());
                    var msg = '';
                    if (_userNick.length == 0 || _userNick == '输入QQ昵称') {
                        msg = '请输入昵称！';
                    }
                    else if (_userNick.length > 12) {
                        msg = '昵称长度限制12个字符';
                    }
                    else if (_userNick.replace(/&nbsp;/g, "").length == 0 || _userNick.replace(/&nbsp/g, "").length == 0 || $m.trim(_userNick).length == 0) {
                        msg = '该昵称不可使用，请您重新输入';
                    }


                    if (msg != '') {
                        $m('.pop_nick_info').html(msg).css('color', 'red');
                        return false;
                    }
                    try {
                        EAS.SendClick({ 'e_c': 'mgc.regist', 'c_t': 4 });
                    } catch (e) {

                    }
                    StartRegister();
                });
                $m("#SelectGender a").unbind('click').bind('click', function() {
                    $m("#SelectGender a").removeClass("current");
                    $m(this).addClass("current");
                    $m("#userGender").val($m(this).attr("idx"));
                });
                $m("#doRegister").unbind('click').bind('click', function() {
                    var _userNick = $m.trim($m("#popSr").val());
                    var msg = '';
                    if (_userNick.length == 0 || _userNick == '输入QQ昵称') {
                        msg = '请输入昵称！';
                    }
                    else if (_userNick.length > 12) {
                        msg = '昵称长度限制12个字符';
                    }
                    else if (_userNick.replace(/&nbsp;/g, "").length == 0 || _userNick.replace(/&nbsp/g, "").length == 0 || $m.trim(_userNick).length == 0) {
                        msg = '该昵称不可使用，请您重新输入';
                    }
                    if (msg != '') {
                        $m('.pop_nick_info').html(msg).css('color', 'red');
                        return false;
                    }
                    try {
                        EAS.SendClick({ 'e_c': 'mgc.regist', 'c_t': 4 });
                    } catch (e) {

                    }

                    StartRegister();
                });
                $m("#SelectGender a").unbind('click').bind('click', function() {
                    $m("#SelectGender a").removeClass("current");
                    $m(this).addClass("current");
                    $m("#userGender").val($m(this).attr("idx"));
                });
            } else {
                MGC_Comm.showDiv("pop1");
                if (true == MGCLoginResponse.hasRole(_accountInfoss, 888)) {

                    //色子注册点击事件
                    $m('.color_words').unbind('click').bind('click', function() {
                        MGCNicknameRequest();
                    });

                    $m("#doRegister").unbind('click').bind('click', function() {
                        var _userNick = $m.trim($m("#popSr").val());
                        var msg = '';
                        if (_userNick.length == 0 || _userNick == '输入QQ昵称') {
                            msg = '请输入昵称！';
                        }
                        else if (_userNick.length > 12) {
                            msg = '昵称长度限制12个字符';
                        }
                        else if (_userNick.replace(/&nbsp;/g, "").length == 0 || _userNick.replace(/&nbsp/g, "").length == 0 || $m.trim(_userNick).length == 0) {
                            msg = '该昵称不可使用，请您重新输入';
                        }
                        if (msg != '') {
                            $m('.pop_nick_info').html(msg).css('color', 'red');
                            return false;
                        }
                        try {
                            if (filename == '' || filename == 'index.shtml') {
                                EAS.SendClick({ 'e_c': 'mgc.regist.1', 'c_t': 4 });
                            } else if (filename == 'liveroom.shtml') {
                                EAS.SendClick({ 'e_c': 'mgc.regist.2', 'c_t': 4 });
                            } else if (filename == 'showroom.shtml') {
                                EAS.SendClick({ 'e_c': 'mgc.regist.3', 'c_t': 4 });
                            } else if (filename == 'ticket.shtml') {
                                EAS.SendClick({ 'e_c': 'mgc.regist.4', 'c_t': 4 });
                            }
                            EAS.SendClick({ 'e_c': 'mgc.regist', 'c_t': 4 });
                        } catch (e) {

                        }

                        StartRegister();
                    });
                    $m("#SelectGender a").unbind('click').bind('click', function() {
                        $m("#SelectGender a").removeClass("current");
                        $m(this).addClass("current");
                        $m("#userGender").val($m(this).attr("idx"));
                    });
                    $m('.pop_mgcjs').show();
                    $m("#mgcSelectRole").unbind('click').bind('click', function() {
                        MGCLoginRequest.roleSelectLogin(MGCData.mgcZoneId);
                    }).show();
                    $m("#mgcCreateRole").unbind('click').hide();
                }
                else {
                    $m('.pop_mgcjs').hide();
                }
            }
        } else {
            alert("获取角色信息失败，请稍候再试");
            return;
        }
    }
};

// =====连接大区服务器的回调================
var AreaLoginGuestCallBack = function(responseStr) {
    var repStr = MGC_Comm.strToJson(responseStr);
    console.log("连接大区服务器游客回调-2：" + JSON.stringify(responseStr));
    if (repStr.res == 0) {
        MGC_Comm.RegisterGuestCard();
    }
}
var AreaLoginCallBack = function(responseStr) {
    var repStr = MGC_Comm.strToJson(responseStr);
    console.log("连接大区服务器回调-2：" + JSON.stringify(responseStr));
    // 连接大区成功后，把返回的信息写到cookie中
    MGC_Comm.commonCheckLogin(
        function() {
            //var _uin = MGC_Comm.commonGetUin();
            if (repStr.res == 0) {

                // 回调 创建角色或者加载的内容  添加游客权限
                if (MGCData.isRegister == true && !MGC_Comm.CheckGuestStatus(true)) {
                    MGC.popLoading(false);
                    MGCRegisterRequest();
                    return;
                }

                if ($m.cookie("mgc_guest_id") && !MGC_Comm.CheckGuestStatus(true)) {
                    window.location.reload();
                    $m.cookie("mgc_guest_id", null);
                    return;
                }
                MGC.popLoading(false);
                if (typeof loginCallBack == 'function') {
                    //添加游客权限
                    if (!MGC_Comm.CheckGuestStatus(true)) {
                        MGCLoginRequest.getCardInfo();
                        //检测首登、签到
                        MGCLoginRequest.getCardInfo(true);
                        MGCLoginRequest.getDoneAct();
                        MGC_CommRequest.getRechargeNotice();
                        $m('.nd').show(); //显示快速充值
                    }
                    loginCallBack();
                }

                if (MGC_Comm.isTransferRequest) {
                    window.location.reload();
                }
            } else if (repStr.res == 2) {
                try {
                    EAS.SendClick({ 'e_c': 'mgc.regist.error.7', 'c_t': 4 });
                } catch (e) {

                }

                // 需要清空cookie
                /*$m.cookie("mgc_ip_" + _uin, null);
                $m.cookie("mgc_port_" + _uin, null);
                $m.cookie("mgc_zone_" + _uin, null);*/
                // @todo 先不处理
            } else {
                try {
                    EAS.SendClick({ 'e_c': 'mgc.regist.error.8', 'c_t': 4 });
                } catch (e) {

                }

                // 失败 @todo
            }
        }, function() {
            try {
                EAS.SendClick({ 'e_c': 'mgc.regist.error.6', 'c_t': 4 });
            } catch (e) {

            }
            // 无登陆状态下，判断是否连接失败，如果失败，则提示，成功及需要清除cookie不处理，
            if (repStr.res == 0) {
                // 连接成功,需要加调加载数据的接口
                if (filename == 'act.shtml') {
                    MGC_Comm.DoLoginFirst();
                }
                if (typeof loginCallBack == 'function') {
                    loginCallBack();
                }
                //$m.cookie("mgcZoneId", null);
                //$m.cookie("mgc_login", null);
            } else if (repStr.res == 2) {
                // 需要清空cookie不处理
            } else {
                // 失败

            }
        });
};
// =====连接大区服务器的回调================

var MGCLoginRequest = {
    // 设置cookie
    doLogin: function(zoneid) {
        $m.cookie("mgcZoneId", zoneid);
        MGCLoginRequest.areaLogin(zoneid);
    },

    // 选择某个大区时的进入操作
    roleSelectLogin: function(zoneid) {
        try {
            if (filename == '' || filename == 'index.shtml') {
                EAS.SendClick({ 'e_c': 'mgc.enteraera.1', 'c_t': 4 });
            } else if (filename == 'liveroom.shtml') {
                EAS.SendClick({ 'e_c': 'mgc.enteraera.2', 'c_t': 4 });
            } else if (filename == 'showroom.shtml') {
                EAS.SendClick({ 'e_c': 'mgc.enteraera.3', 'c_t': 4 });
            } else if (filename == 'ticket.shtml') {
                EAS.SendClick({ 'e_c': 'mgc.enteraera.4', 'c_t': 4 });
            }
            EAS.SendClick({ 'e_c': 'mgc.enteraera', 'c_t': 4 });
        }
        catch (e) {

        }

        $m.cookie("mgcZoneId", zoneid);
        MGC_Comm.hideDialog(true);
        MGCLoginRequest.areaLogin(zoneid);
    },

    // 无登陆状态下，请求默认大区的
    roleSelectNoLogin: function(zoneid) {
        $m.cookie("mgcZoneId", zoneid);
        MGCLoginRequest.areaLogin(zoneid);
    },

    // 获得登录QQ的服务器大区角色列表
    roleList: function() {
        //MGC_Comm.commonGetUin(function(_uin) {
        //    var _loginQQ = (MGC_Comm.CheckGuestStatus(true) ? MGC_Comm.g_HorizonGuestData.mgc_guest_id : _uin) || 0,
        //     _loginCookie = MGC_Comm.CheckGuestStatus(true) ? MGC_Comm.g_HorizonGuestData.mgc_guest_token : MGC_Comm.commonGetCookie();
        //    var _reqStr = "{\"op_type\":128,\"qq\":" + _loginQQ + ",\"vertify_info\":\"" + _loginCookie + "\"}";
        //    console.log("获取登录服务器大区角色列表128：" + _reqStr);
        //    MGC_Comm.sendMsg(_reqStr, "RoleListCallBack");
        //});
    },

    // 无登录态请求时
    noLoginRoleList: function() {
        //var _reqStr = "{\"op_type\":128,\"qq\":0,\"vertify_info\":\"\"}";
        //MGC_Comm.sendMsg(_reqStr, "RoleListCallBack", 1);
    },

    // 连接大区服务器
    areaLogin: function(zoneid, _callback) {
        console.log("连接大区服务器：-2");
        //MGC_Comm.commonGetUin(function(_uin) {
        //    var _loginQQ = MGC_Comm.CheckGuestStatus(true) ? MGC_Comm.g_HorizonGuestData.mgc_guest_id : _uin,
        //    _loginCookie = MGC_Comm.CheckGuestStatus(true) ? MGC_Comm.g_HorizonGuestData.mgc_guest_token : MGC_Comm.commonGetCookie();
        //    if (_loginQQ == null || _loginQQ == undefined || _loginQQ == "") {
        //        _loginQQ = 0;
        //    };
        //    if (_loginCookie == null || _loginCookie == undefined || _loginCookie == "") {
        //        _loginCookie = 0;
        //    };
        //    //var _reqStr = "{\"op_type\":-2, \"zoneid\":" + zoneid + ",\"qq\":" + _loginQQ + ",\"vertify_info\":\"" + _loginCookie + "\"}";
        //    console.log("连接大区服务器请求-2:" + _reqStr);
        //    var _req = { op_type: OP_TYPE.LOGIN_ZONE, qq: account.getUin() || 0, vertify_info: account.getCookie(), zoneid: zoneid || tools.pageSource().zoneid, channel: channel || tools.pageSource().channel, m_appid: tools.pageSource().appid, m_skey: "", m_device_type: tools.pageSource().device_type };
        //    MGC_Comm.sendMsg(_reqStr, _callback != undefined ? _callback : "AreaLoginCallBack");
        //});
    },

 /*   // 获取首页信息
    getCardInfo: function(Stag) {
        console.log("获取首页信息:{\"op_type\":" + OpType.GetIndexUserInfoOpType + ",\"reqtype\":0}");
        MGC_Comm.sendMsg("{\"op_type\":" + OpType.GetIndexUserInfoOpType + ",\"reqtype\":0}", Stag ? "MGC_CommResponse.CardInfoForSignCallBack" : "MGC_CommResponse.CardInfoCallBack");
    },*/

    // 获取未领取任务数量
    getDoneAct: function() {
        MGC_Comm.sendMsg("{\"op_type\":153}", "MGC_CommResponse.hasActCallBack");
    }
};

// 开通VIP相关请求
var MGCVIPRequest = {
    // 获用户VIP信息
    getUserVipInfo: function() {
        if (MGC_Comm.CheckGuestStatus()) {
            return false;//游客身份下，屏蔽此操作
        }
        var _callBack = 'CommOpenVip.openUserVipCallBack',
            _reqStr = "{\"op_type\":176}";
        MGC_Comm.sendMsg(_reqStr, _callBack);
    },

    // 获取VIP价格信息
    getVipPriceInfo: function() {
        var _reqStr = "{\"op_type\":" + OpType.GetVipPriceInfoOpType + "}";
        MGC_Comm.sendMsg(_reqStr, "CommOpenVip.getVipPriceCallBack");
    },

    // 开通VIP
    StartVip: function(type, duration, costtype) {
        var _reqStr = "{\"op_type\":" + OpType.StartVipOpType + ", \"vip_level\":" + type + ",\"duration\":" + duration + ",\"costtype\":" + costtype + "}";
        MGC_Comm.sendMsg(_reqStr, "CommOpenVip.StartVipCallBack");
    },

    // 续费VIP
    RenewalVip: function(type, duration, costtype) {
        var _reqStr = "{\"op_type\":" + OpType.RenewalVipOpType + ", \"vip_level\":" + type + ",\"duration\":" + duration + ",\"costtype\":" + costtype + "}";
        MGC_Comm.sendMsg(_reqStr, "CommOpenVip.RenewalVipCallBack");
    }
};
var refreshVipInfo = function() {
    MGCLoginRequest.getCardInfo();
}
// 开通贵族
var CommOpenVip = {
    isReturnHome: false,//是否返回首页

    myLevel: 0, //我的贵族等级

    ktPriceList: [],

    xfPriceList: [],

    detail: [],

    choosen: {},

    clickLevel: 0,

    fillList: function(xfType, ffLength) {
        var _myLevel = this.clickLevel;
        var detail = this.detail;
        var xfListHtml = '',
            xfPayHtml = '';
        if (xfType.length == 1) {
            var _class = parseInt(xfType) == 1 ? 'icon_mhb' : 'icon_xd',
                _tname = parseInt(xfType) == 1 ? '梦幻币' : '炫豆';
            $m('#select_pay_btn').attr('data', xfType); // 添加续费默认值
            $m('#select_pay_btn span').html(_tname + '<i class="' + _class + '"></i>');
            if (ffLength == 2) {
                xfPayHtml += '<li data=2><span>炫豆<i class="icon_xd"></i></span></li>';
                xfPayHtml += '<li data=1><span>梦幻币<i class="icon_mhb"></i></span></li>';
            } else {
                xfPayHtml = '<li data=' + xfType + '><span>' + _tname + '<i class="' + _class + '"></i></span></li>';
            }
        } else if (xfType.length == 2) {
            $m('#select_pay_btn').attr('data', 2); // 默认炫豆
            $m('#select_pay_btn span').html('炫豆<i class="icon_xd"></i>');
            xfPayHtml += '<li data=2><span>炫豆<i class="icon_xd"></i></span></li>';
            xfPayHtml += '<li data=1><span>梦幻币<i class="icon_mhb"></i></span></li>';
        }
        var j = 0;
        for (var i = 0, len = detail.length; i < len; i++) {
            var _cost_type = parseInt(detail[i].cost_type),
                _duration = detail[i].duration,
                _cost = detail[i].cost,
                _vipName = detail[i].vip_name,
                _fullcost = detail[i].fullcost,
                _iconClass = '';
            if (xfType.length == 1) {
                if (parseInt(xfType) == _cost_type) {
                    if (_cost_type == 1) {
                        _iconClass = 'icon_mhb';
                    } else if (_cost_type == 2) {
                        _iconClass = 'icon_xd';
                    }
                } else {
                    continue;
                }
            } else if (xfType.length == 2) {
                if (_cost_type == 2) {
                    _iconClass = 'icon_xd';
                } else {
                    continue;
                }
            }
            if (j == 0) {
                $m('#select_open_btn').attr('data', "{\"type\":" + _myLevel + ",\"duration\":" + _duration + "}"); // 添加开通默认值
                $m('#select_open_btn span').html(_vipName + '(' + _duration + '天)' + (_fullcost > 0 ? '  <em>' + _fullcost + '</em>' : '') + '  ' + _cost + '<i class="' + _iconClass + '"></i>');
            }
            xfListHtml += '<li data=\'{\"type\":' + _myLevel + ',\"duration\":' + _duration + '}\'><span>' + _vipName + '(' + _duration + '天)' + (_fullcost > 0 ? '  <em>' + _fullcost + '</em>' : '') + '  ' + _cost + '<i class="' + _iconClass + '"></i></span></li>';
            j++;
        }
        $m('#select_pay_list').html(xfPayHtml);
        $m('#select_open_list').html(xfListHtml);
        $m("#select_open_btn,#select_open_list").delegate(".icon_mhb", "mouseover", function(e) {
            var _e = e.target == undefined ? e.toElement : e.target;
            var t = _e.offsetTop + 468;
            var l = _e.offsetLeft + 190;
            $m('.mhb_tips_vip').css({ "top": t, "left": l });
            //$m('.mhb_tips_vip').show();
            window.mgc.popmanager.layerControlShow($m('.mhb_tips_vip'), 4, 3);
        }).delegate(".icon_mhb", "mouseout", function(e) {
            //$m('.mhb_tips_vip').hide();
            window.mgc.popmanager.layerControlHide($m('.mhb_tips_vip'), 4, 3);
        });
        $m("#select_open_btn,#select_open_list").delegate(".icon_xd", "mouseover", function(e) {
            var _e = e.target == undefined ? e.toElement : e.target;
            var t = _e.offsetTop + 468;
            var l = _e.offsetLeft + 190;
            $m('.xd_tips_vip').css({ "top": t, "left": l });
            window.mgc.popmanager.layerControlShow($m('.xd_tips_vip'), 4, 3);
        }).delegate(".icon_xd", "mouseout", function(e) {
            window.mgc.popmanager.layerControlHide($m('.xd_tips_vip'), 4, 3);
        });

        $m("#select_pay_btn,#select_pay_list").delegate(".icon_mhb", "mouseover", function(e) {
            var _e = e.target == undefined ? e.toElement : e.target;
            var t = _e.offsetTop + 468;
            var l = _e.offsetLeft + 640;

            var X = document.body.clientWidth;
            if ((MgcAPI.SNSBrowser.IsQQGame() || MgcAPI.SNSBrowser.IsX52()) && X <= 1024)
            {
                l = _e.offsetLeft + 370;
            }
            else
            {
                //重新定位
                MGC.comm_tips_position($m('.mhb_tips_vip_2'), false, -80,-20);
            }

            $m('.mhb_tips_vip_2').css({ "top": t, "left": l });
            window.mgc.popmanager.layerControlShow($m('.mhb_tips_vip_2'), 4, 3);
            window.mgc.popmanager.layerControlHide($m('.mhb_tips_vip'), 4, 3);
        }).delegate(".icon_mhb", "mouseout", function(e) {
            window.mgc.popmanager.layerControlHide($m('.mhb_tips_vip_2'), 4, 3);
        });

        $m("#select_pay_btn,#select_pay_list").delegate(".icon_xd", "mouseover", function(e) {
            var _e = e.target == undefined ? e.toElement : e.target;
            var t = _e.offsetTop + 468;
            var l = _e.offsetLeft + 640;

            var X = document.body.clientWidth;
            if ((MgcAPI.SNSBrowser.IsQQGame() || MgcAPI.SNSBrowser.IsX52()) && X <= 1024)
            {
                l = _e.offsetLeft + 370;
            }
            else
            {
                //重新定位
                MGC.comm_tips_position($m('.mhb_tips_vip_2'), false, -80,-20);
            }

            $m('.xd_tips_vip_2').css({ "top": t, "left": l });
            window.mgc.popmanager.layerControlShow($m('.xd_tips_vip_2'), 4, 3);
            window.mgc.popmanager.layerControlHide($m('.xd_tips_vip'), 4, 3);
        }).delegate(".icon_xd", "mouseout", function(e) {
            window.mgc.popmanager.layerControlHide($m('.xd_tips_vip_2'), 4, 3);
        });

        window.mgc.popmanager.layerControlHide($m('.mhb_tips_vip'), 4, 3);
        window.mgc.popmanager.layerControlHide($m('.xd_tips_vip'), 4, 3);
        window.mgc.popmanager.layerControlHide($m('.mhb_tips_vip_2'), 4, 3);
        window.mgc.popmanager.layerControlHide($m('.xd_tips_vip_2'), 4, 3);


    },

    myVipSelect: function(id, list) {
        $m("#" + id).unbind('click').click(function() {
            if ($m("#" + list).css("display") == "none") {
                window.mgc.popmanager.layerControlShow($m("#" + list), 4, 2);
            } else {
                window.mgc.popmanager.layerControlHide($m("#" + list), 4, 2);
            }
        });
        /*
        $m(document).unbind('click').click(function (e) {
            e = e || window.event; // 兼容IE7
            obj = $m(e.srcElement || e.target);
            if ($m(obj).is("#" + id + ",#" + id + " *")) {
                $m("#" + list).toggle();
                //$m("#" + list).show();
            } else {
                $m("#" + list).hide();
            }
        });
        */
        var _this = this;

        $m("#" + list).unbind('click').on('click', 'li', function() {
            window.mgc.popmanager.layerControlHide($j("#" + list), 4, 2);
            var shtml = $m(this).find("span").html();
            var d = $m(this).attr('data');
            $m("#" + id).attr('data', d);
            var l = $m("#" + list + " li").length;
            _this.fillList(d, l);
            $m("#" + id).find("span").html(shtml);
        });
    },

    initClick: function(vipLevel) {
        var _myLevel = parseInt(this.myLevel);
        var xfVipInfo = this.xfPriceList;
        var ktVipInfo = this.ktPriceList;
        var _this = this;
        $m('#open_vip_list a').unbind('click').on('click', function() {
            $m('#open_vip_list a').removeClass('current');
            $m(this).addClass('current');
            var clickLevel = parseInt($m(this).attr('vip'));
            var detail = _myLevel == clickLevel ? xfVipInfo[_myLevel] : ktVipInfo[clickLevel];
            _this.clickLevel = _myLevel == clickLevel ? _myLevel : clickLevel;
            _this.detail = detail;
            var xfType = '';
            for (var i = 0, len = detail.length; i < len; i++) {
                //取出当前贵族列表里的付费方式
                if (detail[i].cost_type > 0 && xfType.indexOf(detail[i].cost_type) == -1) {
                    xfType = xfType + '' + detail[i].cost_type;
                }
            }

            _this.fillList(xfType);
            if (_myLevel == clickLevel) {
                $m('#xfBtn').attr('class', 'btn_open').attr('href', 'javascript:CommOpenVip.xfVip();');;
                $m('#ktBtn').attr('class', 'btn_disabled').attr('href', 'javascript:;');
            } else {
                $m('#ktBtn').attr('class', 'btn_open').attr('href', 'javascript:CommOpenVip.ktVip();');;
                $m('#xfBtn').attr('class', 'btn_disabled').attr('href', 'javascript:;');
            }
        })
    },

    open: function() {
        MGCVIPRequest.getUserVipInfo();
    },

    ktVip: function() {
        var ktInfo = $m('#select_open_btn').attr('data'),
            ktType = $m('#select_pay_btn').attr('data'),
            ktInfo = MGC_Comm
            .strToJson(ktInfo);
        var dialog = {};
        if (this.myLevel == ktInfo.type) {
            dialog.Title = '提示信息';
            dialog.Note = '您已开通过此贵族，无法重复开通';
            MGC_Comm.CommonDialog(dialog);
            return;
        }
        var vipName = vipLevelTab[ktInfo.type];
        dialog.Title = '提示信息';
        dialog.BtnNum = 2;
        dialog.BtnName2 = '取消';
        dialog.Note = '是否开通贵族：' + vipName + '(' + ktInfo.duration + '天)';
        var _this = this;
        var _callBack = function() {
            var _choosen = {};
            _choosen.level = ktInfo.type;
            _choosen.vipName = vipName;
            _choosen.duration = ktInfo.duration;
            _this.choosen = _choosen;
            MGCVIPRequest.StartVip(ktInfo.type, ktInfo.duration, ktType);
        }
        MGC_Comm.CommonDialog(dialog, _callBack);

    },

    xfVip: function() {
        var xfInfo = $m('#select_open_btn').attr('data'),
            xfType = $m('#select_pay_btn').attr('data'),
            xfInfo = MGC_Comm
            .strToJson(xfInfo);
        var dialog = {};
        if (this.myLevel != xfInfo.type) {
            dialog.Title = '提示信息';
            dialog.Note = '您尚未开通此贵族，续费失败';
            MGC_Comm.CommonDialog(dialog);
            return;
        }
        var vipName = vipLevelTab[xfInfo.type];
        dialog.Title = '提示信息';
        dialog.BtnNum = 2;
        dialog.BtnName2 = '取消';
        dialog.Note = '是否为' + vipName + '贵族续费' + xfInfo.duration + '天';
        var _this = this;
        var _callBack = function() {
            var _choosen = {};
            _choosen.level = xfInfo.type;
            _choosen.vipName = vipName;
            _choosen.duration = xfInfo.duration;
            _this.choosen = _choosen;
            MGCVIPRequest.RenewalVip(xfInfo.type, xfInfo.duration, xfType);
        }
        MGC_Comm.CommonDialog(dialog, _callBack);
    },

    // 弹出贵族主界面
    openUserVipCallBack: function(obj) {
        var _vipInfo = MGC_Comm.strToJson(obj);
        if (_vipInfo.vipLevel > 0) {
            this.myLevel = parseInt(_vipInfo.vipLevel);
            var remainTime = MGC_Comm.getRemainDate(_vipInfo.remainTime);
            $m('#myDegree').html('<strong>' + _vipInfo.vipName + '</strong> (' + remainTime + ')');
            var _index = _vipInfo.vipLevel - 1;
            $m('#open_vip_list a').removeClass('current').eq(_index).addClass('current');
            $m('#xfBtn').attr('class', 'btn_open').attr('href', 'javascript:CommOpenVip.xfVip();');
            $m('#ktBtn').attr('class', 'btn_disabled').attr('href', 'javascript:;');
        } else {
            this.myLevel = 0;
            $m('#myDegree').html('无');
            $m('#open_vip_list a').removeClass('current').eq(0).addClass('current');//默认近卫
            $m('#ktBtn').attr('class', 'btn_open').attr('href', 'javascript:CommOpenVip.ktVip();');
            $m('#xfBtn').attr('class', 'btn_disabled').attr('href', 'javascript:;');
        }
        if (CommOpenVip.isReturnHome) {
            $m('#mgc_vip .pop_close').attr('href', 'javascript:MGC_LIVEROOM_BIND.closeRefresh();');
        }
        MGCVIPRequest.getVipPriceInfo(); // 获取价格列表

    },

    afterKtOrXf: function(obj) {
        $m('#myDegree').html('<strong>' + obj.vipName + '</strong> (' + obj.duration + '天)');
        this.myLevel = obj.level;
        this.initClick();
        $m('#open_vip_list a').each(function() {
            var _vip = $m(this).attr('vip');
            if (_vip == obj.level) {
                $m(this).click();
            }
        })
    },

    // 获取VIP价格信息
    getVipPriceCallBack: function(obj) {
        obj = MGC_Comm.strToJson(obj);
        var priceInfo = obj.info,
            ktVipInfo = priceInfo.start_price_list,
            xfVipInfo = priceInfo.renewal_price_list;
        this.ktPriceList = ktVipInfo;
        this.xfPriceList = xfVipInfo;
        var _myLevel = this.myLevel;
        var detail = _myLevel > 0 ? xfVipInfo[_myLevel] : ktVipInfo[1];
        this.clickLevel = _myLevel > 0 ? _myLevel : 1;
        this.detail = detail;
        var xfType = '';
        for (var i = 0, len = detail.length; i < len; i++) {
            //取出当前贵族列表里的付费方式
            if (detail[i].cost_type > 0 && xfType.indexOf(detail[i].cost_type) == -1) {
                xfType = xfType + '' + detail[i].cost_type;
            }
        }
        this.fillList(xfType);
        this.initClick();
        this.myVipSelect('select_pay_btn', 'select_pay_list');
        showDialog.show('mgc_vip');
    },

    // 开通VIP
    StartVipCallBack: function(obj) {
        obj = MGC_Comm.strToJson(obj);
        var dialog = {};
        var _callback = null;
        switch (parseInt(obj.errcode)) {
            case 0:
                var _this = this;
                var _choosen = _this.choosen;
                //dialog.Note = '您成功开通了' + _choosen.vipName + '贵族身份' + _choosen.duration + '天';
                dialog.Note = '您成功开通了' + _choosen.vipName + '贵族身份~';
                //_callback = function(){_this.afterKtOrXf(_choosen);}
                _callback = function() { showDialog.hide(); refreshVipInfo(); }
                break;
            case 1:
            case 2:
            case 6:
                //dialog.Note = '操作失败！';
                dialog.Note = '对不起，您没有足够的炫豆或梦幻币';
                break;
            case 3:
                dialog.Note = '操作失败！';
                break;
            case 5:
                //dialog.Note = '您的炫逗余额不足，是否立即购买';
                dialog.Note = '对不起，您没有足够的炫豆或梦幻币';
                dialog.BtnNum = 2;
                dialog.BtnName = '购买炫豆';
                dialog.url = 'http://pay.qq.com/ipay/index.shtml?c=qxwwqp';
                break;
            case 9:
                dialog.Note = '您已开通过此贵族，无法重复开通';
                break;
            case 15:
                //dialog.Note = '您的梦幻币余额不足，您可以通过领取每日工资和完成任务获得梦幻币';
                dialog.Note = '对不起，您没有足够的炫豆或梦幻币';
                break;
            case 18:
                window.mgc.common_logic.CheckNameError(105);
                break;
            default:
                dialog.Note = '操作失败！';
                //dialog.Note = '对不起，您没有足够的炫豆或梦幻币';
                break;
        }
        MGC_Comm.CommonDialog(dialog, function() {
            if (CommOpenVip.isReturnHome) {//返回首页通知
                window.location.reload();
            } else {
                if (!_callback) {
                    refreshVipInfo();
                    MGC_Comm.hideDialog(false);
                } else {
                    _callback();
                }
            }
        });
    },

    // 续费VIP
    RenewalVipCallBack: function(obj) {
        obj = MGC_Comm.strToJson(obj);
        var dialog = {};
        var _callback = null;
        switch (parseInt(obj.errcode)) {
            case 0:
                var _this = this;
                var _choosen = _this.choosen;
                //dialog.Note = '您成功为' + _choosen.vipName + '贵族身份续费了' + _choosen.duration + '天';
                dialog.Note = '续费操作成功';
                //_callback = function(){_this.afterKtOrXf(_choosen);}
                _callback = function() {
                    showDialog.hide();
                    refreshVipInfo();
                }
                break;
            case 1:
            case 2:
            case 6:
                //dialog.Note = '操作失败！';
                dialog.Note = '对不起，您没有足够的炫豆或梦幻币';
                break;
            case 3:
                dialog.Note = '操作失败！';
                break;
            case 5:
                //dialog.Note = '您的炫逗余额不足，是否立即购买';
                dialog.Note = '对不起，您没有足够的炫豆或梦幻币';
                dialog.BtnNum = 2;
                dialog.BtnName = '购买炫豆';
                dialog.url = 'http://pay.qq.com/ipay/index.shtml?c=qxwwqp';
                break;
            case 9:
                dialog.Note = '您尚未开通此贵族，续费失败';
                break;
            case 15:
                //dialog.Note = '您的梦幻币余额不足，您可以通过领取每日工资和完成任务获得梦幻币';
                dialog.Note = '对不起，您没有足够的炫豆或梦幻币';
                break;
            case 18:
                window.mgc.common_logic.CheckNameError(106);
                break;
            default:
                dialog.Note = '操作失败！';
                //dialog.Note = '对不起，您没有足够的炫豆或梦幻币';
                break;
        }
        MGC_Comm.CommonDialog(dialog, function() {
            if (CommOpenVip.isReturnHome) {//返回首页通知
                window.location.reload();
            } else {
                if (!_callback) {
                    refreshVipInfo();
                    MGC_Comm.hideDialog(false);
                } else {
                    _callback();
                }
            }
        });
    }
};

// 种下cookie
var mgc_CheckLogin = function(setCookieCallback) {
        var _url = "http://apps.game.qq.com/x5/mgc/index.php?m=DoLogin&t=" + Math.random();
        MGC_Comm.ajax(_url, function(data) {
            if (data.ret_code == 0) {
                var _data = data.data;
                $m.cookie("mgc_login", _data.mgc_login, {
                    expires: 60,
                    path: '/',
                    domain: '.mgc.qq.com'
                });
            };

            if (typeof setCookieCallback == 'function') {
                setCookieCallback();
            }
        });
};
// ==================登陆相关============================================================

// ==================注册角色============================================================
// 注册的回调
var RegisterCallBack = function(responseStr) {
    var repStr = MGC_Comm.strToJson(responseStr);
    console.log("创建角色回调" + responseStr);
    var _res = parseInt(repStr.res);
    var msg = '';
    switch (_res) {
        case 0:
            // 关闭注册模式
            try {
                EAS.SendClick({ 'e_c': 'mgc.regist.succ', 'c_t': 4 });
            } catch (e) {

            }
            MGCData.isRegister = false;
            $m('#popSr').val('输入QQ昵称').css({ "color": "#bcbcbc" });
            showDialog.hide();
            MGC_Comm.CommonDialog({ "Title": "提示", "Note": "创建角色成功。" }, function() { });
            if (MGC_Comm.isTransferRequest) {
                window.location.reload();
            }
            // 然后进行房间
            if ($m.cookie("mgcZoneId") && $m.cookie("mgcZoneId").length > 0) {
                MGCLoginRequest.roleSelectLogin($m.cookie("mgcZoneId"));
            }
            else {
                MGCLoginRequest.roleSelectLogin(MGCData.mgcZoneId);
            }
            break;
        case 1:
            try {
                EAS.SendClick({ 'e_c': 'mgc.regist.error.1', 'c_t': 4 });
            } catch (e) {

            }
            msg = '请输入昵称！';
            break;
        case 2:
            try {
                EAS.SendClick({ 'e_c': 'mgc.regist.error.2', 'c_t': 4 });
            } catch (e) {

            }

            msg = '该昵称不可使用，请您重新输入！';
            break;
        case 3:
            try {
                EAS.SendClick({ 'e_c': 'mgc.regist.error.3', 'c_t': 4 });
            } catch (e) {

            }
            msg = '该昵称已被使用，请您重新输入！';
            break;
        case 4:
            try {
                EAS.SendClick({ 'e_c': 'mgc.regist.error.4', 'c_t': 4 });
            } catch (e) {

            }
            msg = '角色已存在，请您重新输入！';
            break;
        default:
            try {
                EAS.SendClick({ 'e_c': 'mgc.regist.error.5', 'c_t': 4 });
            } catch (e) {

            }
            msg = '该昵称不可使用，请您重新输入！';
            break;
    }
    if (msg != '') {
        $m('.pop_nick_info').html(msg).css('color', 'red');
    }
    return;
};
// 注册发起请求
var MGCRegisterRequest = function() {
    var _userNick = $m.trim($m("#popSr").val());
    var msg = '';
    if (_userNick.length == 0 || _userNick == '输入QQ昵称') {
        msg = '请输入昵称！';
    }
    if (_userNick.length > 12) {
        msg = '昵称长度限制12个字符';
    }
    if (msg != '') {
        $m('.pop_nick_info').html(msg).css('color', 'red');
        return false;
    }

    if (_userNick != randomUserName) {
        nick_pool = -1;
        nick_record_id = -1;
    }

    var _userGender = parseInt($m("#userGender").val());

    var _reqStr;
    if ($m.cookie("mgcZoneId") && $m.cookie("mgcZoneId").length > 0) {
        console.log('注册新用户请求：op_type=119' + '  zoneid=' + MGCData.mgcZoneId + '  nick=' + _userNick + "   gender=" + _userGender + "   nick_pool =" + nick_pool + "  nick_record_id=" + nick_record_id);
        _reqStr = { "op_type": 119, "zoneid": ($m.cookie("mgcZoneId")), "nick": _userNick, "gender": _userGender, "nick_pool": nick_pool, "nick_record_id": nick_record_id };
    }
    else {
        console.log('注册新用户请求2：op_type=119' + '  zoneid=' + MGCData.mgcZoneId + '  nick=' + _userNick + "   gender=" + _userGender + "   nick_pool =" + nick_pool + "  nick_record_id=" + nick_record_id);
        _reqStr = { "op_type": 119, "zoneid": MGCData.mgcZoneId, "nick": _userNick, "gender": _userGender, "nick_pool": nick_pool, "nick_record_id": nick_record_id };
    }
    console.log("创建角色请求：" + _reqStr);
    MGC_Comm.sendMsg(_reqStr, "RegisterCallBack");
    return;
};

//获取昵称
var MGCNicknameRequest = function(nick) {
    var _userGender = parseInt($m("#userGender").val());
    console.log('获取随机昵称发起请求：op_type=234' + '  nick_pool=' + nick_pool + '  gender=' + _userGender);
    MGC_Comm.sendMsg({ "op_type": 234, "last_nick_pool": nick_pool, "gender": _userGender }, "NicknameCallBack");
};
var randomUserName = "";
var nick_pool = -1;
var nick_record_id = -1;
var NicknameCallBack = function(responseStr) {
    console.log('获取随机昵称返回字符串：responseStr.nick =  ' + responseStr.nick + '  responseStr.nick_pool = ' + responseStr.nick_pool + ' responseStr.nick_record_id= ' + responseStr.nick_record_id);
    responseStr = MGC_Comm.strToJson(responseStr);
    randomUserName = responseStr.nick;
    nick_pool = responseStr.nick_pool;
    nick_record_id = responseStr.nick_record_id;

    if (randomUserName && randomUserName.length > 0) {
        $m('#popSr').val(randomUserName);
        $m('#popSr').css("color", "#000000");
        $m('.pop_nick_info').children().remove();
    }
    else {
        $m('.pop_nick_info').html('获取昵称失败！').css('color', 'red');
    }

};

//检测昵称
var MGCCheckNickRequest = function(nick) {
    MGC_Comm.sendMsg({ "op_type": OpType.CheckDupNickOpType, "nick": nick }, "CheckNickCallBack");
};

var CheckNickCallBack = function(responseStr) {
    responseStr = MGC_Comm.strToJson(responseStr);
    var msg = '',
        color = 'red';
    switch (parseInt(responseStr.res)) {
        case 0:
            msg = '该昵称可用！';
            color = 'green';
            break;
        case 1:
            msg = '请输入昵称！';
            break;
        case 2:
            msg = '该昵称不可使用，请您重新输入！';
            break;
        case 3:
            msg = '该昵称已被使用，请您重新输入！';
            break;
        default:
            msg = '该昵称不可使用，请您重新输入！';
            break;
    }
    $m('.pop_nick_info').html(msg).css('color', color);
};

// 开始注册模式
var StartRegister = function() {
    MGCData.isRegister = true;
    if ($m.cookie("mgcZoneId") && $m.cookie("mgcZoneId").length > 0) {
        MGCLoginRequest.areaLogin($m.cookie("mgcZoneId"));
    }
    else {
        MGCLoginRequest.areaLogin(MGCData.mgcZoneId);
    }
};

/** 
    * 判断浏览器是否支持某一个CSS3属性 
    * @param {String} 属性名称  animation-play-state
    * @return {Boolean} true/false 
    * @version 1.0 
    * alert(mgc.tools.supportCss3('animation-play-state').toString())
    */
var supportCss3 = function (style) {
    var prefix = ['webkit', 'Moz', 'ms', 'o'],
    i,
    humpString = [],
    htmlStyle = document.documentElement.style,
    _toHumb = function (string) {
        return string.replace(/-(\w)/g, function ($0, $1) {
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
测试接口，每秒接收一次数据集合
VOT_LoadTreasureBoxData: int = 17;
VOT_RefreshGiftPoolHeight: int = 34;
VOT_ReceiveGift: int = 36;
VOT_OnReceiveChatMsg: int = 46;
VOT_RoomSkinLevelUpTaskInfo: int = 305;
VOT_RoomSkinDailyTaskInfo: int = 306;
*/
function response_as_list(jsonstr) {
    if (jsonstr && jsonstr.length > 0) {
        for (var i = 0; i < jsonstr.length; i++) {
            response_as(jsonstr[i]);
        }
    }
}
// ==================注册角色============================================================
//window.debuggerArr= [305, 33, 37, -11, 46, 217, 29, 17, 36, 38, 34, 279, 28, 232, 277, 276, 39, 235, 286, 42, 15];
// 响应处理统一方法,主动请求的先写在这里
function response_as(jsonstr) {
    //jsonstr = MGC_Comm.strToJson(jsonstr);
    if (window.debuggerArr) {
        if (window.debuggerArr.length > 0) {
        if ($.inArray(jsonstr.op_type, window.debuggerArr) >= 0) {
                //放行消息
            } else {
                //屏蔽消息
            jsonstr = null;
            return;
        }
        } else {
            return;
        }
    }
    if (jsonstr.op_type == -3) {
        // flash加载完成统一调用的方法
        webInit();
    } else if (jsonstr.op_type == -4) {
        MGC_Comm.CommonDialog({
            "Note": "很抱歉，与服务器连接超时。"
        }, function() {
            window.location.reload();
        });
    } else if (jsonstr.op_type == -8) {
        //MGC_Comm.LiveVideoStart();
        MGC_SWFINIT.LiveVideo = true;
        if (LiveCDNUrl != null && LiveCDNUrl != undefined) {
            video_response(LiveCDNUrl);
        };
    } else if (jsonstr.op_type == -6) {
        console.log("function response_as:"+jsonstr);
        MGC_SWFINIT.GiftSwf = true;
        if ($m("#default_gift_bg")) {
            $m("#default_gift_bg").height(0);
            $m("#default_gift_bg").find("img").hide();
        }
        //周星礼物
        if (GiftRankPane != null) {
            GiftRankPane.init();
        }
        //快捷送礼
        if (GiftQuickPane != null) {
            GiftQuickPane.init();
        }
        if (!($m.cookie("commTips_gift_cookie_room"))) {
            $m.cookie("commTips_gift_cookie_room", true, {
                expires: 24 * 60 * 60 * 1000,
                path: '/',
                domain: '.qq.com'
            })
            if (($m.cookie("commTips_gift_cookie") || $m.cookie("commTips_gift_cookie")=='true') && ($m.cookie("mgc_roomGuide_undefined_") == MGC_roomGuideResp.cookieRoomValue) && ($m.cookie("mgc_roomGuide_undefined_") == '2048')) {
                $m('.commTips_gift').show();
            }
        }        

        if (LiveRoomData != undefined && LiveRoomData != null) {
            gift_response(LiveRoomData);
        }
        if (MGC_SWFINIT.playerInfo) {
            gift_response(MGC_SWFINIT.playerInfo);
            eventgift_response(MGC_SWFINIT.playerInfo);
        }
        if (guard_level_resp_data) {
             gift_response(guard_level_resp_data);
             guard_level_resp_data = null;
        }
    } else if (jsonstr.op_type == 153) {
        MGC_CommResponse.hasActCallBack(jsonstr);
    } else if (jsonstr.op_type == 154) {
        gift_response(jsonstr);
        if (jsonstr.res == 65) {
            window.mgc.common_logic.CheckNameError(154);
        }
    } else if (jsonstr.op_type == 199) {
        MGC_CommResponse.CompleteOnlineTask(jsonstr);
    } else if (jsonstr.op_type == 272) {
        MGC_CommResponse.CompleteGiftRank(jsonstr);//冠名成功
    } else if (jsonstr.op_type == 35) {//房间信息回调
        video_response(jsonstr);
        gift_response(jsonstr);
        MGC_Response(jsonstr);
        eventgift_response(jsonstr);
        MGCData.isConcert = jsonstr.isConcert;
    } else if (jsonstr.op_type == 178) {//服务器连接状态回调
        video_response(jsonstr);
        MGC_Response(jsonstr);
        if (MGC_SWFINIT.GiftSwf == true) {
            gift_response(jsonstr);
        };
    } else if (jsonstr.op_type == 200) {//刷新分屏直播信息
        video_response(jsonstr);
    } else if (jsonstr.op_type == 201) {//分屏直播开启
        video_response(jsonstr);
    } else if (jsonstr.op_type == 202) {//分屏直播关闭
        video_response(jsonstr);
    } else if (jsonstr.op_type == 203) {//是否游客
        video_response(jsonstr);
        gift_response(jsonstr);
    } else if (jsonstr.op_type == 289) {//是否弹任务中心tips引导提示
        MGC_CommResponse.taskCenterGuide();
    } else if (jsonstr.op_type == 116 || jsonstr.op_type == 117) {//关注 取消关注
        video_response(jsonstr);
    } else if (jsonstr.op_type == 192) {//*获取签到信息
        MGC_CommResponse.getSignInfoCallBack(jsonstr);
    } else {
        /* 通用回调方法 */
        MGC_Response(jsonstr);

        // 送礼通用处理
        if (MGC_SWFINIT.GiftSwf == true) {
            gift_response(jsonstr);
            eventgift_response(jsonstr);
        } else {
            if (jsonstr.op_type == 236) {
                guard_level_resp_data = jsonstr;
            }
        }
    }
    jsonstr = null;
};

var guard_level_resp_data;

MGC_CommRequest.checkRoomStatus = function(roomId) {
    var _reqStr = "{\"op_type\":172,\"roomid\":" + roomId + "}";
    MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.checkRoomStatusCallBack");
}

MGC_CommRequest.getRechargeNotice = function() {
    var _reqStr = "{\"op_type\":185}";
    MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.RechargeNoticeCallBack");
}
MGC_CommResponse.checkRoomStatusCallBack = function(callback_obj) {
    MGC_Comm.log("退出返回：" + JSON.stringify(callback_obj));
    callback_obj = MGC_Comm.strToJson(callback_obj);
    if (callback_obj.result == 0 || (callback_obj.result == 59 && callback_obj.isNestRoom)) { //可以进入(小窝房间未直播状态也是可以进入的)
        var source = parseInt(MGC_Comm.getUrlParam('source'));
        var module_type = parseInt(MGC_Comm.getUrlParam('module_type'));
        var page_capacity = parseInt(MGC_Comm.getUrlParam('page_capacity'));
        var room_list_pos = parseInt(MGC_Comm.getUrlParam('room_list_pos'));
        var tagId = parseInt(MGC_Comm.getUrlParam('tag_id'));
        source = source >= 0 ? source : 0;
        if (callback_obj.isSuperRoom) {
            //var _url = showRoomUrl;
            var _url = showRoomUrl + "?roomId=" + callback_obj.roomId + "&source=" + source + "&tag_id=" + tagId + "&module_type=" + module_type + "&page_capacity=" + page_capacity + "&room_list_pos=" + room_list_pos;
        } else {
            //var _url = liveRoomUrl;
            var _url = liveRoomUrl + "?roomId=" + callback_obj.roomId + "&source=" + source + "&tag_id=" + tagId + "&module_type=" + module_type + "&page_capacity=" + page_capacity + "&room_list_pos=" + room_list_pos;
        }
        if (callback_obj.isNestRoom) {//小窝isNestRoom:是否是小窝房间
            var _url = caveolaeRoomUrl + "?roomId=" + callback_obj.roomId + "&source=" + source + "&tag_id=" + tagId + "&module_type=" + module_type + "&page_capacity=" + page_capacity + "&room_list_pos=" + room_list_pos;
        }
        /*$m('#submitForm').attr('action', _url);
        $m('#formRoomId').val(callback_obj.roomId);
        $m('#submitForm').submit();*/
        window.location.href = window.mgc.tools.changeUrlToLivearea(_url);
    } else {
        var msg = '';
        switch (callback_obj.result) {
            case 1:
                msg = '进入房间:未知错误';
                break;
            case 2:
                msg = '进入房间错误';
                break;
            case 3:
                msg = '服务器忙';
                break;
            case 11:
                msg = '对不起，您没有权限';
                break;
            case 12:
                msg = '这个房间不存在';
                break;
            case 17:
                msg = '您被暂时禁止进入';
                break;
            case 22:
                msg = '视频区网路错误';
                break;
            case 24:
                msg = '对不起，无法进入主播专用房间';
                break;
            case 28:
                msg = '对不起，该房间已封，无法进入';
                break;
            case 35:
                msg = '操作频繁，请稍后再试';
                break;
            case 36:
                msg = '当前房间内人太多，挤房失败了';
                break;
            case 41:
                msg = '视频服务器已关闭';
                break;
            case 47:
                msg = '这个房间已经关闭了';
                break;
            case 50:
                msg = '当前房间内人太多，挤房失败了';
                break;
            case 51: //达到挤房的上线
                msg = '房间人满。如果拥有贵族身份，或者成为当前主播的天使守护及以上，可以优先的进入人满房间哦~<br>今日剩余挤房次数：-';
                break;
            case 53:
                msg = '这个房间已经被关闭了';
                break;
            case 55:
                msg = '对不起，由于现在进入房间的人数太多，导致服务器压力过大，请稍后再试';
                break;
            case 56:
                msg = '您现在没有门票，快去购票吧！购买成功后，需要重新进入演唱会房间才可以观看。';
                break;
            case 57:
                msg = '对不起，没有这个房间。';
                break;
            case 58:
                msg = '对不起，没有这个房间。';
                break;
            case 59:
                msg = '当前房间没有直播内容，精彩内容稍后上演。';
                break;
            case 60:
                msg = '对不起，没有这个房间。';
                break;
            case 61:
                msg = 'WEB端不能进入音频房间。';
                break;
            default:
                msg = '未知错误';
        }
        MGC_Comm.CommonDialog({
            "Title": "提示",
            "Note": msg
        }, function() {
            window.location.href = window.mgc.tools.changeUrlToLivearea(home);
        });
    }
}

MGC_CommResponse.RechargeNoticeCallBack = function(callback_obj) {
    if (typeof (callback_obj) == 'object') {

    } else {
        callback_obj = MGC_Comm.strToJson(callback_obj);
    };
    var msg = "";
    $m.each(callback_obj.friendpay, function(k, v) {
        msg += '恭喜您，收到好友(' + v.qq + ')【' + v.nick + '】的礼物：' + v.amount + '炫豆<br>';
    });

    //var msg = '恭喜您，收到好友(' + callback_obj.friendpay[0].qq + ')【' + callback_obj.friendpay[0].nick + '】的礼物：' + callback_obj.friendpay[0].amount + '炫豆';
    MGC_Comm.CommonDialog({
        "Title": "提示",
        "Note": msg
    });

}

function showVideoAS() {
    var swfobj = getSWF('LiveVideoSwfContainer');
    try {
        swfobj.showAS();
    } catch (e) {
        console.log(e.message);
    }
}

function hideVideoAS() {
    var swfobj = getSWF('LiveVideoSwfContainer');
    try {
        swfobj.hideAS();
    } catch (e) {
        console.log(e.message);
    }
}

function showAS() {
    $m('#x51VideoWeb').attr("width", "800px;").attr("height", "200px;").show();
    var swfobj = getSWF('GiftSwf');
    try {
        swfobj.showLog();
    } catch (e) {
        console.log(e.message);
    }
}

function hideAS() {
    $m('#x51VideoWeb').attr("width", "1px;").attr("height", "1px;").hide();
    var swfobj = getSWF('GiftSwf');
    try {
        swfobj.hideLog();
    } catch (e) {
        console.log(e.message);
    }
}

function invitationSubmit() {
    var playId = $m(".invitationBtn").attr("data_targetId");
    var showAreaName = $m(".invitationBtn").attr("data_showAreaName").replace("炫舞-", "");
    var _reqStr = { "op_type": 72, "target_id": playId, "inv_from": 4 };
    MGC_Comm.sendMsg(_reqStr, "invitationCallBack");
}

function invitationCallBack(obj) {
    switch (obj.result) {
        case 0:
            MGC_Comm.CommonDialog({ "Title": "提示", "Note": "您的邀请信息已发出，请耐心等待！" });
            break;
        case 14:
            MGC_Comm.CommonDialog({ "Title": "提示", "Note": "对方已加入后援团，无法邀请！" });
            break;
        case 19:
            MGC_Comm.CommonDialog({ "Title": "提示", "Note": "您所在的后援团已经人满，无法邀请！" });
            break;
        case 45:
            MGC_Comm.CommonDialog({ "Title": "提示", "Note": "邀请失败，移动端登录的用户无法接受邀请。" });
            break;
        default: // case 5 / case 22 / case 35
            MGC_Comm.CommonDialog({ "Title": "提示", "Note": "当前对方无法接受邀请，请稍后再尝试！" });
            break;
    }
}

function showCloseTips(e, val) {
    var t = (e.pageY == undefined ? e.clientY : e.pageY) - 3, l = (e.pageX == undefined ? e.clientX : e.pageX) + 30;
    //  var t = e.target.offsetTop -3;
    //  var l = e.target.offsetLeft + 30;
    if (document.all) {
        var scrollXY = mgc.tools.offsetEvent.scrollXY();
        t += scrollXY.Y, l += scrollXY.X;
    }
    if (val == '') {
        return false;
    }
    var windowW = $(window).width() + $(window).scrollLeft();
    // 110为提示 '该用户已不在房间中' 的宽度
    l = (l + 110 >= windowW) ? (windowW - 110) : l;
    var susTips = $j(".sus_tips_list3");
    susTips.css({ "top": t, "left": l, "width": 110 });
    susTips.text(val);
    //susTips.show();
    window.mgc.popmanager.layerControlShow(susTips, 2, 3);
    setTimeout(function() {
        susTips.animate({
            opacity: "hide"
        }, "slow");
    }, 1000);
}

// 加载flash对象
//MGC_Comm.setSwfObj();

(function($) {
    $.mZone = function(mz) {
        return (mz == "梦工厂" ? mz : "炫舞-" + mz);
    };
})($m);

$m(function() {
    return;
    // 快速进入房间事件绑定
    MGC_Comm.bindSearch();
    // 显示玩家隐身状态栏
    MGC_Comm.showUserStatus();
    //活动中心点击
    $m('#mgc_hdzx').on('click', function() {
        try {
            EAS.SendClick({ 'e_c': 'mgc.actcenter', 'c_t': 4 });
        } catch (e) {

        }
    });
    //个人中心点击
    $m('#mgc_personal').on('click', function() {
        try {
            EAS.SendClick({ 'e_c': 'mgc.personal', 'c_t': 4 });
        } catch (e) {

        }
    });
}); /* |xGv00|17390fc5c448c4599e11d3e5059ffd3e */ /*  |xGv00|9bef166a3f6cdbd2651ec1a4dc5acc80 */
//web端房间内自主模拟消息下发、监测js逻辑内存泄漏问题
//setTimeout(function() {
//    //屏蔽逻辑flash消息下发
//    //mgc.tools.callopt({ "op_type": 90001, "open": true, "block_all": true, "pass_list": [46, 36] });
//    ////逻辑flash消息轮询
//    //mgc.tools.callopt({ "op_type": 90002, "opt_list": [46], "timerInterval": 500 });
//    //超级粉丝模板数据
//    //var fansData = { "_useStr": false, "ret": 0, "data": [{ "baned": false, "viplevel": 4, "zoneName": "大区108", "guardIcon": "guard_lv200", "anchorName": "收破烂ぃ强子", "affinity": "420850", "video_level": 51, "wealth_level": 9, "total_affinity": "628920", "jacket": 0, "perpentralBaned": false, "playerZoneID": 108, "credits_level": 0, "playerID": "949982648699266", "wealth": "13208855", "guardlevel": 200, "vipName": "亲王", "playerName": "哎呀呀呀呀呀", "male": true, "anchorID": "0", "vipIcon": "vip_lv4", "nickColor": "#8f00b1", "portraitUrl": "http://113.108.77.71:80/qdancersec/icdfC9J3MJsjeXnMAj8MibCrvZMNAwpShoW9xbFvxQPWr23YkpibjRicZQ/0?v=1467627056/0?v=16018208", "m_pk_richman_order": 0 }, { "baned": false, "viplevel": 5, "zoneName": "大区108", "guardIcon": "guard_lv200", "anchorName": "收破烂ぃ强子", "affinity": "264377", "video_level": 42, "wealth_level": 6, "total_affinity": "264377", "jacket": 0, "perpentralBaned": false, "playerZoneID": 108, "credits_level": 0, "playerID": "949982912871284", "wealth": "550585", "guardlevel": 200, "vipName": "皇帝", "playerName": "心心祝啊2", "male": true, "anchorID": "0", "vipIcon": "vip_lv5", "nickColor": "#ae5600", "portraitUrl": "", "m_pk_richman_order": 0 }, { "baned": false, "viplevel": 3, "zoneName": "梦工厂", "guardIcon": "guard_lv100", "anchorName": "收破烂ぃ强子", "affinity": "135069", "video_level": 80, "wealth_level": 9, "total_affinity": "135069", "jacket": 0, "perpentralBaned": false, "playerZoneID": 888, "credits_level": 0, "playerID": "7810935470193524", "wealth": "22135897", "guardlevel": 100, "vipName": "将军", "playerName": "WQQQQQWWQQQW", "male": true, "anchorID": "0", "vipIcon": "vip_lv3", "nickColor": "#0a57af", "portraitUrl": "http://113.108.77.71:80/qdancersec/AT4b7rWtPsjnIMZXCicliccrzwZsiarYufhaPJN5WnwkRooWmp9XuLWrg/0?v=1467628280/0?v=529458666", "m_pk_richman_order": 0 }, { "baned": false, "viplevel": 1, "zoneName": "梦工厂", "guardIcon": "guard_lv100", "anchorName": "收破烂ぃ强子", "affinity": "99", "video_level": 41, "wealth_level": 5, "total_affinity": "134431", "jacket": 0, "perpentralBaned": false, "playerZoneID": 888, "credits_level": 0, "playerID": "7810930740536420", "wealth": "134869", "guardlevel": 100, "vipName": "近卫", "playerName": "QQ炫舞", "male": false, "anchorID": "0", "vipIcon": "vip_lv1", "nickColor": "#1a6b00", "portraitUrl": "", "m_pk_richman_order": 0 }], "_count": 18, "op_type": 28, "fanstype": 0, "_isNewInterface": false };
//    //主播面板数据
//    //var anchorData = { "isFollow": false, "ret": 0, "roomName": "强子的绿色直播间", "_count": 15, "op_type": 29, "data": { "anchor_score": 0, "m_pk_anchor_winner_order": 0, "m_starlight_today_needed": 0, "anchor_level": 63, "m_impression_data": { "m_total_count": 5719, "m_player_count": 1771, "m_impressions": [{ "m_impression_id": 1, "m_impression_name": "阳光", "m_count": 670 }, { "m_impression_id": 9, "m_impression_name": "王子", "m_count": 580 }, { "m_impression_id": 14, "m_impression_name": "搞笑", "m_count": 442 }, { "m_impression_id": 21, "m_impression_name": "霸气", "m_count": 310 }, { "m_impression_id": 2, "m_impression_name": "可爱", "m_count": 274 }, { "m_impression_id": 3, "m_impression_name": "呆萌", "m_count": 242 }, { "m_impression_id": 13, "m_impression_name": "傲娇受", "m_count": 180 }, { "m_impression_id": 19, "m_impression_name": "才艺达人", "m_count": 176 }, { "m_impression_id": 20, "m_impression_name": "另类", "m_count": 173 }, { "m_impression_id": 10, "m_impression_name": "大叔", "m_count": 146 }, { "m_impression_id": 4, "m_impression_name": "性感", "m_count": 143 }, { "m_impression_id": 18, "m_impression_name": "段子手", "m_count": 141 }, { "m_impression_id": 5, "m_impression_name": "小清新", "m_count": 139 }, { "m_impression_id": 15, "m_impression_name": "情歌王", "m_count": 133 }, { "m_impression_id": 16, "m_impression_name": "天籁音", "m_count": 121 }, { "m_impression_id": 17, "m_impression_name": "脱口秀", "m_count": 119 }, { "m_impression_id": 28, "m_impression_name": "逗比", "m_count": 118 }, { "m_impression_id": 6, "m_impression_name": "卡哇伊", "m_count": 110 }, { "m_impression_id": 7, "m_impression_name": "治愈系", "m_count": 106 }, { "m_impression_id": 23, "m_impression_name": "重口味", "m_count": 106 }, { "m_impression_id": 11, "m_impression_name": "正太", "m_count": 99 }, { "m_impression_id": 8, "m_impression_name": "女王", "m_count": 90 }, { "m_impression_id": 31, "m_impression_name": "男神", "m_count": 86 }, { "m_impression_id": 22, "m_impression_name": "腹黑", "m_count": 60 }, { "m_impression_id": 51, "m_impression_name": "男神经", "m_count": 58 }, { "m_impression_id": 58, "m_impression_name": "我爱的人", "m_count": 42 }, { "m_impression_id": 47, "m_impression_name": "点券王子", "m_count": 41 }, { "m_impression_id": 35, "m_impression_name": "duang", "m_count": 39 }, { "m_impression_id": 33, "m_impression_name": "实力派", "m_count": 37 }, { "m_impression_id": 45, "m_impression_name": "坑货", "m_count": 36 }, { "m_impression_id": 32, "m_impression_name": "天然呆", "m_count": 34 }, { "m_impression_id": 37, "m_impression_name": "男人味", "m_count": 34 }, { "m_impression_id": 56, "m_impression_name": "暖男", "m_count": 34 }, { "m_impression_id": 43, "m_impression_name": "屌丝", "m_count": 33 }, { "m_impression_id": 59, "m_impression_name": "犀利哥", "m_count": 33 }, { "m_impression_id": 27, "m_impression_name": "虎比", "m_count": 29 }, { "m_impression_id": 61, "m_impression_name": "小鲜肉", "m_count": 29 }, { "m_impression_id": 34, "m_impression_name": "偶像派", "m_count": 28 }, { "m_impression_id": 38, "m_impression_name": "骨感美", "m_count": 26 }, { "m_impression_id": 41, "m_impression_name": "萌萌哒", "m_count": 26 }, { "m_impression_id": 53, "m_impression_name": "蛇精病", "m_count": 26 }, { "m_impression_id": 54, "m_impression_name": "职业坑", "m_count": 25 }, { "m_impression_id": 55, "m_impression_name": "大白", "m_count": 25 }, { "m_impression_id": 24, "m_impression_name": "大叔控", "m_count": 22 }, { "m_impression_id": 40, "m_impression_name": "钻戒帝", "m_count": 22 }, { "m_impression_id": 29, "m_impression_name": "如花", "m_count": 21 }, { "m_impression_id": 50, "m_impression_name": "古灵精怪", "m_count": 21 }, { "m_impression_id": 30, "m_impression_name": "高冷", "m_count": 20 }, { "m_impression_id": 42, "m_impression_name": "花篮哥", "m_count": 20 }, { "m_impression_id": 44, "m_impression_name": "高冷", "m_count": 20 }, { "m_impression_id": 48, "m_impression_name": "闭卷大神", "m_count": 20 }, { "m_impression_id": 39, "m_impression_name": "烟花王", "m_count": 19 }, { "m_impression_id": 46, "m_impression_name": "霸道总裁", "m_count": 19 }, { "m_impression_id": 49, "m_impression_name": "威猛先生", "m_count": 19 }, { "m_impression_id": 57, "m_impression_name": "有钱任性", "m_count": 19 }, { "m_impression_id": 26, "m_impression_name": "肌肉男", "m_count": 17 }, { "m_impression_id": 25, "m_impression_name": "软淑萌", "m_count": 16 }, { "m_impression_id": 52, "m_impression_name": "女神经", "m_count": 15 }, { "m_impression_id": 60, "m_impression_name": "吃货", "m_count": 15 }, { "m_impression_id": 36, "m_impression_name": "御姐", "m_count": 13 }, { "m_impression_id": 12, "m_impression_name": "未知", "m_count": 2 }] }, "talent_show_rank": 0, "room_id": 0, "anchor_badge": 0, "status": 0, "name": "收破烂ぃ强子", "is_nest": false, "is_anchor_with_dance_mark": false, "anchorID": "476458527", "order_change": 0, "followedAudiences": 7, "anchor_levelup_exp": 1389500, "anchorQQ": "476458527", "is_bottleneck": false, "gameID": "", "anchor_gender": 0, "bottleneck_count": -1, "popularity": 90808172, "bottleneck_need_count": 0, "star_anchor": false, "bottleneck_gift_id": 0, "twoweek_starlight": "100", "starlight_rest_exp_today": -78937, "intro": "万般努力只为出人头地\r\n主播QQ：476458527\r\n粉丝群：437764273", "dream_gift_rest_exp_today": 30000, "from": "中国", "male": true, "lucky_draw_rest_exp_today": 60000, "photoUrl": "http://113.108.77.71:80/qdancersec/ajNVdqHZLLDJAOLejwiaQMa5gGnoYCvcqPpx5Orks23RiaehaMWY3MBcOpHTUNnTjZcu5C2HLj5tM/0?v=1467626917/0?v=874078558", "is_basic_info": false, "imageUrl": "http://113.108.77.71:80/qdancer/476458527/zone_1_anchor_image_476458527.jpg/0", "starlight": "94604177", "deputy_name": "", "deputy_zone_name": "", "anchor_exp": 193709 }, "_useStr": false, "_isNewInterface": false };
//    //定时发送消息
//    //var _chatReqStr = { "op_type": 24, "channelID": 0, "receiverName": "", "receiverZoneName": "", "msg": "33333" };
//    //////定时轮询
//    //setInterval(function() {
//    //    //MGC_Response(anchorData);
//    //    MGC_Comm.sendMsg(_chatReqStr, "MGC_CommResponse.SendMsgChatCallBack");
//    //}, 200);
//    //web端屏蔽某消息
//    //window.debuggerArr = [36];
//}, 5000);