/* ========================================================================
* 【本类功能概述】
* 节日活动模块
* 作者：shixinqi 时间：2016-09-28
* 文件名：mgc_festival_activity
* 版本：V1.0.1
* 消息接口： 
        req:  
        resp: 
* 修改者： 时间： 
* 修改说明：
* ========================================================================
*/
define(['jquery', 'mgc_consts', 'mgc_config', 'mgc_tool', 'mgc_popmanager', 'mgc_callcenter', 'mgc_account', 'mgc_festival_activity_model', 'mgc_festival_activity_coll', 'mgc_festival_activity_view'], function($, consts, config, tool, popmanager, callcenter, account, festival_activity_model, festival_activity_coll, festival_activity_view) {
    var fa = {};

    //礼物逻辑处理
    fa.handle = {
        //房间开播状态
        roomStatus: false,
        //活动视图
        faView: null,
        /*
        * 初始化活动模板
        */
        init: function() {
            //只初始化一次
            if (fa.handle.faView) return;
            fa.handle.faView = new festival_activity_view.FestivalActivityModuleView(fa.req.sendGift, fa.req.getCommonActivityPlayerRank);

            var giftRankModel = new festival_activity_model.GiftRankModel();
            var giftRankView = new festival_activity_view.GiftRankView({ model: giftRankModel, el: ".gift-rank" });
            mgc.giftRankModel = giftRankModel;
            mgc.giftRankView = giftRankView;
        }
    }
    //request 
    fa.req = {
        /**
         * 送礼消息
         * @params 　gift_id:int　礼物id
         * @params 　gift_cnt:int　礼物数量
         * @params 　anchor_id:int　主播id
         */
        sendGift: function(gift_id, gift_cnt) {
            if (account.checkGuestStatus(false)) {
                return;
            }
            var anchor_id = MGCData.anchorID;
            //callcenter.sendGift(gift_id, gift_cnt, anchor_id);
            var _repStr = {};
            _repStr.op_type = 19;
            _repStr.anchorID = anchor_id;
            _repStr.gift_id = gift_id;
            _repStr.gift_cnt = gift_cnt;
            MGC_Comm.sendMsg(_repStr);
        },
        /*
        * 查询玩家贡献榜数据
        */
        getCommonActivityPlayerRank: function() {
            mgc.giftRankModel.set("visible", true);
            //test
            /*
            var list = [{m_player_nick: "玩家名字八个大字", m_score: 99988800, m_video_wealth_level: 1 },
                {m_player_nick: "玩家名字字", m_score: 9998880, m_video_wealth_level: 2 },
                {m_player_nick: "玩大字", m_score: 999888, m_video_wealth_level: 3 },
                {m_player_nick: "字八个大字", m_score: 99900, m_video_wealth_level: 4 },
                {m_player_nick: "玩家名字八个大字", m_score: 99800, m_video_wealth_level: 5 },
                {m_player_nick: "玩家名字八个大字", m_score: 99900, m_video_wealth_level: 6 },
                {m_player_nick: "玩家名字八个大字", m_score: 99900, m_video_wealth_level: 7 },
                {m_player_nick: "玩家名字八个大字", m_score: 99800, m_video_wealth_level: 8 },
                {m_player_nick: "玩家名字八个大字", m_score: 99800, m_video_wealth_level: 9 },
                {m_player_nick: "玩家名字八个大字", m_score: 9900, m_video_wealth_level: 9 }];
            mgc.giftRankModel.set("giftList", list);
            */

            callcenter.get_common_activity_player_rank(fa.resp.recvFansContributeListCallback);
        }
    }
    //response
    fa.resp = {
        /*
        * 向客户端发送通用活动开始信息
        */
        recvCommonActivityInfoBeginCallback: function(resp, params) {
            console.log("fa.resp.recvCommonActivityInfoBeginCallback :" + JSON.stringify(resp));
            // @todo
            festival_activity_model.FestivalActivity.set({
                m_activity_id: parseInt(resp.m_activity_id),
                m_end_time: parseInt(resp.m_end_time) * 1000,
                m_gift_id: parseInt(resp.m_gift_id),
                m_max_send_num: parseInt(resp.m_max_send_num),
                m_more_detail_url: resp.m_more_detail_url,
                status: fa.handle.roomStatus
            });

            MGCData.activity_gift_id = parseInt(resp.m_gift_id);
            tool.getSWF("GiftSwf").setActivityGift(parseInt(resp.m_gift_id));
            tool.getSWF("eventGiftContainer").setMaxNum(parseInt(resp.m_max_send_num));
        },
        /*
        * 向客户端发送通用活动结束信息
        */
        recvCommonActivityInfoEndCallback: function(resp, params) {
            console.log("fa.resp.recvCommonActivityInfoEndCallback :" + JSON.stringify(resp));
            // @todo
            festival_activity_model.FestivalActivity.resetData();
        },
        /*
        * 送礼回调消息处理
        */
        sendGiftCallback: function(resp, params) {
            console.log("fa.resp.sendGiftCallback :" + JSON.stringify(resp));
            // @todo
        },
        /*
        * 向客户端发送通用活动配置更新信息
        */
        recvCommonActivityInfoRefreshCallback: function(resp, params) {
            console.log("fa.resp.recvCommonActivityInfoRefreshCallback :" + JSON.stringify(resp));
            // @todo
            festival_activity_model.FestivalActivity.set({
                m_activity_id: parseInt(resp.m_activity_id),
                m_end_time: parseInt(resp.m_end_time) * 1000,
                m_gift_id: parseInt(resp.m_gift_id),
                m_max_send_num: parseInt(resp.m_max_send_num),
                m_more_detail_url: resp.m_more_detail_url,
                status: fa.handle.roomStatus
            });

            MGCData.activity_gift_id = parseInt(resp.m_gift_id);
            tool.getSWF("GiftSwf").setActivityGift(parseInt(resp.m_gift_id));
            tool.getSWF("eventGiftContainer").setMaxNum(parseInt(resp.m_max_send_num));
        },
        /*
       * 向客户端发送通用活动地板数据信息（包括主播排名，主播收到的礼物数，底板等级）
        */
        recvRefreshCommonActivityDataCallback: function(resp, params) {
            console.log("fa.resp.recvRefreshCommonActivityDataCallback :" + JSON.stringify(resp));
            // @todo
            festival_activity_model.FestivalActivity.set({
                m_activity_id: parseInt(resp.m_activity_id),
                m_anchor_rank: parseInt(resp.m_anchor_rank),
                m_recv_gift_count: parseInt(resp.m_recv_gift_count),
                m_pannel_level: parseInt(resp.m_pannel_level) == 0 ? 1:parseInt(resp.m_pannel_level),
                m_is_level_up: resp.m_is_level_up == "true",
                status: true
            });
        },
        /*
        * 粉丝贡献榜单更新回调
        */
        recvFansContributeListCallback: function(resp, params) {
            console.log("fa.resp.recvFansContributeListCallback :" + JSON.stringify(resp));
            mgc.giftRankModel.set("giftList", resp.m_rank);
        },
        /*
        * 监听房间状态更新
        */
        recvRoomStatusCallback: function(resp, params) {
            console.log("fa.resp.recvRoomStatusCallback :" + JSON.stringify(resp));
            // @todo
            if (resp.status == 2) {
                //开播
                fa.handle.roomStatus = true;
            } else {
                fa.handle.roomStatus = false;
                //未开播
                festival_activity_model.FestivalActivity.set({
                    status: false
                });
            }
        }
    }
    //添加监听消息
    callcenter.addRespListener(callcenter.OP_TYPE.COMMON_ACTIVITY_INFO_BEGIN, fa.resp.recvCommonActivityInfoBeginCallback);
    callcenter.addRespListener(callcenter.OP_TYPE.COMMON_ACTIVITY_INFO_END, fa.resp.recvCommonActivityInfoEndCallback);
    callcenter.addRespListener(callcenter.OP_TYPE.COMMON_ACTIVITY_INFO_REFRESH, fa.resp.recvCommonActivityInfoRefreshCallback);
    callcenter.addRespListener(callcenter.OP_TYPE.COMMON_ACTIVITY_REFRESH_DATA, fa.resp.recvRefreshCommonActivityDataCallback);
    callcenter.addRespListener(callcenter.OP_TYPE.RECEIVE_ROOM_STATUS, fa.resp.recvRoomStatusCallback);

    window.fa = fa;
    return fa;
});