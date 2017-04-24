// jQuery url get parameters function [获取URL的GET参数值]
// <code>
//     var GET = $.urlGet(); //获取URL的Get参数
//     var id = GET['id']; //取得id的值
// </code>
//  url get parameters
//  public
//  return array()
(function ($m) {
    $m.extend({
        urlGet: function () {
            var aQuery = window.location.href.split("?");
            //取得Get参数
            var aGET = new Array();
            if (aQuery.length > 1) {
                var aBuf = aQuery[1].split("&");
                for (var i = 0, iLoop = aBuf.length; i < iLoop; i++) {
                    var aTmp = aBuf[i].split("=");
                    //分离key与Value
                    aGET[aTmp[0]] = aTmp[1];
                }
            }
            return aGET;
        }
    })
})(jQuery);

var Video = {

    init:function(){

        /*高度为主居中
        var height = $(window).height();
        var width = height * (4/3);

        //尺寸
        $(".video_flash").width(width);
        $(".video_flash").height(height);

        //居中
        $(".video_flash").offset({left:($(window).width() - width)/2});
        */

        $(window).resize(this.resize);

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
        attributes.id = "LiveVideoSwfContainer";
        attributes.name = "LiveVideoSwfContainer";
        attributes.align = "middle";

        var swfurl = "x51VideoPlayer.swf?v=3_8_8_2016_15_4_final_3";
        /*
        if (MGC.browser().ie7 || MGC.browser().qqbrowser) {
            swfurl += "&r=" + Math.random();
        }
        */
        swfobject.embedSWF(swfurl, "LiveVideoSwfContainer", "100%", "100%",
            swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
    },

    response:function (JsonStr) {
        var swfobj = getSWF('LiveVideoSwfContainer');
        try {
            swfobj.request_as(JsonStr);
        } catch (e) {
            console.log(e.message);
        }
    },

    resize:function(){
        //宽度为主居中
        var width = $(window).width();
        var height = width * (3/4);

        //尺寸
        $(".video_flash").width(width);
        $(".video_flash").height(height);

        //上下裁剪
        var cutHeight = ($(window).height() - height)/2;
        $(".video_flash").css("margin-top",cutHeight);

        //视频区音量条位置
        var swfobj = getSWF('LiveVideoSwfContainer');
        swfobj.setMarginTop(Math.abs(cutHeight));
    }

}

MGC_Comm = {

    room_id:0,

    init:function(){
        this.setSwfObj();
        Video.init();

        //获取页面的url参数
        var data = $.urlGet();
        if (data.room_id) {
            this.room_id = data.room_id;
        }
    },

    // 无登录态请求时
    noLoginRoleList: function() {
        //var _reqStr = "{\"op_type\":128,\"qq\":0,\"vertify_info\":\"\",\"m_device_type\":5,\"m_appid\":1600000566,\"m_skey\":\"\"}";
        var _reqStr = {op_type:128,qq:0,vertify_info:"",m_device_type:5,m_appid:1600000566,m_skey:""};
        MGC_Comm.sendMsg(_reqStr, "RoleListCallBack", 1);
    },

    // 连接大区服务器
    areaLogin: function() {
        //var _reqStr = "{\"op_type\":-2, \"zoneid\":" + 30889 + ",\"qq\":" + 0 + ",\"vertify_info\":\"" + 0 + "\",\"m_device_type\":5,\"m_appid\":1600000566,\"m_skey\":\"\"}";
        var _reqStr = {op_type:-2,zoneid:30889,qq:0,vertify_info:"",m_device_type:5,m_appid:1600000566,m_skey:"",channel:3};
        MGC_Comm.sendMsg(_reqStr, "AreaLoginCallBack");
    },

    setSwfObj: function () {
        var swfV = swfobject.getFlashPlayerVersion();
        if (swfV == null || typeof swfV == 'undefined' || swfV.major == 0) {
            var DialogObj = {};
            DialogObj.Note = "��û�а�װflash���밲װ���°�flash";
            MGC_Comm.CommonDialog(DialogObj, function () {
                /*window.location.reload();*/
            });
        } else if (parseInt(swfV.major) < 11) {
            var DialogObj = {};
            DialogObj.Note = "����flash�汾���ͣ�������װ���°�flash";
            MGC_Comm.CommonDialog(DialogObj, function () {
                /*window.location.reload();*/
            });
        };
        var swfVersionStr = "11.1.0";
        var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
        var flashvars = {};
        flashvars.isDrainage = true;
        flashvars.isOldFrame = "true";
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

        var swfUrl = "x51VideoWeb.swf?v=3_8_8_2016_15_4_final_3";

        if (navigator.userAgent.toLowerCase().indexOf("qqbrowser")>0)
            swfUrl += "&r=" + new Date();
        swfobject.embedSWF(swfUrl, "flashContent", "1000", "200", swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);

        swfobject.createCSS("#flashContent", "display:block;text-align:left;");
    },

    // 统一发送接口
    sendMsg: function(_reqStr, callback, param1) {
        try {
            var swfobj = getSWF('x51VideoWeb');
            if (swfobj) {
                _reqStr = typeof (_reqStr) == "string" ? eval('(' + _reqStr + ')') : _reqStr;
                swfobj.request_as(_reqStr, callback, param1);
            }
        } catch (e) {
            console.log(e.message);
            setTimeout(function() {
                MGC_Comm.sendMsg(_reqStr, callback);
            }, 50);
        }
    },

    strToJson: function (responseStr) {
        if (typeof (responseStr) != 'object') {
            var aresponseStr = responseStr.replace(/\r\n/g, "<br>");
            return JSON.parse(aresponseStr);
        } else {
            return responseStr;
        }
    }
}

// 请求角色列表的回调方法
var RoleListCallBack = function(responseStr, noLogin) {
    var repStr = MGC_Comm.strToJson(responseStr);

    MGC_Comm.areaLogin();
}

//连接大区服务器回调
var AreaLoginCallBack = function(responseStr) {
    var repStr = MGC_Comm.strToJson(responseStr)

    var _reqStr ={op_type:290,roomID:MGC_Comm.room_id};
    MGC_Comm.sendMsg(_reqStr);
}

function response_as(jsonstr) {
    var obj = MGC_Comm.strToJson(jsonstr);
    switch (parseInt(obj.op_type))
    {
        //逻辑flash加载完毕
        case -3:
            MGC_Comm.noLoginRoleList();
            break;

        //视频flash加载完毕
        case -8:
            Video.resize();
            break;

        default :
            Video.response(jsonstr);
            break;
    }
}


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