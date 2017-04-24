/**
 * Created by HXX on 2016/12/22.
 */

define(['underscore', 'backbone', 'jquery', 'mgc_callcenter', 'mgc_consts', 'mgc_hotbox'], function (_, Backbone, $, callcenter, consts, hotbox) {

    var lastKing = {};
    var posCavroom = [27, 69, 116, 163];
    var posLiveroom = [30, 86, 141, 196];
    var posShowRoom = [25, 63, 102, 142];
    var pos = [];
    var roomType = 0;

    lastKing.lastKingModel = Backbone.Model.extend({
        defaults: {
            /**
            * 第几个箱子的补刀王 index
            */
            lastKingBoxIndex: -1,
            isShow: false,
            hoverTips: "",
            rewardList: []
        }
    });

    lastKing.lastKingView = Backbone.View.extend({
        el: ".progress_hot_spar",

        model: lastKing.lastKingModel,

        timer: null,

        initialize: function (model, id) {
            var href = window.location.href;
            if (href.indexOf("caveolaeroom.shtml") >= 0 || href.indexOf("nest.shtml") >= 0) {
                pos = posCavroom;
                roomType = 0;
            } else if (href.indexOf("liveroom.shtml") >= 0) {
                pos = posLiveroom;
                roomType = 1;
            } else if(href.indexOf("showroom.shtml") >= 0){
                pos = posShowRoom;
                roomType = 2;
            }
            this.listenTo(this.model, 'change:isShow', this.progressBarBgChange);
        },

        // 补刀王奖励动画
        lastKingBoxReward: function () {
            
            // 设置鼠标移入 tips
            var boxId = this.model.get("lastKingBoxIndex");
            var lastKingRewards = this.model.get("rewardList");

            for (var i = 0, n = lastKingRewards.length; i < n; i++) {
                hotbox.addTip(lastKingRewards[i]);
            }
            // 补刀王产生：热度宝箱已完成的进度条原色/红色交替闪烁
            this.progressBarBgChange();
        },
        // 补刀王动画
        progressBarBgChange: function () {

            // 弹出补刀王教学 5s 
            if(mgc.consts.isFinishEducation == 0){
                var tips = "激活每个宝箱的最后一个礼物送出者会获得补刀王奖励！还有三倍奖励哦！";
                $("#last-king-edu").html(tips);
                this.showEducationTips($("#last-king-edu"), tips, mgc.lastKingModel.get("lastKingBoxIndex"));
            }

            mgc.lastKingModel.set("lastKingBoxIndex", -1);

            var elms = $(".progress_hot_spar .p_bar .bgSpan");
            clearInterval(consts.lastKingTimer);
            consts.lastKingTimer = setInterval(function(){
                if($(".progress_hot_spar .p_bar .bgSpan").hasClass("red")){
                    $(".progress_hot_spar .p_bar .bgSpan").removeClass("red");
                    // 演唱会房间特殊处理
                    if(roomType == 2){
                        $(".progress_hot_spar .p_bar .showSpan").removeClass("red");
                    }
                }else{
                    $(".progress_hot_spar .p_bar .bgSpan").addClass("red");
                    // 演唱会房间特殊处理
                    if(roomType == 2){
                        $(".progress_hot_spar .p_bar .showSpan").addClass("red");
                    }
                }
                
            }, 300);
        },

        //补刀王玩家的奖励
        notifyLastHitPlayerReward: function (resp, params) {
            var popInfo = {};
            popInfo.showTips = "补刀王奖励！恭喜您获得:";
            popInfo.showTips_game = "";
            popInfo.reward = resp.truelyReward;

            $m.each(popInfo.reward, function (k, v) {
                var url = v.channel == 0 ? v.url : v.channel == 3 ? v.url : v.channel == 4 ? v.url : v.channel == 2 ? ("http://ossweb-img.qq.com/images/mgc/css_img" + v.url + "?v=3_8_8_2016_15_4_final_3") : ("http://ossweb-img.qq.com/images/mgc/css_img" + v.url + "?v=3_8_8_2016_15_4_final_3");
                v.url = url;
                v.Qgame = false;
               
                if (resp.hasgame == true) {
                    if(window.mgc.config.channel == 0){
                        popInfo.showTips_game = "（获得的游戏道具会直接进入游戏背包）";
                    }else{
                        popInfo.showTips_game = "（获得的游戏道具以邮件发放到电脑端）";
                    }
                } else {
                    popInfo.showTips_game = "";
                }

                var tipObj = {};
                tipObj.showTips = popInfo.showTips;
                tipObj.name = v.name;
                tipObj.count_desc = v.count_desc;
                tipObj.showTips_game = popInfo.showTips_game;

                tipObj.isLastkingReward = true;
                mgc.rewardTipModel.addTip(tipObj);
            });
        },

        // 显示补刀王教学
        showEducationTips: function(elms, tips, index){
            elms.css("left", pos[index]+80);
            elms.show();
            mgc.consts.isFinishEducation = 1;
            callcenter.send_finish_education(1);
            setTimeout(function(e){
                elms.hide();
            }, 5000);
            
        }

    });

    window.mgc.lastKing = lastKing;

    return lastKing;

});