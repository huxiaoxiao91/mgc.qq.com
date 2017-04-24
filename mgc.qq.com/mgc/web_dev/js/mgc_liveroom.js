/*
 * Created by vincentgu on 2015/4/27.
 * 提供直播房间的信息
 * op_type :操作类型
 * 12 进入房间
 * 30 刷新房间信息（无请求，主动回调）
 * 13 退出房间
 * 14 主动请求主播名片
 * 27 嘉宾席（无请求，主动回调）
 * 28 超级粉丝（0）和守护（1）
 * 23 热门推荐
 * 15 在线玩家（最多100，有分页信息）
 * 118 加载关注的主播
 *
 */
var wheelStop = true;//标识滚动条是否可移动
leftLiveRoomProTime = 120;
var mouseX;
var mouseY;
var heatCchestWidth = 0;
var Qgame = false;
MGCData.roomID = 0;
MGCData.slideArr = {};
var tmpBx = 0;
isLiveOpen = true;
MGC_CommResponse.contRoom = 0;
isLoginCallback = false;
var oldNickObj = [];
var oldNick = [];
var vipCount = 0;
var MGC_ANCHORIMPRESSION = {
    "1": "阳光",
    "2": "可爱",
    "3": "呆萌",
    "4": "性感",
    "5": "小清新",
    "6": "卡哇伊",
    "7": "治愈系",
    "8": "女王",
    "9": "王子",
    "10": "大叔",
    "11": "正太",
    "13": "傲娇受",
    "14": "搞笑",
    "15": "情歌王",
    "16": "天籁音",
    "17": "脱口秀",
    "18": "段子手",
    "19": "才艺达人",
    "20": "另类",
    "21": "霸气",
    "22": "腹黑",
    "23": "重口味",
    "24": "大叔控",
    "25": "软淑萌",
    "26": "肌肉男",
    "27": "虎比",
    "28": "逗比",
    "29": "如花",
    "30": "高冷",
    "31": "男神",
    "32": "呆萌",
    "33": "实力派",
    "34": "偶像派",
    "35": "duang",
    "36": "御姐",
    "37": "男人味",
    "38": "骨感美",
    "39": "烟花王",
    "40": "钻戒帝",
    "41": "萌萌哒",
    "42": "花篮哥",
    "43": "屌丝",
    "44": "高冷",
    "45": "坑货",
    "46": "霸道总裁",
    "47": "点券王子",
    "48": "闭卷大神",
    "49": "威猛先生",
    "50": "古灵精怪",
    "51": "男神经",
    "52": "女神经",
    "53": "蛇精病",
    "54": "职业坑",
    "55": "大白",
    "56": "暖男",
    "57": "有钱任性",
    "58": "我爱的人",
    "59": "犀利哥",
    "60": "吃货",
    "61": "小鲜肉"
}
//发送请求========================================
var MGC_SpecialRequest = {
    //进入房间
    enter: function(roomId, special) {
        crowd = false;
        if (special) {
            crowd = true;
        }
        roomId = parseInt(roomId);
        console.log('房间ID' + roomId);
        if (roomId > 0) {
            //进入房间先刷新视频区玩家  --- 特殊处理
            var _tmpReqStr = "{\"op_type\":" + OpType.RefreshPlayerOpType + "}";
            console.log('进入房间之前调用操作2_reqStr：' + _tmpReqStr);
            MGC_Comm.sendMsg(_tmpReqStr);
            var source = parseInt(MGC_Comm.getUrlParam('source'));
            source = source >= 0 ? source : 0;
            var module_type = parseInt(MGC_Comm.getUrlParam('module_type'));
            var page_capacity = parseInt(MGC_Comm.getUrlParam('page_capacity'));
            var room_list_pos = parseInt(MGC_Comm.getUrlParam('room_list_pos'));
            var tag_id = parseInt(MGC_Comm.getUrlParam('tag_id'));
            var _reqStr = "{\"op_type\":" + OpType.EnterOpType + ", \"roomID\":" + roomId + ",\"crowd_into\":" + crowd + ", \"invisible\":false,\"source\":" + source + ",\"tag\":" + tag_id + ",\"module_type\":" + module_type + ",\"page_capacity\":" + page_capacity + ",\"room_list_pos\":" + room_list_pos + "}";
            console.log('进入房间_请求：' + _reqStr);
            MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.EnterRoomCallBack");
            if (window.mgc.tools.cookie('mgc_login_succeed_uin') != null) {
                MGC_CommRequest.goodFriendPay();
            }
        } else {
            window.location.href = window.mgc.tools.changeUrlToLivearea(home);
        }
    },

    //好友充值消息主动请求
    goodFriendPay: function () {
        var _reqStr = "{\"op_type\":" + OpType.GoodFrendPay + "}";
        console.log('好友充值消息主动请求');
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.goodFriendPayCallBack");
    },

    //拉去角色列表系信息
    getRoleList: function() {
        var _reqStr = "{\"op_type\":" + OpType.GetRoleListOpType + ", \"pageIndex\":0}";
        console.log('拉取角色列表_reqStr：' + _reqStr);
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.appendRoleList");
    },
    //我关注的主播信息
    getMyFollowAnchor: function() {
        var _reqStr = "{\"op_type\":" + OpType.GetFollowAnchorCardOpType + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.showFollowAnchorCallBack");
    },

    //获取热度宝箱
    getHotBox: function() {
        var _reqStr = "{\"op_type\":" + OpType.GetHotBoxOpType + ", \"roomID\":" + MGCData.roomID + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getHotBoxCallBack");
    },
    //送礼
    SendGift: function(gift_id, gift_cnt) {
        var _reqStr = "{\"op_type\":" + OpType.SendGiftType + ", \"gift_id\":" + gift_id + ", \"gift_cnt\":" + gift_cnt + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.sendGiftCallBack");
    },

    //获取主播任务
    getTaskInfo: function(isT) {
        if (MGC_Comm.CheckGuestStatus(isT)) {
            console.log("屏蔽游客操作：获取主播任务");
            return false;//游客身份下，屏蔽此操作
        }
        var _reqStr = "{\"op_type\":" + OpType.GetTaskInfoOpType + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getTaskInfoCallBack");
    },

    //接受主播任务
    AcceptTask: function() {
        var _reqStr = "{\"op_type\":" + OpType.AcceptTaskOpType + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.AcceptTaskCallBack");
    },

    //放弃主播任务
    GiveUpTask: function() {
        var _reqStr = "{\"op_type\":" + OpType.GiveUpTaskOpType + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.GiveUpTaskCallBack");
    },

    //发送在线好礼任务
    setTaskInfo: function(id, is_daily) {
        MGC_Comm.sendMsg("{\"op_type\":" + OpType.GetActRewardsOpType + ",\"activity_id\":" + id + ",\"category\":" + is_daily + "}", "MGC_CommRequest.GetActRewardsCallBack");
    },
    //在线好礼任务奖励
    GetActRewardsCallBack: function(responseStr) {
        var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
        if (obj.type == 0) {
            var dialogStr = {}; var n = 1;
            switch (parseInt(obj.res)) {
                case 1:
                    dialogStr.Title = '在线好礼';
                    dialogStr.Note = '领取奖励成功！';
                    MGC_Comm.CommonDialog(dialogStr, function() {
                        MGC_SpecialResponse.popId = false;
                        MGC_Comm.hideDialog(true);
                        MGC_SpecialResponse.chechNumShow();
                    });
                    $m('#CommonDialog').css("top", "310px");
                    break;
                case 2: dialogStr.Title = '在线好礼'; dialogStr.Note = '活动任务已过期！'; MGC_Comm.CommonDialog(dialogStr); $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                    $m('#CommonDialog').css("top", "310px"); break;
                case 3: dialogStr.Title = '在线好礼'; dialogStr.Note = '活动任务尚未完成，加油努力吧！'; MGC_Comm.CommonDialog(dialogStr); $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                    $m('#CommonDialog').css("top", "310px"); break;
                case 4: dialogStr.Title = '在线好礼'; dialogStr.Note = '您已经领取过活动任务奖励！'; MGC_Comm.CommonDialog(dialogStr); $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                    $m('#CommonDialog').css("top", "310px"); break;
                case 6:
                    window.mgc.common_logic.CheckNameError(152);
                    break;
                default: dialogStr.Title = '在线好礼'; dialogStr.Note = '领取失败！'; MGC_Comm.CommonDialog(dialogStr); $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                    $m('#CommonDialog').css("top", "310px"); break;
            }

        }
        //====horizon====//
        disabledBtn = false;
    },

    //获取主播、玩家、管理员信息
    getPlayerInfo: function(name, area, x, y) {
        if (MGC_Comm.CheckGuestStatus()) {
            console.log("屏蔽游客操作：获取主播、玩家、管理员信息");
            return false;//游客身份下，屏蔽此操作
        }
        mouseX = x;
        mouseY = y;
        area = area.replace("炫舞-", ""); //过滤炫舞-  防止服务器找不到大区
        var _reqStr = {
            "op_type": OpType.GetMemberInfoOpType,
            "name": name,
            "zoneName": area
        };
        if (mouseX || mouseY) {
            mgc.common_contral.mgc_comm.eventInfo = undefined;
        }
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getPlayerInfoCallBack");
    },

    //举报房间
    reportAnchor: function(type, content, anchorId, anchorName) {
        //content过滤 @todo
        var _reqStr = "{\"op_type\":" + OpType.ReportAnchorOpType + ",\"type\":" + type + ",\"content\":\"" + content + "\",\"anchor\":" + anchorId + ",\"anchor_name\":\"" + anchorName + "\"}";
        MGC_Comm.sendMsg(_reqStr);
        MGC_Comm.HideAndClear($m('#pop_report'));
        alert('提交成功！感谢您热心的举报，我们会尽快处理您的举报。'); //没有回调,直接返回玩家成功
        //清空内容
        $m('#i_report_con').val('');
        $m('#icon_report').attr('data', '5').find('span').html('其他');

    },

    //获用户VIP信息
    getUserVipInfo: function() {
        if (MGC_Comm.CheckGuestStatus()) {
            console.log("屏蔽游客操作：获用户VIP信息");
            return false;//游客身份下，屏蔽此操作
        }
        MGC_Comm.commonGetUin(function(_uin) {
            var _reqStr = "{\"op_type\":" + OpType.RefreshPlayerOpType + ", \"accountid\":" + _uin + "}";
            MGC_Comm.sendMsg(_reqStr, "OpenVip.getVipInfoCallBack");
        });
    },

    //获取VIP价格信息
    getVipPriceInfo: function() {
        var _reqStr = "{\"op_type\":" + OpType.GetVipPriceInfoOpType + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getVipPriceCallBack");
    },

    //开通VIP
    StartVip: function(type, duration) {
        var _reqStr = "{\"op_type\":" + OpType.StartVipOpType + ", \"vip_level\":" + type + ",\"duration\":" + duration + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.StartVipCallBack");
    },

    //续费VIP
    RenewalVip: function(type, duration) {
        var _reqStr = "{\"op_type\":" + OpType.RenewalVipOpType + ", \"vip_level\":" + type + ",\"duration\":" + duration + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.RenewalVipCallBack");
    },


    //编辑主播印象
    editImpression: function(_impressionArr, thisAnchorId) {
        var _reqObj = {};
        _reqObj.op_type = OpType.EditImpressionOpType;
        if (thisAnchorId) {
            _reqObj.anchor_id = thisAnchorId;
        } else {
            _reqObj.anchor_id = MGCData.anchorID;
        }
        _reqObj.data = _impressionArr;
        var _reqStr = JSON.stringify(_reqObj);
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.editImpressionCallBack");
    },

    //是否关注了主播 删除
    isFollowAnchor: function() {
        var _reqStr = "{\"op_type\":" + OpType.FollowAnchorOpType + ", \"AnchorId\":" + MGCData.anchorID + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.isFollowAnchorCallBack");
    },

    //取消和关注主播
    followAnchorAction: function(type, anchorId, name, isFollow) {
        if (MGC_Comm.CheckGuestStatus()) {
            console.log("屏蔽游客操作：取消和关注主播");
            return false;//游客身份下，屏蔽此操作
        }
        if (type == 0) {
            //本页主播的关注
            MGCData.isAnchorOrRoom = 0;
            var op_type = MGCData.difFollowAnchor[0].followAnchor == 0 ? OpType.FollowAnchorActionOpType : OpType.CancelFollowAnchorOpType;
            MGCData.difFollowAnchor[0].followAnchor = 1 - MGCData.difFollowAnchor[0].followAnchor;
            var anchor_id = MGCData.anchorID;
            var anchor_nick = MGCData.anchorName;
        } else {
            //不确定是否是本页主播的关注
            MGCData.isAnchorOrRoom = 1;
            var op_type = isFollow == 0 ? OpType.FollowAnchorActionOpType : OpType.CancelFollowAnchorOpType;
            MGCData.difFollowAnchor[1].followAnchor = 1 - isFollow;
            var anchor_id = anchorId;
            var anchor_nick = name;
        }
        var _reqStr = {
            "op_type": op_type,
            "anchor_id": anchor_id,
            "anchor_nick": anchor_nick
        };
        
        if (op_type == OpType.FollowAnchorActionOpType) {
            mgc.tools.EAS([{ 'e_c': 'mgc.attention', 'c_t': 4 }]);
            MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.FollowAnchorActionCallBack", anchor_id);
        } else {
            mgc.tools.EAS([{ 'e_c': 'mgc.unattention', 'c_t': 4 }]);
            MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.CancelFollowAnchorCallBack", anchor_id);
        }
    },

    //请求所有印象
    allImpressionInfo: function(thisAnchorId) {
        var _reqStr = "{\"op_type\":144}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.allImpressionInfoCallBack", thisAnchorId);
    },

    //请求对主播的印象
    myImpressionInfo: function(thisAnchorId) {
        var _reqStr = "{\"op_type\":" + OpType.MyImpressionOpType + ", \"anchor_id\":" + thisAnchorId + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.myImpressionInfoCallBack", thisAnchorId);
    },

    //请求宝箱数据
    getBoxGift: function(id) {
        if (MGC_Comm.CheckGuestStatus()) {
            console.log("屏蔽游客操作：请求宝箱数据");
            return false;//游客身份下，屏蔽此操作
        }
        var _reqStr = "{\"op_type\":" + OpType.GetBoxGiftOpType + ", \"box_id\":" + id + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getBoxGiftCallBack");
    },

    //禁言和取消禁言
    forbidden: function(_pstid,_name, _area, type, always) {
        var _reqStr = { "op_type": OpType.ForbiddenOpType, "pstid":_pstid,"playerName": _name, "playerZoneName": _area, "ban": type, "perpetual": always };
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.forbiddenCallBack", type);
    },

    //屏蔽和取消屏蔽
    ignore: function(_playerId,_name, _area, _isIgnore) {
        var _reqStr = { "op_type": OpType.IgnoreOpType,"player_id":_playerId, "strNickName": _name, "strZoneName": _area, "bAdd": _isIgnore };
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.ignoreCallBack");
    },
    //非直播，查看房间默认图片
    getRoomUrl: function(roomId) {
        var _reqStr = "{\"op_type\":" + OpType.GetRoomUrlOpType + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getRoomUrlCallBack");
    },

    //旗下 主播列表
    getZhuBoList: function() {
        var _reqStr = "{\"op_type\":" + OpType.GetZhuBoList + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getZhuBoListCallBack");
    }
};

var activityId = '';
var activity_daily = '';
var activityArray = [];
var popId = false;
//存储主播面板返回的消息
var _anchorInfo = {};
// 存储在线列表返回的消息
var _roleListInfo = [];
var roleListTmpl = $m('#roleListTmpl');
var roleListContainer = $m('#roleListContainer');
// 存储超级粉丝列表返回的消息
var _fansInfo = [];
var fansTmpl = $m('#fansTmpl');
var fansContainer = $m('#fansContainer');
// 存储守护列表返回的消息
var _guardInfo = [];
var guardTmpl = $m('#guardTmpl');
var guardContainer = $m('#guardContainer');
var MGC_SpecialResponse = {
    //进入房间回调
    EnterRoomCallBack: function(responseStr) {
        console.log("进入房间_回调:" + JSON.stringify(responseStr));
        // 通知玩家教学标记信息
        var edu_flag = responseStr.info.edu_flag & (1<<1);
        if(edu_flag != 0){
            mgc.consts.isFinishEducation = 1;
        } else{
            mgc.consts.isFinishEducation = 0;
        }
        if (window.mgc.tools.cookie('IsIndexNewPlay') == (new Date().format("yyyy-MM-dd"))) {
            window.mgc.tools.cookie('cookieGuideRoom', null, {
                path: '/',
                domain: '.qq.com'
            });
            window.mgc.tools.cookie('cookieGuideRoom_flag', '1024', {
                path: '/',
                domain: '.qq.com'
            });
            window.mgc.tools.cookie("timerNend_index", '1024', {
                path: '/',
                domain: '.qq.com'
            });
            if (window.mgc.tools.cookie("enterRoom_tips") == null) {
                window.mgc.tools.cookie('enterRoom_tips', '1024', {
                    path: '/',
                    domain: '.qq.com'
                });
                window.mgc.common_contral.IndexResp.taskCenterGuideCallBack();                
            }
            
        }
        var _repStr = MGC_Comm.strToJson(responseStr);
        //【新贵族】初始化当前玩家贵族信息
        //mgc.common_contral.CommOpenVip.attached_anchor_name = _repStr.info.vip_attached_anchor_name;
        VIP_GRAB.free_times = _repStr.info.free_times;
        if (_repStr.ret == 0) {
            var msg = '';

            if (_repStr.res == 49 && _repStr.info.m_remain_crowdroom_count == 0) {
                _repStr.res = 51;
            }

            switch (_repStr.res) {
                case 1:
                    msg = '进入房间:未知错误';
                    break;
                case 2:
                    msg = '进入房间错误';
                    break;
                case 3:
                    msg = '服务器忙';
                    break;
                case 6:
                    msg = '您的操作过于频繁，请稍后再试';
                    break;
                case 9: //房间人满了
                    var roomId = MGC_Comm.getUrlParam('roomId');
                    if (MGC_Comm.CheckGuestStatus(true)) {
                        msg = '房间人满，请登录后再次尝试';
                        MGC_Comm.CommonDialog({
                            "Title": "提示",
                            "Note": msg,
                            "BtnName": "确定",
                            "BtnNum": 1
                        }, function() {
                            MGC_LIVEROOM_BIND.closeRefresh();
                        }, function() {
                            MGC_LIVEROOM_BIND.closeRefresh();
                        });
                    } else {
                        msg = '房间人满。如果拥有贵族身份，或者成为当前主播的天使守护及以上，可以优先的进入人满房间哦~<br>今日剩余挤房次数：-';
                        MGC_Comm.CommonDialog({
                            "Title": "提示",
                            "Note": msg, 
                            "BtnName": "确定",
                            "BtnNum": 1
                        }, function() {
                            MGC_LIVEROOM_BIND.closeRefresh();
                        }, function() {
                            MGC_LIVEROOM_BIND.closeRefresh();
                        });
                    }
                    return;
                    /*
					var vip = _repStr.info.m_vip_level;
					var roomId = MGC_Comm.getUrlParam('roomId');
					if ( vip==1 || vip==2 ) {
						msg = '房间人满。如果拥有贵族身份，或者成为当前主播的天使守护及以上，可以优先的进入人满房间哦~<br>今日剩余挤房次数：'+_repStr.info.m_remain_crowdroom_count;
						MGC_Comm.CommonDialog({"Title":"提示","Note":msg,"BtnName":"挤房间","BtnName2":"确定","BtnNum":2},MGC_CommRequest.enter(roomId,1),MGC_LIVEROOM_BIND.closeRefresh());
					} else {
						//非vip--购买贵族（待完善）
						msg = '房间人满。如果拥有贵族身份，或者成为当前主播的天使守护及以上，可以优先的进入人满房间哦~<br>今日剩余挤房次数：-';
						MGC_Comm.CommonDialog({"Title":"提示","Note":msg,"BtnName":"购买贵族","BtnName2":"确定","BtnNum":2},MGC_CommRequest.enter(roomId,1),MGC_LIVEROOM_BIND.closeRefresh());
					}*/
                    return false;
                    break;
                case 11:
                    msg = '对不起，您没有权限';
                    break;
                case 12:
                    msg = '这个房间不存在';
                    break;
                case 17:
                    msg = '您被暂时禁止进入';
                    break;
                case 22:
                    msg = '视频区网路错误';
                    break;
                case 24:
                    msg = '对不起，无法进入主播专用房间';
                    break;
                case 28:
                    msg = '对不起，该房间已封，无法进入';
                    break;
                case 35:
                    msg = '操作频繁，请稍后再试';
                    break;
                case 36:
                    msg = '当前房间内人太多，挤房失败了';
                    break;
                case 41:
                    msg = '视频服务器已关闭';
                    break;
                case 47:
                    msg = '这个房间已经关闭了';
                    break;
                case 49: //房间人满了
                    var roomId = MGC_Comm.getUrlParam('roomId');
                    msg = '房间人满。如果拥有贵族身份，或者成为当前主播的天使守护及以上，可以优先的进入人满房间哦~<br>今日剩余挤房次数：' + _repStr.info.m_remain_crowdroom_count;
                    MGC_Comm.CommonDialog({
                        "Title": "提示",
                        "Note": msg,
                        "BtnName": "挤房间",
                        "BtnName2": "确定",
                        "BtnNum": 2
                    }, function() {
                        MGC_CommRequest.enter(roomId, 1);
                    }, function() {
                        MGC_LIVEROOM_BIND.closeRefresh();
                    });
                    return;
                    break;
                case 50:
                    msg = '当前房间内人太多，挤房失败了，挤房失败不会扣除您的挤房次数哦~';
                    break;
                case 51: //达到挤房的上线
                    msg = '房间人满。如果拥有贵族身份，或者成为当前主播的天使守护及以上，可以优先的进入人满房间哦~<br>今日剩余挤房次数：-';
                    MGC_Comm.CommonDialog({
                        "Title": "提示",
                        "Note": msg, 
                        "BtnName": "确定",
                        "BtnNum": 1
                    }, function() {
                        MGC_LIVEROOM_BIND.closeRefresh();
                    }, function() {
                        MGC_LIVEROOM_BIND.closeRefresh();
                    });
                    return;
                    break;
                case 53:
                    msg = '这个房间已经被关闭了';
                    break;
                case 55:
                    msg = '对不起，由于现在进入房间的人数太多，导致服务器压力过大，请稍后再试';
                    break;
                case 56:
                    msg = '您现在没有门票，快去购票吧！购买成功后，需要重新进入演唱会房间才可以观看。';
                    break;
                case 57:
                    msg = '对不起，没有这个房间。';
                    break;
                case 58:
                    msg = '对不起，没有这个房间。';
                    break;
                case 59:
                    msg = '当前房间没有直播内容，精彩内容稍后上演。';
                    break;
                case 60:
                    msg = '对不起，没有这个房间。';
                    break;
                case 65:
                    //window.mgc.common_logic.CheckNameError(12);
                    return false;
                    break;
                case 73:
                    msg = '进入房间失败，该账号内角色可同时进入该视频房间的数量已达上限';
                    break;
                default:
                    //
            }
            if (_repStr.res != 0) {
                MGC_Comm.CommonDialog({
                    "Title": "提示",
                    "Note": msg
                }, function() {
                    MGC_LIVEROOM_BIND.closeRefresh();
                });
                return false;
            }
            //在线人数
            var playCount = _repStr.info.m_player_count;
            //$m('#onlineCount').html(playCount);
            $m(".onlineNum span").text(playCount);
            //是否显示主播列表
            var nest_count = _repStr.info.nest_count;
            if (nest_count <= 0) {
                $m('#zhuboliebiao').attr("class", "button_zhubolistnone");
                MGC.newTips("本公会还没有签约的主播哟！", $m('#zhuboliebiao'),2);
            } else {
                $m('#zhuboliebiao').attr("class", "button_zhubolist");
                MGC_CommRequest.getZhuBoList();
            }
            //紅包
            if (_repStr.info.m_redenvelopes.length > 0) {
                MGC_CommResponse.showOldRedPacket(_repStr.info);
                if (window.mgc.tools.cookie("mgc_redpack") == null) {
                } else {
                    window.mgc.tools.cookie("mgc_redpack", 'has', {
                        path: '/',
                        domain: '.qq.com'
                    });
                }
            } else {
                window.mgc.tools.cookie("mgc_redpack", 'has', {
                    path: '/',
                    domain: '.qq.com'
                });
            }
            MGC.progressTime('progressTime', 120);
        } else {
            MGC_Comm.CommonDialog({
                "Title": "提示",
                "Note": "很抱歉，进入房间失败，请重试"
            }, function() {
                window.location.href = window.mgc.tools.changeUrlToLivearea(home);
            });
        }
        //热度宝箱开始倒计时

        //热门房间
        //MGC_CommRequest.HotRecommRoom();
        HotRoom.getHotRoom();
    },
    goodFriendArr: {},
    //好友充值回调
    goodFriendPayCallBack: function (responseStr) {
        console.log('{"op_type":185}:回调' + responseStr);
        if (!(mgc.account.checkGuestStatus(true))) {
            var _repStr = responseStr;
            if (typeof (_repStr.friendpay) == 'undefined') {
                MGC_CommResponse.goodFriendArr = _repStr;
            } else {
                MGC_CommResponse.goodFriendArr = _repStr.friendpay;
            }
            if (MGC_CommResponse.goodFriendArr.length > 0) {
                //填充第一个数据，弹窗，删除第一个数据
                MGC_CommResponse.goodFriendPaypop();
            }
        }
    },
    goodFriendHas: function () {
        if (MGC_CommResponse.goodFriendArr.length > 0) {
            MGC_CommResponse.goodFriendPayCallBack(MGC_CommResponse.goodFriendArr);
        }
    },
    goodFriendPaypop: function () {
        //填充第一个数据，弹窗，删除第一个数据            
        var obj = MGC_CommResponse.goodFriendArr[0];
        var con = $('#goodFriendPayTmpl');
        var tmpl;
        var container = $('#goodFriendPayContainer');
        container.children().remove();
        tmpl = con.tmpl(obj);
        tmpl.appendTo(container);
        MGC_CommResponse.goodFriendArr.shift();
        window.mgc.popmanager.layerControlShow($('#goodFriendPay'), 5, 1);
        $('#confirmBtn2,#closeBtn2').unbind('click').bind('click', function () {
            window.mgc.popmanager.layerControlHide($('#goodFriendPay'), 5, 1);
            MGC_CommResponse.goodFriendHas();
        });
        tmpl = null;
        con = null;
    },

    giftAddexp_max_anchor_exp: 0,
    gifDataExp_total_anchor_exp: 0,
    //梦幻币礼物增加经验值
    giftAddexp: function(obj) {
        var gifDataExp = obj;
        giftAddexp_max_anchor_exp = gifDataExp.max_anchor_exp;
        gifDataExp_total_anchor_exp = gifDataExp.total_anchor_exp;
        MGCData.max_anchor_exp = giftAddexp_max_anchor_exp;
        MGCData.total_anchor_exp = gifDataExp_total_anchor_exp;
        if (MGCData.anchor_level_max) {
            $m('#forAnchor_exp').html(0 + '/' + 0);
        } else {
            $m('#forAnchor_exp').html(gifDataExp_total_anchor_exp + '/' + giftAddexp_max_anchor_exp);
        }
    },
    mouseoverBadge: function() {
        $m('body').on('mouseover', 'em[class^="badge"],i[class^="badge"]', function(e) {
            var badge_id = $m(this).attr('mgc_data');
            var tips = '';
            if (badge_id == '0') {
                return;
            } else if (badge_id) {
                tips = window.mgc.config.BADGE_CONFIG[badge_id].badge_tips;
            }
            MGC.susTipsHtmlPop(e, 1, tips);

        });
    },
    mouseoutBadge: function() {
        $m('body').on('mouseout', 'em[class^="badge"],i[class^="badge"]', function(e) {
            MGC.susTipsHtmlPop(e, 0);
        });
    },

    //刷新房间信息
    refreshRoom: function(obj) {
        //初始化礼物插件存储信息        
        if (typeof (obj) == 'object') {
            LiveRoomData = obj;
        } else {
            LiveRoomData = JSON.parse(obj);
        }
        //JSON.stringify(obj);
        if (MGC_SWFINIT.GiftSwf) {
            gift_response(LiveRoomData);
        };
        //进入房间，主动刷新房间信息
        console.log('房间多的第三方的手' + JSON.stringify(obj));

        /**
         * 0-无效
         * 1-等待
         * 2-直播
         * 3-已关闭
         */
        var _status = obj.data.status;
        console.log('直播状态：' + _status);
        MGCData.roomStatus = _status;
        //设置房间ID
        MGCData.roomID = obj.data.roomID;
        //设置房间名
        MGCData.roomName = obj.data.roomName;
        //设置主播信息
        if (_status == 2) {
            console.log("开播");
            MGCData.anchorID = obj.data.anchorID;
            MGCData.anchorName = obj.data.anchorName;
            //房间热度开始遮罩
            //MGC.progressTime('progressTime', leftLiveRoomProTime);
            //直播中，显示任务
            $m('#anchorTask').show();
            //隐藏幻灯片、未直播推荐
            $m("#video_pic").hide();
            $m(".video_recommend_list").hide()
        } else {
            //没有在直播，不需要遮罩
            //$m('.progress_time').hide();
            //没有直播，不需要热度加速按钮
            $m('#addHotContainer').hide();
            //直播加上幻灯图片
            MGC_CommRequest.getRoomUrl();
            //$m('.hiddenAnchor').hide();
            //未直播房间推荐
            //MGC_CommRequest.getSmallHotRecommRoom();
            SmallHotRoom.getHotRoom();
            //$m('.hiddenAnchor').hide();
            $j('.attention,.hiddenAnchor').hide();
        }
        //是否关注了主播--已经在29中实现
        //MGC_CommRequest.isFollowAnchor();
        //获取个人信息
        //MGC_CommRequest.getOwnInfo();
        //首次拉取在线玩家列表
        MGC_CommRequest.getRoleList(); //s
        //获取主播任务 --这里应该主动回调的，测试的时候手动调用todo
        //MGC_CommRequest.getTaskInfo();

    },

    //非主动更新主播信息
    is_first:true,
    refreshAnchor: function(obj) {
        console.log('非主动更新主播信息 start' + JSON.stringify(obj));
        var obj = MGC_Comm.strToJson(obj);
        // var _anchorInfo = obj.data;
        $m.extend(true, _anchorInfo, obj.data);
        //添加首次刷新逻辑
        if (MGC_SpecialResponse.is_first) {            
            if (_anchorInfo.anchorID != 0) {//开播状态
                MGCData.roomID = roomId;
                MGCData.roomName = obj.roomName;
                MGCData.roomStatus = 2;
                MGCData.isShow = true;
                MGCData.followAnchor = obj.isFollow;
                MGC_SpecialResponse.is_first = false;
            } else {//未开播状态
                MGCData.roomID = roomId;
                MGCData.roomName = obj.roomName;
                MGCData.roomStatus = 2;
                MGCData.isShow = false;
                _anchorInfo.photoUrl = HeadImgPath + "default_female.png?v=3_8_8_2016_15_4_final_3";
            }
        }
        MGCData.anchorName = _anchorInfo.name;
        _anchorInfo.roomId = MGCData.roomID == "0" ? "" : MGCData.roomID;
        _anchorInfo.roomName = MGCData.roomName;
        //印象数据
        _anchorInfo.impression = _anchorInfo.follow = _anchorInfo.followNum = '';
        var anchorContainer = $m('#anchorContainer');
        var ac = $m('#anchorContainer');

        var anchorImg = ac.find(".si_face_links").find("img");

        if (MGCData.roomStatus == 2) {
            MGCData.anchorID = obj.data.anchorID;
            $m('#reminder_room').fadeOut();
            clearTimeout(MGC_CommResponse.timerRoom);
            clearTimeout(MGC_CommResponse.timerRoomHide);
            var _impression = obj.data.m_impression_data.m_impressions;
            var _impressionArr = new Array();
            var _maxImpression = 2;
            $m.each(_impression, function(k, v) {
                if (k < _maxImpression) {
                    _impressionArr.push(v.m_impression_id);
                }
            });
            if (_impressionArr.length < _maxImpression) {
                var _tmpMax = _maxImpression - _impressionArr.length;
                var _tmpStart = 0;
                $m.each(MGC_ANCHORIMPRESSION, function(k, v) {
                    k = parseInt(k);
                    if (_impressionArr.indexOf(k) == -1) {
                        if (_tmpStart < _tmpMax) {
                            ++_tmpStart;
                            _impressionArr.push(k);
                        } else {
                            return false;
                        }
                    }
                });
            }
            $m.each(_impressionArr, function(k, v) {
                _anchorInfo.impression += "<span>" + MGC_ANCHORIMPRESSION[v] + "</span>";
            });
            _anchorInfo.follow = MGCData.difFollowAnchor[MGCData.isAnchorOrRoom].followAnchor == 0 ? "关注" : "取消关注";
            _anchorInfo.followNum = _anchorInfo.followedAudiences + " 位粉丝";
            //var anchorTmpl = $m('#anchorTmpl');
            //anchorContainer.html(anchorTmpl.tmpl(_anchorInfo));

            if (_anchorInfo.roomId == undefined) {
                _anchorInfo.roomId = "";
            }
            if (_anchorInfo.roomName == undefined) {
                _anchorInfo.roomName = "";
            }
            if (_anchorInfo.roomId != "" || _anchorInfo.roomName != "") {
                var siRoom = ac.find(".si_room");
                siRoom.children().removeAll();
                siRoom.html("<span>" + _anchorInfo.roomId + "：</span><strong>" + _anchorInfo.roomName + "</strong>");
            }

            if (anchorImg.attr("src") != _anchorInfo.photoUrl) {
                anchorImg.attr("src", _anchorInfo.photoUrl);
            }
            //ac.find(".si_face_links").find("img").attr("src", _anchorInfo.photoUrl);
            var badgeStr = "";
            switch (_anchorInfo.anchor_badge) {
                case 0:
                    break;
                case 1:
                    badgeStr = "badge badge_gold";
                    break;
                case 2:
                    badgeStr = "badge badge_silver";
                    break;
                case 3:
                    badgeStr = "badge badge_copper";
                    break;
                case 4:
                    badgeStr = "badge badge_yx";
                    break;
                case 5:
                    badgeStr = "badge badge_yr";
                    break;
                case 6:
                    badgeStr = "badge badge_sd";
                    break;
                case 7:
                    badgeStr = "badge badge_zq";
                    break;
                default:
                    break;
            }
            if(_anchorInfo.anchor_badge == 0){
                ac.find(".sf_nic").find("em").hide();
            } else{
                ac.find(".sf_nic").find("em").attr("style", "background:url(http://ossweb-img.qq.com/images/mgc/css_img/common/anchor_badge_small/" + _anchorInfo.anchor_badge + ".png?v=3_8_8_2016_15_4_final_3) no-repeat;").show();
            }
            ac.find(".sf_nic").find("em").attr("class", "badge");
            ac.find(".sf_nic").find("em").attr("mgc_data", _anchorInfo.anchor_badge);
            ac.find(".sf_nic").find("strong").html(_anchorInfo.name);
            var sfFlower= ac.find(".sf_flower");
            sfFlower.children().removeAll();
            sfFlower.html(_anchorInfo.popularity + '<i id="i_top"></i>');
            var sfHeart= ac.find(".sf_heart");
            sfHeart.children().removeAll();
            sfHeart.html(_anchorInfo.starlight + '<i id="i_top_two"></i>');
            var sfLabel = ac.find(".si_label");
            sfLabel.children().removeAll();
            sfLabel.html(_anchorInfo.impression + '<i>可在主播名片中添加主播印象</i>');
            ac.find(".si_attention").html(_anchorInfo.follow);
            var siFansNum = ac.find(".si_fans_num");
            siFansNum.children().removeAll();
            siFansNum.html("<span></span>" + _anchorInfo.followNum);
            
            if (MGCData.roomID == "0") {
                anchorContainer.find(".si_room span").hide();
            } else {
                anchorContainer.find(".si_room span").show();
            }
            if(MGCData.isShow)
            {
                $m('.attention,.hiddenAnchor').show();
            }
            else
            {
                $m('.attention,.hiddenAnchor').hide();
                MGCData.roomStatus = 0;
            }
        } else {
            //不再直播使用默认头像
            _anchorInfo.photoUrl = HeadImgPath + "default_female.png?v=3_8_8_2016_15_4_final_3";
            _anchorInfo.name = "";
            if (anchorImg.attr("src") != _anchorInfo.photoUrl) {
                anchorImg.attr("src", _anchorInfo.photoUrl);
            }
            //ac.find(".si_face_links").find("img").attr("src", _anchorInfo.photoUrl);
        }
        

        anchorContainer.find(".sf_flower").off("mouseover,mouseout").on("mouseover", function(){
            MGC.pop_rqTips(event, 1, '赠送免费礼物增加主播人气，主播人气会随时间衰减');      
        }).on("mouseout", function(){
            MGC.pop_rqTips(event, 0);
        });
        anchorContainer.find(".sf_heart").off("mouseover,mouseout").on("mouseover", function(){
            MGC.pop_rq_two_Tips(event, 1, '赠送付费礼物增加主播星耀值');        
        }).on("mouseout", function(){
            MGC.pop_rq_two_Tips(event, 0);
        });

        MGCData.anchor_level = _anchorInfo.anchor_level;
        _anchorInfo.anchor_level_temp = Math.floor(_anchorInfo.anchor_level / 10) + 1;
        if (_anchorInfo.anchor_level == 0) {
            _anchorInfo.anchor_level_temp = 0;
        }


        _anchorInfo.max_anchor_exp = 0;
        _anchorInfo.total_anchor_exp = 0;
        if (_anchorInfo.anchor_levelup_exp == -1) {
            MGCData.anchor_level_max = true;
            _anchorInfo.max_anchor_exp = 0;
            _anchorInfo.total_anchor_exp = 0;
        } else {
            if (typeof giftAddexp_max_anchor_exp != 'undefined' || typeof gifDataExp_total_anchor_exp != 'undefined') {
                _anchorInfo.max_anchor_exp = giftAddexp_max_anchor_exp;
                _anchorInfo.total_anchor_exp = gifDataExp_total_anchor_exp;
            }
        }
        _anchorInfo.giftData = MGCData.giftData;

        _anchorInfo.anchor_Per = 0;
        if ((_anchorInfo.anchor_levelup_exp == -1) || _anchorInfo.anchor_levelup_exp == 0) {
            _anchorInfo.anchor_Per = 100 + '%';
        } else {
            _anchorInfo.anchor_Per = (_anchorInfo.anchor_exp / _anchorInfo.anchor_levelup_exp * 100).toFixed(0);

            if (_anchorInfo.anchor_Per <= 0 || _anchorInfo.anchor_Per == '0') {
                _anchorInfo.anchor_Per = 0;
            } else if (_anchorInfo.anchor_Per >= 100) {
                _anchorInfo.anchor_Per = 100 + '%';
            } else {
                _anchorInfo.anchor_Per = _anchorInfo.anchor_Per + '%';
            }
        }
        MGCData.anchor_Per = _anchorInfo.anchor_Per;
        //主播等级背景底图
        MGCData.anchor_level_bg = _anchorInfo.anchor_level_temp;
        //主播等级瓶颈标识
        MGCData.is_bottleneck = _anchorInfo.is_bottleneck;

        //主播等级当前经验
        MGCData.anchor_exp = _anchorInfo.anchor_exp;

        //主播等级当前经验需要达到下一经验的经验值
        MGCData.anchor_levelup_exp = _anchorInfo.anchor_levelup_exp;

        //主播瓶颈送的礼物数量
        MGCData.bottleneck_count = _anchorInfo.bottleneck_count;

        //主播瓶颈送的礼物ID
        MGCData.bottleneck_gift_id = _anchorInfo.bottleneck_gift_id;

        //主播瓶颈需要送的礼物数量
        MGCData.bottleneck_need_count = _anchorInfo.bottleneck_need_count;

        //通过星耀值还可为主播增加的主播经验值上限
        MGCData.starlight_rest_exp_today = _anchorInfo.starlight_rest_exp_today;

        //通过梦幻币礼物还可为主播增加的主播经验值上限
        MGCData.dream_gift_rest_exp_today = _anchorInfo.dream_gift_rest_exp_today;
        
        //抽奖可增加经验
        MGCData.lucky_draw_rest_exp_today = _anchorInfo.lucky_draw_rest_exp_today;

        //公会房间里的主播等级经验槽数据加载内容
        //主播经验条区域加载内容

        if (MGCData.roomStatus == 2) {
            //当主播信息接口未被刷新时候，初始化页面--如果主播等级非零，加载主播经验区域
            if (MGCData.anchor_level != 0) {
                //初始化经验条主播区域
                $j('#anchor_level').show();
                $j('#anchor_level_temp').attr('class', '');
                $j('#anchor_level_temp').attr("class", "anchorLevel anchor_level_" + MGCData.anchor_level_bg);
                $j('#anchor_level_temp').html('<i>' + MGCData.anchor_level + '</i>');
                $j('#anchor_level_temp').css({ 'display': 'inline-block', 'position': 'absolute' });
                $j('#anchor_level_temp').css("background","url('http://ossweb-img.qq.com/images/mgc/css_img/common/anchor_level/"+ MGCData.anchor_level_bg +".png?v=3_8_8_2016_15_4_final_3') no-repeat right center");
                //当是瓶颈的时候
                if (MGCData.is_bottleneck) {
                	if($j('#is_bottleneck').css('display')=="none"){
                    	$j('#anchor_level_tips').css('display', 'none');
                        window.mgc.popmanager.layerControlHide($j('#anchor_level_tips').find("strong"), 1, 3);
                    }
                    //初始化瓶颈区域
                    //先清空满级经验条状态
                	$j('#max_span,#max_i').css('display', 'none');

                    var bottlePer = Math.floor(MGCData.bottleneck_count / MGCData.bottleneck_need_count * 100);
                    if (bottlePer == 0) {
                        $j('#bottle_per').hide();
                    } else {
                    	$j('#bottle_per').show();
                        $j('#bottle_per').width(bottlePer + "%");
                    }
                    $j('#is_bottleneck').css({ 'display': 'inline-block', 'position': 'absolute' });
                    $j('#i_is_bottleneck').css('display', 'block');
                    $j('#gift_mover,#exp_common,#exp_max').css('display', 'none');
                    $j('#anchor_level_txt').hide();
                    $j('#anchor_Per,#spanW0,#anchor_exp,#pd_progress').css('display', 'none');
                    $j('#anchor_level_tips strong').css('width', '168px');

                    $j("#anchor_level .anchor-up").show();
                } else {
                    $j("#anchor_level .anchor-up").hide();
                    
                	if($j('#is_bottleneck').css('display')!="none"){
                    	$j('#anchor_level_tips').css('display', 'none');
                        window.mgc.popmanager.layerControlHide($j('#anchor_level_tips').find("strong"), 1, 3);
                    }
                	$j('#anchor_level_tips strong').css('width', '303px');
                	$j('#i_is_bottleneck').css('display', 'none');
                	$j('#gift_mover,#exp_common').css('display', 'block');
                    $j('#anchor_level_txt').show();
                    //不是瓶颈期其他情况
                    //先清空满级经验条状态
                    $j('#max_span,#max_i').css('display', 'none');

                    $j('#pd_progress').css('display', 'block'); //经验条显示
                    $j('#is_bottleneck').css('display', 'none');
                    $j('#anchor_exp').css('line-height', '13px');
                    $j('#anchor_Per').width(MGCData.anchor_Per);
                    //满级
                    if (MGCData.anchor_levelup_exp == -1) {
                        $j('#max_span,#anchor_Per,#anchor_exp').css('display', 'block');                        
                        $j('#max_i').css('display', 'block');
                        $j('#anchor_exp').html('max');
                        $j('#anchor_exp').css('line-height', '9px');
                        $j('#exp_max').css('display', 'block');
                        $j('#exp_common').css('display', 'none');
                        $j('#i_mhb_exp').html(MGCData.dream_gift_rest_exp_today);
                        $j('#i_star_exp').html(MGCData.starlight_rest_exp_today);
                        $j('#i_lucky_exp').html(MGCData.lucky_draw_rest_exp_today);
                        //下一经验开始时候（0/num）--判断经验条上，当前经验为0的样式效果
                    } else if ((MGCData.anchor_exp == 0 && MGCData.anchor_levelup_exp != 0) || MGCData.anchor_Per == 0) {
                        $j('#spanW0').css('display', 'block');
                        $j('#anchor_exp').css('display', 'block');
                        $j('#anchor_Per').css('display', 'none');
                        $j('#anchor_exp').html(MGCData.anchor_exp + '/' + MGCData.anchor_levelup_exp);
                        //经验条正常显示效果
                    } else {
                        $j('#anchor_Per').css('width', MGCData.anchor_Per);
                        $j('#anchor_Per,#anchor_exp').css('display', 'block');
                        $j('#anchor_exp').html(MGCData.anchor_exp + '/' + MGCData.anchor_levelup_exp);

                    }
                }
                //当主播信息接口未被刷新时候，初始化页面--如果主播等级是零，主播经验区域不显示
            } else {
                $j('.anchor_level,#pd_progress,#is_bottleneck').css('display', 'none');
                $j('.anchor_icon .anchor_level').css('display', 'block');
            }
        } else if (MGCData.roomStatus == 1) {
            $j('.si_open_vip').children().remove();
            $j('.si_open_vip').html('<p id="si_open_vip_swf_1"></p><span></span>');
            $j('.anchor_level,#pd_progress,#is_bottleneck,.attention,.hiddenAnchor').css('display', 'none');
            $j('.anchor_icon .anchor_level').css('display', 'block');
            var strongItem = $m('#anchor_level_tips').find("strong");
            window.mgc.popmanager.layerControlHide(strongItem, 1, 3);
            $j('#anchorContainer .sf_nic').children().remove();
            $j('#anchorContainer .sf_nic').html('<strong></strong>');
        }
        //主播等级经验条区域结束
        $m('.pd_progress').css('overflow', 'inherit');
        //如果在直播中，则要显示
        if (MGCData.roomStatus == 2) {
            $m('.attention,.hiddenAnchor').show();
        }
        MGC.popTipss("pop_tips", "i");

        if (MGCData.roomStatus == 2) {
            //绑定名片动作
            $m('.layer-anchor .anchor-hot').css("cursor","pointer");
            $m('#anchorCard,.layer-anchor .anchor-hot').off('click').on('click', function() {
                MGC_CommRequest.getAnchorCard();
            });
            
            //是否已经关注主播
            if (obj.isFollow) {
                MGCData.difFollowAnchor[MGCData.isAnchorOrRoom].followAnchor = 1;
                //关注了
                $m('.si_attention').text('已关注');
            } else {
                MGCData.difFollowAnchor[MGCData.isAnchorOrRoom].followAnchor = 0;
                //未关注
                $m('.si_attention').text('关注');
            }

            $m('.si_attention').off("mouseover").on('mouseover', function(e) {
                if ($m('.si_attention').text() == '关注') {
                    $m('.sus_tips_').css('width', '163px');
                    $m('.sus_tips_').text('关注TA,主播直播时可收到通知')
                    MGC.susStatepositionTips(e, 1, "关注TA,主播直播时可收到通知");
                } else {
                    $m('.si_attention').text('取消');
                    $m('.sus_tips_').css('width', '160px');
                    $m('.sus_tips_').text('点击即可取消关注');
                    MGC.susStatepositionTips(e, 1, "点击即可取消关注");
                }
            });
            $m('.si_attention').off('mouseout').on('mouseout', function(e) {
                if ($m('.si_attention').text() == '取消') {
                    $m('.si_attention').text('已关注');
                }
                $m('.sus_tips_').text('');
                MGC.susStatepositionTips(e, 0);
            });


            $m('.sus_tips_').text('');
            //取消和关注主播绑定
            $m('.si_attention').off('click').on('click', function() {
                MGC_CommRequest.followAnchorAction(0);
            });
            //绑定开通贵族
            mgc.common_contral.CommOpenVip.room_anchor_id = _anchorInfo.anchorID;
            mgc.common_contral.CommOpenVip.room_anchor_name = _anchorInfo.name;
            if ($m('.si_open_vip').find("object").length == 0) {
                mgc.common_contral.CommOpenVip.initOpenBtnSwf(1);
                $m('.si_open_vip span').unbind('click').on('click', function(e) {
                    if (mgc.common_contral.CommOpenVip.room_anchor_id == "0") { return; }
                    mgc.common_contral.CommOpenVip.open(mgc.common_contral.CommOpenVip.room_anchor_id, mgc.common_contral.CommOpenVip.room_anchor_name);
                    mgc.tools.EAS([{ 'e_c': 'mgc.buyvip.2', 'c_t': 4 }, { 'e_c': 'mgc.buyvip', 'c_t': 4 }]);
                }).unbind("mouseover").bind("mouseover", function(e) {
                    window.mgc.popmanager.layerControlShow($m(".sus_tips_open_vip"), 1, 3);
                }).unbind("mouseout").bind("mouseout", function(e) {
                    window.mgc.popmanager.layerControlHide($m(".sus_tips_open_vip"), 1, 3);
                });
            }
            //更新右边的公告栏
            $m('.sn_tips').children().removeAll();
            $m('.sn_tips').html('<div>' + _anchorInfo.intro + '</div>');
            //举报
            $m('.si_fk').off('click').on('click', function() {
                DoReport.initReport();
                MGC.mnsSelect("icon_report", "icon_report_list");
            });
        }else{
            //$m('#si_face_links').off('click');
            $m('.layer-anchor .anchor-hot').css("cursor","auto");
            $m('#anchorCard,.layer-anchor .anchor-hot').off('click')
        }
       
        obj = null;
        // _anchorInfo = null;
        anchorContainer = null;
        ac = null;
        console.log('非主动更新主播信息 end');
    },

    refreshOnlineNums: function(obj) {
        //刷新在线人数
        var playCount = obj.count;
        //$m('#onlineCount').text(playCount);
        $m(".onlineNum span").text(playCount);
        obj = null;
    },

    //超级粉丝
    getFans: function(obj) {
        console.log("收到的超级粉丝信息：" + JSON.stringify(obj));
        if (obj.ret == 0) {
            _fansInfo.length = 0;
            $m.extend(true, _fansInfo, obj.data);
            $m.each(_fansInfo, function(k, v) {
                if (k == 0) {
                    v.liClass = "sr_first";
                } else if (k == 1) {
                    v.liClass = "sr_second";
                } else if (k == 2) {
                    v.liClass = "sr_third";
                } else {
                    v.liClass = "";
                }
                v.liNum = k + 1;
                //登录图标
                if (v.guardlevel == 0) {
                    v.guardlevelClass = "icon_lv";
                } else {
                    v.guardlevelClass = "icon_lv icon_lv" + v.guardlevel;
                    v.guard_levelShow = '';
                    if (v.guardlevel > 0) {
                        v.guard_levelShow = guardLevelTab[v.guardlevel];
                    }
                }
                if (v.viplevel == 0) {
                    v.viplevelClass = "icon_honor";
                } else {
                    v.viplevelClass = "icon_honor icon_honor" + v.viplevel;
                }
                v.zoneName = v.zoneName != "" ? (v.zoneName == "梦工厂" ? v.zoneName : "炫舞-" + v.zoneName) : "";
            });
            var _fansLeng = _fansInfo.length;
            var fansTmplCon;
            if (_fansLeng != 0) {
                if (fansContainer.find('.defaultfanscontent')) {
                    fansContainer.find('.defaultfanscontent').remove();
                    $m('.sr_con').jScrollPane({ autoReinitialise: true, animateScroll: true, autoReinitialiseDelay: 100, verticalDragMinHeight: 20 });
                }
                fansTmplCon = fansTmpl.tmpl(_fansInfo);
                fansContainer.children().removeAll();
                fansTmplCon.appendTo(fansContainer);

            } else {
                if ($m('#fansContainer .defaultfanscontent').length == 0) {
                    var guardStr = '';
                    guardStr += '<li class="defaultfanscontent" style="text-align: center; line-height: 20px; margin-top:15px;">这里都是主播的超级粉丝哦<br />快和他们交个朋友吧！</li>';
                    fansContainer.children().removeAll();
                    fansTmplCon = fansTmpl.tmpl(_fansInfo);
                    fansTmplCon.appendTo(fansContainer);
                    fansContainer.append(guardStr);

                }
            }
            
            fansContainer.find("i").off("mouseover,mouseout").on("mouseover", function(){
                var guardLevel = $(this).attr("mgc_guardlevel");
                var vipName = $(this).attr("mgc_vipName");
                if (guardLevel) {
                    MGC.jiangLiTips(this, 1, guardLevel);
                } else if (vipName) {
                    MGC.jiangLiTips(this, 1, vipName);
                }
            }).on("mouseout", function(){
                MGC.jiangLiTips(this, 0);
            }); 

            $m("#fansContainer").find("li b").eq(9).css("text-indent", "-4px");
            $m('#fansContainer .li_sz_room').off('click').on('click', function() {
                inv_from = 3;
                card_source = 4;
                var _playId = $m(this).attr('playerid');
                var _name = $m(this).attr('name');
                var _area = $m(this).attr('area');
                var _type = 1;
                if (_playId == 0 || _playId == '') {
                    alert('很抱歉，系统异常，请刷新页面再试。');
                    return false;
                }
                //请求玩家信息
                mgc.common_contral.mgc_comm.eventInfo = MGC.getEvent();
                MGC_CommRequest.getPlayerInfo(_name, _area);
                //注：  此处event为引类型，在传递过程中event改变,赋值变量随即改变，因此此处要复制一个event对象指向不同的地址。 兼容ie

            });
            $m('#cjfs_li').off('click').on('click', function() {
                MGC.scrollPosition('sr_con', 0);
            });
            fansTmplCon = null;
            //调用守护的数据
            /*var _reqStr = "{\"op_type\":" + OpType.GetGuardOpType + ", \"fanstype\":1,\"anchorID\":" + MGCData.anchorID + "}";
            console.log("调用守护信息：" + _reqStr);
            MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getGuard");*/
        } else {
            //异常
        }
        obj = null;
        //重绘滚动条
        if ($m("#sr_tab").find(".current").parent().index() == 0) {
            if (!mgc.consts.API.scroll.fanslist)
                mgc.consts.API.scroll.fanslist = $m('.sr_con').data('jsp');
            if(mgc.consts.API.scroll.fanslist){
                mgc.consts.API.scroll.fanslist.initScroll();
            }
        }
    },

    //守卫
    getGuard: function(obj) {
        console.log("收到的守护信息：" + obj);
        obj = MGC_Comm.strToJson(obj);
        if (obj.ret == 0) {
            _guardInfo.length = 0;
            $m.extend(true, _guardInfo, obj.data);
            $m.each(_guardInfo, function(k, v) {
                if (k == 0) {
                    v.liClass = "sr_first";
                } else if (k == 1) {
                    v.liClass = "sr_second";
                } else if (k == 2) {
                    v.liClass = "sr_third";
                } else {
                    v.liClass = "";
                }
                v.liNum = k + 1;
                //登录图标
                if (v.guardlevel == 0) {
                    v.guardlevelClass = "icon_lv";
                } else {
                    v.guardlevelClass = "icon_lv icon_lv" + v.guardlevel;
                    v.guard_levelShow = '';
                    if (v.guardlevel > 0) {
                        v.guard_levelShow = guardLevelTab[v.guardlevel];
                    }
                }
                if (v.viplevel == 0) {
                    v.viplevelClass = "icon_honor";
                } else {
                    v.viplevelClass = "icon_honor icon_honor" + v.viplevel;
                    v.vipName = vipLevelTab[v.viplevel];
                }
                v.zoneName = v.zoneName != "" ? (v.zoneName == "梦工厂" ? v.zoneName : "炫舞-" + v.zoneName) : "";
            });
            var _guardLeng = _guardInfo.length;
            var guardTmplCon;
            if (_guardLeng != 0) {
                if (guardContainer.find('.defaultfanscontent')) {
                    guardContainer.find('.defaultfanscontent').remove();
                    $m('.sr_con').jScrollPane({ autoReinitialise: true, animateScroll: true, autoReinitialiseDelay: 100, verticalDragMinHeight: 20 });
                }
                guardTmplCon = guardTmpl.tmpl(_guardInfo);
                guardContainer.children().removeAll();
                guardTmplCon.appendTo(guardContainer);
            } else {
                if ($m('#guardContainer .defaultfanscontent').length == 0) {
                    var guardStr = '';
                    guardStr += '<li class="defaultfanscontent" style="text-align: center; line-height: 20px; margin-top: 5px;">这里都是主播的超级粉丝哦<br />快和他们交个朋友吧！</li>';
                    guardContainer.children().removeAll();
                    guardTmplCon = guardTmpl.tmpl(_guardInfo);
                    guardTmplCon.appendTo(guardContainer);
                    guardContainer.append(guardStr);
                }
            }            
            
            guardContainer.find("i").off("mouseover,mouseout").on("mouseover", function(){
                var guardLevel = $(this).attr("mgc_guardlevel");
                var vipName = $(this).attr("mgc_vipName");
                if(guardLevel)
                {
                    MGC.jiangLiTips(this, 1, guardLevel);
                }
                else{
                    if(vipName)
                    {
                        MGC.jiangLiTips(this, 1, vipName);
                    }
                }
            }).on("mouseout", function(){
                MGC.jiangLiTips(this,0);
            });
            
            $m('#guardContainer .li_sz_room').off('click').on('click', function() {
                inv_from = 3;
                card_source = 5;
                var _playId = $m(this).attr('playerid');
                var _name = $m(this).attr('name');
                var _area = $m(this).attr('area');
                var _type = 1;
                if (_playId == 0 || _playId == '') {
                    alert('很抱歉，系统异常，请刷新页面再试。');
                    return false;
                }
                //请求玩家信息
                MGC_CommRequest.getPlayerInfo(_name, _area);
                //注：  此处event为引类型，在传递过程中event改变,赋值变量随即改变，因此此处要复制一个event对象指向不同的地址。 兼容ie
                mgc.common_contral.mgc_comm.eventInfo = MGC.getEvent();
            });
            $m("#guardContainer").find("li b").eq(9).css("text-indent", "-4px");
            $m('#sh_li').off('click').on('click', function() {
                MGC.scrollPosition('sr_con', 1);
            });
            guardTmplCon = null;
        } else {
            //异常
        }
        obj = null;
        //重绘滚动条
        if ($m("#sr_tab").find(".current").parent().index() == 1) {
            if (!mgc.consts.API.scroll.fanslist)
                mgc.consts.API.scroll.fanslist = $m('.sr_con').data('jsp');
            if(mgc.consts.API.scroll.fanslist){
                mgc.consts.API.scroll.fanslist.initScroll();
            }
        }
    },

    //渲染角色列表
    appendRoleList: function(obj) {
        console.log("获取到的角色列表：" + JSON.stringify(obj));
        obj = MGC_Comm.strToJson(obj);
        if (obj.roomID != MGCData.roomID) {
            //to do 返回的房间ID和当前的房间ID不一致的情况
        } else {
            _roleListInfo.length = 0;
            $m.extend(true, _roleListInfo, obj.players);
            var _isSelf = false;
            $m.each(_roleListInfo, function(k, v) {
                //登录图标
                if (v.playerType == 3) {
                    v.guardlevelClass = "";
                    //游客身份
                    //v.name = "游客" + v.playerID;
                } else if (v.playerType == 2) {
                    //永久禁言》临时禁言》守护
                    if (v.perpetualTalkForbidden) {
                        v.guardlevelClass = "icon_forever";
                        v.guardlevelShow = "该用户被永久禁言";
                    } else if (v.talkForbidden) {
                        v.guardlevelClass = "icon_temp";
                        v.guardlevelShow = "该用户被临时禁言";
                    } else if (v.guardLevel == 0) {
                        v.guardlevelClass = "icon_lv";
                    } else {
                        v.guardlevelClass = "icon_lv icon_lv" + v.guardLevel;
                        v.guardlevelShow = guardLevelTab[v.guardLevel];
                    }
                    if (v.viplevel == 0) {
                        v.viplevelClass = "icon_honor";
                    } else {
                        v.viplevelClass = "icon_honor icon_honor" + v.viplevel;
                        v.viplevelShow = vipLevelTab[v.viplevel];
                    }
                    v.videoLevelShow = 'LV' + v.videoLevel;
                } else if (v.playerType == 1) {
                    v.wealth = '';
                    v.videoLevelShow = '';
                    v.guardlevelClass = "icon_admin";
                    v.guardlevelShow = "管理员";
                } else if (v.playerType == 0) {
                    v.wealth = '';
                    v.videoLevelShow = '';
                    v.anchor_level_temp = 0;
                    v.anchor_level_temp = Math.floor(v.anchor_level / 10) + 1;
                    if (v.anchor_level == 0) {
                        v.anchor_level_temp = 0;
                    }
                    if (v.starAnchor) { //星级主播
                        v.guardlevelClass = "icon_star";
                        v.guardlevelShow = "星级主播";
                    } else if (v.isOnLive) {
                        v.guardlevelClass = "icon_anchor";
                        v.guardlevelShow = "主播";
                        v.viplevelClass = "icon_micro";
                    } else {
                        v.guardlevelClass = "icon_anchor";
                        v.guardlevelShow = "主播";
                    }
                }
                v.roleListWeathShow = "财富值";
                v.videoLevelShowTips = "等级";
                //大区展示信息
                v.showAreaName = '';
                v.isMobileManager = false;
                /**
                 *　0:主播
                 *　1:管理员
                 *　2：观众或者叫玩家
                 */
                if (v.playerType == 2) {
                    if (v.zoneID == MGCData.mgcZoneId) {
                        //v.showAreaName = '[梦工厂]';
                        v.showAreaName = '[' + v.zoneName + ']';
                    } else {
                        v.showAreaName = '[炫舞-' + v.zoneName + ']';
                    }
                }
                v.isSelf = false;
                if (!_isSelf) {
                    v.isSelf = true;
                    v.nickColor = "#f26cff";
                    _isSelf = true;
                }
            });
            var roleListTmplCon = roleListTmpl.tmpl(_roleListInfo);
            roleListContainer.children().removeAll();
            roleListTmplCon.appendTo(roleListContainer);
            MGC_LIVEROOM_BIND.popPlayerCard();
            
            roleListContainer.find("i").off("mouseover,mouseout").on("mouseover", function(e){
                var guardLevel = $(this).attr("mgc_guardlevel");
                var vipName = $(this).attr("mgc_vipName");
                if (guardLevel) {
                    MGC.susStateTips(e, 1, guardLevel, -3, 30);
                } else if (vipName) {
                    MGC.susStateTips(e, 1, vipName, -3, 30);
                }
            }).on("mouseout", function(e){
                MGC.susStateTips(e, 0);
            });
            roleListContainer.find("p").off("mouseover,mouseout").on("mouseover", function(e){
                var wealthLevel = $(this).attr("mgc_wealthlevel");
                var videoLevel = $(this).attr("mgc_videolevel");
                var anchorLevel = $(this).attr("mgc_anchorlevel");

                if (wealthLevel) {
                    MGC.susTipsEnd(e, 1, wealthLevel);
                } else if (videoLevel) {
                    MGC.susTipsEnd(e, 1, videoLevel);
                } else if (anchorLevel) {
                    MGC.susTipsEnd(e, 1, anchorLevel);
                }
            }).on("mouseout", function(e){
                MGC.susTipsEnd(e, 0);
            });
            roleListTmplCon = null;
        }
        //重绘滚动条 
        if (!mgc.consts.API.scroll.rolelist)
            mgc.consts.API.scroll.rolelist = $m('.sn_con').data('jsp');
        if(mgc.consts.API.scroll.rolelist){
            mgc.consts.API.scroll.rolelist.initScroll();
        }
    },

    //非直播，获得房间默认图片
    getRoomUrlCallBack: function (obj) {
        console.log("获得房间幻灯图片：" + JSON.stringify(obj));
        if (MGCData.slideArr.length > 0) {
            obj.urls = MGCData.slideArr;
            //成功获得房间的默认图片
            if (obj.urls.length > 0) {
                /*
                var v = $m("#video_pic");
                var html = "";
                $m.each(obj.urls, function (i, o) {
                    if (i == 0) {
                        html += "<li style='z-index:1;'><img src='" + o + "' /></li>";
                    } else {
                        html += "<li><img src='" + o + "' /></li>";
                    }
                });
                v.html(html);
                v.show();
                MGC.FuncAutoPlay(v);
                */
                mgc.adVideoModel.setBgList(obj.urls);
                $m("#video_pic").show();
            }
        } else {
            //成功获得房间的默认图片
            if (obj.urls.length > 0) {
                /*
                var v = $m("#video_pic");
                var html = "";
                $m.each(obj.urls, function (i, o) {
                    if (i == 0) {
                        html += "<li style='z-index:1;'><img src='" + o + "' /></li>";
                    } else {
                        html += "<li><img src='" + o + "' /></li>";
                    }
                });
                v.html(html);
                v.show();
                MGC.FuncAutoPlay(v);
                */
                mgc.adVideoModel.setBgList(obj.urls);
                $m("#video_pic").show();
            } else {
                /*
                html += "<li style='z-index:1;'><img src='http://ossweb-img.qq.com/images/mgc/css_img/video_room/living.jpg?v=3_8_8_2016_15_4_final_3' /></li>";
                v.html(html);
                v.show();
                */
                mgc.adVideoModel.setBg("http://ossweb-img.qq.com/images/mgc/css_img/video_room/living.jpg?v=3_8_8_2016_15_4_final_3");
                $m("#video_pic").show();
            }
        }
    },
    //聊天
    PushTalk: function(obj) {
        $chat.PushTalk(obj);
        obj = null;
    },
    RevolvingDoor: function(obj) {
        if (obj.op_type == 39) {
            obj.MsgStr = "[" + obj.info.sender + "]" + "对[" + obj.info.anchor + "]" + "献上了" + "#IMG?type=gift_icon&a=" + obj.info.giftid + "#×" + obj.info.num;
        } else if (obj.op_type == 40) {
            //var vip_icon = obj.viplevel > 0 ? "<i class='icon_honor icon_honor" + obj.viplevel + "'></i>" : "";
            var vip_icon = obj.viplevel > 0 ? "#IMG?type=icon_honor&a=" + obj.viplevel + "#": "";
            if (obj.guard_level == 500) {
                //obj.MsgStr = "<i class='icon_lv icon_lv" + obj.guard_level + "'></i>" + obj.player_name + "<i class='icon_honor icon_honor" + obj.viplevel + "'></i>" + "[" + obj.zone_name + "]" + "乘坐赤炎飞马驾临房间" + obj.room_id + ",房间瞬间蓬荜生辉!";
                obj.MsgStr = "#IMG?type=icon_lv&a=" + obj.guard_level + "#超凡守护【" + obj.player_name + "】" + vip_icon + "乘坐梦幻飞马驾临房间" + obj.room_id + "-[" + obj.room_name + "]" + ",房间瞬间蓬荜生辉!";
            }
            else {
                obj.MsgStr = vip_icon + obj.player_name + "驾临至房间" + obj.room_name + "气宇非凡，万民欢腾";
            }
        } else if (obj.op_type == 235) {
            var timedimensionStr = obj.timedimension == 0 ? "日" : obj.timedimension == 1 ? "周" : obj.timedimension == 2 ? "月" : obj.timedimension == 3 ? "总" : "";

            var anchor_level_temp = Math.floor(obj.level / 10) + 1;
            if (obj.level == 0) {
                anchor_level_temp = 0;
            }
            var levelStr = "#IMG?type=anchor_level&a=" + anchor_level_temp + "&b=" + obj.level + "#";

            if (obj.enScrollType == 0) {
                if(obj.video_rank_type == 1)
                {
                    obj.MsgStr = "#IMG?type=rank_icon&a=2#" + obj.anchor_name + "成为了星耀榜" + timedimensionStr + "榜的第" + obj.rank_move + "名，快为" + obj.anchor_name + "送上礼物，助Ta早日夺冠！";
                }
                else if(obj.video_rank_type == 2)
                {
                    obj.MsgStr = "#IMG?type=rank_icon&a=2#" + levelStr + obj.anchor_name + "成为了周星礼物榜(" + obj.gift_name + ")的第" + obj.rank_move + "名，快为" + obj.anchor_name + "送上礼物，助Ta早日夺冠！#任性土豪："+obj.stargift_player_nick;
                }

            } else if (obj.enScrollType == 1) {
                if(obj.video_rank_type == 1)
                {
                    obj.MsgStr = "#IMG?type=rank_icon&a=3#" + obj.anchor_name + "在星耀榜" + timedimensionStr + "榜的排名下降了，快为" + obj.anchor_name + "送上礼物，助Ta早日夺冠！";
                }
                else if(obj.video_rank_type == 2)
                {
                    obj.MsgStr = "#IMG?type=rank_icon&a=3#" + levelStr + obj.anchor_name + "在周星礼物榜(" + obj.gift_name + ")中的排名下降了，快为" + obj.anchor_name + "送上礼物，助Ta早日夺冠！";
                }

            } else if (obj.enScrollType == 2) {
                if(obj.video_rank_type == 1)
                {
                    obj.MsgStr = "恭喜" + obj.anchor_name + "荣登星耀榜" + timedimensionStr + "榜第1名！！";
                }
                else if(obj.video_rank_type == 2)
                {
                    obj.MsgStr = "恭喜" + levelStr + obj.anchor_name + "荣登周星礼物榜(" + obj.gift_name + ")第一名！！#任性土豪："+obj.stargift_player_nick;
                }

            } else if (obj.enScrollType == 3) {
                if(obj.video_rank_type == 1)
                {
                    obj.MsgStr = "#IMG?type=rank_icon&a=2#" + obj.anchor_name + "成为了星耀榜" + timedimensionStr + "榜的第" + obj.rank_move + "名，快为" + obj.anchor_name + "送上礼物，助Ta早日夺冠！";
                }
                else if(obj.video_rank_type == 2)
                {
                    obj.MsgStr = "#IMG?type=rank_icon&a=2#" + levelStr + obj.anchor_name + "成为了周星礼物榜(" + obj.gift_name + ")的第" + obj.rank_move + "名，快为" + obj.anchor_name + "送上礼物，助Ta早日夺冠！#任性土豪："+obj.stargift_player_nick;
                }
            }
        }
        RevolvingDoor = true;
        MGC.marqueeArr(obj);
        obj = null;
    },

    topMeiliCallback: function(obj) {
        console._log("魅力榜第一通知");
        var ii = obj.info;
        var td = ii.rank_timedimension;
        var dStr = td == 0 ? "日" : td == 1 ? "周" : td == 2 ? "月" : td == 3 ? "总" : "";
        //var levelIconStr = "<p class='room_level room_level_" + ii.skin_id + "'><i>" + ii.skin_level + "</i></p>";
        var levelIconStr = "#IMG?type=room_level&a=" + ii.skin_id + "&b=" + ii.skin_level + "#";
        var marqueeStr = "恭喜" + levelIconStr + ii.room_id + "-" + ii.room_name + "荣登房间魅力" + dStr + "榜第一名，进入房间为Ta庆祝吧！";
        var marqueeObj = {
            op_type: obj.op_type,
            MsgStr: marqueeStr
        };
        MGC.marqueeArr(marqueeObj);
    },

    //加载关注的主播信息
    showFollowAnchorCallBack: function(obj) {
        obj = MGC_Comm.strToJson(obj);
        console.log("从服务器获得的我关注的主播信息：" + obj);
    },

    //主动推送宝箱回调
    houseHot: function(obj) {
        console.log("获取的热度宝箱信息34++++++++++++：" + JSON.stringify(obj));
        MGCData.curHeight = obj.curHeight;
        MGCData.maxHeight = obj.maxHeight;
        //将军以上活跃度加成
        var _addHotInfo = {};
        _addHotInfo.perHot = obj.vip_addition;
        _addHotInfo.vipInfo = '';
        $m.each(obj.vip_cnt_info, function(k, v) {
            if (v.count > 0 && v.level > 3) { //将军以上才显示
                _addHotInfo.vipInfo += v.vipname + ' ' + v.count + "名<br>";
            }
        });
        console.log('在线列表 vipInfo = ' + _addHotInfo.vipInfo + ",roomStatus = " +  MGCData.roomStatus);
        $m('#addHotContainer').css("display", "none");
        if (_addHotInfo.vipInfo != '' && MGCData.roomStatus == 2) {

            console.log("在线列表有亲王或者皇帝");

            // var addHotTmpl = $m('#addHotTmpl');
            var addHotCon = $m('#addHotTmpl');
            var addHotTmpl;
            var addHotContainer = $m('#addHotContainer');
            var info = addHotContainer.find("i");
            if(info.length == 0){
                $m("<i></i>").appendTo(addHotContainer);
                info = addHotContainer.find("i");
            }
            info.html("");
            addHotTmpl = addHotCon.tmpl(_addHotInfo);
            addHotTmpl.appendTo(info);
            // addHotTmpl.tmpl(_addHotInfo).appendTo(info);
            $m('#addHotContainer').css("display", "block");
            addHotTmpl = null;
            addHotCon = null;
            addHotContainer = null;
            info = null;
        }
        else {
            console.log("在线列表无亲王或者皇帝");
            $m('#addHotContainer').css("display", "none");
        }
        //主动请求热度宝箱
        //MGC_CommRequest.getHotBox();
        obj = null;
        _addHotInfo = null;
    },

    getStyle: function(obj, attr) {
        return $m(obj).css(attr);
    },
    startMove: function(obj, json, fn) {//实现热度条移动
        var iss = $m('.showSpan i');
        clearInterval(obj.timer);
        obj.timer = setInterval(function() {
            var bStop = true;		//这一次运动就结束了——所有的值都到达了
            for (var attr in json) {
                //1.取当前的值
                var iCur = 0;
                iCur = parseInt(MGC_SpecialResponse.getStyle(obj, attr));
                //2.算速度
                var iSpeed = (json[attr] - iCur) / 8;
                iSpeed = iSpeed > 0 ? Math.ceil(iSpeed) : Math.floor(iSpeed);
                //3.检测停止
                if (iCur != json[attr]) {
                    bStop = false;
                }
                var iwidth = iCur + iSpeed;
                obj.style[attr] = iwidth + 'px';
                if (iwidth >= 44) {
                    iss.eq(0).removeClass('hide');
                }
                if (iwidth >= 98) {
                    iss.eq(1).removeClass('hide');
                }
                if (iwidth >= 155) {
                    iss.eq(2).removeClass('hide');
                }
                if (iwidth >= 210) {
                    iss.eq(3).removeClass('hide');
                }
            }
            if (bStop) {
                clearInterval(obj.timer);
                if (fn) {
                    fn();
                }
            }
        }, 30)
    },
    //请求宝箱回调
    getHotBoxCallBack: function(obj) {
        //obj = "{\"type\":0,\"op_type\":17,\"roomID\":1,\"data\":[{\"index\":0,\"require\":30000,\"status\":1},{\"index\":1,\"require\":60000,\"status\":1},{\"index\":2,\"require\":150000,\"status\":1},{\"index\":3,\"require\":400000,\"status\":0},{\"index\":7,\"require\":30000,\"status\":1},{\"index\":8,\"require\":60000,\"status\":1},{\"index\":9,\"require\":150000,\"status\":1},{\"index\":10,\"require\":400000,\"status\":1}],\"res\":0}";
        obj = MGC_Comm.strToJson(obj);
        //控制进度条的长度
        var _width = 0;
        var _iHtml = '';
        var _iHtmlCover = '';
        var _currentHot = _need = _thisAll = 0;
        var _tmpOverK = 4;
        //每个间隔的长度
        var _widthObj = {
            0: 44,
            1: 56,
            2: 55,
            3: 55
        };
        var _widthObjSmall = {
            0: 32,
            1: 88,
            2: 143,
            3: 198
        };
        var _iconLeft = {
            0: 30,
            1: 86,
            2: 141,
            3: 196
        };
        console.log("getHotBoxCallBack l obj.data.length = " + obj.data.length);
        // 添加补刀王数据consts.lastKingNeedData
        // clearInterval(mgc.consts.lastKingTimer);
        if (obj.res == 0 || obj.res == 1 || obj.res == 2 || obj.res == 3) {
            if (obj.roomID == MGCData.roomID) {
                $m.each(obj.data, function(k, v) {
                    if (k < 4) {
                        //前4个是房间热度
                        if (v.status == 0) {
                            //不能打开，要看下需要的热度
                            _need = MGCData.curHeight - _currentHot;
                            _need = _need < 0 ? 0 : _need;
                            _thisAll = v.require - _currentHot;
                            var _realNeed = v.require - MGCData.curHeight;
                            /**
                            *   判断是否是补刀王 start，替换数据
                            */
                            if(_realNeed <= mgc.consts.lastKingNeedData[k]){// && !mgc.consts.isRongruTime
                                mgc.lastKingModel.set("lastKingBoxIndex", (k));
                                mgc.lastKingModel.set("isShow",!(mgc.lastKingModel.get("isShow")));
                            }else{
                                clearInterval(mgc.consts.lastKingTimer);
                            }
                            /**
                             * end
                             */
                            _tmpOverK = k;
                            return false;
                        } else if (v.status == 1) {
                            //可以打开 
                            _currentHot = v.require;
                            clearInterval(mgc.consts.lastKingTimer);
                            _iHtmlCover += '<i class="p_icon_1" style="left:' + _iconLeft[k] + 'px"></i>';
                            _iHtml += '<i class="p_icon_2 " style="left:' + _iconLeft[k] + 'px" rel="'+k+'"></i>';
                        } else {
                            //已经打开过了
                            _currentHot = v.require;
                            _iHtmlCover += '<i class="p_icon_1" style="left:' + _iconLeft[k] + 'px"></i>';
                        }
                    } else { return false; }
                });
            }
        } else if (obj.res == 3) {
            //宝箱重置
        }
        for (var i = 0; i <= _tmpOverK; i++) {
            if (i < _tmpOverK) {
                _width += (_widthObj[i] + 0);

            } else if (_thisAll > 0) {
                _width += parseInt(_need / _thisAll * _widthObj[i]);
            }
            if (_width >= _widthObjSmall[i]) {
                _iHtmlCover += '<i class="p_icon_1 " style="left:' + _iconLeft[i] + 'px"></i>';
            }
        }
        _width = _width > 209 ? 209 : _width;
        var _boxInfo = {};
        _boxInfo.width = heatCchestWidth;
        _boxInfo.iHtmlCover = _iHtmlCover;
        _boxInfo.iHtml = _iHtml;
        console.log1("getHotBoxCallBack width = l " + _width + "," + heatCchestWidth);
        // var boxHotTmpl = $m('#boxHotTmpl');
        var boxHotCon = $m('#boxHotTmpl');
        var boxHotTmpl;
        var boxHotContainer = $m('#boxHotContainer');
        boxHotContainer.children().remove();
        boxHotTmpl = boxHotCon.tmpl(_boxInfo);
        boxHotTmpl.appendTo(boxHotContainer);
        // boxHotTmpl.tmpl(_boxInfo).appendTo(boxHotContainer);
        $m(".showSpanCover .p_icon_2").unbind("click").bind("click", function() {
            MGC_LIVEROOM_BIND.getBoxGift($m(this).attr("rel"));
        });
        if (heatCchestWidth != _width) {
            if (_width == 0) {
                $m('.showSpanCover,.bgSpan,.showSpan').stop().animate({
                    width: _width
                }, 2000, function() {
                });
            } else {
                MGC_SpecialResponse.startMove($m('.showSpanCover').get(0), { width: _width }, null);
                MGC_SpecialResponse.startMove($m('.bgSpan').get(0), { width: _width }, null);
                MGC_SpecialResponse.startMove($m('.showSpan').get(0), { width: _width }, null);
                MGC_SpecialResponse.startMove($m('.spanCover').get(0), { width: _width }, null);
                MGC_SpecialResponse.startMove($m('.showSpan2').get(0), { width: _width }, null);
            }
            heatCchestWidth = _width;
        }
        obj = null;
        _iHtmlCover = null;
        _iHtml = null;
        boxHotTmpl = null;
        boxHotCon = null;
        boxHotContainer = null;
    },

    foramtTaskRewards: function(obj) { //根据type 获取tips
        var array = obj.task == undefined ? obj.rewardlist : obj.task.rewards;
        var l = array.length; var n = 1;
        if (l > 0) {
            $m.each(array, function(k, v) {
                v.num = n;
                var url = v.channel == 0 ? v.url : v.channel == 3 ? v.url : v.channel == 4 ? v.url : v.channel == 2 ? ("http://ossweb-img.qq.com/images/mgc/css_img" + v.url + "?v=3_8_8_2016_15_4_final_3") : ("http://ossweb-img.qq.com/images/mgc/css_img" + v.url + "?v=3_8_8_2016_15_4_final_3");
                v.url = url;
                v.Qgame = false;
                if (v.channel == 3) {
                    if (v.url == '') {
                        v.url = "http://ossweb-img.qq.com/images/mgc/css_img/common/game_default.png?v=3_8_8_2016_15_4_final_3";
                    }
                    Qgame = true;
                    v.Qgame = true;
                }
                n++;
            });
            n = 1;
        }
    },
    //请求主播任务回调
    getTaskInfoCallBack: function(obj) {
        var obj = MGC_Comm.strToJson(obj);
        console.log("获取的主播任务信息：" + obj);

        //条件
        var _stat = obj.task.stat;
        if (_stat == 0) {
            showDialog.show('pop12');
            return;
        } else if (_stat == 1) {
            $m('#TaskBtn').attr("href", "javascript:MGC_CommRequest.AcceptTask();").html("接受任务");
        } else if (_stat == 2) {
            $m('#TaskBtn').attr("href", "javascript:PreGiveUpTask();").html("放弃任务");
        } else if (_stat == 3) {

        }
        //$m.each(obj.task.rewards, function(k, v) {
        //    v.Qgame = v.channel == 3 ? true : false;
        //    if (v.Qgame == true) {
        //        Qgame = true;
        //    }
        //})
        if (MgcAPI.SNSBrowser.IsQQGame()) {
            Qgame = true;
        }
        if (Qgame) {
            $m("#pop10 .adv_guard_ratio").children().remove();
            $m("#pop10 .adv_guard_ratio").html("如获得游戏道具，会自动放入您的QQ游戏大厅背包中");
            $m("#pop10 .adv_guard_ratio").show();
        } else if ((Qgame == false) && (obj.adv_guard_ratio > 1)) {//是否显示高级守护加成提示
            $m("#pop10 .adv_guard_ratio span").html(obj.adv_guard_ratio);
            $m("#pop10 .adv_guard_ratio").show();
        } else {                
            $m("#pop10 .adv_guard_ratio").hide();
        }

        var TaskDescription = {};
        TaskDescription.TaskDescriptionStr = obj.task.description;
        var TaskDescriptionCon = $m('#TaskDescriptionTmpl');
        var TaskDescriptionTmpl;
        // var TaskDescriptionTmpl = $m('#TaskDescriptionTmpl');
        var TaskDescriptionContainer = $m('#TaskDescriptionContainer');
        TaskDescriptionContainer.children().remove();
        TaskDescriptionTmpl = TaskDescriptionCon.tmpl(TaskDescription);
        TaskDescriptionTmpl.appendTo(TaskDescriptionContainer);
        // TaskDescriptionTmpl.tmpl(TaskDescription).appendTo(TaskDescriptionContainer);

        var TaskRewardsArr = obj.task.rewards;
        $m.each(obj.task.rewards, function(k, v) {
            v.anchor_level = MGCData.anchor_level;
            v.buff_percent = obj.buff_percent;
        });

        var TaskRewardsCon= $m('#TaskRewardsTmpl');
        var TaskRewardsTmpl;
        // var TaskRewardsTmpl = $m('#TaskRewardsTmpl');
        var TaskRewardsContainer = $m('#TaskRewardsContainer');
        TaskRewardsContainer.children().remove();

        this.foramtTaskRewards(obj);

        TaskRewardsTmpl = TaskRewardsCon.tmpl(TaskRewardsArr);
        TaskRewardsTmpl.appendTo(TaskRewardsContainer);
        // TaskRewardsTmpl.tmpl(TaskRewardsArr).appendTo(TaskRewardsContainer);
        TaskRewardsContainer.find("li").find('span').off("mouseover,mouseout").on("mouseover", function(){
            MGC.suswTips2(event,1,$(this).attr("mgc_name"),$(this).attr("mgc_tips"));       
        }).on("mouseout", function(){
            MGC.suswTips2(event,0);
        });
        
        TaskRewardsContainer.find("li").find('i').off("mouseover,mouseout").on("mouseover", function(){
            MGC.suswTips5(event,1,$(this).attr("mgc_tips"),'');        
        }).on("mouseout", function(){
            MGC.suswTips5(event,0);
        });
        MGC.flipOver("#pop10");
        if ($m("#pop10").css("display") != "block") {
            showDialog.show('pop10');
        }
        TaskDescriptionTmpl = null;
        TaskDescriptionCon = null;
        TaskRewardsTmpl = null;
        TaskRewardsCon = null;
    },

    //接受主播任务
    AcceptTaskCallBack: function(obj) {
        var obj = MGC_Comm.strToJson(obj);
        console.log("接受主播任务信息：" + obj);

        if (obj.res == 0) {
            $m('#TaskBtn').attr("href", "javascript:PreGiveUpTask();").html("放弃任务");
            $m('#newTask').hide();
            /*alert("已成功接受主播任务");*/
            showDialog.hide()
        } else if (obj.res == 1) {
            alert("您已接受了主播任务");
        } else if (obj.res == 2) {
            alert("当前没有发布主播任务");
        } else if (obj.res == 3) {
            alert("操作失败");
        };
    },

    //放弃主播任务
    GiveUpTaskCallBack: function(obj) {
        var obj = MGC_Comm.strToJson(obj);
        console.log("放弃主播任务信息：" + obj);

        if (obj.res == 0) {
            MGC_CommRequest.getTaskInfo();
            //$m('#TaskBtn').attr("href", "javascript:MGC_CommRequest.AcceptTask();").html("接受任务");
            alert("您已经放弃该主播任务，如需完成，请在房间中重新领取");
        } else if (obj.res == 1) {
            alert("当前的主播任务不存在");
        };
    },

    //发布任务通知
    PublishTask: function(obj) {
        MGC_Comm.log("发布主播任务信息：", obj);

        if (obj.is_show == true) {
            $m('#newTask').show();
        } else {
            $m('#newTask').hide();
        }
    },

    //取消任务
    CancelTask: function(obj) {
        MGC_Comm.log("取消主播任务信息：", obj);
        $m('#anchorTask').attr("href", "javascript:MGC_CommRequest.getTaskInfo();");
        $m('#newTask').hide();
    },

    //完成主播任务
    CompleteTask: function(obj) {
        MGC_Comm.log("主播任务完成：" + obj);

        $m.each(obj.rewardlist, function(k, v) {
            v.Qgame = v.channel == 3 ? true : false;
            if (v.Qgame == true) {
                Qgame = true;
            }
        })
        if (MgcAPI.SNSBrowser.IsQQGame()) {
            Qgame = true;
        }
        
        if (Qgame) {
            $m("#pop11 .adv_guard_ratio").children().remove();
            if(obj.is_reissue){            
                $m("#pop11 .adv_guard_ratio").html("很遗憾，本期主播任务奖励已经发完，您获得了安慰奖励：");
            }else{                
                $m("#pop11 .adv_guard_ratio").html("你完成了主播发布的任务，你获得了如下奖励：（如获得游戏道具，会自动放入您的QQ游戏大厅背包中）");
            }            
        } else{
            if (obj.adv_guard_ratio > 1) {
                //显示高级守护加成提示
                $m("#pop11 .adv_guard_ratio span").html(obj.adv_guard_ratio);
                $m("#pop11 .adv_guard_ratio").show();
            }
        }

        if (obj.hasgame == true) {
            if(window.mgc.config.channel == 0){
                $m('#gameTool').text('（获得的游戏道具会直接进入游戏背包）');
            }else{
                $m('#gameTool').text('（获得的游戏道具以邮件发放到电脑端）');
            }
        } else if (Qgame) {
            $m('#gameTool').text('');
        } else {
            $m('#gameTool').text('：');
        }
        var TaskRewardList = obj.rewardlist;
        $m.each(obj.rewardlist, function(k, v) {
            v.anchor_level = MGCData.anchor_level;
            v.buff_percent = obj.buff_percent;
        })
        var TaskRewardsCom = $m('#TaskRewardsTmpl');
        var TaskRewardsTmpl;
        // var TaskRewardsTmpl = $m('#TaskRewardsTmpl');
        var CompleteTaskRewardContainer = $m('#CompleteTaskRewardContainer');
        CompleteTaskRewardContainer.children().remove();
        this.foramtTaskRewards(obj);
        TaskRewardsTmpl = TaskRewardsCom.tmpl(TaskRewardList);
        TaskRewardsTmpl.appendTo(CompleteTaskRewardContainer);
        // TaskRewardsTmpl.tmpl(TaskRewardList).appendTo(CompleteTaskRewardContainer);
        CompleteTaskRewardContainer.find("li").find('span').off("mouseover,mouseout").on("mouseover", function(){
            MGC.suswTips2(event,1,$(this).attr("mgc_name"),$(this).attr("mgc_tips"));       
        }).on("mouseout", function(){
            MGC.suswTips2(event,0);
        });
        
        CompleteTaskRewardContainer.find("li").find('i').off("mouseover,mouseout").on("mouseover", function(){
            MGC.suswTips5(event,1,$(this).attr("mgc_tips"),'');        
        }).on("mouseout", function(){
            MGC.suswTips5(event,0);
        });
        MGC.flipOver("#pop11");
        showDialog.show('pop11');
        TaskRewardsTmpl = null;
        TaskRewardsCom = null;
    },
    //完成在线好礼任务
    CompleteOnlineTask: function(obj) {
        if (!MGC_SpecialResponse.popId) {
            MGC_CommResponse.popOnline(obj);
            MGC_SpecialResponse.popId = true;
        } else {
            MGC_CommResponse.cunChu(obj);
        }

    },

    onlineFun: function() {
        showDialog.hide();
        window.mgc.popmanager.layerControlHide($m('#pop19'), 5, 1);
        MGC_CommRequest.setTaskInfo(MGC_CommResponse.activityId, MGC_CommResponse.activity_daily);
        return;
    },
    //弹出在线好礼方法
    popOnline: function(obj) {
        MGC_CommResponse.activityId = obj.activity.id;
        MGC_CommResponse.activity_daily = obj.is_daily;
        MGC_Comm.log("在线好礼任务完成：" + obj);
        var array = obj.activity.rewards;
        var l = array.length; var n = 1;
        if (l > 0) {
            $m.each(array, function(k, v) {
                var url = v.channel == 0 ? v.url : v.channel == 3 ? v.url : v.channel == 4 ? v.url : v.channel == 2 ? ("http://ossweb-img.qq.com/images/mgc/css_img" + v.url + "?v=3_8_8_2016_15_4_final_3") : ("http://ossweb-img.qq.com/images/mgc/css_img" + v.url + "?v=3_8_8_2016_15_4_final_3");
                v.url = url;
                v.Qgame = false;
                if (v.channel == 3) {
                    if (v.url == '') {
                        v.url = "http://ossweb-img.qq.com/images/mgc/css_img/common/game_default.png?v=3_8_8_2016_15_4_final_3";
                    }
                    Qgame = true;
                    v.Qgame = true;
                }
                v.anchor_level = MGCData.anchor_level;
                v.buff_percent = obj.buff_percent;
            });
            n = 0;
        }
        if (MgcAPI.SNSBrowser.IsQQGame()) {
            Qgame = true;
        }
        var OnlineTaskRewardsCom = $m('#OnlineTaskRewardsTmpl');
        var OnlineTaskRewardsTmpl;
        // var OnlineTaskRewardsTmpl = $m('#OnlineTaskRewardsTmpl');
        var CompleteOnlineTaskRewardContainer = $m('#CompleteOnlineTaskRewardContainer');
        CompleteOnlineTaskRewardContainer.children().remove();
        OnlineTaskRewardsTmpl = OnlineTaskRewardsCom.tmpl(array);
        OnlineTaskRewardsTmpl.appendTo(CompleteOnlineTaskRewardContainer);
        // OnlineTaskRewardsTmpl.tmpl(array).appendTo(CompleteOnlineTaskRewardContainer);
        CompleteOnlineTaskRewardContainer.find("li").find('span').off("mouseover,mouseout").on("mouseover", function(){
            MGC.suswTips2(event,1,$(this).attr("mgc_name"),$(this).attr("mgc_tips"));       
        }).on("mouseout", function(){
            MGC.suswTips2(event,0);
        });
        $m('#onlineTitle').text(obj.activity.name);
        $m('#pop19').find(".pop_close").attr("href", "javascript:showDialog.hide();MGC_SpecialResponse.popId=false;MGC_SpecialResponse.chechNumShow();");
        //showDialog.show('pop19');
        window.mgc.popmanager.layerControlShow($m('#pop19'), 5, 1);
        $m('#pop19').find(".pop_close").off('click').on('click', function() {
            window.mgc.popmanager.layerControlHide($m('#pop19'), 5, 1);
        });
        if (obj.hasgame == true) {
            if(window.mgc.config.channel == 0){
                $m('#gameTips').text('（获得的游戏道具会直接进入游戏背包）');
            }else{
                $m('#gameTips').text('（获得的游戏道具以邮件发放到电脑端）');
            }
        } else {
            $m('#gameTips').text('：');
        }
        OnlineTaskRewardsTmpl = null;
        OnlineTaskRewardsCom = null;
    },
    //在线有礼-存储没有弹出的数据
    cunChu: function(obj) {
        activityArray.push(obj);
    },
    //在线有礼-检查是否有未弹出的弹窗
    chechNumShow: function() {
        if (MGC_SpecialResponse.popId == false) {
            if (activityArray.length > 0) {
                var array = activityArray.shift();
                MGC_CommResponse.popOnline(array);
                MGC_SpecialResponse.popId = true;
            }

        }
    },
    getFansCardInfoCallBack: function(obj) {
        console.log("获取的粉丝名片信息：" + obj);
        obj = MGC_Comm.strToJson(obj);
        var _playerInfo = {};
        if (obj.result == 0) { //test
            //观众
            //头像
            _playerInfo._portrait_url = obj.card_info.portrait_url;
            //性别
            var _sexId = obj.card_info.player_sex;
            //大区
            var _zoneId = obj.card_info.zone_id;
            if (_zoneId == MGCData.mgcZoneId) {
                //_playerInfo._showAreaName = '梦工厂';
                _playerInfo._showAreaName = obj.card_info.zone_name;
            } else {
                _playerInfo._showAreaName = '炫舞-' + obj.card_info.zone_name;
            }
            //玩家昵称
            _playerInfo._nickName = obj.card_info.player_name;
            //贵族
            _playerInfo._vip_name = vipLevelTab[obj.card_info.vip_level];
            var tempVipI = parseInt(obj.card_info.vip_level + 1);
            _playerInfo._vipClass = 'pop_card' + tempVipI;
            _playerInfo._videoLevel = obj.card_info.videoLevel;
            //需要判断在不在线-todo
            //他人名片弹出框--男女
            _playerInfo._sexCardInfo = _sexId == 0 ? "pop_woman" : "pop_man";
            //他人名片弹出框--等级todo
            //他人名片弹出框--财富值
            _playerInfo.wealth = obj.card_info.wealth;
            //他人名片弹出框--签名
            _playerInfo.signature = obj.card_info.signature;
            //关注的主播信息
            _playerInfo.followed_anchors = obj.card_info.followed_anchors;
            //弹出他人名片框
            MGC_LIVEROOM_BIND.popPlayerDetailCard(_playerInfo);
        } else {
            alert('很抱歉，请求数据失败，请重试。');
            return false;
        }
    },

    //个人名片回调
    getPlayerInfoCallBack: function(obj) {
        console.log("获取的个人名片信息111：" + obj);
        obj = MGC_Comm.strToJson(obj);
        var _playerInfo = {};
        if (!obj.mem_info.Online) {
            showCloseTips(mgc.common_contral.mgc_comm.eventInfo, '该用户已不在房间中');
            return false;
        }
        _playerInfo.guardlevelClass = _playerInfo.guardlevelShow = _playerInfo.viplevelClass = _playerInfo.viplevelShow = '';
        _playerInfo.playerType = obj.mem_info.playerType;
        _playerInfo.isSelf = obj.mem_info.isSelf;
        _playerInfo.wealth_level = obj.mem_info.wealth_level;
        _playerInfo.isMobileManager = false;
        _playerInfo._targetId = obj.mem_info.psid;
        if (obj.mem_info.playerType != 2) {
            //暂时无法区分管理员和主播todo
            //头像 -- 要区分主播和管理员，不一样
            //房间管理员：所有房间管理员都显示同一张默认的新增头像资源
            _playerInfo._portrait_url = obj.mem_info.portrait_url;
            //性别
            var _sexId = obj.mem_info.m_sex_male;
            _playerInfo._sexFemale = _sexId ? "" : "female";

            if (_playerInfo._portrait_url == '') {
                if (_sexId) {
                    _playerInfo._portrait_url = HeadImgPath + "default_male.png?v=3_8_8_2016_15_4_final_3";
                } else {
                    _playerInfo._portrait_url = HeadImgPath + "default_female.png?v=3_8_8_2016_15_4_final_3";
                }
            }

            //昵称
            _playerInfo._nickName = obj.mem_info.player_name;
            //大区--不显示
            _playerInfo._showAreaName = '';
            //传给私聊的大区
            var _zoneId = obj.mem_info.zoneid;
            if (_zoneId == MGCData.mgcZoneId) {
                //_playerInfo._talkAreaName = '梦工厂';
                _playerInfo._talkAreaName = obj.mem_info.zone_name;
            } else {
                _playerInfo._talkAreaName = obj.mem_info.zone_name;
            }
            //贵族--不显示

            //id
            _playerInfo.anchorId = obj.mem_info.anchorId;

            _playerInfo._vip_level = '';
            //名片--管理员不显示、主播显示todo
            if (obj.mem_info.playerType == 1) {

            } else {
                _playerInfo._cardClass = 'icon_card';
            }
            //下拉信息
            _playerInfo.card_list_info = '';
            _playerInfo._guard_level = 0;
            if (obj.mem_info.isSelf) {
                //查看自己
            } else {
                _playerInfo.card_list_info += '<ul class="list_btn">';
                _playerInfo.card_list_info += '<li><a class="privitechat"  receiverId="'+_playerInfo._targetId+'" receiverName="' + _playerInfo._nickName + '" receiverZoneName="' + _playerInfo._talkAreaName + '" receiverPlayerType="' + obj.mem_info.playerType + '" href="javascript:;">私 聊</a></li>';
                _playerInfo.card_list_info += '</ul>';
            }
        } else {
            //观众
            //头像
            _playerInfo._portrait_url = obj.mem_info.portrait_url;
            //性别
            var _sexId = obj.mem_info.m_sex_male;
            _playerInfo._sexFemale = _sexId ? "" : "female";

            if (_playerInfo._portrait_url == '') {
                if (_sexId) {
                    _playerInfo._portrait_url = HeadImgPath + "default_male.png?v=3_8_8_2016_15_4_final_3";
                } else {
                    _playerInfo._portrait_url = HeadImgPath + "default_female.png?v=3_8_8_2016_15_4_final_3";
                }
            }
            //大区
            var _zoneId = obj.mem_info.zoneid;
            if (_zoneId == MGCData.mgcZoneId) {
                //_playerInfo._showAreaName = '梦工厂';
                //_playerInfo._talkAreaName = '梦工厂';
                _playerInfo._showAreaName = obj.mem_info.zone_name;
                _playerInfo._talkAreaName = obj.mem_info.zone_name;
            } else {
                _playerInfo._showAreaName = '炫舞-' + obj.mem_info.zone_name;
                _playerInfo._talkAreaName = obj.mem_info.zone_name;
            }
            //玩家昵称
            _playerInfo._nickName = obj.mem_info.player_name;

            //贵族
            _playerInfo._vip_level = obj.mem_info.vip_level;
            _playerInfo._nickColor = "#111111";
            switch (_playerInfo._vip_level) {
                case 0:
                    _playerInfo._nickColor = "#111111"; //非贵族
                    break;
                case 1:
                    _playerInfo._nickColor = "#1a6b00"; //近卫
                    break;
                case 2:
                    _playerInfo._nickColor = "#006772"; //骑士
                    break;
                case 3:
                    _playerInfo._nickColor = "#0a57af"; //将军
                    break;
                case 4:
                    _playerInfo._nickColor = "#8f00b1"; //亲王
                    break;
                case 5:
                    _playerInfo._nickColor = "#ae5600"; //皇帝
                    break;
                default:
                    break;
            }
            //守护
            _playerInfo._guard_level = obj.mem_info.guardlevel;
            if (_playerInfo._guard_level > 0) {
                _playerInfo.guardlevelClass = "icon_lv icon_lv" + _playerInfo._guard_level;
                _playerInfo.guardlevelShow = guardLevelTab[_playerInfo._guard_level];
            }
            if (_playerInfo._vip_level > 0) {
                _playerInfo.viplevelClass = "icon_honor icon_honor" + _playerInfo._vip_level;
                _playerInfo.viplevelShow = vipLevelTab[_playerInfo._vip_level];
            }
            if (_playerInfo.wealth_level > 0) {
                _playerInfo.wealthlevelClass = "wealth_level_" + _playerInfo.wealth_level;
            }
            //名片
            _playerInfo._cardClass = 'icon_card';
            //下拉信息--要分各种情况todo
            _playerInfo.card_list_info = '';
            if (obj.mem_info.isSelf) {
                //查看自己
            } else {
                _playerInfo.canInvite = canInvite;
                _playerInfo.isIgnore = obj.mem_info.isIgnore
                _playerInfo.player_name = obj.mem_info.player_name;
                _playerInfo.zone_name = obj.mem_info.zone_name;
                _playerInfo.banable = obj.mem_info.banable;
                _playerInfo.unbanable = obj.mem_info.unbanable;
            }
        }
        var cardTipCon = $m('#cardTipTmpl');
        var cardTipTmpl;
        // var cardTipTmpl = $m('#cardTipTmpl');
        var cardTipContainer = $m('#cardTipContainer');
        cardTipContainer.children().remove();
        try {
            cardTipTmpl = cardTipCon.tmpl(_playerInfo);
            cardTipTmpl.appendTo(cardTipContainer);
            // cardTipTmpl.tmpl(_playerInfo).appendTo(cardTipContainer);
        }
        catch (e) {
            console.log(e);
        }
        //兼容不容版本的jquery版本
        cardTipContainer.find(".privitechat").unbind("click").bind("click", function() {
            $chat.PreSendMsgChat(1, this, true);
        });
        //如果有名片、绑定名片事件
        if (_playerInfo._cardClass == 'icon_card') {
            if (obj.mem_info.playerType == 0) { //主播
                $m('.icon_card').off('click').on('click', function() {
                    window.mgc.popmanager.layerControlHide($m(".card_tips"), 1, 2);
                    MGC_CommRequest.getAnchorCard($m(this).attr('anchorId'), card_source);
                });
            } else { //玩家
                $m('.icon_card').off('click').on('click', function() {
                    //需要判断在不在线-已经在点击阶段实现
                    window.mgc.popmanager.layerControlHide($m(".card_tips"), 1, 2);
                    //查询名片信息
                    MGC_cardRequest.getListCardInfo(_playerInfo._targetId,card_source);
                });
            }
        }
        //增加禁言和取消禁言的操作
        $m('.forbidden').on('click', function() {
            var _name = $m.trim($m("#cardTipContainer .name_info .ni_nick").html()) || "";//解决转义字符
            var _area = $m(this).attr('area');
            var _playerId = $m(this).attr('playerId');
            MGC_CommRequest.forbidden(_playerId,_name, _area, true, false);
        });

        $m('.cancelForbidden').on('click', function() {
            var _name = $m.trim($m("#cardTipContainer .name_info .ni_nick").html()) || "";//解决转义字符
            var _area = $m(this).attr('area');
            var _playerId = $m(this).attr('playerId');
            MGC_CommRequest.forbidden(_playerId,_name, _area, false, false);
        });
        //屏蔽和取消屏蔽操作
        $m('.ignore').on('click', function() {
            var _name = $m.trim($m("#cardTipContainer .name_info .ni_nick").html()) || "";//解决转义字符
            var _area = $m(this).attr('area');
            var _playerId = $m(this).attr('playerId');
            var _isIgnore = $m(this).attr('isIgnore') == "true" ? true : false;
            MGC_CommRequest.ignore(_playerId,_name, _area, _isIgnore);
        });
        //弹出他人框
        MGC.cardTips(mgc.common_contral.mgc_comm.eventInfo, 's_con_card');
        cardTipTmpl = null;
        cardTipCon = null;
    },

    //获取自己的信息
    /*
	getOwnInfoCallBack: function(obj) {
		console.log("获取的自己名片信息：" + obj);
		obj = MGC_Comm.strToJson(obj);
		//我自己的贵族等级
		if (obj.card_info.vip_level) {
			MGCData.myVipLevel = obj.card_info.vip_level;
		}
		//我的playerId
		if (obj.card_info.player_id) {
			MGCData.myPlayerId = obj.card_info.player_id;
		}
	},*/

    //编辑印象返回
    editImpressionCallBack: function(obj) {
        console.log("编辑印象的返回" + obj);
        obj = MGC_Comm.strToJson(obj);
        if (obj.res == 0) {
            var msg = "恭喜您，成功添加主播印象";
        } else if (obj.res == 2) {
            var msg = "成为ta的守护或拥有贵族身份才能添加印象哦";
        } else if (obj.res == 3) {
            window.mgc.common_logic.CheckNameError(114);
        } else {
            var msg = "很抱歉，添加主播印象失败。";
        }
        showDialog.hide();
        alert(msg);
        //无需再显示主播名片
        //$m('#anchorCard').click();
    },

    //是否关注的主播
    isFollowAnchorCallBack: function(obj) {
        console.log('ddddddddddddddddddd' + obj);
        obj = MGC_Comm.strToJson(obj);
        if (obj.res) {
            MGCData.difFollowAnchor[MGCData.isAnchorOrRoom].followAnchor = 1;
            //关注了
            $m('.si_attention').text('已关注');
        } else {
            MGCData.difFollowAnchor[MGCData.isAnchorOrRoom].followAnchor = 0;
            //未关注
            $m('.si_attention').html('关注');
        }
    },
    isFull : false,
    //关注主播
    FollowAnchorActionCallBack: function(obj, anchor_id) {
        console.log("关注主播的返回" + obj);

        //给flash下发
        response_as(obj);

        obj = MGC_Comm.strToJson(obj);        
        var msg = "";
        switch (obj.res) {
           
			case 0:
                MGCData.difFollowAnchor[MGCData.isAnchorOrRoom].followAnchor = 1;
			    msg = '恭喜你，关注成功';			    
				break;
			case 1:
				msg = '土豪，您的关注达到上限啦~';
                MGCData.difFollowAnchor[MGCData.isAnchorOrRoom].followAnchor = 0;
                MGC_CommResponse.IsMaxFollow();
				break;
			case 2:
				msg = '关注主播失败，未找到该主播';
				break;
			case 3:
				msg = '关注主播失败，未知错误';
				break;
			case 4:
                MGCData.difFollowAnchor[MGCData.isAnchorOrRoom].followAnchor = 1;
				msg = '关注失败，该主播已经在您的关注列表中了。';
				break;
			case 5:
				msg = '操作频繁，请稍后再试。';
				break;
            case 9:
                msg = '土豪，您的关注达到上限啦~升级就能提高上限呢！';
                
                MGCData.difFollowAnchor[MGCData.isAnchorOrRoom].followAnchor = 0;
                MGC_CommResponse.NotMaxFollow();
                break;
		
            default: break;
        }
        if (obj.res == 0 || obj.res == 4) {
            MGC_LIVEROOM_BIND.refreshFollowInfo('add', anchor_id);
            /*var msg = "恭喜您，成功关注该主播";*/
        }
        if (msg != '') {
          //  alert(msg);
        }
    },

    //满级弹框
    IsMaxFollow: function(){
        var dialogStr = {};
        dialogStr.Title = '温馨提示';
        dialogStr.BtnName = '确定';
        dialogStr.BtnNum = 1;
        dialogStr.Note = '土豪，您的关注达到上限啦~';

        MGC_Comm.CommonDialog(dialogStr);
        $m('#CommonDialog').css("top", "310px");
        $m('#CommonDialog').find("#NoteP").css("textAlign", "left");
    },
    //未满级弹框
    NotMaxFollow: function(){
        var dialogStr = {};
        dialogStr.Title = '温馨提示';
        dialogStr.BtnName = '确定';
        dialogStr.BtnNum = 1;
        dialogStr.Note = '土豪，您的关注达到上限啦~升级就能提高上限呢！';

        MGC_Comm.CommonDialog(dialogStr);
        $m('#CommonDialog').css("top", "310px");
        $m('#CommonDialog').find("#NoteP").css("textAlign", "left");
    },

    //取消关注主播
    CancelFollowAnchorCallBack: function(obj, anchor_id) {
        console.log("取消关注主播的返回" + obj);

        //给flash下发
        response_as(obj);
        obj = MGC_Comm.strToJson(obj);        
        var msg = "";
        switch (obj.res) {
           /*
                case 0:
                    msg = '恭喜你，取消关注成功';                    
                    break;
                case 2:
                    msg = '取消关注主播失败，未找到该主播';
                    break;
            */
            default:
                //msg = '取消关注主播失败，未知错误。';
                break;
        }
        if (obj.res == 0) {
            MGCData.difFollowAnchor[MGCData.isAnchorOrRoom].followAnchor = 0;
            MGC_LIVEROOM_BIND.refreshFollowInfo('cancel', anchor_id);
        }
        if (msg != '') {
            alert(msg);
        }
    },

    //查询宝箱数据
    getBoxGiftCallBack: function(obj, isSurpriseTreasure) {
        console.log("获取宝箱数据：" + obj);
        obj = MGC_Comm.strToJson(obj);
        if (obj.reward) {
            $m.each(obj.reward, function(k, v) {
                var url = v.channel == 0 ? v.url : v.channel == 3 ? v.url : v.channel == 4 ? v.url : v.channel == 2 ? ("http://ossweb-img.qq.com/images/mgc/css_img" + v.url + "?v=3_8_8_2016_15_4_final_3") : ("http://ossweb-img.qq.com/images/mgc/css_img" + v.url + "?v=3_8_8_2016_15_4_final_3");
                v.url = url;
                v.Qgame = false;
                if (v.channel == 3) {
                    if (v.url == '') {
                        v.url = "http://ossweb-img.qq.com/images/mgc/css_img/common/game_default.png?v=3_8_8_2016_15_4_final_3";
                    }
                    Qgame = true;
                    v.Qgame = true;
                }
                v.anchor_level = MGCData.anchor_level;
                v.buff_percent = obj.buff_percent;
            });
            if (MgcAPI.SNSBrowser.IsQQGame()) {
                Qgame = true;
            }
            if (isSurpriseTreasure) {
                obj.showTips = "激活的惊喜宝箱打开后，你将获得如下奖励中的一个";
            } else if (Qgame == true) {
                obj.showTips = "若出现密令宝箱，快速响应能获得额外奖励哦";
                obj.showTips_game = "";
            } else {
                obj.showTips = "若出现密令宝箱，快速响应能获得额外奖励哦";
                if (obj.hasgame == true) {
                    if(window.mgc.config.channel == 0){
                        obj.showTips_game = "（获得的游戏道具会直接进入游戏背包）";
                    }else{
                        obj.showTips_game = "（获得的游戏道具以邮件发放到电脑端）";
                    }
                } else {
                    obj.showTips_game = "";
                }
            }
            var boxGiftCon = $m('#boxGiftTmpl');
            var boxGiftTmpl;
            // var boxGiftTmpl = $m('#boxGiftTmpl');
            var boxGiftContainer = $m('#boxGiftContainer');
            boxGiftContainer.children().remove();
            boxGiftTmpl = boxGiftCon.tmpl(obj);
            boxGiftTmpl.appendTo(boxGiftContainer);
            // boxGiftTmpl.tmpl(obj).appendTo(boxGiftContainer);
            MGC.flipOver("#boxGiftContainer");
            
            boxGiftContainer.find("span").off("mouseover,mouseout").on("mouseover", function(e){
                var giftName = $(this).attr("mgc_giftname");
                var giftTips = $(this).attr("mgc_gifttips");
                if (giftName) {
                    MGC.suswTips2(e, 1, giftName, giftTips);
                }    
            }).on("mouseout", function(){
                MGC.suswTips2(event, 0);
            });

            boxGiftContainer.find("i").off("mouseover,mouseout").on("mouseover", function(e){
                var giftBuff = $(this).attr("mgc_buff");
                if (giftBuff) {
                    MGC.suswTips5(e, 1, giftBuff, "");
                }    
            }).on("mouseout", function(){
                MGC.suswTips5(event, 0);
            }); 

            window.mgc.popmanager.layerControlShow($m('#boxGiftContainer'), 5, 1);
            $m('#boxGiftContainer').find(".btn_open,.pop_close").off('click').on('click', function () {
                window.mgc.popmanager.layerControlHide($m('#boxGiftContainer'), 5, 1);
            });
            boxGiftTmpl = null;
            boxGiftCon = null;
        }
    },

    //获得宝箱数据的提示
    getBoxGiftActionCallBack: function(obj) {
        if (MGC_Comm.CheckGuestStatus(true)) {
            console.log("屏蔽游客操作：获得宝箱数据动画");
            return false;//游客身份下，屏蔽此操作
        }
        console.log("获取宝箱数据Action：" + JSON.stringify(obj));
        obj = MGC_Comm.strToJson(obj);

        //宝箱开启提示
        if(obj.res == 0 || obj.res == 8)
        {
            mgc.openTipModel.set("boxid",obj.boxid);
        }

        if ((obj.online && obj.res == 0) || (obj.online && obj.res == 9) || (obj.online && obj.res == 11)) {
            var popInfo = {};
            //popInfo.showTips = "房间热度奖励";
            popInfo.reward = {};
            popInfo.reward.count_desc = obj.truelyReward[0].count_desc;
            popInfo.reward.name = obj.truelyReward[0].name;
            popInfo.reward.tips = obj.truelyReward[0].tips;
            popInfo.reward.url = obj.truelyReward[0].channel == 0 ? obj.truelyReward[0].url : obj.truelyReward[0].channel == 3 ? obj.truelyReward[0].url : obj.truelyReward[0].channel == 4 ? obj.truelyReward[0].url : obj.truelyReward[0].channel == 2 ? ("http://ossweb-img.qq.com/images/mgc/css_img" + obj.truelyReward[0].url + "?v=3_8_8_2016_15_4_final_3") : ("http://ossweb-img.qq.com/images/mgc/css_img" + obj.truelyReward[0].url + "?v=3_8_8_2016_15_4_final_3");

            if (obj.truelyReward[0].channel == 3) {
                if (obj.truelyReward[0].url == '') {
                    obj.truelyReward[0].url = "http://ossweb-img.qq.com/images/mgc/css_img/common/game_default.png?v=3_8_8_2016_15_4_final_3";
                }
                Qgame = true;
            }
            if (MgcAPI.SNSBrowser.IsQQGame()) {
                Qgame = true;
            }
            popInfo.reward.anchor_level = MGCData.anchor_level;
            if(popInfo.reward.name == "梦幻币" || popInfo.reward.name == "经验")
            {
                popInfo.reward.buff_percent = "(+" + obj.buff_percent + "%)";
            }
            else{
                popInfo.reward.buff_percent = "";
            }

            if(obj.res == 0 || obj.res == 11)
            {
                popInfo.showTips = "[热度奖励]";
            }
            else if(obj.res == 9)
            {
                popInfo.showTips = "[补发热度奖励]";
            }

            if (Qgame) {
                if (obj.is_reissue) {
                    popInfo.showTips = "本期热度宝箱奖励已发完，您获得安慰奖：";
                } else {
                    //popInfo.showTips = "获得房间热度奖励~（如获得游戏道具，会自动放入您的QQ游戏大厅背包中）";
                    //popInfo.showTips = "热度宝箱已开启！恭喜您获得：";
                }
                popInfo.showTips_game = "";
            } else {
                if (obj.hasgame) {
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
            if (obj.last_hit_player_name.length > 0) {
                if(obj.last_hit_player_invisible && obj.last_hit_player_id != MGCData.myPlayerId){
                    tipObj.lastHitPlayerName = "神秘土豪";
                } else{
                    tipObj.lastHitPlayerName = obj.last_hit_player_name[0];
                }
                tipObj.isLastking = true;
            } else {
                tipObj.isLastking = false;
            }
            //var rewardTip = "<span>" + popInfo.showTips + popInfo.reward.name + " x" + popInfo.reward.count_desc + popInfo.reward.buff_percent + popInfo.showTips_game + "</span>";
            mgc.rewardTipModel.addTip(tipObj);

            //获得遗失在房间里的热度宝箱奖励(主播下线未开的宝箱奖励)
        } else if ((!obj.online && obj.res == 0) || (!obj.online && obj.res == 9) || (!obj.online && obj.res == 11)) {

            console.log("获取宝箱数据Action处理后：" + JSON.stringify(obj));
            $m('.video_title').hide();
            var popInfo = {};
            //popInfo.lostReward = "这是你在房间遗失的奖励~请查收~";
            popInfo.showTips = "[补发热度奖励]";
            popInfo.showTips_game = "";
            popInfo.reward = obj.truelyReward;

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
                v.anchor_level = obj.anchor_level;
                //v.buff_percent = obj.buff_percent;
                if(v.name == "梦幻币" || v.name == "经验")
                {
                    v.buff_percent = "(+" + obj.buff_percent + "%)";
                }
                else{
                    v.buff_percent = "";
                }

                if (MgcAPI.SNSBrowser.IsQQGame()) {
                    Qgame = true;
                }
                indexNum = 1;
                if (Qgame) {
                    if (obj.is_reissue) {
                        //popInfo.showTips = "很遗憾，本期热度宝箱奖励已经发完，您获得了安慰奖励：";
                        //popInfo.showTips = "本期热度宝箱奖励已发完，您获得安慰奖：";
                    } else {
                        //popInfo.showTips = "获得房间热度奖励~（如获得游戏道具，会自动放入您的QQ游戏大厅背包中）";
                        //popInfo.showTips = "热度宝箱已开启！恭喜您获得：";
                    }
                    popInfo.showTips_game = "";
                } else {
                    if (obj.hasgame == true) {
                        if(window.mgc.config.channel == 0){
                            obj.showTips_game = "（获得的游戏道具会直接进入游戏背包）";
                        }else{
                            obj.showTips_game = "（获得的游戏道具以邮件发放到电脑端）";
                        }
                        //popInfo.showTips = "热度宝箱已开启！恭喜您获得：";
                    } else {
                        //popInfo.showTips_game = "：";
                        //popInfo.showTips = "热度宝箱已开启！恭喜您获得：";
                    }
                }

                //var rewardTip = "<span>" + popInfo.showTips + v.name + " x" + v.count_desc + v.buff_percent + popInfo.showTips_game + "</span>"
                var tipObj = {};
                tipObj.showTips = popInfo.showTips;
                tipObj.name = v.name;
                tipObj.count_desc = v.count_desc;
                tipObj.buff_percent = v.buff_percent;
                tipObj.showTips_game = popInfo.showTips_game;
                if (obj.last_hit_player_name.length > 0) {
                    if(obj.last_hit_player_invisible[k] && obj.last_hit_player_id[k] != MGCData.myPlayerId){
                        tipObj.lastHitPlayerName = "神秘土豪";
                    } else{
                        tipObj.lastHitPlayerName = obj.last_hit_player_name[k];
                    }
                    tipObj.isLastking = true;
                } else {
                    tipObj.isLastking = false;
                }
                mgc.rewardTipModel.addTip(tipObj);
            });

        } else if (obj.res == 8 && tmpBx == 0 && obj.online) {
            // tmpBx = 1;
            // //冷却--公用弹出框
            // MGC_Comm.CommonDialog({
            //     "Title": "提示",
            //     "Note": "您进入房间的时间太短，还没有融入房间的热度中。主播开启热度宝箱的奖励，将会在您融入房间的热度后再发放给您。"
            // });
        } else if (obj.res == 8 && tmpBx == 0 && !obj.online) {
            // tmpBx = 1;
            // //冷却--公用弹出框
            // MGC_Comm.CommonDialog({
            //     "Title": "提示",
            //     "Note": "您进入房间的时间太短，还没有融入房间的热度中。主播开启热度宝箱的奖励帮您存起来了，在您融入房间热度后再发放给您。"
            // });
        }
    },


    //获得惊喜宝箱数据
    getSurpriseTreasureCallBack: function(obj) {
        console.log("获取惊喜宝箱数据Action：" + JSON.stringify(obj));
        obj = MGC_Comm.strToJson(obj);
        $m.each(obj.reward, function(k, v) {
            var url = v.channel == 0 ? v.url : v.channel == 3 ? v.url : v.channel == 4 ? v.url : v.channel == 2 ? ("http://ossweb-img.qq.com/images/mgc/css_img" + v.url + "?v=3_8_8_2016_15_4_final_3") : ("http://ossweb-img.qq.com/images/mgc/css_img" + v.url + "?v=3_8_8_2016_15_4_final_3");
            v.url = url;
            v.Qgame = false;
            if (v.channel == 3) {
                if (v.url == '') {
                    v.url = "http://ossweb-img.qq.com/images/mgc/css_img/common/game_default.png?v=3_8_8_2016_15_4_final_3";
                }
                Qgame = true;
                v.Qgame = true;
            }
            v.anchor_level = MGCData.anchor_level;
            v.buff_percent = obj.buff_percent;
        });
        if (MgcAPI.SNSBrowser.IsQQGame()) {
            Qgame = true;
        }
        obj.showTips = "惊喜宝箱奖励";
        if (Qgame) {
            if (obj.is_reissue) {
                obj.showTips = "很遗憾，本期惊喜宝箱奖励已经发完，您获得了安慰奖励：";
            } else {
                obj.showTips = "惊喜宝箱奖励：（如获得游戏道具，会自动放入您的QQ游戏大厅背包中）";
            }
        } else {
            if (obj.hasgame) {
                if(window.mgc.config.channel == 0){
                    obj.showTips_game = "（获得的游戏道具会直接进入游戏背包）";
                }else{
                    obj.showTips_game = "（获得的游戏道具以邮件发放到电脑端）";
                }
            } else {
                obj.showTips_game = '：';
            }
        }
        var boxGiftCon = $m('#boxGiftTmpl');
        var boxGiftTmpl;
        // var boxGiftTmpl = $m('#boxGiftTmpl');
        var boxGiftContainer = $m('#boxGiftContainer');
        boxGiftContainer.children().remove();
        boxGiftTmpl = boxGiftCon.tmpl(obj);
        boxGiftTmpl.appendTo(boxGiftContainer);
        // boxGiftTmpl.tmpl(obj).appendTo(boxGiftContainer);
        MGC.flipOver("#boxGiftContainer");
        
        boxGiftContainer.find("span").off("mouseover,mouseout").on("mouseover", function(e){
            var giftName = $(this).attr("mgc_giftname");
            var giftTips = $(this).attr("mgc_gifttips");
            if (giftName) {
                MGC.suswTips2(e, 1, giftName, giftTips);
            }        
        }).on("mouseout", function(){
            MGC.suswTips2(event, 0);
        });
        
        boxGiftContainer.find("i").off("mouseover,mouseout").on("mouseover", function(e){
            var giftBuff = $(this).attr("mgc_buff");
            if (giftBuff) {
                MGC.suswTips5(e, 1, giftBuff, "");
            }        
        }).on("mouseout", function(){
            MGC.suswTips5(event, 0);
        });
        window.mgc.popmanager.layerControlShow($m('#boxGiftContainer'), 5, 1);
        $m('#boxGiftContainer').find("a").off('click').on('click', function() {
            window.mgc.popmanager.layerControlHide($m('#boxGiftContainer'), 5, 1);
        });

        boxGiftContainer.find("span").off("mouseover,mouseout").on("mouseover", function(e){
           var giftName = $(this).attr("mgc_giftname");
            var giftTips = $(this).attr("mgc_gifttips");
            if (giftName) {
                MGC.suswTips2(e, 1, giftName, giftTips);
            }         
        }).on("mouseout", function(){
            MGC.suswTips2(event, 0);
        });

        boxGiftContainer.find("i").off("mouseover,mouseout").on("mouseover", function(e){
            var giftBuff = $(this).attr("mgc_buff");
            if (giftBuff) {
                MGC.suswTips5(e, 1, giftBuff, "");
            }        
        }).on("mouseout", function(){
            MGC.suswTips5(event, 0);
        });
        boxGiftTmpl = null;
        boxGiftCon = null;
    },

    //禁言通知--对操作的反馈
    forbiddenCallBack: function(obj, type) {
        console.log("禁言结果通知信息：" + JSON.stringify(obj));
        obj = MGC_Comm.strToJson(obj);
        var msg = '';
        switch (obj.res) {
            case 0:
                if (type == true) {
                    msg = '禁言操作成功！';
                } else {
                    msg = '解除禁言操作成功！';
                }
                break;
            case 11:
                msg = '对不起，您没有权限。';
                break;
            case 19:
                msg = '玩家已经处于禁言状态，无法重复禁言。';
                break;
            case 39:
                msg = '对不起，由于对方守护等级不低于您，或者拥有防止您禁言的贵族权限，禁言失败';
                break;
            case 40:
                msg = '对不起，您只能为被您禁言的玩家解禁';
                break;
            case 41:
                msg = '操作失败';
                break;
            default:
                break;
        }
        if (msg != '') {
            MGC_Comm.CommonDialog({
                "Title": "提示",
                "Note": msg
            });
        }
    },

    //屏蔽操作的返回消息
    ignoreCallBack: function(obj) {
        console.log("屏蔽操作的信息：" + obj);
        obj = MGC_Comm.strToJson(obj);
        if (!obj.res) {
            //操作失败
            MGC_Comm.CommonDialog({
                "Title": "提示",
                "Note": "该玩家不在线，无法查看。"
            });
        }
    },

    //直播地址通知
    LiveVideoStart: function(obj) {
        LiveCDNUrl = JSON.stringify(obj);
        if (MGC_SWFINIT.LiveVideo) {
            video_response(LiveCDNUrl);
        };
    },
    //停止直播
    LiveVideoStop: function(obj) {
        LiveCDNUrl = JSON.stringify(obj);
        video_response(LiveCDNUrl);
    },

    allImpressionInfoCallBack: function(obj, anchorId) {
        $m.each(obj.impression, function(k, v) {
            MGC_ANCHORIMPRESSION[v.impressionID] = v.impressionName;
        });
        MGC_CommRequest.myImpressionInfo(anchorId);
    },

    //获取主播列表
    getZhuBoListCallBack: function(obj) {
        obj = MGC_Comm.strToJson(obj);
        var _zhuboList = obj.nest_info;
        $m.each(_zhuboList, function(k, v) {
            v.levelClass = Math.floor(v.anchor_level / 10) + 1;
            if (v.anchor_level == 0) {
                v.levelClass = 0;
            }
        });

        var zhuboListCon = $m('#zhuboListTmpl');
        var zhuboListTmpl;
        // var zhuboListTmpl = $m('#zhuboListTmpl');
        var zhuboListContainer = $m('#zhuboListContainer');
        zhuboListContainer.children().remove();
        zhuboListTmpl = zhuboListCon.tmpl(_zhuboList);
        zhuboListTmpl.appendTo(zhuboListContainer);
        // zhuboListTmpl.tmpl(_zhuboList).appendTo(zhuboListContainer);
        //重绘滚动条 
        var scrollAPI_qixiazhubolist = $m('#zhuboListWrapper').data('jsp');
        if(scrollAPI_qixiazhubolist){
            scrollAPI_qixiazhubolist.initScroll();
        }

        zhuboListTmpl = null;
        zhuboListCon = null;
    },

    //守护等级变化
    updataGuardLevel: function(obj) {
        obj = MGC_Comm.strToJson(obj);

        if (obj.newGuardLevel < 400 && obj.oldGuardLevel < 400) return;

        if (obj.newGuardLevel > obj.oldGuardLevel) {
            if (obj.isSelf) {
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.BtnName = '知道了';
                dialog.Note = "恭喜您成功升级为" + obj.anchorName + "的" + guardLevelTab[obj.newGuardLevel];
                dialog.BtnName = '知道了';
                MGC_Comm.CommonDialog(dialog);
            }

            //走马灯
            var o = {};
            o.op_type = 239;
            var vipIcon = "";
            if (obj.vipLevel > 0) {
                vipIcon = "#IMG?type=icon_honor&a=" + obj.vipLevel + "#";
            }
            obj.zoneName = (obj.zoneName == "梦工厂" ? obj.zoneName : "炫舞-" + obj.zoneName);
            o.MsgStr = "恭喜" + "#IMG?type=icon_lv&a=" + obj.newGuardLevel + "#" + obj.nickName + "" + vipIcon + "成功升级为[" + obj.anchorName + "]的" + guardLevelTab[obj.newGuardLevel];
            MGC.marqueeArr(o);
        }
        else {
            if (obj.isSelf) {
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.BtnNum = 2;
                dialog.BtnName = '知道了';
                dialog.BtnName2 = '如何升级';
                dialog.Note = "亲，您的上月亲密度未达到标准，现已降级为" + guardLevelTab[obj.newGuardLevel];
                MGC_Comm.CommonDialog(dialog);
                //避免弹窗中取消按钮显示错误
                $("#CancelBtn").css("display", "inline-block");
                $m('#CancelBtn').attr("target", "_blank");
                $m('#CancelBtn').attr("href", "http://x5.qq.com/act/a20140306mar/page04.htm#1");
            }
        }
    }


};

$m.extend(MGC_CommRequest, MGC_SpecialRequest);
$m.extend(MGC_CommResponse, MGC_SpecialResponse);


var MGC_Response = function(callback_obj) {
    var _op_type = callback_obj.op_type;
    switch (parseInt(_op_type)) {
        case 237:
            if (MGCData.roomStatus == 1) {
                //主动更新房间幻灯片
                MGCData.slideArr = callback_obj.urls;
                MGC_CommResponse.getRoomUrlCallBack(callback_obj);
            } else {

                MGCData.slideArr = callback_obj.urls;
            }
            break;
        case 74:
            if (callback_obj.result == 0) {
                //后援团初始化
                $chat.ChatInit(true);
                MGC_Comm.CommonDialog({ "Title": "提示", "Note": "您已加入后援团 " + callback_obj.vgname + "。" });
            }
            else if (callback_obj.result == 19) {
                MGC_Comm.CommonDialog({ "Title": "提示", "Note": "后援团已经达到人数上限，无法加入。" });
            }
            else if (callback_obj.result == 29) {
                MGC_Comm.CommonDialog({ "Title": "提示", "Note": "邀请超时。" });
            }
            break;
        case 205:
            canInvite = callback_obj.canInvite;
            //后援团初始化
            if (callback_obj.vgid != 0) {
                $chat.ChatInit(true);
            } else {
                $chat.ChatInit();
            }
            break;
        case 15:
            console.log("隔5分钟刷新数据：" + callback_obj);
            MGC_CommResponse.appendRoleList(callback_obj);
            break;
        case 30:
            MGC_CommResponse.refreshRoom(callback_obj);
            break;
        case 29:
            MGC_CommResponse.refreshAnchor(callback_obj);
            break;
        case 71:
            MGC_Comm.backupInvitationBoxPopUp(callback_obj);
            break;
        case 73:
            MGC_Comm.backupInvitationCallBack(callback_obj);
            break;
        case 33:
            MGC_CommResponse.refreshOnlineNums(callback_obj);
            break;
        case -100:
            $chat_response.initFinashedBoxCallback(callback_obj);
            break;
        case 224://查询惊喜宝箱奖励
            MGC_CommResponse.getBoxGiftCallBack(callback_obj, true);
            break;
        case 226://更新惊喜宝箱奖励
            $chat_response.updateSurpriseBoxCallback(callback_obj);
            break;
        case 227://获得惊喜宝箱奖励
            MGC_CommResponse.getSurpriseTreasureCallBack(callback_obj);
            break;
        case 256://刷新我对当前主播贡献的经验值已经当日上限
            MGC_CommResponse.giftAddexp(callback_obj);
            break;
        case 225://打开惊喜宝箱返回
            $chat_response.openBoxCallback(callback_obj);
            break;
        case 256://刷新我对当前主播贡献的经验值已经当日上限
            MGC_CommResponse.giftAddexp(callback_obj);
            break;
        case 28:
            if (callback_obj.fanstype == 0) {
                MGC_CommResponse.getFans(callback_obj); //超级粉丝
            } else if (callback_obj.fanstype == 1) {
                //守护
                MGC_CommResponse.getGuard(callback_obj);
            }
            break;
        case 34:
            //房间热度
            MGC_CommResponse.houseHot(callback_obj);
            break;
        case 36:
            FreeGift.responseGiftMessage(callback_obj);
            break;
        case 39:
            MGC_CommResponse.RevolvingDoor(callback_obj);
            break;
        case 40:
            MGC_CommResponse.RevolvingDoor(callback_obj);
            break;
        case 235:
            MGC_CommResponse.RevolvingDoor(callback_obj);
            break;
        case 310:
            MGC_CommResponse.topMeiliCallback(callback_obj);
            break;
        case 42:
            MGC_Comm.addEnterRoomEffect(callback_obj);
            break;
            //守护升级
        case 239:
            MGC_CommResponse.updataGuardLevel(callback_obj);
            break;
        case 52:
            MGC_CommResponse.LiveVideoStart(callback_obj);
            //隐藏未开播的推荐房间
            $m(".video_recommend_list").hide()
            break;
        case 53:
            MGC_CommResponse.LiveVideoStop(callback_obj);
            break;
        case 17:
            //获取宝箱数据
            MGC_CommResponse.getHotBoxCallBack(callback_obj);
            break;
        case OpType.GetTaskInfoOpType:
            //获取主播任务
            MGC_CommResponse.getTaskInfoCallBack(callback_obj);
            break;
        case 142:
            //获得了宝箱
            MGC_CommResponse.getBoxGiftActionCallBack(callback_obj);
            break;
        case 143:
            //完成主播任务
            MGC_CommResponse.CompleteTask(callback_obj);

            //更新梦幻币余额
            var tojson = {};
            tojson.op_type = "154";
            gift_send(tojson);
            break;
        case 199:
            //完成在线好礼任务
            MGC_CommResponse.CompleteOnlineTask(callback_obj);
            break;
        case 25:
            //获取VIP价格
            MGC_CommResponse.getVipPriceCallBack(callback_obj);
            break;
        case 115:
            //开通VIP
            MGC_CommResponse.StartVipCallBack(callback_obj);
            break;
        case 116:
            //续费VIP
            MGC_CommResponse.RenewalVipCallBack(callback_obj);
            break;
        case 121:
            MGC_CommResponse.PublishTask(callback_obj);
            break;
        case 125:
            MGC_CommResponse.CancelTask(callback_obj);
            break;
        case 131: //有新的投票
            console.log("发起投票：" + JSON.stringify(callback_obj));
            var _obj = MGC_Comm.strToJson(callback_obj);
            if (_obj.res == 0) {
                $m('#newVote').show();
            } else {
                MGC_CommRequest.getVoteInfo(true);
            }
            break;
        case 155: //主播开启宝箱啦，需要播放动画效果x
            MGC_Comm.log("主播开启宝箱通知JSON：" + JSON.stringify(callback_obj));
            $m.each(callback_obj, function(k, v) {

            });
            break;
        case 35: //通知房间的状态
            console.log("房间状态通知：" + JSON.stringify(callback_obj));
            MGCData.roomStatus = callback_obj.status;
            $chat_response.updateSurpriseBoxCallback(callback_obj);
            if (callback_obj.status == 2) {
                //直播啦
                //$m('.progress_time').show();
                //MGC.progressTime('progressTime', leftLiveRoomProTime);
                $m('#anchorTask').show();
                $m('.video_pic').hide();
                $m('.hiddenAnchor').show();
                //热度条
                $m('#boxHotContainer').find('*').show();

                isLiveOpen = true;

                //更新用户列表
                MGC_CommRequest.getRoleList();

                //礼物启用
                FreeGift.setEnabled(true);
                //隐藏幻灯片、未直播推荐
                $m("#video_pic").hide();
                //视频区广告停止轮播
                mgc.adVideoModel.stopChange();

                $m(".video_recommend_list").hide();
                //显示抽奖按钮
                clearInterval(mgc.swfInterval); 
                mgc.swfInterval = setInterval(function() {
                    if (MGC_SWFINIT.GiftSwf) {
                        $m("#draw_button").show();
                        if (!(mgc.account.checkGuestStatus(true))) {
                            if (mgc.tools.cookie("draw_prompt") != "draw_prompt") {
                                $('#draw_prompt').show();
                                $('#prompt_close').unbind('click').bind('click', function() {
                                    $('#draw_prompt').hide();
                                });
                                setTimeout("$('#draw_prompt').fadeOut();", 30000);
                                mgc.tools.cookie("draw_prompt", "draw_prompt", {
                                    expires: 365 * 24 * 60
                                });
                            }
                        }
                        var uid = mgc.account.getUin();
                        if (mgc.tools.cookie("draw_refresh_time" + uid) == "draw_refresh_time") {
                            $("#icon_new").show();
                            $("#icon_red").hide();
                        }
                        clearInterval(mgc.swfInterval);
                    }
                }, 1500);
            } else {
                //没有直播，不需要热度加速按钮
                $m('#addHotContainer').hide();
                //房间热度归0 
                MGCData.curHeight = 0;
                //热度条隐藏
                $m('#boxHotContainer').find('*').hide();
                //没有直播，不需要任务
                //$m('#anchorTask').hide();
                $m('.video_pic').show();
                //直播加上图片
                MGC_CommRequest.getRoomUrl();
                //未直播房间推荐
                //MGC_CommRequest.getSmallHotRecommRoom();
                SmallHotRoom.getHotRoom();
                //clearInterval(MGC.timer);
                //leftLiveRoomProTime = parseInt($m("#progressTime i").eq(0).text()) * 60 + parseInt($m("#progressTime i").eq(1).text());
                //$m('.progress_time').hide();
                //$m('.hiddenAnchor').hide();
                //$m('.sn_tips').html('');
                isLiveOpen = false;

                //更新用户列表
                MGC_CommRequest.getRoleList();

                //礼物禁用
                FreeGift.setEnabled(false);

                if (MGC_CommResponse.contRoom == 0) {
                    //房间内引导
                    MGC_CommResponse.roomGuide(180000, 240000);
                    MGC_CommResponse.contRoom++;
                }
                //隐藏抽奖按钮
                $m("#draw_button").hide();
            }
            //发送到新架构下
            mgc.network.recvMsg(callback_obj);
            break;
        case 13:
            console.log("退出返回：" + JSON.stringify(callback_obj));
            //如果是在游客状态下切换正常玩家时 此处为游客登出回调
            if (mgc.account.checkGuestStatus(true)) {
                //清除游客缓存
                mgc.account.delGuestCookie();
                //正常玩家登录回调
                $("#login-bar-btn").click();
            }
            break;
        case 173:
            MGC_Comm.log("关闭投票：" + JSON.stringify(callback_obj));
            MGC_CommResponse.CloseVote(callback_obj);
            break;        
        case 47:
            MGC_Comm.log("被踢出：" + JSON.stringify(callback_obj));
            //$m('.video_pic').find('img').attr('src', LiveRoomWatingImgPath);
            mgc.adVideoModel.setBg(LiveRoomWatingImgPath);
            $m('.video_pic').show();
            var msg = '';
            switch (callback_obj.reason) {
                case 0:
                    msg = '与视频服务器断开连接';
                    break;
                case 1:
                    msg = '很抱歉，您已被踢出房间。';
                    break;
                case 2:
                    msg = '房间被关闭了';
                    break;
                case 3:
                    msg = '您被踢出了房间';
                    break;
                case 4:
                    msg = '与视频服务器断开连接';
                    break;
                case 5:
                    msg = '您被踢出了房间';
                    break;
                case 6:
                    if (callback_obj.device_type !=  mgc.tools.pageSource().device_type) {
                        msg = '您的账号已在另一处进入视频房间，如果这不是您本人操作，那么您的密码可能已经泄漏，建议您修改密码';
                    }
                    break;
                case 8:
                    msg = '这个房间已经关闭了';
                    break;
                case 9:
                    msg = '这个房间已经被关闭了';
                    break;
                case 10:
                    msg = '当前视频房间已关闭，无法直播';
                    break;
                case 11:
                    msg = '您被踢出了房间';
                    break;
                case 13:
                    msg = '哎呦！房间暂时关闭了，休息一下再来试试吧！';
                    break;
                case 14:
                    msg = '房间太火爆啦，赶快登录账号占个坑吧！';
                    break;
                default:
                    msg = '很抱歉，您已被踢出房间。';
                    break;
            }
            if (msg != '') {
                MGC_Comm.CommonDialog({
                    "Title": "提示",
                    "Note": msg
                }, function() {
                    window.location.href = window.mgc.tools.changeUrlToLivearea(home);
                });
            }
            break;
            //收到申请后援团成功消息（true）收到申请后援团失败消息（false）
        case 70:
            var mark = callback_obj.is_approve;
            var dialog = {};
            dialog.Title = '提示信息';
            if (mark) {
                dialog.Note = '您已加入后援团' + callback_obj.vgname + '。'
            } else {
                dialog.Note = '后援团' + callback_obj.vgname + '拒绝了您的入团申请。'
            }
            MGC_Comm.CommonDialog(dialog);
            break;

            //收到被传位成功消息
        case 84:
            var dialog = {};
            callback_obj.old_chief_name;
            callback_obj.old_chief_zone;
            dialog.Title = '提示信息';
            dialog.Note = callback_obj.old_chief_name + "已将后援团团长之位传给了你，你成为了新的团长。";
            MGC_Comm.CommonDialog(dialog);
            break;

            //收到传位成功消息
        case 85:
            var dialog = {};
            //callback_obj.old_chief_name;
            //callback_obj.old_chief_zone;
            dialog.Title = '提示信息';
            dialog.Note = '您已成功将团长之位传给了' + callback_obj.new_chief_name;
            MGC_Comm.CommonDialog(dialog);
            break;

            //后援团最终解散的时候 通知
        case 86:
            $chat.ChatInit(false);
            var dialog = {};
            dialog.Title = '提示信息';
            dialog.Note = '您所在的后援团已解散。';
            MGC_Comm.CommonDialog(dialog);
            break;

            //被开除后援团，通知被开除的玩家
        case 87:
            $chat.ChatInit(false);
            var dialog = {};
            callback_obj.name;
            dialog.Title = '提示信息';
            dialog.Note = '您已被开除出' + callback_obj.name + '后援团。';
            MGC_Comm.CommonDialog(dialog);
            break;

            //座位被抢通知
        case 231:
            Seat.seatLost(callback_obj);
            break;
        case 230:
            Seat.grapCallBack(callback_obj);
            break;
            //刷新宝座信息
        case 232:
            Seat.getSeatList(callback_obj);
            break;
            //刷新其他人抢座成功流星特效    
        case 276:
            VIP_GRAB.vipGrabCallBack(callback_obj);
            break;
            //刷新VIP座位信息      27  
        case 277:
            VIP_GRAB.getVip(callback_obj);
            break;
        case 278:
            VIP_GRAB.getVipTime(callback_obj);
            break;
        case 275:
            VIP_GRAB.lostVip(callback_obj);
            break;
        case 279:
            //VIP_GRAB.GrabMarquee(callback_obj);
            break;
        case 281:
            VIP_GRAB.grabFreeTime(callback_obj);
            break;
            //红包
        case 251:
            MGC_CommResponse.redPacketCallBack(callback_obj);
            break;

            //发布梦幻宝箱通知
        case 284:
            DreamBox.getDreamBoxCallBack(callback_obj);
            break;

            //刷新梦幻宝箱数量
        case 285:
            DreamBox.setCountCallBack(callback_obj);
            break;

            //火箭礼物飞屏
        case 286:
            //DreamFly.add(callback_obj);
            MGC_Comm.addRocketScreenMsg(callback_obj);
            break;

            //通知梦幻宝箱被抢空
        case 287:
            var dialog = {};
            dialog.Title = '提示信息';
            dialog.Note = '来晚了，宝箱已经被抢光啦！';
            MGC_Comm.CommonDialog(dialog);
            break;

            //通知清空梦幻宝箱
        case 288:
            DreamBox.setCount(0);
            break;
        case 185:
            MGC_CommResponse.goodFriendPayCallBack(callback_obj);
            break;

        //下发广告配置
        case 315:
            //视频区广告
            var list = callback_obj.ad.background_video_ad;
            if(list.length != 0)
            {
                mgc.adVideoModel.setUrl(list[0].pic_link);
            }

            //贴边广告
            mgc.sideADModel.set("url",callback_obj.ad.edge_video_ad.jump_link);
            break;

        default:
            break;
    }
    callback_obj = null;
};

var MGC_LIVEROOM_BIND = {
    popPlayerCard: function() {
        $m('.li_player').off('click').on('click', function() {
            inv_from = 1;
            card_source = 1;
            var _playId = $m(this).attr('playid');
            var _online = $m(this).attr('online');
            var _name = $m(this).attr('name');
            var _area = $m(this).attr('area');
            var _type = parseInt($m(this).attr('mytype'));
            if (MGC_Comm.CheckGuestStatus() || _type == 3) {
                console.log("屏蔽游客操作：玩家点击游客【无响应】；游客点击游客【弹登录】");
                return;//先判断当前身份是否为游客再判断当前操作对象是否是游客    玩家点击游客【无响应】；游客点击游客【弹登录】
            }
            if (_playId == 0 || _playId == '') {
                alert('很抱歉，系统异常，请刷新页面再试。');
                return;
            }
            var _color = $m(this).find('.player').find('span').attr('style');
            if (_online == 'true') {
                //请求玩家信息
                MGC_CommRequest.getPlayerInfo(_name, _area);
                //注：  此处event为引类型，在传递过程中event改变,赋值变量随即改变，因此此处要复制一个event对象指向不同的地址。 兼容ie
                mgc.common_contral.mgc_comm.eventInfo = MGC.getEvent();
            }
        });
    },

    //弹出玩家名片
    popPlayerDetailCard: function(playerInfo) {
        $m.each(playerInfo.followed_anchors, function(k, v) {
            v.anchorStatus = v.anchor_status == 2 ? "直播中" : "离线";
            v.cardLevelShowTips = guardLevelTab[v.guard_level];
        });
        showDialog.hide();
        var cardInfoCon = $m('#cardInfoTmpl');
        var cardInfoTmpl;
        // var cardInfoTmpl = $m('#cardInfoTmpl');
        var cardInfoContainer = $m('#cardInfoContainer');
        cardInfoContainer.removeClass().addClass('pop_card ' + playerInfo._vipClass);
        cardInfoContainer.children().remove();
        cardInfoTmpl = cardInfoCon.tmpl(playerInfo);
        cardInfoTmpl.appendTo(cardInfoContainer);
        // cardInfoTmpl.tmpl(playerInfo).appendTo(cardInfoContainer);
        showDialog.show('cardInfoContainer');
        if (playerInfo._vip_name == "皇帝" || playerInfo._vip_name == "亲王") {
            $m('.pop_details .p5 fieldset').parent().removeClass().addClass('p5 pborder1');
        } else if (playerInfo._vip_name == "普通" || playerInfo._vip_name == "近卫") {
            $m('.pop_details .p5 fieldset').parent().removeClass().addClass('p5 pborder2');
        } else if (playerInfo._vip_name == "将军") {
            $m('.pop_details .p5 fieldset').parent().removeClass().addClass('p5 pborder3');
        } else if (playerInfo._vip_name == "骑士") {
            $m('.pop_details .p5 fieldset').parent().removeClass().addClass('p5 pborder4');
        }
        if (parseFloat(playerInfo._levelPer.replace('%', '')) >= 0.00 && parseFloat(playerInfo._levelPer.replace('%', '')) <= 6.00) {
            $m(".pop_info .pd_progress").css("overflow", "hidden");
        } else {
            $m(".pop_info .pd_progress").css("overflow", "inherit");
        }
        //绑定主播的弹框
        $m('.lv_links').off('click').on('click', function() {
            MGC_CommRequest.getAnchorCard($m(this).attr('anchorId'));
        });
        //绑定后援团的弹框
        $m('.backGroup_card').off('click').on('click', function() {
            MGC_CommRequest.getbackupGroupCard($m(this).attr('vgid'));
        });
        ////绑定后援团邀请
        //$m('.backGroup_invitation_card').off('click').on('click', function () {
        //    MGC_CommRequest.getbackupGroupCard($m(this).attr('vgid'));
        //});
        cardInfoTmpl = null;
        cardInfoCon = null;
    },
    //刷新我的关注信息
    refreshFollowInfo: function(type, anchor_id) {
        var fansNum = parseInt($m('.si_fans_num').text()); //页面的
        var fansCardNum = parseInt($m('.fans').text()); //card面板里面的
        if (type == 'add') {
            //关注--面板里面的肯定要变
            $m('.btn_care').text('-已关注');
            ++fansCardNum;
            $m('.fans').text(fansCardNum);
            $m('.btn_care').attr('isFollow', 1);
            if (anchor_id == MGCData.anchorID) {
                $m('.si_attention').text('已关注');
                $m('.sus_tips_').text('');
                $m('.sus_tips_').css('width', '230px');
                ++fansNum;
                $m('.si_fans_num').text(fansNum + ' 位粉丝');
                MGCData.difFollowAnchor[0].followAnchor = 1;
            }
        } else {
            $m('.btn_care').text('+关注');
            if (fansCardNum == 0) {
                fansCardNum;
            } else {
                --fansCardNum;
            }
            fansCardNum = fansCardNum <= 0 ? 0 : fansCardNum;
            $m('.fans').text(fansCardNum);
            $m('.btn_care').attr('isFollow', 0);
            if (anchor_id == MGCData.anchorID) {
                $m('.si_attention').text('关注');
                $m('.sus_tips_').text('关注TA,主播直播时可收到通知');
                $m('.sus_tips_').css('width', '163px');
                if (fansNum == 0) {
                    fansNum;
                } else {
                    --fansNum;
                }
                $m('.si_fans_num').text(fansNum + ' 位粉丝');
                MGCData.difFollowAnchor[0].followAnchor = 0;
            }
        }
    },

    //房间热度宝箱
    getBoxGift: function(id) {
        MGC_CommRequest.getBoxGift(id);
    },

    //开启热度宝箱的动画
    boxAnimation: function() {
        var box = $j("#box"),
            boxTips = $j(".box_tips"),
            boxList = box.find("li"),
            boxPrizeList = box.find("span"),
            boxAuto = true,
            timer = null;
        box.show();
        boxList.eq(0).animate({
            "left": "0px"
        });
        boxList.eq(2).animate({
            "left": "390px"
        });
        boxPrizeList.each(function(index) {
            boxList.delay(500).animate({
                "left": "195px"
            }, 1000, function() {
                box.fadeOut();
                clearTimeout(timer);
                timer = setTimeout(function() {
                    MGC.popFormsShow("boxGiftContainer");
                }, 1000);
            });
        });
    },

    //角色列表财富和等级切换
    showRoleListWL: function() {
        if ((tempShowWL % 2) == 0) {
            $m('.roleListWeath').hide();
            $m('.roleListLv').show();
        } else {
            $m('.roleListWeath').show();
            $m('.roleListLv').hide();
        }
        ++tempShowWL;
    },

    //通用弹框
    defaultPop: function($msg) {
        $m('#defaultMsg').html($msg);
        showDialog.hide();
        showDialog.show('default');
    },

    //关闭弹框，回首页
    closeRefresh: function() {
        showDialog.hide();
        window.location.href = window.mgc.tools.changeUrlToLivearea(home);
    }
};

var mousewheelFlash = function(event) {
    var delta = 0;
    event = event || window.event;
    delta = (event.originalEvent.wheelDelta) ? event.originalEvent.wheelDelta / 120 : -(event.originalEvent.detail || 0) / 3;
    console.log("滚轮刻度 " + event.originalEvent.detai + "      " + event.originalEvent.wheelDelta + "     " + delta);
    if (delta > 0) {
        delta = 30;
    }
    else if (delta < 0) {
        delta = -30;
    }
    getSWF("GiftSwf").callbackWheelHandler(delta);
    try {
        event.preventDefault();
        event.stopPropagation();
    } catch (e) {
        event.returnValue = false;
        event.cancelBubble = true;
    }
    return false;
}

var getScrollTop = function() {
    var scrollPos;
    if (document.body.scrollTop) {
        scrollPos = document.body.scrollTop;
    } else {
        scrollPos = document.documentElement.scrollTop
    }
    return scrollPos;
}
var callPageWheelHandler = function(isPerform, delta) {
    if (isPerform) {
        console.log("滚动条移动的距离 " + (getScrollTop() + delta) + "    " + getScrollTop() + "    " + delta);
        window.scrollTo(0, getScrollTop() - delta);
    } else {
        return true;
    }
}
var PreGiveUpTask = function() {
    MGC_Comm.CommonDialog({
        "Title": "提示",
        "Note": "确定要放弃当前主播任务吗？",
        "BtnName": "确定",
        "BtnName2": "取消",
        "BtnNum": 2
    }, function() {
        MGC_CommRequest.GiveUpTask();
    });
}

var reportTypes = {
    types: [{
        name: "色情暴力",
        value: 0
    }, {
        name: "骚扰谩骂",
        value: 1
    }, {
        name: "广告欺诈",
        value: 2
    }, {
        name: "病毒木马",
        value: 3
    }, {
        name: "反动政治",
        value: 4
    }, {
        name: "其它",
        value: 5
    }]
};

//举报房间
var DoReport = {
    initReport: function() {
        if (MGC_Comm.CheckGuestStatus()) {
            console.log("屏蔽游客操作：举报房间");
            return false;//游客身份下，屏蔽此操作
        }
        if (typeof MGCData.anchorName != 'undefined') {
            $m('#i_report_con').on('keyup', function() {
                var con = $m.trim($m(this).val());
                if (MGC_Comm.Strlen(con) > 400) {
                    alert('抱歉，内容已超过400个字节');
                    $m(this).val(con.substr(0, 400));
                }
            });
            var anchorName = MGCData.anchorName,
                roomName = MGCData.roomName;
            $m('#i_anchor_name').html(anchorName);
            $m('#i_room_name').html(roomName);
            $m('#icon_report_list').children().remove();
            var report_list_con = $m('#report_list_tmpl');
            var report_list_tmpl = report_list_con.tmpl(reportTypes);
            report_list_tmpl.appendTo($m('#icon_report_list'));
            // $m('#report_list_tmpl').tmpl(reportTypes).appendTo($m('#icon_report_list'));
            showDialog.show('pop_report');
            report_list_tmpl = null;
            report_list_con = null;
        } else {
            alert('当前房间不在直播中。');
        }
    },
    reportAnchor: function() {
        var anchorName = MGCData.anchorName,
            anchorID = MGCData.anchorID,
            report_con = $m.trim($m('#i_report_con').val()),
            report_type = parseInt($m('#icon_report').attr('data'));
        if (report_con == '') {
            alert('请输入举报内容');
            return;
        }
        MGC_CommRequest.reportAnchor(report_type, report_con, anchorID, anchorName);
    }

}

var Hotbar = {

    timeid:0,

    // 初始化热度条效果
    initHotBarEffect: function() {
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

        attributes.id = "hotbar";
        attributes.name = "hotbar";
        attributes.align = "middle";
        var swfurl = "assets/hotbar.swf?v=3_8_8_2016_15_4_final_3";
        if (MGC.checkIsIEloadSwfFailed()) {
            swfurl += "&r=" + Math.random();
        }
        swfobject.embedSWF(swfurl, "hotbarEffect-p", "100%", "100%",
            swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);

        this.hideHotBarEffect();
    },

    showHotBarEffect:function(){
        $m("#hotbarEffect").show();
        clearTimeout(this.timeid);
        this.timeid = setTimeout(Hotbar.hideHotBarEffect,1000);
    },

    hideHotBarEffect:function(){
        $m("#hotbarEffect").hide();
    }
};

MGC_CommResponse.mouseoverBadge();
MGC_CommResponse.mouseoutBadge();

//本页需要回调加载的功能
var roomId = MGC_Comm.getUrlParam('roomId');
var loginCallBack = function() {
    isLoginCallback = true;
    //同步MGCData
    MGCData.myPlayerId = mgc.consts.MGCData.myPlayerId;
    MGCData.myVipLevel = mgc.consts.MGCData.myVipLevel;
    //进入房间
    MGC_CommRequest.enter(roomId);
    //抢座初始化
    //Seat.init();
    //直播swf初始化
    //MGC_Comm.LiveVideoSwfInit();
    //开始直播
    //MGC_Comm.GiftSwfInit();
    //送礼swf初始化
    //MGC_Comm.GiftSwfInit();
    MGC_CommResponse.checkIsRoomGuideCallBack();

    //初始化热度条效果
    Hotbar.initHotBarEffect();
    //flash特效初始化
    window.mgc.LuckEffect.init();
    
    MGC_Comm.setFlyScreenSwfObj();
};
window.mgc.roomLoginCallBack = loginCallBack;
//直播swf初始化
MGC_Comm.LiveVideoSwfInit();
//活动礼物初始化
MGC_Comm.initEventGift();
//送礼swf初始化
isCaveolae = "false";
MGC_Comm.GiftSwfInit();



$m(function() {
    try {
        $m("#progressTimeCountDown").hover(function(e) {
            MGC.susHotTitleTips(e, 1, '抢座以及付费礼物可增加房间热度，从而开启宝箱。活动期间有额外奖励哦！<br/>进房计时结束前，热度宝箱奖励将会暂存，倒计时结束后自动补发。');
        }, function(e) {
            MGC.susHotTitleTips(e, 0);
        });
        $m("#roleListContainer").html(MGC.randNickNameFun());
        $m('.tb_con_list').jScrollPane({ autoReinitialise: true, animateScroll: true, autoReinitialiseDelay: 100 });
        $m('.sn_con').jScrollPane({ autoReinitialise: true, animateScroll: true, autoReinitialiseDelay: 100, verticalDragMinHeight: 44 });
        $m(".flash_heat").mousewheel(mousewheelFlash);
        setInterval("MGC_LIVEROOM_BIND.showRoleListWL()", 5000);
        $m('#zhuboliebiao').off('click').on('click', function() {
            if ($m(this).attr("class") != "button_zhubolistnone")
                if ($m('.list_zhubolist').is(':hidden')) {
                    MGC_CommRequest.getZhuBoList();
                    $m('.list_zhubolist').show();
                    $m(this).attr("class", "button_zhubolistdown");
                } else {
                    $m('.list_zhubolist').hide();
                    $m(this).attr("class", "button_zhubolist");
                    $m('#zhuboListWrapper .jspVerticalBar').remove();
                }
        });
        //重绘滚动条 
        var scrollAPI_tbconlist = $m('.tb_con_list').data('jsp');
        if(scrollAPI_tbconlist){
            scrollAPI_tbconlist.initScroll();
        }
        //重绘滚动条 
        var scrollAPI_sncon = $m('.sn_con').data('jsp');
        if(scrollAPI_sncon){
            scrollAPI_sncon.initScroll();
        }
        $m('#zhuboListWrapper').jScrollPane({
            autoReinitialise: true,
            animateScroll: true,
            autoReinitialiseDelay: 100,
            maintainPosition: false
        });
        //重绘滚动条 
        var scrollAPI_zhuboListWrapper = $m('#zhuboListWrapper').data('jsp');
        if(scrollAPI_zhuboListWrapper){
            scrollAPI_zhuboListWrapper.initScroll();
        }

        $m('body').on('mouseover', 'span[class^="level_span"]', function(e) {
            var level = $m(this).html();
            MGC.susTipsHtml(e, 1, '主播等级：' + level);
        });

        $m('body').on('mouseout', 'span[class^="level_span"]', function(e) {
            MGC.susTipsHtml(e, 0);
        });
        MGC.popAnchor_tips(110, -2);
    } catch (e) {

    }
    $m(".tips").hover(function () {
        $m('.tipsShow').show();

    }, function () {
        $m('.tipsShow').hide();
    });
    document.onclick = function() {
        var swfObj = getSWF("GiftSwf");
        swfObj.jsClick();
    };
});

tempShowWL = 0;


/*  |xGv00|9409b14e757774fff639b1921f41c9d1 */
