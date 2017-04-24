/**
 * @Description:   梦工厂web-控制-工会直播间
 *
 * @author         Xu XiaoJing
 * @version        V1.0
 * @Date           2015/12/04
 * @Company        horizon3d
 */
define(['mgc_room', 'mgc_callcenter', 'eas', 'mgc_consts', 'jqtmpl', 'mgc_tool', 'mgc_tips', 'mgc_popmanager'], function(mgc_room, callcenter, eas, consts, jqtmpl, mgc_tool, mgc_tips) {
    var control = {};
    /**
     * 初始化个人直播间
     */
    control.init = function(resp) {
        mgc_room.init(resp);
    };
    //监听下发========================================
    //房间状态35
    callcenter.addRespListener(callcenter.OP_TYPE.RECEIVE_ROOM_STATUS, function(resp, params) {
        lroom_callBack.receiveRoomStatus(resp);
    });
    //刷新房间信息30
    callcenter.addRespListener(callcenter.OP_TYPE.RECEIVE_REFRESH_ROOM, function(resp, params) {
        lroom_callBack.refreshRoom(resp);
    });
    //发送请求========================================
    var lroom_request = {
        //进入房间
        enter: function(roomId, special) {
            var crowd = false;
            if (special) {
                crowd = true;
            }
            roomId = parseInt(roomId);
            console.log('房间ID' + roomId);
            if (roomId > 0) {
                //进入房间先刷新视频区玩家  --- 特殊处理
                console.log('进入房间之前调用操作刷新视频区玩家');
                callcenter.standard_req("REFRESH_PLAYER");
                var source = parseInt(mgc_tool.getUrlParam('source'));
                source = source >= 0 ? source : 0;
                console.log('进入房间_请求');
                var reqParams = {
                    roomID: roomId,
                    crowd_into: crowd,
                    invisible: false,
                    source: source
                };
                callcenter.callbackStr_req("ENTER_ROOM", lroom_callBack.EnterRoomCallBack, "lroom_callBack.EnterRoomCallBack", reqParams);
            } else {
                window.location.href = window.mgc.tools.changeUrlToLivearea(home);
            }
        },
    };

    //请求回调========================================
    var lroom_callBack = {
        //进入房间
        EnterRoomCallBack: function(obj) {
            console.log('进入房间_返回' + JSON.stringify(obj));
        },
        //刷新房间信息
        refreshRoom: function(obj) {
            //初始化礼物插件存储信息
            //xxjtemp//LiveRoomData = JSON.stringify(obj);
            //xxjtemp//if (MGC_SWFINIT.GiftSwf) {
            //xxjtemp//    gift_response(LiveRoomData);
            //xxjtemp//};
            //进入房间，主动刷新房间信息
            console.log('主动刷新房间信息' + JSON.stringify(obj));

            /**
             * 0-无效
             * 1-等待
             * 2-直播
             * 3-已关闭
             */
            var _status = obj.data.status;
            console.log('直播状态：' + _status);
            consts.MGCData.roomStatus = _status;
            //设置房间ID
            consts.MGCData.roomID = obj.data.roomID;
            //设置房间名
            consts.MGCData.roomName = obj.data.roomName;
            //设置主播信息
            if (_status == 2) {
                consts.MGCData.anchorID = obj.data.anchorID;
                consts.MGCData.anchorName = obj.data.anchorName;
                //直播中，显示任务
                $('#anchorTask').show();
                //隐藏幻灯片、未直播推荐
                $("#video_pic").hide();
                $(".video_recommend_list").hide();
            } else {
                //没有直播，不需要热度加速按钮
                $('#addHotContainer').hide();
                //直播加上幻灯图片
                mgc_room.room_request.getRoomUrl();
                //未直播房间推荐
                //xxjtemp//MGC_CommRequest.getSmallHotRecommRoom();
            }
            //首次拉取在线玩家列表
            //xxjtemp//MGC_CommRequest.getRoleList();
            //获取主播任务 --这里应该主动回调的，测试的时候手动调用todo
            //MGC_CommRequest.getTaskInfo();

        },
        //下发房间状态
        receiveRoomStatus: function(obj) {
            console.log('下发房间状态' + JSON.stringify(obj));
            consts.MGCData.roomStatus = obj.status;
            if (obj.status == 2) {
                //直播啦
                consts.MGCData.isLiveOpen = true;
                $('#anchorTask').show();
                $('.video_pic').hide();
                $('.hiddenAnchor').show();
                //热度条
                $('#boxHotContainer').find('*').show();
                //礼物启用
                //xxjtemp//FreeGift.setEnabled(true);
                //隐藏幻灯片、未直播推荐
                $("#video_pic").hide();
                $(".video_recommend_list").hide();

            } else {
                consts.MGCData.isLiveOpen = false;
                //没有直播，不需要热度加速按钮
                $('#addHotContainer').hide();
                //房间热度归0
                consts.MGCData.curHeight = 0;
                //热度条隐藏
                $('#boxHotContainer').find('*').hide();
                $('.video_pic').show();
                //直播加上图片
                mgc_room.room_request.getRoomUrl();
                //未直播房间推荐
                //xxjtemp//MGC_CommRequest.getSmallHotRecommRoom();
                //礼物禁用
                //xxjtemp//FreeGift.setEnabled(false);
            }
            //更新用户列表
            //xxjtemp//MGC_CommRequest.getRoleList();
        },
    };
    return control;
});

