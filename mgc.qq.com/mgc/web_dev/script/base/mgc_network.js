/**
 * Created by Zhangqing on 2015/9/28.
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
define(['mgc_tool', 'swfobject'], function(tool, swfobject) {
    console.log("body mgc_network.js load");
    var swfV = swfobject.getFlashPlayerVersion();
    if (swfV == null || typeof swfV == 'undefined' || swfV.major == 0) {
        var DialogObj = {};
        DialogObj.Note = "您没有安装flash，请安装最新版flash";
        tool.commonDialog(DialogObj, function() {
            /*window.location.reload();*/
        });
    } else if (parseInt(swfV.major) < 14) {
        var DialogObj = {};
        DialogObj.Note = "您的flash版本过低，请您安装最新版flash";
        tool.commonDialog(DialogObj, function() {
            /*window.location.reload();*/
        });
    };
    var flash = {};
    var swfElementStr = "flashContent";
    var swfUrl = "x51VideoWeb.swf?v=3_8_8_2016_15_4_final_3";
    if (tool.browser.ie7 || tool.browser.ie8 || tool.browser.ie11 || tool.browser.qqbrowser) {
        swfUrl += "&r=" + Math.random();
    }
    var swfVersionStr = "11.1.0";
    var xiSwfUrlStr = "http://172.17.100.30/x5videoWeb/playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
    var flashvars = {};
    flashvars.isOldFrame = "false";
    //区分出新老版本消息发送
    if (tool.is_group_page() || tool.is_show_room() || tool.is_live_room() || tool.is_caveolae_room() || tool.is_nest_room()) {
        flashvars.isOldFrame = "true";
    }
    var params = {};
    params.quality = "high";
    params.bgcolor = "#ffffff";
    params.allowscriptaccess = "always";
    params.allowfullscreen = "true";
    params.wmode = "transparent";
    var attributes = {};
    attributes.id = "x51VideoWeb";
    attributes.name = "x51VideoWeb";
    attributes.align = "middle";
    var swfWidth = "1";
    var swfHeight = "1";

    var network = {};
    /**
     * 查看flash的接口是否可以调用，可以调用则认为已经加载完成
     * @returns {*}
     */
    network.isFlashInited = function() {
        flash = tool.getSWF("x51VideoWeb");
        try {
            return flash.isReady();
        } catch (ex) {
            return false;
        }
    };
    /**
     *  代码加载时立刻初始化swf
     */
    network.FlashInit = function() {
        console.log("initswf:" + swfUrl);
        swfobject.embedSWF(swfUrl, swfElementStr, swfWidth, swfHeight, swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
        flash = tool.getSWF(attributes.id);
    };
    var broadcast_callback = null;
    network.listenToBroadcastMsg = function(callback) {
        broadcast_callback = callback;
    };
    var login_change_callback = null;
    network.listenToLoginChanged = function(callback) {
        login_change_callback = callback;
    };
    //测试接口，每秒接收一次数据集合
    network.recvMsg_list = function(jsonstr, params) {
        if (jsonstr && jsonstr.length > 0) {
            for (var i = 0; i < jsonstr.length; i++) {
                network.recvMsg(jsonstr[i]);
            }
        }
    }
    network.recvMsg = function(jsonstr, params) {
        //测试 window.debuggerArr= [305, 33, 37, -11, 46, 217, 29, 17, 36, 38, 34, 279, 28, 232, 277, 276, 39, 235, 286, 42, 15];
        if (window.debuggerArr) {
            if (window.debuggerArr.length > 0) {
                if ($.inArray(jsonstr.op_type, window.debuggerArr) >= 0) {
                    //放行消息
                } else {
                    //屏蔽消息
                    jsonstr = null;
                    params = null;
                    return;
                }
            } else {
                return;
            }
        }
        console.log("network---recvMsg:" + JSON.stringify(jsonstr));
        var callback_obj = (params == undefined || params.callback_str == undefined) ? null : req_callbacks[params.callback_str];
        if (callback_obj) {
            if (callback_obj.callback && callback_obj.caller) {
                callback_obj.callback.apply(callback_obj.caller, [jsonstr, params]);
            }
            else if (callback_obj.callback) {
                callback_obj.callback(jsonstr, params);
            }
            else {
                broadcast_callback(jsonstr, params);
            }
            return;
        }
        broadcast_callback(jsonstr, params);
        jsonstr = null;
        params = null;
        callback_obj = null;
    };

    var req_callbacks = [];
    /**
     * 通过flash逻辑控件发送网络消息
     * @param _req   消息内容
     * @param callback  回调
     * @param param1    附加参数
     */
    network.sendMsg = function(_req, callback, params) {
        try {
            console.log("network---sendmessage:" + JSON.stringify(_req));
            params || (params = {}) && (params.caller = '');
            if (callback) {
                req_callbacks[params.callback_str] = { callback: callback, caller: params.caller };
            }
            params.caller && (params.caller = '');
            flash.request_as(_req, "mgc.network.recvMsg", params);
        } catch (e) {
            console.log(e.message);
            setTimeout(function() {
                network.sendMsg(_req, callback, params);
            }, 200);
        }
    };

    network.login_changed = function() {
        login_change_callback();
    };

    /**
     * network不应该开放到全局给其他模块使用，需要使用network的模块必须直接引用该模块，以免写出跨层的坑爹逻辑,但是flash的回调需要访问一个全局的函数。以后有更好的处理方法干掉这里。Todo
     */
    if (!window.mgc) {
        window.mgc = {};
    }
    window.mgc.network = network;
    return network;
});