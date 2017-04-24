/*
 * Created by ouyangtaili on 2015/9/24.
 * 主播名片信息
 * op_type :操作类型
 * 14 获取主播名片信息
 *
 */
//发送请求========================================
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
    "32": "天然呆",
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
};
var MGC_anchorCardRequest={
	    //拉取主播名片信息
    getAnchorCard: function (anchorId) {
        if (MGC_Comm.CheckGuestStatus()) {
            console.log("屏蔽游客操作：拉取主播名片信息");
            return false;//游客身份下，屏蔽此操作
        }
        mgc.tools.EAS([{ 'e_c': 'mgc.showcard', 'c_t': 4 }]);
        if (anchorId) {
            var _reqStr = {
                "op_type": OpType.GetAnchorCardOpType,
                "anchorID": anchorId
            };
        } else if (MGCData.anchorID) {
            var _reqStr = {
                "op_type": OpType.GetAnchorCardOpType,
                "anchorID": +MGCData.anchorID
            };
        }
        MGC_Comm.sendMsg(_reqStr, "MGC_anchorCardResponse.showAnchorCardCallBack");
    },
	//请求所有印象
	allImpressionInfo:function(thisAnchorId){
		var _reqStr = "{\"op_type\":144}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.allImpressionInfoCallBack", thisAnchorId);
	},
	//请求对主播的印象
    myImpressionInfo: function(thisAnchorId) {
        var _reqStr = "{\"op_type\":" + OpType.MyImpressionOpType + ", \"anchor_id\":" + thisAnchorId + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.myImpressionInfoCallBack", thisAnchorId);
    },
		//编辑印象返回
    editImpressionCallBack: function(obj,anchorId) {
        console.log("编辑印象的返回" + obj);
        obj = MGC_Comm.strToJson(obj);
        if (obj.res == 0) {
            //重置不显示弹窗
            MGC_anchorCardRequest.myImpressionInfo(anchorId);
            if($m('.selectImpression.current').length > 0)
            {
                var msg = "恭喜您，成功添加主播印象";
            }
            else{
                return;
            }
        } else if (obj.res == 2) {
            var msg = "成为ta的守护或拥有贵族身份才能添加印象哦";
        } else if (obj.res == 3) {
            window.mgc.common_logic.CheckNameError(114);
        } else {
            var msg = "很抱歉，添加主播印象失败。";
        }
   //     showDialog.hide();
        alert(msg);
        //无需再显示主播名片
        //$m('#anchorCard').click();
    },
	//主播弹框-粉丝排行-他人名片
    getFansCardInfo: function(id, source) {
        var _reqStr = { "op_type": OpType.GetPlayerInfoOpType, "player_id": id, "source": source};
        MGC_Comm.sendMsg(_reqStr, "MGC_cardResponse.getListCardInfoCallBack");
    }
};

var MGC_anchorCardResponse ={
	    //展示主播名片
    showAnchorCardCallBack: function(obj) {
        console.log("从服务器获得的主播名片：" + JSON.stringify(obj));
        obj = MGC_Comm.strToJson(obj);
        if (obj.succ) {
            var _anchorInfo = {};
            //主播小窝皮肤信息
            _anchorInfo.nest_skin_info = obj.data.nest_skin_info;
            //主播id
            _anchorInfo.anchorId = obj.data.basicData.anchorID;
            //是否关注--文字
            _anchorInfo.follow = !obj.isFollow ? "+ 关注" : "-已关注";
            //是否关注--true,false
            _anchorInfo.isFollow = obj.isFollow ? 1 : 0;
            //照片
            _anchorInfo.imageUrl = obj.data.basicData.imageUrl;
            //照片2
            _anchorInfo.photoUrl = obj.data.basicData.photoUrl;
            //主播名
            _anchorInfo.name = obj.data.basicData.name;
            //主播等级
            _anchorInfo.anchor_level = obj.data.basicData.anchor_level;
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
            //距离下一等级需要的经验值
            _anchorInfo.anchor_levelup_exp = obj.data.basicData.anchor_levelup_exp;
            //目前总共经验值
            _anchorInfo.anchor_exp = obj.data.basicData.anchor_exp;
            //瓶颈标识字段
            _anchorInfo.is_bottleneck = obj.data.basicData.is_bottleneck;
            //需要的瓶颈数量
            _anchorInfo.bottleneck_need_count = obj.data.basicData.bottleneck_need_count;
            MGCData.bottleneck_need_count = obj.data.basicData.bottleneck_need_count;
            //目前总共的瓶颈数量
            _anchorInfo.bottleneck_count = obj.data.basicData.bottleneck_count;
            //目前相差的瓶颈数量
            _anchorInfo.bottleneck_need_count_little = obj.data.basicData.bottleneck_count - obj.data.basicData.bottleneck_need_count;
            //需要的瓶颈礼物ID
            _anchorInfo.bottleneck_gift_id = obj.data.basicData.bottleneck_gift_id;            

            //主播名片里显示还需多少个礼物突破瓶颈
            _anchorInfo.bottleneck_need_count = _anchorInfo.bottleneck_need_count - _anchorInfo.bottleneck_count;
            //主播瓶颈送的礼物数量
            MGCData.bottleneck_count = _anchorInfo.bottleneck_count;
            _anchorInfo.Per = 0;
            if (_anchorInfo.anchor_levelup_exp == 0) {
                _anchorInfo.Per = 100 + '%';
            } else {
                _anchorInfo.anchor_Per = (_anchorInfo.anchor_exp / _anchorInfo.anchor_levelup_exp * 100).toFixed(0);

                if (_anchorInfo.anchor_Per <= 0) {
                    _anchorInfo.anchor_Per = 0;
                } else if (_anchorInfo.anchor_Per>=100) {
                    _anchorInfo.anchor_Per = 100 + '%';
                }else{
                _anchorInfo.anchor_Per = _anchorInfo.anchor_Per + '%';
                }
            }
            
            //瓶颈优化
            if (_anchorInfo.is_bottleneck) {
                //初始化瓶颈区域
                var bottlePer = Math.floor(MGCData.bottleneck_count / MGCData.bottleneck_need_count * 100);
                _anchorInfo.bottle_per_anchor = bottlePer;
            }

            //添加了印象的观众数
            _anchorInfo.m_player_count = obj.data.basicData.m_impression_data.m_player_count;
            //印象展示
            var _impression = obj.data.basicData.m_impression_data.m_impressions;
            var _m_total_count = obj.data.basicData.m_impression_data.m_total_count;
            _anchorInfo.impression = '';
            if (_impression.length < 5) {
                _anchorInfo.impression = "<span style='color:#000'>ta的印象还不足5种哦</span>";
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
            _anchorInfo.anchor_level_temp = 0;          

           
            _anchorInfo.anchor_level_temp = Math.floor(_anchorInfo.anchor_level / 10) + 1;
            if (_anchorInfo.anchor_level == 0) {
                _anchorInfo.anchor_level_temp = 0;
            }
           

            //我的守护信息
            var next_guard_level = obj.data.next_guard_level; //下一守护级别 VIDEO_GUARD_LEVEL_INVALID表示没有
            var next_guard_name = obj.data.next_guard_name;
            var affinity_need = obj.data.affinity_need; //到下一守护级别还需要多少亲密度
            var current_guard_level = obj.data.current_guard_level; //正在查看主播名片的玩家和这个主播的亲密度
            var current_guard_name = obj.data.current_guard_name; //正在查看主播名片的玩家和这个主播的亲密度
            var needMonthAffinity = obj.data.needMonthAffinity;//本月需要获得的亲密度值
            if (current_guard_level < 1) {
                _anchorInfo.tips = "很抱歉，您还不是Ta的守护。再获得<strong>" + affinity_need + "</strong>亲密度，就可以成为Ta的<strong>" + next_guard_name + "</strong>。";
            } else if (next_guard_level == 0 && needMonthAffinity > 0) {
                _anchorInfo.tips = "您是Ta的<strong>" + current_guard_name + "</strong>。本月再获得<strong>" + needMonthAffinity + "</strong>亲密度，就可以在下月继续成为Ta的<strong>" + current_guard_name + "</strong>。";
            } else if (next_guard_level == 0 && needMonthAffinity <= 0) {
                _anchorInfo.tips = "您是Ta的<strong>" + current_guard_name + "</strong>。恭喜本月亲密度达标，可以在下月继续成为Ta的<strong>" + current_guard_name + "</strong>。";
            } else if (next_guard_level == 500 && needMonthAffinity > 0 && affinity_need > 0) {
                _anchorInfo.tips = "您是Ta的<strong>" + current_guard_name + "</strong>。总亲密度还差<strong>" + affinity_need + "</strong>，月亲密度还差<strong>" + needMonthAffinity + "</strong>，就可以升级为Ta的<strong>" + next_guard_name + "</strong>。";
            } else if (next_guard_level == 500 && needMonthAffinity <= 0 && affinity_need > 0) {
                _anchorInfo.tips = "您是Ta的<strong>" + current_guard_name + "</strong>。月亲密度已达<strong>" + current_guard_name + "</strong>标准；总亲密度还差<strong>" + affinity_need + "</strong>，就可以升级为Ta的<strong>" + next_guard_name + "</strong>。";
            } else if (next_guard_level == 500 && needMonthAffinity > 0 && affinity_need <= 0) {
                _anchorInfo.tips = "您是Ta的<strong>" + current_guard_name + "</strong>。总亲密度已达标，月亲密度还差<strong>" + needMonthAffinity + "</strong>，可以升级为Ta的<strong>" + next_guard_name + "</strong>。";

            } else if (next_guard_level == 400 && needMonthAffinity > 0 && affinity_need > 0) {
                _anchorInfo.tips = "您是Ta的<strong>" + current_guard_name + "</strong>。总亲密度还差<strong>" + affinity_need + "</strong>，月亲密度还差<strong>" + needMonthAffinity + "</strong>，可以升级为Ta的<strong>" + next_guard_name + "</strong>。";
            } else if (next_guard_level == 400 && needMonthAffinity <= 0 && affinity_need > 0) {
                _anchorInfo.tips = "您是Ta的<strong>" + current_guard_name + "</strong>。月亲密度已达标，总亲密度还差<strong>" + affinity_need + "</strong>，可以升级为Ta的<strong>" + next_guard_name + "</strong>。";
            } else if (next_guard_level == 400 && needMonthAffinity > 0 && affinity_need <= 0) {
                _anchorInfo.tips = "您是Ta的<strong>" + current_guard_name + "</strong>。总亲密度已达标，月亲密度还差<strong>" + needMonthAffinity + "</strong>，可以升级为Ta的<strong>" + next_guard_name + "</strong>。";
            } else {
                _anchorInfo.tips = "您是Ta的" + current_guard_name + "。再获得<strong>" + affinity_need + "</strong>亲密度，就可以成为Ta的<strong>" + next_guard_name + "</strong>。";
            }
            //守护规则url
            _anchorInfo.guardRuleUrl = obj.guardRuleUrl;
            var weekstarMatchInfo = obj.data.weekstarMatchInfo; //周星赛信息
            weekstarMatchInfo.tips = _anchorInfo.tips;
            weekstarMatchInfo.guardRuleUrl = obj.guardRuleUrl;

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
                if (_tmpObj.guardLevel>0)
                {
                	_tmpObj.guard_levelShow=guardLevelTab[_tmpObj.guardLevel];
                }
                _tmpObj.viplevel = v.viplevel;
                _tmpObj.viplevelName = '';
                if(_tmpObj.viplevel>0)
                {
                	_tmpObj.viplevelName = vipLevelTab[_tmpObj.viplevel];
                }
                _tmpObj.nickColor = v.nickColor;
                _tmpObj.psid = v.psid;
                _anchorFans.push(_tmpObj);
            });
            
            //去Ta的个人直播间判断是否显示按钮
            var selfRoomId=obj.data.nest_id;
			var reg = new RegExp("(^|&)"+ "roomId" +"=([^&]*)(&|$)");
     		var r = window.location.search.substr(1).match(reg);
     		var roomId=0;
     		if(r!=null){
     			roomId=unescape(r[2]);
     		}
     		
            if(selfRoomId!=roomId&&selfRoomId>0){
            	_anchorInfo.selfRoomId=selfRoomId;
            	_anchorInfo.showSelfRoomLink=true;
            }

            //弹框-粉丝列表
            var fansCardCon = $m('#fansCardTmpl');
            var fansCardTmpl;
            var fansCardContainer = $m('#fansCardContainer');
            fansCardContainer.children().remove();
            fansCardTmpl = fansCardCon.tmpl(_anchorFans);
            fansCardTmpl.appendTo(fansCardContainer);

            //弹窗-后援团排名列表     

            //后援团排名
            var backGround = obj.data.guild_list;
            var backupGroupCon = $m('#backupGroupTmpl');
            var backupGroupTmpl;
            var backupGroupList = $m('#backupGroupList');
            backupGroupList.children().remove();
            backupGroupTmpl = backupGroupCon.tmpl(backGround);
            backupGroupTmpl.appendTo(backupGroupList);

            //主播徽章
            var badge = obj.data.anchor_badge_vec;            
            var badgeArr = [];
            var badgeArrTemp = [];

            $m.each(badge, function (k, v) {
                badgeArrTemp = {'badge_id': v.badge_id };
                badgeArr.push(badgeArrTemp);

            })

            var badgeCon = $m('#badgeTmpl');
            var badgeTmpl;
            var badgeList = $m('#badgeList');
            badgeList.children().remove();
            badgeTmpl = badgeCon.tmpl(badgeArr);
            badgeTmpl.appendTo(badgeList);
            if (badge.length == 0) {
                $m('#badgeList').append("<span></span>");
                $m('#badgeList span').css({ 'line-height': '150px', 'text-align': 'center', 'width': '497px', 'margin': '0 auto', 'display': 'inline-block' });
                $m('#badgeList span').html('TA还没有获得徽章，去TA直播间帮心爱的TA拿徽章吧！');
            }
            MGC_anchorCardResponse.mouseoutBadge();
            MGC_anchorCardResponse.mouseoverBadge();

            //绑定粉丝列表的弹框
            $m('.icon_message').off('click').on('click', function() {
                card_source = 7;
                var _id = $m(this).attr('psid');
                MGC_CommRequest.getFansCardInfo(_id, card_source);
            });
            //弹框-基本信息
            var anchorTip1Con = $m('#anchorTip1Tmpl');
            var anchorTip1Tmpl;
            var anchorTip1Container = $m('#anchorTip1Container');
            anchorTip1Container.children().remove();
            //满级的时候
            var ii = _anchorInfo.nest_skin_info;
            if(ii.room_skin_level==9)
            {
            	var fin = ii.current_punchin_count + ii.current_takeseat_count;
                var total = ii.total_punchin_count + ii.total_takeseat_count;
                var tList = ii.skin_task_info;
                if (tList.length > 0) {
                    for (var i = 0; i < tList.length; i++) {
                        fin += tList[i].current_count;
                        total += tList[i].total_count;
                    }
                }
                _anchorInfo.per = Math.floor(fin / total * 100); 
            }
            anchorTip1Container.children().remove();
            anchorTip1Tmpl = anchorTip1Con.tmpl(_anchorInfo);
            anchorTip1Tmpl.appendTo(anchorTip1Container);
            MGC.popTipss('anchor_card_level_tips', 'em', 4, 3);
            
            var nestInfo = _anchorInfo.nest_skin_info;
            if(nestInfo.room_skin_id==null || nestInfo.room_skin_id==0)
            {
                nestInfo.room_name = "";
                $m("#anchorTip1Container").find('.room_dd').hide();
            }
            else
            {
                $m("#anchorTip1Container").find('.room_dd').show();
                nestInfo.room_name = mgc.config.SKIN_CONFIG[nestInfo.room_skin_id].name;
                
                
                var anchorRoomTipsTmpl = $m('#anchorRoomTipsTmpl').tmpl(nestInfo);
                $m('#anchor_room_tips').html(anchorRoomTipsTmpl);
                $m(".room_div").off("mouseover,mouseout").on("mouseover", function(){
                    var t = $m(this).offset().top + 30;
                    var l = $m(this).offset().left + 63;
                    $m('#anchor_room_tips').css({
                        "top": t,
                        "left": l
                    });
                    window.mgc.popmanager.layerControlShow($m('#anchor_room_tips'), 4, 3);
                }).on("mouseout", function(){
                    window.mgc.popmanager.layerControlHide($m('#anchor_room_tips'), 4, 3);
                });
                anchorRoomTipsTmpl = null;
            }      
             

            if (filename == "showroom.shtml") {

                $m('#aninfo_tab1 ul li:eq(2)').css('display', 'none');

            }
            if (filename == 'group.shtml') {
                $m('.fans_list').find('.anchor_backGroup_card,.icon_message').hide();
            }
            if (filename == 'ranklist.shtml') {
                $m('.room_icon .room_level p').css('margin-top', '0');
                $m('.pop_anchor_info dd .pd_progress i').css('font-style', 'inherit');
            }
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
                MGC_anchorCardRequest.allImpressionInfo(thisAnchorId);
            });
            //绑定名片中的关注
            $m('.btn_care').off('click').on('click', function () {
                if (MGC_Comm.CheckGuestStatus(false)) {
                    return;
                } else {
                    var isFollow = $m(this).attr('isFollow');
                    var name = $m(this).attr('name');
                    var anchorId = $m(this).attr('anchorId');
                    MGC_anchorCardResponse.followAnchorAction(1, anchorId, name, isFollow);
                }
            });
            //绑定开通贵族
            if ($m('.anchord_open_vip').find("object").length == 0) {
                $m('.anchord_open_vip span').unbind('click').on('click', function(e) {
                    if (_anchorInfo.anchorId == "0") { return; }
                    mgc.common_contral.CommOpenVip.open(_anchorInfo.anchorId, _anchorInfo.name);
                    mgc.tools.EAS([{ 'e_c': 'mgc.buyvip.2', 'c_t': 4 }, { 'e_c': 'mgc.buyvip', 'c_t': 4 }]);
                });
                mgc.common_contral.CommOpenVip.initOpenBtnSwf(3);
            }
            

            //弹框-主播名片
            if ($m.cookie("mgc_invite_click") != null) {
                window.mgc.popmanager.layerControlShow($m("#pop3"), 4, 1, 2);
            } else {
                window.mgc.popmanager.layerControlShow($m("#pop3"), 4, 1, 1);
            }            
            $m('#pop3').centerDisp();
            $m('#pop3').find(".pop_close").off('click').on('click', function() {
                window.mgc.popmanager.layerControlHide($m("#pop3"), 4, 1);
            });
            //绑定后援团的弹框
            $m('.anchor_backGroup_card').off('click').on('click', function() {
                MGC_CommRequest.getbackupGroupCard($m(this).attr('vgid'));
            });
            //var anchorIcon = $m('#pop3').find(".anchor_card_level_tips").find("i").get(0);
            //var anchorIcon_em = $m('#pop3').find(".anchor_card_level_tips").find("em").get(0);
            //anchorIcon_em = anchorIcon_em.innerHTML;
            //MGC.newTipsLeft((anchorIcon_em), $m(anchorIcon), 4, 3);    

            //是否已经关注主播            

            $m('#anchorTip1Container .btn_care').off("mouseover").on('mouseover', function (e) {
                if (filename == "ranklist.shtml") {
                    MGCData.attention = true;
                    if (($m('#anchorTip1Container .btn_care').html() == '+ 关注') || ($m('#anchorTip1Container .btn_care').html() == '+关注')) {

                    } else {
                        $m('#anchorTip1Container .btn_care').text('取消');
                    }
                } else {
                    MGCData.attention = false;
                    if (($m('#anchorTip1Container .btn_care').html() == '+ 关注') || ($m('#anchorTip1Container .btn_care').html() == '+关注')) {

                    } else {
                        $m('#anchorTip1Container .btn_care').text('取消');
                    }
                }
            });
            $m('#anchorTip1Container .btn_care').off('mouseout').on('mouseout', function (e) {
                if ($m('#anchorTip1Container .btn_care').text() == '取消') {
                    $m('#anchorTip1Container .btn_care').text('-已关注');
                }
                MGC.susStatepositionTips(e, 0);
            });
            var weekstarCon = $("#weekstarMatchTmpl");
            // 周星赛数据
            // obj.data.weekstarMatchInfo.status = 0;

            if(weekstarMatchInfo.week_star_medals){
                for(var i=0,n=weekstarMatchInfo.week_star_medals.length; i<n; i++){
                    if(weekstarMatchInfo.grade == i+1){
                        weekstarMatchInfo.grade_name = weekstarMatchInfo.week_star_medals[i].grade_name;
                        weekstarMatchInfo.grade_desc = weekstarMatchInfo.week_star_medals[i].desc;
                    }

                    if(weekstarMatchInfo.week_star_medals[i].light_time == 0){
                        weekstarMatchInfo.ranklevel = weekstarMatchInfo.week_star_medals[i].grade_name;
                        break;
                    }

                    weekstarMatchInfo.week_star_medals[i].light_time = new Date(weekstarMatchInfo.week_star_medals[i].light_time*1000).format("yyyy/MM/dd");
                    
                }
            }

            var guardConStr = "<div><p class='tips_w'>"+weekstarMatchInfo.tips+"<a href='"+weekstarMatchInfo.guardRuleUrl+"' class='knowmore target-blank' target='__blank'>了解守护规则<i></i></a></p></div>";
            $("#weekstarContainer").children().remove();
            if(weekstarMatchInfo.status == 0){//成功
                $("#weekstarContainer").html("");
                if(weekstarMatchInfo.total_score > 999999){
                    weekstarMatchInfo.total_score = "999999+";
                }
                if(weekstarMatchInfo.total_rank > 9999){
                    weekstarMatchInfo.total_rank = "9999+";
                }
                if(weekstarMatchInfo.sub_rank > 9999){
                    weekstarMatchInfo.sub_rank = "9999+";
                }
                
                if(weekstarMatchInfo.sub_level >= 10){
                    weekstarMatchInfo.no = 2;
                    weekstarMatchInfo.sub_level1 = parseInt(weekstarMatchInfo.sub_level / 10);
                    weekstarMatchInfo.sub_level2 = weekstarMatchInfo.sub_level % 10;
                } else {
                    weekstarMatchInfo.no = 1;
                }
                var anchorweekstarTmpl = weekstarCon.tmpl(weekstarMatchInfo);
                anchorweekstarTmpl.appendTo($("#weekstarContainer"));
                $("#weekstarContainer").append(guardConStr);
                var tipsArr = $("#weekstar-icon .weekstar-icon .hover-tips");
                $("#weekstar-icon .weekstar-icon .weekstar-icon-bg,#weekstar-icon .weekstar-icon .hover-tips").off("mouseover").on("mouseover", function(){
                    var index = $(this).attr("index");
                    $(tipsArr[index]).show();
                }).off("mouseout").on("mouseout", function(){
                    var index = $(this).attr("index");
                    $(tipsArr[index]).hide();
                });
            } else if(weekstarMatchInfo.status == 1){//比赛未开始 
                //$("#weekstarContainer").addClass("fontChange");
                $("#weekstarContainer").html("<div class='fontChange'>赛季未开启，敬请期待</div>"+guardConStr);
            } else if(weekstarMatchInfo.status == 2){//主播未参赛
                //$("#weekstarContainer").addClass("fontChange");
                $("#weekstarContainer").html("<div class='fontChange'>该主播未参赛</div>"+guardConStr);
            } else if(weekstarMatchInfo.status == 3){//开赛第一周，榜上无数据
                //$("#weekstarContainer").addClass("fontChange");
                $("#weekstarContainer").html("<div class='fontChange'>赛季已开启，快来角逐王者桂冠</div>"+guardConStr);
            }
            fansCardTmpl = null;
            fansCardCon = null;
            backupGroupTmpl = null;
            backupGroupCon = null;
            badgeTmpl = null;
            badgeCon = null;
            anchorTip1Tmpl = null;
            anchorTip1Con = null;
            anchorTip2Tmpl = null;
            anchorTip2Con = null;
        }
    },
    mouseoverBadge: function () {
        $m('body').on('mouseover', 'span[class^="badge"]', function (e) {
            var badge_id = $m(this).attr('mgc_data');
            var tips = '';
            if (badge_id == '0') {
                return;
            } else if (badge_id) {
                tips = window.mgc.config.BADGE_CONFIG[badge_id].badge_tips;
            }
            MGC.susTipsBadge(e, 1, tips);
        });
    },
    mouseoutBadge: function () {
        $m('body').on('mouseout', 'span[class^="badge"]', function (e) {
            MGC.susTipsBadge(e, 0);
        });
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
    isFull:false,
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
                break;
            case 1:
                msg = '土豪，您的关注达到上限啦~';
                MGCData.difFollowAnchor[MGCData.isAnchorOrRoom].followAnchor = 0;
                MGC_CommResponse.IsMaxFollow();
        
                break;
            case 4:
                MGCData.difFollowAnchor[MGCData.isAnchorOrRoom].followAnchor = 1;
                break;
            case 9:
                msg = '土豪，您的关注达到上限啦~升级就能提高上限呢！';
                MGCData.difFollowAnchor[MGCData.isAnchorOrRoom].followAnchor = 0;
                MGC_CommResponse.NotMaxFollow();
                break;
            /*case 1:
                MGC_CommResponse.isFull = true;
                break;
            
			case 0:
				msg = '恭喜你，关注成功';
				break;
			case 1:
				msg = '您的关注列表已达到上限';
				break;
			case 2:
				msg = '关注主播失败，未找到该主播';
				break;
			case 3:
				msg = '关注主播失败，未知错误';
				break;
			case 4:
				msg = '关注失败，该主播已经在您的关注列表中了。';
				break;
			case 5:
				msg = '操作频繁，请稍后再试。';
				break;
		*/
            default: break;
        }
        if (obj.res == 0 || obj.res == 4) {
            MGC_anchorCardResponse.refreshFollowInfo('add', anchor_id);
            /*var msg = "恭喜您，成功关注该主播";*/
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
            MGC_anchorCardResponse.refreshFollowInfo('cancel', anchor_id);
        }
        if (msg != '') {
            // alert(msg);
        }
    },
	//是否关注了主播 删除
    isFollowAnchor: function() {
        var _reqStr = "{\"op_type\":" + OpType.FollowAnchorOpType + ", \"AnchorId\":" + MGCData.anchorID + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.isFollowAnchorCallBack");
    },

    //取消和关注主播
    followAnchorAction: function (type, anchorId, name, isFollow) {
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
                $m('.sus_tips_').css({ 'width': '0', 'padding': '0' });
                ++fansNum;
                $m('.si_fans_num').text(fansNum + ' 位粉丝');
                MGCData.difFollowAnchor[0].followAnchor = 1;
            }            
        } else {
            $m('.btn_care').text('+关注');
            
            // if(type != 'over'){
                --fansCardNum;
            // }
            
            fansCardNum = fansCardNum <= 0 ? 0 : fansCardNum;
            $m('.fans').text(fansCardNum);
            $m('.btn_care').attr('isFollow', 0);
            if (anchor_id == MGCData.anchorID) {
                $m('.si_attention').text('关注');
                $m('.sus_tips_').text('关注TA,主播直播时可收到通知');
                if (filename == "showroom.shtml") {
                    $m('.sus_tips_').css('padding','5px');
                }
                $m('.sus_tips_').css('width','163px');                
                // if(type != 'over'){
                    --fansNum;
                // }
                
                $m('.si_fans_num').text(fansNum + ' 位粉丝');
                MGCData.difFollowAnchor[0].followAnchor = 0;
            }
        }
    },
		allImpressionInfoCallBack:function(obj, anchorId){
		$m.each(obj.impression,function(k,v){
			MGC_ANCHORIMPRESSION[v.impressionID] = v.impressionName;
		});
		MGC_anchorCardRequest.myImpressionInfo(anchorId);
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
        MGC_Comm.sendMsg(_reqStr, "MGC_anchorCardRequest.editImpressionCallBack",_reqObj.anchor_id);
    },
	//我对主播的印象
    myImpressionInfoCallBack: function(obj, anchorId) {
        console.log("我对主播的印象的返回" + obj);
        obj = MGC_Comm.strToJson(obj);

        if(obj.status == 65)
        {
            window.mgc.common_logic.CheckNameError(113);
            return;
        }

        var _myImpression = _myTmpArr = new Array();
        if (obj.data) {
            _myImpression = obj.data;
        }
        var impressionAnchorId = anchorId;
        $m.each(_myImpression, function(k, v) {
            _myTmpArr[v] = 1;
        });
        //绑定编辑印象
        var _allImpression = {
            "impressionShowHtml": ""
        };
        $m.each(MGC_ANCHORIMPRESSION, function(k, v) {
            var _selectClass = _myTmpArr[k] ? "current" : "";
            _allImpression.impressionShowHtml += '<a class="selectImpression ' + _selectClass + '" impressionId="' + k + '" href="javascript:void(0);">' + v + '</a>';
        });
        var allImpressionCon = $m('#allImpressionTmpl');
        var allImpressionTmpl;
        var allImpressionContainer = $m('#allImpressionContainer');
        allImpressionContainer.children().remove();
        allImpressionTmpl = allImpressionCon.tmpl(_allImpression);
        allImpressionTmpl.appendTo(allImpressionContainer);
        //增加主播ID
        $m('.submitImpression').attr('anchorId', impressionAnchorId);
        //动画渲染
        $m('.selectImpression').off('click').on('click', function() {
            $m(this).toggleClass('current');
        });
        $m('.clearImpression').off('click').on('click', function() {
            $m('.selectImpression').removeClass('current');
        });
        //绑定最终的编辑印象submit按钮
        $m('.submitImpression').off('click').on('click', function() {
            var selecedImpression = $m('.selectImpression');
            var thisAnchorId = $m(this).attr('anchorId');
            var _impressionArr = new Array();
            $m.each(selecedImpression, function(k, v) {
                var _tmpObj = {};
                var _isPush = 0;
                _tmpObj.impressionID = v.getAttribute('impressionid');
                if (v.className.indexOf('current') != -1) {
                    //被选中了
                    _tmpObj.editType = 0;
                    if (_myImpression.indexOf(parseInt(_tmpObj.impressionID)) == -1) { //不在之前自己已经添加的印象中
                        _isPush = 1;
                    }
                } else {
                    _tmpObj.editType = 1;
                    if (_myImpression.indexOf(parseInt(_tmpObj.impressionID)) != -1) { //在之前自己已经添加的印象中
                        _isPush = 1;
                    }
                }
                if (_isPush == 1) {
                    _impressionArr.push(_tmpObj);
                }
            });
            if (_impressionArr.length > 0) {
            	MGC_anchorCardResponse.editImpression(_impressionArr, thisAnchorId);
            }
        });
      
        window.mgc.popmanager.layerControlShow($m("#pop_anchor"), 4, 1, 2);
        $m('#pop_anchor').css('width', '438px');
        $m('#pop_anchor').centerDisp();
        $m('#pop_anchor').find(".pop_close").off('click').on('click', function () {
            window.mgc.popmanager.layerControlHide($m("#pop_anchor"), 4, 1);
        });
        $m('#allImpression').jScrollPane({
            autoReinitialise: true,
            animateScroll: true
        });
        
        var $jsp = $m('#allImpression').data('jsp');
        if($jsp){
            $jsp.initScroll();
        }

        allImpressionTmpl = null;
        allImpressionCon = null;
    }
};

$m(function(){
    try {
        $m('#aninfo_con1 .fans_list').jScrollPane({ autoReinitialise: true, animateScroll: true, autoReinitialiseDelay: 100, verticalDragMinHeight: 20 });
        var $jsp = $m('#aninfo_con1 .fans_list').data('jsp');
        if($jsp){
            $jsp.initScroll();
        }

    } catch (e) {

    }
});
$m.extend(MGC_CommRequest, MGC_anchorCardRequest);
$m.extend(MGC_CommResponse, MGC_anchorCardResponse);