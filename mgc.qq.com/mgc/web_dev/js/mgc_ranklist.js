/*
 * Created by v_binjinluo on 2015/5/5
 * 显示各类排行榜
 * op_type : 
 * 
 *  3 主播星耀值排行榜(总榜）
 *　  4 主播亲密度排行榜
 *  5 主播人气值排行榜
 *　  6 小屋主播积分排行榜
 *  7 舞团联盟争霸排行榜
 *  8 主播积分榜
 *  9 后援团排行榜
 *  10 优胜主播榜
 *  11 英豪榜
 *  110 主播星耀值排行榜(双周榜）
 *  149 财富排行榜
 *  109 贵族排行榜（VIP排行）
 *  255 主播等级榜
 */

var rankExchange = { 0: 'first', 1: 'second', 2: 'third', 3: 'fourth', 4: 'fifth', 5: 'sixth', 6: 'seventh', 7: 'eighth', 8: 'ninth', 9: 'tenth' };


//发送请求========================================
var MGC_SpecialRequest = {

    //主播积分榜（日、周、月）
    getAnchorJFRank: function (timedimension) {
        var cacheData = $m('#anchor_jf').data('showlist' + timedimension);
        if (typeof cacheData == 'undefined') {
            var _repStr = "{\"op_type\":" + OpType.GetAnchorJFRankOpType + ",\"timedimension\":" + timedimension + "}";
            MGC_Comm.sendMsg(_repStr, "MGC_CommResponse.AnchorRankCallBack");
        } else {
            MGC_Response(cacheData);
        }
    },
    
    //主播等级榜
    getAnchorLevelRank: function () {   
        var _repStr = "{\"op_type\":" + OpType.GetAnchorLevelRankOpType + "}";
        MGC_Comm.sendMsg(_repStr, "MGC_CommResponse.AnchorLeverRankCallBack");
    },

    //星耀排行榜（日、周、月、总）
    getAnchorStarRank: function (timedimension) {
        var cacheData = $m('#anchor_star').data('showlist' + timedimension);
        if (typeof cacheData == 'undefined') {
            var _repStr = "{\"op_type\":" + OpType.GetAnchorStarRankOpType + ",\"timedimension\":" + timedimension + "}";
            MGC_Comm.sendMsg(_repStr, "MGC_CommResponse.StarRankCallBack");
        } else {
            MGC_Response(cacheData);
        }
    },

    //主播亲密度排行榜
    getAnchorIntiRank: function (timedimension) {
        var cacheData = $m('#anchor_player_intimate').data('showlist' + timedimension);
        if (typeof cacheData == 'undefined') {
            var _repStr = "{\"op_type\":" + OpType.GetAnchorIntiRankOpType + ",\"timedimension\":" + timedimension + "}";
            MGC_Comm.sendMsg(_repStr, "MGC_CommResponse.AnchorIntiCallBack");
        } else {
            MGC_Response(cacheData);
        }
    },

    //财富排行榜
    getWealthRank: function (pageIndex, timedimension) {
        var pageSize = 10, begin_index = (pageIndex - 1) * pageSize, end_index = pageIndex * pageSize;
        var _repStr = "{\"op_type\":" + OpType.GetWealthRankOpType + ",\"begin_index\":" + begin_index + ",\"end_index\":" + end_index + ",\"timedimension\":" + timedimension + "}";
        MGC_Comm.sendMsg(_repStr, "MGC_CommResponse.WealthRankCallBack");
    },

    //贵族排行榜
    getVipRank: function (pageIndex) {
        var pageSize = 10, begin_index = (pageIndex - 1) * pageSize, end_index = pageIndex * pageSize;
        var _repStr = "{\"op_type\":" + OpType.GetVipRankOpType + ",\"begin_index\":" + begin_index + ",\"end_index\":" + end_index + "}";
        MGC_Comm.sendMsg(_repStr, "MGC_CommResponse.VipRankCallBack");
    },

    //等级排行榜
    getLevelRank: function (pageIndex) {
        var pageSize = 10, begin_index = (pageIndex - 1) * pageSize, end_index = pageIndex * pageSize;
        var _repStr = "{\"op_type\":" + OpType.GetLevelRankOpType + ",\"begin_index\":" + begin_index + ",\"end_index\":" + end_index + "}";
        MGC_Comm.sendMsg(_repStr, "MGC_CommResponse.LevelRankCallBack");
    },

    //后援团排行榜
    getBackupList: function () {
        var _repStr = "{\"op_type\":" + 9 + "}";
        MGC_Comm.sendMsg(_repStr, "MGC_CommResponse.BackupListCallBack");
    },

    //优胜主播榜
    getGreatAnchorRank: function () {
        var cacheData = $m('#great_anchor').data('showlist');
        if (typeof cacheData == 'undefined') {
            var _repStr = "{\"op_type\":" + OpType.GetGreatAnchorRankOpType + "}";
            MGC_Comm.sendMsg(_repStr, "MGC_CommResponse.GreatAnchorCallBack");
        } else {
            MGC_Response(cacheData);
        }
    },

    //英豪榜
    getGreatPlayerRank: function () {
        var cacheData = $m('#great_player').data('showlist');
        if (typeof cacheData == 'undefined') {
            var _repStr = "{\"op_type\":" + OpType.GetGreatPlayerRankOpType + "}";
            MGC_Comm.sendMsg(_repStr, "MGC_CommResponse.GreatPlayerCallBack");
        } else {
            MGC_Response(cacheData);
        }
    }

};

var MGC_SpecialResponse = {
    //=============主播积分榜（日周月）==============
    AnchorRankCallBack: function (responseStr) {
        console.log("主播积分榜（日周月总）:" + JSON.stringify(responseStr));
        if (responseStr.ret == 0) {
            var _rank = responseStr.rank, len = _rank.length, maxLen = 12, _rankHtml = '', container = $m('#anchor_jf');
            if (len > 0) {
                if (typeof container.data('showlist' + responseStr.timedimension) == 'undefined') {
                    container.data('showlist' + responseStr.timedimension, responseStr);//缓存
                }
                
                for (var i = 0; i < len; i++) {
                	var level = _rank[i].m_anchor_level;
                    var levelClass = Math.floor(level / 10) + 1;
                    var _status_html = '';
                    if (level == 0) {
                        levelClass = 0;
                    }
                    if (parseInt(_rank[i].m_anchor_status) == 2) {
                        _status_html = '<em><a href="transfer.shtml?roomId=' + _rank[i].m_room_id + '" target="_blank">直播中</a></em>';
                    }
                    //_rank[i].order_change = -10;//debugger
                    var _icon = _rank[i].m_order_change > 0 ? "up" : _rank[i].m_order_change == 0 ? "nor" : _rank[i].m_order_change < 0 ? "down" : "nor";
                    if (i < 3) {
                        _rankHtml += '<li class="' + rankExchange[i] + '"><b>' + (parseInt(i) + 1) + '</b><img src="' + _rank[i].m_anchor_portrait_url + '" width="65" height="65" alt="" /><i></i><span class="rank_level_span_top" style="margin-top:' + (_status_html == '' ? '0' : '-8') + 'px"><a class="i_anchor_level_' + levelClass + '"><i>' + level + '</i></a></span><span class="m_anchor_name"><strong><label style="margin-top:' + (_status_html == '' ? '10' : '0') + 'px">' + _rank[i].m_anchor_name + '</label>' + _status_html + '</strong></span><span class="rank_times rank_' + _icon + '_color">' + (_rank[i].m_order_change == 0 ? "" : (_rank[i].order_change == 0 ? "" : Math.abs(_rank[i].m_order_change))) + '</span><span class="rank_icon rank_icon_' + _icon + '"></span><span class="r_poll">' + _rank[i].m_score + '</span></li>';
                    } else {
                        _rankHtml += '<li class="' + rankExchange[i] + '"><b>' + (parseInt(i) + 1) + '</b><span class="rank_level_span"><a class="i_anchor_level_' + levelClass + '"><i>' + level + '</i></a></span><span><strong><label>' + _rank[i].m_anchor_name + '</label>' + _status_html + '</strong></span><span class="rank_times rank_' + _icon + '_color">' + (_rank[i].m_order_change == 0 ? "" : (_rank[i].order_change == 0 ? "" : Math.abs(_rank[i].m_order_change))) + '</span><span class="rank_icon rank_icon_' + _icon + '"></span><span class="r_poll">' + _rank[i].m_score + '</span></li>';
                    }
                }
                for (var i = len; i < maxLen; i++) {
                    _rankHtml += '<li class="' + rankExchange[i] + '"><b>' + (parseInt(i) + 1) + '</b></li>';
                }
            } else {
                _rankHtml = '<div class="bg_none"><p class="bg_none_img"></p><p class="bg_none_txt">主播排队中，快去支持喜爱的主播吧</p></div>';
            }
            container.html(_rankHtml);
        } else {

        }
    },
    //=============主播等级榜==============
    AnchorLeverRankCallBack: function (responseStr) {
        console.log("主播等级榜:" + JSON.stringify(responseStr));
        var _rank = responseStr.anchorRank;
        var len = _rank.length;
        var maxLen = 12;
        var _rankHtml = '';
        var container = $m('#anchor_dengji');
        if (len > 0) {
            for (var i = 0; i < len; i++) {

                var level = _rank[i].level;
                var levelClass = Math.floor(level / 10) + 1;
                if (level == 0) {
                    levelClass = 0;
                }
                var _status_html = '';
                if (parseInt(_rank[i].anchor_status) == 2) {
                    _status_html = '<em><a href="transfer.shtml?roomId=' + _rank[i].room_id + '" target="_blank">直播中</a></em>';
                }
                if (i < 3) {
                    _rankHtml += '<li class="' + rankExchange[i] + '"><b>' + (parseInt(i) + 1) + '</b>';
                    _rankHtml += '<img src="' + _rank[i].anchor_url + '" width="65" height="65" alt="" /><i></i>';
                    _rankHtml += '<span class="rank_level_span_top" style="margin-top:' + (_status_html == '' ? '0' : '-8') + 'px"><a class="i_anchor_level_' + levelClass + '"><i>' + level + '</i></a></span>';
                    _rankHtml += '<span class="m_anchor_name"><strong><label style="margin-top:' + (_status_html == '' ? '10' : '0') + 'px">';
                    _rankHtml += _rank[i].anchor_nick + '</label>' + _status_html + '</strong></span>';
                    _rankHtml += '<span class="r_poll">LV' + level + '</span></li>';
                    
                } else {
                    _rankHtml += '<li class="' + rankExchange[i] + '"><b>' + (parseInt(i) + 1) + '</b>';
                    _rankHtml += '<span class="rank_level_span"><a class="i_anchor_level_' + levelClass + '"><i>' + level + '</i></a></span>';
                    _rankHtml += '<span><strong><label>' + _rank[i].anchor_nick + '</label>' + _status_html + '</strong></span>';
                    _rankHtml += '<span class="r_poll">LV' + level + '</span></li>';
                }
            }
            for (var i = len; i < maxLen; i++) {
                _rankHtml += '<li class="' + rankExchange[i] + '"><b>' + (parseInt(i) + 1) + '</b></li>';
            }
        } else {
            _rankHtml = '<div class="bg_none"><p class="bg_none_img"></p><p class="bg_none_txt">主播排队中，快去支持喜爱的主播吧</p></div>';
        }
        container.html(_rankHtml);
		

        
    },

    //=============星耀排行榜（日周月总）==============
    StarRankCallBack: function (responseStr) {
        console.log("星耀排行榜（日周月总）:" + JSON.stringify(responseStr));
        if (responseStr.res == 0) {
            var _rank = responseStr.rank.anchorRank, len = _rank.length, maxLen = 12, _rankHtml = '', container = $m('#anchor_star');
            if (typeof container.data('showlist' + responseStr.timedimension) == 'undefined') {
                container.data('showlist' + responseStr.timedimension, responseStr);//缓存
            }
            if (len>0) {
                for (var i in _rank) {
                	var level = _rank[i].anchor_level;
                    var levelClass = Math.floor(level / 10) + 1;
                    if (level == 0) {
                        levelClass = 0;
                    }
                    if (_rank[i].name == undefined)
                        continue;
                    var _status_html = '';
                    //_rank[i].order_change = -10;//debugger
                    var _icon = _rank[i].order_change > 0 ? "up" : _rank[i].order_change == 0 ? "nor" : _rank[i].order_change < 0 ? "down" : "nor";
                    if (parseInt(_rank[i].status) == 2) {
                        _status_html = '<em><a href="transfer.shtml?roomId=' + _rank[i].room_id + '" target="_blank">直播中</a></em>';
                    }
                    if (i < 3) {
                        _rankHtml += '<li class="' + rankExchange[i] + '"><b>' + (parseInt(i) + 1) + '</b><img src="' + _rank[i].photoUrl + '" width="65" height="65" alt="" /><i></i><span class="rank_level_span_top" style="margin-top:' + (_status_html == '' ? '0' : '-8') + 'px"><a class="i_anchor_level_' + levelClass + '"><i>' + level + '</i></a></span><span class="m_anchor_name"><strong><label style="margin-top:' + (_status_html == '' ? '10' : '0') + 'px">' + _rank[i].name + '</label>' + _status_html + '</strong></span><span class="rank_times rank_' + _icon + '_color">' + (_rank[i].order_change == 0 ? "" : Math.abs(_rank[i].order_change)) + '</span><span class="rank_icon rank_icon_' + _icon + '"></span><span class="r_poll">' + _rank[i].starlight + '</span></li>';
                    } else {
                        _rankHtml += '<li class="' + rankExchange[i] + '"><b>' + (parseInt(i) + 1) + '</b><span class="rank_level_span"><a class="i_anchor_level_' + levelClass + '"><i>' + level + '</i></a></span><span><strong><label>' + _rank[i].name + '</label>' + _status_html + '</strong></span><span class="rank_times rank_' + _icon + '_color">' + (_rank[i].order_change == 0 ? "" : Math.abs(_rank[i].order_change)) + '</span><span class="rank_icon rank_icon_' + _icon + '"></span><span class="r_poll">' + _rank[i].starlight + '</span></li>';
                    }
                }
                for (var i = len; i < maxLen; i++) {
                    _rankHtml += '<li class="' + rankExchange[i] + '"><b>' + (parseInt(i) + 1) + '</b></li>';
                }
            } else {
                _rankHtml = '<div class="bg_none"><p class="bg_none_img"></p><p class="bg_none_txt">主播排队中，快去支持喜爱的主播吧</p></div>';
            }
            container.html(_rankHtml);
        } else {

        }

    },

    //=============主播亲密度排行榜==============
    AnchorIntiCallBack: function (responseStr) {
        console.log("主播亲密度排行榜（日周月总）:" + JSON.stringify(responseStr));
        var _rank = responseStr.rank, len = _rank.length, maxLen = 12, _rankHtml = '', container = $m('#anchor_player_intimate');
        if (typeof container.data('showlist') == 'undefined') {
            container.data('showlist' + responseStr.timedimension, responseStr);//缓存
        }
        if (len>0) {
            for (var i = 0; i < len; i++) {
            	var level = _rank[i].anchor_level;
                var levelClass = Math.floor(level / 10) + 1;
                var _icon = _rank[i].order_change > 0 ? "up" : _rank[i].order_change == 0 ? "nor" : _rank[i].order_change < 0 ? "down" : "nor";
                if(level==0){
                levelClass = 0;
                }
                if (i < 3) {
                    var _photo = '';
                    if (_rank[i].m_has_portrait) {
                        _photo = _rank[i].playerPhotoUrl;
                    } else {
                        if (_rank[i].playerGender == 1) {
                            _photo = 'http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_male.png?v=3_8_8_2016_15_4_final_3';
                        } else {
                            _photo = 'http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_female.png?v=3_8_8_2016_15_4_final_3';
                        }
                    }
                    _rankHtml += '<li class="' + rankExchange[i] + '">\
							<b>'+ (parseInt(i) + 1) + '</b>\
							<div class="head_box">\
								<img src="'+ _photo + '" width="65" height="65" alt="" /><i></i>\
								<strong>'+ _rank[i].m_player_nick + '</strong>\
							</div>\
							<div class="head_box">\
								<img src="'+ _rank[i].anchorPhotoUrl + '" width="65" height="65" alt="" /><i></i>\
								<span class="rank_level_span_top" style="margin-top:0px"><a class="i_anchor_level_' + levelClass + ' anchor_i_' + levelClass + '"><i>' + level + '</i></a></span><strong class="a_strong">' + _rank[i].m_anchor_nick + '</strong>\
							</div><span class="rank_times rank_' + _icon + '_color">' + (_rank[i].order_change == 0 ? "" : Math.abs(_rank[i].order_change)) + '</span><span class="rank_icon rank_icon_' + _icon + '"></span>\
							<span class="r_poll">'+ _rank[i].m_score + '</span>\
					</li>';
                } else {
                    _rankHtml += '<li class="' + rankExchange[i] + '">\
							<b>'+ (parseInt(i) + 1) + '</b>\
							<div class="head_box">\
								<strong>'+ _rank[i].m_player_nick + '</strong></span>\
							</div>\
							<div class="head_box">\
								<span class="rank_level_span"><a class="i_anchor_level_' + levelClass + '"><i>' + level + '</i></a></span><strong>'+ _rank[i].m_anchor_nick + '</strong></span>\
							</div><span class="rank_times rank_' + _icon + '_color">' + (_rank[i].order_change == 0 ? "" : Math.abs(_rank[i].order_change)) + '</span><span class="rank_icon rank_icon_' + _icon + '"></span>\
							<span class="r_poll">'+ _rank[i].m_score + '</span>\
					</li>';
                }
            }
            for (var i = len; i < maxLen; i++) {
                _rankHtml += '<li class="' + rankExchange[i] + '"><b>' + (parseInt(i) + 1) + '</b></li>';
            }
        } else {
            _rankHtml = '<div class="bg_none"><p class="bg_none_img"></p><p class="bg_none_txt">主播排队中，快去支持喜爱的主播吧</p></div>';
        }
        container.html(_rankHtml);
    },

    //=============财富榜==============
    WealthRankCallBack: function (responseStr) {
        var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
        console.log("财富榜（日周月总）:" + JSON.stringify(responseStr));
        if (obj.type == 0) {
            var _rank = obj.rank, len = _rank.length, maxLen = 10, _rankHtml = '', container = $m('#player_wealth'), _total = obj.total_size, _myRank = obj.my_rank;
            if (len > 0) {
                var _totalPage = Math.ceil(_total / 10);
                var tipstr = '';
                var _curPage = pages1.currentPage, begin_index = (_curPage - 1) * 10;
                var _class = '';
                for (var i = 0; i < len; i++) {
                	var level = _rank[i].m_wealth_level;
                    var levelClass = level;
                    if (begin_index <= 3) {
                        _class = rankExchange[begin_index];
                    }
                    var _icon = _rank[i].m_order_change > 0 ? "up" : _rank[i].m_order_change == 0 ? "nor" : _rank[i].m_order_change < 0 ? "down" : "nor";
                    _rankHtml += '<li class="' + _class + '"><a href="javascript:;" style="cursor:default"><b>' + (parseInt(begin_index) + 1) + '</b><span class="i_rich_level i_rich_level_' + levelClass + '" mgc_rich_level="'+level+'" mgc_rich_value="'+_rank[i].m_video_wealth+'"></span><span class="user_name"><strong><label>' + _rank[i].m_player_nick + '</label></strong><em class="source" style="cursor:default">' + (_rank[i].m_player_zone != "" ? (_rank[i].m_player_zone == "梦工厂" ? _rank[i].m_player_zone : "炫舞-" + _rank[i].m_player_zone) : "") + '</em></span><span class="rank_times rank_' + _icon + '_color">' + (_rank[i].m_order_change == 0 ? "" : Math.abs(_rank[i].m_order_change)) + '</span><span class="rank_icon rank_icon_' + _icon + '"></span><span class="r_poll">' + _rank[i].m_video_wealth + '</span></a></li>';
                    begin_index++;
                }
                for (var i = len; i < maxLen; i++) {
                    if (begin_index <= 3) {
                        _class = rankExchange[begin_index];
                    }
                    _rankHtml += '<li class="' + _class + '"><b>' + (parseInt(begin_index) + 1) + '</b></li>';
                    begin_index++;
                }
                MGC_Comm.commonCheckLogin(function () {
                    if (_myRank > 1000 || _myRank <= 0) {
                        tipstr = '您暂未上榜！';
                    } else {
                        tipstr = '您的排名：<strong>' + _myRank + '</strong>名';
                    }
                    $m('#wealth_tips').html(tipstr);
                }, function () {
                    tipstr = '您尚未登录，无法查看本人排名';
                    $m('#wealth_tips').html(tipstr);
                });
                pages1.totalPage = _totalPage;
                container.parent().find(".list_page,.tips").show();
            } else {
                _rankHtml = '<div class="bg_none"><p class="bg_none_img"></p><p class="bg_none_txt">虚位以待，等你来战！！！</p></div>';
                container.parent().find(".list_page,.tips").hide();
            }
            pages1.initPage();
            container.html(_rankHtml);
        }
    },

    //=============贵族榜==============
    VipRankCallBack: function (responseStr) {
        var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
        if (obj.type == 0) {
            var _rank = obj.rank, len = _rank.length, maxLen = 10, _rankHtml = '', container = $m('#player_vip'), _total = obj.total_size, _myRank = obj.my_rank;
            if (len > 0) {
                var _totalPage = Math.ceil(_total / 10);
                var tipstr = '';
                var _curPage = pages2.currentPage, begin_index = (_curPage - 1) * 10;
                var _class = '';
                for (var i = 0; i < len; i++) {
                    if (begin_index <= 3) {
                        _class = rankExchange[begin_index];
                    }
                    var _vipName = vipLevelTab[_rank[i].m_vip_level];
                    _rankHtml += '<li class="' + _class + '"><a href="javascript:;" style="cursor:default"><b>' + (parseInt(begin_index) + 1) + '</b><span><strong><label>' + _rank[i].m_player_nick + '</label></strong><em class="source" style="cursor:default">' + (_rank[i].m_player_zone != "" ? (_rank[i].m_player_zone == "梦工厂" ? _rank[i].m_player_zone : "炫舞-" + _rank[i].m_player_zone) : "") + '</em></span><span class="r_poll">' + _rank[i].m_video_wealth + '&nbsp;&nbsp;<ins class="icon_honor icon_honor' + _rank[i].m_vip_level + '" onmouseover= MGC.susStateTipsRanklist(event,1,"' + _vipName + '"); onmouseout= MGC.susStateTipsRanklist(event,0);>' + _vipName + '</ins></span></a></li>';
                    begin_index++;
                }
                for (var i = len; i < maxLen; i++) {
                    if (begin_index <= 3) {
                        _class = rankExchange[begin_index];
                    }
                    _rankHtml += '<li class="' + _class + '"><b>' + (parseInt(begin_index) + 1) + '</b></li>';
                    begin_index++;
                }
                MGC_Comm.commonCheckLogin(function () {
                    if (_myRank > 1000 || _myRank <= 0) {
                        tipstr = '您暂未上榜！';
                    } else {
                        tipstr = '您的排名：<strong>' + _myRank + '</strong>名';
                    }
                    $m('#vip_tips').html(tipstr);
                }, function () {
                    tipstr = '您尚未登录，无法查看本人排名';
                    $m('#vip_tips').html(tipstr);
                });
                container.html(_rankHtml);
                pages2.totalPage = _totalPage;
                pages2.initPage();
                container.parent().find(".list_page,.tips").show();
            } else {
                _rankHtml = '<div class="bg_none"><p class="bg_none_img"></p><p class="bg_none_txt">虚位以待，等你来战！！！</p></div>';
                container.html(_rankHtml);
                container.parent().find(".list_page,.tips").hide();
            }
        } else {

        }
    },

    //=============后援团排行榜==============
    BackupListCallBack: function (responseStr) {
        var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
        if (obj.ret == 0) {
            //if(true){
            var _rank = obj.rank, len = _rank.length, maxLen = 10, _rankHtml = '', container = $m('#support_Group_list');
            //var len = 10,_rankHtml='',container = $m('#support_Group_list');
            if (typeof container.data('showlist') == 'undefined') {
                container.data('showlist', responseStr);//缓存
            }
            //for(var i=0;i<len;i++){
            if (len>0) {
                for (var i = 0; i < len; i++) {
                    if (i < 3) {
                        var _photo = '';
                        _photo = 'http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_female.png?v=3_8_8_2016_15_4_final_3';
                        _rankHtml += '<li class="' + rankExchange[i] + '">\
							<b>'+ (parseInt(i) + 1) + '</b>\
							<span class="support_group_strong">'+ rank[i].m_guild_name + '</span>\
							<div class="support_group_head_box">\
								<img src="'+ _rank[i].m_player_url + '" width="65px" height="65px" alt="" /><i></i>\
								<strong class="support_Group_head_name">'+ _rank[i].m_guild_chairman + '</strong>\
							</div>\
							<div class="support_group_head_box">\
								<img src="'+ _rank[i].m_anchor_portrait_url + '" width="65px" height="65px" alt="" /><i></i>\
								<strong class="support_Group_head_name">'+ _rank[i].m_anchor_name + '</strong>\
							</div>\
							<span class="r_poll">'+ _rank[i].m_active_score + '</span>\
					</li>';
                    } else {
                        _rankHtml += '<li class="' + rankExchange[i] + '">\
							<b>'+ (parseInt(i) + 1) + '</b>\
							<span class="support_group">'+ _rank[i].m_guild_name + '</span>\
							<div class="support_group_head_box">\
								<strong class="support_Group_head_name">'+ _rank[i].m_guild_chairman + '</strong>\
							</div>\
							<div class="support_group_head_box">\
								<strong class="support_Group_head_name">'+ _rank[i].m_anchor_name + '</strong>\
							</div>\
							<span class="r_poll">'+ _rank[i].m_active_score + '</span>\
					</li>';
                    }
                }
                for (var i = len; i < maxLen; i++) {
                    _rankHtml += '<li class="' + rankExchange[i] + '"><b>' + (parseInt(i) + 1) + '</b></li>';
                }
            } else {
                _rankHtml = '<div class="bg_none"><p class="bg_none_img"></p><p class="bg_none_txt">虚位以待，等你来战！！！</p></div>';
            }
            container.html(_rankHtml);
        } else {

        }
    },

    //=============等级榜==============
    LevelRankCallBack: function (responseStr) {
        var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
        if (obj.type == 0) {
            var _rank = obj.rank, len = _rank.length, maxLen = 10, _rankHtml = '', container = $m('#player_lv'), _total = obj.total_size, _myRank = obj.my_rank;
            if (len > 0) {
                var _totalPage = Math.ceil(_total / 10);
                var tipstr = '';
                var _curPage = pages3.currentPage, begin_index = (_curPage - 1) * 10;
                for (var i = 0; i < len; i++) {
                    var _class = '';
                    if (begin_index <= 3) {
                        _class = rankExchange[begin_index];
                    }
                    _rankHtml += '<li class="' + _class + '"><a href="javascript:;" style="cursor:default"><b>' + (parseInt(begin_index) + 1) + '</b><span><strong><label>' + _rank[i].m_nick + '</label></strong><em class="source" style="cursor:default">' + (_rank[i].m_zone != "" ? (_rank[i].m_zone == "梦工厂" ? _rank[i].m_zone : "炫舞-" + _rank[i].m_zone) : "") + '</em></span><span class="r_poll r_polled">LV ' + _rank[i].m_level + '</span></a></li>';
                    begin_index++
                }
                for (var i = len; i < maxLen; i++) {
                    if (begin_index <= 3) {
                        _class = rankExchange[begin_index];
                    }
                    _rankHtml += '<li class="' + _class + '"><b>' + (parseInt(begin_index) + 1) + '</b></li>';
                    begin_index++;
                }
                MGC_Comm.commonCheckLogin(function () {
                    if (_myRank > 1000 || _myRank <= 0) {
                        tipstr = '您暂未上榜！';
                    } else {
                        tipstr = '您的排名：<strong>' + _myRank + '</strong>名';
                    }
                    $m('#lv_tips').html(tipstr);
                }, function () {
                    tipstr = '您尚未登录，无法查看本人排名';
                    $m('#lv_tips').html(tipstr);
                });
                container.html(_rankHtml);
                pages3.totalPage = _totalPage;
                pages3.initPage();
                container.parent().find(".list_page,.tips").show();
            } else {
                _rankHtml = '<div class="bg_none"><p class="bg_none_img"></p><p class="bg_none_txt">虚位以待，等你来战！！！</p></div>';
                container.html(_rankHtml);
                container.parent().find(".list_page,.tips").hide();
            }
        } else {

        }
    },

    //=============优胜主播榜==============
    GreatAnchorCallBack: function (responseStr) {
        var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
        if (obj.ret == 0) {
            var _rank = obj.rank, len = _rank.length, _rankHtml = '', container = $m('#great_anchor');
            if (len > 0) {
                if (typeof container.data('showlist') == 'undefined') {
                    container.data('showlist', responseStr);//缓存
                }
                $m('#rc_tab li').eq(2).show();
                container.show().prev().hide();
                for (var i = 0; i < len; i++) {
                    var _status_html = '';
                    if (parseInt(_rank[i].m_anchor_status) == 2) {
                        _status_html = '<em><a href="transfer.shtml?roomId=' + _rank[i].m_room_id + '" target="_blank">直播中</a></em>';
                    }
                    if (i < 3) {
                        _rankHtml += '<li class="' + rankExchange[i] + '"><b>' + (parseInt(i) + 1) + '</b><img src="' + _rank[i].m_anchor_portraiturl + '" width="65" height="65" alt="" /><i></i><span><strong>' + _rank[i].m_guild_name + _status_html + '</strong></span><span class="r_poll">' + _rank[i].m_guild_name + '</span></li>';
                    } else {
                        _rankHtml += '<li class="' + rankExchange[i] + '"><b>' + (parseInt(i) + 1) + '</b><span><strong>' + _rank[i].m_anchor_nick + _status_html + '</strong></span><span class="r_poll">' + _rank[i].m_guild_name + '</span></li>';
                    }
                }
                container.html(_rankHtml);
            } else {
                $m('#rc_tab li').eq(2).hide();
            }
        } else {

        }

    },

    //=============英豪榜==============
    GreatPlayerCallBack: function (responseStr) {
        var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
        if (obj.ret == 0) {
            var _rank = obj.rank, len = _rank.length, _rankHtml = '', container = $m('#great_player');

            if (len > 0) {
                if (typeof container.data('showlist') == 'undefined') {
                    container.data('showlist', responseStr);//缓存
                }
                $m('#rc_tab li').eq(2).show();
                container.show().prev().hide();
                for (var i = 0; i < len; i++) {
                    if (i < 3) {
                        var _photo = _rank[i].playerPhotoUrl;
                        if (_rank[i].player_portrait) {
                            _photo = _rank[i].playerPhotoUrl;
                        } else {
                            if (_rank[i].player_gender == 1) {
                                _photo = 'http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_male.png?v=3_8_8_2016_15_4_final_3';
                            } else {
                                _photo = 'http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_female.png?v=3_8_8_2016_15_4_final_3';
                            }
                        }
                        _rankHtml += '<li class="' + rankExchange[i] + '"><b>' + (parseInt(i) + 1) + '</b><img src="' + _photo + '" width="65" height="65" alt="" /><i></i><span><strong>' + _rank[i].m_player_nick + '</strong></span><span class="r_poll">' + _rank[i].m_contribution + '</span></li>';
                    } else {
                        _rankHtml += '<li class="' + rankExchange[i] + '"><b>' + (parseInt(i) + 1) + '</b><span><strong>' + _rank[i].m_player_nick + '</strong></span><span class="r_poll">' + _rank[i].m_contribution + '</span></li>';
                    }
                }
                container.html(_rankHtml);
            } else {
                $m('#rc_tab li').eq(2).hide();
            }
        } else {

        }

    }
};

$m.extend(MGC_CommRequest, MGC_SpecialRequest);
$m.extend(MGC_CommResponse, MGC_SpecialResponse);


var MGC_Response = function (responseStr) {
    var _repStr = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr), _op_type = _repStr.op_type;
    switch (parseInt(_op_type)) {
        case 8:
            MGC_CommResponse.AnchorRankCallBack(_repStr);
            break;
        case 3:
            MGC_CommResponse.StarRankCallBack(_repStr);
            break;
        case 110:
            MGC_CommResponse.StarRankCallBack(_repStr);
            break;
        case 4:
            MGC_CommResponse.AnchorIntiCallBack(_repStr);
            break;
        case 10:
            MGC_CommResponse.GreatAnchorCallBack(_repStr);
            break;
        case 11:
            MGC_CommResponse.GreatPlayerCallBack(_repStr);
            break;
        case 149:
            MGC_CommResponse.WealthRankCallBack(_repStr);
            break;
        case 109:
            MGC_CommResponse.VipRankCallBack(_repStr);
            break;
        case 148:
            MGC_CommResponse.getLevelRank(_repStr);
            break;
        case 255:
            MGC_CommResponse.AnchorLeverRankCallBack(_repStr);
            break;
        default:
            break;
    }
}

//本页需要回调加载的功能
var loginCallBack = function () {
    MGC_CommRequest.getAnchorJFRank(0);//加载积分榜（日榜）
    MGC_CommRequest.getAnchorLevelRank();//加载主播等级榜
    MGC_CommRequest.getAnchorStarRank(0);//加载星耀排行榜（日榜）
    MGC_CommRequest.getAnchorIntiRank();//加载亲密度排行榜
    //MGC_CommRequest.getGreatAnchorRank();
    //MGC_CommRequest.getGreatPlayerRank();
    myTabCon("xy_tab", "xy_con");
    myTabCon("jf_tab", "jf_con");
    myTabCon("qmd_tab", "qmd_con");
    myTabCon("caifu_tab", "caifu_con");
    myClickTab("rc_tab", "rc_con");
    MGCLoginRequest.getCardInfo();//加载右上角个人信息
};

$m('body').on('mouseover','a[class^="i_anchor_level_"]', function(e) {
    var level = $m(this).html();
    MGC.susTipsHtml(e, 1, '主播等级：' + level);
});

$m('body').on('mouseout','a[class^="i_anchor_level_"]', function(e) {
    MGC.susTipsHtml(e,0);
});

$m('body').on('mouseover', 'span[class^="i_rich_level"]', function(e) {
    var level = $m(this).attr("mgc_rich_level");
    var value = $m(this).attr("mgc_rich_value");
    if (level > 0) {
        MGC.susTipsHtml(e, 1, '财富值：' + value);
    }
});

$m('body').on('mouseout','span[class^="i_rich_level"]', function(e) {
    MGC.susTipsHtml(e,0);
});

var myTabCon = function (id, con) {
    var tabArr = $m("#" + id).find("li a"), len = tabArr.length;
    tabArr.removeClass().eq(0).addClass("current");//初始化
    tabArr.each(function (index) {
        $m(this).unbind("mouseenter").bind("mouseenter", function () {
            tabArr.removeClass().eq(index).addClass("current");
            var _con = $m("#" + con).find("ul").eq(0);
            switch (id) {
                case "xy_tab":
                    MGC_CommRequest.getAnchorStarRank(index);
                    switch (index) {
                        case 0:
                            $m('.rc_xy_info .score').html("今日星耀值");
                            $m(".xy_con .tips").html("日榜星耀值<strong>每天0点</strong>清空重新累计。");
                            break;
                        case 1:
                            $m('.rc_xy_info .score').text("本周星耀值");
                            $m(".xy_con .tips").html("周榜星耀值<strong>每周一0点</strong>清空重新累计。");
                            break;
                        case 2:
                            $m('.rc_xy_info .score').text("本月星耀值");
                            $m(".xy_con .tips").html("月榜星耀值<strong>每月1日0点</strong>清空重新累计。");
                            break;
                        case 3:
                            $m('.rc_xy_info .score').text("星耀值");
                            $m(".xy_con .tips").children().remove();
                            break;
                        default:
                            break;
                    }
                    break;
                case "jf_tab":
                    MGC_CommRequest.getAnchorJFRank(index);
                    switch (index) {
                        case 0:
                            $m('.rc_jifen .rc_con_info .score').html("今日主播积分");
                            $m(".jf_con .tips").html("主播积分<strong>每天0点</strong>清空重新累计。<br>加入后援团，为主播贡献主播积分。");
                            break;
                        case 1:
                            $m('.rc_jifen .rc_con_info .score').text("本周主播积分");
                            $m(".jf_con .tips").html("主播积分<strong>每周一0点</strong>清空重新累计。<br>加入后援团，为主播贡献主播积分。");
                            break;
                        case 2:
                            $m('.rc_jifen .rc_con_info .score').text("本月主播积分");
                            $m(".jf_con .tips").html("主播积分<strong>每月1日0点</strong>清空重新累计。<br>加入后援团，为主播贡献主播积分。");
                            break;
                        default:
                            break;
                    }
                    break;
                case "qmd_tab":
                    MGC_CommRequest.getAnchorIntiRank(index);
                    switch (index) {
                        case 0:
                            $m('.rc_qmd_info .zqmd').html("日亲密度");
                            break;
                        case 1:
                            $m('.rc_qmd_info .zqmd').text("周亲密度");
                            break;
                        case 2:
                            $m('.rc_qmd_info .zqmd').text("月亲密度");
                            break;
                        case 3:
                            $m('.rc_qmd_info .zqmd').text("亲密度");
                            break;
                        default:
                            break;
                    }
                    break;
                case "caifu_tab":
                    pages1.currentPage = 1;
                    pages1.timedimension = index;
                    MGC_CommRequest.getWealthRank(pages1.currentPage, pages1.timedimension);
                    break;
                default:
                    break;
            }
        })
    })
}

var myClickTab = function (id, con) {
    var tabArr = $m("#" + id).find("a"), conArr = $m("." + con);
    tabArr.each(function (index) {
        $m(this).unbind("click").click(function () {
            tabArr.removeClass().eq(index).addClass("current");
            conArr.hide().eq(index).show();
            if (index == 0) {
                //主播榜
                $m("#xy_tab").find("li a").eq(0).mouseenter();
                $m("#jf_tab").find("li a").eq(0).mouseenter();
                $m("#qmd_tab").find("li a").eq(0).mouseenter();
            } else if (index == 1) {
                // 粉丝榜
                $m("#caifu_tab").find("li a").eq(0).mouseenter();
                pages2.currentPage = 1;
                pages3.currentPage = 1;
                MGC_CommRequest.getVipRank(pages2.currentPage);//加载贵族榜
                MGC_CommRequest.getBackupList();// 后援团排行榜
                MGC_CommRequest.getLevelRank(pages3.currentPage);//加载等级榜
            } else {
                //活动榜
                MGC_CommRequest.getGreatAnchorRank();//加载优胜主播榜
                MGC_CommRequest.getGreatPlayerRank();//加载英豪榜
            }
        });
    });
}

var Pages = function (container, requestFunc) {
    this.container = container;
    this.currentPage = 1;
    this.timedimension = 0;
    this.totalPage;
    this.funcs = { "MGC_CommRequest.getWealthRank": MGC_CommRequest.getWealthRank, "MGC_CommRequest.getVipRank": MGC_CommRequest.getVipRank, "MGC_CommRequest.getLevelRank": MGC_CommRequest.getLevelRank };
    this.requestFunc = requestFunc;
    this.initPage = function () {
        var _this = this, _html = '';
        if (this.totalPage == 1) {
            _html += '<a href="javascript:;" class="un_homepage">后退十页</a>';
            _html += '<a href="javascript:;" class="un_prev">上一页</a>';
            _html += '<span>' + this.currentPage + '/' + this.totalPage + '</span>';
            _html += '<a href="javascript:;" class="un_next">下一页</a>';
            _html += '<a href="javascript:;" class="un_lastpage">前进十页</a>';
        } else {
            if (this.currentPage == 1) {
                _html += '<a href="javascript:;" class="un_homepage">后退十页</a>';
                _html += '<a href="javascript:;" class="un_prev">上一页</a>';
                _html += '<span>' + this.currentPage + '/' + this.totalPage + '</span>';
                _html += '<a href="javascript:;" class="next">下一页</a>';
                _html += '<a href="javascript:;" class="lastpage">前进十页</a>';
            } else if (this.currentPage == this.totalPage) {
                _html += '<a href="javascript:;" class="homepage">后退十页</a>';
                _html += '<a href="javascript:;" class="prev">上一页</a>';
                _html += '<span>' + this.currentPage + '/' + this.totalPage + '</span>';
                _html += '<a href="javascript:;" class="un_next">下一页</a>';
                _html += '<a href="javascript:;" class="un_lastpage">前进十页</a>';
            } else {
                _html += '<a href="javascript:;" class="homepage">后退十页</a>';
                _html += '<a href="javascript:;" class="prev">上一页</a>';
                _html += '<span>' + this.currentPage + '/' + this.totalPage + '</span>';
                _html += '<a href="javascript:;" class="next">下一页</a>';
                _html += '<a href="javascript:;" class="lastpage">前进十页</a>';
            }
        }
        $m('#' + this.container).html(_html);
        var aClicks = $m('#' + this.container + ' a');
        aClicks.eq(0).on('click', function () { _this.goToFirstTen(); });
        aClicks.eq(1).on('click', function () { _this.goToPrev(); });
        aClicks.eq(2).on('click', function () { _this.goToNext(); });
        aClicks.eq(3).on('click', function () { _this.goToLastTen(); });
    };
    this.goToFirstTen = function () {
        if (this.currentPage - 10 > 0) {
            this.currentPage = this.currentPage - 10;
        } else {
            this.currentPage = 1;
        }
        this.funcs[this.requestFunc](this.currentPage, this.timedimension);
    };

    this.goToLastTen = function () {
        if (this.currentPage + 10 < this.totalPage) {
            this.currentPage = this.currentPage + 10;
        } else {
            this.currentPage = this.totalPage;
        }
        this.funcs[this.requestFunc](this.currentPage, this.timedimension);
    };

    this.goToPrev = function () {
        if (this.currentPage == 1) return;
        this.currentPage--;
        this.funcs[this.requestFunc](this.currentPage, this.timedimension);
    };

    this.goToNext = function () {
        if (this.currentPage >= this.totalPage) return;
        this.currentPage++;
        this.funcs[this.requestFunc](this.currentPage, this.timedimension);
    };
}
var pages1 = new Pages('wealth_page', 'MGC_CommRequest.getWealthRank');
var pages2 = new Pages('vip_page', 'MGC_CommRequest.getVipRank');
var pages3 = new Pages('lv_page', 'MGC_CommRequest.getLevelRank');
/*  |xGv00|9cd4eefccdcf6e68b3e83467d526d4aa */