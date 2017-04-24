/**
 * Created by Shixinqi on 2015/11/11.
 */
define(['jqtmpl', 'mgc_login', 'mgc_account', 'mgc_callcenter', 'mgc_comm_view', 'mgc_show_view', 'mgc_comm', 'mgc_tool', 'swfobject', 'mgc_popmanager', 'js_scrollpane', 'js_mousewheel'], function(jqtmpl, login, account, callcenter, comm_view, show_view, mgc_comm, tool, swfobject, mgc_popmanager, js_scrollpane, js_mousewheel) {
    var comm = {};
    //针对QGame注册事件:变更链接跳转方式
    tool.changeLinkTo();
    tool.topFun();
    var loginCallback = null;
    //TAB页加载，默认选中xxTab页
    var tab_coll = new mgc.show_coll.TabColl();
    var tab_arr = [{ "tag_id": 1, "tag_name": "首页", "tag_url": "index.shtml", "target": "", "display": "dis-block" }, { "tag_id": 2, "tag_name": "娱乐表演", "tag_url": "show.shtml", "target": "", "display": "dis-block" }, { "tag_id": 3, "tag_name": "排行榜", "tag_url": "ranklist.shtml", "target": "_blank", "display": "dis-block" }, { "tag_id": 4, "tag_name": "活动", "tag_url": "http://mgc.qq.com/cp/a20151231music/index.htm", "target": "_blank", "display": "dis-block" }, { "tag_id": 5, "tag_name": "快速充值", "tag_url": "http://pay.qq.com/ipay/index.shtml?c=qxwwqp", "target": "_blank", "display": "dis-none" }];
    var default_select = 0;
    if (tool.filename() == "") {
        default_select = 1;
    } else {
        $.each(tab_arr, function(i, o) {
            if (o.tag_url == tool.filename()) {
                default_select = o.tag_id;
                return;
            }
        });
    }
    tab_coll.reset(tab_arr);
    var tab_nav_view = new show_view.TabNavView('#nav', tab_coll, default_select, null);
    //搜索组件
    var search_bar_view = new comm_view.SearchBarView();
    // 初始化签到效果swf
    var signFlashInit = function() {
        var flashvars = {};
        var params = {};
        params.quality = "high";
        params.bgcolor = "#000";
        params.allowscriptaccess = "always";
        params.allowfullscreen = "true";
        params.allowFullScreenInteractive = "true";
        params.wmode = "transparent";
        var attributes = {};
        var swfurl = "assets/signin.swf?v=3_8_8_2016_15_4_final_3";
        swfobject.embedSWF(swfurl, "header_sign_flash",
            "100%", "100%", "11.1.0", '', flashvars, params, attributes);
    };
    signFlashInit();
    if (MgcAPI.SNSBrowser.IsX52()) {
        tool.setXW2Cookie();
    }
    var doLogin = function() {
        comm_view.getViewLoginBar(mgc.comm_model.getLoginBarModel, qqloginCallback, getPlayerInfoCallback);
        //先检测、才能获取uin
        account.checkLogin(function() {
            //有登录态的情况下
            console.log("logined" + account.getUin());
            mgc.comm_model.getLoginBarModel.toggle(true);
            qqloginCallback(false);
        }, function() {
            //无登录态的情况下
            console.log("not logined");
            callcenter.query_clear_login_cookie(function() {
                console.log("cookie cleared!");
                var myTime = new Date();
                var filename = window.location.href;
                tool.cookie("mgc_logError_main_entry_doLogin", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___unLogin_state___web--main_entry_doLogin-unLogin_state___account_checkLogin_unLogin___filename" + filename, {
                    path: '/',
                    domain: '.qq.com'
                });
            });
            mgc.comm_model.getLoginBarModel.toggle(false);
            if (tool.is_in_room_page()) {
                qqloginCallback(true);
            } else {
                qqloginCallback(false);
            }
        }, true);
    };
    var qqloginCallback = function(use_guest) {
        login.doLoginVideo(loginCallback, use_guest);
    };
    var getPlayerInfoCallback = function() {
        login.getPlayerInfo();
    };
    var qqloginCancelCallback = function() {
        //todo
    };
    comm.onNetworkInited = function(_login_callback) {
        //初始化回调
        loginCallback = _login_callback;
        //监听登录
        doLogin();
    };
    return comm;
});