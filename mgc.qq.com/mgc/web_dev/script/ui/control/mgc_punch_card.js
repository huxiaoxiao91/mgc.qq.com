/**
 * Created by 77 on 2015/10/8.
 */
/**
 * Todo:1.处理全局统一逻辑
 */
define(['mgc_callcenter', 'mgc_tool', 'mgc_consts', 'mgc_punchcard_view'], function(callcenter, tool, consts, punchcard_view) {
    var control = {};
    control.Req = {
        /*
        *获取打卡信息
        */
        getPunchCardInfo: function() {
            callcenter.get_punch_card_info(control.Resp.getPunchCardInfoCallBack, null);
        },
        /*
        * 打卡
        * punch_in_id     打卡周期id
        * today_index     今日索引
        * day_index       打卡日期索引
        * retrieve        是否补打卡
        * retrieve_price  补打卡价格
        */
        PunchCard: function(punch_in_id, today_index, day_index, retrieve, retrieve_price) {
            //control.Resp.PunchCardCallBack({"info":{"retrieve_punch_in_prce":30,"rewards":[{"id":0,"type":0,"name":"音符","count_desc":"30","url":"/flash/gift/gift_201.png?v=3_8_8_2016_15_4_final_3","channel":2,"tips":"【迷情舞台主题专属】在迷情舞台主题皮肤下送出魅力值+6，其他主题下送出魅力值+3。"}],"res":0,"day_index":22,"retrieve":false,"room_left":3,"charm":1},"op_type":301,"hasgame":false});
            callcenter.punch_card(punch_in_id, today_index, day_index, retrieve, retrieve_price, control.Resp.PunchCardCallBack, null);
        }
    }
    /*
     *打卡回调处理
     */
    control.Resp = {
        /*
         *获取打卡信息回调
         */
        punchCardView: null,
        getPunchCardInfoCallBack: function(resp, params) {
            console.log("get punch card info callback");
            //主界面
            control.Resp.punchCardView = new punchcard_view.PunckCardView(
                resp,
                control.Req.PunchCard,
                control.Req.PunchCard,
                null);
        },
        /*
        *打卡回调
        */
        punchCardMsg: { "isSelf": false, "chatnodes": [{ "content": "成功打卡1次，为房间贡献1魅力值，打卡任务+1。", "nodeType": 0 }], "msg": { "judge_type": -1, "msg": "$t$成功打卡1次，为房间贡献1魅力值，打卡任务+1。$z", "video_guild_id": "", "receiverPlayerID": "", "receiverPlayerType": 0, "flag": 0, "senderDeviceType": 2, "m_in_vip_seat": false, "m_is_free_whistle": false, "m_is_purple": false, "invisible": false, "m_senderPlayerType": 2, "forbid_talk_all_room": false, "isOnLive": false, "nest_assistant": false, "senderIcon": "", "NickColor": "", "channel": 3, "TextColor": "#b841c6", "senderPlayerID": "", "isSelf": 0, "senderPlayerZoneID": 0, "systemType": 0, "targetVipLevel": 0, "senderName": "", "targetGuardLevel": 0, "receiverName": "", "ban": false, "senderZoneName": "", "perpetual": false, "receiverZoneName": "", "wealth_level": 0, "sender_jacket": 0, "add_anchor_exp": 0, "sender_defend": 0, "isTakeVip": false, "viplevel": 0, "vipCardPattern": null }, "op_type": 46 },
        PunchCardCallBack: function(resp, params) {
            console.log("打卡回调");
            if (resp.info.res == 0) {
                //打卡成功 reset view data
                control.Resp.punchCardView.reset_view_data(resp.info);
                //伪造系统消息提醒
                if (resp.info.charm == 0) {
                    control.Resp.punchCardMsg.chatnodes[0].content = "亲，房间今日打卡任务已完成，连续打卡可以获得专属礼物哦！";
                } else {
                    control.Resp.punchCardMsg.chatnodes[0].content = "成功打卡1次，为房间贡献" + resp.info.charm + "魅力值，打卡任务+1。";
                }
                control.Resp.punchCardMsg.msg.msg = "$t$" + control.Resp.punchCardMsg.chatnodes[0].content + "$z";
                $chat.PushTalk(control.Resp.punchCardMsg);
            } else if (resp.info.res == 1) {
                //失败
                tool.commonDialog({ "Title": "提示", "Note": "数据哥哥正在拼命赶来的路上，请稍后再试~~>_<~~" }, function() { });
            } else if (resp.info.res == 2) {
                //数据不一致
                tool.commonDialog({ "Title": "提示", "Note": "数据哥哥正在拼命赶来的路上，请稍后再试~~>_<~~" }, function() { });
            } else if (resp.info.res == 3) {
                //达到打卡房间上线
                tool.commonDialog({ "Title": "提示", "Note": "亲，今日您的打卡房间已达到上限！" }, function() { });
            } else if (resp.info.res == 4) {
                //已经打过卡了
                tool.commonDialog({ "Title": "提示", "Note": "数据哥哥正在拼命赶来的路上，请稍后再试~~>_<~~" }, function() { });
            } else if (resp.info.res == 5) {
                //补打卡余额不足
                var dialog = {};
                dialog.Note = '您的炫豆不够了！快去充值吧！';
                dialog.BtnNum = 2;
                dialog.BtnName = '立即充值';
                dialog.BtnName2 = '算了';
                dialog.url = consts.url.IPAY;
                tool.commonDialog(dialog);
            }
            if (resp.info.retrieve) {
                control.Resp.punchCardView.click_punch_card_add = true;
            } else {
                control.Resp.punchCardView.click_punch_card = true;
            }
        }
    };
    callcenter.addRespListener(callcenter.OP_TYPE.GET_PUNCH_CARD_INFO, control.Resp.getPunchCardInfoCallBack);
    window.mgc.punch_card_control = control;
    return control;
});