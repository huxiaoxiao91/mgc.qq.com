/*
 * Created by ouyangtaili on 2015/9/16.
 * 提供直播房间的信息
 * op_type :操作类型
 * 77 获取玩家梦工厂名片信息
 *
 */
//发送请求========================================
var MGC_cardRequest = {


//角色列表-他人名片
    getListCardInfo: function(id, source) {
        var _reqStr = { "op_type": OpType.GetPlayerInfoOpType, "player_id": id, "source": source};
        MGC_Comm.sendMsg(_reqStr, "MGC_cardResponse.getListCardInfoCallBack");
    },

    //角色列表-他人名片(宝座离线时用)
    getListCard: function(player_id,source) {
        player_id = player_id.toString();
        var _reqStr = { "op_type": OpType.GetPlayerInfoOpType, "player_id": player_id,"source":source};
        MGC_Comm.sendMsg(_reqStr, "MGC_cardResponse.getListCardCallBack");
    }
};

var MGC_cardResponse = {

	//弹出玩家名片信息
    popPlayerDetailCard: function(playerInfo) {
        $m.each(playerInfo.followed_anchors, function(k, v) {
            v.anchorStatus = v.anchor_status == 2 ? "直播中" : "离线";
            v.cardLevelShowTips = guardLevelTab[v.guard_level];
        });
        $m.each(playerInfo.love_nest_info_vec, function (k, v) {
            if (filename == "caveolaeroom.shtml" || filename == "nest.shtml") {
                v.cardLevelShowTips = "";
            } else {
                //v.cardLevelShowTips = vipLevelTab[v.credits_level];
                v.cardLevelShowTips = "";
            }
        });
        //showDialog.hide();
        if ((typeof(playerInfo.wealth_level_exp) !="undefined")&&(parseFloat(playerInfo.wealth_level_exp.replace('%', '')) > 100.00)) {
            playerInfo.wealth_level_exp = 100 + '%';
        }
        if ((typeof(playerInfo.wealth_level_exp) !="undefined")&&(parseFloat(playerInfo.wealth_level_exp.replace('%', '')) <= 0.00)) {
            playerInfo.wealth_level_exp = 0;
        }
        playerInfo._targetId = playerInfo._targetId;
        var cardInfoCon = $m('#cardInfoTmpl');
        var cardInfoTmpl;
        var cardInfoContainer = $m('#cardInfoContainer');
        cardInfoContainer.removeClass().addClass('pop_card ' + playerInfo._vipClass);
        cardInfoContainer.children().remove();
        cardInfoTmpl = cardInfoCon.tmpl(playerInfo);
        cardInfoTmpl.appendTo(cardInfoContainer);

        if(!playerInfo.isSelf){
            $('#cardInfoContainer .pop_tab_head li').eq(1).hide();
            $('#cardInfoContainer .pop_lv_tab').eq(1).hide();
        }
        
        if ($m.cookie("mgc_invite_click") != null) {
            window.mgc.popmanager.layerControlShow($m("#cardInfoContainer"), 4, 1, 2);
        } else {
            window.mgc.popmanager.layerControlShow($m("#cardInfoContainer"), 4, 1, 1);
        }
        $m('#cardInfoContainer').centerDisp();
        $m('#cardInfoContainer').find(".pop_close").off('click').on('click', function() {
            window.mgc.popmanager.layerControlHide($m("#cardInfoContainer"), 4, 1);
        });
        if (filename == "showroom.shtml") {
            $m(".tb_con .icon_lv,.tb_con .icon_headrank").hide();
        }
        //后援团id为0时候，表示该玩家没有后援团
        if (playerInfo.vgid == 0) {
            $m('.backGroup_card').css('display', 'none');            
        }
        if (playerInfo._vip_name == "皇帝" || playerInfo._vip_name == "亲王") {
            $m('.pop_details .p5 fieldset').parent().removeClass().addClass('p5 pborder1');
        } else if (playerInfo._vip_name == "普通" || playerInfo._vip_name == "近卫") {
            $m('.pop_details .p5 fieldset').parent().removeClass().addClass('p5 pborder2');
        } else if (playerInfo._vip_name == "将军") {
            $m('.pop_details .p5 fieldset').parent().removeClass().addClass('p5 pborder3');
        } else if (playerInfo._vip_name == "骑士") {
            $m('.pop_details .p5 fieldset').parent().removeClass().addClass('p5 pborder4');
        }
        if (playerInfo._levelPer != 0) {
            if (parseFloat(playerInfo._levelPer.replace('%', '')) >= 0.00 && parseFloat(playerInfo._levelPer.replace('%', '')) <= 6.00) {
                $m(".pop_info .pd_progress").css("overflow", "hidden");
            } else {
                $m(".pop_info .pd_progress").css("overflow", "inherit");
            }
        }
        //绑定主播的弹框
        $m('.lv_links').off('click').on('click', function() {
            MGC_CommRequest.getAnchorCard($m(this).attr('anchorId'));
        });
		$m('#anchorCard').off('click').on('click', function() {
                MGC_CommRequest.getAnchorCard();
            });
        //绑定后援团的弹框
        $m('.backGroup_card').off('click').on('click', function () {
            MGC_CommRequest.getbackupGroupCard($m(this).attr('vgid'));
        });
        cardInfoTmpl = null;
        cardInfoCon = null;
    },

    //角色列表-他人名片
    getListCardInfoCallBack: function(obj) {
        mgc.tools.EAS([{ 'e_c': 'mgc.showcard', 'c_t': 0 }]);
        console.log("查询个人名片信息：" + JSON.stringify(obj));
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
        }else{
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
            _playerInfo._targetId = obj.card_info.player_id;
            //大区
            var _zoneId = obj.card_info.zone_id;
            if (_zoneId == MGCData.mgcZoneId) {
                //_playerInfo._showAreaName = '梦工厂';
                _playerInfo._showAreaName = obj.card_info.zone_name;
            } else if (obj.card_info.zone_name == "QQ游戏") {
                _playerInfo._showAreaName = obj.card_info.zone_name;
            }else{
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
            _playerInfo.vip_level = obj.card_info.vip_level;
            if (obj.card_info.vip_level == 0) {
                _playerInfo.roleGuizu = "";
            } else {
                _playerInfo.roleGuizu = "icon_honor";
            }
            //下一级的经验
            var _nextExp = obj.card_info.levelup_exp;
            if (_nextExp == 0) { //满级
                _playerInfo._levelPer = '100%';
            } else {
                _playerInfo._levelPer = (_playerInfo._currentExp / _nextExp).toPercent(2);
                if (_playerInfo._levelPer == '0.00%') {
                    _playerInfo._levelPer = 0;
                }
            }
            //他人名片弹出框--等级todo
            //他人名片弹出框--财富值
            _playerInfo.wealth = obj.card_info.wealth;
            //他人名片弹窗框-后援团名
            _playerInfo.vg_name = obj.card_info.vg_name;
            //他人名片弹窗框-后援团ID
            _playerInfo.vgid = obj.card_info.vgid;
            //他人名片弹出框--签名
            _playerInfo.signature = obj.card_info.signature;
            //关注的主播信息
            _playerInfo.followed_anchors = obj.card_info.followed_anchors;
            //关注的主播等级

            $m.each(_playerInfo.followed_anchors, function (k, v) {
                v.anchor_level_temp = Math.floor(v.anchor_level / 10) + 1;
                if (v.anchor_level == 0) {
                    v.anchor_level_temp = 0;
                }
            });

            //最爱的直播间
            _playerInfo.love_nest_info_vec = obj.card_info.love_nest_info_vec;
            //他人名片财富等级
            _playerInfo.wealth_level = obj.card_info.wealth_level;
            //他人名片财富经验槽-经验值
            _playerInfo.wealth_exp = obj.card_info.wealth_exp;
            //他人名片财富等级-需要达到下一经验所需的经验值
            _playerInfo.wealth_levelup_exp = obj.card_info.wealth_levelup_exp;
            //他人名片财富等级-下一级的经验
            if (_playerInfo.wealth_levelup_exp == 0) { //满级
                _playerInfo.wealth_level_exp = '100%';
            } else {
                _playerInfo.wealth_level_exp = (_playerInfo.wealth_exp / _playerInfo.wealth_levelup_exp).toPercent(2);
            }
            //判断是不是自己点击名片
            if(_playerInfo._targetId == mgc.consts.MGCData.myPlayerId){
                _playerInfo.isSelf = true;
            }else{
                _playerInfo.isSelf = false;
            }
            //弹出他人名片框
            MGC_cardResponse.popPlayerDetailCard(_playerInfo);
            

            $m('.tb_con').jScrollPane({
                autoReinitialise: true,
                animateScroll: true
            });
            var $jsp = $m('.tb_con').data('jsp');
            if($jsp){
                $jsp.initScroll();
            }

            //重绘滚动条
            var scrollAPI_cardfanslist = $m('#cardInfoContainer .pop_lv_tab').eq(0).find(".tb_con").data('jsp');
            if(scrollAPI_cardfanslist){
                scrollAPI_cardfanslist.initScroll();
            }


            //详情页tab页切换1
            $m(".pop_tab_head").find('li').each(function(i) {
                $m(this).bind('click', function() {
                    $m(".pop_tab_head").find('li').removeClass('active').eq(i).addClass('active');
                    $m(this).parent().parent().parent().find(".pop_lv_tab").hide().eq(i).show();
                    //重绘滚动条 
                    var scrollAPI_cardfanslist = $m('#cardInfoContainer .pop_lv_tab').eq(i).find(".tb_con").data('jsp');
                    if(scrollAPI_cardfanslist){
                        scrollAPI_cardfanslist.initScroll();
                    }
                });
            });
            if (filename.indexOf("showroom.shtml") >= 0) {
                $m(".pop_lv_tab").eq(0).find("th").eq(2).text("信息");
                $m(".pop_lv_tab").eq(1).find("th").eq(2).text("信息");
                $m(".pop_lv_tab .r").find("i").css("display", "none");                
            } else if ((filename.indexOf("liveroom.shtml") >= 0) || (filename.indexOf("caveolaeroom.shtml") >= 0)|| (filename.indexOf("nest.shtml") >= 0)) {
                $m(".pop_lv_tab .r a").css({ "left": "0px", "margin-left": "13px" });
            }
            MGC.popTipss("dream_card_weath_tips", "em", 4, 3);         
            
            $m('#cardInfoContainer .pop_lv_tab').find("i").off("mouseover,mouseout").on("mouseover", function(e){
                var anchorLevel = $(this).attr("mgc_card_anchor");
                var guardLevel = $(this).attr("mgc_card_guard");

                if (anchorLevel) {
                    MGC.susTips(e, 1, wealthLevel);
                } else if (guardLevel) {
                    MGC.susTips(e, 1, videoLevel);
                } 
            }).on("mouseout", function(){
                MGC.susTips(event, 0);
            });



        }
    },


    //角色列表-他人名片(宝座离线时用)
    getListCardCallBack: function(obj) {
        mgc.tools.EAS([{ 'e_c': 'mgc.showcard', 'c_t': 0 }]);
        console.log("查询个人名片信息：" + JSON.stringify(obj));
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
                default:
                    msg = '无法查看名片信息，其他错误。';
                    break;
            }
            MGC_Comm.CommonDialog({
                "Title": "提示",
                "Note": msg
            });
        }else{
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
            //玩家id
            _playerInfo._targetId = obj.card_info.player_id;
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
            _playerInfo.vip_level = obj.card_info.vip_level;
            //下一级的经验
            var _nextExp = obj.card_info.levelup_exp;
            if (_nextExp == 0) { //满级
                _playerInfo._levelPer = '100%';
            } else {
                _playerInfo._levelPer = (_playerInfo._currentExp / _nextExp).toPercent(2);
                if (_playerInfo._levelPer == '0.00%') {
                    _playerInfo._levelPer = 0;
                }
            }
            //他人名片弹出框--等级todo
            //他人名片弹出框--财富值
            _playerInfo.wealth = obj.card_info.wealth;
            //他人名片弹窗框-后援团名
            _playerInfo.vg_name = obj.card_info.vg_name;
            //他人名片弹窗框-后援团ID
            _playerInfo.vgid = obj.card_info.vgid;
            //他人名片弹出框--签名
            _playerInfo.signature = obj.card_info.signature;
            //关注的主播信息
            _playerInfo.followed_anchors = obj.card_info.followed_anchors;
            //关注的主播等级           
            $m.each(_playerInfo.followed_anchors, function (k, v) {
                v.anchor_level_temp = 0;
                if (v.anchor_level > 0 && v.anchor_level < 10) {
                    v.anchor_level_temp = 1;
                } else if (v.anchor_level > 9 && v.anchor_level < 20) {
                    v.anchor_level_temp = 2;
                } else if (v.anchor_level > 19 && v.anchor_level < 30) {
                    v.anchor_level_temp = 3;
                } else if (v.anchor_level > 29 && v.anchor_level < 40) {
                    v.anchor_level_temp = 4;
                } else if (v.anchor_level > 39 && v.anchor_level < 50) {
                    v.anchor_level_temp = 5;
                } else if (v.anchor_level > 49 && v.anchor_level < 60) {
                    v.anchor_level_temp = 6;
                } else if (v.anchor_level >= 60 && v.anchor_level < 70) {
                    v.anchor_level_temp = 7;
                } else if (v.anchor_level >= 70 && v.anchor_level < 80) {
                    v.anchor_level_temp = 8;
                } else if (v.anchor_level >= 80) {
                    v.anchor_level_temp = 9;
                }
            })

            //最爱的直播间
            _playerInfo.love_nest_info_vec = obj.card_info.love_nest_info_vec;
            //他人名片财富等级
            _playerInfo.wealth_level = obj.card_info.wealth_level;
            //他人名片财富经验槽-经验值
            _playerInfo.wealth_exp = obj.card_info.wealth_exp;
            //他人名片财富等级-需要达到下一经验所需的经验值
            _playerInfo.wealth_levelup_exp = obj.card_info.wealth_levelup_exp;
            //他人名片财富等级-下一级的经验
            if (_playerInfo.wealth_levelup_exp == 0) { //满级
                _playerInfo.wealth_level_exp = '100%';
            } else {
                _playerInfo.wealth_level_exp = (_playerInfo.wealth_exp / _playerInfo.wealth_levelup_exp).toPercent(2);
            }
            //判断是不是自己点击名片
            if(_playerInfo._targetId == mgc.consts.MGCData.myPlayerId){
                _playerInfo.isSelf = true;
            }else{
                _playerInfo.isSelf = false;
            }

            //弹出他人名片框
            MGC_cardResponse.popPlayerDetailCard(_playerInfo);


            $j('.tb_con').jScrollPane({
                autoReinitialise: true,
                animateScroll: true
            });
            var $jsp = $m('.tb_con').data('jsp');
            if($jsp){
                $jsp.initScroll();
            }
            
            //详情页tab页切换1
            $j(".pop_tab_head").find('li').each(function (i) {
                $j(this).bind('click', function () {
                    $j(".pop_tab_head").find('li').removeClass('active').eq(i).addClass('active');
                    $j(this).parent().parent().parent().find(".pop_lv_tab").hide().eq(i).show();
                    //重绘滚动条 
                    var scrollAPI_cardfanslist = $m('#cardInfoContainer .pop_lv_tab').eq(i).find(".tb_con").data('jsp');
                    if(scrollAPI_cardfanslist){
                        scrollAPI_cardfanslist.initScroll();
                    }
                });
            });
            MGC.popTipss("dream_card_weath_tips", "em", 4, 3);

        }
    }

};
$m.extend(MGC_CommRequest, MGC_cardRequest);
$m.extend(MGC_CommResponse, MGC_cardResponse);