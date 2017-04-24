/*
 * Author:             77
 * Version:            1.0 (2015/11/11)
 * Discription:        room模块视图:主要初始化直播间内部公共组件
 * @todo:
 */
define(['backbone', 'jquery', 'mgc_templates', 'swfobject', 'mgc_tool', 'mgc_popmanager'], function(backbone, $, templates, swfobject, tool, mgc_popmanager) {
    var room_view = {};

    room_view.VideoView = backbone.View.extend({

        id: "LiveVideoSwfContainer",

        //视频flash
        flash: null,

        initialize: function() {
            this.render();
        },

        render: function() {
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
            var params = {};
            params.quality = "high";
            params.bgcolor = "#000";
            params.allowscriptaccess = "always";
            params.allowfullscreen = "true";
            params.allowFullScreenInteractive = "true";
            params.wmode = "transparent";
            var attributes = {};
            var swfurl = "x51VideoPlayer.swf?v=3_8_8_2016_15_4_final_3";
            if (tool.checkIsIEloadSwfFailed())
                swfurl += "&r=" + new Date();
            swfobject.embedSWF(swfurl, this.id, "100%", "100%", "11.1.0", '', flashvars, params, attributes);

            this.flash = tool.getSWF(this.id);
        },

        //接受服务器广播消息
        broadcast: function(jsonstr) {
            var op_type = parseInt(jsonstr.op_type);
            if (op_type == 35 || op_type == 52 || op_type == 53 || op_type == 116 || op_type == 117 || op_type == 178 || op_type == 200 || op_type == 201 || op_type == 202 || op_type == 203) {
                this.flash.request_as(jsonstr);
            }
        }
    });

    //嘉宾席
    room_view.vipListView = backbone.View.extend({
        el: "#vipContainer",
        initialize: function() {
            this.template = $('#vipTmpl');
            this.listenTo(this.model, 'change', this.render);
        },
        render: function() {
            var vipInfoList = this.model.getVipInfoList();
            var tmpl = this.template.tmpl(vipInfoList);
            this.$el.html(tmpl);
            tmpl = null;
        },
        events: {
            'mouseover i': 'mouseOverI',
            'mouseout i': 'mouseOutI',
            'click i': 'clickI'
        },
        clickI: function(e) {
            var name = $(e.currentTarget).attr('name');
            var zoneName = $(e.currentTarget).attr('zonename').replace("炫舞-", "");
            if (zoneName != '') {
                var mgc_room = require("mgc_room");
                mgc_room.room_request.getPlayerInfo(name, zoneName, e);
            }
        },
        mouseOverI: function(e) {
            var thisEle = e.srcElement || e.target;
            var attr = $(thisEle).attr("mgc_vip_info");
            this.susTipsLvList(e, 1, attr, thisEle, 'sus_tips_LvList');
        },
        mouseOutI: function(e) {
            var thisEle = e.srcElement || e.target;
            this.susTipsLvList(e, 0, '', thisEle, 'sus_tips_LvList');
        },
        susTipsLvList: function(e, n, val, obj, tem) {
            var _e = e.target == undefined ? e.toElement : e.target;
            var arr = {}, sum = 0;

            if ((n == 1 && val == '') || (n == 1 && val == "|@abc|@abc|@abc|@abc|@abc|@abc") || (n == 1 && val == "|@abc|@abc|@abc|@abc|@abc|@abc;cursor: auto") || (n == 1 && val == "|@abc|@abc|@abc|@abc|@abc;cursor: auto") || (n == 1 && val == "|@abc|@abc|@abc|@abc|@abc;cursor: auto|@abc")) {
                return false;
            }
            var susTips = $("." + tem);
            susTips.children().remove();
            if (n == 1) {
                if (val != '') {
                    val = $(obj).attr("name") + "|@abc" + val;
                    arr = val.split('|@abc');
                    if (arr[5] > 5) {
                        sum = 8 - arr[5];
                        sum2 = 0;
                    } else {
                        sum = 5 - arr[5];
                        sum2 = 92;
                    }
                    var t = $(_e).offset().top + 61;
                    var l = $(_e).offset().left + 80;
                    susTips.css({
                        "top": t,
                        "left": l
                    });
                    susTips.append("<p>名字：<strong style='color:" + arr[6] + "'>" + arr[0] + "</strong></p><p>等级：LV" + arr[1] + "</p><p>财富等级：" + arr[2] + "</p><p>财富值：" + arr[3] + "</p><p>贵族身份：" + arr[4] + "</p><p>大区：" + arr[7] + "</p>");
                }
                mgc_popmanager.layerControlShow(susTips, 1, 3);
            } else {
                mgc_popmanager.layerControlHide(susTips, 1, 3);
            }
        }
    });

    return room_view;
});
