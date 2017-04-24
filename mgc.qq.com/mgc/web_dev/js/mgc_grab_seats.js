/**
 * Created by ouyangtaili on 2016/3/16.
 * 守护宝座及嘉宾席抢座相关逻辑
 *
 *    守护宝座抢座：
 *    守护宝座被抢通知： 231          
 *    守护宝座抢座回调： 230
 *    刷新守护宝座信息： 232
 *
 *    贵族抢座：
 *    其他人抢座成功通知： 276
 *    刷新VIP座位信息： 277  
 *    贵族保护时间通知：278           
 *    座位被抢通知：275
 *    座位席满触发走马灯通知：279      
 * 
 */
var VIP_GRAB = {

    /**
    * 座位数据
    */
    seats: [],
    seatIndex: 0,
    cost: 0,
    free_times: 0,
    time: 0,
    cost_seat: false,
    vip_time: 0,
    nick: 0,
    zone: 0,
    oldNickObj: [],
    oldNick: [],
    vipCount: 0,

    /**
     * 初始化
     */
    init: function() {

    },

    /**
     * 某个id的玩家是否在座位上
     */
    isSeat: function(id) {
        for (var i = 0; i < VIP_GRAB.seats.length; i++) {
            if (VIP_GRAB.seats[i].m_player_id == id) {
                return true;
            }
        }
        return false;
    },
    //嘉宾席
    getVipTime: function(obj) {
        console.log('嘉宾保护时间' + JSON.stringify(obj));
        VIP_GRAB.vip_time = obj.seat_time[3].time;
    },


    //嘉宾席
    getVip: function(obj) {
        console.log('嘉宾统计次数:277:' + JSON.stringify(obj));
        var _vipInfo = obj.list;
        var _len = obj.list.length;
        var currentTime = new Date().toLocaleString();


        var newNickObj = [];
        var newNick = [];

        if (VIP_GRAB.vipCount == 0) {
            $m.each(_vipInfo, function(k, v) {
                VIP_GRAB.oldNick.push(v.nick);
                VIP_GRAB.oldNickObj.push(v);
            });
        } else {
            $m.each(_vipInfo, function(k, v) {
                newNick.push(v.nick);
                newNickObj.push(v);
            });
        }
        if (VIP_GRAB.vipCount > 0) {
            $m.each(VIP_GRAB.oldNick, function(k, v) {
                //if (v != newNick[k]) {
                VIP_GRAB.oldNickObj[k] = newNickObj[k];
                VIP_GRAB.refreshSeat(newNickObj[k], k);
                //}
            });
        }
        VIP_GRAB.vipCount++;
        if (VIP_GRAB.vipCount == 1) {
            //糊墙
            var _vipInfo_3 = $m.extend(true, {}, _vipInfo[3]);
            var _vipInfo_5 = $m.extend(true, {}, _vipInfo[5]);
            _vipInfo[3] = _vipInfo_5;
            _vipInfo[5] = _vipInfo_3;
            $m.each(_vipInfo, function(k, v) {
                v.num = 8 - k;
                //          v.liClass = "z" + _tmp + " vipShowTips";
                if (window.mgc.tools.is_live_room()) {
                    v.liClass = " vipShowTips";
                    v.vipIclass = '';
                    v.index = k;
                    if (v.player_id != 0) {
                        if (v.pic_url == '') {
                            if (v.gender == 1) {
                                v.pic_url = HeadImgPath + "default_male.png?v=3_8_8_2016_15_4_final_3";
                            } else if (v.gender == 0) {
                                v.pic_url = HeadImgPath + "default_female.png?v=3_8_8_2016_15_4_final_3";
                            }
                        }
                    } else {
                        v.pic_url = '';
                    }
                    v.vipP = 'sv_' + v.vip_level + '_c';
                    v.vipI = 'sv_' + v.vip_level;
                } else {
                    if (SKIN.level < 1) {

                        v.liClass = " vipShowTips";
                        v.vipIclass = '';
                        v.index = k;
                        if (v.player_id != 0) {
                            if (v.pic_url == '') {
                                if (v.gender == 1) {
                                    v.pic_url = HeadImgPath + "default_male.png?v=3_8_8_2016_15_4_final_3";
                                } else if (v.gender == 0) {
                                    v.pic_url = HeadImgPath + "default_female.png?v=3_8_8_2016_15_4_final_3";
                                }
                            }
                        } else {
                            v.pic_url = '';
                        }
                        v.vipP = 'sv_' + v.vip_level + '_c';
                        v.vipI = 'sv_' + v.vip_level;
                    } else {
                        v.liClass = " vipShowTips";
                        v.vipIclass = '';
                        v.index = k >= 3 ? 8 - k : k;
                        //v.index = k;
                        if (!(window.mgc.tools.supportCss3('border-radius'))) {
                            v.ieFlag = true;
                            if (v.player_id != 0) {
                                if (v.pic_url == '') {
                                    if (v.gender == 1) {
                                        v.pic_url = HeadImgPath + "default_male.png?v=3_8_8_2016_15_4_final_3";
                                    } else if (v.gender == 0) {
                                        v.pic_url = HeadImgPath + "default_female.png?v=3_8_8_2016_15_4_final_3";
                                    }
                                }
                                v.vipI = 'sv_0';
                            } else {
                                v.pic_url = '';
                                v.vipI = 'sv_0';
                            }
                        } else {
                            if (v.player_id != 0) {
                                if (v.pic_url == '') {
                                    if (v.gender == 1) {
                                        v.pic_url = HeadImgPath + "default_male.png?v=3_8_8_2016_15_4_final_3";
                                    } else if (v.gender == 0) {
                                        v.pic_url = HeadImgPath + "default_female.png?v=3_8_8_2016_15_4_final_3";
                                    }
                                }
                                v.vipI = 'sv_1';
                            } else {
                                v.pic_url = '';
                                v.vipI = 'sv_0';
                            }
                        }
                        v.vipP = 'sv_' + v.vip_level + '_c';

                    }
                }
                v.zoneName = v.zoneName != "" ? (v.zoneName == "梦工厂" ? v.zoneName : "炫舞-" + v.zoneName) : "";
                v.nickColor = v.vip_level == 0 ? "#fff" : v.vip_level == 1 ? "#1a6b00" : v.vip_level == 2 ? "#006772" : v.vip_level == 3 ? "#0a57af" : v.vip_level == 4 ? "#8f00b1" : "#ae5600";
                v.vipName = v.vip_level == 1 ? "近卫" : v.vip_level == 2 ? "骑士" : v.vip_level == 3 ? "将军" : v.vip_level == 4 ? "亲王" : v.vip_level == 5 ? "皇帝" : "";
                v.status == 0 ? "icon_lingqu" : v.status == 1 ? "icon_yilingqu" : "icon_bukelingqu";
                if (parseInt(VIP_GRAB.seatIndex) == v.index) {
                    if ((v.nick == '') && (v.zone == '')) {
                        //隐藏成员名片
                        window.mgc.popmanager.layerControlHide($j(".card_tips"), 1, 2);
                    }
                }
            });
            VIP_GRAB.seats = obj.list;
            var vipCon = '';
            var vipTmpl;
            var vipContainer = '';
            if (window.mgc.tools.is_live_room()) {
                vipCon = $m('#vipTmpl');
                vipContainer = $m('#vipContainer');
            } else {
                if (SKIN.level < 1) {
                    vipCon = $m('#vipTmpl');
                    vipContainer = $m('#vipContainer');
                } else {
                    vipCon = $m('#skinTmpl');
                    vipContainer = $m('#vipContainerSkin');
                }
            }
            vipTmpl = vipCon.tmpl(_vipInfo);
            vipContainer.html("").append(vipTmpl);
            $m.each(_vipInfo, function(k, v) {
                MGC_Comm.initSkinGrabFlash(k);
            })
            vipTmpl = null;
            vipCon = null;
        }
        //节日活动
        window.mgc.tools.ACT.DO_ACT();
        $m('.vipShowTips').off('click').on('click', function() {
            mgc.common_contral.mgc_comm.eventInfo = MGC.getEvent();
            var _this = $m(this).find("i");
            var name = _this.attr('name');
            var zone = _this.attr('zone').replace("炫舞-", "");
            VIP_GRAB.seatIndex = _this.attr('data-seatid');
            VIP_GRAB.cost = _this.attr('data-cost');
            VIP_GRAB.time = _this.attr('protect_time');
            //alert('获取的个人名片信息——————VIP_GRAB.time' + _this.attr('protect_time'));
            VIP_GRAB.begin_time = _this.attr('begin_time');
            VIP_GRAB.cost_seat = _this.attr('cost_seat');
            VIP_GRAB.nick = name;
            VIP_GRAB.zone = zone;
            if (name != '抢座' && zone != '') {
                card_source = 3;
                VIP_GRAB.getPlayerInfoGrabChire(name, zone);
            } else {
                VIP_GRAB.getPlayerInfoGrabChireNull();
            }
        });

        $m(".vipShowTips").delegate("img", "click", function() {
            mgc.common_contral.mgc_comm.eventInfo = MGC.getEvent();
            var _this = $m(this).find("i");
            var name = _this.attr('name');
            var zone = _this.attr('zone').replace("炫舞-", "");
            VIP_GRAB.seatIndex = _this.attr('data-seatid');
            VIP_GRAB.cost = _this.attr('data-cost');
            VIP_GRAB.time = _this.attr('protect_time');
            //alert('获取的个人名片信息——————VIP_GRAB.time' + _this.attr('protect_time'));
            VIP_GRAB.begin_time = _this.attr('begin_time');
            VIP_GRAB.cost_seat = _this.attr('cost_seat');
            VIP_GRAB.nick = name;
            VIP_GRAB.zone = zone;
            if (name != '抢座' && zone != '') {
                console.log('抢座座位保护开始测试方法--有人座位');
                card_source = 3;
                VIP_GRAB.getPlayerInfoGrabChire(name, zone);
            } else {
                console.log('抢座座位保护开始测试方法--无人座位');
                VIP_GRAB.getPlayerInfoGrabChireNull();
            }
        });

        $m('.vipShowTips').on("mouseenter", function(e) {
            $m(this).find('span').eq(0).show();
        });

        $m('.vipShowTips').on('mouseleave', function(e) {
            $m(this).find('span').eq(0).hide();
        });

        MGC_Comm.initGrabFlash();
        clearTimeout(VIP_GRAB.skinGrabEffects);

        obj = null;
        _vipInfo = null;
    },
    //vip贵宾-抢座功能
    vipGrab: function () {
        console.log('是否隐身——发抢座请求（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
        //发服务器请求       
        var _reqStr = "{\"op_type\":" + OpType.GrapVIP + ", \"cost\":" + VIP_GRAB.cost + ", \"seat_index\":" + VIP_GRAB.seatIndex + "}";
        MGC_Comm.sendMsg(_reqStr, "VIP_GRAB.vipGrabCallBack");
    },
    //vip贵宾-抢座回调
    vipGrabCallBack: function (obj) {
        console.log('是否隐身——抢座请求回调方法里（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
        console.log("嘉宾统计次数:276:" + JSON.stringify(obj));
        if (VIP_GRAB.oldNick[obj.seat_index] != obj.seatinfo.nick) {
            VIP_GRAB.oldNickObj[obj.seat_index] = obj.seatinfo;
            $m.each(VIP_GRAB.oldNickObj, function(k, v) {
                VIP_GRAB.oldNick[k] = v.nick;
            });
        }
        console.log("嘉宾统计次数:276:1");
        var seat_index = obj.seat_index;
        VIP_GRAB.playerIdMy = obj.seatinfo.player_id;
        if (obj.free_times != -1) {
            VIP_GRAB.free_times = obj.free_times;
            VIP_GRAB.seatIndex = String(obj.seat_index);
        }
        VIP_GRAB.cost_seat = obj.seatinfo.cost_seat;
        console.log("嘉宾统计次数:276:2");
        var numId = 0, pic_url = '', nickColor = '', vipName = '', headURLBg = '';
        //座位tips坐标
        if (seat_index == 0) {
            numId = 8;
        } else if (seat_index == 1) {
            numId = 7;
        } else if (seat_index == 2) {
            numId = 6;
        } else if (seat_index == 3) {
            numId = 5;
        } else if (seat_index == 4) {
            numId = 4;
        } else if (seat_index == 5) {
            numId = 3;
        }
        console.log("嘉宾统计次数:276:3");
        //头像加载
        if (obj.seatinfo.pic_url == '') {
            if (obj.seatinfo.gender == 1) {
                pic_url = HeadImgPath + "default_male.png?v=3_8_8_2016_15_4_final_3";
            } else if (obj.seatinfo.gender == 0) {
                pic_url = HeadImgPath + "default_female.png?v=3_8_8_2016_15_4_final_3";
            }
            headURLBg = 'sv_1';
        } else {
            pic_url = obj.seatinfo.pic_url;
            headURLBg = 'sv_1';
        }
        console.log("嘉宾统计次数:276:4");
        //贵族名字颜色、贵族名字
        nickColor = obj.seatinfo.vip_level == 0 ? "#fff" : obj.seatinfo.vip_level == 1 ? "#1a6b00" : obj.seatinfo.vip_level == 2 ? "#006772" : obj.seatinfo.vip_level == 3 ? "#0a57af" : obj.seatinfo.vip_level == 4 ? "#8f00b1" : "#ae5600";
        vipName = obj.seatinfo.vip_level == 1 ? "近卫" : obj.seatinfo.vip_level == 2 ? "骑士" : obj.seatinfo.vip_level == 3 ? "将军" : obj.seatinfo.vip_level == 4 ? "亲王" : obj.seatinfo.vip_level == 5 ? "皇帝" : "";

        switch (parseInt(obj.res)) {
            case 0:
                console.log('是否隐身——抢座请求回调方法——抢座成功里（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                mgc.consts.MGCData.invisible = false;
                console.log("嘉宾统计次数:276:5");
                //开播时候
                if (MGCData.roomStatus == 2) {
                    console.log('是否隐身——抢座请求回调方法——抢座成功里——开播状态（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                    //流星效果
                    try {
                        console.log("嘉宾统计次数:276:5:1");
                        VIP_GRAB.seatIndex = String(obj.seat_index);
                        if (mgc.tools.is_live_room()) {
                            MGC_Comm.showGrabFlash(String(parseInt(VIP_GRAB.seatIndex) + 4));
                            console.log("嘉宾统计次数:276:5:2");
                        } else {
                            if (typeof (SKIN) != 'undefined') {
                                if (SKIN.level < 1) {
                                    MGC_Comm.showGrabFlash(String(parseInt(VIP_GRAB.seatIndex) + 4));
                                    console.log("嘉宾统计次数:276:5:3");
                                } else if (SKIN.level >= 1 && SKIN.level <= 9) {
                                    console.log("嘉宾统计次数:276:5:4");
                                    if ($m('.auto_seatVip').width() == 321) {
                                        console.log("嘉宾统计次数:276:5:5");
                                        MGC_Comm.initSkinShrinkGrabFlash();
                                        MGC_Comm.showSkinShrinkGrabSeat();
                                        console.log("嘉宾统计次数:276:5:6");
                                    } else {
                                        console.log("嘉宾统计次数:276:5:7:VIP_GRAB.seatIndex:" + VIP_GRAB.seatIndex + ":seatIndex:" + obj.seat_index);
                                        MGC_Comm.showSkinGrabFlash(parseInt(VIP_GRAB.seatIndex));
                                        console.log("嘉宾统计次数:276:5:8");
                                    }
                                }
                            }
                        }
                    } catch (e) {
                        console.log("嘉宾统计次数:276:5:error:" + e.message);
                    }
                }

                

                console.log("嘉宾统计次数:276:6");
                if (mgc.tools.is_live_room()) {
                    //替换被抢座的位置--刷新自己座位
                    $m('#vipContainer').find('li').eq(obj.seat_index).html('<img src="' + pic_url + '" width="65" height="65" alt=""><span class="sv_' + obj.seatinfo.vip_level + '" style="display: none;" ></span><p zonename="' + obj.seatinfo.zone + '" name="' + obj.seatinfo.nick + '" class="sv_' + obj.seatinfo.vip_level + '_c  vipPopClass" onmouseover=MGC.susTipsLvList(event,1,"' + obj.seatinfo.level + '|@abc' + obj.seatinfo.wealth_level + '|@abc' + obj.seatinfo.video_room_wealth + '|@abc' + vipName + '|@abc' + numId + '|@abc' + nickColor + '|@abc' + obj.seatinfo.zone + '",this,10,105,"sus_tips_LvList",1); onmouseout=MGC.susTipsLvList(event,0,"",this,10,105,"sus_tips_LvList",1)>' + obj.seatinfo.nick + '</p><i class="sv_' + obj.seatinfo.vip_level + ' vipPopClass" data-playerid="' + obj.seatinfo.player_id + '" data-seatid="' + obj.seat_index + '" data-cost="' + obj.seatinfo.take_cost + '" zone="' + obj.seatinfo.zone + '" protect_time="' + obj.seatinfo.protect_time + '" begin_time="' + obj.seatinfo.begin_time + '" taken_cnt="' + obj.seatinfo.taken_cnt + '" cost_seat="' + obj.seatinfo.cost_seat + '" name="' + obj.seatinfo.nick + '" onmouseover=MGC.susTipsLvList(event,1,"' + obj.seatinfo.level + '|@abc' + obj.seatinfo.wealth_level + '|@abc' + obj.seatinfo.video_room_wealth + '|@abc' + vipName + '|@abc' + numId + '|@abc' + nickColor + '|@abc' + obj.seatinfo.zone + '",this,10,105,"sus_tips_LvList",1); onmouseout=MGC.susTipsLvList(event,0,"",this,10,105,"sus_tips_LvList",1);></i><span class="april_fool_s_day_04"></span>');
                    VIP_GRAB.seats[obj.seat_index].m_player_id = obj.seatinfo.player_id;
                    $m('.layer-video .sl_vip .sv_list li p,.layer-video .sl_vip .sv_list li i').off("mouseover,mouseout").on("mouseover", function(){
                        var grabSpan = $m(this).parent().find('span').eq(0);
                        grabSpan.css('display', 'block');
                    }).on("mouseout", function(){
                        $m('.layer-video .sl_vip .sv_list li p,.layer-video .sl_vip .sv_list li i').css('display', 'block');
                        $m(this).parent().find('p').html($m(this).attr('name'));
                        var grabSpan = $m(this).parent().find('span').eq(0);
                        grabSpan.css('display', 'none');
                    });
                } else if (SKIN.level < 1) {
                    //替换被抢座的位置--刷新自己座位
                    $m('#vipContainer').find('li').eq(obj.seat_index).html('<img src="' + pic_url + '" width="65" height="65" alt=""><span class="sv_' + obj.seatinfo.vip_level + '" style="display: none;" ></span><p zonename="' + obj.seatinfo.zone + '" name="' + obj.seatinfo.nick + '" class="sv_' + obj.seatinfo.vip_level + '_c  vipPopClass" onmouseover=MGC.susTipsLvList(event,1,"' + obj.seatinfo.level + '|@abc' + obj.seatinfo.wealth_level + '|@abc' + obj.seatinfo.video_room_wealth + '|@abc' + vipName + '|@abc' + numId + '|@abc' + nickColor + '|@abc' + obj.seatinfo.zone + '",this,10,105,"sus_tips_LvList",1); onmouseout=MGC.susTipsLvList(event,0,"",this,10,105,"sus_tips_LvList",1)>' + obj.seatinfo.nick + '</p><i class="sv_' + obj.seatinfo.vip_level + ' vipPopClass" data-playerid="' + obj.seatinfo.player_id + '" data-seatid="' + obj.seat_index + '" data-cost="' + obj.seatinfo.take_cost + '" zone="' + obj.seatinfo.zone + '" protect_time="' + obj.seatinfo.protect_time + '" begin_time="' + obj.seatinfo.begin_time + '" taken_cnt="' + obj.seatinfo.taken_cnt + '" cost_seat="' + obj.seatinfo.cost_seat + '" name="' + obj.seatinfo.nick + '" onmouseover=MGC.susTipsLvList(event,1,"' + obj.seatinfo.level + '|@abc' + obj.seatinfo.wealth_level + '|@abc' + obj.seatinfo.video_room_wealth + '|@abc' + vipName + '|@abc' + numId + '|@abc' + nickColor + '|@abc' + obj.seatinfo.zone + '",this,10,105,"sus_tips_LvList",1); onmouseout=MGC.susTipsLvList(event,0,"",this,10,105,"sus_tips_LvList",1);></i><span class="april_fool_s_day_04"></span>');
                    VIP_GRAB.seats[obj.seat_index].m_player_id = obj.seatinfo.player_id;
                    $m('.layer-video .sl_vip .sv_list li p,.layer-video .sl_vip .sv_list li i').off("mouseover,mouseout").on("mouseover", function(){
                        var grabSpan = $m(this).parent().find('span').eq(0);
                        grabSpan.css('display', 'block');
                    }).on("mouseout", function(){
                        $m('.layer-video .sl_vip .sv_list li p,.layer-video .sl_vip .sv_list li i').css('display', 'block');
                        $m(this).parent().find('p').html($m(this).attr('name'));
                        var grabSpan = $m(this).parent().find('span').eq(0);
                        grabSpan.css('display', 'none');
                    });
                } else {
                    //替换被抢座的位置--刷新自己座位  headURLBg
                    console.log("嘉宾统计次数:276:7");
                    if (!(window.mgc.tools.supportCss3('border-radius'))) {
                        $m('#vipContainerSkin').find('li i[data-seatid=' + obj.seat_index + ']').parent().html('<img src="' + pic_url + '" width="48" height="48" class="ieStyle" alt=""><span class="sv_0" style="display: none;" ></span><p zonename="' + obj.seatinfo.zone + '" name="' + obj.seatinfo.nick + '" class="sv_0_c  vipPopClass">' + obj.seatinfo.nick + '</p><i class="sv_0 vipPopClass" data-playerid="' + obj.seatinfo.player_id + '" data-seatid="' + obj.seat_index + '" data-cost="' + obj.seatinfo.take_cost + '" zone="' + obj.seatinfo.zone + '" protect_time="' + obj.seatinfo.protect_time + '" begin_time="' + obj.seatinfo.begin_time + '" taken_cnt="' + obj.seatinfo.taken_cnt + '" cost_seat="' + obj.seatinfo.cost_seat + '" name="' + obj.seatinfo.nick + '"></i><span class="april_fool_s_day_04"></span>');
                    } else {
                        $m('#vipContainerSkin').find('li i[data-seatid=' + obj.seat_index + ']').parent().html('<img src="' + pic_url + '" width="65" height="65" alt=""><span class="sv_0" style="display: none;" ></span><p zonename="' + obj.seatinfo.zone + '" name="' + obj.seatinfo.nick + '" class="sv_0_c  vipPopClass">' + obj.seatinfo.nick + '</p><i class="' + headURLBg + ' vipPopClass" data-playerid="' + obj.seatinfo.player_id + '" data-seatid="' + obj.seat_index + '" data-cost="' + obj.seatinfo.take_cost + '" zone="' + obj.seatinfo.zone + '" protect_time="' + obj.seatinfo.protect_time + '" begin_time="' + obj.seatinfo.begin_time + '" taken_cnt="' + obj.seatinfo.taken_cnt + '" cost_seat="' + obj.seatinfo.cost_seat + '" name="' + obj.seatinfo.nick + '"></i><span class="april_fool_s_day_04"></span>');
                    }
                    console.log("嘉宾统计次数:276:seat_index:" + obj.seat_index);
                    VIP_GRAB.seats[obj.seat_index >= 3 ? 8 - obj.seat_index : obj.seat_index].m_player_id = obj.seatinfo.player_id;
                    $m('.vipShowTips').on("mouseenter", function(e) {
                        $m(this).find('span').eq(0).show();
                    });

                    $m('.vipShowTips').on('mouseleave', function(e) {
                        $m(this).find('span').eq(0).hide();
                    });

                }



                //节日活动
                window.mgc.tools.ACT.DO_ACT();

                //隐藏成员名片
                window.mgc.popmanager.layerControlHide($j(".card_tips"), 1, 2);
                $j(".card_tips").hide();
                break;
            case 3:
                console.log('是否隐身——抢座请求回调方法——抢座失败里——座位被抢——未开播状态（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '座位被抢了，请稍后再试！';
                dialog.BtnName = '知道了';
                MGC_Comm.CommonDialog(dialog);
                break;

            case 4:
                console.log('是否隐身——抢座请求回调方法——抢座失败里——炫豆不足——未开播状态（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.BtnNum = 2;
                dialog.BtnName = '立即充值';
                dialog.BtnName2 = '算了';
                dialog.url = "http://pay.qq.com/ipay/index.shtml?c=qxwwqp";
                dialog.Note = '亲，您的炫豆不够了，快去充值吧！~';
                MGC_Comm.CommonDialog(dialog);
                break;
            case 5:
                console.log('是否隐身——抢座请求回调方法——抢座失败里——座位暂时不能抢（5）——未开播状态（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '亲，座位暂时不能抢，请稍后再试！';
                dialog.BtnName = '知道了';
                MGC_Comm.CommonDialog(dialog);
                break;
            case 6:
                console.log('是否隐身——抢座请求回调方法——抢座失败里——座位暂时不能抢（亲王以上有保护时间）——未开播状态（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.BtnNum = 1;
                dialog.BtnName = '确定';
                dialog.Note = '亲，该座位暂时不能抢，等会儿再来吧！亲王及以上贵族可以拥有保护时间哦！';
                // dialog.BtnName = '开通贵族';
                // MGC_Comm.CommonDialog(dialog, mgc.common_contral.CommOpenVip.open);
                MGC_Comm.CommonDialog(dialog);
                break;
            case 7:
                console.log('是否隐身——抢座请求回调方法——抢座失败里——座位暂时不能抢（7）——未开播状态（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '亲，座位暂时不能抢，请稍后再试！';
                dialog.BtnName = '知道了';
                MGC_Comm.CommonDialog(dialog);
                break;
            case 8:
                console.log('是否隐身——抢座请求回调方法——抢座失败里——座位暂时不能抢（8）——未开播状态（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '亲，座位暂时不能抢，请稍后再试！';
                dialog.BtnName = '知道了';
                MGC_Comm.CommonDialog(dialog);
                break;
            case 9:
                console.log('是否隐身——抢座请求回调方法——抢座失败里——座位暂时不能抢（您在座位上）——未开播状态（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '亲，您已经在座位上了！';
                dialog.BtnName = '知道了';
                MGC_Comm.CommonDialog(dialog);
                break;
            case 10:
                console.log('是否隐身——抢座请求回调方法——抢座失败里——座位暂时不能抢（10）——未开播状态（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '亲，座位暂时不能抢，请稍后再试！';
                dialog.BtnName = '知道了';
                MGC_Comm.CommonDialog(dialog);
                break;
            default:
                console.log('是否隐身——抢座请求回调方法——抢座失败里——座位暂时不能抢（产品经理被抓走了）——未开播状态（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '产品经理被妖怪抓走了！请稍后再试！';
                MGC_Comm.CommonDialog(dialog);
                break;
        }
        obj = null;
    },
    refreshSeat: function(obj, n) {
        console.log('嘉宾统计次数276:refreshSeat' + JSON.stringify(obj));
        var numId = 0, pic_url = '', nickColor = '', vipName = '', nick = '', HeadImg = '', cssDisplay = '';
        nick = obj.nick;
        if (mgc.tools.is_live_room()|| SKIN.level < 1) {
            if (obj.nick == '') {
                pic_url = "http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_head_null.png?v=3_8_8_2016_15_4_final_3";
                headURLBg = 'sv_0_c';
            } else {
                if (obj.pic_url == '') {
                    if (obj.gender == 1) {
                        pic_url = HeadImgPath + "default_male.png?v=3_8_8_2016_15_4_final_3";
                    } else if (obj.gender == 0) {
                        pic_url = HeadImgPath + "default_female.png?v=3_8_8_2016_15_4_final_3";
                    }
                }
                else {
                    pic_url = obj.pic_url;
                    //pic_url = (pic_url.split("?v="))[0];
                }
            }
        } else {
            if (obj.nick == '') {
                obj.nick = "抢座";
                pic_url = obj.pic_url;
                cssDisplay = 'none';
                HeadImg = 'sv_0';
            } else {
                cssDisplay = 'block';
                if (obj.pic_url == '') {
                    if (obj.gender == 1) {
                        pic_url = HeadImgPath + "default_male.png?v=3_8_8_2016_15_4_final_3";
                    } else if (obj.gender == 0) {
                        pic_url = HeadImgPath + "default_female.png?v=3_8_8_2016_15_4_final_3";
                    }
                } else {
                    pic_url = obj.pic_url;
                    //pic_url = (pic_url.split("?v="))[0];
                }
                HeadImg = 'sv_1';
            }

        }
        if (obj.nick == '') {
            obj.nick = "抢座";
        }

        //贵族名字颜色、贵族名字
        nickColor = obj.vip_level == 0 ? "#fff" : obj.vip_level == 1 ? "#1a6b00" : obj.vip_level == 2 ? "#006772" : obj.vip_level == 3 ? "#0a57af" : obj.vip_level == 4 ? "#8f00b1" : "#ae5600";
        vipName = obj.vip_level == 1 ? "近卫" : obj.vip_level == 2 ? "骑士" : obj.vip_level == 3 ? "将军" : obj.vip_level == 4 ? "亲王" : obj.vip_level == 5 ? "皇帝" : "";


        if (mgc.tools.is_live_room()) {
            //替换被抢座的位置--刷新自己座位
            $m('#vipContainer').find('li').eq(n).html('<img src="' + pic_url + '" width="65" height="65" alt="" style="display:' + cssDisplay + '" ><span class="sv_' + obj.vip_level + '" style="display: none;" ></span><p zonename="' + obj.zone + '" name="' + obj.nick + '" class="sv_' + obj.vip_level + '_c  vipPopClass" onmouseover=MGC.susTipsLvList(event,1,"' + obj.level + '|@abc' + obj.wealth_level + '|@abc' + obj.video_room_wealth + '|@abc' + vipName + '|@abc' + numId + '|@abc' + nickColor + '|@abc' + obj.zone + '",this,10,105,"sus_tips_LvList",1); onmouseout=MGC.susTipsLvList(event,0,"",this,10,105,"sus_tips_LvList",1)>' + obj.nick + '</p><i class="sv_' + obj.vip_level + ' vipPopClass" data-playerid="' + obj.player_id + '" data-seatid="' + n + '" data-cost="' + obj.take_cost + '" zone="' + obj.zone + '" protect_time="' + obj.protect_time + '" begin_time="' + obj.begin_time + '" taken_cnt="' + obj.taken_cnt + '" cost_seat="' + obj.cost_seat + '" name="' + obj.nick + '" onmouseover=MGC.susTipsLvList(event,1,"' + obj.level + '|@abc' + obj.wealth_level + '|@abc' + obj.video_room_wealth + '|@abc' + vipName + '|@abc' + numId + '|@abc' + nickColor + '|@abc' + obj.zone + '",this,10,105,"sus_tips_LvList",1); onmouseout=MGC.susTipsLvList(event,0,"",this,10,105,"sus_tips_LvList",1);></i><span class="april_fool_s_day_04"></span>');

        } else if (SKIN.level < 1) {
            //替换被抢座的位置--刷新自己座位
            $m('#vipContainer').find('li').eq(n).html('<img src="' + pic_url + '" width="65" height="65" alt="" style="display:' + cssDisplay + '" ><span class="sv_' + obj.vip_level + '" style="display: none;" ></span><p zonename="' + obj.zone + '" name="' + obj.nick + '" class="sv_' + obj.vip_level + '_c  vipPopClass" onmouseover=MGC.susTipsLvList(event,1,"' + obj.level + '|@abc' + obj.wealth_level + '|@abc' + obj.video_room_wealth + '|@abc' + vipName + '|@abc' + numId + '|@abc' + nickColor + '|@abc' + obj.zone + '",this,10,105,"sus_tips_LvList",1); onmouseout=MGC.susTipsLvList(event,0,"",this,10,105,"sus_tips_LvList",1)>' + obj.nick + '</p><i class="sv_' + obj.vip_level + ' vipPopClass" data-playerid="' + obj.player_id + '" data-seatid="' + n + '" data-cost="' + obj.take_cost + '" zone="' + obj.zone + '" protect_time="' + obj.protect_time + '" begin_time="' + obj.begin_time + '" taken_cnt="' + obj.taken_cnt + '" cost_seat="' + obj.cost_seat + '" name="' + obj.nick + '" onmouseover=MGC.susTipsLvList(event,1,"' + obj.level + '|@abc' + obj.wealth_level + '|@abc' + obj.video_room_wealth + '|@abc' + vipName + '|@abc' + numId + '|@abc' + nickColor + '|@abc' + obj.zone + '",this,10,105,"sus_tips_LvList",1); onmouseout=MGC.susTipsLvList(event,0,"",this,10,105,"sus_tips_LvList",1);></i><span class="april_fool_s_day_04"></span>');

        } else {
            if (!(window.mgc.tools.supportCss3('border-radius'))) {
                //替换被抢座的位置--刷新自己座位
                $m('#vipContainerSkin').find('li i[data-seatid=' + n + ']').parent().html('<img src="' + pic_url + '" class="ieStyle" width="48" height="48" alt="" style="display:' + cssDisplay + '" ><span class="sv_0" style="display: none;" ></span><p zonename="' + obj.zone + '" name="' + obj.nick + '" class="sv_0_c  vipPopClass">' + obj.nick + '</p><i class="sv_0 vipPopClass" data-playerid="' + obj.player_id + '" data-seatid="' + n + '" data-cost="' + obj.take_cost + '" zone="' + obj.zone + '" protect_time="' + obj.protect_time + '" begin_time="' + obj.begin_time + '" taken_cnt="' + obj.taken_cnt + '" cost_seat="' + obj.cost_seat + '" name="' + obj.nick + '"></i><span class="april_fool_s_day_04"></span>');
            } else {
                //替换被抢座的位置--刷新自己座位
                $m('#vipContainerSkin').find('li i[data-seatid=' + n + ']').parent().html('<img src="' + pic_url + '" width="65" height="65" alt="" style="display:' + cssDisplay + '" ><span class="sv_0" style="display: none;" ></span><p zonename="' + obj.zone + '" name="' + obj.nick + '" class="sv_0_c  vipPopClass">' + obj.nick + '</p><i class="' + HeadImg + ' vipPopClass" data-playerid="' + obj.player_id + '" data-seatid="' + n + '" data-cost="' + obj.take_cost + '" zone="' + obj.zone + '" protect_time="' + obj.protect_time + '" begin_time="' + obj.begin_time + '" taken_cnt="' + obj.taken_cnt + '" cost_seat="' + obj.cost_seat + '" name="' + obj.nick + '"></i><span class="april_fool_s_day_04"></span>');
            }
        }
    },
    lostVip: function(obj) {
        VIP_GRAB.seatIndex = obj.seat_index;
        var dialog = {};
        dialog.Title = '提示信息';
        dialog.Note = '亲，座位被' + obj.player_nick + '抢走了，立即用' + obj.cost + '炫豆抢回座位！';
        dialog.BtnNum = 2;
        dialog.BtnName = '我有钱';
        dialog.BtnName2 = '我怂了';
        VIP_GRAB.cost = obj.cost;
        MGC_Comm.CommonDialog(dialog, VIP_GRAB.vipGrab);

		$("#CancelBtn").css("display", "inline-block");
        obj = null;
        dialog = null;
    },
    GrabMarquee: function(obj) {
        obj.MsgStr = obj.msg;
        obj.msg = '';
        MGC.marqueeArr(obj);
        obj = null;
    },
    grabFreeTime: function(obj) {
        VIP_GRAB.free_times = obj.free_times;
    },
    grabOthor: function(obj) {
        VIP_GRAB.seatIndex = Strong(obj.seat_index);
        if (MGCData.roomStatus == 2) {
            //流星效果
            VIP_GRAB.showGrabFlash(String(parseInt(VIP_GRAB.seatIndex) + 4), 2);

        }
    },
    GrabZeroTips: function () {
        console.log('是否隐身——零点提醒方法——隐身（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
        mgc.consts.MGCData.invisible = false;
        console.log('是否隐身——零点提醒方法——更改隐身状态——在线（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
        VIP_GRAB.GrabZero();
    },
    GrabZero: function() {
        //发服务器请求
        var _reqStr = "{\"op_type\":" + OpType.GrapZero + "}";
        MGC_Comm.sendMsg(_reqStr, "VIP_GRAB.GrabZeroTipsCallBack");

    },
    GrabZeroTipsCallBack: function (obj) {
        console.log('是否隐身——进零点提醒方法回调（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
        if (obj.notice == true && VIP_GRAB.free_times == 0) {
            var dialog = {};
            dialog.Title = '提示信息';
            dialog.Note = '亲，座位即将在0点回归原价，现在就要抢座吗？';
            dialog.BtnNum = 2;
            dialog.BtnName = '有钱任性';
            dialog.BtnName2 = '等会儿再来';
            MGC_Comm.CommonDialog(dialog, VIP_GRAB.vipGrab);
        } else {
            console.log('是否隐身——进零点提醒方法回调——进抢座回调之前（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
            VIP_GRAB.vipGrab();
        }
    },
    //获取主播、玩家、管理员信息---抢座   
    getPlayerInfoGrabChire: function(name, area, x, y) {
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
        MGC_Comm.sendMsg(_reqStr, "VIP_GRAB.getPlayerInfoGrabChireCallBack");
    },

    //获取主播、玩家、管理员信息---空座抢座   
    getPlayerInfoGrabChireNull: function(x, y) {
        if (MGC_Comm.CheckGuestStatus()) {
            console.log("屏蔽游客操作：获取主播、玩家、管理员信息");
            return false;//游客身份下，屏蔽此操作
        }
        mouseX = x;
        mouseY = y;

        if (mouseX || mouseY) {
            mgc.common_contral.mgc_comm.eventInfo = undefined;
        }
        VIP_GRAB.getPlayerInfoGrabChireNullCallBack();
    },
    //个人名片回调--抢座
    getPlayerInfoGrabChireCallBack: function(obj) {
        $m('.sv_list li span').hide();
        console.log("获取的个人名片信息111：" + obj);
        obj = MGC_Comm.strToJson(obj);
        var _playerInfo = {};
        /*    if (!obj.mem_info.Online) {
                showCloseTips(MGCData.eventInfo, '该用户已不在房间中');
                return false;
            }*/
        _playerInfo.guardlevelClass = _playerInfo.guardlevelShow = _playerInfo.viplevelClass = _playerInfo.viplevelShow = '';
        _playerInfo.wealth_level = 0;
        _playerInfo.isMobileManager = mgc.tools.judgeIfUserAdmin(allUserAdmins, obj.mem_info.psid);
        _playerInfo._targetId = obj.mem_info.psid;
        if (parseInt(VIP_GRAB.time) != 0) {
            var myTime = obj.mem_info.server_time;
            var totalTime = parseInt(VIP_GRAB.begin_time) + parseInt(VIP_GRAB.time);
            var timeTmpl = totalTime - parseInt(myTime);
            if (timeTmpl > 0) {
                VIP_GRAB.time = timeTmpl;
            } else {
                VIP_GRAB.time = 0;
            }
        }
        //   VIP_GRAB.free_times = obj.free_seat_left;        
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
            if (obj.mem_info.isSelf) {
                //查看自己
            } else {
                _playerInfo.card_list_info += '<ul class="list_btn">';
                _playerInfo.card_list_info += '<li><a receiverId="'+_playerInfo._targetId+'" receiverName="' + _playerInfo._nickName + '" receiverZoneName="' + _playerInfo._talkAreaName + '" receiverPlayerType="' + obj.mem_info.playerType + '" onclick="$chat.PreSendMsgChat(1,this,true);" href="javascript:;">私 聊</a></li>';
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
            if (obj.mem_info.wealth_level > 0) {
                _playerInfo.wealthlevelClass = "wealth_level_" + obj.mem_info.wealth_level;
                _playerInfo.wealth_level = obj.mem_info.wealth_level;
                // _playerInfo.wealthlevelShow = vipLevelTab[_playerInfo._wealth_level];
            }
            //名片
            _playerInfo._cardClass = 'icon_card';
            //下拉信息--要分各种情况todo
            _playerInfo.card_list_info = '';
            _playerInfo.hid = false;
            if (obj.mem_info.isSelf) {
                //查看自己
            } else {
                _playerInfo.card_list_info += '<ul class="list_btn">';
                _playerInfo.card_list_info += '<li><a receiverId="'+_playerInfo._targetId+'" receiverName="' + _playerInfo._nickName + '" receiverZoneName="' + _playerInfo._talkAreaName + '" receiverPlayerType="' + obj.mem_info.playerType + '" onclick="$chat.PreSendMsgChat(1,this,true);" href="javascript:;">私 聊</a></li>';
                _playerInfo.card_list_info += '<li><a href="javascript:copyToClipBoard();">复制昵称</a></li>';
                if (canInvite) {
                    _playerInfo.card_list_info += '<li><a id="invitationBtn" data_targetId=' + _playerInfo._targetId + ' data_showAreaName="' + _playerInfo._talkAreaName + '" href="javascript:fansInvited();">后援团邀请</a></li>';
                }
                //屏蔽信息
                if (obj.mem_info.isIgnore) { //true ? 已经屏幕了？
                    _playerInfo.card_list_info += '<li><a class="ignore" playerId="'+_playerInfo._targetId+'" name="' + obj.mem_info.player_name + '" area="' + obj.mem_info.zone_name + '" isIgnore="false" href="javascript:;">取消屏蔽</a></li>';
                } else {
                    _playerInfo.card_list_info += '<li><a class="ignore" playerId="'+_playerInfo._targetId+'" name="' + obj.mem_info.player_name + '" area="' + obj.mem_info.zone_name + '" isIgnore="true" href="javascript:;">屏 蔽</a></li>';
                }
                if (obj.mem_info.banable && !_playerInfo.isMobileManager) { //可以禁言
                    _playerInfo.card_list_info += '<li><a class="forbidden" playerId="'+_playerInfo._targetId+'" name="' + obj.mem_info.player_name + '" area="' + obj.mem_info.zone_name + '" href="javascript:;">禁 言</a></li>';
                    _playerInfo.card_list_info += '<li><a class="cancelForbidden" playerId="'+_playerInfo._targetId+'" name="' + obj.mem_info.player_name + '" area="' + obj.mem_info.zone_name + '" href="javascript:;">取消禁言</a></li>';
                } else if (obj.mem_info.unbanable && !_playerInfo.isMobileManager) {
                    _playerInfo.card_list_info += '<li><a class="cancelForbidden" playerId="'+_playerInfo._targetId+'" name="' + obj.mem_info.player_name + '" area="' + obj.mem_info.zone_name + '" href="javascript:;">取消禁言</a></li>';
                }
                //list_btn_grab_chair
                _playerInfo.card_list_info += '</ul>';
                //抢座区域
                //自己等级比被抢的人等级低                
                if (MGCData.myVipLevel <= _playerInfo._vip_level) {
                    if (VIP_GRAB.time > 0) {
                        _playerInfo.card_list_info += '<ul class="list_btn_grab_chair">'
                        _playerInfo.card_list_info += '<li><span class="left line20" id="grabChireTime" ><strong>座位保护中</strong><br/><i>' + VIP_GRAB.time + '</i>：<i>00</i></span><span id="greyBtn" class="grey">抢 座</span><span id="grabChireTimeOut" style="display:none" class="left"><strong>' + VIP_GRAB.cost + '炫豆</strong>抢座</span><span id="rightBtn" style="display:none" class="right">抢 座</span></li>'
                        _playerInfo.card_list_info += '</ul>'
                    } else {
                        _playerInfo.card_list_info += '<ul class="list_btn_grab_chair">'
                        _playerInfo.card_list_info += '<li><span class="left"><strong>' + VIP_GRAB.cost + '炫豆</strong>抢座</span><span class="right">抢 座</span></li>'
                        _playerInfo.card_list_info += '</ul>'
                    }

                } else {
                    //自己等级比被抢的人等级高
                    if (VIP_GRAB.time > 0 && (VIP_GRAB.cost_seat == "false") && VIP_GRAB.free_times > 0 && (MGCData.myVipLevel > 0)) { //保护时间内、没有花钱抢、有免费次数              
                        VIP_GRAB.cost = 0;
                        _playerInfo.card_list_info += '<ul class="list_btn_grab_chair">'
                        _playerInfo.card_list_info += '<li><span class="left line20" id="grabChireTime" ><strong>座位保护中</strong><br/><i>' + VIP_GRAB.time + '</i>：<i>00</i></span><span id="greyBtn" class="grey">抢 座</span><span id="grabChireTimeOut" style="display:none" class="left line20"><strong>0炫豆</strong>抢座<br><b>(您还有' + VIP_GRAB.free_times + '次免费特权)</b></span><span id="rightBtn" style="display:none" class="right">抢 座</span></li>'
                        _playerInfo.card_list_info += '</ul>'
                    } else if (VIP_GRAB.time > 0 && (VIP_GRAB.cost_seat == "false") && VIP_GRAB.free_times == 0 && (MGCData.myVipLevel > 0)) {//保护时间内、没有花钱抢、免费次数用尽（花钱抢）                        
                        _playerInfo.card_list_info += '<ul class="list_btn_grab_chair">'
                        _playerInfo.card_list_info += '<li><span class="left line20" id="grabChireTime" ><strong>座位保护中</strong><br/><i>' + VIP_GRAB.time + '</i>：<i>00</i></span><span id="greyBtn" class="grey">抢 座</span><span id="grabChireTimeOut" style="display:none" class="left line20"><strong>' + VIP_GRAB.cost + '炫豆</strong>抢座<br><b>(您的免费次数已用尽)</b></span><span id="rightBtn" style="display:none" class="right">抢 座</span></li>'
                        _playerInfo.card_list_info += '</ul>'
                    } else if (VIP_GRAB.time > 0 && (VIP_GRAB.cost_seat == "true") && (VIP_GRAB.free_times > 0 || VIP_GRAB.free_times == 0) && (MGCData.myVipLevel > 0)) {//保护时间内、花钱抢                        
                        _playerInfo.card_list_info += '<ul class="list_btn_grab_chair">'
                        _playerInfo.card_list_info += '<li><span class="left line20" id="grabChireTime" ><strong>座位保护中</strong><br/><i>' + VIP_GRAB.time + '</i>：<i>00</i></span><span id="greyBtn" class="grey">抢 座</span><span id="grabChireTimeOut" style="display:none" class="left"><strong>' + VIP_GRAB.cost + '炫豆</strong>抢座</span><span id="rightBtn" style="display:none" class="right">抢 座</span></li>'
                        _playerInfo.card_list_info += '</ul>'
                    } else if (VIP_GRAB.time == 0 && (VIP_GRAB.cost_seat == "false") && VIP_GRAB.free_times > 0 && (MGCData.myVipLevel > 0)) {//过了保护时间内、没有花钱抢 、有免费次数  
                        VIP_GRAB.cost = 0;
                        _playerInfo.card_list_info += '<ul class="list_btn_grab_chair">'
                        _playerInfo.card_list_info += '<li><span class="left line20"><strong>0炫豆</strong>抢座<br><b>(您还有' + VIP_GRAB.free_times + '次免费特权)</b></span><span class="right">抢 座</span></li>'
                        _playerInfo.card_list_info += '</ul>'
                    } else if (VIP_GRAB.time == 0 && (VIP_GRAB.cost_seat == "false") && VIP_GRAB.free_times == 0 && (MGCData.myVipLevel > 0)) {//过了保护时间内、没有花钱抢 、没有免费次数                       
                        _playerInfo.card_list_info += '<ul class="list_btn_grab_chair">'
                        _playerInfo.card_list_info += '<li><span class="left line20"><strong>' + VIP_GRAB.cost + '炫豆</strong>抢座<br><b>(您的免费次数已用尽)</b></span><span class="right">抢 座</span></li>'
                        _playerInfo.card_list_info += '</ul>'
                    } else if (VIP_GRAB.time == 0 && (VIP_GRAB.cost_seat == "true") && (VIP_GRAB.free_times > 0 || VIP_GRAB.free_times == 0) && (MGCData.myVipLevel > 0)) {//过了保护时间内、花钱抢                        
                        _playerInfo.card_list_info += '<ul class="list_btn_grab_chair">'
                        _playerInfo.card_list_info += '<li><span class="left"><strong>' + VIP_GRAB.cost + '炫豆</strong>抢座</span><span class="right">抢 座</span></li>'
                        _playerInfo.card_list_info += '</ul>'
                        //以上是贵族的提示，以下是非贵族提示
                    } else if (VIP_GRAB.time == 0 && (VIP_GRAB.cost_seat == "false" || VIP_GRAB.cost_seat == "true") && (VIP_GRAB.free_times > 0 || VIP_GRAB.free_times == 0) && (MGCData.myVipLevel == 0)) {//过了保护时间内、没有或有花钱抢、不是贵族                        
                        _playerInfo.card_list_info += '<ul class="list_btn_grab_chair">'
                        _playerInfo.card_list_info += '<li><span class="left"><strong>' + VIP_GRAB.cost + '炫豆</strong>抢座</span><span class="right">抢 座</span></li>'
                        _playerInfo.card_list_info += '</ul>'
                    } else if (VIP_GRAB.time == 0 && (VIP_GRAB.cost_seat == "false" || VIP_GRAB.cost_seat == "true") && (VIP_GRAB.free_times > 0 || VIP_GRAB.free_times == 0) && (MGCData.myVipLevel == 0)) {//保护时间内、没有或有花钱抢、不是贵族                        
                        _playerInfo.card_list_info += '<ul class="list_btn_grab_chair">'
                        _playerInfo.card_list_info += '<li><span class="left line20" id="grabChireTime" ><strong>座位保护中</strong><br/><i>' + VIP_GRAB.time + '</i>：<i>00</i></span><span id="greyBtn" class="grey">抢 座</span><span id="grabChireTimeOut" style="display:none" class="left"><strong>' + VIP_GRAB.cost + '炫豆</strong>抢座</span><span id="rightBtn" style="display:none" class="right">抢 座</span></li>'
                        _playerInfo.card_list_info += '</ul>'
                    }
                }
                if (VIP_GRAB.cost > 0) {
                    VIP_GRAB.sign = true;
                } else if (VIP_GRAB.cost == 0) {
                    VIP_GRAB.sign = false;
                }
            }

        }
        var grabChaircardTipCon = $m('#grabChaircardTipTmpl');
        var grabChaircardTipTmpl;
        var cardTipContainer = $m('#cardTipContainer');
        cardTipContainer.children().remove();
        grabChaircardTipTmpl = grabChaircardTipCon.tmpl(_playerInfo);
        grabChaircardTipTmpl.appendTo(cardTipContainer);
        //如果有名片、绑定名片事件
        if (_playerInfo._cardClass == 'icon_card') {
            if (obj.mem_info.playerType == 0) { //主播
                $m('.icon_card').off('click').on('click', function() {
                    window.mgc.popmanager.layerControlHide($m(".card_tips"), 1, 2);
                    MGC_CommRequest.getAnchorCard($m(this).attr('anchorId'));
                });
            } else { //玩家
                $m('.icon_card').off('click').on('click', function() {
                    //需要判断在不在线-已经在点击阶段实现
                    window.mgc.popmanager.layerControlHide($m(".card_tips"), 1, 2);
                    //查询名片信息
                    MGC_cardRequest.getListCardInfo(_playerInfo._targetId, card_source);
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
        //VIP贵宾席-抢座逻辑接口
        $m('.card_tips .list_btn_grab_chair li span.right').on('click', function(e) {
            console.log('座位有人——点击抢座，判断是否是隐身前（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
            //是否隐身
            if (mgc.consts.MGCData.invisible) {
                console.log('座位有人——判断是隐身——弹提示前（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.BtnNum = 2;
                dialog.BtnName = '立即抢';
                dialog.BtnName2 = '算了吧';
                if (VIP_GRAB.free_times > 0) {
                    if (VIP_GRAB.sign) {
                        console.log('座位有人——判断是隐身——弹提示前——有免费次数——花钱抢座（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                        dialog.Note = '您现在是隐身登陆，抢座成功后将会自动现身。您将花费' + VIP_GRAB.cost + '炫豆抢座！';
                    } else {
                        console.log('座位有人——判断是隐身——弹提示前——有免费次数——用免费次数抢座（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                        dialog.Note = '您现在是隐身登陆，抢座成功后将会自动现身。本次抢座免费！您还有' + VIP_GRAB.free_times + '次抢座特权。';
                    }
                } else {
                    console.log('座位有人——判断是隐身——弹提示前——无免费次数——花钱抢座（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                    dialog.Note = '您现在是隐身登陆，抢座成功后将会自动现身。您将花费' + VIP_GRAB.cost + '炫豆抢座！';
                }
                MGC_Comm.CommonDialog(dialog, VIP_GRAB.GrabZeroTips);

                return;
            }
            //是否游客
            if (MGC_Comm.CheckGuestStatus(false)) return;
            VIP_GRAB.GrabZero();
        });
        //保护时间倒计时        
        MGC.progressGrabTime('grabChireTime', 'greyBtn', 'rightBtn', 'grabChireTimeOut', VIP_GRAB.time);
        //保护时间tips
        var itemTips = $j('.sus_tips');
        $m('.card_tips').on("mouseover", "span[class='grey']", function(e) {
            itemTips.html('亲，该座位暂时不能抢，等会儿<br/>再来吧！亲王及以上贵族可以拥<br/>有保护时间哦！');
            var t = $m(this).offset().top + 0;
            var l = $m(this).offset().left + 90;
            itemTips.css({
                "top": t,
                "left": l,
                "text-align": "left"
            });
            window.mgc.popmanager.layerControlShow(itemTips, 3, 3);
            window.mgc.tools.comm_tips_position(itemTips, false, 0, 0, $(this).width());
        });

        $m('.card_tips').on('mouseout', "span[class='grey']", function(e) {
            window.mgc.popmanager.layerControlHide(itemTips, 3, 3);
        });
        //弹出他人框
        MGC.grabChaircardTips(mgc.common_contral.mgc_comm.eventInfo, 's_con_card');
        grabChaircardTipTmpl = null;
        grabChaircardTipCon = null;
    },

    //空座抢座名片
    //个人名片回调--抢座
    getPlayerInfoGrabChireNullCallBack: function() {
        $m('.sv_list li span').hide();
        console.log('getPlayerInfoGrabChireNullCallBack hide');
        var _playerInfo = {};
        //名片
        _playerInfo._cardClass = 'icon_card';
        //下拉信息--要分各种情况todo
        _playerInfo.card_list_info = '';
        _playerInfo.wealth_level = 0;
        _playerInfo._guard_level = 0;
        _playerInfo._vip_level = 0;
        _playerInfo.hid = true;
        if ((VIP_GRAB.cost_seat == "false") && VIP_GRAB.free_times > 0 && (MGCData.myVipLevel > 0)) {//没有花钱抢、有免费次数 、贵族            
            VIP_GRAB.cost = 0;
            _playerInfo.card_list_info += '<ul class="list_btn_grab_chair">'
            _playerInfo.card_list_info += '<li><span class="left line20"><strong>0炫豆</strong>抢座<br><b>(您还有' + VIP_GRAB.free_times + '次免费特权)</b></span><span class="right">抢 座</span></li>'
            _playerInfo.card_list_info += '</ul>'
        } else if ((VIP_GRAB.cost_seat == "false") && VIP_GRAB.free_times == 0 && (MGCData.myVipLevel > 0)) {//没有花钱抢、是贵族-免费次数用尽（花钱抢）            
            _playerInfo.card_list_info += '<ul class="list_btn_grab_chair">'
            _playerInfo.card_list_info += '<li><span class="left line20"><strong>' + VIP_GRAB.cost + '炫豆</strong>抢座<br><b>(您的免费次数已用尽)</b></span><span class="right">抢 座</span></li>'
            _playerInfo.card_list_info += '</ul>'
        } else if ((VIP_GRAB.cost_seat == "false") && VIP_GRAB.free_times == 0 && (MGCData.myVipLevel == 0)) {//没有花钱抢、不是贵族-没有免费次数             
            _playerInfo.card_list_info += '<ul class="list_btn_grab_chair">'
            _playerInfo.card_list_info += '<li><span class="left"><strong>' + VIP_GRAB.cost + '炫豆</strong>抢座</span><span class="right">抢 座</span></li>'
            _playerInfo.card_list_info += '</ul>'
        } else if ((VIP_GRAB.cost_seat == "true") && VIP_GRAB.free_times == 0 && (MGCData.myVipLevel > 0)) {//花钱抢过、免费次数用尽（花钱抢）            
            _playerInfo.card_list_info += '<ul class="list_btn_grab_chair">'
            _playerInfo.card_list_info += '<li><span class="left line20"><strong>' + VIP_GRAB.cost + '炫豆</strong>抢座<br><b>(您的免费次数已用尽)</b></span><span class="right">抢 座</span></li>'
            _playerInfo.card_list_info += '</ul>'
        } else if ((VIP_GRAB.cost_seat == "true") && VIP_GRAB.free_times == 0 && (MGCData.myVipLevel == 0)) {//花钱抢过 、不是贵族没有免费次数            
            _playerInfo.card_list_info += '<ul class="list_btn_grab_chair">'
            _playerInfo.card_list_info += '<li><span class="left"><strong>' + VIP_GRAB.cost + '炫豆</strong>抢座</span><span class="right">抢 座</span></li>'
            _playerInfo.card_list_info += '</ul>'
        } else if ((VIP_GRAB.cost_seat == "false") && VIP_GRAB.free_times > 0 && (MGCData.myVipLevel == 0)) {//没有花钱抢、有免费次数 、不是贵族            
            VIP_GRAB.cost = 0;
            _playerInfo.card_list_info += '<ul class="list_btn_grab_chair">'
            _playerInfo.card_list_info += '<li><span class="left line20"><strong>0炫豆</strong>抢座<br><b>(您还有' + VIP_GRAB.free_times + '次免费特权)</b></span><span class="right">抢 座</span></li>'
            _playerInfo.card_list_info += '</ul>'
        }

        if (VIP_GRAB.cost > 0) {
            VIP_GRAB.sign = true;
        } else if (VIP_GRAB.cost == 0) {
            VIP_GRAB.sign = false;
        }
        var grabChaircardTipCon = $m('#grabChaircardTipTmpl');
        var grabChaircardTipTmpl;
        var cardTipContainer = $m('#cardTipContainer');
        cardTipContainer.children().remove();
        grabChaircardTipTmpl = grabChaircardTipCon.tmpl(_playerInfo);
        grabChaircardTipTmpl.appendTo(cardTipContainer);
        $m('.hiding').css('display', 'none');
        $m('.card_tips').css({ 'paddingTop': '0px' });
        $m('.card_head').css({ 'paddingBottom': '0px', 'border': 'none' });
        $m('.list_btn_grab_chair').css({ 'border': 'none' });

        //VIP贵宾席-抢座逻辑接口
        $m('.card_tips .list_btn_grab_chair li span.right').on('click', function(e) {
            console.log('座位没人——点击抢座，判断是否是隐身前（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
            //是否隐身
            if (mgc.consts.MGCData.invisible) {
                console.log('座位没人——判断是隐身——弹提示前（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.BtnNum = 2;
                dialog.BtnName = '立即抢';
                dialog.BtnName2 = '算了吧';
                if (VIP_GRAB.free_times > 0) {
                    if (VIP_GRAB.sign) {
                        console.log('座位没人——判断是隐身——弹提示前——有免费次数——花钱抢座（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                        dialog.Note = '您现在是隐身登陆，抢座成功后将会自动现身。您将花费' + VIP_GRAB.cost + '炫豆抢座！';
                    } else {
                        console.log('座位没人——判断是隐身——弹提示前——有免费次数——用免费次数抢座（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                        dialog.Note = '您现在是隐身登陆，抢座成功后将会自动现身。本次抢座免费！您还有' + VIP_GRAB.free_times + '次抢座特权。';
                    }
                } else {
                    console.log('座位没人——判断是隐身——弹提示前——无免费次数——花钱抢座（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                    dialog.Note = '您现在是隐身登陆，抢座成功后将会自动现身。您将花费' + VIP_GRAB.cost + '炫豆抢座！';
                }
                MGC_Comm.CommonDialog(dialog, VIP_GRAB.GrabZeroTips);

                return;
            }
            //是否游客
            if (MGC_Comm.CheckGuestStatus(false)) return;
            VIP_GRAB.GrabZero();
        });
        //保护时间倒计时        
        MGC.progressGrabTime('grabChireTime', 'greyBtn', 'rightBtn', 'grabChireTimeOut', 3);
        //保护时间tips
        var itemTips = $j('.sus_tips');
        $m('.card_tips').on("mouseover", "span[class='grey']", function(e) {
            itemTips.html('亲，该座位暂时不能抢，等会儿<br/>再来吧！亲王及以上贵族可以拥<br/>有保护时间哦！');

            var t = $m(this).offset().top + 0;
            var l = $m(this).offset().left + 90;
            itemTips.css({
                "top": t,
                "left": l,
                "text-align": "left"
            });
            window.mgc.popmanager.layerControlShow(itemTips, 3, 3);
            window.mgc.tools.comm_tips_position(itemTips, false, 0, 0, $(this).width());
        });

        $m('.card_tips').on('mouseout', "span[class='grey']", function(e) {
            window.mgc.popmanager.layerControlHide(itemTips, 3, 3);
        });
        //弹出他人框
        MGC.grabChairNullcardTips(mgc.common_contral.mgc_comm.eventInfo, 's_con_card');
        grabChaircardTipTmpl = null;
        grabChaircardTipCon = null;

    }
};

/**
 * 守护宝座-抢座模块
 */
var Seat = {

    /**
     * 座位数据
     */
    seats: [],

    seatIndex: 0,
    owner: 0,
    cost: 0,

    /**
     * 自己是否抢到座位了
     */
    hasSeat:false,

    /**
     * 初始化
     */
    init: function() {

    },

    /**
     * 根据座位id获取某个宝座的数据
     */
    getSeat: function(id) {
        var obj;
        for (var i = 0; i < Seat.seats.length; i++) {
            if (Seat.seats[i].m_seat_id == id) {
                obj = Seat.seats[i];
            }
        }

        return obj;
    },

    /**
     * 某个id的玩家是否在座位上
     */
    isSeat: function(id) {
        var b = false;
        for (var i = 0; i < Seat.seats.length; i++) {
            if (Seat.seats[i].m_player_id == id) {
                if (Seat.seats[i].m_take_cost > 0) {
                    b = true;
                }
            }
        }

        return b;
    },

    /**
     * 获取座位列表
     */
    getSeatList: function(obj) {

        //var data = [{playerid:0,seatIndex:0,m_nick:"aaa",m_zone:"大区",m_pic_url:"http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_male.png?v=3_8_8_2016_15_4_final_3",canseat:true,m_guard_level:100},{playerid:0,seatIndex:1,m_nick:"aaa11",m_zone:"大区2",m_pic_url:"http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_male.png?v=3_8_8_2016_15_4_final_3",canseat:true,m_guard_level:100}];

        //Seat.seats = data;

        //过滤服务器的延迟数据  防止自己重新进房时还在座位上
        $m.each(obj.seats, function(k, v) {
            if (MGCData.myPlayerId == obj.seats[k].m_player_id && !Seat.hasSeat && obj.seats[k].m_take_cost > -1) {
                obj.seats[k].m_player_id = 0;
                obj.seats[k].m_pic_url = "";
                obj.seats[k].m_nick = "";
            }
        });

        if (Seat.seats.length != 0) {
            $m.each(Seat.seats, function(k, v) {
               if (v.m_player_id != obj.seats[k].m_player_id ||v.m_pic_url!=obj.seats[k].m_pic_url || v.m_nick != obj.seats[k].m_nick) {
                    //刷单个座位
                    var _obj = {
                        "player_id": obj.seats[k].m_player_id,
                        "res": 0,
                        "op_type": 230,
                        "seatInfoUI": obj.seats[k],
                        "cost": 100,
                        "seatIndex": k
                    };
                    //if (mgc.consts.MGCData.myPlayerId == v.m_player_id) {
                    //    _obj.seatInfoUI.m_player_id = "0";
                    //}

                   //看起来这里面只用到seatInfoUI对象的数据
                   Seat.grapCallBack(_obj);
                }

            });
            obj = null;
            return;
        }

        Seat.seats = $m.extend(true, [], obj.seats);

        for (var i = 0; i < obj.seats.length; i++) {
            var seat = obj.seats[i];

            //没有头像的玩家用默认头像
            if (seat.m_pic_url == "") {
                if (mgc.tools.is_live_room()) {
                    if (seat.m_gender == 0) {
                        seat.m_pic_url = "http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_female.png?v=3_8_8_2016_15_4_final_3";
                    }
                    else {
                        seat.m_pic_url = "http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_male.png?v=3_8_8_2016_15_4_final_3";
                    }
                } else {
                    if (SKIN.level < 1) {
                        if (seat.m_gender == 0) {
                            seat.m_pic_url = "http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_female.png?v=3_8_8_2016_15_4_final_3";
                        }
                        else {
                            seat.m_pic_url = "http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_male.png?v=3_8_8_2016_15_4_final_3";
                        }
                    } else {
                        if (seat.m_gender == 0) {
                            seat.m_pic_url = HeadImgPath + "default_female2.png?v=3_8_8_2016_15_4_final_3";
                        }
                        else {
                            seat.m_pic_url = HeadImgPath + "default_male2.png?v=3_8_8_2016_15_4_final_3";
                        }
                    }
                }

            }

            //大区
            seat.m_zone = (seat.m_zone == "梦工厂" ? seat.m_zone : "炫舞-" + seat.m_zone);

            //守护名称
            seat.guardName = guardLevelTab[seat.m_guard_level];

            //是否可抢 根据当前座位的花销判断宝座的状态：>0 可抢、<0 不可抢

            if (mgc.tools.is_live_room()) {
                if (seat.m_take_cost > 0) {
                    seat.canseat = true;
                }
            } else {
                if (SKIN.level >= 1) {
                    if (seat.m_take_cost > 0) {
                        if (!(window.mgc.tools.supportCss3('border-radius'))) {
                            seat.canseatIE = true;
                        } else {
                            seat.canseat = true;
                        }
                    } else {
                        if (!(window.mgc.tools.supportCss3('border-radius'))) {
                            seat.nullIE = true;
                        }
                    }
                } else {
                    if (seat.m_take_cost > 0) {
                        seat.canseat = true;
                    }
                }
            }


            //空座位
            if (seat.m_player_id == 0) {
                if (mgc.tools.is_live_room()) {
                    seat.canseat = true;
                } else {
                    if (SKIN.level >= 1) {
                        if (!(window.mgc.tools.supportCss3('border-radius'))) {
                            seat.canseatIE = true;
                        } else {
                            seat.canseat = true;
                        }
                    } else {
                        seat.canseat = true;
                    }
                }
                if (mgc.tools.is_live_room()) {
                    seat.m_pic_url = "http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_head_null.png?v=3_8_8_2016_15_4_final_3";
                } else {
                    if (SKIN.level < 1) {
                        seat.m_pic_url = "http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_head_null.png?v=3_8_8_2016_15_4_final_3";
                    } else {
                        if (SKIN.id == 1) {
                            seat.m_pic_url = HeadImgPath + "default_head_null_skin1.png?v=3_8_8_2016_15_4_final_3";
                        } else if (SKIN.id == 2) {
                            seat.m_pic_url = HeadImgPath + "default_head_null_skin2.png?v=3_8_8_2016_15_4_final_3";
                        } else if (SKIN.id == 3) {
                            seat.m_pic_url = HeadImgPath + "default_head_null_skin3.png?v=3_8_8_2016_15_4_final_3";
                        }
                    }
                }


            }

        }

        var seatCon = $m('#seatTmpl');
        var seatTmpl = seatCon.tmpl(obj.seats);
        var seatContainer = $m('.seatlist ul');
        seatContainer.html("").append(seatTmpl);

        //抢座按钮
        seatContainer.find("li a.seatbtn").click(Seat.onGrap);

        //玩家头像点击
        seatContainer.find("li a.userbtn").click(Seat.onClickUser);
        seatContainer.find("li").mouseenter(Seat.onOverUser);
        seatContainer.find("li").mouseleave(Seat.onOutUser);

        //隐藏TIPS
        $m(".seat .tip2").hide();

        obj = null;
        seatTmpl = null;
        seatContainer = null;
        seatTmpl = null;
        seatCon = null;
    },

    /**
     * 座位被抢
     */
    seatLost: function(obj) {
        Seat.seatIndex = obj.seatIndex;
        Seat.owner = 0;
        Seat.cost = obj.cost;
        var dialog = {};
        dialog.Title = '提示信息';
        dialog.BtnNum = 2;
        dialog.BtnName = '立即夺回';
        dialog.BtnName2 = '算了吧';
        dialog.Note = "亲，您被" + obj.nick + "用" + obj.last_cost + "炫豆请下座位，立即用" + obj.cost + "炫豆夺回宝座！";
        MGC_Comm.CommonDialog(dialog, Seat.grap);
    },

    /**
     * 点击抢座
     */
    onGrap: function(e) {

        //是否游客
        if (MGC_Comm.CheckGuestStatus(false)) return;

        //是否直播
        if (isLiveOpen == false) {
            var obj = { res: 5 };
            Seat.grapCallBack(obj);
            return;
        }

        var $a = $m(e.currentTarget);
        //var id = $a.data("id");
        //alert("抢座" + $a.data("seatid") + " " + $a.data("playerid") + " " + $a.data("cost"));
        Seat.seatIndex = $a.data("seatid");
        Seat.owner = $a.data("playerid");
        Seat.cost = $a.data("cost");

        //是否自己
        if (mgc.consts.MGCData.myPlayerId == Seat.owner) {
            var dialog = {};
            dialog.Title = '提示信息';
            dialog.Note = '亲，您已经在座位上了！';
            dialog.BtnName = '知道了';
            MGC_Comm.CommonDialog(dialog);
            return;
        }

        //是否隐身
        if (mgc.consts.MGCData.invisible) {
            var dialog = {};
            dialog.Title = '提示信息';
            dialog.BtnNum = 2;
            dialog.BtnName = '立即抢';
            dialog.BtnName2 = '算了吧';
            if (VIP_GRAB.free_times > 0) {
                if (VIP_GRAB.sign) {
                    dialog.Note = '您现在是隐身登陆，抢座成功后将会自动现身。';
                } else {
                    dialog.Note = '您现在是隐身登陆，抢座成功后将会自动现身。';
                }
            } else {
                dialog.Note = '您现在是隐身登陆，抢座成功后将会自动现身。';
            }
            MGC_Comm.CommonDialog(dialog, Seat.grap);

            return;
        }

        Seat.grap();
    },

    /**
     * 点击玩家头像
     */
    onClickUser: function(e) {
        //e.stopPropagation();
        //是否游客
        if (MGC_Comm.CheckGuestStatus(false)) return;
        card_source = 2;
        var $a = $m(e.currentTarget);
        var playerid = $a.data("playerid");
        var inroom = $a.data("inroom");

        //是否空座位
        if (playerid == "0") return;

        //是否离线
        if (!inroom) {
            Seat.onShowOffLineUserMenu(e);
            return;
        }

        //非空座位
        if (playerid != "0") {
            MGC_CommRequest.getPlayerInfo($a.data("name"), $a.data("zone"));
            mgc.common_contral.mgc_comm.eventInfo = e;
        }
    },

    /**
     * 显示离线玩家菜单
     */
    onShowOffLineUserMenu: function(e) {
        e.stopPropagation();

        var $a = $m(e.currentTarget);

        var _playerInfo = {};
        _playerInfo.isSelf = false;
        _playerInfo.playerType = -100;
        _playerInfo._portrait_url = $a.data("picurl");
        _playerInfo._nickName = $a.data("name");
        _playerInfo._showAreaName = $a.data("zone");
        _playerInfo._sexFemale = ($a.data("sex") == 1 ? "" : "female");
        _playerInfo._vip_level = $a.data("viplevel");
        _playerInfo._guard_level = $a.data("guardlevel");
        _playerInfo._wealth_level = $a.data("wealthlevel");
        _playerInfo._targetId = $a.data("playerid");
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
        if (_playerInfo._guard_level > 0) {
            _playerInfo._guard_level = _playerInfo._guard_level;
        }
        if (_playerInfo._vip_level > 0) {
            _playerInfo._vip_level = _playerInfo._vip_level;
        }
        if (_playerInfo._wealth_level > 0) {
            _playerInfo.wealth_level = _playerInfo._wealth_level;
        }
        _playerInfo.card_list_info = '';
        _playerInfo.card_list_info += '<ul class="list_btn">';
        _playerInfo.card_list_info += '<li><a href="javascript:copyToClipBoard();">复制昵称</a></li>';
        _playerInfo.card_list_info += '</ul>';
        _playerInfo._cardClass = 'icon_card';

        var cardTipCon = $m('#cardTipTmpl');
        var cardTipTmpl;
        var cardTipContainer = $m('#cardTipContainer');
        cardTipContainer.children().remove();
        cardTipTmpl = cardTipCon.tmpl(_playerInfo);
        cardTipTmpl.appendTo(cardTipContainer);

        card_source = 2;
        $m('.icon_card').off('click').on('click', function() {
            window.mgc.popmanager.layerControlHide($m(".card_tips"), 1, 2);
            //查询名片信息
            MGC_CommRequest.getListCard($a.data("playerid"),card_source);
        });

        mgc.common_contral.mgc_comm.eventInfo = MGC.getEvent();
        MGC.cardTips(mgc.common_contral.mgc_comm.eventInfo, 's_con_card');
        cardTipTmpl = null;
        cardTipCon = null;
    },

    /**
     * 滑过玩家头像
     */
    onOverUser: function(e) {
        var $li = $m(e.currentTarget);
        var seatid = $li.data("seatid");
        var seat = Seat.getSeat(seatid);
        //守护名称
        seat.guardName = guardLevelTab[seat.m_guard_level];
        var com = $m('#seatUserTipTmpl');
        var tmpl;
        var container = $m('.seat .tip2');
        container.children().remove();
        tmpl = com.tmpl(seat);
        tmpl.appendTo(container);

        //var $li = $m(".seatlist").find("li[data-seatid=" + seatid + "]");

        //$m(".seat .tip2").show();
        window.mgc.popmanager.layerControlShow($m(".seat .tip2"), 1, 3);
        container.offset({ top: $li.offset().top, left: ($li.offset().left + 69) });
        tmpl = null;
        com = null;
    },

    /**
     * 划出玩家头像
     */
    onOutUser: function(e) {
        //$m(".seat .tip2").hide();
        window.mgc.popmanager.layerControlHide($m(".seat .tip2"), 1, 3);
    },

    /**
     * 提示
     */
    susStateTips: function(e, n, val, tnum, lnum) {
        var _e = e.target == undefined ? e.toElement : e.target;
        var t = _e.offsetTop + tnum;
        var l = _e.offsetLeft + lnum;
        if ((n == 1 && val == '') || (n == 1 && val == '无')) {
            return false;
        }
        var susTips = $j(".sus_tips_listLi");
        susTips.css({ "top": t, "left": l });
        if (n == 1) {
            if (val != '') {
                susTips.text(val);
            }
            //  susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 1, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 1, 3);
        }

    },

    grap: function() {
        var _reqStr = "{\"op_type\":" + OpType.Grap + ", \"seatIndex\":" + Seat.seatIndex + ", \"owner\":" + Seat.owner + ", \"cost\":" + Seat.cost + "}";
        MGC_Comm.sendMsg(_reqStr, "Seat.grapCallBack");
    },

    grapCallBack: function(obj) {
        switch (parseInt(obj.res)) {
            case 0:
                //当守护宝座上有人,被刷掉，或者隐身状态改变以后，会一直刷新座位信息，触发回调函数——重置隐身状态（错误隐身信息），注释掉下一行
                //mgc.consts.MGCData.invisible = false;

                //是否自己抢到座位
                if(MGCData.myPlayerId == obj.seatInfoUI.m_player_id)
                {
                    Seat.hasSeat = true;
                }

                var gender = obj.seatInfoUI.m_gender;
                var level = obj.seatInfoUI.m_level;
                var nick = obj.seatInfoUI.m_nick;
                var pic_url = obj.seatInfoUI.m_pic_url;
                var player_id = obj.seatInfoUI.m_player_id;//宝座上的玩家ID
                //var player_id = obj.player_id;//宝座上的玩家ID
                var seat_id = obj.seatInfoUI.m_seat_id;
                var take_cost = obj.seatInfoUI.m_take_cost;
                var taken_times = obj.seatInfoUI.m_taken_times; //抢座次数
                var taking_id = obj.seatInfoUI.m_taking_id;//抢座玩家ID
                var taking_time = obj.seatInfoUI.m_taking_time;//抢座时间
                var vip_level = obj.seatInfoUI.m_vip_level;//贵族等级
                var guard_level = obj.seatInfoUI.m_guard_level;//守护等级
                var wealth_level = obj.seatInfoUI.m_wealth_level;//财富等级
                var wealth = obj.seatInfoUI.m_wealth;//财富等级值
                var zone = obj.seatInfoUI.m_zone;//大区
                var isUpseat = '', noUpseatBtn = '', spanName = '';

                if (player_id != 0) {
                    if (obj.seatInfoUI.m_pic_url == '') {
                        if (gender == 0) {
                            pic_url = HeadImgPath + 'default_female.png?v=3_8_8_2016_15_4_final_3';
                        } else {
                            pic_url = HeadImgPath + 'default_male.png?v=3_8_8_2016_15_4_final_3';
                        }
                    }

                } else {
                    if (obj.seatInfoUI.m_pic_url == '') {
                        if (mgc.tools.is_live_room() || SKIN.level < 1) {
                            pic_url = HeadImgPath + 'default_head_null.png?v=3_8_8_2016_15_4_final_3';
                        } else {
                            if (SKIN.id == 1) {
                                pic_url = HeadImgPath + "default_head_null_skin1.png?v=3_8_8_2016_15_4_final_3";
                            } else if (SKIN.id == 2) {
                                pic_url = HeadImgPath + "default_head_null_skin2.png?v=3_8_8_2016_15_4_final_3";
                            } else if (SKIN.id == 3) {
                                pic_url = HeadImgPath + "default_head_null_skin3.png?v=3_8_8_2016_15_4_final_3";
                            }
                        }
                    }

                }
                if (player_id != 0) {
                    //if (mgc.consts.MGCData.myPlayerId == Seat.owner) {
                    //    MGC_Comm.showGrabFlash(String(parseInt(Seat.seatIndex) + 1));
                    //} else {
                    //    MGC_Comm.showGrabFlash(String(parseInt(obj.seatIndex) + 1));
                    //}
                    if (player_id != Seat.seats[obj.seatIndex].m_player_id) {
                        MGC_Comm.showGrabFlash(String(parseInt(obj.seatIndex) + 1));
                    }
                }
                //显示是否上座的座位背景刷新  
                //显示是否上座后，是否显示抢座按钮（可以点击抢座事件）（上座的玩家不显示抢座按钮）按钮变量：noUpseatBtn
                if (obj.seatInfoUI.m_take_cost > 0) {
                    if (!(window.mgc.tools.supportCss3('border-radius'))) {
                        isUpseat = 'canseat canseatIE';
                    } else {
                        isUpseat = 'canseat';
                    }
                    noUpseatBtn = '<a class="seatbtn" data-playerid=' + player_id + ' data-seatid=' + seat_id + ' data-cost=' + take_cost + '></a>';
                    spanName = '';
                } else {
                    if (!(window.mgc.tools.supportCss3('border-radius'))) {
                        isUpseat = 'nullIE';
                    } else {
                        isUpseat = '';
                    }
                    noUpseatBtn = '';
                    spanName = '<span>'+nick+'</span>';
                }

                if (!(window.mgc.tools.supportCss3('border-radius'))) {
                    $m('.seatlist ul').find('li').eq(seat_id).html('<img src=' + pic_url + ' class="ieStyle" ><i class="' + isUpseat + '"></i>'+ spanName +'<a style="" class="userbtn" data-picurl=' + pic_url + ' data-playerid="7810930959487557" data-seatid=' + seat_id + ' data-cost=' + take_cost + ' data-name=' + nick + ' data-zone=' + zone + ' data-sex=' + gender + ' data-inroom="true" data-viplevel=' + vip_level + ' data-guardlevel=' + guard_level + ' data-wealthlevel=' + wealth_level + '></a>' + noUpseatBtn);
                } else {
                    $m('.seatlist ul').find('li').eq(seat_id).html('<img src=' + pic_url + '><i class="' + isUpseat + '"></i>'+ spanName +'<a style="" class="userbtn" data-picurl=' + pic_url + ' data-playerid="7810930959487557" data-seatid=' + seat_id + ' data-cost=' + take_cost + ' data-name=' + nick + ' data-zone=' + zone + ' data-sex=' + gender + ' data-inroom="true" data-viplevel=' + vip_level + ' data-guardlevel=' + guard_level + ' data-wealthlevel=' + wealth_level + '></a>' + noUpseatBtn);
                }
                Seat.seats[seat_id].m_gender = gender;
                Seat.seats[seat_id].m_guard_level = guard_level;
                Seat.seats[seat_id].m_level = level;
                Seat.seats[seat_id].m_nick = nick;
                Seat.seats[seat_id].m_pic_url = pic_url;
                Seat.seats[seat_id].m_player_id = player_id;
                Seat.seats[seat_id].m_seat_id = seat_id;
                Seat.seats[seat_id].m_take_cost = take_cost;
                Seat.seats[seat_id].m_taken_times = taken_times;
                Seat.seats[seat_id].m_taking_id = taking_id;
                Seat.seats[seat_id].m_taking_time = taking_time;
                Seat.seats[seat_id].m_vip_level = vip_level;
                Seat.seats[seat_id].m_wealth = wealth;
                Seat.seats[seat_id].m_wealth_level = wealth_level;
                Seat.seats[seat_id].m_zone = zone;
                $m('.seatlist').find("li a.seatbtn").off().click(Seat.onGrap);
                $m('.seatlist ul').find("li a.userbtn").click(Seat.onClickUser);

                break;

            case 4:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.BtnNum = 2;
                dialog.BtnName = '立即充值';
                dialog.BtnName2 = '算了';
                dialog.url = "http://pay.qq.com/ipay/index.shtml?c=qxwwqp";
                dialog.Note = '亲，您的炫豆不够了，快去充值吧！~';
                MGC_Comm.CommonDialog(dialog);
                break;

            case 14:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '亲，您已经拥有一个宝座了，不要太贪心哦！';
                dialog.BtnName = '好吧';
                MGC_Comm.CommonDialog(dialog);
                break;

            case 5:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '只有主播开播时才能抢座哦！';
                MGC_Comm.CommonDialog(dialog);
                break;

            case 8:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '只有主播开播时才能抢座哦！';
                MGC_Comm.CommonDialog(dialog);
                break;

            case 13:
                var seat = Seat.getSeat(obj.seatIndex);
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '该座位已经被' + seat.m_nick + '买断了哦！';
                MGC_Comm.CommonDialog(dialog);

            case 15:
                /*var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '世界上最远的距离就是晚了0.001秒，请稍后再试！';
                MGC_Comm.CommonDialog(dialog);*/
                break;

            default:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '产品经理被妖怪抓走了！请稍后再试！';
                MGC_Comm.CommonDialog(dialog);
                break;
        }

        obj = null;
    }

};
window.mgc.Seat = Seat;
window.mgc.VipGrab = VIP_GRAB;
$m.extend(MGC_CommResponse, VIP_GRAB);
$m.extend(MGC_CommResponse, Seat);

