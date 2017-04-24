/**
 * Created by user on 2015/9/28.
 */
requirejs.config({
    shim: {
        login_manager: {
            deps: [],
            exports: 'LoginManager'
        },
        eas: {
            exports: 'eas'
        },
        tgadshow: {
            exports: 'tgadshow'
        },
        mgc_ad: {
            deps: [],
            exports: 'mgc_ad'
        }
    },
    paths: {
        login_manager: 'http://ossweb-img.qq.com/images/js/login/loginmanagerv3',
        eas: 'http://ossweb-img.qq.com/images/js/eas/eas',
        tgadshow: 'http://ossweb-img.qq.com/images/js/comm/tgadshow.min',
        mgc_ad: 'http://mgc.qq.com/upload/x5/x5mgc/ad'
    }
});
define(['login_manager', 'jquery', 'mgc_consts', 'mgc_tool', 'backbone', 'mgc_popmanager'], function(loginmanager, $, consts, tool, backbone, mgc_popmanager) {
    var account = {};
    var DEFAULT_COOKIE_NAME = 'mgc_login';
    var ZONEID_COOKIE = 'mgc_zoneid';
    var secToMinRate = 60;
    var msToSecRate = 1000;
    var checkLoginTimeout;
    var checkLoginTimes = 30 * 60 * 1000;
    //qq账号的登录逻辑
    var qqaccount = {};
    qqaccount.is_guest = false;
    qqaccount.clear_cookie = function() {
        tool.cookie("mgc_login", null, { path: '/', domain: 'mgc.qq.com' });
        tool.cookie("IED_LOG_INFO2", null, { path: '/', domain: '.qq.com' });
        tool.cookie("mgc_zoneid", null, { path: '/', domain: '.qq.com' });
    }
    qqaccount.login = function(callback, cancelcallback) {
        //房间内引导登录隐藏登录窗口
        $(".commTips,.register_guide_bg,.commTips_gift,.commTips_punchCard").hide();
        loginmanager.login(callback, tool.pageSource().appid);
        loginmanager.closeLogin(cancelcallback);
    };
    qqaccount.closeLogin = function(callback) {
        loginmanager.closeLogin(callback);
    }
    //检测登录态
    qqaccount.checkLogin = function(callback_a, callback_b, is_loginmanager) {
        //是否启用loginmanager的checklogin
        if (is_loginmanager) {
            //x52 checklogin
            if (MgcAPI.SNSBrowser.IsX52()) {
                if (qqaccount.getUin()) {
                    if (callback_a)
                        callback_a();
                } else {
                    qqaccount.checkLoginCallback(false, callback_b);
                }
            } else {
                loginmanager.checkLogin(function() {
                    qqaccount.checkLoginCallback(true, callback_a);
                }, function() {
                    qqaccount.checkLoginCallback(false, callback_b);
                });
            }
        } else {
            //登录续期
            mgc.callcenter.renewal_account_login(function(resp, param) {
                console.log("服务端续期：" + JSON.stringify(resp));
                if (resp.res == 0 || resp.res == 2) { //res:0   续期成功  ； res:2   续期超时
                    qqaccount.checkLoginCallback(true, callback_a);
                } else {
                    qqaccount.checkLoginCallback(false, callback_b);
                }
            }, null, true);
        }
        console.log("检测登录：loginmanager.checkLogin");
    }
    qqaccount.checkLoginCallback = function(islogin, callback) {
        if (islogin) {
            console.log("有登录态：" + qqaccount.getUin());
            tool.EAS([{ 'e_c': 'mgc.loginuser', 'c_t': 4 }]);            
            //每半小时检测一次
            if (checkLoginTimeout)
                clearTimeout(checkLoginTimeout);
            checkLoginTimeout = setTimeout(qqaccount.checkLogin, checkLoginTimes);
        } else {
            //检测登录异常
            console.log("未检测到登录态:");
            tool.EAS([{ 'e_c': 'mgc.visitor', 'c_t': 4 }]);            
            if (MgcAPI.SNSBrowser.IsQQGameLiveArea() != "true") {
            if (MgcAPI.SNSBrowser.IsQQGame()) {
                console.log("未检测到登录态：过期提醒");
                tool.commonDialog({ "Note": "对不起，由于您的登录状态已过期，请重新登录梦工厂。" }, function() {
                    GameAPI.SNSBrowser.Close();
                }, function() {
                    GameAPI.SNSBrowser.Close();
                });
                return false;
            } else if (MgcAPI.SNSBrowser.IsX52()) {
                console.log("未检测到登录态：过期提醒");
                tool.commonDialog({ "Note": "对不起，由于您的登录状态已过期，请重新登录梦工厂。" }, function() {
                    //todo
                }, function() {
                    //todo
                });
                return false;
            } else {
                if (!callback) {
                    //检测登录异常时，清除缓存
                    mgc.account.hasSkey = false;
                    account.logout();
                    account.clear_cookie();
                    mgc.comm_model.getLoginBarModel.toggle(false);
                        mgc.callcenter.query_clear_login_cookie(function() {
                        console.log("cookie cleared!");
                        var myTime = new Date();
                        var filename = window.location.href;
                        tool.cookie("mgc_logError_qqaccount_checkLoginCallback", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___Test-the-login-state-expired___web--qqaccount_checkLoginCallback-islogin-false___filename" + filename, {
                            path: '/',
                            domain: '.qq.com'
                        });
                    });
                    tool.commonDialog({ "Note": "对不起，由于您的登录状态已过期，请重新登录梦工厂。" }, function() {
                        tool.hideDialog();
                        $("#login-bar-btn").click();
                    }, function() {
                        tool.hideDialog();
                        $("#login-bar-btn").click();
                    });
                    return false;
                }
            }
        }
        }
        if (callback)
            callback();
    }
    qqaccount.getUin = function() {
        if (MgcAPI.SNSBrowser.IsX52()) {
            return qqaccount.getCookie("x52_uin");
        } else {
            return loginmanager.getUserUin();
        }
    }
    qqaccount.getSkey = function() {
        if (MgcAPI.SNSBrowser.IsX52()) {
            return qqaccount.getCookie("x52_skey");
        }
        else {
            return qqaccount.getCookie("skey");
        }
    }
    qqaccount.logout = function(callback) {
        loginmanager.logout(callback);
        var myTime = new Date();
        var filename = window.location.href;
        tool.cookie("mgc_logError_qqaccount_logout", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___qqaccount_logout___web--qqaccount_logout___filename" + filename, {
            path: '/',
            domain: '.qq.com'
        });
    }
    qqaccount.isLogin = function() {
        return loginmanager.isLogin();
    }
    qqaccount.getCookie = function(cookieName) {
        var _name = (typeof cookieName == mgc.consts.classtype.UNDEFINED) ? DEFAULT_COOKIE_NAME : cookieName;
        return tool.cookie(_name);
    }
    qqaccount.checkGuestStatus = function(isDoLogin) {
        if (qqaccount.is_guest && !isDoLogin) {
            $("#login-bar-btn").click();
        }
        return qqaccount.is_guest;
    }
    qqaccount.checkLoginStatus = function () {
        if (!qqaccount.getUin()) {
            $("#login-bar-btn").click();
        }
        return !qqaccount.getUin();
    }
    //清除游客标量
    qqaccount.delGuestCookie = function() {
        qqaccount.is_guest = false;
    }
    //skey是否存在标示
    qqaccount.hasSkey = true;
    if (!window.mgc) {
        window.mgc = {};
    }
    account = qqaccount;
    window.mgc.account = account;
    return account;
});