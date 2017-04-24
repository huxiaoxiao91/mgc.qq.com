/**
 * Created by HXX on 2016/12/20.
 */

define(['underscore', 'backbone', 'jquery', 'mgc_callcenter', 'mgc_consts', 'mgc_chat'], function(_, Backbone, $, callcenter, consts, chat) {

    var secretOrder = {};
    var secretOrderTimer = null;
    var lastSeconds = 0;
    var countDownConfig = 10;//密令宝箱在倒计时最后N秒显示特效

    secretOrder.secretOrderModel = Backbone.Model.extend({
        defaults: {
            /**
             * 密令按钮 id
             */
            secretOrderId: -1,
            isShow: false,
            hoverTips: "",
            countTime: -1 //倒计时
        }
    });

    secretOrder.secretOrderView = Backbone.View.extend({
        el: "#secret-order",

        model: secretOrder.secretOrderModel,

        timer: null,

        events: {
            "mouseover #secret-order-box": "secretOrderMouseover",
            "mouseleave #secret-order-box": "secretOrderMouseleave",
            "click #secret-order-box": "secretOrderClick"
        },

        initialize: function(model, countTime) {
            this.secretOrderBoxSwfInit(true);
            this.secretOrderLastNSecondsSwfInit(true);
            this.listenTo(this.model, 'change:hoverTipsTitle', this.setHoverTips);
            this.listenTo(this.model, 'change:hoverTipsContent', this.setHoverTips);
            this.listenTo(this.model, 'change:isShow', this.secretOrderBtnShow);
            this.listenTo(this.model, 'change:countTime', this.secretOrderCountTimeUpdate);

        },
        setHoverTips: function() {
            // 设置鼠标移入 tips
            this.hoverTipsTitle = this.model.get("hoverTipsTitle");
            this.hoverTipsContent = this.model.get("hoverTipsContent");
            this.$el.find(".hover-tips .secret-order-title").html(this.hoverTipsTitle);
            this.$el.find(".hover-tips .secret-order-content").html(this.hoverTipsContent);
        },
        // 密令按钮展示
        secretOrderBtnShow: function() {
            clearInterval(secretOrderTimer);

            var secretOrderPane = this.$el;

            var swf = mgc.tools.getSWF("SecretOrderBoxSwf");
            //隐藏倒计时 n 秒的特效
            if ($("#secretOrderLastNSecondsSwf")) {
                $("#secretOrderLastNSecondsSwf").hide();
            }
            // 如果上一个密令按钮未消失,添加效果
            if (secretOrderPane.css("display") == "block") {
                //显示密令按钮叠加特效
                swf.setBoxStatus(1);
            }
            
            // 显示密令按钮
            secretOrderPane.show();
            this.secretOrderCountTimeUpdate();
            
        },

        secretOrderCountTimeUpdate: function() {
            clearInterval(secretOrderTimer);

            var secretOrderPane = this.$el;

            // 倒计时开始
            var startTime = new Date().getTime();
            var second = mgc.secretOrderModel.get("countTime"); 
            var s = second;

            secretOrderTimer = setInterval(function() {
                var nowTime = new Date().getTime();
                var selTime = second - Math.floor((nowTime - startTime) / 1000);
                if (selTime < s) {
                    s = selTime;
                }
                if (s >= 0) {
                    if(s <= countDownConfig){//密令宝箱在倒计时最后N秒显示特效
                        if ($("#secretOrderLastNSecondsSwf")) {
                            $("#secretOrderLastNSecondsSwf").show();
                        }
                    }
                } else {
                    clearInterval(secretOrderTimer);
                    secretOrderPane.hide();
                }
                s--;
            }, 1000);
        },

        // 密令按钮鼠标移入事件
        secretOrderMouseover: function(event) {
            this.$el.find(".hover-tips").show();
        },

        // 密令按钮鼠标移出事件
        secretOrderMouseleave: function() {
            this.$el.find(".hover-tips").hide();
        },

        // 密令按钮点击事件
        secretOrderClick: function() {
            console.log("密令按钮点击，需要发送请求");

            // 密令按钮消失
            this.$el.hide();
            clearInterval(secretOrderTimer);

            callcenter.send_secret_box_clicked(false);
        },

        /**
         * 下发主播设置（默认）的密令
         * secretCode
         */
        notifytAnchorSecretCode: function(resp, params) {
            consts.secretOrderInfo = resp.secretCode;
        },
        /**
         * 通知玩家密令宝箱倒计时变化
         * lastSeconds 剩余的秒数
         * endTime 结束的时间戳
         */
        notifyPlayerSecretHeatBox: function(resp, params) {
            lastSeconds = resp.lastSeconds - 1;
            mgc.openTipModel.set("boxid", resp.boxId);
            mgc.secretOrderModel.set("isShow", !(mgc.secretOrderModel.get("isShow")));
            mgc.secretOrderModel.set("countTime", (resp.lastSeconds - 1));
            //剩余time
            callcenter.get_system_time(function(resp, param) {
                var second = param.endTime - resp.server_time;
                //倒计时校准
                second = second > (param.lastSeconds - 1) ? (param.lastSeconds - 1) : second;
                mgc.secretOrderModel.set("countTime", second);
            }, resp);

        },
        // 获得宝箱数据展示
        //获得宝箱数据的提示
        getBoxGiftActionCallBack: function(resp, params) {
            if (MGC_Comm.CheckGuestStatus(true)) {
                console.log("屏蔽游客操作：获得宝箱数据动画");
                return false; //游客身份下，屏蔽此操作
            }
            console.log("获取宝箱数据Action：" + JSON.stringify(resp));
            resp = MGC_Comm.strToJson(resp);

            //宝箱开启提示
            if (resp.res == 0 || resp.res == 8) {
                mgc.openTipModel.set("boxid", resp.boxid);
            }

            if ((resp.online && resp.res == 0) || (resp.online && resp.res == 9)) {
                var popInfo = {};
                //popInfo.showTips = "房间热度奖励";
                popInfo.reward = {};
                popInfo.reward.count_desc = resp.truelyReward[0].count_desc;
                popInfo.reward.name = resp.truelyReward[0].name;
                popInfo.reward.tips = resp.truelyReward[0].tips;
                popInfo.reward.url = resp.truelyReward[0].channel == 0 ? resp.truelyReward[0].url : resp.truelyReward[0].channel == 3 ? resp.truelyReward[0].url : resp.truelyReward[0].channel == 4 ? resp.truelyReward[0].url : resp.truelyReward[0].channel == 2 ? ("http://ossweb-img.qq.com/images/mgc/css_img" + resp.truelyReward[0].url + "?v=3_8_8_2016_15_4_final_3") : ("http://ossweb-img.qq.com/images/mgc/css_img" + resp.truelyReward[0].url + "?v=3_8_8_2016_15_4_final_3");

                if (resp.truelyReward[0].channel == 3) {
                    if (resp.truelyReward[0].url == '') {
                        resp.truelyReward[0].url = "http://ossweb-img.qq.com/images/mgc/css_img/common/game_default.png?v=3_8_8_2016_15_4_final_3";
                    }
                    Qgame = true;
                }
                if (MgcAPI.SNSBrowser.IsQQGame()) {
                    Qgame = true;
                }
                popInfo.reward.anchor_level = MGCData.anchor_level;
                if (popInfo.reward.name == "梦幻币" || popInfo.reward.name == "经验") {
                    popInfo.reward.buff_percent = "(+" + resp.buff_percent + "%)";
                } else {
                    popInfo.reward.buff_percent = "";
                }

                if (resp.res == 0) {
                    popInfo.showTips = "热度宝箱已开启！恭喜您获得：";
                } else if (resp.res == 9) {
                    popInfo.showTips = "补发热度宝箱奖励：";
                }

                if (Qgame) {
                    if (resp.is_reissue) {
                        popInfo.showTips = "本期热度宝箱奖励已发完，您获得安慰奖：";
                    } else {
                        //popInfo.showTips = "获得房间热度奖励~（如获得游戏道具，会自动放入您的QQ游戏大厅背包中）";
                        //popInfo.showTips = "热度宝箱已开启！恭喜您获得：";
                    }
                    popInfo.showTips_game = "";
                } else {
                    if (resp.hasgame) {
                        if(window.mgc.config.channel == 0){
                            popInfo.showTips_game = "（获得的游戏道具会直接进入游戏背包）";
                        }else{
                            popInfo.showTips_game = "（获得的游戏道具以邮件发送至电脑端）";
                        }
                        //popInfo.showTips = "热度宝箱已开启！恭喜您获得：";
                    } else {
                        popInfo.showTips_game = "";
                        //popInfo.showTips = "热度宝箱已开启！恭喜您获得：";
                    }
                }

                var tipObj = {};
                tipObj.showTips = popInfo.showTips;
                tipObj.name = popInfo.reward.name;
                tipObj.count_desc = popInfo.reward.count_desc;
                tipObj.buff_percent = popInfo.reward.buff_percent;
                tipObj.showTips_game = popInfo.showTips_game;
                if (resp.last_hit_player_name.length > 0) {
                    tipObj.lastHitPlayerName = resp.last_hit_player_name[0];
                    tipObj.isLastking = true;
                } else {
                    tipObj.isLastking = false;
                }
                //var rewardTip = "<span>" + popInfo.showTips + popInfo.reward.name + " x" + popInfo.reward.count_desc + popInfo.reward.buff_percent + popInfo.showTips_game + "</span>";
                mgc.rewardTipModel.addTip(tipObj);

                //获得遗失在房间里的热度宝箱奖励(主播下线未开的宝箱奖励)
            } else if ((!resp.online && resp.res == 0) || (!resp.online && resp.res == 9)) {

                console.log("获取宝箱数据Action处理后：" + JSON.stringify(resp));
                $m('.video_title').hide();
                var popInfo = {};
                //popInfo.lostReward = "这是你在房间遗失的奖励~请查收~";
                popInfo.showTips = "补发热度宝箱奖励：";
                popInfo.showTips_game = "";
                popInfo.reward = resp.truelyReward;
                $m.each(popInfo.reward, function(k, v) {
                    var url = v.channel == 0 ? v.url : v.channel == 3 ? v.url : v.channel == 4 ? v.url : v.channel == 2 ? ("http://ossweb-img.qq.com/images/mgc/css_img" + v.url + "?v=3_8_8_2016_15_4_final_3") : ("http://ossweb-img.qq.com/images/mgc/css_img" + v.url + "?v=3_8_8_2016_15_4_final_3");
                    v.url = url;
                    v.Qgame = false;
                    if (v.channel == 3) {
                        if (v.url == '') {
                            v.url = "http://ossweb-img.qq.com/images/mgc/css_img/common/game_default.png?v=3_8_8_2016_15_4_final_3";
                        }
                        v.Qgame = true;
                    }
                    v.anchor_level = resp.anchor_level;
                    //v.buff_percent = resp.buff_percent;
                    if (v.name == "梦幻币" || v.name == "经验") {
                        v.buff_percent = "(+" + resp.buff_percent + "%)";
                    } else {
                        v.buff_percent = "";
                    }

                    if (MgcAPI.SNSBrowser.IsQQGame()) {
                        Qgame = true;
                    }
                    indexNum = 1;
                    if (Qgame) {
                        popInfo.showTips_game = "";
                    } else {
                        if (resp.hasgame == true) {
                            if(window.mgc.config.channel == 0){
                                popInfo.showTips_game = "（获得的游戏道具会直接进入游戏背包）";
                            }else{
                                popInfo.showTips_game = "（获得的游戏道具以邮件发放到电脑端）";
                            }
                        } else {
                            popInfo.showTips_game = "";
                        }
                    }

                    //var rewardTip = "<span>" + popInfo.showTips + v.name + " x" + v.count_desc + v.buff_percent + popInfo.showTips_game + "</span>"
                    var tipObj = {};
                    tipObj.showTips = popInfo.showTips;
                    tipObj.name = v.name;
                    tipObj.count_desc = v.count_desc;
                    tipObj.buff_percent = v.buff_percent;
                    tipObj.showTips_game = popInfo.showTips_game;
                    if (resp.last_hit_player_name.length > 0) {
                        tipObj.lastHitPlayerName = resp.last_hit_player_name[k];
                        tipObj.isLastking = true;
                    } else {
                        tipObj.isLastking = false;
                    }
                    mgc.rewardTipModel.addTip(tipObj);
                });

            }
        },
        /*
         *初始化密令按钮
         */
        secretOrderBoxSwfInit: function() {
            var surpruseBox = $("#secret-order");

            if ($("#SecretOrderBoxSwf")) {
                $("#SecretOrderBoxSwf").remove();
            }
            if ($("#secret-order-box-swf").length == 0) {
                $("<div id='secret-order-box-swf'></div>").appendTo(surpruseBox);
            }
            var swfVersionStr1 = "11.1.0";
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
            attributes.id = "SecretOrderBoxSwf";
            attributes.name = "SecretOrderBoxSwf";
            attributes.align = "middle";

            var swfurl = "assets/secret_order_flash.swf?v=3_8_8_2016_15_4_final_3" + "&r=" + Math.random();
            swfobject.embedSWF(swfurl, "secret-order-box-swf", "100%", "100%", swfVersionStr1, xiSwfUrlStr, flashvars, params, attributes);
        },
        /**
         * 密令宝箱在倒计时的最后 n 秒显示特效
         */
        secretOrderLastNSecondsSwfInit: function(){
            var secretOrderBox = $("#secret-order");

            if ($("#secretOrderLastNSecondsSwf")) {
                $("#secretOrderLastNSecondsSwf").remove();
            }
            if ($("#secret-order-last-seconds-swf").length == 0) {
                $("<div id='secret-order-last-seconds-swf'></div>").appendTo(secretOrderBox);
            }
            var swfVersionStr1 = "11.1.0";
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
            attributes.id = "secretOrderLastNSecondsSwf";
            attributes.name = "secretOrderLastNSecondsSwf";
            attributes.align = "middle";

            var swfurl = "assets/secret_order_last_seconds.swf?v=3_8_8_2016_15_4_final_3" + "&r=" + Math.random();
            swfobject.embedSWF(swfurl, "secret-order-last-seconds-swf", "100%", "100%", swfVersionStr1, xiSwfUrlStr, flashvars, params, attributes);
        }

    });

    window.mgc.secretOrder = secretOrder;

    return secretOrder;

});
