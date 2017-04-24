/**
 * @Description:   梦工厂web-控制-个人直播间皮肤升级后
 *
 * @author         Xu XiaoJing
 * @version        V1.0
 * @Date           2016/04/20
 * @Company        horizon3d
 */
define(['mgc_callcenter', 'mgc_consts', 'jqtmpl', 'mgc_tool', 'mgc_tips', 'mgc_comm_view', 'mgc_popmanager', 'mgc_punch_card'], function(callcenter, consts, jqtmpl, mgc_tool, mgc_tips, comm_view, mgc_popmanager, punch_card) {
    var control = {};

    var missionCon = $('.layer-mission-con');
    var missionTmpl = $('#missionNorTmpl');

    var roomTaskInfo = {};
    var roomTaskDrawTimer;
    var roomTaskDrawFirst = true;
    var roomTaskDraw = function() {
        if (roomTaskDrawTimer) { return; }
        roomTaskDrawTimer = setTimeout(function() {
            control.Response.roomTaskInfoCallback(roomTaskInfo, null, true);
        }, 5000);
    }

    control.Request = {

    };
    control.Response = {
        /*
         * 皮肤升级
         */
        roomTaskInfoCallback: function(resp, param, isDraw) {
            if (roomTaskDrawFirst) {
                $.extend(true, roomTaskInfo, resp.info);
                roomTaskDrawFirst = false;
            } else {
                if (!isDraw) {
                    $.extend(true, roomTaskInfo, resp.info);
                    roomTaskDraw();
                    resp = null;
                    return;
                } else {
                    roomTaskDrawTimer = null;
                }
            }

            missionCon.children().removeAll();
            missionCon.html(missionTmpl.tmpl(roomTaskInfo));
            setMissionTips();
            //打卡按钮红点状态
            if (SKIN.can_punch_in_room) {
                missionCon.find(".daka_btn .icon-red-dot").show();
            }
            //打卡点击事件
            missionCon.find(".daka_btn").unbind("click").click(function() {
                if (!mgc.account.checkGuestStatus()) {
                    punch_card.Req.getPunchCardInfo();
                }
            });
            //missionCon = null;
            //missionTmpl = null;
            resp = null;
            //ii = null;
            param = null;
        },
        roomTaskInfoMaxCallback: function(resp, param) {
            clearTimeout(roomTaskDrawTimer);
            var ii = resp.info;
            var fin = ii.current_punchin_count + ii.current_takeseat_count;
            var total = ii.total_punchin_count + ii.total_takeseat_count;
            var tList = ii.task_list;
            if (tList.length > 0) {
                for (var i = 0; i < tList.length; i++) {
                    fin += tList[i].current_count;
                    total += tList[i].total_count;
                }
            }
            ii.per = Math.floor(fin / total * 100);
            $('.layer-mission-con').html($('#missionMaxTmpl').tmpl(ii));
            //setMissionTips(ii);
            //打卡按钮红点状态
            if (SKIN.can_punch_in_room) {
                $('.layer-mission-con').find(".daka_btn .icon-red-dot").show();
            }
            //打卡点击事件
            $('.layer-mission-con').find(".daka_btn").unbind("click").click(function() {
                if (!mgc.account.checkGuestStatus()) {
                    punch_card.Req.getPunchCardInfo();
                }
            });
            resp = null;
            ii = null;
            tList = null;
            param = null;
        },
        /*
         * 魅力榜第一
         */
        topMeiliCallback: function(resp, param) {
            console._log("魅力榜第一通知");
            var ii = resp.info;
            var td = ii.rank_timedimension;
            var dStr = td == 0 ? "日" : td == 1 ? "周" : td == 2 ? "月" : td == 3 ? "总" : "";
            //var levelIconStr = "<p class='room_level room_level_" + ii.skin_id + "'><i>" + ii.skin_level + "</i></p>";
            var levelIconStr = "#IMG?type=room_level&a=" + ii.skin_id + "&b=" + ii.skin_level + "#";
            var marqueeStr = "恭喜" + levelIconStr + ii.room_id + "-" + ii.room_name + "荣登房间魅力" + dStr + "榜第一名，进入房间为Ta庆祝吧！";
            var marqueeObj = {
                op_type: resp.op_type,
                MsgStr: marqueeStr
            };
            MGC.marqueeArr(marqueeObj);
        },
        /*
        * 皮肤满级后每日任务奖励消息:309
        */
        recvTaskRewardSkinUpCallback: function(resp, param) {
            console.log("recvTaskRewardSkinUpCallback:" + JSON.stringify(resp));
            //满级进度条闪烁
            playFinalSwf();
            setTimeout(function() {
                $('#flash_final').hide();
                //领取成功 弹出奖励信息
                var data = {};
                data.rewards = resp.rewards;
                data.title = "房间任务奖励";
                data.showTips = "任务完成，恭喜您获得以下奖励：";
                data.showTips_game = "";
                var reward_dialog_view = new comm_view.RewardDialogView(data);
            }, 3000);
        }
    };

    //播放swf
    function playFinalSwf() {
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
        attributes.id = "drawAnimation";
        attributes.name = "drawAnimation";
        attributes.align = "middle";
        var swfurl = "http://ossweb-img.qq.com/assets/effect_max.swf?v=3_7_4_2015_34_3_" + (new Date()).getTime();
        swfobject.embedSWF(swfurl, "final_flash_con", "100%", "100%", swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
        $('#flash_final').show();

        //IE下样式调整
        if (mgc.tools.browser.ie6 || mgc.tools.browser.ie7 || mgc.tools.browser.ie8 || mgc.tools.browser.ie9 || mgc.tools.browser.ie11) {
            $('#flash_final').css({ "top": "-6px", "left": "-10px", "width": "175px" });
        }
    }

    var meiliTipsCon = $('#room_meili_tips');
    var meiliTipsTmpl = $('#roomMeiliTipsTmpl');

    //房间任务进度tips
    function setMissionTips() {
        //$(".mission_div").find(".mission_progress,.mission_progress span").css("behavior", "url(PIE.htc)");

        meiliTipsCon.children().removeAll();
        meiliTipsCon.html(meiliTipsTmpl.tmpl(roomTaskInfo));

        $(".mission_total .mission_progress,.mission_total .room_level").unbind("mouseover,mouseout").bind("mouseover", function(){
            var t = $(".mission_total .mission_progress").offset().top + 20;
            var l = $(".mission_total .mission_progress").offset().left + 60;
            $('#room_meili_tips').css({
                "top": t,
                "left": l
            });
            var sideStat = $(".side-left").attr("side_state");
            var mainType = 1;
            if (sideStat == "1") {
                mainType = 2;
            }
            window.mgc.popmanager.layerControlShow($('#room_meili_tips'), mainType, 3);        
        }).on("mouseout", function(){
            var sideStat = $(".side-left").attr("side_state");
            var mainType = 1;
            if (sideStat == "1") {
                mainType = 2;
            }
            window.mgc.popmanager.layerControlHide($('#room_meili_tips'), mainType, 3);
        });
        //meiliTipsCon = null;
        //meiliTipsTmpl = null;
        //ii = null;
    }
    //初始化 执行
    //粉丝守护榜tips
    MGC.popTipss("pop_tips", "i");
    //模拟数据begin
    var ii = {
        "op_type": 305,
        info: {
            "next_level_charm": 99999,
            "charm_total": 342465,
            "next_level_takeseat_count": 1,
            "current_charm": 8888,
            "next_level_punchin_count": 0,
            "room_id": 80003,
            "task_list": [{
                "gift_name": "恶魔之鞭",
                "total_count": 200,
                "gift_id": 41,
                "current_count": 200,
                "gift_price": 499,
                "gift_icon": "http://ossweb-img.qq.com/images/mgc/css_img/flash/gift/gift_41.png?v=3_8_8_2016_15_4_final_3",
                "gift_url": "/flash/gift/gift_41.png?v=3_8_8_2016_15_4_final_3"
            }, {
                "gift_name": "香水",
                "total_count": 300,
                "gift_id": 42,
                "current_count": 300,
                "gift_price": 199,
                "gift_icon": "http://ossweb-img.qq.com/images/mgc/css_img/flash/gift/gift_42.png?v=3_8_8_2016_15_4_final_3",
                "gift_url": "/flash/gift/gift_42.png?v=3_8_8_2016_15_4_final_3"
            }, {
                "gift_name": "香水",
                "total_count": 300,
                "gift_id": 42,
                "current_count": 300,
                "gift_price": 199,
                "gift_icon": "http://ossweb-img.qq.com/images/mgc/css_img/flash/gift/gift_42.png?v=3_8_8_2016_15_4_final_3",
                "gift_url": "/flash/gift/gift_42.png?v=3_8_8_2016_15_4_final_3"
            }],
            "next_level_skin_gift_count": 0,
            "total_takeseat_count": 1,
            "is_max_level": false,
            "today_task_list": [{
                "gift_name": "恶魔之鞭",
                "total_count": 0,
                "gift_id": 41,
                "current_count": 0,
                "gift_price": 499,
                "gift_icon": "http://ossweb-img.qq.com/images/mgc/css_img/flash/gift/gift_41.png?v=3_8_8_2016_15_4_final_3",
                "gift_url": "/flash/gift/gift_41.png?v=3_8_8_2016_15_4_final_3"
            }, {
                "gift_name": "香水",
                "total_count": 0,
                "gift_id": 42,
                "current_count": 0,
                "gift_price": 199,
                "gift_icon": "http://ossweb-img.qq.com/images/mgc/css_img/flash/gift/gift_42.png?v=3_8_8_2016_15_4_final_3",
                "gift_url": "/flash/gift/gift_42.png?v=3_8_8_2016_15_4_final_3"
            }],
            "room_skin_level": 1,
            "room_skin_id": 2,
            "need_charm": 1000,
            "total_punchin_count": 1,
            "current_takeseat_count": 1,
            "current_punchin_count": 1,
            "current_charm_rank": 190,
            "skin_gift": {
                "gift_icon": "http://ossweb-img.qq.com/images/mgc/css_img/flash/gift/gift_43.png?v=3_8_8_2016_15_4_final_3",
                "gift_url": "/flash/gift/gift_42.png?v=3_8_8_2016_15_4_final_3",
                "current_count": 0,
                "gift_name": "香水",
                "total_count": 30,
                "gift_price": 199,
                "gift_id": 42,
                "next_level_skin_gift_count": 9866
            }
        }
    };

    var ii2 = {
        "op_type": 305,
        info: {
            rank_timedimension: 0,
            skin_id: 2,
            skin_level: 7,
            room_id: 1480,
            room_name: 'god'
        }
    };
    
    
    var iflash = {
        "rewards": [{
            "url": "",
            "id": 0,
            "channel": 2,
            "type": 4,
            "name": "",
            "count_desc": null,
            "price": 0,
            "tips": null,
            "CCY": null
        }, {
            "url": "/items/item_fly_1.png?v=3_8_8_2016_15_4_final_3",
            "id": 0,
            "channel": 2,
            "type": 5,
            "name": "飞屏",
            "count_desc": "10",
            "price": 0,
            "tips": "当天使用有效的飞屏喇叭",
            "CCY": null
        }, {
            "url": "http://ossweb-img.qq.com/images/mgc/css_img/flash/gift/gift_200.png?v=3_8_8_2016_15_4_final_3",
            "id": 200,
            "channel": 2,
            "type": 7,
            "name": "贝壳",
            "count_desc": "1",
            "price": 0,
            "tips": "【欢乐海洋主题专属】在海底主题皮肤下送出魅力值+6，其他主题下送出魅力值+3。",
            "CCY": "炫豆"
        }],
        "room_id": 101030,
        "op_type": 309,
        "hasgame": false
    }; 
 

    setTimeout(function() {
        //control.Response.roomTaskInfoCallback(ii);
        //control.Response.topMeiliCallback(ii2);
        //control.Response.recvTaskRewardSkinUpCallback(iflash);
        //playFinalSwf();
    }, 7500);

    $('body').bind('click', function(e) {
        e = e || window.event;
        // 兼容IE7
        var obj = $(e.srcElement || e.target);
        if (!$(obj).is(".meili_btn,.meili_btn *,#meili_div,#meili_div *")) {
            window.mgc.popmanager.layerControlHide($m("#meili_div"), 3, 1);
        }
    });

    //主动下发下消息监听
    callcenter.addRespListener(callcenter.OP_TYPE.ROOM_TASK_INFO, control.Response.roomTaskInfoCallback);
    callcenter.addRespListener(callcenter.OP_TYPE.ROOM_TASK_INFO_MAX, control.Response.roomTaskInfoMaxCallback);
    callcenter.addRespListener(callcenter.OP_TYPE.RECV_TOP_MEILI, control.Response.topMeiliCallback);
    callcenter.addRespListener(callcenter.OP_TYPE.RECV_TASK_REWARD_SKIN_UP, control.Response.recvTaskRewardSkinUpCallback);
    return control;
});

