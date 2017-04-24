/**
 * Created by 77 on 2015/10/8.
 */
/**
 * Todo:1.处理直播间内公共操作
 */
define(['mgc_consts', 'mgc_tool', 'mgc_callcenter', 'mgc_room_model', 'mgc_account', 'mgc_login', 'mgc_comm', 'mgc_chat','mgc_recommend','mgc_room_view'], function(consts , tools, callcenter, mgc_room_model, mgc_account, mgc_login, mgc_comm, $chat,mgc_recommend,mgc_room_view) {
    var control = {};
    var MGC_Comm = mgc_comm.mgc_comm;
    var MGCData = mgc_comm.mgcData;
    var MGC_CommRequest = {};
    var MGC_CommResponse = {};
    var _roleListInfo=[];//存储玩家列表信息
    var _fansInfo=[];//存储超级粉丝数据
    //未开播推荐位
    var recommendModel = new mgc_recommend.RecommendModel();
    var recommendView = new mgc_recommend.RecommendView({model:recommendModel});
    $(".sl_vip").html($("#viptemp").html());
    $("#viptemp").children().remove();
    var vipListModel = new mgc_room_model.vipListModel();
    var vipListView = new mgc_room_view.vipListView({
        model: vipListModel
    });
    //临时存储弹出名片的事件，仿佛有点
    var tempEvent;
    //是否能邀请
    var canInvite;

    //初始化room
    control.init = function(resp) {
        callcenter.query_weekstar_url_config(room_callback.getWeekStarUrlCallback);
        //进入房间前处理147
        if (resp.op_type == callcenter.OP_TYPE.GET_PLAYER_INFO)
            room_callback.cardInfoCallBack(resp);
        //进入房间
        room_request.enter(tools.roomid(), false);

        //非直播，查看房间默认图片
        callcenter.addRespListener(callcenter.OP_TYPE.GET_ROOMPIC_URL,room_callback.getRoomUrlCallBack);
    };

    //监听下发========================================
    //嘉宾席27
    callcenter.addRespListener(callcenter.OP_TYPE.RECEIVE_VIP_LIST, function(resp, params) {
        room_callBack.receiveVipList(resp);
    });
    //后援团权限205
    callcenter.addRespListener(callcenter.OP_TYPE.RECEIVE_GROUP_AUTH, function(resp, params) {
        canInvite = resp.canInvite;
    });
    //非直播阶段，查看房间的默认图片
    callcenter.addRespListener(callcenter.OP_TYPE.GET_ROOMPIC_URL, function(resp, params) {
        room_callBack.getRoomUrlCallBack(resp);
    });

    //发送请求========================================
    var room_request = {
        /**
         * 进房请求
         * @param roomid : 房间id
         * @param crowd_info
         */
        enter: function(roomid, crowd_into) {
            if (roomid > 0) {
                callcenter.refresh_video_client_charinfo();
                var source = tools.getUrlParam('source');
                source = source >= 0 ? source : 0;
                callcenter.enter_room(roomid, crowd_into, source, room_callBack.enterRoomCallback);
            } else {
                window.localtion.href = tools.changeUrlToLivearea(consts.url.HOME);
            }
        },
        //获取主播、玩家、管理员信息
        getPlayerInfo: function(name, area, e) {
            if (mgc_account.checkGuestStatus()) {
                console.log("屏蔽游客操作：获取主播、玩家、管理员信息");
                return false;
                //游客身份下，屏蔽此操作
            }
            tempEvent = e;
            //过滤炫舞-  防止服务器找不到大区
            area = area.replace("炫舞-", "");
            var reqParams = {
                name: name,
                zoneName: area
            };
            callcenter.callbackStr_req("GET_MEMBER_INFO", room_callBack.getPlayerInfoCallBack, "room_callBack.getPlayerInfoCallBack", reqParams);
        },
        getRoomUrl: function(roomId) {
            callcenter.callbackStr_req("GET_ROOMPIC_URL", room_callBack.getRoomUrlCallBack, "room_callBack.getRoomUrlCallBack");
        },    
    };

    //设置免费礼物Tips显示
    var freeGifShow = function(freeGiftTime,x,y) {
        mgc_room_view.setFreeGifShow(freeGiftTime,x,y);
    };

    //设置免费礼物Tips隐藏
    var freeGifHide = function() {
        mgc_room_view.setFreeGifHide();
    };


    //请求回调
    var room_callback = {
        /**
         * 147玩家信息处理
         * @param resp
         */
        cardInfoCallBack: function(resp, params) {
            var _res = parseInt(resp.res);
            var _res = parseInt(resp.res);
            if (_res == 0) {
                var _card_info = resp.playerinfo;
                var _card_info = resp.playerinfo;
                var _vipLevel = _card_info.vip_level;
                if (_vipLevel > 0) {
                    consts.MGCData.invisible = _card_info.invisible;
                }
                consts.MGCData.myVipLevel = _vipLevel;
                consts.MGCData.myPlayerId = _card_info.pstid;
            } 
        },
        getWeekStarUrlCallback : function(resp){
            consts.MGCData.player_url = resp.player_url;
        },
        /**
         * 进房回调
         * @param resp
         */
        enterRoomCallback: function(resp, params) {
            console.log("is guset:" + mgc_account.checkGuestStatus());
            console.log("enter room! callback!");
            if (resp.ret == 0) {
                var msg = '';
                if (resp.res == 49 && resp.info.m_remain_crowdroom_count == 0) {
                    resp.res = 51;
                }
                switch (resp.res) {
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
                    case 9:
                        //房间人满了
                        msg = '房间人满，请登录后再次尝试';
                        break;
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
                    case 49:
                        //房间人满了
                        var roomId = tools.roomid();
                        msg = '房间人满。如果拥有贵族身份，或者成为当前主播的天使守护及以上，可以优先的进入人满房间哦~<br>今日剩余挤房次数：' + resp.info.m_remain_crowdroom_count;
                        break;
                        MGC_Comm.CommonDialog({
                            "Title": "提示",
                            "Note": msg,
                            "BtnName": "挤房间",
                            "BtnName2": "确定",
                            "BtnNum": 2
                        }, function() {
                            this.enter(roomId, true);
                        }, function() {
                            MGC_LIVEROOM_BIND.closeRefresh();
                        });
                        return;
                        break;
                    case 50:
                        msg = '当前房间内人太多，挤房失败了，挤房失败不会扣除您的挤房次数哦~';
                        break;
                    case 51:
                        //达到挤房的上线
                        msg = '房间人满。如果拥有贵族身份，或者成为当前主播的天使守护及以上，可以优先的进入人满房间哦~<br>今日剩余挤房次数：-';
                        break;
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
                    default:;
                        //
                }
                if (resp.res != 0) {
                    alert(msg);
                    return false;
                }
                console.log("enter room success");
                //@ todo   进房成功后的操作
            } else {
                alert("很抱歉，进入房间失败，请重试");
            }
            //@ todo
        },
        //嘉宾席
        receiveVipList: function(obj) {
            console.log('嘉宾' + JSON.stringify(obj));
            if (obj.ret == 0) {
                vipListModel.set(obj);
            } else {
                //异常
            }
        },
        //非直播，获得房间默认图片
        getRoomUrlCallBack: function(obj) {
            console.log("获得房间幻灯图片：" + JSON.stringify(obj));
            //成功获得房间的默认图片
            var v = $("#video_pic");
            var html = "";
            if (obj.urls.length > 0) {
                $.each(obj.urls, function(i, o) {
                    if (i == 0) {
                        html += "<li style='z-index:1;'><img src='" + o + "' /></li>";
                    } else {
                        html += "<li><img src='" + o + "' /></li>";
                    }
                });
                v.html(html);
                v.show();
                //xxjtemp//MGC.FuncAutoPlay(v);
            } else {
                html += "<li style='z-index:1;'><img src='http://ossweb-img.qq.com/images/mgc/css_img/video_room/living.jpg?v=3_8_8_2016_15_4_final_3' /></li>";
                v.html(html);
                v.show();
            }
        },
	
        //个人名片回调
        getPlayerInfoCallBack: function(obj) {
            try {
                console.log("获取的个人名片信息111：" + obj);
                obj = tool.strToJson(obj);
                var _playerInfo = {};
                if (!obj.mem_info.Online) {
                    room_callBack.showCloseTips(tempEvent, '该用户已不在房间中');
                    return false;
                }
                _playerInfo.guardlevelClass = _playerInfo.guardlevelShow = _playerInfo.viplevelClass = _playerInfo.viplevelShow = '';
                var HeadImgPath = consts.filePath.HEAD_IMG_PATH;
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
                    _playerInfo._targetId = obj.mem_info.psid;
                    //大区--不显示
                    _playerInfo._showAreaName = '';
                    _playerInfo._targetId = obj.mem_info.psid;
                    //传给私聊的大区
                    var _zoneId = obj.mem_info.zoneid;
                    if (_zoneId == consts.MGCData.mgcZoneId) {
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
                    if (obj.mem_info.isSelf) {
                        //查看自己
                    } else {
                        _playerInfo.card_list_info += '<ul class="list_btn">';
                        _playerInfo.card_list_info += '<li><a class="privitechat" receiverId="'+_playerInfo._targetId+'" receiverName="' + _playerInfo._nickName + '" receiverZoneName="' + _playerInfo._talkAreaName + '" receiverPlayerType="' + obj.mem_info.playerType + '" href="javascript:;">私 聊</a></li>';
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
                    if (_zoneId == consts.MGCData.mgcZoneId) {
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
                    _playerInfo._targetId = obj.mem_info.psid;

                    //贵族
                    _playerInfo._vip_level = obj.mem_info.vip_level;
                    _playerInfo._nickColor = "#111111";
                    switch (_playerInfo._vip_level) {
                        case 0:
                            _playerInfo._nickColor = "#111111";
                            //非贵族
                            break;
                        case 1:
                            _playerInfo._nickColor = "#1a6b00";
                            //近卫
                            break;
                        case 2:
                            _playerInfo._nickColor = "#006772";
                            //骑士
                            break;
                        case 3:
                            _playerInfo._nickColor = "#0a57af";
                            //将军
                            break;
                        case 4:
                            _playerInfo._nickColor = "#8f00b1";
                            //亲王
                            break;
                        case 5:
                            _playerInfo._nickColor = "#ae5600";
                            //皇帝
                            break;
                        default:
                            break;
                    }
                    //守护
                    _playerInfo._guard_level = obj.mem_info.guardlevel;
                    if (_playerInfo._guard_level > 0) {
                        _playerInfo.guardlevelClass = "icon_lv icon_lv" + _playerInfo._guard_level;
                        _playerInfo.guardlevelShow = consts.guardLevelTab[_playerInfo._guard_level];
                    }
                    if (_playerInfo._vip_level > 0) {
                        _playerInfo.viplevelClass = "icon_honor icon_honor" + _playerInfo._vip_level;
                        _playerInfo.viplevelShow = consts.vipLevelTab[_playerInfo._vip_level];
                    }
                    //名片
                    _playerInfo._cardClass = 'icon_card';
                    //下拉信息--要分各种情况todo
                    _playerInfo.card_list_info = '';
                    if (obj.mem_info.isSelf) {
                        //查看自己
                    } else {
                        _playerInfo.card_list_info += '<ul class="list_btn">';
                        _playerInfo.card_list_info += '<li><a class="privitechat" receiverId="'+_playerInfo._targetId+'" receiverName="' + _playerInfo._nickName + '" receiverZoneName="' + _playerInfo._talkAreaName + '" receiverPlayerType="' + obj.mem_info.playerType + '" href="javascript:;">私 聊</a></li>';
                        _playerInfo.card_list_info += '<li><a href="javascript:copyToClipBoard();">复制昵称</a></li>';
                        if (canInvite) {
                            _playerInfo.card_list_info += '<li><a id="invitationBtn" data_targetId=" + _playerInfo._targetId + " data_showAreaName="' + _playerInfo._talkAreaName + '" href="javascript:fansInvited();">后援团邀请</a></li>';
                        }
                        //屏蔽信息
                        if (obj.mem_info.isIgnore) {//true ? 已经屏幕了？
                            _playerInfo.card_list_info += '<li><a class="ignore"  playerId="'+_playerInfo._targetId+'" name="' + obj.mem_info.player_name + '" area="' + obj.mem_info.zone_name + '" isIgnore="false" href="javascript:;">取消屏蔽</a></li>';
                        } else {
                            _playerInfo.card_list_info += '<li><a class="ignore"  playerId="'+_playerInfo._targetId+'" name="' + obj.mem_info.player_name + '" area="' + obj.mem_info.zone_name + '" isIgnore="true" href="javascript:;">屏 蔽</a></li>';
                        }
                        if (obj.mem_info.banable) {//可以禁言
                            _playerInfo.card_list_info += '<li><a class="forbidden"  playerId="'+_playerInfo._targetId+'" name="' + obj.mem_info.player_name + '" area="' + obj.mem_info.zone_name + '" href="javascript:;">禁 言</a></li>';
                            _playerInfo.card_list_info += '<li><a class="cancelForbidden" playerId="'+_playerInfo._targetId+'" name="' + obj.mem_info.player_name + '" area="' + obj.mem_info.zone_name + '" href="javascript:;">取消禁言</a></li>';
                        } else if (obj.mem_info.unbanable) {
                            _playerInfo.card_list_info += '<li><a class="cancelForbidden" playerId="'+_playerInfo._targetId+'" name="' + obj.mem_info.player_name + '" area="' + obj.mem_info.zone_name + '" href="javascript:;">取消禁言</a></li>';
                        }
                        _playerInfo.card_list_info += '</ul>';
                    }
                }
                var cardTipCon = $('#cardTipTmpl');
                var cardTipTmpl;
                var cardTipContainer = $('#cardTipContainer');
                cardTipContainer.children().remove();
                cardTipTmpl = cardTipCon.tmpl(_playerInfo);
                cardTipTmpl.appendTo(cardTipContainer);
                //兼容不容版本的jquery版本
                cardTipContainer.find(".privitechat").unbind("click").bind("click", function() {
                    $chat.PreSendMsgChat(1, this, true);
                });
                //如果有名片、绑定名片事件
                if (_playerInfo._cardClass == 'icon_card') {
                    if (obj.mem_info.playerType == 0) {//主播
                        $('.icon_card').off('click').on('click', function() {
                            window.mgc.popmanager.layerControlHide($(".card_tips"), 1, 2);
                            MGC_CommRequest.getAnchorCard($(this).attr('anchorId'));
                        });
                    } else {//玩家
                        $('.icon_card').off('click').on('click', function() {
                            //需要判断在不在线-已经在点击阶段实现
                            window.mgc.popmanager.layerControlHide($(".card_tips"), 1, 2);
                            //查询名片信息
                            MGC_cardRequest.getListCardInfo(_playerInfo._targetId, card_source);
                        });
                    }
                }
                //增加禁言和取消禁言的操作
                $('.forbidden').on('click', function() {
                    var _name = $.trim($("#cardTipContainer .name_info .ni_nick").html()) || "";
                    //解决转义字符
                    var _area = $(this).attr('area');
                    var _playerId = $m(this).attr('playerId');
                    MGC_CommRequest.forbidden(_playerId,_name, _area, true, false);
                });

                $('.cancelForbidden').on('click', function() {
                    var _name = $.trim($("#cardTipContainer .name_info .ni_nick").html()) || "";
                    //解决转义字符
                    var _area = $(this).attr('area');
                    var _playerId = $m(this).attr('playerId');
                    MGC_CommRequest.forbidden(_playerId,_name, _area, false, false);
                });
                //屏蔽和取消屏蔽操作
                $('.ignore').on('click', function() {
                    var _name = $.trim($("#cardTipContainer .name_info .ni_nick").html()) || "";
                    //解决转义字符
                    var _area = $(this).attr('area');
                    var _playerId = $m(this).attr('playerId');
                    var _isIgnore = $(this).attr('isIgnore') == "true" ? true : false;
                    MGC_CommRequest.ignore(_playerId,_name, _area, _isIgnore);
                });
                //弹出他人框
                room_callBack.cardTips(tempEvent, 's_con_card');

                cardTipTmpl = null;
                cardTipCon = null;
            } catch (e) {
                console.log(e);
            }
        },
	/**
         * 房间状态回调
         */
        roomStatusCallBack:function(resp, params){

            console.log('下发房间状态' + JSON.stringify(resp));
            consts.MGCData.roomStatus = resp.status;
           
            if (resp.status == 1&&resp.isConcert==false) {
                //显示幸运抽奖按钮
                mgc.swfInterval = setInterval(function() {
                    // if (MGC_SWFINIT.GiftSwf) {
                    $("#draw_button").show();
                    if (!(mgc_account.checkGuestStatus(true))) {
                        if (tools.cookie("draw_prompt") != "draw_prompt") {
                            $('#draw_prompt').show();
                            $('#prompt_close').unbind('click').bind('click', function() {
                                $('#draw_prompt').hide();
                            });
                            setTimeout("$('#draw_prompt').fadeOut();", 30000);
                            tools.cookie("draw_prompt", "draw_prompt", {
                                expires: 365 * 24 * 60
                            });
                        }
                    }
                    var uid = mgc_account.getUin();
                    if (tools.cookie("draw_refresh_time" + uid) == "draw_refresh_time") {
                        $("#icon_new").show();
                        $("#icon_red").hide();
                    }
                    clearInterval(mgc.swfInterval);
                    // }
                }, 1500);

                //显示视频区广告
                $('.video_pic').show();

                //非直播，查看房间默认图片
                callcenter.get_room_url(room_callback.getRoomUrlCallBack);

                //未开播推荐位
                callcenter.get_recommend(room_callback.get_recommend_callback);

                //显示未开播推荐位
                recommendModel.set("enabled",true);

            } else {
                //隐藏抽奖按钮
                $("#draw_button").hide();

                //隐藏视频区广告
                $('.video_pic').hide();

                //隐藏未开播推荐位
                recommendModel.set("enabled",false);
            }

            video_response(resp);
        },

        //////////////////////////////////////////////////////////////////////////
        //已经不在房间的提示

        showCloseTips: function(e, val) {
            var t = (e.pageY == undefined ? e.clientY : e.pageY) - 3, l = (e.pageX == undefined ? e.clientX : e.pageX) + 30;
            if (val == '') {
                return false;
            }
            var susTips = $(".sus_tips_list3");
            susTips.css({
                "top": t,
                "left": l
            });
            susTips.text(val);
            susTips.show();
            setTimeout(function() {
                susTips.animate({
                    opacity: "hide"
                }, "slow");
            }, 1000);
        },

        //已经不在房间的提示名片提示层
        cardTips: function(evt, con) {
            var posx = 0, posy = 0, l, t, card = $(".card_tips");
            if (/firefox/.test(navigator.userAgent.toLowerCase())) {
                evt = evt;
            } else {
                evt = evt || window.event;
            }

            if (evt.pageX || evt.pageY) {
                posx = evt.pageX;
                posy = evt.pageY;
            } else if (evt.clientX || evt.clientY) {
                posx = evt.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
                posy = evt.clientY + document.documentElement.scrollTop + document.body.scrollTop;
            }
            if (navigator.userAgent.toLocaleLowerCase().indexOf('msie') !== -1) {
                t = posy + 10, l = posx + 20;
            } else {
                t = posy + 10, l = posx + 20;
            }
            //判断是否出边界
            if ((l + 204) > $(window).width()) {
                l = l - 204;
            }
            var cardHeight = card.height();
            if ((t + cardHeight) > $(window).height()) {
                t = t - cardHeight;
            }
            card.css({
                "left": l,
                "top": t
            }).show();
            $(document).click(function(e) {
                e = window.event || e;
                var obj = $(e.srcElement || e.target);
                if ($(obj).is("#" + con + ",#" + con + " *   ,.card_tips")) {
                    card.css({
                        "left": l,
                        "top": t
                    }).show();
                } else {
                    card.hide();
                    $(document).off("click");
                }
            });
        }
    };
    control.room_request = room_request;
    //房间状态
    callcenter.addRespListener(callcenter.OP_TYPE.RECEIVE_ROOM_STATUS, room_callback.roomStatusCallBack);
    return control;
});
