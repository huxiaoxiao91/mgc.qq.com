/**
 * @Description:   梦工厂web-控制-任务中心
 *
 * @author         Xu XiaoJing
 * @version        V1.0
 * @Date           2015/11/24
 * @Company        horizon3d
 */
define(['mgc_callcenter', 'eas', 'mgc_consts', 'jqtmpl', 'mgc_tool', 'mgc_tips', 'mgc_popmanager', 'mgc_dialog'], function(callcenter, eas, consts, jqtmpl, mgc_tool, mgc_tips, mgc_popmanager, mgc_dialog) {
    var control = {};
    /**
     * 初始化任务中心
     */
    control.init = function() {
        act_request.enter();
        //tabnav绑定事件
        tabNavBind('#side_nav', '.act_list', 'dd');
    };

    //发送请求========================================
    var act_request = {
        //进入活动中心页面
        enter: function() {
            callcenter.standard_req("GET_ACT_CENTER", act_callBack.EnterCallBack);
        },

        //领取每日工资
        getDailyWage: function() {
            callcenter.standard_req("GET_DAILY_WAGE", act_callBack.GetDailyWageCallBack);
        },

        //领取活动奖励
        getActRewards: function(act_id, category) {
            var reqParams = {
                activity_id: act_id,
                category: category
            };
            callcenter.standard_req("GET_ACT_REWARDS", act_callBack.GetActRewardsCallBack, reqParams);
        },
        // 获取未领取任务数量
        getDoneAct: function() {
            callcenter.standard_req("GET_DONE_ACT", act_callBack.hasActCallBack);
        }
    };

    var getRewardsBtn;
    var disabledBtn = false;

    var act_callBack = {
        EnterCallBack: function(responseStr) {
            try {
                console.log("EnterCallBack resp:" + JSON.stringify(responseStr));
                var zoneid = mgc_tool.cookie("mgc_zoneid") || consts.MGCData.mgcZoneId;
                if ((zoneid != 888) && (zoneid != 30889))
                {
                	$('#web_tab').css('display', 'block');
                }
                var obj = typeof responseStr == 'object' ? responseStr : mgc_tool.strToJson(responseStr);

                if(obj.succ == 65)
                {
                    window.mgc.common_logic.CheckNameError(151);
                    return;
                }

                if (obj.type == 0) {
                    //顶部信息
                    var _info = obj.info;
                    var _act_info = _info.activity_info;
                    var _daily_info = _info.daily_activity_info;
                    var _activity_info_web = _info.activity_info_web;
                    var proc = 0;
                    var wageStr = '';
                    if (_info.levelup_exp > 0) {
                        proc = (_info.exp / _info.levelup_exp * 100).toFixed(0);
                        $('#i_exp').html('<i>' + _info.exp + '/' + _info.levelup_exp + '</i>').width(proc + '%');
                    }
                    else{
                    	$('#i_exp').html('<i>max</i>').width('100%');
                    }
                    $('#i_lv').html(_info.level);
                    $('#i_mhb').html(_info.video_money);
                    //$('#icon_mhb').attr('onmouseover', 'MGC.susStateTipss(event, 1, "' + _info.video_money + '梦幻币")');
                    mgc_tips.commonTips(_info.video_money + "梦幻币", $('#icon_mhb'));

                    var LeveLName = '';
                    if (_info.vip_level > 0) {
                        LeveLName = consts.vipLevelTab[_info.vip_level];
                    }
                    //if (false) {
                    if (_info.has_taken_wage_today) {
                        wageStr = '<span class="btn_geted">已领取</span>';
                    } else {
                        if (_info.vip_level > 0) {
                            wageStr = _info.wage + '+' + _info.attached_wage + '（<i class="icon_honor icon_honor' + _info.vip_level + '" style="background:url(http://ossweb-img.qq.com/images/mgc/css_img/common/nobility/' + _info.vip_level + '.png?v=3_8_8_2016_15_4_final_3)"></i>' + LeveLName + '加成）';

                        } else {
                            wageStr = _info.wage;
                        }
                        wageStr += '<a href="javascript:;" class="btn_get">领取</a>';
                    }
                    $('#i_wage').html(wageStr);
                    mgc_tips.commonTips(LeveLName + '+' + _info.attached_wage, $('.icon_honor.icon_honor' + _info.vip_level));
                    $('#i_wage').find('.btn_get').off('click').on('click', function() {
                        if (!disabledBtn) {
                            act_request.getDailyWage();
                        }
                    });

                    //活动信息
                    var actCon = $('#actTmpl');
                    var actTmpl;
                    var actContainer = $('#actContainer');
                    var actComent = $('#actComent');
                    var act_rewards_list_con = $('#act_rewards_list_tmpl');
                    var act_rewards_list_tmpl;
                    var actMain = [];
                    var dev_activity_cnt = obj.dev_activity_cnt;
                    var growthTask = false;
                    if (dev_activity_cnt > 0) {
                        growthTask = true;
                    }
                    if (_act_info.length > 0) {

                        $.each(_info.activity_info, function (k, v) {
                            v.end_time = act_callBack.mySetTime(v.end_time);
                            if (growthTask == true && (k == 0)) {
                                v.growthTask = true;
                            }
                            $.each(v.rewards, function (w, y) {                                
                                y.hasgame_act = false;
                                y.qgame_act = false;
                                var url = y.channel == 0 ? y.url : y.channel == 3 ? y.url : y.channel == 4 ? y.url : y.channel == 2 ? ("http://ossweb-img.qq.com/images/mgc/css_img" + y.url) : ("http://ossweb-img.qq.com/images/mgc/css_img" + y.url);
                                y.url = url;
                                if (y.channel==0 || y.channel==4) {
                                    y.hasgame_act = true;
                                } else if (y.channel == 3) {
                                    if (y.url == '') {
                                        y.url = "http://ossweb-img.qq.com/images/mgc/css_img/common/game_default.png?v=3_8_8_2016_15_4_final_3";
                                    }                                    
                                    y.qgame_act = true;
                                }
                                actMain.push(y);
                            });

                            actComent.children().remove();
                            act_rewards_list_tmpl = act_rewards_list_con.tmpl(actMain);
                            act_rewards_list_tmpl.appendTo(actComent);
                        });

                        if (_act_info.length <= 1 && _act_info.length>0) {
                            if (_act_info[0].progress[0].key != 8) {
                                if (_act_info[0].progress[0].key != 9) {
                                    if (_act_info[0].status == 1)
                                    { $("#act_act_b").show(); }
                                    else
                                    { $("#act_act_b").hide(); }
                                }
                            }
                        } else if (_act_info.length > 1) {

                            if (_act_info[0].progress[0].key != 8) {
                                if (_act_info[0].progress[0].key != 9) {
                                    if (_act_info[0].status == 1)
                                    { $("#act_act_b").show(); }
                                    else if (_act_info[1].status == 1)
                                    { $m("#act_act_b").show(); }
                                    else
                                    { $("#act_act_b").hide(); }
                                }
                            }
                        } else {
                        }
                        actContainer.children().remove();
                        actTmpl = actCon.tmpl(_act_info)
                        actTmpl.appendTo(actContainer);
                        actContainer.show().next().hide();
                    } else {
                        $("#act_act_b").hide();
                        actContainer.hide().next().show();
                    }

                    //每日信息
                    var everyCom = $('#everyTmpl');
                    var everyTmpl;
                    var everyContainer = $('#everyContainer');
                    var act_dayComent = $('#act_dayComent');
                    var act_day_rewards_list_con = $('#act_day_rewards_list_tmpl');
                    var act_day_rewards_list_tmpl ;
                    var act_dayMain = [];
                    if (_daily_info.length > 0) {
                        $.each(_info.daily_activity_info, function(k, v) {
                            v.end_time = act_callBack.mySetTime(v.end_time);
                            $.each(v.rewards, function(w, y) {
                                y.hasgame_day = false;
                                y.qgame_day = false;
                                var url = y.channel == 0 ? y.url : y.channel == 3 ? y.url : y.channel == 4 ? y.url : y.channel == 2 ? ("http://ossweb-img.qq.com/images/mgc/css_img" + y.url) : ("http://ossweb-img.qq.com/images/mgc/css_img" + y.url);
                                y.url = url;
                                if (y.channel == 0 ||  y.channel == 4) {
                                    y.hasgame_day = true;
                                } else if (y.channel == 3) {
                                    if (y.url == '') {
                                        y.url = "http://ossweb-img.qq.com/images/mgc/css_img/common/game_default.png?v=3_8_8_2016_15_4_final_3";
                                    }
                                    y.qgame_day = true;
                                }
                                act_dayMain.push(y);
                            });

                            act_dayComent.children().remove();
                            act_day_rewards_list_tmpl = act_day_rewards_list_con.tmpl(act_dayMain);
                            act_day_rewards_list_tmpl.appendTo(act_dayComent);
                        });
                        
                            if (_daily_info[0].progress[0].key != 8) {
                                if (_daily_info[0].progress[0].key != 9) {
                                    if (_daily_info[0].status == 1)
                                    { $("#act_day_b").show(); }
                                    else
                                    { $("#act_day_b").hide(); }
                                }
                            }
                        
                        everyContainer.children().remove();
                        everyTmpl = everyCom.tmpl(_daily_info);
                        everyTmpl.appendTo(everyContainer);
                        everyContainer.show().next().hide();
                    } else {
                        $("#act_day_b").hide();
                        everyContainer.hide().next().show();
                    }

                    /*网页任务*/
                    var webActCon = $('#webActTmpl');
                    var webActTmpl;
                    var webActContainer = $('#webActContainer');
                    var act_web_Coment = $('#act_web_Coment');
                    var act_web_rewards_list_tmpl = $('#act_web_rewards_list_tmpl');
                    var act_webMain = [];
                    if (_activity_info_web.length > 0) {
                        $.each(_info.activity_info_web, function(k, v) {
                            v.end_time = act_callBack.mySetTime(v.end_time);
                            $.each(v.rewards, function(w, y) {
                                y.hasgame_web = false;                                
                                var url = y.channel == 0 ? y.url : y.channel == 3 ? y.url : y.channel == 4 ? y.url : y.channel == 2 ? ("http://ossweb-img.qq.com/images/mgc/css_img" + y.url) : ("http://ossweb-img.qq.com/images/mgc/css_img" + y.url);
                                y.url = url;
                                if (y.channel == 0 || y.channel == 4) {
                                    y.hasgame_web = true;
                                }
                                act_webMain.push(y);
                            });

                            act_dayComent.children().remove();
                            act_day_rewards_list_tmpl = act_day_rewards_list_con.tmpl(act_webMain);
                            act_day_rewards_list_tmpl.appendTo(act_dayComent);
                        });

                            if (_activity_info_web[0].progress[0].key != 8) {
                                if (_activity_info_web[0].progress[0].key != 9) {
                                    if (_activity_info_web[0].status == 1)
                                    { $("#web_act_b").show(); }
                                    else
                                    { $("#web_act_b").hide(); }
                                }
                            }
                        
                        webActContainer.children().remove();
                        webActTmpl = webActCon.tmpl(_activity_info_web);
                        webActTmpl.appendTo(webActContainer);
                        webActContainer.show().next().hide();
                    } else {
                        $("#web_act_b").hide();
                        webActContainer.hide().next().show();
                    }

                    $('#actContainer,#everyContainer,#act_web_Coment').find("i,img").each(function(index) {
                        if ($(this).attr("alt")) {
                            var pos = {
                                y: -25,
                                x: 15
                            };
                            var cssObj = {
                                "padding": "2px"
                            };
                            mgc_tips.cssFixPosTips($(this).attr("alt"), $(this), pos, cssObj);
                        }
                    });

                    $('.act_list').find('.btn_get').off('click').on('click', function() {
                        if (!disabledBtn) {
                            getRewardsBtn = this;
                            var data = $(this).attr('get-data');
                            data = mgc_tool.strToJson(data);
                            act_request.getActRewards(data.act_id, data.category);
                        }
                    });
                    act_rewards_list_tmpl = null;
                    act_rewards_list_con = null;
                    actTmpl = null;
                    actCon = null;
                    act_day_rewards_list_tmpl = null;
                    act_day_rewards_list_con = null;
                    everyTmpl = null;
                    everyCom = null;
                    webActTmpl = null;
                    webActCon = null;
                } else {
                    //异常
                }
            } catch (e) {
                console.log(e);
            }
        },

        //领取每日工资
        GetDailyWageCallBack: function(responseStr) {
            var obj = typeof responseStr == 'object' ? responseStr : mgc_tool.strToJson(responseStr);
            var dialogStr = {}, _callBack = function() {
                disabledBtn = false;
            };
            if (obj.res == 1) {
                dialogStr.Note = '领取成功！<br>欢迎明天再来。<br>提升等级或提升贵族后，<br>每日工资将进一步提升';
                dialogStr.Title = '每日工资领取';
                _callBack = function() {
                    var mhb = parseInt($('#i_mhb').text()), wage = parseInt(obj.wage), a_wage = parseInt(obj.attached_wage);
                    var nowMhb = mhb + wage + a_wage;
                    $('#i_mhb').text(nowMhb);
                    mgc_tips.commonTips(nowMhb + "梦幻币", $('#icon_mhb'));
                    $('#i_wage').html('<span class="btn_geted">已领取</span>');
                    act_request.getDoneAct();
                    //====tencent====//
                    disabledBtn = false;
                };
            } else if (obj.res == 2) {
                dialogStr.Note = '您已经领取过了！';
            } else if (obj.res == 3) {
                window.mgc.common_logic.CheckNameError(150);
            } else {
                dialogStr.Note = '网络繁忙，请稍后重试！';
            }
            //====horizon====//
            disabledBtn = false;
            mgc_dialog.simpleDialog(5, dialogStr, _callBack);
        },
        //领取活动奖励
        GetActRewardsCallBack: function(responseStr) {
            var obj = typeof responseStr == 'object' ? responseStr : mgc_tool.strToJson(responseStr);
            if (obj.type == 0) {
                var dialogStr = {};
                var Qgame = false;
                var n = 1;
                switch(parseInt(obj.res)) {
                    case 1:
                        var l = obj.rewards.length;
                        if (l > 0) {
                            $.each(obj.rewards, function (k, v) {
                                var url = v.channel == 0 ? v.url : v.channel == 3 ? v.url : v.channel == 4 ? v.url : v.channel == 2 ? ("http://ossweb-img.qq.com/images/mgc/css_img" + v.url) : ("http://ossweb-img.qq.com/images/mgc/css_img" + v.url);
                                v.url = url;
                                v.Qgame = false;
                                if (v.channel == 3) {
                                    v.Qgame = true;
                                    Qgame = true;
                                    }
                                });
                            if (MgcAPI.SNSBrowser.IsQQGame()) {
                                Qgame = true;
                            }
                            n = 1;
                            obj.showTips = "任务完成，恭喜您获得以下奖励";
                            if (Qgame) {
                                if (obj.is_reissue) {
                                    obj.showTips = "很遗憾，本期任务奖励已经发完，您获得了安慰奖励：";
                                } else {
                                    obj.showTips = "任务完成，恭喜您获得以下奖励：（如获得游戏道具，会自动放入您的QQ游戏大厅背包中）";
                                }
                                obj.showTips_game = "";
                            } else {
                                if (obj.hasgame) {
                                    if(window.mgc.config.channel == 0){
                                        obj.showTips_game = "（获得的游戏道具会直接进入游戏背包）";
                                    }else{
                                        obj.showTips_game = "（获得的游戏道具以邮件发放到电脑端）";
                                    }
                                } else {
                                    obj.showTips_game = "：";
                                }
                            }
                            var boxGiftCon = $('#boxGiftTmpl');
                            var boxGiftTmpl;
                            var boxGiftContainer = $('#boxGiftContainer');
                            boxGiftContainer.children().remove();
                            boxGiftTmpl = boxGiftCon.tmpl(obj);
                            boxGiftTmpl.appendTo(boxGiftContainer);
                            mgc_popmanager.layerControlShow($('#boxGiftContainer'), 5, 1);
                            boxGiftContainer.centerDisp();
                            $('#boxGiftContainer').find("a").off('click').on('click', function() {
                                mgc_popmanager.layerControlHide($('#boxGiftContainer'), 5, 1);
                                $(getRewardsBtn).parents('tr').fadeOut('fast', function() {
                                    $(this).remove();
                                });
                                act_request.enter();
                                act_request.getDoneAct();
                                //====tencent====//
                                disabledBtn = false;
                            });
                            //$('#boxGiftContainer').find("li").find("span").each(function(index) {
                            //    mgc_tips.missionTips($(this).attr("mgc-data-name"), $(this).attr("mgc-data-tips"), $(this), 5, 3);
                            //});
                        }
                        boxGiftTmpl = null;
                        boxGiftCon = null;
                        break;
                    case 2:
                        dialogStr.Note = '活动任务已过期！';
                        mgc_dialog.simpleDialog(5, dialogStr, function () {
                            act_request.enter();
                            act_request.getDoneAct();
                        });                        
                        break;
                    case 3:
                        dialogStr.Note = '活动任务尚未完成，加油努力吧！';
                        mgc_dialog.simpleDialog(5, dialogStr);
                        break;
                    case 4:
                        dialogStr.Note = '您已经领取过活动任务奖励！';
                        mgc_dialog.simpleDialog(5, dialogStr);
                        break;
                    default:
                        dialogStr.Note = '领取失败！';
                        mgc_dialog.simpleDialog(5, dialogStr);
                        break;
                }
            }
            //====horizon====//
            disabledBtn = false;
        },
        mySetTime: function(time) {
            var d = new Date();
            d.setTime(time * 1000);
            var _nDate = ((parseInt(d.getMonth()) + 1) < 10 ? ('0' + (parseInt(d.getMonth()) + 1)) : (parseInt(d.getMonth()) + 1)) + '月' + (d.getDate() < 10 ? ('0' + d.getDate()) : d.getDate()) + '日' + (d.getHours() == 0 ? '00' : d.getHours()) + ':' + (d.getMinutes() == 0 ? '00' : d.getMinutes());
            return _nDate;
        },
        hasActCallBack: function(obj) {
            obj = mgc_tool.strToJson(obj);

            if(obj.status == 65)
            {
                //window.mgc.common_logic.CheckNameError(153);
                return;
            }

            if (obj.count > 0) {
                $('.logined_nav').find('b').show();
            } else {
                $('.logined_nav').find('b').hide();
            };
        }
    };

    var tabNavBind = function(navId, con, tabType) {
        var allTab = $(navId).find(tabType);
        allTab.each(function(i) {
            $(this).off('click').on('click', function() {
                allTab.removeClass().eq(i).addClass("current");
                $(con).hide().eq(i).show();
                act_request.enter();
                mgc_tool.EAS([{ 'e_c': 'mgc.acttask', 'c_t': 4 }]);
            });
        });
    };

    return control;
});

