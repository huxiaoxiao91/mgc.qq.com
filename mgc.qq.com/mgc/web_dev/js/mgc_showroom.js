var wheelStop = true;//标识滚动条是否可移动showLeftTime = 0;
drawLeftTime = 0;
//是否有门票，默认人人都有门票 
hasTicket = 1;
//演唱会是否开启，默认未开启，有直播也可能未开启
isOpen = false;
isLiveOpen = false; //直播开启
giftNum = 0;
var tmpBx = 0;
var heatCchestWidth = 0;
var Qgame = false;
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

var mgc_bg_default = 'http://ossweb-img.qq.com/images/mgc/css_img/common/mgc_auto.png?v=3_8_8_2016_15_4_final_3';
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
        if (mouseX || mouseY) {
            mgc.common_contral.mgc_comm.eventInfo = undefined;
        }
        area = area.replace("炫舞-", ""); //过滤炫舞-  防止服务器找不到大区
        var _reqStr = { "op_type": OpType.GetMemberInfoOpType, "name": name, "zoneName": area };
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getPlayerInfoCallBack");
    },

    //角色列表-他人名片
    getListCardInfo: function(id, source) {
        var _reqStr = { "op_type": OpType.GetPlayerInfoOpType, "player_id": id, "source": source};
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getListCardInfoCallBack");
    },

    //获取可选的清晰度
    SelectDefinition: function() {
        var _reqStr = "{\"op_type\":" + OpType.SelectDefinitionOpType + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.SelectDefinitionCallBack");
    },

    //设置视频的质量
    ChangeDefinition: function(definition) {
        var _reqStr = "{\"op_type\":" + OpType.ChangeDefinitionOpType + ",\"definition\":" + definition + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.ChangeDefinitionCallBack", definition);
    },

    //获取本页购票地址
    GetTicketUrl: function(type) {
        var _reqStr = "{\"op_type\":" + OpType.GetTicketUrlOpType + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.GetTicketUrlCallBack", type);
    },

    //抽奖展示
    showRoomGift: function(refresh) {
        if (MGC_Comm.CheckGuestStatus()) {
            console.log("屏蔽游客操作：抽奖展示");
            return false;//游客身份下，屏蔽此操作
        }
        var _reqStr = "{\"op_type\":" + OpType.GetShowRoomGiftOpType + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.showRoomGiftCallBack", refresh);
    },

    //抽奖
    giftLucky: function() {
        var _reqStr = "{\"op_type\":" + OpType.ShowRoomGiftLuckyOpType + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.giftLuckyCallBack");
    },

    //设置新手教学
    setStudy: function() {
        var _reqStr = "{\"op_type\":181}";
        MGC_Comm.sendMsg(_reqStr);
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

    //拉取主播名片信息
    getAnchorCard: function(anchorId) {
        if (MGC_Comm.CheckGuestStatus()) {
            console.log("屏蔽游客操作：拉取主播名片信息");
            return false;//游客身份下，屏蔽此操作
        }
        if (anchorId) {
            var _reqStr = "{\"op_type\":" + OpType.GetAnchorCardOpType + ", \"anchorID\":" + anchorId + "}";
        } else if (MGCData.anchorID) {
            var _reqStr = "{\"op_type\":" + OpType.GetAnchorCardOpType + ", \"anchorID\":" + MGCData.anchorID + "}";
        }
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.showAnchorCardCallBack");
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

    //主播弹框-粉丝排行-他人名片
    getFansCardInfo: function(id, source) {
        var _reqStr = "{\"op_type\":" + OpType.GetPlayerInfoOpType + ",\"player_id\":\"" + id + "\"" + ",\"source\":\"" + source + "\"}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getListCardInfoCallBack");
    },

    //获取as缓存
    showRoomGetAsCache: function() {
        MGC_Comm.commonGetUin(function(_uin) {
            var _reqStr = "{\"op_type\":-1,\"qq\":\"" + uin + "\"}";
            MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.showRoomGetAsCacheCallBack");
        });
    }
};
var activityId = '';
var activity_daily = '';
var activityArray = [];
var popId = false; 
//存储主播面板返回的消息
var _anchorInfo = {};
var anchorTmpl = $m('#anchorTmpl');
var anchorContainer = $m('#anchorContainer');
// 存储超级粉丝列表返回的消息
var _fansInfo = [];
var fansTmpl = $m('#fansTmpl');
var fansContainer = $m('#fansContainer');
var MGC_SpecialResponse = {
    //进入房间回调
    EnterRoomCallBack: function (responseStr) {
        if (typeof (responseStr) == 'object') {
            LiveRoomData = responseStr;
        } else {
            LiveRoomData = JSON.parse(responseStr);
        }
        //LiveRoomData = JSON.stringify(responseStr);
        console.log("进入房间_回调:" + JSON.stringify(responseStr));
        FreeGift.showRoomsessionNo = responseStr.info.concert_id;
        FreeGift.getShowNo = true;
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
        if (_repStr.ret == 0) {
            var msg = '';
            //测试
            /*
			var roomId = MGC_Comm.getUrlParam('roomId');
			if(roomId==88){
				_repStr.res = 49;
			}*/
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
                    var recommend = MGC_Comm.getUrlParam('recommend');
                    if (MGC_Comm.CheckGuestStatus(true)) {
                        msg = '房间人满，请登录后再次尝试';
                        MGC_Comm.CommonDialog({
                            "Title": "提示",
                            "Note": msg,
                            "BtnName": "确定",
                            "BtnNum": 1
                        }, function() {
                            MGC_ACTION.closeRefresh();
                        }, function() {
                            MGC_ACTION.closeRefresh();
                        });
                    } else {
                        msg = '房间人满。如果拥有贵族身份，或者成为当前主播的天使守护及以上，可以优先的进入人满房间哦~<br>今日剩余挤房次数：-';
                        if (recommend) {
                            //分流推荐过来的
                            MGC_Comm.CommonDialog({
                                "Title": "提示",
                                "Note": msg, 
                                "BtnName": "更多推荐",
                                "BtnNum": 1
                            }, function() {
                                MGC_ACTION.closeRefresh(recommend);
                            }, function() {
                                MGC_ACTION.closeRefresh(recommend);
                            });
                        } else {
                            MGC_Comm.CommonDialog({
                                "Title": "提示",
                                "Note": msg, 
                                "BtnName": "确定",
                                "BtnNum": 1
                            }, function() {
                                MGC_ACTION.closeRefresh();
                            }, function() {
                                MGC_ACTION.closeRefresh();
                            });
                        }
                    }
                    return;
                    /*
					var vip = _repStr.info.m_vip_level;
					var roomId = MGC_Comm.getUrlParam('roomId');
					if ( vip==1 || vip==2 ) {
						msg = '房间人满。如果拥有贵族身份，或者成为当前主播的天使守护及以上，可以优先的进入人满房间哦~<br>今日剩余挤房次数：'+_repStr.info.m_remain_crowdroom_count;
						MGC_Comm.CommonDialog({"Title":"提示","Note":msg,"BtnName":"挤房间","BtnName2":"确定","BtnNum":2},MGC_CommRequest.enter(roomId,1),MGC_ACTION.closeRefresh());
					} else {
						//非vip--购买贵族（待完善）
						msg = '房间人满。如果拥有贵族身份，或者成为当前主播的天使守护及以上，可以优先的进入人满房间哦~<br>今日剩余挤房次数：-';
						MGC_Comm.CommonDialog({"Title":"提示","Note":msg,"BtnName":"购买贵族","BtnName2":"确定","BtnNum":2},MGC_CommRequest.enter(roomId,1),MGC_ACTION.closeRefresh());
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
                    var recommend = MGC_Comm.getUrlParam('recommend');
                    msg = '房间人满。如果拥有贵族身份，或者成为当前主播的天使守护及以上，可以优先的进入人满房间哦~<br>今日剩余挤房次数：' + _repStr.info.m_remain_crowdroom_count;
                    if (recommend) {
                        MGC_Comm.CommonDialog({
                            "Title": "提示",
                            "Note": msg,
                            "BtnName": "挤房间",
                            "BtnName2": "更多推荐",
                            "BtnNum": 2
                        }, function() {
                            MGC_CommRequest.enter(roomId, 1);
                        }, function() {
                            MGC_ACTION.closeRefresh(recommend);
                        });
                    } else {
                        MGC_Comm.CommonDialog({
                            "Title": "提示",
                            "Note": msg,
                            "BtnName": "挤房间",
                            "BtnName2": "确定",
                            "BtnNum": 2
                        }, function() {
                            MGC_CommRequest.enter(roomId, 1);
                        }, function() {
                            MGC_ACTION.closeRefresh();
                        });
                    }
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
                        MGC_ACTION.closeRefresh();
                    }, function() {
                        MGC_ACTION.closeRefresh();
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


            MGC.progressTime('progressTime', 120);

            if (msg != '') {
                if (_repStr.res == 56) {
                    MGC_CommRequest.GetTicketUrl(3);
                } else {
                    MGC_Comm.CommonDialog({
                        "Title": "提示",
                        "Note": msg
                    }, function() {
                        MGC_ACTION.closeRefresh();
                    });
                }
                return;
            }
            //test--
            isOpen = _repStr.info.concert_is_open;

            if (!_repStr.info.has_concert_ticket) {
                //无门票
                hasTicket = 0;
                MGC_CommRequest.GetTicketUrl(1);
                $m('.sc_box_panl').addClass('sc_box_un');
                $chat.unMaskGifts();//禁用屏蔽免费礼物
                $m('.sc_role').addClass('sc_role_un');
                $m('#SendMsgChatBox').attr('disabled', 1);
                $m('.sc_box_btn').addClass("stopClick");
                $m('.scr_r').attr('onclick', '').off('click');
                FreeGift.setEnabled(false);
            } else {
                //有门票才能聊天
                hasTicket = 1;
                $chat.SendMsgChatInit();
                $m('.sc_box_panl').removeClass('sc_box_un');
                $chat.maskGifts();//启用屏蔽免费礼物
                $m('.sc_role').removeClass('sc_role_un');
                $m('.scr_r').attr('onclick', '$chat.GetPrivateMsgChatList();');
                //有可能本页登录，把无门票的tips隐藏
                $m('.mvc_tips').hide();
                $m('#SendMsgChatBox').removeAttr('disabled');
                $m('.sc_box_btn').removeClass("stopClick");
                FreeGift.setEnabled(true);
            }

            if (_repStr.info.has_concert_ticket) {
                //有票且开播了才能送。。。
                if (MGC_SWFINIT.GiftSwf) {
                    gift_response(LiveRoomData);
                }
            }

            if (!_repStr.info.concert_is_open) {
                //演唱会尚未开始--不处理，在是否直播那里处理。
                //直播加上图片
                //MGC_CommRequest.GetTicketUrl(2);
            } else if (!_repStr.info.has_concert_ticket) {
                //无门票且开播了，视频要隐藏
                MGC_CommRequest.GetTicketUrl(2);
            } else {
                //MGC_CommRequest.showRoomGetAsCache();
                //有门票，且直播
                //获取可选的清晰度
                // MGC_CommRequest.SelectDefinition();
            }
        } else {
            MGC_Comm.CommonDialog({
                "Title": "提示",
                "Note": "很抱歉，进入房间失败，请重试"
            }, function() {
                window.location.href = window.mgc.tools.changeUrlToLivearea(home);
            });
        }
        MGC.popTipss("sn_title_con", "i");

        //热门房间
        //MGC_CommRequest.HotRecommRoom();
        HotRoom.getHotRoom();
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
    refreshRoom: function (obj) {
        //初始化礼物插件存储信息        
        LiveRoomData = obj;
        //未了避免先得到房间刷新消息，礼物区未初始化完毕，这里先存储数据，待礼物区初始化完毕，传此数据，调礼物区插件（房间开播下）,激活飞屏、赠送按钮
        MGCData.giftDataRoom = LiveRoomData;
        
        //LiveRoomData = JSON.stringify(obj);
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
        $m('#showRoomId').text(MGCData.roomID);
        //设置房间名
        MGCData.roomName = obj.data.roomName;
        $m('#showRoomName').text(MGCData.roomName);
        //清晰度列表
        //MGC_CommRequest.SelectDefinition();
        if (MGCData.roomStatus != 2) {
            MGC_CommRequest.GetTicketUrl(2);
            isLiveOpen = false;
        } else {
            isLiveOpen = true;
        }
    },

    // refreshOnlineNums: function(obj) {
    //     //刷新在线人数
    //     var obj = MGC_Comm.strToJson(obj);
    //     var playCount = obj.count;
    //     $m('#onlineCount').text(playCount);
    // },
    //非主动更新主播信息
    is_first: true,
    refreshAnchor: function(obj) {
        console.log('非主动更新主播信息:' + JSON.stringify(obj));
        var obj = MGC_Comm.strToJson(obj);
        $m.extend(true, _anchorInfo, obj.data);
        //添加首次刷新逻辑
        //if (MGC_SpecialResponse.is_first) {
        //    MGCData.roomID = roomId;
        //    MGCData.roomName = obj.roomName;
        //    MGCData.roomStatus = _anchorInfo.status;
        //    MGCData.followAnchor = obj.isFollow;
        //    MGC_SpecialResponse.is_first = false;
        //}
        MGCData.anchorName = _anchorInfo.name;
        _anchorInfo.roomId = MGCData.roomID;
        _anchorInfo.roomName = MGCData.roomName;
        //印象数据
        _anchorInfo.impression = _anchorInfo.follow = _anchorInfo.followNum = '';

        var ac = $m('#si_face_links');
        var anchorImg = ac.find("img");

        if (MGCData.roomStatus == 2) {
            MGCData.anchorID = obj.data.anchorID;
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

            if (anchorImg.attr("src") != _anchorInfo.photoUrl) {
                anchorImg.attr("src", _anchorInfo.photoUrl);
            }

        } else {
            //不再直播使用默认头像
            _anchorInfo.photoUrl = HeadImgPath + "default_female.png?v=3_8_8_2016_15_4_final_3";
            //名字置空
            _anchorInfo.name = "";

            if (anchorImg.attr("src") != _anchorInfo.photoUrl) {
                anchorImg.attr("src", _anchorInfo.photoUrl);
            }
        }
        ac = null;
        anchorImg = null;

        
        var anchorTmplCon;
        
        anchorContainer.children().remove();
        anchorTmplCon = anchorTmpl.tmpl(_anchorInfo);
        anchorTmplCon.appendTo(anchorContainer);
        
        anchorContainer.find(".sf_flower").off("mouseover").on("mouseover", function() {
             MGC.pop_rqTips(event, 1, '赠送免费礼物增加主播人气，主播人气会随时间衰减');
        }).off("mouseout").on("mouseout", function() {
            MGC.pop_rqTips(event, 0);
        });
        anchorContainer.find(".sf_heart").off("mouseover").on("mouseover", function() {
            MGC.pop_rq_two_Tips(event, 1, '赠送付费礼物增加主播星耀值');
        }).off("mouseout").on("mouseout", function() {
            MGC.pop_rq_two_Tips(event, 0);
        });
        
        console.log("房间人气变化：" + _anchorInfo.starlight + "  " + _anchorInfo.popularity);
        _anchorInfo.anchor_level_temp = 0;
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

            if (_anchorInfo.anchor_Per <= 0) {
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
        
            //演唱会房间里的主播等级经验槽数据加载内容
            //主播经验条区域加载内容
        if (MGCData.roomStatus == 2) {
            //当主播信息接口未被刷新时候，初始化未指定的演唱会房间--如果主播等级非零，加载主播经验区域
            if (MGCData.anchor_level != 0) {
                //当主播信息接口未被刷新时候，初始化指定的演唱会房间--如果主播等级非零，加载主播经验区域
                if (!(MGCData.anchor_level == 1 && MGCData.anchor_levelup_exp == 0)) {
                    //初始化经验条主播区域
                    //$j('#anchor_level_temp').attr("class","anchor_level_" + MGCData.anchor_level_bg);
                    $j('#anchor_level_temp').html('<i>' + MGCData.anchor_level + '</i>');
                    $j('#anchor_level_temp').css({ 'display': 'inline-block', 'position': 'absolute' });
                    $j('#anchor_level_temp').css("background","url('http://ossweb-img.qq.com/images/mgc/css_img/common/anchor_level/"+ MGCData.anchor_level_bg +".png?v=3_8_8_2016_15_4_final_3') no-repeat right center");
                    $j('#anchor_level_temp').attr('class', "anchorLevel anchor_level_" + MGCData.anchor_level_bg);
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
                        $j('#anchor_Per,#spanW0,#anchor_exp,#pd_progress').css('display', 'none');
                        $j('#i_is_bottleneck').css('display', 'block');
                        $j('#gift_mover,#exp_common,#exp_max').css('display', 'none');
                        $j('#anchor_level_txt').hide();
                        $j('#anchor_level_tips strong').css('width', '168px');
                    } else {
                    	if($j('#is_bottleneck').css('display')!="none"){
                    		$j('#anchor_level_tips').css('display', 'none');
                            window.mgc.popmanager.layerControlHide($j('#anchor_level_tips').find("strong"), 1, 3);
                    	}
                    	$j('#anchor_level_tips strong').css('width', '270px');
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
                            $j('#max_span,#max_i').css('display', 'block');                            
                            $j('#anchor_Per,#anchor_exp').css('display', 'none');
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
                    //当主播信息接口未被刷新时候，初始化指定的演唱会房间--如果主播等级是零，主播经验区域不显示
                } else {
                    $j('#anchor_level_temp,#pd_progress,#is_bottleneck').css('display', 'none');
                }
                //当主播信息接口未被刷新时候，初始化未指定的演唱会房间--如果主播等级是零，主播经验区域不显示
            } else {
                $j('#anchor_level_temp,#pd_progress,#is_bottleneck').css('display', 'none');
            }
            //主播等级经验条区域结束
            $m('.pd_progress').css('overflow', 'inherit');
        } else if (MGCData.roomStatus == 1) {
            $j('#anchor_level_temp,#pd_progress,#is_bottleneck').css('display', 'none');
            var strongItem = $m('#anchor_level_tips').find("strong");
            window.mgc.popmanager.layerControlHide(strongItem, 1, 3);
            $j('#anchorContainer .sf_nic').children().remove();
            $j('#anchorContainer .sf_nic').html('<strong></strong>');
            //停止直播，关闭所有任务、投票
            $m('#newVote,#newTask,.md_cj_i,.md_rw,.md_cj').hide();
        }
       

        //如果在直播中，则要显示
        if (MGCData.roomStatus == 2) {
            $m('.hiddenAnchor,.si_open_vip').show();
        }
        MGC.popTipss("pop_tips", "i");        
        if (MGCData.roomStatus == 2) {
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
                    $m('.sus_tips_').text('关注TA,主播直播时可收到通知');
                    MGC.susStatepositionTips(e, 1, "关注TA,主播直播时可收到通知");
                }
                else {
                	if (hasTicket) {
                        $m('.si_attention').text('取消');
                    }
                	$m('.sus_tips_').css({ 'width': '230px','padding':'5px' });
                    $m('.sus_tips_').text('取消关注，点击后取消关注，恢复为关注Ta');
                    MGC.susStatepositionTips(e, 1, "取消关注，点击后取消关注，恢复为关注Ta");
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
            if (hasTicket) {
                //取消和关注主播绑定
                $m('.si_attention').off('click').on('click', function() {
                    MGC_CommRequest.followAnchorAction(0);
                });
            } else {
                $m('.si_attention').addClass("si_attention_lock");
            }
            //绑定开通贵族
            mgc.common_contral.CommOpenVip.room_anchor_id = _anchorInfo.anchorID;
            mgc.common_contral.CommOpenVip.room_anchor_name = _anchorInfo.name;
            if ($m('.si_open_vip').find("object").length == 0) {
                $m('.si_open_vip span').unbind('click').on('click', function(e) {
                    if (mgc.common_contral.CommOpenVip.room_anchor_id == "0") { return;}
                    mgc.common_contral.CommOpenVip.open(mgc.common_contral.CommOpenVip.room_anchor_id, mgc.common_contral.CommOpenVip.room_anchor_name);
                    mgc.tools.EAS([{ 'e_c': 'mgc.buyvip.2', 'c_t': 4 }, { 'e_c': 'mgc.buyvip', 'c_t': 4 }]);
                }).unbind("mouseover").bind("mouseover", function(e) {
                    window.mgc.popmanager.layerControlShow($m(".sus_tips_open_vip"), 1, 3);
                }).unbind("mouseout").bind("mouseout", function(e) {
                    window.mgc.popmanager.layerControlHide($m(".sus_tips_open_vip"), 1, 3);
                });
                mgc.common_contral.CommOpenVip.initOpenBtnSwf(2);
            }
        }
        obj = null;
        anchorTmplCon = null;
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
                    v.vipName = vipLevelTab[v.viplevel];
                }
                v.zoneName = v.zoneName != "" ? (v.zoneName == "梦工厂" ? v.zoneName : "炫舞-" + v.zoneName) : "";
            });
            var fansTmplCon;
            fansContainer.children().removeAll();
            fansTmplCon = fansTmpl.tmpl(_fansInfo);
            fansTmplCon.appendTo(fansContainer);
            
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
            
            //调用守护的数据
            var _reqStr = "{\"op_type\":" + OpType.GetGuardOpType + ", \"fanstype\":1,\"anchorID\":" + MGCData.anchorID + "}";
            console.log("调用守护信息：" + _reqStr);
            MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getGuard");
            if (_fansInfo.length > 3) {
                //为另一个模板装数据
                var moreFansContainer = $m('#more_fans_container');
                moreFansContainer.children().removeAll();
                fansTmplCon = fansTmpl.tmpl(_fansInfo);
                fansTmplCon.appendTo(moreFansContainer);

                moreFansContainer.find("i").off("mouseover,mouseout").on("mouseover", function(){
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

                
                //下拉按钮可点
                $m('#down_icon_div').attr("class", "down_enable");
      			$m('#more_fans').attr("class", "blue_div");
                if (_fansInfo.length >= 10) {
                    for (var i = 9; i <= _fansInfo.length; i++) {
                        $m('#fansContainer').find('li').eq(i).addClass('double');
                        $m('#more_fans_container').find('li').eq(i).addClass('double');
                    }
                    //加滚动条
                    if (_fansInfo.length > 10) {
                        $m('#more_fans_con').attr("class", "fixed_height");
                        $m('#more_fans_con').jScrollPane({
                            autoReinitialise: true,
                            animateScroll: true
                        });
                        //重绘滚动条 
                        var scrollAPI_morefanscon = $m('#more_fans_con').data('jsp');
                        if(scrollAPI_morefanscon){    
                            scrollAPI_morefanscon.initScroll();
                        }
                    }
                } else {
                    var element = $m('#more_fans_con').jScrollPane({});
                    var api = element.data('jsp');
                    api.destroy();
                    $m('#more_fans_con').attr("class", "auto_height");
                }

            } else {
                //下拉按钮置灰
                $m('#down_icon_div').attr("class", "down_disable");
                $m('#more_fans').attr("class", "grey_div");
                //更多图层隐藏
                $m('#more_fans').css("visibility", "visible");
                $m('.side_fans').css("visibility", "visible");
                $m('#more_side_fans').hide();
            }
            
            
            
            
            

            $m('#down_icon_div').off('click').on('click', function() {
                if ($m('#down_icon_div').attr("class") == "down_enable") {
                    if (!MGC_Comm.CheckGuestStatus(false)) {
                        $m('#more_fans').css("visibility", "hidden");
                        $m('.side_fans').css("visibility", "hidden");
                        $m('#more_side_fans').show();
                    }
                }
            }); 

            $m('#up_icon_div').off('click').on('click', function() {
                $m('#more_fans').css("visibility", "visible");
                $m('.side_fans').css("visibility", "visible");
                $m('#more_side_fans').hide();
            });
            
            if (hasTicket) {
                $m('.li_sz_room').off('click').on('click', function() {
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
                    MGC_CommRequest.getPlayerInfo(_name, _area);
                    //注：  此处event为引类型，在传递过程中event改变,赋值变量随即改变，因此此处要复制一个event对象指向不同的地址。 兼容ie
                    mgc.common_contral.mgc_comm.eventInfo = MGC.getEvent();
                });

            }
            fansTmplCon = null;
        } else {
            //异常
        }
        obj = null;
        //重绘滚动条 
        if (!mgc.consts.API.scroll.fanslist)
            mgc.consts.API.scroll.fanslist = $m('.sr_con').data('jsp');
        if(mgc.consts.API.scroll.fanslist){
            mgc.consts.API.scroll.fanslist.initScroll();
        }
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

    //聊天
    PushTalk: function(obj) {
        $chat.PushTalk(obj);
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

        $m('#addHotContainer').css("display", "none");

        if (_addHotInfo.vipInfo != '' && MGCData.roomStatus == 2) {
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
            $m('#addHotContainer').css("display", "block");
            addHotTmpl = null;
            addHotCon = null;
        }
        //主动请求热度宝箱
        //MGC_CommRequest.getHotBox();
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
        var _iHtmlCover = '';
        var _iHtml = '';
        var _tmpHot = _need = _thisAll = 0;
        var _tmpOverK = 4;
        //每个间隔的长度
        var _widthObj = {
            0: 41,
            1: 38,
            2: 39,
            3: 40
        };
        var _widthObjSmall = {
            0: 32,
            1: 68,
            2: 108,
            3: 146
        };
        var _iconLeft = {
            0: 25,
            1: 63,
            2: 102,
            3: 142
        };
        console.log("getHotBoxCallBack s obj.data.length = " + obj.data.length);
        // 添加补刀王数据consts.lastKingNeedData
        // clearInterval(mgc.consts.lastKingTimer);
        if (obj.res == 0 || obj.res == 1 || obj.res == 2 || obj.res == 3) {
            if (obj.roomID == MGCData.roomID) {
                var count = 0;
                $m.each(obj.data, function(k, v) {

                    if (v.index == 13 || v.index == 14 || v.index == 15 || v.index == 16) {
                        //前4个是房间热度
                        if (v.status == 0) {
                            //不能打开，要看下需要的热度
                            _need = MGCData.curHeight - _tmpHot;
                            _need = _need < 0 ? 0 : _need;
                            _thisAll = v.require - _tmpHot;
                            var _realNeed = v.require - MGCData.curHeight;
                            /**
                            *   判断是否是补刀王 start，替换数据
                            */
                            if(_realNeed <= mgc.consts.lastKingNeedData[k-8]){// && !mgc.consts.isRongruTime
                                mgc.lastKingModel.set("lastKingBoxIndex", (k-8));
                                mgc.lastKingModel.set("isShow",!(mgc.lastKingModel.get("isShow")));
                            }else{
                                clearInterval(mgc.consts.lastKingTimer);
                            }
                            /**
                             * end
                             */
                            _tmpOverK = count;
                            return false;
                        } else if (v.status == 1) {
                            //可以打开
                            _tmpHot = v.require;
                            clearInterval(mgc.consts.lastKingTimer);
                            _iHtmlCover += '<i class="p_icon_1 " style="left:' + _iconLeft[count] + 'px"></i>';
                            _iHtml += '<i class="p_icon_2 " style="left:' + _iconLeft[count] + 'px" rel="'+v.index+'"></i>';
                        } else {
                            //已经打开过了
                            _tmpHot = v.require;
                            _iHtmlCover += '<i class="p_icon_1" style="left:' + _iconLeft[count] + 'px"></i>';
                        }

                        count++;
                    }
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
        _width = _width > 165 ? 165 : _width;
        var _boxInfo = {};
        _boxInfo.width = heatCchestWidth;
        _boxInfo.iHtmlCover = _iHtmlCover;
        _boxInfo.iHtml = _iHtml;
        console.log1("getHotBoxCallBack width = s " + _width + "," + heatCchestWidth);
        var boxHotCon = $m('#boxHotTmpl');
        var boxHotTmpl;
        var boxHotContainer = $m('#boxHotContainer');
        boxHotContainer.children().remove();
        boxHotTmpl = boxHotCon.tmpl(_boxInfo);
        boxHotTmpl.appendTo(boxHotContainer);
        $m(".showSpanCover .p_icon_2").unbind("click").bind("click", function() {
            MGC_ACTION.getBoxGift($m(this).attr("rel"));
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
        boxHotTmpl = null;
        boxHotCon = null;
    },
    /*
    *演唱会走马灯
    *演唱会没有守护入场及排行榜变化，此为跟其他房间统一，其他走马灯不会被执行
    */
    RevolvingDoor: function(obj) {
        if (obj.op_type == 39) {//付费礼物
            obj.MsgStr = "[" + obj.info.sender + "]" + "对[" + obj.info.anchor + "]" + "献上了" + "#IMG?type=gift_icon&a=" + obj.info.giftid + "#×" + obj.info.num;
        } else if (obj.op_type == 40) {//贵族入场
            var vip_icon = obj.viplevel > 0 ? "#IMG?type=icon_honor&a=" + obj.viplevel + "#": "";
            obj.MsgStr = vip_icon + obj.player_name + "驾临至房间" + obj.room_name + "气宇非凡，万民欢腾";
        } else if (obj.op_type == 235) {//排行榜变化
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
    },

    //直播地址通知
    LiveVideoStart: function(obj) {
        LiveCDNUrl = JSON.stringify(obj);
        if (MGC_SWFINIT.LiveVideo) {
            video_response(LiveCDNUrl);
        };
        //MGC_CommRequest.SelectDefinition();
        //if (!isOpen) {
        $m('.video_pic').hide();
        //}
    },
    //停止直播
    LiveVideoStop: function(obj) {
        LiveCDNUrl = JSON.stringify(obj);
        video_response(LiveCDNUrl);
        //$m('.video_pic').find('img').attr('src', ShowRoomWatingImgPath || mgc_bg_default);
        //$m('.video_pic').show();
        MGC_CommRequest.GetTicketUrl(2);
        isLiveOpen = false;
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
        var OnlineTaskRewardsCon = $m('#OnlineTaskRewardsTmpl');
        var OnlineTaskRewardsTmpl;
        var CompleteOnlineTaskRewardContainer = $m('#CompleteOnlineTaskRewardContainer');
        CompleteOnlineTaskRewardContainer.children().remove();
        OnlineTaskRewardsTmpl = OnlineTaskRewardsCon.tmpl(array);
        OnlineTaskRewardsTmpl.appendTo(CompleteOnlineTaskRewardContainer);
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
                $m('#gameTool').text('（获得的游戏道具会直接进入游戏背包）');
            }else{
                $m('#gameTool').text('（获得的游戏道具以邮件发放到电脑端）');
            }
        } else {
            $m('#gameTips').text('：');
        }
        OnlineTaskRewardsTmpl = null;
        OnlineTaskRewardsCon = null;
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
    //角色列表-他人名片
    getListCardInfoCallBack: function(obj) {
        console.log("查询个人名片信息：" + obj);
        obj = MGC_Comm.strToJson(obj);
        if (obj.result != 0) {
            var msg = "";
            switch (obj.result) {
                case 2:
                    msg = '无法查看名片信息，请求超时';
                    break;
                case 3:
                    msg = '无法查看名片信息，内部错误';
                    break;
                case 4:
                    msg = '该玩家不在线，无法查看名片信息';
                    break;
                case 7:
                    msg = '无法查看名片信息，服务器繁忙';
                    break;
                case 13:
                    msg = '无法查看名片信息，目标不是玩家。';
                    break;
                case 18:
                    window.mgc.common_logic.CheckNameError(77);
                    return;
                default:
                    msg = '无法查看名片信息，其他错误。';
                    break;
            }
            MGC_Comm.CommonDialog({
                "Title": "提示",
                "Note": msg
            });
        } else {
            var _playerInfo = {};
            _playerInfo._portrait_url = obj.card_info.portrait_url;
            var _sexId = obj.card_info.player_sex;
            //他人名片弹出框--男女
            _playerInfo._sexCardInfo = _sexId == 0 ? "pop_woman" : "pop_man";
            if (_playerInfo._portrait_url == '') {
                if (_sexId != 0) {
                    _playerInfo._portrait_url = HeadImgPath + "default_male.png?v=3_8_8_2016_15_4_final_3";
                } else {
                    _playerInfo._portrait_url = HeadImgPath + "default_female.png?v=3_8_8_2016_15_4_final_3";
                }
            }
            //玩家昵称
            _playerInfo._nickName = obj.card_info.player_name;
            //大区
            var _zoneId = obj.card_info.zone_id;
            if (_zoneId == MGCData.mgcZoneId) {
                //_playerInfo._showAreaName = '梦工厂';
                _playerInfo._showAreaName = obj.card_info.zone_name;
            } else {
                _playerInfo._showAreaName = '炫舞-' + obj.card_info.zone_name;
            }
            //贵族
            _playerInfo._vip_name = vipLevelTab[obj.card_info.vip_level];
            var tempVipI = parseInt(obj.card_info.vip_level + 1);
            _playerInfo._vipClass = 'pop_card' + tempVipI;
            //工厂等级
            _playerInfo._videoLevel = obj.card_info.videoLevel;

            //当前的经验
            _playerInfo._currentExp = obj.card_info.exp;
            _playerInfo.levelup_exp = obj.card_info.levelup_exp;
            if (obj.card_info.vip_level == 0) {
                _playerInfo.roleGuizu = "icon_honor";
            } else {
                _playerInfo.roleGuizu = "icon_honor icon_honor" + obj.card_info.vip_level;
            }
            //下一级的经验
            var _nextExp = obj.card_info.levelup_exp;
            if (_nextExp == 0) { //满级
                _playerInfo._levelPer = '100%';
            } else {
                var _perLv = (_playerInfo._currentExp / _nextExp) > 1 ? 1 : (_playerInfo._currentExp / _nextExp);
                _playerInfo._levelPer = (_playerInfo._currentExp / _nextExp).toPercent(2);               
            }
            //他人名片弹出框--等级todo
            //他人名片弹出框--财富值
            _playerInfo.wealth = obj.card_info.wealth;
            //他人名片弹出框--签名
            _playerInfo.signature = obj.card_info.signature;
            //关注的主播信息
            _playerInfo.followed_anchors = obj.card_info.followed_anchors;
            //弹出他人名片框
            MGC_ACTION.popPlayerDetailCard(_playerInfo);
            $j('.tb_con').jScrollPane({
                autoReinitialise: true,
                animateScroll: true
            }); //yao 滚轮
            //重绘滚动条 
            var scrollAPI_tbcon = $j('.tb_con').data('jsp');
            if(scrollAPI_tbcon){
                scrollAPI_tbcon.initScroll();
            }
        }
    },

    //个人名片回调
    getPlayerInfoCallBack: function(obj) {
        console.log("获取的个人名片信息：" + JSON.stringify(obj));
        obj = MGC_Comm.strToJson(obj);
        var _playerInfo = {};
        if (!obj.mem_info.Online) {
            showCloseTips(mgc.common_contral.mgc_comm.eventInfo, '该用户已不在房间中');
            return false;
        }
        _playerInfo.guardlevelClass = _playerInfo.guardlevelShow = _playerInfo.viplevelClass = _playerInfo.viplevelShow = _playerInfo.wealthlevelClass = '';
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
        var cardTipContainer = $m('#cardTipContainer');
        cardTipContainer.children().remove();
        cardTipTmpl = cardTipCon.tmpl(_playerInfo);
        cardTipTmpl.appendTo(cardTipContainer);
        //兼容不容版本的jquery版本
        cardTipContainer.find(".privitechat").unbind("click").bind("click", function() {
            $chat.PreSendMsgChat(1, this, true);
        });
        //如果有名片、绑定名片事件
        if (_playerInfo._cardClass == 'icon_card') {
            if (obj.mem_info.playerType == 0) { //主播
                $m('.icon_card').removeClass().addClass('icon_card_un');
                //$m('.icon_card').off('click').on('click', function() {
                //    window.mgc.popmanager.layerControlHide($m(".card_tips"), 1, 2);
                //    MGC_CommRequest.getAnchorCard($m(this).attr('anchorId'));
                //});
            } else { //玩家
                $m('.icon_card').off('click').on('click', function() {
                    //需要判断在不在线-已经在点击阶段实现
                    window.mgc.popmanager.layerControlHide($m(".card_tips"), 1, 2);
                    //查询名片信息
                    MGC_CommRequest.getListCardInfo(_playerInfo._targetId, card_source);
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
    //====horizon====//
    //刷新任务
    refreshTask: function(obj) {
        console.log("刷新任务：" + JSON.stringify(obj));
        //有任务，显示任务按钮--没门票的不显示
        if (obj != null && obj.info.length == 0) { //删除完
            $m('.md_rw').hide();
            return;
        }
        if (hasTicket == 1 && isLiveOpen) {
            $m('.md_rw').show();
            if (newTask == 1) {
                $m('#newTask').show();
            }
        }
        var taskInfo = obj.info;
        var isHide = true;
        $m.each(taskInfo, function(k, v) {
            if (v.status == 1) { //完成了
                v.taskProClass = "spt_progress spt_progress_100";
                v.taskProPer = "100%";
                v.taskProResult = "已完成";
            } else {
                isHide = false;
                v.taskProClass = "spt_progress";
                v.taskProPer = (v.current_progress / v.finish_progress).toPercent(2);
                v.taskProResult = v.current_progress + "/" + v.finish_progress;
            }
        });
        if (isHide) {
            $m('#newTask').hide();
        }
        var taskCon = $m('#taskTmpl');
        var taskTmpl;
        var taskContainer = $m('#taskContainer');
        taskContainer.children().remove();
        taskTmpl = taskCon.tmpl(taskInfo);
        taskTmpl.appendTo(taskContainer);
        taskTmpl = null;
        taskCon = null;
    },

    //获取可选的清晰度列表
    SelectDefinitionCallBack: function(obj) {
        console.log("获取的清晰度列表：" + obj.def.length);
        console.log("获取的清晰度列表：" + obj.def);

        obj = MGC_Comm.strToJson(obj);
        // obj.def=[0,1,2,3];
        //系统默认为最高清晰度
        var definition = MGCData.showRoomDefinition;
        if(obj.def.length == 1){
            showRoomDefinition = {
                0: '流畅'
            };
        } else if (obj.def.length == 2) {
            showRoomDefinition = {
                0: '流畅',
                1: '标准',
            };
            // definition=1;
        }else if (obj.def.length == 3) {
            showRoomDefinition = {
                2: '高清',
                1: '标准',
                0: '流畅'
            };
            // definition=2;
        }
        else {
            showRoomDefinition = {
                3: '超清',
                2: '高清',
                1: '标准',
                0: '流畅'
            };
            // definition=3;
        }

        var tempObj = {};
        tempObj.liHtml = "";
        $m.each(obj.def, function(k, v) {
            var _tempClass = '';
            if (v == definition) {
                _tempClass = 'current';
                tempObj.defaultDefinition = showRoomDefinition[v];
            }
            tempObj.liHtml = '<li class="' + _tempClass + '" definition="' + v + '">' + showRoomDefinition[v] + '</li>' + tempObj.liHtml;
        });
        var definitionCom = $m('#definitionTmpl');
        var definitionTmpl;
        var definitionContainer = $m('#definitionContainer');
        definitionContainer.children().remove();
        definitionTmpl = definitionCom.tmpl(tempObj);
        definitionTmpl.appendTo(definitionContainer);
        if(obj.def.length == 1){
            definitionContainer.find("ul").addClass("onlyOne");
        } else if(obj.def.length == 2){
            definitionContainer.find("ul").addClass("two");
        } else if(obj.def.length == 3){
            definitionContainer.find("ul").addClass("three");
        } else{
            definitionContainer.find("ul").addClass("four");
        }
        //切换效果
        MGC_ACTION.mvQuality();
        definitionTmpl = null;
        definitionCom = null;
    },

    //更改视频的质量
    ChangeDefinitionCallBack: function(obj, definition) {
        console.log("更改清晰度返回：" + obj);
        obj = MGC_Comm.strToJson(obj);
        if (obj.res) { //切换成功
            $m(".mvc_quality").find("b").html(showRoomDefinition[definition]);
            MGCData.showRoomDefinition = definition;
            $m('.mvc_quality').find("li").removeClass();//.eq(MGCData.showRoomDefinition).addClass("current");
            $m('.mvc_quality').find("li[definition=" + definition + "]").addClass("current");
        } else {
            MGC_Comm.CommonDialog({
                "Title": "提示",
                "Note": "很抱歉，切换失败，请重试。"
            });
        }
    },

    //获得演唱会购票地址
    GetTicketUrlCallBack: function(obj, type) {
        console.log("获得演唱会购票地址" + obj);
        obj = MGC_Comm.strToJson(obj);
        if (type == 1) {
            //无门票
            $m('#buyTicket').attr('href', obj.ticketurl);
            $m('#buyTicket').attr('target', '_blank');
            $m('.mvc_tips').show();
            //$m('.video_pic').find('img').attr('src', obj.picurl|| mgc_bg_default);
            //$m('.video_pic').show();
            $m('#definitionContainer').hide();
            $m('.md_tp').hide();
            //超级粉丝不显示
            hasTicket = 0;
        } else if (type == 2) {
            //未开播
            //var picImg = obj.picurl == "" ? ShowRoomImgPath : obj.picurl;
            //$m('.video_pic').find('img').attr('src', picImg || mgc_bg_default);
            mgc.adVideoModel.setBg(ShowRoomImgPath);
            if (obj.picurl != "") {
                var picImg = obj.picurl;
                var picList = [];
                if (picImg.indexOf(",") != -1) {
                    picList = picImg.split(",");
                } else {
                    picList = [picImg];
                }
                mgc.adVideoModel.setBgList(picList);
            }
            $m('.video_pic').show();
        } else if (type == 3) { //关闭按钮要加回调
            MGC_Comm.CommonDialog({
                "Title": "提示",
                "Note": '对不起，拥有门票才可以进入本房间',
                "BtnName": "去买票",
                "BtnName2": "关闭",
                "BtnNum": 2,
                "url": obj.ticketurl
            }, null, MGC_ACTION.closeRefresh);
        }
    },

    //抽奖回调
    showRoomGiftCallBack: function(obj, refresh) {
        //obj = '{"countdown":0,"result":[{"reward_desc":"jiangp","get_reward_time":0,"nick":"vc1","zone_name":"web大区","player_id":"7810931100263057","vip_level":0,"gender":0}],"state":3,"rwds":[],"op_type":167}';
        console.log("抽奖展示的回调信息：" + JSON.stringify(obj));
        obj = MGC_Comm.strToJson(obj);
        /**
         *  RS_EndRaffle:int =0;  //抽奖结束
         *  RS_ShowReward:int = 1; //展示奖品
         *  RS_Raffling:int = 2;   //正在抽奖
         *  RS_ShowResult:int = 3; //展示结果
         *  RS_TakenRaffle:int =4;//已经抽过
         *
         */
        if (obj.state == 0) {
            MGC_Comm.CommonDialog({
                "Title": "提示",
                "Note": "很抱歉，抽奖已结束。"
            });
        } else if (obj.state == 1 || obj.state == 2) {
            //展示奖品
            var showLeftTimeNew = 0;
            var drawLeftTimeNew = 0;
            if (obj.state == 1 && obj.countdown > 0) {
                showLeftTimeNew = obj.countdown;
            } else if (obj.state == 2 && obj.countdown > 0) {
                drawLeftTimeNew = obj.countdown;
            }
            $m.each(obj.rwds, function(k, v) {
                if (v.pic_url == '') {
                    v.pic_url = defaultGiftImg;
                }
            });
            obj.rwds[obj.rwds.length - 1].pic_url = emptyImg;
            var giftShowCon = $m('#giftShowTmpl');
            var giftShowTmpl;
            var giftShowContainer = $m('#giftShowContainer');
            giftShowContainer.children().remove();
            giftShowTmpl = giftShowCon.tmpl(obj);
            giftShowTmpl.appendTo(giftShowContainer);
            window.mgc.popmanager.commonPop45($m("#giftShowContainer"), 4, 1, 1);
            console.log('showLeftTimeNew:' + showLeftTimeNew + ",drawLeftTimeNew:" + drawLeftTimeNew);
            if (showLeftTimeNew > 0) {
                var _tmpShowLeftTimeNew = showLeftTimeNew - 1;
                //开始倒计时
                MGC.progressTimeMulti('giftWait', _tmpShowLeftTimeNew);
                $m('#giftWait').show();
                setTimeout(function() {
                    $m('#giftWait').hide();
                    $m('#giftStart').show();
                    $m('#giftStart').off('click').on('click', function() {
                        MGC_CommRequest.showRoomGift(2);
                    });
                }, _tmpShowLeftTimeNew * 1000);
            } else {
                $m('#giftStart').show();
                //调用yao-倒计时 时间：giftHideContainer
                MGC.progressTimeMulti('drawLeft', drawLeftTimeNew);
                if (refresh == 2) {
                    //展示抽奖页面
                    var _giftHideLi = '';
                    $m.each(obj.rwds, function(k, v) {
                        _giftHideLi += '<li><img src="http://ossweb-img.qq.com/images/mgc/css_img/video_room/auto_unchecked.jpg?v=3_8_8_2016_15_4_final_3" class="giftClick" width="100"  height="100"><p></p></li>';
                    });
                    $m('#giftHideContainer').find('ul').html(_giftHideLi);
                    //绑定抽奖事件
                    $m('.giftClick').off('click').on('click', function() {
                        MGC_CommRequest.giftLucky();
                    });
                    window.mgc.popmanager.commonPop45($m("#giftHideContainer"), 4, 1, 1);
                } else {
                    $m('#giftStart').off('click').on('click', function() {
                        //展示抽奖页面
                        var _giftHideLi = '';
                        $m.each(obj.rwds, function(k, v) {
                            _giftHideLi += '<li><img src="http://ossweb-img.qq.com/images/mgc/css_img/video_room/auto_unchecked.jpg?v=3_8_8_2016_15_4_final_3" class="giftClick" width="100"  height="100"><p></p></li>';
                        });
                        $m('#giftHideContainer').find('ul').html(_giftHideLi);
                        //绑定抽奖事件
                        $m('.giftClick').off('click').on('click', function() {
                            MGC_CommRequest.giftLucky();
                        });
                        window.mgc.popmanager.commonPop45($m("#giftHideContainer"), 4, 1, 1);
                    });
                }
            }
            giftShowTmpl = null;
            giftShowCon = null;
        } else if (obj.state == 3 || obj.state == 4) {
            //展示结果
            var _giftResultInfo = obj.result;
            var myId = obj.playerid;
            var myInfo = new Array();
            var unsetK = -1;
            $m.each(_giftResultInfo, function(k, v) {
                v.sexInfo = v.gender == 0 ? "女" : "男";
                v.zoneName = v.zone_name == '梦工厂' ? v.zone_name : '炫舞-' + v.zone_name;
                //v.zoneName = v.zone_name; //要更改todo
                v.color = v.player_id == myId ? 'red' : '';
                if (v.player_id == myId) {
                    myInfo.push(v);
                    unsetK = k;
                }
                if (v.vip_level == 0) {
                    v.vipClass = "icon_honor";
                } else {
                    v.vipClass = "icon_honor icon_honor" + v.vip_level;
                }
            });
            if (typeof (myInfo[0]) != 'undefined') {
                _giftResultInfo.splice(unsetK, 1);
                _giftResultInfo.unshift(myInfo[0]);
            }
            var giftResultCon = $m('#giftResultTmpl');
            var giftResultTmpl;
            var giftResultContainer = $m('#giftResultContainer');
            giftResultContainer.children().remove();
            giftResultTmpl = giftResultCon.tmpl(_giftResultInfo);
            giftResultTmpl.appendTo(giftResultContainer);
            if (refresh != 1) {
                window.mgc.popmanager.commonPop45($m("#giftResultPop"), 4, 1, 1);
            }
            giftResultTmpl = null;
            giftResultCon = null;
        }
    },

    //个人抽奖回调
    giftLuckyCallBack: function(obj) {
        console.log("抽奖回调信息：" + JSON.stringify(obj));
        obj = MGC_Comm.strToJson(obj);
        $m('.md_cj_i').hide();
        if (obj.res != 0) {
            var msg = "";
            if (obj.res == 1) {
                msg = '您已经抽过奖了';
            } else if (obj.res == 2) {
                msg = '对不起，抽奖阶段已结束';
            } else {
                msg = '未知错误';
            }
            //确认，这里怎么展示todo
            MGC_Comm.CommonDialog({
                "Title": "提示",
                "Note": msg
            });
        } else if (obj.is_lucky) {
            //中奖了
            var _giftInfo = obj.reward;
            var pic = _giftInfo.pic_url == "" ? defaultGiftImg : _giftInfo.pic_url;
            $m('#getGiftLi').find('img').attr('src', pic);
            $m('#getGiftLi').find('p').text(_giftInfo.desc);
            window.mgc.popmanager.commonPop45($m("#getGift"), 4, 1, 1);
        } else {
            window.mgc.popmanager.commonPop45($m("#noGift"), 4, 1, 1);
        }
    },

    //禁言通知--对操作的反馈
    forbiddenCallBack: function(obj) {
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

    //是否关注的主播
    isFollowAnchorCallBack: function(obj) {
        console.log('ddddddddddddddddddd' + obj);
        obj = MGC_Comm.strToJson(obj);
        if (obj.res) {
            MGCData.difFollowAnchor[MGCData.isAnchorOrRoom].followAnchor = 1;
            //关注了
            $m('.si_attention').text('取消关注');
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
            MGC_ACTION.refreshFollowInfo('add', anchor_id);
            /*var msg = "恭喜您，成功关注该主播";*/
        }
        if (msg != '') {
            alert(msg);
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
        obj = MGC_Comm.strToJson(obj);
        var msg = "";
        switch (obj.res) {
            
			case 0:
			    msg = '恭喜你，取消关注成功';
				break;
			case 2:
				msg = '取消关注主播失败，未找到该主播';
				break;
		
            default:
            //msg = '取消关注主播失败，未知错误。';
                break;
        }
        if (obj.res == 0) {
            MGCData.difFollowAnchor[MGCData.isAnchorOrRoom].followAnchor = 0;
            MGC_ACTION.refreshFollowInfo('cancel', anchor_id);
        }
        if (msg != '') {
          //  alert(msg);
        }
    },

    //查询宝箱数据
    getBoxGiftCallBack: function(obj) {
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

            if (Qgame == true) {
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
            var boxGiftContainer = $m('#boxGiftContainer');
            boxGiftContainer.children().remove();
            boxGiftTmpl = boxGiftCon.tmpl(obj);
            boxGiftTmpl.appendTo(boxGiftContainer);
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
                            popInfo.showTips_game = "（获得的游戏道具会直接进入游戏背包）";
                        }else{
                            popInfo.showTips_game = "（获得的游戏道具以邮件发放到电脑端）";
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

    //展示主播名片
    showAnchorCardCallBack: function(obj) {
        //console.log("从服务器获得的主播名片：" + obj);
        obj = MGC_Comm.strToJson(obj);
        if (obj.succ) {
            var _anchorInfo = {};
            //主播id
            _anchorInfo.anchorId = obj.data.basicData.anchorID;
            //是否关注 
            _anchorInfo.follow = !obj.isFollow ? "+ 关注" : "- 取消关注";
            _anchorInfo.isFollow = obj.isFollow ? 1 : 0;
            //照片
            _anchorInfo.imageUrl = obj.data.basicData.imageUrl;
            //照片2
            _anchorInfo.photoUrl = obj.data.basicData.photoUrl;
            //主播名
            _anchorInfo.name = obj.data.basicData.name;
            //籍贯
            _anchorInfo.from = obj.data.basicData.from;
            //积分
            _anchorInfo.anchor_score = obj.data.basicData.anchor_score;
            //人气
            _anchorInfo.popularity = obj.data.basicData.popularity;
            //星耀
            _anchorInfo.starlight = obj.data.basicData.starlight;
            //守护数量
            _anchorInfo.total_guard_cnt = obj.data.total_guard_cnt;
            //后援团数量
            _anchorInfo.vg_cnt = obj.data.vg_cnt;
            //个人简介
            _anchorInfo.intro = obj.data.basicData.intro; //这里重构设计有问题，接口是否会有换行符号发给我？
            //观众数量
            _anchorInfo.followedAudiences = obj.data.basicData.followedAudiences;
            //添加了印象的观众数
            _anchorInfo.m_player_count = obj.data.basicData.m_impression_data.m_player_count;
            //印象展示
            var _impression = obj.data.basicData.m_impression_data.m_impressions;
            var _m_total_count = obj.data.basicData.m_impression_data.m_total_count;
            _anchorInfo.impression = '';
            if (_impression.length < 5) {
                _anchorInfo.impression = "<span>ta的印象还不足5种哦</span>";
            } else {
                var _m_show_count = 0;
                var temp_percent = 0;
                $m.each(_impression, function(k, v) {
                    var _tmp = k + 1;
                    _m_show_count += v.m_count;
                    if (k < 5) {
                        var _percent = Math.floor(v.m_count*100 / _m_total_count);
                        temp_percent += _percent;
                        _anchorInfo.impression += "<span class='keywords0" + _tmp + "'>" + _percent+ '%' + "<strong>" + MGC_ANCHORIMPRESSION[v.m_impression_id] + "</strong></span>"; //todo，改成比例以及印象中文
                    }
                });
                temp_percent = 100 - temp_percent;
                _anchorInfo.impression += "<span class='keywords06'>" + temp_percent+ '%'  + "<strong>其他</strong></span>";
            }
            //我的守护信息
            var next_guard_level = obj.data.next_guard_level; //下一守护级别 VIDEO_GUARD_LEVEL_INVALID表示没有
            var next_guard_name = obj.data.next_guard_name;
            var affinity_need = obj.data.affinity_need; //到下一守护级别还需要多少亲密度
            var current_guard_level = obj.data.current_guard_level; //正在查看主播名片的玩家和这个主播的亲密度
            var current_guard_name = obj.data.current_guard_name; //正在查看主播名片的玩家和这个主播的亲密度
            if (current_guard_level < 1) {
                _anchorInfo.tips = "很抱歉，您还不是Ta的守护。再获得<strong>" + affinity_need + "</strong>亲密度，就可以成为Ta的<strong>" + next_guard_name + "</strong>。"
            } else if (next_guard_level == 0) {
                _anchorInfo.tips = "您是Ta的" + current_guard_name + "。"
            } else {
                _anchorInfo.tips = "您是Ta的" + current_guard_name + "。再获得<strong>" + affinity_need + "</strong>亲密度，就可以成为Ta的<strong>" + next_guard_name + "</strong>。"
            }
            //守护规则url
            _anchorInfo.guardRuleUrl = obj.guardRuleUrl;
            //粉丝排名
            var fans = obj.data.fans;
            var _anchorFans = new Array;
            $m.each(fans, function(k, v) {
                var _tmpObj = {};
                _tmpObj.name = v.name;
                _tmpObj.qinmidu = v.affinity;
                _tmpObj.zoneName = v.zoneName;
                _tmpObj.guardLevel = v.guardLevel;
                _tmpObj.guard_levelShow = '';
                if (_tmpObj.guardLevel > 0) {
                    _tmpObj.guard_levelShow = guardLevelTab[_tmpObj.guardLevel];
                }
                _tmpObj.viplevel = v.viplevel;
                _tmpObj.viplevelName = '';
                if (_tmpObj.viplevel > 0) {
                	_tmpObj.viplevelName = vipLevelTab[_tmpObj.viplevel];
                }
                _tmpObj.nickColor = v.nickColor;
                _tmpObj.psid = v.psid;
                _anchorFans.push(_tmpObj);
            });

            //弹框-粉丝列表
            var fansCardCon = $m('#fansCardTmpl');
            var fansCardTmpl;
            var fansCardContainer = $m('#fansCardContainer');
            fansCardContainer.children().remove();
            fansCardTmpl = fansCardCon.tmpl(_anchorFans);
            fansCardTmpl.appendTo(fansCardContainer);
            //绑定粉丝列表的弹框
            $m('.icon_message').off('click').on('click', function() {
                card_source = 7;
                var _id = $m(this).attr('id');
                MGC_CommRequest.getFansCardInfo(_id, card_source);
            });
            //弹框-基本信息
            var anchorTip1Con = $m('#anchorTip1Tmpl');
            var anchorTip1Tmpl;
            var anchorTip1Container = $m('#anchorTip1Container');
            anchorTip1Container.children().remove();
            anchorTip1Tmpl = anchorTip1Con.tmpl(_anchorInfo);
            anchorTip1Tmpl.appendTo(anchorTip1Container);
            //弹框-印象
            var anchorTip2Con = $m('#anchorTip2Tmpl');
            var anchorTip2Tmpl;
            var anchorTip2Container = $m('#anchorTip2Container');
            anchorTip2Container.children().remove();
            anchorTip2Tmpl = anchorTip2Con.tmpl(_anchorInfo);
            anchorTip2Tmpl.appendTo(anchorTip2Container);
            $m('.addimpress').off('click').on('click', function() {
                //请求我的印象数据
                var thisAnchorId = $m(this).attr('anchorId');
                MGC_CommRequest.myImpressionInfo(thisAnchorId);
                MGC_CommRequest.allImpressionInfo(thisAnchorId);
            });
            //绑定名片中的关注
            $m('.btn_care').off('click').on('click', function() {
                var isFollow = $m(this).attr('isFollow');
                var name = $m(this).attr('name');
                var anchorId = $m(this).attr('anchorId');
                MGC_CommRequest.followAnchorAction(1, anchorId, name, isFollow);
            });
            //弹框-主播名片
            window.mgc.popmanager.layerControlShow($m("#pop3"), 4, 1);
            $m('#pop3').off('click').on('click', function() {
                window.mgc.popmanager.layerControlHide($m("#pop3"), 4, 1);
            });
            fansCardTmpl = null;
            fansCardCon = null;
            anchorTip1Tmpl = null;
            anchorTip1Con = null;
            anchorTip2Tmpl = null;
            anchorTip2Con = null;
        }
    },

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

    //获取大区
    showRoomGetAsCacheCallBack: function(obj) {
        obj = MGC_Comm.strToJson(obj);
        if (obj.hasCookie == true) {
            MGC_ACTION.addWatchedSum(obj.zoneid);
        }
    },
    allImpressionInfoCallBack: function(obj, anchorId) {
        $m.each(obj.impression, function(k, v) {
            MGC_ANCHORIMPRESSION[v.impressionID] = v.impressionName;
        });
        MGC_CommRequest.myImpressionInfo(anchorId);
    },
    WatchedSumCallBack: function(obj) {
        console.log("累计人数：" + obj.num);
        obj.num = mgc.tools.showRoomNumFormat(obj.num);
        $m('#watch_total_num').text(obj.num);
    }
};

$m.extend(MGC_CommRequest, MGC_SpecialRequest);
$m.extend(MGC_CommResponse, MGC_SpecialResponse);

var MGC_Response = function(callback_obj) {
    var _op_type = callback_obj.op_type;
    switch (parseInt(_op_type)) {
        //case 205:
        //    canInvite = callback_obj.canInvite;
        //    break;        
        case 29:
            MGC_CommResponse.refreshAnchor(callback_obj);
            break;
        case 30:
            MGC_CommResponse.refreshRoom(callback_obj);
            break;
        //case 71:
        //    MGC_Comm.backupInvitationBoxPopUp(callback_obj);
        //    break;
        //case 73:
        //    MGC_Comm.backupInvitationCallBack(callback_obj);
        //    break;
        case 28:
            if (callback_obj.fanstype == 0) {
                MGC_CommResponse.getFans(callback_obj); //超级粉丝
            } else if (callback_obj.fanstype == 1) {
                //守护
            }
            break;
        // 演唱会在线人数
        // case 33:
        //     console.log("在线人数：" + callback_obj + " : " + callback_obj.count);
        //     MGC_CommResponse.refreshOnlineNums(callback_obj);
        //     break;
        case 17:
            //获取宝箱数据
            MGC_CommResponse.getHotBoxCallBack(callback_obj);
            break;
        case 34:
            //房间热度
            MGC_CommResponse.houseHot(callback_obj);
            break;
        case 142:
            //获得了宝箱
            MGC_CommResponse.getBoxGiftActionCallBack(callback_obj);
            break;
        case 155: //主播开启宝箱啦，需要播放动画效果x
            MGC_Comm.log("主播开启宝箱通知JSON：" + JSON.stringify(callback_obj));
            $m.each(callback_obj, function(k, v) {

            });
            break;
        case 35: //通知房间的状态
            MGC_Comm.log("房间状态通知：" + JSON.stringify(callback_obj));
            MGCData.roomStatus = callback_obj.status;
            if (callback_obj.status == 2) {
                //直播中，获取可选的清晰度
                MGC_CommRequest.SelectDefinition();
                isLiveOpen = true;
                //有门票
                if (callback_obj.isHasTicket) {
                    $m('.video_pic').hide();
                    //视频区广告停止轮播
                    mgc.adVideoModel.stopChange();
                    $m('.md_tp').show();
                }

                //礼物启用
                if (hasTicket == 0) {
                    FreeGift.setEnabled(false);
                }
                else {
                    FreeGift.setEnabled(true);
                }
                $m(".mvc_quality").show();
            } else {

                //没有直播，不需要热度加速按钮
                $m('#addHotContainer').hide();
                //房间热度归0
                MGCData.curHeight = 0;
                //热度条隐藏
                $m('#boxHotContainer').find('*').hide();
                //没有直播，不需要任务
                $m('#anchorTask').hide();

                MGC_CommRequest.GetTicketUrl(2);
                isLiveOpen = false;

                //礼物禁用
                FreeGift.setEnabled(false);

                $m(".mvc_quality").hide();
            }
            break;
        case 36:
            FreeGift.responseGiftMessage(callback_obj);
            break;
        //其他免费礼物
        case 196:
            FreeGift.responseOtherFreeGift(callback_obj);
            break;
        //免费礼物配置
        case 197:
            FreeGift.responseInitFreeGift(callback_obj);
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
        //case 42:
        //    if(callback_obj.vip_level >=3)
        //    {
        //        MGC_Comm.nobleSwfInit(callback_obj.vip_level,callback_obj.player_name,callback_obj.player_zone);
        //    }
        //    break;
        // case 46:
        //     MGC_CommResponse.PushTalk(callback_obj);
        //     //主播经验效果
        //     if(callback_obj.msg.add_anchor_exp > 0)
        //     {
        //         MGC_Comm.addExpEffect(callback_obj.msg.add_anchor_exp);
        //     }
        //     break;
        case 52:
            MGC_CommResponse.LiveVideoStart(callback_obj);
            break;
        case 53:
            MGC_CommResponse.LiveVideoStop(callback_obj);
            break;
        case 169: //新任务通知
            console.log("新任务通知：" + callback_obj);
            newTask = 1;
            break;
        case 166: //刷新任务
            console.log("刷新任务" + callback_obj);
            MGC_CommResponse.refreshTask(callback_obj);
            break;
        case 131: //有新的投票
            console.log("新的投票" + JSON.stringify(callback_obj));
            if (hasTicket == 1 && isLiveOpen) {
                $m('.md_tp').show();
                if (callback_obj.res == 1) {
                    MGC_CommRequest.getVoteInfo(true);
                } else {
                    //查看当前玩家是否已经投票
                    MGC_CommRequest.checkMyVoteInfo();
                }
            }
            break;
        case 256://刷新我对当前主播贡献的经验值已经当日上限
            MGC_CommResponse.giftAddexp(callback_obj);
            break;
        case 157: //房间状态改变
            console.log("获得的房间状态" + JSON.stringify(callback_obj));
            isOpen = callback_obj.is_open;
            if (callback_obj.is_open) {
                if (callback_obj.hasticket) {
                    //演唱会开启+有票
                    MGC_CommRequest.showRoomGetAsCache();
                    $m('.video_pic').hide();
                } else {
                    MGC_CommRequest.GetTicketUrl(2);
                }
            } else {
                //关闭
                //$m('.video_pic').find('img').attr('src', ShowRoomImgPath || mgc_bg_default);
                mgc.adVideoModel.setBg(ShowRoomImgPath || mgc_bg_default);
                $m('.video_pic').show();
            }
            break;
        case 158: //正在播放的清晰度
            console.log("播放的清晰度" + callback_obj);
            // MGC_CommRequest.ChangeDefinition(2);
            MGCData.showRoomDefinition = callback_obj.definition;
            // MGC_CommRequest.ChangeDefinition(MGCData.showRoomDefinition);
            MGC_CommRequest.SelectDefinition();
            break;
        case 163: //抽奖的通知showLeftTime
            console.log("163主动推送抽奖的通知" + JSON.stringify(callback_obj));
            if (hasTicket == 1 && isLiveOpen) {
                if (callback_obj.state == 1) { //展示奖品
                    //抽奖--
                    showLeftTime = callback_obj.countdown;
                    var timer = null;
                    timer = setInterval(function() {
                        if (showLeftTime > 0) {
                            --showLeftTime;
                        } else {
                            clearInterval(timer);
                            return false;
                        }
                    }, 1000);
                    if ($m('.md_cj').is(':hidden')) {
                        $m('.md_cj').show();
                    }
                    $m('.md_cj').off('click').on('click', function() {
                        MGC_CommRequest.showRoomGift();
                    });
                } else if (callback_obj.state == 2) { //正在抽奖
                    mgc.tools.initSwf("md_cj_i_swf", "md_cj_i_swf", "/assets/icon_choujiang.swf?v=3_8_8_2016_15_4_final_3");
                    $m('.md_cj_i').show();
                    $m('.md_cj').show();
                    $m('.md_cj').off('click').on('click', function() {
                        MGC_CommRequest.showRoomGift();
                    });
                    //抽奖剩余的时间
                    drawLeftTime = callback_obj.countdown;
                    var timer = null;
                    timer = setInterval(function() {
                        if (drawLeftTime > 0) {
                            --drawLeftTime;
                        } else {
                            clearInterval(timer);
                            return false;
                        }
                    }, 1000);
                } else if (callback_obj.state == 3 || callback_obj.state == 4) { //是否强制弹出
                    if ($m('.md_cj').is(':hidden')) {
                        $m('.md_cj').show();
                    }
                    $m('.md_cj_i').hide();
                    $m('.md_cj').off('click').on('click', function() {
                        MGC_CommRequest.showRoomGift();
                    });
                    //之前的弹框是否关闭
                    var giftShowContainer = $m('#giftShowContainer').css('display');
                    var giftHideContainer = $m('#giftHideContainer').css('display');
                    if (giftShowContainer == 'block' || giftHideContainer == 'block') {
                        window.mgc.popmanager.commonPop45($m("#giftResultPop"), 4, 1, 1);
                    }
                } else if (callback_obj.state == 0) {
                    $m('.md_cj').hide();
                }
            }
            break;
        case 175:
            console.log("分流通知：" + JSON.stringify(callback_obj));
            var _roomInfo = callback_obj.rooms;
            $m.each(_roomInfo, function(k, v) {
                v.roomUrl = v.bSuperRoom ? showRoomUrl + "?roomId=" + v.roomID : liveRoomUrl + "?roomId=" + v.roomID;
                v.roomLogoUrl = v.roomLogoUrl == "" ? RoomDefaultImg : v.roomLogoUrl;
                v.anchor_level_temp = Math.floor(v.anchor_level / 10) + 1;
                if (v.anchor_level == 0) {
                    v.anchor_level_temp = 0;
                }
                if (v.anchor_badge == null) {
                	v.anchor_badge = 0;
                }
                v.playerCount = mgc.tools.roomListNumFormat(v.playerCount);
            });
            var fenliuCon = $m('#fenliuTmpl');
            var fenliuTmpl;
            var fenliuContainer = $m('#fenliuContainer');
            fenliuContainer.children().remove();
            fenliuTmpl = fenliuCon.tmpl(_roomInfo);
            fenliuTmpl.appendTo(fenliuContainer);
           
            //js出现mic
            fenliuContainer.find("li").hover(function() {
                $m(this).css("border-color", "#6a41c6").find(".room-cover").show();
            }, function() {
                $m(this).css("border-color", "#f5f5f5").find(".room-cover").hide();
            });
            showDialog.hide();
            showDialog.show('fenliuDiv'); 
            var imgs = $("#fenliuContainer .room-img img");
            for(var i=0,n=imgs.length; i<n; i++){
                var img = new Image();
                img.src = imgs[i].src;
                img._img = imgs[i];
                if(img.complete){
                    mgc.tools.adjustPics(img);
                } else{
                    img.onload = function(e){
                        mgc.tools.adjustPics(e == undefined ? this : e.target);
                    }
                }
            }
            fenliuTmpl = null;
            fenliuCon = null;
            break;
        case 180:
            console.log("是否需要新手指引：" + JSON.stringify(callback_obj));
            if (!callback_obj.need) {
                //执行新手教学
                MGC_ACTION.study();
            }
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
        case 178://房间断线时res为false
            if (!callback_obj.res) {
                //alert("断线");
                $m(".mvc_quality").hide();
            }
            break;        
        case 195:
            //完成在线好礼任务
            MGC_CommResponse.CompleteOnlineTask(callback_obj);
            break;
        case 47:
            MGC_Comm.log("被踢出：" + JSON.stringify(callback_obj));
            //$m('.video_pic').find('img').attr('src', ShowRoomWatingImgPath || mgc_bg_default);
            mgc.adVideoModel.setBg(ShowRoomWatingImgPath || mgc_bg_default);
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
                    if (callback_obj.device_type != mgc.tools.pageSource().device_type ) {
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
        case 188://累计在线人数拉取
            MGC_CommResponse.WatchedSumCallBack(callback_obj);
            break;
        case 185:
            MGC_CommResponse.goodFriendPayCallBack(callback_obj);
            break;
        //主动下发清晰度
        case 160:
            MGC_CommResponse.SelectDefinitionCallBack(callback_obj);
            break;

        //下发广告配置
        case 315:
            //视频区广告
            var list = callback_obj.ad.background_video_ad;
            if(list.length != 0)
            {
                mgc.adVideoModel.setUrl(list[0].pic_link);
            }

            //粉丝区广告
            var list = callback_obj.ad.fixed_video_ad;
            var server_time = callback_obj.server_time;
            $m.each(list,function(k,v){
                v.src = v.pic_link;
                v.link = v.jump_link;
                v.startTime = v.begin_time - server_time;
                v.endTime = v.end_Time - server_time;
            });
            mgc.adModel.setADList(list);
            if(list.length > 0)
            {
                mgc.adView.$el.show();
            }
            break;

        default:
            break;
    }
};

var MGC_ACTION = {

    //弹出玩家名片
    popPlayerDetailCard: function(playerInfo) {
        $m.each(playerInfo.followed_anchors, function(k, v) {
            v.anchorStatus = v.anchor_status == 2 ? "直播中" : "离线";
            v.cardLevelShowTips = '';
            if (v.guardlevel > 0) {
                v.cardLevelShowTips = guardLevelTab[v.guardlevel];
            }
        });
        if (parseInt(playerInfo._levelPer) < 4) {
            playerInfo._levelPer = '4%';
        }
        showDialog.hide();
        var cardInfoCon = $m('#cardInfoTmpl');
        var cardInfoTmpl;
        var cardInfoContainer = $m('#cardInfoContainer');
        cardInfoContainer.removeClass().addClass('pop_card ' + playerInfo._vipClass);
        cardInfoContainer.children().remove();
        cardInfoTmpl = cardInfoCon.tmpl(playerInfo);
        cardInfoTmpl.appendTo(cardInfoContainer);
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
        cardInfoTmpl = null;
        cardInfoCon = null;
    },

    //切换视频质量
    mvQuality: function() {
        var mvQuality = $m(".mvc_quality"),
            start = true;
        mvQuality.find("b").click(function() {
            if (start) {
                mvQuality.find("ul").show();
                start = false;
            } else {
                mvQuality.find("ul").hide();
                start = true;
            }
        });
        mvQuality.find("li").each(function(index) {
            $m(this).click(function() {
                var this_html = $m(this).html();
                var _definition = $m(this).attr('definition');
                mvQuality.find("li").removeClass();//.eq(index).addClass("current");
                mvQuality.find("li[definition=" + _definition + "]").addClass("current");
                //成功了再设置 --todo 暂时先不处理
                mvQuality.find("b").html(this_html);
                mvQuality.find("ul").hide();
                start = true;
                if (_definition == 0 || _definition == 1 || _definition == 2|| _definition == 3) {
                    MGC_CommRequest.ChangeDefinition(_definition);
                }
            });
        });
        var mvQualityTime; //move延时器
        mvQuality.off("mouseover,mouseout").on("mouseover", function(){
            clearTimeout(mvQualityTime);        
        }).on("mouseout", function(){
            mvQualityTime = setTimeout(function() {
                mvQuality.find("ul").hide();
                start = true;
            }, 200);
        });
    },

    //关闭弹框，回首页
    closeRefresh: function(recommend) {
        showDialog.hide();
        if (recommend) {
            window.location.href = window.mgc.tools.changeUrlToLivearea(entertainmentRoom);
        } else {
            window.location.href = window.mgc.tools.changeUrlToLivearea(home);
        }
    },

    //新手学习
    study: function() {
        if (MGC_Comm.CheckGuestStatus(true)) {
            console.log("屏蔽游客操作：新手学习");
            return false;//游客身份下，屏蔽此操作
        }
        $m('.layer-gifts .study1').show();
        $m('.layer-gifts .study1_close').on('click', function () {
            MGC_CommRequest.setStudy();
            $m('.layer-gifts .study1').hide();
            $m('.layer-chat .study2').show();
        });
        $m('.layer-chat .study2_close').on('click', function () {
            $m('.layer-chat .study2').hide();
            $m('.layer-gifts .study3').show();
        });
        $m('.layer-gifts .study3_close').on('click', function () {
            $m('.layer-gifts .study3').hide();
        });
    },

    //刷新我的关注信息
    refreshFollowInfo: function(type, anchor_id) {
        var fansNum = parseInt($m('.si_fans_num').text()); //页面的
        var fansCardNum = parseInt($m('.fans').text()); //card面板里面的
        if (type == 'add') {
            //关注--面板里面的肯定要变
            $m('.btn_care').text('-取消关注');
            ++fansCardNum;
            $m('.fans').text(fansCardNum);
            $m('.btn_care').attr('isFollow', 1);
            if (anchor_id == MGCData.anchorID) {
                $m('.si_attention').text('取消关注');
                $m('.sus_tips_').text('取消关注，点击后取消关注，恢复为关注Ta');
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
                $m('.sus_tips_').text('关注TA,主播直播时可收到通知')
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

    //查看累计观看人数 废弃
    checkWatchedSum: function() {
        //var concertId = parseInt(MGC_Comm.getUrlParam('roomId'));
        //var _url = "http://apps.game.qq.com/mgc/ConertTotal/MGC_Query.php?concertId=" + concertId;
        //fn.loadjs(_url, function() {
        //    if (typeof(MGC_Query_RES) != 'undefined' && MGC_Query_RES.ret_code == 0) {

        //        var _tempNum = MGC_Query_RES.msg.toString(),
        //            total = 6,
        //            _tempZer0 = '';
        //        var _tempLen = _tempNum.length;
        //        if (_tempLen < total) {
        //            for (var i = _tempLen; i < total; i++) {
        //                _tempZer0 += '0';
        //            }
        //        }
        //        _tempNum = _tempZer0 + _tempNum;
        //        for (var j = 1; j <= total; j++) {
        //            var _temp = _tempNum.substr(-j, 1);
        //            $m('#watch_' + j).text(_temp);
        //        }
        //    }
        //});
    },

    //增加累计观看人数 废弃
    addWatchedSum: function(areaId) {
        //var uin = MGC_Comm.getUin();
        //var concertId = parseInt(MGC_Comm.getUrlParam('roomId'));
        ////操作cookie
        //var cookieName = "mgc_addWatch_" + uin + "_" + concertId + "_" + areaId;
        //var isAdd = MGC_Comm.getCookie(cookieName);
        //if (isAdd == null) {
        //    var _url = "http://apps.game.qq.com/mgc/ConertTotal/MGC_Total.php?uin=" + uin + "&areaId=" + areaId + "&concertId=" + concertId;
        //    fn.loadjs(_url, function() {
        //        if (typeof(MGC_Total_RES) != 'undefined' && MGC_Total_RES.ret_code == 0) {
        //            $m.cookie(cookieName, 1, {
        //                expires: 60 * 24 * 5,
        //                path: '/'
        //            });
        //        }
        //    });
        //}
    }
};

//热度条适配
var progressBarRize = function(){
    var width = $m(".mv_details").width() - ($m(".mv_details .md_status") != null ? $m(".mv_details .md_status").width() : 0) - $m(".mv_details .progress").width() - 40;
    var $md_links = $m(".mv_details .md_links");

    /*
    var width1 = $m(".mv_details .progress").width();
    if(width > 240)
    {
        $md_links.width(width*0.8);
        $m(".mv_details .progress").width(width1 + width*0.2);
    }
    else
    {
        $md_links.width(width);
        $m(".mv_details .progress").width(width1);
    }
    */

    //每个按钮间隔
    var gap = parseInt((width - 195)/($md_links.children().length + 1));

    $md_links.children().each(function(index){
        $m(this).css("right",(index + 1)*gap);
    });
};

MGC_CommResponse.mouseoverBadge();
MGC_CommResponse.mouseoutBadge();
var roomId;
//本页需要回调加载的功能
var loginCallBack = function() {
	//同步MGCData
    MGCData.myPlayerId = mgc.consts.MGCData.myPlayerId;
    MGCData.myVipLevel = mgc.consts.MGCData.myVipLevel;
    roomId = MGC_Comm.getUrlParam('roomId');
    MGC_ACTION.checkWatchedSum();
    //进入房间
    MGC_CommRequest.enter(roomId);
    //直播swf初始化
    MGC_Comm.LiveVideoSwfInit();

    //送礼swf初始化
    isCaveolae = "false";
    MGC_Comm.GiftSwfInit();
    $m(".m_prize").mousewheel(mousewheelFlash);

	MGC_Comm.setFlyScreenSwfObj();
}
window.mgc.roomLoginCallBack = loginCallBack;
var mousewheelFlash = function(event) {
    var delta = 0;
    event = event || window.event;
    delta = (event.originalEvent.wheelDelta) ? event.originalEvent.wheelDelta / 120 : -(event.originalEvent.detail || 0) / 3;
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
        window.scrollTo(0, getScrollTop() - delta);
    } else {
        return true;
    }
}

function showMyGiftResult() {
    MGC_CommRequest.showRoomGift();
}
var newTask = 0;
$m(function() {
    document.onclick = function() {
        var swfObj = getSWF("GiftSwf");
        swfObj.jsClick();
    };
    $j('.sr_con').jScrollPane({
        autoReinitialise: true,
        animateScroll: true,
        autoReinitialiseDelay: 100,
        verticalDragMinHeight: 44,
        callback: function() {
            $j('[class*="sus_tips_"]').hide();
        }
    });
    //重绘滚动条 
    var scrollAPI_srcon = $j('.sr_con').data('jsp');
    if(scrollAPI_srcon){    
        scrollAPI_srcon.initScroll();
    }
    $m("#progressTimeCountDown").hover(function(e) {
        MGC.susHotTitleTips(e, 1, '赠送付费礼物可增加房间热度，从而开启宝箱。活动期间有额外奖励哦！<br/>进房计时结束前，热度宝箱奖励将会暂存。倒计时结束后自动补发。');
    }, function(e) {
        MGC.susHotTitleTips(e, 0);
    });
    //任务
    $m('.md_rw').off('click').on('click', function() {
        newTask = 0;
        $m('#newTask').hide();
        window.mgc.popmanager.commonPop45($m("#popShowRoomTask"), 4, 1);

        var taskH = $m('#taskContainer').find('li').eq(0).height() + $m('#taskContainer').find('li').eq(1).height() + $m('#taskContainer').find('li').eq(2).height() + 208;
        $m('.s_prize_task').css('height', taskH + 'px');
    });
    $m('.s_prize_task,#giftResultScroll').jScrollPane({
        autoReinitialise: true,
        animateScroll: true
    }); 
    //重绘滚动条 
    var scrollAPI_prizetaskAndgift = $m('.s_prize_task,#giftResultScroll').data('jsp');
    if(scrollAPI_prizetaskAndgift){
        scrollAPI_prizetaskAndgift.initScroll();
    }
            
    MGC.popAnchor_tips(50, 5);
}); /*  |xGv00|60978f6842e0a4aafcefe32795b63260 */
