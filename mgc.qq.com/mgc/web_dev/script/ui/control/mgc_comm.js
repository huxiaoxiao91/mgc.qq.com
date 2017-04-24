/**
 * Created by 77 on 2015/10/8.
 */
/**
 * Todo:1.处理全局统一逻辑
 */
define(['mgc_callcenter', 'mgc_comm_model', 'mgc_comm_coll', 'mgc_comm_view', 'mgc_tool', 'mgc_consts'], function(callcenter, comm_model, comm_coll, mgc_comm_view, tool, consts) {
    var common = {};
    /*
     *首登回调处理
     */
    common.LoginGiftsResp = {
        /*
         **检查是否首登-回调
         */
        checkIsFirstLoginCallBack: function(resp, params) {
            callcenter.check_sign(common.SignResp.checkSignCallBack, { isAuto: false, isStop: true });
            tool.cookie("LoginGiftsResp_IsToken", resp.isToken, {
                path: '/',
                domain: '.qq.com'
            });
         /*   if (resp.isToken) {
                common.IndexResp.taskCenterGuideCallBack();
            }*/
            console.log("check is first login callback：" + JSON.stringify(resp));
            var cookie_key = "mgc_logingifts_" + mgc.account.getUin() + "_" + tool.cookie("mgc_zoneid");
            if (!(tool.is_home_page() || tool.is_in_room_page() || tool.is_ranklist_page() || tool.is_show_page() || tool.is_playback_page() || tool.is_act_page()) || tool.cookie(cookie_key) == new Date().format("yyyy-MM-dd")) {
                console.log("登录统计");
                return;
            }
            if (!resp.isToken && resp.rewards && resp.rewards.length > 0) {
                //自动弹出首登礼包领取界面
                var first_login_view = new mgc_comm_view.FirstLoginView(resp, function() {
                    //有时候会触发断点重连请求（为了解决这个，做如下操作）--定时处理                    
                    callcenter.receive_login_gifts(common.LoginGiftsResp.receiveLoginGiftsCallBack);
                    common.LoginGiftsResp.receiveLoginGiftCakkBackTimeout();
                }, function() {
                    callcenter.check_sign(common.SignResp.checkSignCallBack);
                });
            } else {
                //非首登状态下 - 立即判断签到状态 isAuto:是否自动弹出 ; isStop:是否阻止弹出
                callcenter.check_sign(common.SignResp.checkSignCallBack, {
                    isAuto: true,
                    isStop: false
                });
            }
            //每天只弹出一次  记录cookie
            tool.cookie(cookie_key, new Date().format("yyyy-MM-dd"), {
                path: '/',
                domain: '.qq.com'
            });
        },
        receLogincallBackTimer: null,
        receiveLoginGiftCakkBackTimeout: function() {
            if (!common.LoginGiftsResp.receiveCallbackFlag) {
                clearTimeout(common.LoginGiftsResp.receLogincallBackTimer);
                common.LoginGiftsResp.receLogincallBackTimer = setTimeout(common.LoginGiftsResp.receiveLoginGiftsCallBack, 5000);
            }
        },
        /*
         *领取首登礼包-回调
         */
        receiveLoginGiftsCallBack: function(resp, params) {
            common.LoginGiftsResp.receiveCallbackFlag = true;
            console.log("receive first login gifts callbak：" + JSON.stringify(resp));
            $("#pop_logingifts").hide();
            var dialog = {
                "Title": "提示",
                "Note": ""
            };
            if (!resp) {
                return;
            }
            if (resp.res == 0) {
                //成功操作 关闭首登礼包领取界面

                if (resp.is_reissue) {
                    var first_login_get_view = new mgc_comm_view.FirstLoginGetView(resp, function() {
                        if (window.mgc.tools.is_home_page()) {
                            //N分钟在热门推荐处弹引导气泡                                                       
                            common.IndexResp.indexNewPlayerGuideCallBack();

                        } else if (window.mgc.tools.is_in_room_page()) {
                            if (tool.cookie("LoginGiftsResp_IsToken") == 'false') {
                                //房间内领首登礼包成功
                                tool.cookie("timerNend_index", '1024', {
                                    path: '/',
                                    domain: '.qq.com'
                                });
                                common.IndexResp.taskCenterGuideCallBack();
                            }
                        }
                    });
                } else {
                    ////新手礼包功能而干掉了 --成功以后  N分钟在热门推荐处弹引导气泡
                    //window.mgc.popmanager.layerControlShow($('#pop_newPlayer'), 4, 1);

                    if (window.mgc.tools.is_home_page()) {
                        //N分钟在热门推荐处弹引导气泡                                                
                        common.IndexResp.indexNewPlayerGuideCallBack();

                    } else if (window.mgc.tools.is_in_room_page()) {
                        if (tool.cookie("LoginGiftsResp_IsToken") == 'false') {
                            //房间内领首登礼包成功
                            tool.cookie("timerNend_index", '1024', {
                                path: '/',
                                domain: '.qq.com'
                            });
                            common.IndexResp.taskCenterGuideCallBack();
                        }
                    }

                }

            } else if (resp.res == 1) {
                //失败操作 不关闭首登礼包领取界面                
                window.mgc.popmanager.layerControlShow($('#pop_newPlayer_error'), 4, 1);
            } else {
                //重复领取                
                window.mgc.popmanager.layerControlShow($('#pop_newPlayer_get'), 4, 1);
            }
            //新手礼包功能而干掉了 --成功以后  N分钟在热门推荐处弹引导气泡
            /* $('#pop_newPlayer_a').unbind('click').bind('click', function() {
                 window.mgc.popmanager.layerControlHide($('#pop_newPlayer'), 4, 1);                
             });
             $('#pop_newPlayer_act').unbind('click').bind('click', function() {
                 window.mgc.popmanager.layerControlHide($('#pop_newPlayer'), 4, 1);                
             });*/
            $('#pop_newPlayer_a_error').unbind('click').bind('click', function() {
                window.mgc.popmanager.layerControlHide($('#pop_newPlayer_error'), 4, 1);
                callcenter.check_sign(common.SignResp.checkSignCallBack);
            });
            $('#pop_newPlayer_a_geted').unbind('click').bind('click', function() {
                window.mgc.popmanager.layerControlHide($('#pop_newPlayer_get'), 4, 1);
                callcenter.check_sign(common.SignResp.checkSignCallBack);
            });

        }
    };
    /*
     *签到回调处理
     */
    common.SignResp = {
        /*
         *检查签到回调
         */
        checkSignCallBack: function(resp, params) {
            console.log("check sign status callback：" + JSON.stringify(resp));
            if (resp.status == 0) {//成功状态下
                $("#signin,#h-nav .nav4").unbind("click").click(function() {
                    callcenter.query_sign_info(common.SignResp.getSignInfoCallBack);
                });
                //header 签到常驻按钮的显示与隐藏
                if (resp.is_Daily || resp.is_Acc) {
                    $(".header_sign_flash,#h-nav .nav4 .icon-red-dot").show();
                } else {
                    $(".header_sign_flash,#h-nav .nav4 .icon-red-dot").hide();
                }
                if (!params.isStop) {
                    if (params.isAuto) {//属于自动弹出签到界面
                        if (resp.is_Daily) {
                            //允许弹出签到界面
                            callcenter.query_sign_info(common.SignResp.getSignInfoCallBack);
                        }
                    } else {
                        //允许弹出界面
                        callcenter.query_sign_info(common.SignResp.getSignInfoCallBack);
                    }
                }
            } else {//失败状态下
                tool.commonDialog({
                    "Title": "提示",
                    "Note": "签到状态获取失败！"
                });
            }
        },
        /*
         *获取签到信息
         */
        signView: null,
        signViewTipsIndex: null,
        clearSetTimeSignDay: null,
        getSignInfoCallBack: function(resp, params) {
            console.log("get sign info callback：" + JSON.stringify(resp));
            //主界面
            common.SignResp.signView = new mgc.common_view.SignView(resp, function() {
                callcenter.receive_daily_reward(common.SignResp.receiveDailyRewardCallBack);
            }, function(n, m) {
                common.SignResp.signViewTipsIndex = parseInt(m);
                callcenter.receive_cumulative_reward(n, common.SignResp.receiveCumulativeRewardCallBack);
            });
            //每天只弹出一次  记录cookie
            tool.cookie("mgc_sign_" + mgc.account.getUin() + "_" + tool.cookie("mgc_zoneid"), new Date().format("yyyy-MM-dd"), {
                path: '/',
                domain: '.qq.com'
            });
        },
        /*
         *领取每日签到奖励
         */
        receiveDailyRewardCallBack: function(resp, params) {
            console.log("领取每日签到奖励回调：" + JSON.stringify(resp));
            if (resp.res == 0) {


                /*
                //领取成功 弹出奖励信息
                var data = {};
                var Qgame = false;
                data.hasgame = resp.hasgame;
                data.rewards = [];
                if (MgcAPI.SNSBrowser.IsQQGame()) {
                    Qgame = true;
                }
                if (!resp.is_reissue) {
                    if ($.isArray(resp.rws)) {
                        data.rewards = resp.rws;
                    } else {
                        data.rewards = [];
                        data.rewards.push(resp.rws);
                    }
                    resp.Qgame = resp.rws.channel == 3 ? true : false;
                    if (resp.Qgame) {
                        Qgame = true;
                    }
                } else {
                    if ($.isArray(resp.reward_list)) {
                        data.rewards = resp.reward_list;
                    } else {
                        data.rewards = [];
                        data.rewards.push(resp.reward_list);
                    }
                    resp.Qgame = resp.rws.channel == 3 ? true : false;
                    if (resp.Qgame) {
                        Qgame = true;
                    }
                }
                data.title = "签到奖励";
                if (Qgame) {
                    if (resp.is_reissue) {
                        data.showTips = "很遗憾，本期签到奖励已经发完，您获得了安慰奖励：";
                    } else {
                        data.showTips = "签到成功！再接再厉！恭喜您获得如下奖励！（如获得游戏道具，会自动放入您的QQ游戏大厅背包中）";
                    }
                    data.showTips_game = "";
                } else {
                    data.showTips = "签到成功！再接再厉！恭喜您获得以下奖励";

                    if (data.hasgame == true) {
                        data.showTips_game = "（获得的游戏道具以邮件发放到电脑端）";
                    } else {
                        data.showTips_game = "：";
                    }
                }
                */

                //由成功后弹弹窗奖励改为 tips气泡 提醒：签到成功，定时2秒钟后渐隐消失
                $('.signTips_day').css('display', 'block');
                clearTimeout(common.SignResp.clearSetTimeSignDay);
                common.SignResp.clearSetTimeSignDay = setTimeout('$(".signTips_day").fadeOut();', 2000);


                /*     var reward_dialog_view = new comm_view.RewardDialogView(data, function() {
                      }, function() {
                      });
                      */
            } else if (resp.res == 2) {
                //您已经领取 弹出失败提醒
                tool.commonDialog({
                    "Title": "提示",
                    "Note": "今日您已签过到了！"
                }, function() {
                    //todo  关闭签到界面
                    $("#pop_sign .pop_close").click();
                });
            } else {
                //领取失败 弹出失败提醒
                tool.commonDialog({
                    "Title": "提示",
                    "Note": "数据哥哥正在拼命赶来的路上，请稍后再试~~>_<~~"
                }, function() {
                    //todo  关闭签到界面
                    $("#pop_sign .pop_close").click();
                });
            }
            common.SignResp.signView.click_daily_reward = true;
        },
        clearSetTimeSignOne: null,
        clearSetTimeSignTwo: null,
        clearSetTimeSignThree: null,
        clearSetTimeSignFour: null,
        /*
         *领取累计签到奖励
         */
        receiveCumulativeRewardCallBack: function(resp, params) {
            console.log("领取累计签到奖励回调：" + JSON.stringify(resp));
            if (resp.res == 0) {

                /*
                //领取成功 弹出奖励信息
                var data = {};
                var Qgame = false;
                data.hasgame = resp.hasgame;
                if (MgcAPI.SNSBrowser.IsQQGame()) {
                    Qgame = true;
                }
                if (resp.is_reissue) {
                    if ($.isArray(resp.reward_list)) {
                        data.rewards = resp.reward_list;
                    } else {
                        data.rewards = [];
                        data.rewards.push(resp.reward_list);
                    }
                } else {
                    if ($.isArray(resp.rws)) {
                        data.rewards = resp.rws;
                    } else {
                        data.rewards = [];
                        data.rewards.push(resp.rws);
                    }
                }

                data.title = "累计签到奖励";
                if (Qgame) {
                    if (resp.is_reissue) {
                        data.showTips = "很遗憾，本期累计签到奖励已经发完，您获得了安慰奖励：";
                    } else {
                        data.showTips = "哇哦~感受到你对我浓浓的爱意！送您以下大礼（如获得游戏道具，会自动放入您的QQ游戏大厅背包中）";
                    }
                    data.showTips_game = ('');
                } else {
                    data.showTips = "哇哦~感受到你对我浓浓的爱意！送您以下大礼";
                    if (data.hasgame) {
                        data.showTips_game = ('（获得的游戏道具以邮件发放到电脑端）');
                    } else {
                        data.showTips_game = ('：');
                    }
                }
                */

                //由成功后弹弹窗奖励改为 tips气泡 提醒：领取成功，定时2秒钟后渐隐消失
                //显示对应的tips common.SignResp.signViewTipsIndex, 当为0时候 显示第一个tips气泡，以此类推
                switch (common.SignResp.signViewTipsIndex) {
                    case 0:
                        $('.signTips_one').css('display', 'block');
                        clearTimeout(common.SignResp.clearSetTimeSignOne);
                        common.SignResp.clearSetTimeSignOne = setTimeout('$(".signTips_one").fadeOut();', 2000);
                        break;
                    case 1:
                        $(".signTips_two").css('display', 'block');
                        clearTimeout(common.SignResp.clearSetTimeSignTwo);
                        common.SignResp.clearSetTimeSignTwo = setTimeout('$(".signTips_two").fadeOut();', 2000);
                        break;
                    case 2:
                        $(".signTips_three").css('display', 'block');
                        clearTimeout(common.SignResp.clearSetTimeSignThree);
                        common.SignResp.clearSetTimeSignThree = setTimeout('$(".signTips_three").fadeOut();', 2000);
                        break;
                    case 3:
                        $(".signTips_four").css('display', 'block');
                        clearTimeout(common.SignResp.clearSetTimeSignFour);
                        common.SignResp.clearSetTimeSignFour = setTimeout('$(".signTips_four").fadeOut();', 2000);
                        break;
                    default:
                        break;
                }

                /* var reward_dialog_view = new comm_view.RewardDialogView(data, function() {
                 }, function() {
                 });
                 */
            } else if (resp.res == 2) {
                //您已经领取 弹出失败提醒
                tool.commonDialog({
                    "Title": "提示",
                    "Note": "您已经领取过这个奖励了！"
                }, function() {
                    //todo  关闭签到界面
                    $("#pop_sign .pop_close").click();
                });
            } else {
                //领取失败 弹出失败提醒
                //您已经领取 弹出失败提醒
                tool.commonDialog({
                    "Title": "提示",
                    "Note": "数据哥哥正在拼命赶来的路上，请稍后再试~~>_<~~"
                }, function() {
                    //todo  关闭签到界面
                    $("#pop_sign .pop_close").click();
                });
            }
            common.SignResp.signView.click_cumulative_reward = true;
        }
    };
    /*
    * 好友充值提示
    */
    common.GoodFriendPay = {
        goodFriendArr: {},
        //好友充值回调
        goodFriendPayCallBack: function(responseStr) {
            console.log("好友充值回调_repStr:" + responseStr);
            var _repStr = responseStr;
            if (typeof (_repStr.friendpay) == 'undefined') {
                common.GoodFriendPay.goodFriendArr = _repStr;
            } else {
                common.GoodFriendPay.goodFriendArr = _repStr.friendpay;
            }
            if (common.GoodFriendPay.goodFriendArr.length > 0) {
                //填充第一个数据，弹窗，删除第一个数据
                common.GoodFriendPay.goodFriendPaypop();
            }
        },
        goodFriendHas: function() {
            if (common.GoodFriendPay.goodFriendArr.length > 0) {
                common.GoodFriendPay.goodFriendPayCallBack(common.GoodFriendPay.goodFriendArr);
            } 
        },
        goodFriendPaypop: function() {
            //填充第一个数据，弹窗，删除第一个数据            
            var obj = common.GoodFriendPay.goodFriendArr[0];
            var con = $('#goodFriendPayTmpl');
            var tmpl;
            var container = $('#goodFriendPayContainer');
            container.children().remove();
            tmpl = con.tmpl(obj);
            tmpl.appendTo(container);
            common.GoodFriendPay.goodFriendArr.shift();
            window.mgc.popmanager.layerControlShow($('#goodFriendPay'), 5, 1);
            $('#ConfirmBtn,#CloseBtn').unbind('click').bind('click', function() {
                window.mgc.popmanager.layerControlHide($('#goodFriendPay'), 5, 1);
                common.GoodFriendPay.goodFriendHas();
            });
            con = null;
            tmpl = null;
        }

    };
    common.IndexReq = {
        /*
        *获取玩家当前任务数
        */
        getDoneActCount: function() {
            callcenter.query_done_act_count(common.IndexResp.hasActCallBack);
        }
    };
    common.IndexResp = {
        /*
        *隐身状态切换回调
        */
        SetUserStatusCallBack: function(resp, params) {
            var dialog = {};
            switch (parseInt(resp.res)) {
                case 0:
                    var _status = 0,
                        _an_stat = 1,
                        _s_str = '在线',
                        _a_str = '隐身';
                    _note = '设置在线成功！';
                    consts.MGCData.invisible = false;
                    console.log('是否隐身——隐身回调切换——在线（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                    if (resp.invisble == true) {
                        _status = 1;
                        _an_stat = 0;
                        _s_str = '隐身';
                        _a_str = '在线';
                        _note = '隐身成功!在隐身状态内，您的大部分操作将不会显示给当前的观众';
                        consts.MGCData.invisible = true;
                        console.log('是否隐身——隐身回调切换——隐身（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                    }
                    $('.logined_status strong').attr('class', 'icon' + _status).html(_s_str);
                    $('.logined_status li').attr('class',
                        'icon' + (parseInt(_status) == 0 ? 1 : 0)).html(_a_str);
                    dialog.Note = _note;
                    break;
                case 3:
                    dialog.Note = '您已经隐身了哦！';
                    break;
                case 4:
                    dialog.Note = '对不起，您没有隐身的权限，只有将军及以上的贵族玩家才可拥有！';
                    break;
                default:
                    dialog.Note = '对不起，隐身失败！';
                    break;
            }
            tool.commonDialog(dialog);
        },
        /*
        *登录异常检测
        */
        ChangeLoginCallback: function(resp, params) {
            console.log("检测到您的登录状态异常，请重新登录   new :" + JSON.stringify(resp));
            var NoteObj = {};
            if (resp.res == 1) {
                NoteObj.Note = "哎呀，程序哥哥发呆了，快去刷新重试吧";
            } else if (resp.res == 2) {
                NoteObj.Note = "您的登录状态发生了异常，需要重新登录哦";
            } else if (resp.res == 3) {
                NoteObj.Note = "世界那么大，程序哥哥出门散步了~亲！需要刷新重试哦";
            } else {
                NoteObj.Note = "检测到您的登录状态异常，请重新登录";
            }
            if((MgcAPI.SNSBrowser.IsQQGameLiveArea() == 'true') && (resp.res != 1) && (resp.res != 3)){
                //检测登录异常时，清除缓存
                mgc.account.hasSkey = false;
                mgc.account.logout();
                mgc.account.clear_cookie();
                mgc.comm_model.getLoginBarModel.toggle(false);
                mgc.callcenter.query_clear_login_cookie(function () {
                    console.log("cookie cleared!");
                    var myTime = new Date();
                    var filename = window.location.href;
                    mgc.tools.cookie("mgc_logError_qqaccount_checkLoginCallback", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___Test-the-login-state-expired___web--qqaccount_checkLoginCallback-islogin-false___filename" + filename, {
                        path: '/',
                        domain: '.qq.com'
                    });
                });
                tool.commonDialog(NoteObj, function() {
                    $("#login-bar-btn").click();
                });
            } else{
                tool.commonDialog(NoteObj, function() {
                    window.location.href = window.mgc.tools.changeUrlToLivearea(consts.url.HOME);
                });
            }
        },
        //新手礼包领取成功以后--N分钟 热门推荐位置引导提示
        newTimer: null,
        newTimerend: null,
        indexNewPlayerGuideCallBack: function(resp, params) {
            var cookie_key_index = 'IsIndexNewPlay';
            tool.cookie(cookie_key_index, (new Date().format("yyyy-MM-dd")), {
                path: '/',
                domain: '.qq.com'
            });
            //首页新手引导开始时间-计算出结束时间
            var myTime = new Date();
            var myHour = myTime.getHours();
            var myMinute = myTime.getMinutes();
            var mySection = myTime.getSeconds();
            if (myMinute == 50) {
                myMinute = 0;
                myHour++;
            } else if (myMinute == 51) {
                myMinute = 1;
                myHour++;
            } else if (myMinute == 52) {
                myMinute = 2;
                myHour++;
            } else if (myMinute == 53) {
                myMinute = 3;
                myHour++;
            } else if (myMinute == 54) {
                myMinute = 4;
                myHour++;
            } else if (myMinute == 55) {
                myMinute = 5;
                myHour++;
            } else if (myMinute == 56) {
                myMinute = 6;
                myHour++;
            } else if (myMinute == 57) {
                myMinute = 7;
                myHour++;
            } else if (myMinute == 58) {
                myMinute = 8;
                myHour++;
            } else if (myMinute == 59) {
                myMinute = 9;
                myHour++;
            } else {
                myMinute = myMinute + 10;
            }
            var strMyTimeArr = myHour + ',' + myMinute + ',' + mySection;
            tool.cookie('strMyTimeArr', (strMyTimeArr), {
                path: '/',
                domain: '.qq.com'
            });
            // var strMyTimeNew = (myMinute * 60 + mySection) * 1000 + '毫秒';
            //首页新手礼包引导cookie
            var cookie_guide = 'cookieGuide';
            clearTimeout(common.IndexResp.newTimer);
            clearTimeout(common.IndexResp.newTimerend);
            common.IndexResp.newTimer = setTimeout(common.IndexResp.cookieGuideFun, 600000);
            $('#pop_newPlayer .pop_close,#index_newPlayer_enter').unbind('click').bind('click', function() {
                $("#pop_newPlayer").fadeOut();
            })

        },
        //定时读取cookie的时候判断是否显示方法
        cookieGuideFun: function() {
            if (tool.cookie('cookieGuideRoom') == null && (tool.cookie('cookieGuideRoom_flag') == '1024')) {
                return;
            } else {
                var indexHref = null;
                indexHref = $("#index_newPlayer_enter").attr('href');
                if (indexHref != 'javascript:showDialog.hide();') {
                    $("#pop_newPlayer").fadeIn();
                }
            }
        },

        //任务中心-提示引导
        timer: null,
        timerN: null,
        timerNend: null,
        taskCenterGuideCallBack: function(resp, params) {
            
                //从主页引导，进入房间以后弹 和 没有主页引导，在房间内登录后弹
                if (tool.cookie("LoginGiftsResp_IsToken") == 'false' && tool.cookie("timerNend_index") == "1024") {
                    //首页领取大礼包成功时，清弹热门推荐弹窗cookie
                    tool.cookie("IsIndexNewPlay", null, {
                        path: '/',
                        domain: '.qq.com'
                    });
                    clearTimeout(common.IndexResp.timerN);
                    common.IndexResp.timerN = setTimeout(function () {
                        //10分钟后清除房间内领首登礼包成功标识--恢复正常tips弹出逻辑
                        tool.cookie("timerNend_index", null, {
                            path: '/',
                            domain: '.qq.com'
                        });
                    }, 600000);
                   
                } else {
                    //is_act_guide_over 是否弹出过tips任务气泡标识 ：false 没有弹过，true 弹过（以后不再弹）
                    if ((!resp.is_act_guide_over) && (tool.cookie("timerNend_index") == null)) {
                        //正常弹出
                        clearTimeout(common.IndexResp.timer);
                        $('#reminder').fadeIn();
                        $('#reminder .close').unbind('click').bind('click', function () {
                            $("#reminder").fadeOut();
                        });
                        common.IndexResp.timer = setTimeout('$("#reminder").fadeOut();', 30000);
                        //319接口通知弹出完毕
                        callcenter.popup_task_pop();
                    }
                }
            
        },
        hasActCount: null,
        /*
        * 未完成任务数回调
        */
        hasActCallBack: function(resp, params) {
            if (!resp.has_taken_wage_today) {
                if (resp.count - 1 > 0) {
                    common.IndexResp.hasActCount = true;
                }
            } else {
                if (resp.count > 0) {
                    common.IndexResp.hasActCount = true;
                }
            }
            if (resp.status == 65) {
                //window.mgc.common_logic.CheckNameError(153);
                return;
            }

            if (resp.count > 0) {
                $('.logined_nav,#h-nav .nav5').find('b').show();
            } else {
                $('.logined_nav,#h-nav .nav5').find('b').hide();
            };
        }
    };

    // 开通VIP相关请求
    common.MGCVIPRequest = {
        // 获用户VIP信息
        getUserVipInfo: function() {
            if (mgc.account.checkGuestStatus()) {
                return false;//游客身份下，屏蔽此操作
            }
            callcenter.query_player_vip_info(common.CommOpenVip.openUserVipCallBack, null);
        },

        // 获取VIP价格信息
        getVipPriceInfo: function() {
            callcenter.query_player_vip_price_info(common.CommOpenVip.getVipPriceCallBack, null);
        },
        // 开通VIP
        StartVip: function(viplevel, duration, costtype) {
            callcenter.open_vip(viplevel, duration, costtype, common.CommOpenVip.in_anchor_id, common.CommOpenVip.StartVipCallBack, null);
        },
        // 续费VIP
        RenewalVip: function(viplevel, duration, costtype) {
            callcenter.renewal_vip(viplevel, duration, costtype, common.CommOpenVip.attached_anchor_id, common.CommOpenVip.RenewalVipCallBack, null);
        }
    };
    var refreshVipInfo = function() {
        mgc.common_logic.getPlayerInfo();
    }
    // 开通贵族
    common.CommOpenVip = {
        isReturnHome: false,//是否返回首页
        myLevel: 0, //我的贵族等级
        remainTime: 0,//天数
        attached_anchor_id: "0",//绑定的主播ID
        attached_anchor_name: "",//绑定的主播昵称
        in_anchor_id: "0",//当前入口的主播id
        in_anchor_name: "",//当前入口的主播昵称
        room_anchor_id: "0",//当前房间的主播id
        room_anchor_name: "",//当前房间的主播昵称
        ktPriceList: [],
        xfPriceList: [],
        detail: [],
        choosen: {},
        clickLevel: 0,

        beanOrCoin: 2, //2 炫豆 1 梦幻币
        discountCost: 0,//折后的价格
        fullcost: 0,//未打折的价格

        initOpenBtnSwf: function(n) {
            tool.initSwf("si_open_vip_swf_" + n, "si_open_vip_swf_" + n, "assets/open_vip_btn_" + n + ".swf");
        },
        getRemainDate: function(remainTime) {
            if (remainTime <= 0) return false;
            var _myVipDuration;
            _myVipDuration = Math.ceil(remainTime / 86400);
            _myVipDuration = _myVipDuration + '天';
            return _myVipDuration;
        },
        fillList: function(xfType, ffLength) {
            var _myLevel = common.CommOpenVip.clickLevel;
            var detail = common.CommOpenVip.detail;
            var xfListHtml = '',
                xfPayHtml = '';
            var _style = parseInt(xfType) == 1 ? 'background:url("http://ossweb-img.qq.com/images/mgc/css_img/common/cash_classify/dream_money.png?v=3_8_8_2016_15_4_final_3") no-repeat' : 'background:url("http://ossweb-img.qq.com/images/mgc/css_img/common/cash_classify/money_balance.png?v=3_8_8_2016_15_4_final_3") no-repeat';

            if (xfType.length == 1) {
                common.CommOpenVip.beanOrCoin = xfType;
                var _class = parseInt(xfType) == 1 ? 'icon_mhb' : 'icon_xd',
                    _tname = parseInt(xfType) == 1 ? '梦幻币' : '炫豆';

                $('#select_pay_btn').attr('data', xfType); // 添加续费默认值
                $('#select_pay_btn span').html(_tname + '<i class="' + _class + '"style='+_style+'"></i>');
                if (ffLength == 2) {
                    xfPayHtml += '<li data=2><span>炫豆<i class="icon_xd" style="background:url(http://ossweb-img.qq.com/images/mgc/css_img/common/cash_classify/money_balance.png?v=3_8_8_2016_15_4_final_3) no-repeat;"></i></span></li>';
                    xfPayHtml += '<li data=1><span>梦幻币<i class="icon_mhb" style="background:url(http://ossweb-img.qq.com/images/mgc/css_img/common/cash_classify/dream_money.png?v=3_8_8_2016_15_4_final_3) no-repeat;" ></i></span></li>';
                } else {
                    xfPayHtml = '<li data=' + xfType + '><span>' + _tname + '<i class="' + _class + '"style=' + _style + '"></i></span></li>';
                }
            } else if (xfType.length == 2) {
                $('#select_pay_btn').attr('data', 2); // 默认炫豆
                $('#select_pay_btn span').html('炫豆<i class="icon_xd" style="background:url(http://ossweb-img.qq.com/images/mgc/css_img/common/cash_classify/money_balance.png?v=3_8_8_2016_15_4_final_3) no-repeat;"></i>');
                xfPayHtml += '<li data=2><span>炫豆<i class="icon_xd" style="background:url(http://ossweb-img.qq.com/images/mgc/css_img/common/cash_classify/money_balance.png?v=3_8_8_2016_15_4_final_3) no-repeat;"></i></span></li>';
                xfPayHtml += '<li data=1><span>梦幻币<i class="icon_mhb" style="background:url(http://ossweb-img.qq.com/images/mgc/css_img/common/cash_classify/dream_money.png?v=3_8_8_2016_15_4_final_3) no-repeat;"></i></span></li>';
            }
            var j = 0;
            // 折后价格需要根据当前等级来计算
            common.CommOpenVip.discountCost = common.CommOpenVip.xfPriceList[_myLevel][0].cost;
            //守卫梦幻币特殊处理
            if (parseInt(common.CommOpenVip.beanOrCoin) == 2 && _myLevel == 1) {
                common.CommOpenVip.discountCost = common.CommOpenVip.xfPriceList[_myLevel][3].cost;
            }

            for (var i = 0, len = detail.length; i < len; i++) {
                var _cost_type = parseInt(detail[i].cost_type),
                    _duration = detail[i].duration,
                    _cost = detail[i].cost,
                    _vipName = detail[i].vip_name,
                    _fullcost = detail[i].fullcost,
                    _iconClass = '';
                if (xfType.length == 1) {
                    if (parseInt(xfType) == _cost_type) {

                        if (_cost_type == 1) {
                            _iconClass = 'icon_mhb';
                        } else if (_cost_type == 2) {
                            _iconClass = 'icon_xd';
                        }
                    } else {
                        continue;
                    }
                } else if (xfType.length == 2) {
                    if (_cost_type == 2) {
                        _iconClass = 'icon_xd';
                    } else {
                        continue;
                    }
                }
                if (j == 0) {
                    $('#select_open_btn').attr('data', "{\"type\":" + _myLevel + ",\"duration\":" + _duration + "}"); // 添加开通默认值
                    // $('#select_open_btn span').html(_vipName + '(' + _duration + '天)' + (_fullcost > 0 ? '  <em>' + _fullcost + '</em>' : '') + '  ' + _cost + '<i class="' + _iconClass + '"></i>');
                    $('#select_open_btn span').html(_vipName + '(' + _duration + '天)' + ' ' + (_fullcost > 0 ? _fullcost : _cost) + ' ' + '<i class="' + _iconClass + '"style=' + _style + '"></i>');
                    common.CommOpenVip.fullcost = _fullcost > 0 ? _fullcost : _cost;
                }
                // xfListHtml += '<li data=\'{\"type\":' + _myLevel + ',\"duration\":' + _duration + '}\'><span>' + _vipName + '(' + _duration + '天)' + (_fullcost > 0 ? '  <em>' + _fullcost + '</em>' : '') + '  ' + _cost + '<i class="' + _iconClass + '"></i></span></li>';
                xfListHtml += '<li data=\'{\"type\":' + _myLevel + ',\"duration\":' + _duration + '}\'><span>' + _vipName + '(' + _duration + '天)' + ' ' + (_fullcost > 0 ? _fullcost : _cost) + '<i class="' + _iconClass + '"style=' + _style + '"></i></span></li>';
                j++;
            }
            $('#select_pay_list').html(xfPayHtml);
            $('#select_open_list').html(xfListHtml);
            $("#select_open_btn,#select_open_list").delegate(".icon_mhb", "mouseover", function(e) {
                var _e = e.target == undefined ? e.toElement : e.target;
                var t = _e.offsetTop + 500;
                var l = _e.offsetLeft + 190;
                $('.mhb_tips_vip').css({ "top": t, "left": l });
                //$('.mhb_tips_vip').show();
                window.mgc.popmanager.layerControlShow($('.mhb_tips_vip'), 4, 3);
            }).delegate(".icon_mhb", "mouseout", function(e) {
                //$('.mhb_tips_vip').hide();
                window.mgc.popmanager.layerControlHide($('.mhb_tips_vip'), 4, 3);
            });
            $("#select_open_btn,#select_open_list").delegate(".icon_xd", "mouseover", function(e) {
                var _e = e.target == undefined ? e.toElement : e.target;
                var t = _e.offsetTop + 500;
                var l = _e.offsetLeft + 190;
                $('.xd_tips_vip').css({ "top": t, "left": l });
                window.mgc.popmanager.layerControlShow($('.xd_tips_vip'), 4, 3);
            }).delegate(".icon_xd", "mouseout", function(e) {
                window.mgc.popmanager.layerControlHide($('.xd_tips_vip'), 4, 3);
            });

            $("#select_pay_btn,#select_pay_list").delegate(".icon_mhb", "mouseover", function(e) {
                var _e = e.target == undefined ? e.toElement : e.target;
                var t = _e.offsetTop + 500;
                var l = _e.offsetLeft + 640;

                var X = document.body.clientWidth;
                if (MgcAPI.SNSBrowser.IsQQGame() && X <= 1024) {
                    l = _e.offsetLeft + 370;
                }
                else {
                    //重新定位
                    tool.comm_tips_position($('.mhb_tips_vip_2'), false, -80, -20);
                }

                $('.mhb_tips_vip_2').css({ "top": t, "left": l });
                window.mgc.popmanager.layerControlShow($('.mhb_tips_vip_2'), 4, 3);
                window.mgc.popmanager.layerControlHide($('.mhb_tips_vip'), 4, 3);
            }).delegate(".icon_mhb", "mouseout", function(e) {
                window.mgc.popmanager.layerControlHide($('.mhb_tips_vip_2'), 4, 3);
            });

            $("#select_pay_btn,#select_pay_list").delegate(".icon_xd", "mouseover", function(e) {
                var _e = e.target == undefined ? e.toElement : e.target;
                var t = _e.offsetTop + 500;
                var l = _e.offsetLeft + 640;

                var X = document.body.clientWidth;
                if ((MgcAPI.SNSBrowser.IsQQGame() || MgcAPI.SNSBrowser.IsX52()) && X <= 1024) {
                    l = _e.offsetLeft + 370;
                }
                else {
                    //重新定位
                    tool.comm_tips_position($('.mhb_tips_vip_2'), false, -80, -20);
                }

                $('.xd_tips_vip_2').css({ "top": t, "left": l });
                window.mgc.popmanager.layerControlShow($('.xd_tips_vip_2'), 4, 3);
                window.mgc.popmanager.layerControlHide($('.xd_tips_vip'), 4, 3);
            }).delegate(".icon_xd", "mouseout", function(e) {
                window.mgc.popmanager.layerControlHide($('.xd_tips_vip_2'), 4, 3);
            });
            window.mgc.popmanager.layerControlHide($('.mhb_tips_vip'), 4, 3);
            window.mgc.popmanager.layerControlHide($('.xd_tips_vip'), 4, 3);
            window.mgc.popmanager.layerControlHide($('.mhb_tips_vip_2'), 4, 3);
            window.mgc.popmanager.layerControlHide($('.xd_tips_vip_2'), 4, 3);
        },
        myVipSelect: function(id, list) {
            $("#" + id).unbind('click').click(function() {
                if ($("#" + list).css("display") == "none") {
                    window.mgc.popmanager.layerControlShow($("#" + list), 4, 2);
                } else {
                    window.mgc.popmanager.layerControlHide($("#" + list), 4, 2);
                }
            });
            $(document).click(function(e) {
                e = e || window.event; // 兼容IE7
                obj = $(e.srcElement || e.target);
                if ($(obj).is("#" + id + ",#" + id + " *")) {
                    $("#" + list).show();
                } else {
                    $("#" + list).hide();
                }
            });
            $("#" + list).delegate('li', 'click', function() {
                window.mgc.popmanager.layerControlHide($("#" + list), 4, 2);
                var shtml = $(this).find("span").html();
                var d = $(this).attr('data');
                $("#" + id).attr('data', d);
                var l = $("#" + list + " li").length;
                if (list == "select_pay_list") {
                    if (d == 1) {
                        $(".pop_t_txt_no").show();
                    } else {
                        $(".pop_t_txt_no").hide();
                    }
                    common.CommOpenVip.fillList(d, l);
                } else {
                    var details = common.CommOpenVip.detail;
                    var payType = common.CommOpenVip.beanOrCoin;
                    var alis = $(this).parent().find("li");

                    for (var i = 0, n = alis.length; i < n; i++) {
                        $(alis[i]).attr("vip_index", i);
                    }

                    var oneDets = [];
                    for (var i = 0, n = details.length; i < n; i++) {
                        if (payType == details[i].cost_type) {
                            oneDets.push(details[i]);
                        }
                    }
                    common.CommOpenVip.fullcost = oneDets[$(this).attr("vip_index")].fullcost > 0 ? oneDets[$(this).attr("vip_index")].fullcost : oneDets[$(this).attr("vip_index")].cost;
                    common.CommOpenVip.discountCost = common.CommOpenVip.xfPriceList[common.CommOpenVip.myLevel || 1][$(this).attr("vip_index")].cost;
                    //守卫梦幻币特殊处理
                    if (parseInt(common.CommOpenVip.beanOrCoin) == 2 && common.CommOpenVip.myLevel == 1) {
                        common.CommOpenVip.discountCost = common.CommOpenVip.xfPriceList[common.CommOpenVip.myLevel || 1][parseInt($(this).attr("vip_index")) + 3].cost;
                    }
                }

                $("#" + id).find("span").html(shtml);
            });
        },
        initClick: function(vipLevel) {
            var _myLevel = parseInt(common.CommOpenVip.myLevel);
            var xfVipInfo = common.CommOpenVip.xfPriceList;
            var ktVipInfo = common.CommOpenVip.ktPriceList;
            $('#open_vip_list a').unbind('click').bind('click', function() {
                $('#open_vip_list a').removeClass('current');
                $(this).addClass('current');
                var clickLevel = parseInt($(this).attr('vip'));
                // var detail = _myLevel == clickLevel ? xfVipInfo[_myLevel] : ktVipInfo[clickLevel];
                var detail;
                if (_myLevel == clickLevel) {
                    if ((common.CommOpenVip.attached_anchor_id > 0) && (common.CommOpenVip.attached_anchor_id == common.CommOpenVip.in_anchor_id)) {
                        detail = xfVipInfo[_myLevel];
                    } else {
                        detail = ktVipInfo[clickLevel];
                    }
                } else {
                    detail = ktVipInfo[clickLevel];
                }

                common.CommOpenVip.clickLevel = _myLevel == clickLevel ? _myLevel : clickLevel;
                common.CommOpenVip.detail = detail;
                var xfType = '';
                for (var i = 0, len = detail.length; i < len; i++) {
                    //取出当前贵族列表里的付费方式
                    if (detail[i].cost_type > 0 && xfType.indexOf(detail[i].cost_type) == -1) {
                        xfType = xfType + '' + detail[i].cost_type;
                    }
                }
                common.CommOpenVip.fillList(xfType);
                if (_myLevel == clickLevel) {
                    if (common.CommOpenVip.attached_anchor_id == "0") {
                        //若 没有绑定主播
                        $('#ktBtn').attr('class', 'btn_open');
                        $('#xfBtn').attr('class', 'btn_disabled');
                    } else {
                        if (common.CommOpenVip.attached_anchor_id == common.CommOpenVip.in_anchor_id) {
                            //若 绑定的主播==入口主播
                            $('#ktBtn').attr('class', 'btn_disabled');
                            $('#xfBtn').attr('class', 'btn_open');
                        } else {
                            //若 绑定的主播!=入口主播
                            $('#ktBtn').attr('class', 'btn_open');
                            $('#xfBtn').attr('class', 'btn_open');
                        }
                    }
                } else {
                    $('#ktBtn').attr('class', 'btn_open');
                    $('#xfBtn').attr('class', 'btn_disabled');
                }
                $(".pop_t_txt_no").hide();
            });
        },
        // 打开
        open: function(anchorid, anchorname) {
            common.CommOpenVip.in_anchor_id = anchorid || common.CommOpenVip.room_anchor_id;
            common.CommOpenVip.in_anchor_name = anchorname || common.CommOpenVip.room_anchor_name;
            if (common.CommOpenVip.in_anchor_id == "0") { return; }
            common.MGCVIPRequest.getUserVipInfo();
        },
        // 开通
        ktVip: function() {
            if ($('#ktBtn').hasClass('btn_disabled')) {
                //置灰状态下 不可点击
                return;
            }
            var ktInfo = $('#select_open_btn').attr('data'),
                ktType = $('#select_pay_btn').attr('data'),
                ktInfo = JSON.parse(ktInfo);


            var dialog = {};
            var vipName = consts.vipLevelTab[ktInfo.type];
            dialog.Title = '提示信息';
            dialog.BtnNum = 2;
            dialog.BtnName2 = '取消';

            // attached_anchor_id 不等于0就是新贵族了
            if (common.CommOpenVip.attached_anchor_id != 0) {

                dialog.Note = '感谢老板绑定新宠<b style="line-height:35px;">' + common.CommOpenVip.in_anchor_name + '</b> 并开通贵族：' + vipName + '(' + ktInfo.duration + '天)<br/>实际支付' + (parseInt(common.CommOpenVip.beanOrCoin) == 1 ? "梦幻币" : "炫豆") + '价格：<b style="line-height:35px;">' + common.CommOpenVip.fullcost + '</b><br/>开通后主播获得奖励，您同时获得丰厚返利~';

            } else { //attend_anchor_id 等于零就是老贵族或者没有贵族

                dialog.Note = '为<b style="line-height:35px;">' + common.CommOpenVip.in_anchor_name + '</b>开通贵族：' + vipName + '(' + ktInfo.duration + '天)<br/>实际支付' + (parseInt(common.CommOpenVip.beanOrCoin) == 1 ? "梦幻币" : "炫豆") + '价格：<b style="line-height:35px;">' + common.CommOpenVip.fullcost + '</b><br/>开通后主播获得奖励，您同时获得丰厚返利~';

            }

            var _this = this;
            var _callBack = function() {
                var __callback = function() {
                    var _choosen = {};
                    _choosen.level = ktInfo.type;
                    _choosen.vipName = vipName;
                    _choosen.duration = ktInfo.duration;
                    common.CommOpenVip.choosen = _choosen;
                    common.MGCVIPRequest.StartVip(ktInfo.type, ktInfo.duration, ktType);
                }
                if (common.CommOpenVip.myLevel > 0) {
                    //如果vip>0的 弹二次确认框
                    dialog.Note = '您开通新贵族后，原有<b>' + common.CommOpenVip.remainTime + '</b>' + consts.vipLevelTab[common.CommOpenVip.myLevel] + '贵族身份会被系统<b>直接收回</b><br/><b style="color:#8212ff;font-size:16px;line-height:35px;">土豪，现在真开？</b>';
                    tool.commonDialog(dialog, __callback);
                } else {
                    __callback();
                }
            }
            tool.commonDialog(dialog, _callBack);
        },
        // 续费
        xfVip: function() {
            if ($('#xfBtn').hasClass('btn_disabled')) {
                //置灰状态下 不可点击
                return;
            }
            var xfInfo = $('#select_open_btn').attr('data'),
                xfType = $('#select_pay_btn').attr('data'),
                xfInfo = JSON.parse(xfInfo);
            var dialog = {};
            if (common.CommOpenVip.myLevel != xfInfo.type) {
                dialog.Title = '提示信息';
                dialog.Note = '您尚未开通此贵族，续费失败';
                tool.commonDialog(dialog);
                return;
            }
            //此处处理当我绑定的A主播，在B主播的房间续费贵族身份时，弹框的炫豆不对的问题
            var _discountCost = common.CommOpenVip.discountCost;

            /*
            if (common.CommOpenVip.attached_anchor_id != common.CommOpenVip.in_anchor_id && common.CommOpenVip.myLevel == 1) {
                if (parseInt(common.CommOpenVip.beanOrCoin) == 2) {
                    _discountCost = common.CommOpenVip.xfPriceList[common.CommOpenVip.myLevel][4].cost;
                } else {
                    xfInfo.duration = common.CommOpenVip.xfPriceList[common.CommOpenVip.myLevel][0].duration;
                }
            }
            */

            var vipName = consts.vipLevelTab[xfInfo.type];
            dialog.Title = vipName + '贵族来啦~接驾！';
            dialog.BtnNum = 2;
            dialog.BtnName2 = '取消';
            dialog.Note = '感谢老板再次恩宠<b style="line-height:35px;">' + common.CommOpenVip.attached_anchor_name + '</b>' + xfInfo.duration + '天<br/>实际支付' + (parseInt(common.CommOpenVip.beanOrCoin) == 1 ? "梦幻币" : "炫豆") + '价格：<b style="line-height:35px;">' + _discountCost + '</b><br/>续费后可按实际付费价格获得丰厚返利哦~';

            var _this = this;
            var _callBack = function() {
                var _choosen = {};
                _choosen.level = xfInfo.type;
                _choosen.vipName = vipName;
                _choosen.duration = xfInfo.duration;
                common.CommOpenVip.choosen = _choosen;
                common.MGCVIPRequest.RenewalVip(xfInfo.type, xfInfo.duration, xfType);
            }
            tool.commonDialog(dialog, _callBack);
        },
        // 弹出贵族主界面
        openUserVipCallBack: function(resp, param) {
            if (resp.vipLevel > 0) {
                common.CommOpenVip.attached_anchor_id = resp.attachedAnchorID;
                common.CommOpenVip.attached_anchor_name = resp.attachedAnchor;
                common.CommOpenVip.myLevel = parseInt(resp.vipLevel);
                var remainTime = common.CommOpenVip.getRemainDate(resp.remainTime);
                common.CommOpenVip.remainTime = remainTime;
                var _attached_anchor_name = common.CommOpenVip.attached_anchor_name == "" ? "" : "   一     " + common.CommOpenVip.attached_anchor_name;
                $('#myDegree').html('<strong>' + resp.vipName + '</strong>' + _attached_anchor_name + '(' + remainTime + ')');
                var _index = resp.vipLevel - 1;
                $('#open_vip_list a').removeClass('current').eq(_index).addClass('current');
            } else {
                common.CommOpenVip.myLevel = 0;
                $('#myDegree').html('无');
                $('#open_vip_list a').removeClass('current').eq(0).addClass('current');//默认近卫
            }
            if (common.CommOpenVip.attached_anchor_id == "0") {
                //若 没有绑定主播
                $('#ktBtn').attr('class', 'btn_open');
                $('#xfBtn').attr('class', 'btn_disabled');
            } else {
                if (common.CommOpenVip.attached_anchor_id == common.CommOpenVip.in_anchor_id) {
                    //若 绑定的主播==入口主播
                    $('#ktBtn').attr('class', 'btn_disabled');
                    $('#xfBtn').attr('class', 'btn_open');
                } else {
                    //若 绑定的主播!=入口主播
                    $('#ktBtn').attr('class', 'btn_open');
                    $('#xfBtn').attr('class', 'btn_open');
                }
            }
            $('#xfBtn').attr('href', 'javascript:;').click(common.CommOpenVip.xfVip);
            $('#ktBtn').attr('href', 'javascript:;').click(common.CommOpenVip.ktVip);
            if (common.CommOpenVip.isReturnHome) {
                $('#mgc_vip .pop_close').attr('href', 'javascript:;').click(function() { 
                    window.location.href = window.mgc.tools.changeUrlToLivearea(consts.url.HOME); 
                });
            } else {
                $('#mgc_vip .pop_close').attr('href', 'javascript:;').click(function() { window.mgc.popmanager.layerControlHide($("#mgc_vip"), 4, 1); });
            }
            common.MGCVIPRequest.getVipPriceInfo(); // 获取价格列表
            $(".pop_t_txt_no").hide();
            $("#NoteP").css("textAlign", "center");
        },
        // 开通或续费后
        afterKtOrXf: function(obj) {
            $('#myDegree').html('<strong>' + obj.vipName + '</strong> (' + obj.duration + '天)');
            common.CommOpenVip.myLevel = obj.level;
            common.CommOpenVip.initClick();
            $('#open_vip_list a').each(function() {
                var _vip = $(this).attr('vip');
                if (_vip == obj.level) {
                    $(this).click();
                }
            })
        },
        // 获取VIP价格信息
        getVipPriceCallBack: function(resp, param) {
            var priceInfo = resp.info,
                ktVipInfo = priceInfo.start_price_list,
                xfVipInfo = priceInfo.renewal_price_list,
                rebateInfo = resp.rebate_info || [];
            common.CommOpenVip.ktPriceList = ktVipInfo;
            common.CommOpenVip.xfPriceList = xfVipInfo;
            var _myLevel = common.CommOpenVip.myLevel;
            var detail;

            if ((common.CommOpenVip.attached_anchor_id > 0) && (common.CommOpenVip.attached_anchor_id == common.CommOpenVip.in_anchor_id)) {
                detail = xfVipInfo[_myLevel];
            } else {
                detail = ktVipInfo[_myLevel > 0 ? _myLevel : 1];
            }
            common.CommOpenVip.clickLevel = _myLevel > 0 ? _myLevel : 1;
            common.CommOpenVip.detail = detail;
            var xfType = '';
            for (var i = 0, len = detail.length; i < len; i++) {
                //取出当前贵族列表里的付费方式
                if (detail[i].cost_type > 0 && xfType.indexOf(detail[i].cost_type) == -1) {
                    xfType = xfType + '' + detail[i].cost_type;
                }
            }
            //【新贵族】展示返利比例
            for (var i = 1; i <= rebateInfo.length; i++) {
                $("#mgc_vip").find(".vip-" + i).find(".rebate_num").html(rebateInfo[i] + "%");
            }
            //默认炫豆
            common.CommOpenVip.beanOrCoin = 2;
            common.CommOpenVip.fillList(xfType);
            common.CommOpenVip.initClick();
            common.CommOpenVip.myVipSelect('select_pay_btn', 'select_pay_list');
            common.CommOpenVip.myVipSelect('select_open_btn', 'select_open_list');
            if ($("#pop3").css('display') == 'block') {
                window.mgc.popmanager.layerControlHide($("#pop3"), 4, 1);
            }
            window.mgc.popmanager.layerControlShow($("#mgc_vip"), 4, 1);
            $("#mgc_vip").centerDisp();
        },
        // 开通VIP
        StartVipCallBack: function(resp, param) {
            var dialog = {};
            var _callback = null;
            switch (parseInt(resp.errcode)) {
                case 0:
                    var _this = this;
                    var _choosen = common.CommOpenVip.choosen;
                    _callback = function() { window.mgc.popmanager.layerControlHide($("#mgc_vip"), 4, 1); refreshVipInfo(); }
                    if (resp.cost_type == 1) {
                        //梦幻币支付
                        dialog.Note = '您成功开通了' + _choosen.vipName + '贵族身份~';
                    } else {
                        common.CommOpenVip.reward_dialog(_choosen.vipName, resp.rebate, true, _callback, _callback);
                        return;
                    }
                    break;
                case 1:
                case 2:
                case 6:
                    //dialog.Note = '操作失败！';
                    dialog.Note = '对不起，您没有足够的炫豆或梦幻币';
                    break;
                case 3:
                    dialog.Note = '操作失败！';
                    break;
                case 5:
                    //dialog.Note = '您的炫逗余额不足，是否立即购买';
                    dialog.Note = '对不起，您没有足够的炫豆或梦幻币';
                    dialog.BtnNum = 2;
                    dialog.BtnName = '购买炫豆';
                    dialog.url = consts.url.IPAY;
                    break;
                case 9:
                    dialog.Note = '您已开通过此贵族，无法重复开通';
                    break;
                case 15:
                    //dialog.Note = '您的梦幻币余额不足，您可以通过领取每日工资和完成任务获得梦幻币';
                    dialog.Note = '对不起，您没有足够的炫豆或梦幻币';
                    break;
                case 18:
                    window.mgc.common_logic.CheckNameError(105);
                    break;
                case 20:
                    dialog.Note = '操作失败！';
                    break;
                default:
                    dialog.Note = '操作失败！';
                    //dialog.Note = '对不起，您没有足够的炫豆或梦幻币';
                    break;
            }
            tool.commonDialog(dialog, function() {
                if (common.CommOpenVip.isReturnHome) {//返回首页通知
                    window.location.reload();
                } else {
                    if (!_callback) {
                        refreshVipInfo();
                        tool.hideDialog(false);
                    } else {
                        _callback();
                    }
                }
            });
        },
        // 续费VIP
        RenewalVipCallBack: function(resp, param) {
            var dialog = {};
            var _callback = null;
            switch (parseInt(resp.errcode)) {
                case 0:
                    var _this = this;
                    var _choosen = common.CommOpenVip.choosen;
                    _callback = function() { window.mgc.popmanager.layerControlHide($("#mgc_vip"), 4, 1); refreshVipInfo(); }
                    if (resp.cost_type == 1) {
                        //梦幻币支付
                        dialog.Note = '续费操作成功';
                    } else {
                        common.CommOpenVip.reward_dialog(_choosen.vipName, resp.rebate, false, _callback, _callback);
                        return;
                    }
                    break;
                case 1:
                case 2:
                case 6:
                    //dialog.Note = '操作失败！';
                    dialog.Note = '对不起，您没有足够的炫豆或梦幻币';
                    break;
                case 3:
                    dialog.Note = '操作失败！';
                    break;
                case 5:
                    //dialog.Note = '您的炫逗余额不足，是否立即购买';
                    dialog.Note = '对不起，您没有足够的炫豆或梦幻币';
                    dialog.BtnNum = 2;
                    dialog.BtnName = '购买炫豆';
                    dialog.url = consts.url.IPAY;
                    break;
                case 9:
                    dialog.Note = '您尚未开通此贵族，续费失败';
                    break;
                case 15:
                    //dialog.Note = '您的梦幻币余额不足，您可以通过领取每日工资和完成任务获得梦幻币';
                    dialog.Note = '对不起，您没有足够的炫豆或梦幻币';
                    break;
                case 18:
                    window.mgc.common_logic.CheckNameError(106);
                    break;
                case 20:
                    dialog.Note = '操作失败！';
                    break;
                default:
                    dialog.Note = '操作失败！';
                    //dialog.Note = '对不起，您没有足够的炫豆或梦幻币';
                    break;
            }
            tool.commonDialog(dialog, function() {
                if (common.CommOpenVip.isReturnHome) {//返回首页通知
                    window.location.reload();
                } else {
                    if (!_callback) {
                        refreshVipInfo();
                        tool.hideDialog(false);
                    } else {
                        _callback();
                    }
                }
            });
        },
        reward_dialog: function(vipname, rebate, is_kt, ok_callback, cancel_callback) {
            //领取成功 弹出奖励信息
            var data = {};
            data.rewards = [{
                "count_desc": rebate,
                "type": 0,
                "tips": "",
                "name": "炫豆",
                "url": "http://ossweb-img.qq.com/images/mgc/css_img/items/item_money.png?v=3_8_8_2016_15_4_final_3",
                "price": 0,
                "id": 0,
                "channel": 0,
                "CCY": null
            }];
            data.title = "提示信息";
            data.showTips = is_kt ? "感谢老板开通" + vipname + "贵族身份，返利奖品小的给您放进账户：" : "感谢老板再次恩宠，返利奖品小的给您放进账户：";
            data.showTips_game = "";
            var reward_dialog_view = new mgc.common_view.RewardDialogView(data, ok_callback, cancel_callback);
        }
    };
    // 排行榜__主播名片tips
    common.anchorTips = {
        // 主播id
        _anchorId: 0,
        // tips的x坐标
        _showX: 0,
        // tips的y坐标
        _showY: 0,
        // 记录上一次body的y坐标，判断是否滚动。
        _lastBodyY: 0,
        // 延迟显示计时器id
        _delayShowTimerId: 0,
        // 延迟隐藏计时器id
        _delayHideTimerId: 0,
        // 鼠标悬停状态。
        _isMouseOver: false,
        // 正在隐藏的主播tip的id
        _hideAnchorId: 0,
        // 当前状态。0-隐藏，1-即将隐藏，2-显示，3-即将显示。
        _status: 0,
        //点击重试发送请求
        reloadFun: function (anchorId) {
            $('#anchor_error').hide();
            $('#anchor_loadding').show();
            window.mgc.anchorCardRanklistRequest.getAnchorCard(anchorId);
        },
        //判断是否是IE内核
        checkClient: function () {
            return (tool.browser.ie6 || tool.browser.ie7 || tool.browser.ie8 || tool.browser.ie9 || tool.browser.ie10 || tool.browser.ie11 || tool.browser.firefox ? true : false);
        },
        // 要显示名片（延迟）
        doShow: function (anchorId, showX, showY, e) {
            var doshowX = 0;
            var doshowY = 0;
            if (common.anchorTips.checkClient()) {
                doshowX = e.clientX == undefined ? e.pageX : e.clientX;
                doshowY = e.clientY == undefined ? e.pageY : e.clientY;
            } else {
                doshowX = e.pageX == undefined ? e.clientX : e.pageX;
                doshowY = e.pageY == undefined ? e.clientY : e.pageY;
            }
            showX += doshowX;
            showY += doshowY;

            // 判断是否是新的tips
            var isNewTips = false;
            if (common.anchorTips._anchorId == 0) {
                isNewTips = true;
            } else {
                if (anchorId != common.anchorTips._anchorId ||
                    common.anchorTips._showX != showX ||
                    common.anchorTips._showY != showY) {
                    isNewTips = true;
                }
            }

            if (isNewTips) {
                common.anchorTips._hide();

                common.anchorTips._anchorId = anchorId;
                common.anchorTips._showX = showX;
                common.anchorTips._showY = showY;

                common.anchorTips._lastBodyY = document.body.scrollTop - document.body.clientTop;

                common.anchorTips._delayShowTimerId = setTimeout(common.anchorTips._show, 500);
            } else {
                // 当前要查看的主播正是要隐藏的主播tips，注销隐藏tips操作。 
                if (anchorId == common.anchorTips._hideAnchorId) {
                    clearTimeout(common.anchorTips._delayHideTimerId);
                }
            }
            $(window).unbind('scroll');
            $(window).scroll(function (e) {
                common.anchorTips._hide();
            });
            common.anchorTips._status = 3;

            console.log("mouse point(x:" + showX + ", y:" + showY + ")  body point(y:" + common.anchorTips._lastBodyY + ")");
        },
        // 展示名片
        _show: function () {
            var currentBodyY = document.body.scrollTop - document.body.clientTop;
            var currentBodyX = document.body.scrollLeft - document.body.clientLeft;

            console.log("mouse point -- (x:" + common.anchorTips._showY + ", y:" + common.anchorTips._showX + ")  body point(y:" + currentBodyY + ")body point(x:" + currentBodyX + ")");
            // 判断页面是否滚动
            if (Math.abs(currentBodyY - common.anchorTips._lastBodyY) < 4) {
                var ranklist_tips = $('.sus_anchor_tips');
                var ranklist_loadding = $('#anchor_loadding');
                var ranklist_anchor_error = $('#anchor_error');
                var outWidth = common.anchorTips._showX - currentBodyX + ranklist_tips.width();
                var outWidth_down = common.anchorTips._showY - currentBodyY + ranklist_tips.height();
                var lastLeft = 0, lastTop = 0;
                if (outWidth > $(window).width()) {
                    lastLeft = $(window).width() - ranklist_tips.width() - 2;
                } else {
                    lastLeft = common.anchorTips._showX - currentBodyX;
                }
                if (outWidth_down > $(window).height()) {
                    lastTop = $(window).height() - 173;
                } else {
                    lastTop = common.anchorTips._showY - currentBodyY;
                }

                ranklist_tips.css({
                    "top": lastTop,
                    "left": lastLeft
                });

                ranklist_tips.show();
                ranklist_loadding.show();
                ranklist_anchor_error.hide();

                $('#anchor_error').find('a').attr('href', 'javascript:window.mgc.common_contral.anchorTips.reloadFun(' + common.anchorTips._anchorId + ');');

                ranklist_tips.on("mouseenter", function (e) {
                    //ranklist_tips.show();
                    common.anchorTips._isMouseOver = true;
                    if (common.anchorTips._status = 1) {
                        clearTimeout(common.anchorTips._delayHideTimerId);
                    }
                });
                ranklist_tips.on("mouseleave", function (e) {
                    common.anchorTips._isMouseOver = false;
                    common.anchorTips.doHide();
                });

                // 加载数据
                window.mgc.anchorCardRanklistRequest.getAnchorCard(common.anchorTips._anchorId);

                common.anchorTips._status = 2;
            } else {
                common.anchorTips._hide();
            }
        },
        doHide: function () {
            console.log("mouse point  doHide (x:" + common.anchorTips._showY + ", y:" + common.anchorTips._showX + ")");
            if (common.anchorTips._status == 2) {
                if (common.anchorTips._isMouseOver) {
                    // 移动到Tips上，有tips的移除事件处理。
                } else {
                    common.anchorTips._hideAnchorId = common.anchorTips._anchorId;
                    common.anchorTips._delayHideTimerId = setTimeout(common.anchorTips._hide, 500);

                    common.anchorTips._status = 1;
                }
            } else {
                common.anchorTips._hide();
            }
        },
        // 隐藏名片
        _hide: function () {
            console.log("mouse point  clear (x:" + common.anchorTips._showY + ", y:" + common.anchorTips._showX + ")");
            common.anchorTips._status = 0;
            common.anchorTips._anchorId = 0;
            common.anchorTips._hideAnchorId = 0;
            clearTimeout(common.anchorTips._delayShowTimerId);
            clearTimeout(common.anchorTips._delayHideTimerId);

            $(window).unbind('scroll');

            $('.sus_anchor_tips').off("mouseenter");
            $('.sus_anchor_tips').off("mouseleave");

            $(".sus_anchor_tips").hide();
            $('#ranklist_anchorTipContainer').children().remove();
        }
    };

    // ==================公用的方法============================================================
    var MGC_Comm = {
        //========================永航测试方法=================================
        //永航内网测试接入接口
        isTransferRequest: false,
        countdownNum: 120,
        countdownId: 0,
        invitationData: null,
        genderInt: 0,

        strEndIndex : 0,
        g_HorizonLoginData: {
            mgcQQ: "0",
            mgcVerify: "test_verify"
        },
        //游客身份
        g_HorizonGuestData: {
            isGuest: false,
            mgc_guest_id: "",
            mgc_guest_token: ""
        },

        g_HorizonChangeLoginUIStatus: function() {
            console.log1("登录态：g_HorizonChangeLoginUIStatus");
            var logined = $j(".logined");
            var unlogined = $j(".unlogin");
            logined.show();
            unlogined.hide();
        },

        g_HorizonLogin: function() {
            console.log1("登录态：g_HorizonLogin");
            var qq = $("#txtLoginName").val();
            var logined = $j(".logined");
            var unlogined = $j(".unlogin");
            logined.show();
            unlogined.hide();
            MGC_Comm.g_HorizonLoginData.mgcQQ = qq;
            $.cookie("mgc_login", MGC_Comm.g_HorizonLoginData.mgcQQ);
        },

        g_HorizonLogout: function(_funca) {
            console.log1("登录态：g_HorizonLogout");
            var logined = $j(".logined");
            var unlogined = $j(".unlogin");
            logined.hide();
            unlogined.show();
            if (typeof _funca == 'function') {
                _funca();
            }
        },

        g_HorizonCheckLogin: function(_hasCookieCallback, _noCookieCallback) {
            MGC_Comm.g_HorizonLoginData.mgcQQ = MGC_Comm.commonGetCookie();
            if ((MGC_Comm.g_HorizonLoginData.mgcQQ == null || MGC_Comm.g_HorizonLoginData.mgcQQ.length == 0 || MGC_Comm.g_HorizonLoginData.mgcQQ == "0")) {
                //未登录
                _noCookieCallback();
            }
            else {
                _hasCookieCallback(MGC_Comm.g_HorizonLoginData.mgcQQ, MGC_Comm.g_HorizonLoginData.mgcVerify);
            }
        },

        g_HorizonIsLogin: function() {
            if (MGC_Comm.g_HorizonLoginData.mgcQQ == null || MGC_Comm.g_HorizonLoginData.mgcQQ.length == 0 || MGC_Comm.g_HorizonLoginData.mgcQQ == "0") {
                return false;
            }
            else {
                return true;
            }
        },
        //检查游客身份是否已经登录
        //isDoLogin:是否弹登录框
        CheckGuestStatus: function(isDoLogin) {
            //此处走重构版本游客判定
            return window.mgc.account.checkGuestStatus(isDoLogin);
            if (MGC_Comm.g_HorizonGuestData.isGuest && !isDoLogin) {
                //执行登录
                MGC_Comm.DoLoginFirst();
            }
            return MGC_Comm.g_HorizonGuestData.isGuest;
        },
        // 申请游客账号
        RegisterGuestCard: function() {
            var _reqStr = { "op_type": OpType.VOT_GetGuestInfo };
            console.log("申请游客账号：" + JSON.stringify(_reqStr));
            MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.RegisterGuestCardCallBack");
        },
        //种下游客cookie
        SetGuestCookie: function(obj) {
            MGC_Comm.g_HorizonGuestData.mgc_guest_id = obj.id;
            MGC_Comm.g_HorizonGuestData.mgc_guest_token = obj.encrypt_identity;
            MGC_Comm.g_HorizonGuestData.isGuest = true;
            $.cookie("mgc_guest_id", obj.id);
            //$.cookie("mgc_guest_token", obj.encrypt_identity);
            console.log("种下游客身份cookie：" + JSON.stringify(MGC_Comm.g_HorizonGuestData));
        },
        DelGuestCookie: function() {
            MGC_Comm.g_HorizonGuestData.mgc_guest_id = "";
            MGC_Comm.g_HorizonGuestData.mgc_guest_token = "";
            MGC_Comm.g_HorizonGuestData.isGuest = false;
            console.log("删除游客身份cookie：" + JSON.stringify(MGC_Comm.g_HorizonGuestData));
        },
        //永航自制登入弹框，可以输入QQ号
        g_funcHorizonLoginToast: function(okcallback) {
            //弹loading框
            MGC.popLoading(true);
            //这里应该弹自制组件，输入QQ号然后按确定回调
            //okcallback("2921101974");
            //自制输入框点取消时的回调。
            //cancelcallback();
            loginTest.showLoginTest(okcallback, function() {
                MGC.popLoading(false);
            });
        },
        //测试登录回调  在这里登出游客发送171
        loginToastOk: function() {
            //如果是在游客状态下切换正常玩家时 应先登出游客 发送171
            if (MGC_Comm.CheckGuestStatus(true) && (filename == "liveroom.shtml" || filename == "showroom.shtml" || filename == "caveolaeroom.shtml" || filename == "nest.shtml")) {
                console.log("登出游客171");
                MGC_Comm.sendMsg({ "op_type": 171 });
            } else {
                MGC_Comm.loginInfo();
            }
        },


        //==========================永航测试接口结束=============================

        commonLogin: function(_funca) {
                LoginManager.login(_funca);
                $("#coverbg").css("z-index", 990000);
                $("#loginDiv").css("z-index", 990001);
                //第三方登录插件 绑定关闭事件
                if (filename == "" || filename == "index.shtml") {
                    //
                } else {
                    LoginManager.closeLogin(function() {
                        if (!MGC_Comm.CheckGuestStatus(true))
                            window.location.href = window.mgc.tools.changeUrlToLivearea(home);
                        return true;
                    });
                }
        },

        commonCheckLogin: function(_funca, _funcb) {
            //走新框架逻辑
            mgc.account.checkLogin(_funca, _funcb, true);
        },

        // 获得uin
        commonGetUin: function(_funca, _funcb) {
            if (MGC_Comm.CheckGuestStatus(true)) {
                _funca(MGC_Comm.g_HorizonGuestData.mgc_guest_id.toString());
            } else {
                    var uin = '';
                    MGC_Comm.commonCheckLogin(function() {
                        _funca(LoginManager.getUserUin());
                    }, function() {
                        _funca(0);
                    });
            }
        },
        commonLogout: function(_funca) {
                LoginManager.logout(_funca);
        },

        commonIsLogin: function() {
                return LoginManager.isLogin();
        },

        // 获得cookie内容
        commonGetCookie: function(cookieName) {
                var _name = (typeof cookieName == 'undefined') ? 'mgc_login' : cookieName;
                return $.cookie(_name);

        },
        /**
        *   复制操作
        */
        copy: function(txt) {
            if (window.clipboardData) {
                window.clipboardData.clearData();
                if (window.clipboardData.setData("Text", txt)) {
                    alert("复制成功！");
                }
                else {
                    alert("对不起，您的浏览器不能使用复制功能，请手动复制！");
                }
            } else if (navigator.userAgent.indexOf("Opera") != -1) {
                window.location = txt;
            } else if (window.netscape) {
                try {
                    netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
                } catch (e) {
                    alert("对不起，您的浏览器不能使用复制功能，请手动复制！");
                }
                var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);
                if (!clip) return;
                var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);
                if (!trans) return;
                trans.addDataFlavor('text/unicode');
                var str = new Object();
                var len = new Object();
                var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
                var copytext = txt;
                str.data = copytext;
                trans.setTransferData("text/unicode", str, copytext.length * 2);
                var clipid = Components.interfaces.nsIClipboard;
                if (!clip) return false;
                clip.setData(trans, null, clipid.kGlobalClipboard);
                alert("复制成功！");
            } else {
                alert("对不起，您的浏览器不能使用复制功能，请手动复制！");
            }
        },

        // 复制昵称
        copyToClipBoard: function() {
            var txt = $(".ni_nick").text();
            if (window.clipboardData) {
                window.clipboardData.clearData();
                if (window.clipboardData.setData("Text", txt)) {
                    alert("复制成功！");
                }
                else {
                    alert("对不起，您的浏览器不能使用复制功能，请手动复制！");
                }
            } else if (navigator.userAgent.indexOf("Opera") != -1) {
                window.location = txt;
            } else if (window.netscape) {
                try {
                    netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
                } catch (e) {
                    alert("对不起，您的浏览器不能使用复制功能，请手动复制！");
                }
                var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);
                if (!clip) return;
                var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);
                if (!trans) return;
                trans.addDataFlavor('text/unicode');
                var str = new Object();
                var len = new Object();
                var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
                var copytext = txt;
                str.data = copytext;
                trans.setTransferData("text/unicode", str, copytext.length * 2);
                var clipid = Components.interfaces.nsIClipboard;
                if (!clip) return false;
                clip.setData(trans, null, clipid.kGlobalClipboard);
                alert("复制成功！");
            } else {
                alert("对不起，您的浏览器不能使用复制功能，请手动复制！");
            }
        },

        requestLogout: function(_funca) {
                LoginManager.logout(_funca);
        },

        afterLogout: function(type) {
            var _reqStr = "{\"op_type\":171}";
            MGC_Comm.sendMsg(_reqStr);
            MGC_Comm.loginInfo(type);
        },

        //浏览器无登陆态时点击登录调用。
        DoLoginFirst: function() {
            MGC_Comm.commonLogin(function() {
                MGC.popLoading(true);
                //如果是在游客状态下切换正常玩家时 应先登出游客 发送171
                if (MGC_Comm.CheckGuestStatus(true) && (filename == "liveroom.shtml" || filename == "showroom.shtml" || filename == "caveolaeroom.shtml" || filename == "nest.shtml")) {
                    console.log("登出游客171");
                    MGC_Comm.sendMsg({ "op_type": 171 });
                } else {
                    MGC_Comm.loginInfo();
                    $("#coverbg").css("z-index", 990000);
                    $("#loginDiv").css("z-index", 990001);
                    try {
                        EAS.SendClick({ 'e_c': 'mgc.login', 'c_t': 4 });
                    } catch (e) {

                    }
                }
            });
        },

        ToDoClosePage: function() {
            window.onbeforeunload = onbeforeunload_handler;
            function onbeforeunload_handler() {
                try {
                    getSWF("x51VideoWeb").UpLoadLog();
                    getSWF("LiveVideoSwfContainer").UpLoadLog();
                } catch (e) {

                }
            }
        },

        getUrlVars: function(url) {
            if (!url) {
                url = window.location.href;
            };
            var vars = [], hash;
            if (MgcAPI.SNSBrowser.IsX52()) {
                hashes = url.slice(url.indexOf('?') + 1).split(/[&#]/);
            } else {
                hashes = url.slice(url.indexOf('?') + 1).split(/[&#|]/);
            }
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                try {
                    vars[hash[0]] = decodeURIComponent(hash[1]);
                } catch (e) {

            }
            }
            return vars;
        },

        getUrlParam: function(name, url) {
            return MGC_Comm.getUrlVars(url)[name];
        },


        // 重写jquery的getScript方法，支持浏览器缓存
        getScript: function(url, callback) {
            $.getScript(url, function() {
                callback();
            });
        },

        // ajax提交方法，默认为不缓存,jsonp协议
        ajax: function(_url, callback) {
            $.ajax({
                type: 'get',
                url: _url,
                dataType: 'jsonp',
                jsonp: 'jsoncallback',
                success: function(data) {
                    callback(data);
                },
                error: function() {
                    alert('抱歉，网络繁忙，请稍候再试！');
                }
            });
        },

        // 加载flash
        setSwfObj: function() {
            var swfV = swfobject.getFlashPlayerVersion();
            if (swfV == null || typeof swfV == 'undefined' || swfV.major == 0) {
                var DialogObj = {};
                DialogObj.Note = "您没有安装flash，请安装最新版flash";
                MGC_Comm.CommonDialog(DialogObj, function() {
                    /*window.location.reload();*/
                });
            } else if (parseInt(swfV.major) < 14) {
                var DialogObj = {};
                DialogObj.Note = "您的flash版本过低，请您安装最新版flash";
                MGC_Comm.CommonDialog(DialogObj, function() {
                    /*window.location.reload();*/
                });
            };
            var swfVersionStr = "11.1.0";
            var xiSwfUrlStr = "http://124.207.138.230/x5videoWeb/playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
            var flashvars = {};
            //区分出新老版本消息发送
            if ((filename == "group.shtml" || filename == "showroom.shtml" || filename == "liveroom.shtml" || filename == "caveolaeroom.shtml" || filename == "nest.shtml")) {
                flashvars.isOldFrame = "true";
            }
            var params = {};
            params.quality = "high";
            params.bgcolor = "#ffffff";
            params.allowscriptaccess = "always";
            params.allowfullscreen = "true";
            var attributes = {};
            attributes.id = "x51VideoWeb";
            attributes.name = "x51VideoWeb";
            attributes.align = "middle";
            if (MGC.checkIsIEloadSwfFailed())
                swfUrl += "&r=" + new Date();
            swfobject.embedSWF(swfUrl, "flashContent", "1", "1", swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);

            swfobject.createCSS("#flashContent", "display:block;text-align:left;");
        },

        // 统一发送接口
        sendMsg: function(_reqStr, callback, param1) {
            try {
                //console.log( ":" + new Date().format("yyyy-MM-dd hh:mm:ss.S"));
                var swfobj = getSWF('x51VideoWeb');
                if (swfobj) {
                    //_reqStr = typeof (_reqStr) == "string" ? eval('(' + _reqStr + ')') : _reqStr;
                    _reqStr = typeof (_reqStr) == "string" ? JSON.parse(_reqStr) : _reqStr;
                    console.log("reqStr has send :reqStr : " + JSON.stringify(_reqStr) + + new Date().format("yyyy-MM-dd hh:mm:ss.S"));
                    swfobj.request_as(_reqStr, callback, param1);
                    swfobj = null;
                    _reqStr = null;
                    callback = null;
                }
            } catch (e) {
                console.log(e.message);
                setTimeout(function() {
                    MGC_Comm.sendMsg(_reqStr, callback);
                }, 50);
            }
        },

        // 公用的登陆组件
        loginInfo: function(type) {
            //登录模块，使用重构，此处不再处理
            return;
            //检查是否已经login
            MGC_Comm.commonCheckLogin(
                    function() {
                        MGC.popLoading(true);
                        mgc_CheckLogin(function() {
                            MGC_Comm.commonGetUin(function(_uin) {
                                MGC_Comm.getAsCache(_uin);
                            });
                        });
                    },
                    function() {
                        //强制登出
                        MGC_Comm.DoClear();
                        if ((filename == "group.shtml" || filename == "personal.shtml" || filename == "act.shtml" || filename == "showroom.shtml" || filename == "liveroom.shtml" || filename == "caveolaeroom.shtml" || filename == "nest.shtml" || filename == "transfer.shtml")) {
                            if (type == 1) {
                                window.location.href = window.mgc.tools.changeUrlToLivearea(home);
                            }
                            else {
                                if (MGC_Comm.getUrlParam("ADUIN")) {
                                    //执行登录
                                    MGC_Comm.DoLoginFirst();
                                } else {
                                    // 请求服务区列表接口，弹出来选择框
                                    try {
                                        EAS.SendClick({ 'e_c': 'mgc.poparea', 'c_t': 4 });
                                    } catch (e) {

                                    }
                                    MGCLoginRequest.roleList();
                                    //MGCLoginRequest.areaLogin(MGCData.mgcZoneId);
                                    //MGC_Comm.DoLoginFirst(); //不再弹出登录框
                                }
                            }
                        }
                        else {
                            MGCLoginRequest.noLoginRoleList();
                        }
                    });
        },

        getAsCache: function(Uin) {
            var _reqStr = "{\"op_type\":-1,\"qq\":\"" + Uin + "\"}";
            MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getAsCacheCallBack");
        },
        getAsGuestCache: function() {
            var _reqStr = "{\"op_type\":204}";
            MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getAsGuestCacheCallBack");
        },
        // 显示一个div
        showDiv: function(e) {
            showDialog.show({
                id: e,
                bgcolor: "#fff",
                opacity: 50
            });
        },

        // 隐藏div
        hideDiv: function() {
            showDialog.hide();
        },

        //隐藏功能框
        hideFunctionDialog: function() {
            showDialog.hide();
            $("#CommonDialog").hide();
        },

        // 字符串转json
        strToJson: function(responseStr) {
            return responseStr;
            //if (typeof (responseStr) != 'object') {
            //    var aresponseStr = responseStr.replace(/\r\n/g, "<br>");
            //    console.log("newreqStr : " + aresponseStr);
            //    return JSON.parse(aresponseStr);
            //} else {
            //    return responseStr;
            //}
        },


        bindSearch: function() {
            $('#search_con').focus(function() {
                if ($(this).val() == '请输入房间号') {
                    $(this).val("");
                }
            }).blur(function() {
                if ($.trim($(this).val()) == '') {
                    $(this).val("请输入房间号");
                }
            }).keyup(function() {
                if ($(this).val().length > 20) {
                    $(this).val($(this).val().substring(0, 20));
                }
            }).keydown(function(event) {
                if (event.keyCode == 13) {
                    //event.preventDefault();
                    //$('#submitForm').submit();
                    //MGC_Comm.searchSubmit();
                    //$('#searchBtn').trigger("click");
                }
            })
        },
        checkFormSubmit: function() {
            var con = $('#search_con').val();
            con = $.trim(con);
            if (con == '' || con == '请输入房间号') {
                alert('想要快速进入房间，必须输入2位以上数字');
                return false;
            } else if (con.length > 20) {
                alert('没有该房间哦');
                return false;
            } else if (!/^\d+$/.test(con)) {
                alert('想要快速进入房间，必须输入2位以上数字');
                return false;
            }
            var roomIdFormat = parseInt(con);
            if (roomIdFormat < 10) {
                alert('想要快速进入房间，必须输入2位以上数字。');
                return false;
            }
            var _url = "transfer.shtml";
            $('#submitForm').attr('action', _url);
            $('#formRoomId').val(con);
            try {
                EAS.SendClick({ 'e_c': 'mgc.enterroom.2', 'c_t': 4 });
                EAS.SendClick({ 'e_c': 'mgc.enterroom', 'c_t': 4 });
            } catch (e) {

            }
            return true;
        },

        // 快速进入
        searchSubmit: function() {
            var con = $('#search_con').val();
            con = $.trim(con);
            if (con == '' || con == '请输入房间号') {
                alert('想要快速进入房间，必须输入2位以上数字');
                return false;
            } else if (con.length > 20) {
                alert('没有该房间哦');
                return false;
            } else if (!/^\d+$/.test(con)) {
                alert('想要快速进入房间，必须输入2位以上数字');
                return false;
            }
            var roomIdFormat = parseInt(con);
            if (roomIdFormat < 10) {
                alert('想要快速进入房间，必须输入2位以上数字。');
                return false;
            }
            /*window.open(home + 'liveroom.shtml?roomId=' + con);*/
            /*MGC_CommRequest.checkRoomStatus(con);*/
            var _url = "transfer.shtml";
            $('#submitForm').attr('action', _url);
            $('#formRoomId').val(con);
            $('#submitBtn').click();
        },
        searchKeyUp: function(obj) {
            var v = $.trim($(obj).val());
            if (MGC_Comm.Strlen(v) > 20) {
                $(obj).val(MGC_Comm.Strcut(v, 20));
            }
        },
        searchKeyDown: function(obj) {
            var v = $(obj).val();
            if (MGC_Comm.Strlen(v) >= 20) {
                if (event.keyCode == 13)
                    event.returnValue = true;
                else
                    event.returnValue = false;
            }
            if (event.keyCode == 8) {
                event.returnValue = true;;
            }
        },
        // 显示角色状态设置框
        showUserStatus: function() {
            var _login_status_div = $('.logined_status'),
                _other_status = $('.logined_status ul');
            _login_status_div.on('click', function(e) {
                /*
                 * if(_other_status.is(':hidden')){ _other_status.show(); }else{
                 * _other_status.hide(); }
                 */
                _other_status.toggle();
                e.stopPropagation();
            });
            _other_status.find('li').on(
                'click',
                function(e) {
                    var _class = $(this).attr('class'),
                        _status = _class
                        .substr(_class.length - 1); // 0在线 1隐身
                    //如果玩家在座位上要隐身  弹提示
                    if (typeof (Seat) != "undefined" && _status == 1)
                    {
                        if ((Seat.isSeat(MGCData.myPlayerId)) || (mgc.consts.MGCData.myVipLevel > 0))
                        {
                            var dialog = {};
                            dialog.Title = '提示信息';
                            dialog.BtnNum = 2;
                            dialog.BtnName = '隐身';
                            dialog.BtnName2 = '算了吧';
                            dialog.Note = "亲，您隐身后将会自动离开座位";
                            MGC_Comm.CommonDialog(dialog, MGC_Comm.setUserStatus);
                        }
                        else {
                            MGC_Comm.setUserStatus(_status);
                        }
                    }
                    else {
                        MGC_Comm.setUserStatus(_status);
                    }
                    e.stopPropagation();
                })
        },

        // 设置隐身或在线状态
        setUserStatus: function(status) {
            //默认为隐身
            status = status ? status : 1;

            var _status = parseInt(status) == 0 ? false : true, // false在线 true隐身
                _reqStr = "{\"op_type\":140,\"invisible\":" + _status + ",\"client\":false}";
            MGC_Comm.sendMsg(_reqStr, "SetUserStatusCallBack");
        },

        // 初始化视频直播swf
        LiveVideoSwfInit: function() {
            var flashvars = {};
            //是否开启硬件编码
            /*
            flashvars.useHardwareDecoder = true;
            if($.isSafari())
            {
                flashvars.useHardwareDecoder = false;
            }
            */
            flashvars.useHardwareDecoder = false;
            //区分出新老版本消息发送
            if ((filename == "group.shtml" || filename == "showroom.shtml" || filename == "liveroom.shtml" || filename == "caveolaeroom.shtml" || filename == "nest.shtml")) {
                flashvars.isOldFrame = "true";
            }
            var params = {};
            params.quality = "high";
            params.bgcolor = "#000";
            params.allowscriptaccess = "always";
            params.allowfullscreen = "true";
            params.allowFullScreenInteractive = "true";
            params.wmode = "transparent";
            var attributes = {};

            /*
             * attributes.id = "LiveVideoSwf"; attributes.name = "LiveVideoSwf";
             * attributes.align = "middle";
             * swfobject.embedSWF("http://124.207.138.230/x5videoWeb/x51VideoWeb.swf?v=3_8_8_2016_15_4_final_3",
             * "flashContent", "1", "1", swfVersionStr, xiSwfUrlStr, flashvars,
             * params, attributes);
             */

            /*
             * attributes.id = "LiveVideoSwf"; attributes.name = "LiveVideoSwf";
             * attributes.align = "middle";
             */
            var swfurl = "x51VideoPlayer.swf?v=3_8_8_2016_15_4_final_3";
            if (MGC.checkIsIEloadSwfFailed()) {
                swfurl += "&r=" + Math.random();
            }
            swfobject.embedSWF(swfurl, "LiveVideoSwfContainer",
                "100%", "100%", "11.1.0", '', flashvars, params, attributes);
        },

        // 开始直播
        /*LiveVideoStart: function(LiveUrl) {
            var swfobj = getSWF('LiveVideoSwfContainer');
            var LiveUrl = "{\"cdnUrls\": [\"http://125.39.127.145:1863/6060491.flv?apptype=live&xHttpTrunk=1&buname=x5h3d_platform&uin=2110989563\"]}";
            if (LiveUrl.length == 0)
                alert("数据错误");
            else
                swfobj.start(LiveUrl);
        },*/
        //格式化时间 00:00
        DateToUnix: function(string) {
            var datetime = new Date();
            datetime.setTime(string);
            var hour = datetime.getHours() < 10 ? "0" + datetime.getHours() : datetime.getHours();
            var minute = datetime.getMinutes() < 10 ? "0" + datetime.getMinutes() : datetime.getMinutes();
            return hour + ":" + minute;
        },
        // 初始化送礼swf
        GiftSwfInit: function() {
            var swfVersionStr = "11.1.0";
            var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
            var flashvars = {};
            flashvars.isCaveolae = isCaveolae;
            if(typeof(SKIN) != "undefined")
            {
                flashvars.skinId = SKIN.id;
                flashvars.skinLevel = SKIN.level;
            }
            //区分出新老版本消息发送
            if ((filename == "group.shtml" || filename == "showroom.shtml" || filename == "liveroom.shtml" || filename == "caveolaeroom.shtml" || filename == "nest.shtml")) {
                flashvars.isOldFrame = "true";
            }
            var params = {};
            params.quality = "high";
            params.bgcolor = "#000";
            params.allowscriptaccess = "always";
            params.allowfullscreen = "true";
            params.allowFullScreenInteractive = "true";
            params.wmode = "transparent";
            var attributes = {};

            attributes.id = "GiftSwf";
            attributes.name = "GiftSwf";
            attributes.align = "middle";
            var swfurl = "http://ossweb-img.qq.com/images/mgc/css_img/swf/x51VideoGift.swf?v=3_8_8_2016_15_4_final_3";
            if (MGC.checkIsIEloadSwfFailed()) {
                swfurl += "&r=" + Math.random();
            }
            swfobject.embedSWF(swfurl, "GiftSwfContainer", "100%", "100%",
                swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
        },

        //是否正在播放入场动画
        isPlayEnterRoonmEffect: false,
        //入场特效队列
        enterRoomEffect: [],

        // 增加入场特效
        addEnterRoomEffect: function(obj) {
            MGC_Comm.enterRoomEffect.push(obj);
            if (!MGC_Comm.isPlayEnterRoonmEffect) {
                MGC_Comm.playEnterRoomEffect();
            }
        },

        // 播放入场特效
        playEnterRoomEffect: function() {
            if (MGC_Comm.enterRoomEffect.length == 0 || MGC_Comm.isPlayEnterRoonmEffect) return;

            MGC_Comm.isPlayEnterRoonmEffect = true;
            var obj = MGC_Comm.enterRoomEffect.shift();

            //高级守护入场效果
            if (obj.guard_level > 300) {
                MGC_Comm.showGuardFlash(obj.player_name, obj.player_zone, obj.vip_level, obj.guard_level);
                obj = null;
                return;
            }

            if (obj.vip_level >= 3) {
                MGC_Comm.nobleSwfInit(obj);
            }
            obj = null;
        },

        // 初始化送礼swf
        nobleSwfInit: function(obj) {

            //if(MGC_Comm.nobleSwfArray.length <= 0)
            //    return;
            //
            //var obj = MGC_Comm.nobleSwfArray[0];
            var vipLevel = obj.vip_level;
            var userName = obj.player_name;
            var userZone = obj.player_zone;
            //MGC_Comm.nobleSwfArray.splice(0,1);
            MGC_Comm.isPlayNobleSwf = true;
            var swfVersionStr = "11.1.0";
            var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
            var flashvars = {};
            flashvars.guardIcon = "http://ossweb-img.qq.com/images/mgc/css_img/flash/icon/identity_vip_lv" + vipLevel + ".png?v=3_8_8_2016_15_4_final_3";
            //防止&不能传入flash
            userName = userName.replace(/&/g,"＆");
            flashvars.userName = userName;
            if (userZone != "梦工厂") {
                flashvars.userZone = "[炫舞-" + userZone + "]";
            }
            else {
                flashvars.userZone = "[" + userZone + "]";
            }

            flashvars.isCaveolae = isCaveolae;
            var params = {};
            params.quality = "high";
            params.bgcolor = "#000";
            params.allowscriptaccess = "always";
            params.allowfullscreen = "true";
            params.allowFullScreenInteractive = "true";
            params.wmode = "transparent";
            var attributes = {};
            attributes.id = "nobleSwf";
            attributes.name = "nobleSwf";
            attributes.align = "middle";

            var swfurl = "http://ossweb-img.qq.com/images/mgc/css_img/swf/" + "noble_" + vipLevel + ".swf?v=3_8_8_2016_15_4_final_3_" + (new Date()).getTime();

            if (MGC.checkIsIEloadSwfFailed())
                swfurl += "&r=" + new Date();
            swfobject.embedSWF(swfurl, "nobleContent", "100%", "100%",
                swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
            //$('.nobleAnimation').show();
            window.mgc.popmanager.layerControlShow($('.nobleAnimation'), 2, 2, null, { saveFocus: true });
            obj = null;
        },

        // 高级守护入场动画
        showGuardFlash: function(userName, userZone, vipLevel, guardlevel) {
            var swfVersionStr = "11.1.0";
            var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
            var flashvars = {};
            flashvars.vipIcon = "/assets/icon/identity_vip_lv" + vipLevel + ".png?v=3_8_8_2016_15_4_final_3";
            flashvars.guardIcon = "/assets/icon/identity_guard_lv" + guardlevel + ".png?v=3_8_8_2016_15_4_final_3";
            //防止&不能传入flash
            userName = userName.replace(/&/g,"＆");
            flashvars.userName = userName;
            flashvars.userZone = "[" + $.mZone(userZone) + "]";
            flashvars.isCaveolae = isCaveolae;
            var params = {};
            params.quality = "high";
            params.bgcolor = "#000";
            params.allowscriptaccess = "always";
            params.allowfullscreen = "true";
            params.allowFullScreenInteractive = "true";
            params.wmode = "transparent";
            var attributes = {};
            attributes.id = "nobleSwf";
            attributes.name = "nobleSwf";
            attributes.align = "middle";

            var swfurl = "/assets/" + "guard_" + guardlevel + ".swf?v=3_8_8_2016_15_4_final_3_" + (new Date()).getTime();

            if (MGC.checkIsIEloadSwfFailed())
                swfurl += "&r=" + new Date();
            swfobject.embedSWF(swfurl, "nobleContent", "100%", "100%",
                swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
            //$('.nobleAnimation').show();
            window.mgc.popmanager.layerControlShow($('.nobleAnimation'), 2, 2, null, { saveFocus: true });
        },

        hideNobleSwf: function() {
            window.mgc.popmanager.layerControlHide($('.nobleAnimation'), 2, 2);
            $('.nobleAnimation').remove();
            $('.content').append("<div  class='nobleAnimation'>");
            $('.nobleAnimation').hide();
            $('.nobleAnimation').append("<p id='nobleContent'/>");
            MGC_Comm.isPlayEnterRoonmEffect = false;

            setTimeout('MGC_Comm.playEnterRoomEffect()',500);
            //MGC_Comm.playEnterRoomEffect();

            MGC_Comm.resizeGuardFlash();
        },

        //守护入场动画适配
        resizeGuardFlash:function(){
            var h = $(".layer-video").height() - 348;
            $('.nobleAnimation').css("top",50 + h);
            //console.log("@@@@@@@@@@@@layer-video@@@@@@@@@@@@@:height:   " + $(".layer-video").height());
        },
        initSkinGrabFlash: function (index) {
            var swfVersionStr = "11.1.0";
            var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
            var flashvars = {};
            //flashvars.positionNum = positionNum;
            var params = {};
            params.quality = "high";
            params.bgcolor = "#000";
            params.allowscriptaccess = "always";
            params.allowfullscreen = "true";
            params.allowFullScreenInteractive = "true";
            params.wmode = "transparent";
            var attributes = {};
            attributes.id = "gif_skinGrab" + index;
            attributes.name = "gif_skinGrab" + index;
            attributes.align = "middle";

            var swfurl = "";
            swfurl = "/assets/" + "gif_skinGrab.swf?v=3_7_4_2015_34_3_" + (new Date()).getTime();

            if (MGC.checkIsIEloadSwfFailed())
                swfurl += "&r=" + new Date();
            swfobject.embedSWF(swfurl, "grabEffects_con" + index, "100%", "100%", swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
        },
        initGrabFlash: function () {
            var swfVersionStr = "11.1.0";
            var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
            var flashvars = {};
            //flashvars.positionNum = positionNum;
            var params = {};
            params.quality = "high";
            params.bgcolor = "#000";
            params.allowscriptaccess = "always";
            params.allowfullscreen = "true";
            params.allowFullScreenInteractive = "true";
            params.wmode = "transparent";
            var attributes = {};
            attributes.id = "GrabBlockAnimation";
            attributes.name = "GrabBlockAnimation";
            attributes.align = "middle";

            var swfurl = "";
            swfurl = "/assets/" + "GrabBlockAnimationPane.swf?v=3_8_8_2016_15_4_final_3_" + (new Date()).getTime();

            if (MGC.checkIsIEloadSwfFailed())
                swfurl += "&r=" + new Date();
            swfobject.embedSWF(swfurl, "vipGrabContent", "100%", "100%",swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
        },
        // VIP抢座-宝座闪烁-流星-热度宝箱-飞屏-特效动画
        showGrabFlash: function(positionNum) {
            if ($(".side-left").attr("side_state") == 0) {
                //左侧隐藏状态下不播放动画
                return;
            }
            var swfobj = getSWF('GrabBlockAnimation');
            swfobj.showGrabAni(positionNum);
            $('.vipGrabFlash').css('width', '260px');
            $('.vipGrabFlash').css('height', '356px');
            if (mgc.tools.is_nest_room()) {
                $('.vipGrabFlash').css('top', '16px');
            }
            swfobj = null;
            // window.mgc.popmanager.layerControlShow($('.vipGrabFlash'), 2, 1, null, { saveFocus: true });
        },

        // 隐藏VIP抢座-宝座闪烁-流星-热度宝箱-飞屏-特效动画
        hideGrabBlockAnimation: function () {   
            
            $('.vipGrabFlash').css('width', '1px');
            //房间热度条闪烁效果
            Hotbar.showHotBarEffect();        
        },
        skinShowFlashEffects: function () {
            if (SKIN.id == 1) {
                if ($('.auto_seatVip').width() > 700) {
                    $('.grabEffectsBox').css('top', '-190px');
                } else {
                    $('.grabEffectsBox').css('top', '-107px');
                }
            } else if (SKIN.id == 2) {
                if ($('.auto_seatVip').width() > 700) {
                    $('.grabEffectsBox').css('top', '-195px');
                } else {
                    $('.grabEffectsBox').css('top', '-103px');
                }
            } else if (SKIN.id == 3) {
                if (SKIN.level >= 7) {
                    if ($('.auto_seatVip').width() > 708) {
                        $('.grabEffectsBox').css('top', '-199px');
                    } else {
                        $('.grabEffectsBox').css('top', '-107px');
                    }
                } else {
                    if ($('.auto_seatVip').width() > 708) {
                        $('.grabEffectsBox').css('top', '-159px');
                    } else {
                        $('.grabEffectsBox').css('top', '-107px');
                    }
                }
            }
        },
        // 换肤抢座-----------VIP抢座-宝座闪烁-流星-热度宝箱-飞屏-特效动画
        showSkinGrabFlash: function (positionNum) {
            clearTimeout(Hotbar.timeid);
            MGC_Comm.skinShowFlashEffects();
            var swfobj = getSWF("gif_skinGrab" + positionNum);
            swfobj.showGrabAni(positionNum);
            swfobj = null;
        },    
        // 换肤抢座-----------隐藏VIP抢座-宝座闪烁-流星-热度宝箱-飞屏-特效动画
        hideSkinGrabBlockAnimation: function () {         
            //房间热度条闪烁效果
            Hotbar.showHotBarEffect();
            //房间热度条闪烁效果   
        },    
        moveGrabFlash: function () {
            // return;
            //$('.grabEffectsBox').css('display', 'none');
            if ((SKIN.id == 3 && $('.auto_seatVip').width() > 708) || (SKIN.id != 3 && $('.auto_seatVip').width() > 700)) {
                $('.grabEffectsBox').css('top', '-90px');
            } else {
                $('.grabEffectsBox').css('top', '-5px');
            }
            //$('.grabEffectsBox').css('display', 'block');
        },
        //缩回去的抢座
        //初始化缩回去抢座特效
        initSkinShrinkGrabFlash: function () {
            var swfVersionStr = "11.1.0";
            var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
            var flashvars = {};
            //flashvars.positionNum = positionNum;
            var params = {};
            params.quality = "high";
            params.bgcolor = "#000";
            params.allowscriptaccess = "always";
            params.allowfullscreen = "true";
            params.allowFullScreenInteractive = "true";
            params.wmode = "transparent";
            var attributes = {};
            attributes.id = "shrinkGrabSeat";
            attributes.name = "shrinkGrabSeat";
            attributes.align = "middle";

            var swfurl = "";
            swfurl = "/assets/" + "shrinkGrabSeat.swf?v=3_7_4_2015_34_3_" + (new Date()).getTime();

            if (MGC.checkIsIEloadSwfFailed())
                swfurl += "&r=" + new Date();
            swfobject.embedSWF(swfurl, "shrinkGrabSeat", "100%", "100%", swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
        },
        // 缩回去-显示-换肤抢座-----------VIP抢座-宝座闪烁-流星-热度宝箱-飞屏-特效动画
        showSkinShrinkTimer:null,
        showSkinShrinkGrabSeat: function () {
            if ($('.auto_seatVip').width() == 321) {
                if (SKIN.id != 3) {
                    $('.shrinkGrabSeat').css('margin-top', '-109px');
                } else {
                    $('.shrinkGrabSeat').css('margin-top', '-123px');
                }
            }
            $('.shrinkGrabSeat').css('display', 'block');
            clearTimeout(MGC_Comm.showSkinShrinkTimer);
            MGC_Comm.showSkinShrinkTimer=setTimeout(MGC_Comm.hideSkinShrinkGrabSeat, 1000);

        },

        // 缩回去-隐藏-换肤抢座-----------隐藏VIP抢座-宝座闪烁-流星-热度宝箱-飞屏-特效动画
        hideSkinShrinkGrabSeat: function () {

            //房间热度条闪烁效果
            $('.shrinkGrabSeat').css('display', 'none');     
            //房间热度条闪烁效果
            Hotbar.showHotBarEffect();
            //房间热度条闪烁效果
            // $('.grabEffectsBox').css('width', '1px');
            // $('.auto_seatVip .sv_list .grabEffectsBox li .grabEffects,.auto_seatVip .sv_list .grabEffectsBox li').css('width', '1px');
        },

        // 全屏礼物效果播放完毕
        fullGiftEffectPlayOver: function() {
            //console.log('EffectOver  ---  fullGiftEffectPlayOver');
            var swfobj = getSWF('GiftSwf');
            try {
                swfobj.fullGiftEffectPlayOver();
            } catch (e) {
                console.log(e.message);
            }
            swfobj = null;
        },

        // 显示礼物效果
        showGiftEffect: function(data) {
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
            attributes.id = "gifteffectswf";
            attributes.name = "gifteffectswf";
            attributes.align = "middle";

            var swfurl;

            if (MgcAPI.SNSBrowser.IsQQGame() || MgcAPI.SNSBrowser.IsX52())
            {
                swfurl = data.path + "?v=3_8_8_2016_15_4_final_3";
            }
            else
            {
                swfurl = data.path + "?v=3_7_4_2015_34_3_" + (new Date()).getTime();
            }

            if (MGC.checkIsIEloadSwfFailed())
                swfurl += "&r=" + new Date();
            swfobject.embedSWF(swfurl, "gifteffectContent", "100%", "100%",
                swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
            //$('.gifteffectflash').show();

            /*
            if(filename == "showroom.shtml")
            {
                $('.gifteffectflash').css("top", $("#LiveVideoSwfContainer").offset().top + 80);
            }
            else
            {
                $('.gifteffectflash').css("top", $("#LiveVideoSwfContainer").offset().top);
            }


            $('.gifteffectflash').css("left", $("#LiveVideoSwfContainer").offset().left);
             */
            
            window.mgc.popmanager.layerControlShow($('.gifteffectflash'), 2, 2, null, { saveFocus: true });
        },
        // 隐藏礼物效果
        hideGiftEffect: function() {
            $('.gifteffectflash').remove();

            //区分演唱会和直播间标签
            if (MGCData.isConcert) {
                $('.video_flash').append('<div class="gifteffectflash" style="display: none"></div>');
            }
            else {
                $('.video_flash').append('<div class="gifteffectflash" style="display: none"></div>');
            }

            $('.gifteffectflash').append("<p id='gifteffectContent'></p>");

            MGC_Comm.resizeGiftEffect();
        },

        //恶魔动画适配
        resizeGiftEffect: function(){

            $('.gifteffectflash').css("top", $(".video_flash").height() - $('.gifteffectflash').height());
            //$('.gifteffectflash').css("left", $("#LiveVideoSwfContainer").offset().left);
        },

        //是否正在播放主播经验动画
        isPlayExpEffect: false,
        //主播经验特效队列
        expEffect: [],

        // 增加主播经验特效
        addExpEffect: function(exp) {
            if(!mgc.tools.is_show_room())return;
            MGC_Comm.expEffect.push(exp);
            if (!MGC_Comm.isPlayExpEffect) {
                MGC_Comm.playExpEffect();
            }
        },

        // 播放主播经验特效
        playExpEffect: function() {
            if (MGC_Comm.expEffect.length == 0 || MGC_Comm.isPlayExpEffect) return;

            MGC_Comm.isPlayExpEffect = true;
            var exp = MGC_Comm.expEffect.shift();

            MGC_Comm.showExpEffect(exp);
        },

        // 显示主播经验效果
        showExpEffect: function(exp) {
            var swfVersionStr = "11.1.0";
            var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
            var flashvars = {};
            flashvars.exp = exp;
            var params = {};
            params.quality = "high";
            params.bgcolor = "#000";
            params.allowscriptaccess = "always";
            params.allowfullscreen = "true";
            params.allowFullScreenInteractive = "true";
            params.wmode = "transparent";
            var attributes = {};
            attributes.id = "expeffectswf";
            attributes.name = "expeffectswf";
            attributes.align = "middle";

            var swfurl = "http://ossweb-img.qq.com/images/mgc/css_img/video_room/exp_effect.swf?v=3_8_8_2016_15_4_final_3_";

            if (MGC.checkIsIEloadSwfFailed())
                swfurl += "&r=" + new Date();
            swfobject.embedSWF(swfurl, "expeffectContent", "100%", "100%",
                swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
            $('.expeffectflash').show();
        },
        // 隐藏主播经验效果
        hideExpEffect: function() {
            $('.expeffectflash').remove();
            $('.sl_info').append('<div class="expeffectflash" style="display: none"></div>');
            $('.expeffectflash').append("<p id='expeffectContent'></p>");

            MGC_Comm.isPlayExpEffect = false;
            MGC_Comm.playExpEffect();
        },

        // 初始化上传头像swf
        AvatarSwfInit: function() {
            var swfUrl = "upimage.swf?v=3_8_8_2016_15_4_final_3";
            var swfVersionStr = "11.1.0";
            var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
            var flashvars = {};
            var params = {};
            params.quality = "high";
            params.bgcolor = "#000";
            params.allowscriptaccess = "always";
            params.allowfullscreen = "true";
            params.allowFullScreenInteractive = "true";
            params.wmode = "opaque";
            var attributes = {};

            attributes.id = "AvatarSwf";
            attributes.name = "AvatarSwf";
            attributes.align = "middle";
            if (MGC.checkIsIEloadSwfFailed())
                swfUrl += "&r=" + new Date();
            swfobject.embedSWF(swfUrl, "AvatarFlashContent", "100%", "100%",
                swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
        },

        Dologout: function(type, i) {
            try {
                EAS.SendClick({ 'e_c': 'mgc.logout', 'c_t': 4 });
            } catch (e) {

            }
            if (i == 1) {
                showDialog.hide();
            }
            if(type==0){            
                $.cookie("mgc_login_succeed_uin", null, {
                    path: '/',
                    domain: '.qq.com'
                });
                $("#reminder").fadeOut();
                MGC_Comm.logFirstTrue = false;
                
            }

            MGC_Comm.commonGetUin(function (_uin) {
                $.cookie("mgc_login", null, { path: '/', domain: 'mgc.qq.com' });
                $.cookie("IED_LOG_INFO2", null, { path: '/', domain: '.qq.com' });
                $('.nd').hide();
                $.cookie("mgc_logingifts_" + _uin + "_" + $.cookie("mgcZoneId"), null, {
                    path: '/',
                    domain: '.qq.com'
                });

                if (type !== 999 && (filename == "liveroom.shtml" || filename == "showroom.shtml" || filename == "caveolaeroom.shtml" || filename == "nest.shtml")) {
                    var NoteObj = {
                        "Note": "退出登录后会退出当前视频房间并且回到首页，您确认要更换登录状态吗？",
                        "BtnNum": 2
                    };
                    MGC_Comm.CommonDialog(NoteObj, function() {
                        MGC_Comm.commonLogout(function() {
                            //请求退出操作
                            MGC_Comm.afterLogout(1);
                        });
                    });
                } else if (filename == "act.shtml" || filename == "personal.shtml" || filename == "group.shtml") {
                    //无论是否是因为权限退登的，都会回到首页
                    MGC_Comm.commonLogout(function() {
                        //请求退出操作
                        MGC_Comm.afterLogout(1);
                    });
                } else if (filename == "ticket.shtml") {//这里是不需要回到首页的
                    MGC_Comm.commonLogout(function() {
                        //请求退出操作
                        var _reqStr = "{\"op_type\":171}";
                        MGC_Comm.sendMsg(_reqStr);
                        MGC_Comm.DoClear();
                    });
                } else {
                    MGC_Comm.commonLogout(function() {
                        MGC_Comm.afterLogout(0);
                    });
                };
            });
        },

        DoClear: function() {
            var _reqStr = "{\"op_type\":179}";
            MGC_Comm.sendMsg(_reqStr);
        },

        log: function(str, obj) {
            /*console.log(str);
            console.log(obj);*/
        },

        LoginHb: function(LoginHbKey) {
            var _url = "http://apps.game.qq.com/mgc/index.php?m=LoginHb&LoginHbKey=" + LoginHbKey + "&t=" + Math.random();
            MGC_Comm.ajax(_url, function(data) {
                //MGC_Comm.log("续期返回", data.data);
                if (data.ret_code == 0) {
                    var _data = data.data;
                    $.cookie("mgc_login", _data.mgc_login, {
                        expires: 60,
                        path: '/',
                        domain: 'mgc.qq.com'
                    });
                };
            });
        },

        HideAndClear: function(obj) {
            var pop = $(obj).parents('.pop');
            if (pop.has('ul').length > 0) {
                pop.find('ul').hide();
            }
            if (pop.has('textarea').length > 0) {
                pop.find('textarea').val('');
            }
            showDialog.hide();
        },

        //中英文字符串长度
        Strlen: function(str,limit) {
            var len = 0;
            MGC_Comm.strEndIndex = 0;
            for (var i = 0; i < str.length; i++) {
                var c = str.charCodeAt(i);
                //单字节加1 
                if ((c >= 0x0001 && c <= 0x007e) || (0xff60 <= c && c <= 0xff9f)) {
                    len++;
                } else {
                    len += 2;
                }

                if(limit && len <= limit)
                {
                    MGC_Comm.strEndIndex++;
                }
            }
            return len;
        },

        Strcut: function(str, len) {
            var str_length = 0;
            var str_len = 0;
            str_cut = new String();
            str_len = str.length;
            for (var i = 0; i < str_len; i++) {
                a = str.charAt(i);
                str_length++;
                if (escape(a).length > 4) {
                    //中文字符的长度经编码之后大于4  
                    str_length++;
                }
                if (str_length > len) {
                    return str_cut;
                }
                else if (str_length == len) {
                    str_cut = str_cut.concat(a);
                    return str_cut;
                }
                str_cut = str_cut.concat(a);
            }
            //如果给定字符串小于指定长度，则返回源字符串；  
            if (str_length < len) {
                return str;
            }
        },

        backupInvitationBoxPopUp: function(DialogObj) {
            var isNotOnlyOpen = false;
            if (!arguments[3]) {
                isNotOnlyOpen = true;
            }

            $('#backupInvitationTitleP').html("后援团邀请");
            $('#backupInvitationNoteP').html(DialogObj.player_name +  "邀请您加入" + DialogObj.vgname + "，是否接受并加入后援团？");

            $('#seeSupportGroup').unbind('click').click(function() {
                MGC_CommRequest.getbackupGroupCard(DialogObj.vgid);
            });

            $('#backupInvitationConfirmBtn').unbind('click').click(function() {
                MGC_Comm.refuseIinvite(DialogObj.vgid, 1);
            });
            $('#backupInvitationCancelBtn').unbind('click').click(function() {
                MGC_Comm.refuseIinvite(DialogObj.vgid, 2);
            });
            $('#backupInvitationCloseBtn').unbind('click').click(function() {
                MGC_Comm.refuseIinvite(DialogObj.vgid, 0);
            });

            //if (isNotOnlyOpen)
            //    $("#backupInvitation").css("z-index", 9998).show();
            if (isNotOnlyOpen)
            {
                //   设定一个cookie到主播名片判断是否有打开
                $.cookie("mgc_invite_click",1 , {
                    path: '/',
                    domain: '.qq.com'
                });
                $('#backupInvitation').centerDisp();
                window.mgc.popmanager.layerControlShow($('#backupInvitation'), 4, 1, 2);
            }
            MGC_Comm.countdownId = setInterval(MGC_Comm.invitationCountdown, 1000);
        },
        refuseIinvite: function(vgid, is_agree) {
            var _reqStr = { "op_type": 74, "is_agree": is_agree, "vgid": vgid };
            $.cookie("mgc_invite_click", null, {
                path: '/',
                domain: '.qq.com'
            });
            MGC_Comm.sendMsg(_reqStr);
            MGC_Comm.clearInvitationPopUp();
        },
        backupInvitationCallBack: function(obj) {
            var objLabel = {};
            objLabel.Title = "提示";

            if (obj.accept) {
                objLabel.Note = "邀请成功，" + obj.player_name + "已加入您的后援团~";
                MGC_Comm.CommonDialog(objLabel);
            }
            else {
                objLabel.Note = obj.player_name + "拒绝了您的邀请。";
                MGC_Comm.CommonDialog(objLabel);
            }
        },

        clearInvitationPopUp: function() {
            MGC_Comm.countdownNum = 120;
            //$("#backupInvitation").hide();
            //$("#overlay_CommonDialog_backupInvitation").hide();
            window.mgc.popmanager.layerControlHide($('#backupInvitation'), 4, 1);
            clearInterval(MGC_Comm.countdownId);
        },

        /*
            邀请倒计时
         */
        invitationCountdown: function() {
            MGC_Comm.countdownNum--;
            if (MGC_Comm.countdownNum == 0) {
                MGC_Comm.clearInvitationPopUp();
                return;
            }
            $('#countdown').html("倒计时：" + MGC_Comm.countdownNum + "秒");
        },

        /*
         * 通用提示框，后续所有报错均调用次接口
         * DialogObj {
         *     Title:提示框标题,
         *     Note:提示框提示语,
         *     Type:提示框类型, 1：AS调用 2：主动PUSH 3：页面调用
         *     BtnName:提示框第一个按钮名称,
         *     BtnNum:提示框按钮个数, >1 会显示取消按钮
         * }
         * 
         * _callback：回调函数 string or function(){}
         
        */
        CommonDialog: function(DialogObj, _callback, _callback2, isNotOnlyOpen, isCloseAll) {
            //use the new code
            mgc.tools.commonDialog(DialogObj, _callback, _callback2, isNotOnlyOpen, isCloseAll);
            return;
            $('#ConfirmBtn,#CancelBtn,#CloseBtn').off("click");
            if (!arguments[3]) {
                isNotOnlyOpen = true;
            }
            if (!arguments[4]) {
                isCloseAll = false;
            }
            if (DialogObj.Title) {
                $('#TitleP').html(DialogObj.Title);
            };
            if (DialogObj.Note) {
                $('#NoteP').html(DialogObj.Note);
            };

            $('#CancelBtn').html("取消").hide();

            if (DialogObj.BtnName) {
                $('#ConfirmBtn').html(DialogObj.BtnName);
            } else {
                $('#ConfirmBtn').html("确定");
            };
            if (isNotOnlyOpen) {
                $('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(" + isCloseAll + ");");
                $('#CloseBtn').attr("href", "javascript:MGC_Comm.hideDialog(" + isCloseAll + ");");
                $('#CancelBtn').attr("href", "javascript:MGC_Comm.hideDialog(" + isCloseAll + ");");
            } else {
                $('#ConfirmBtn').attr("href", "javascript:showDialog.hide();");
                $('#CloseBtn').attr("href", "javascript:showDialog.hide();");
                $('#CancelBtn').attr("href", "javascript:showDialog.hide();");
            }
            if (typeof _callback == "function") {            
                $('#ConfirmBtn').one("click", function(){
                    _callback();    
                });
            }

            if (typeof _callback == "string") {
                $('#ConfirmBtn').attr("href", "javascript:" + _callback + "();");
            };

            if (DialogObj.url != undefined && DialogObj.url != "") {
                $('#ConfirmBtn').attr("href", DialogObj.url);
                $('#ConfirmBtn').attr("target", "_blank");
            };
            //$('#CloseBtn').attr("href", "javascript:showDialog.hide();");
            if (DialogObj.BtnNum > 1) {
                if (DialogObj.BtnName2) {
                    $('#CancelBtn').html(DialogObj.BtnName2);
                };
                $('#CancelBtn').show();
                //避免弹窗中取消按钮显示错误
                $("#CancelBtn").css("display", "inline-block");
                if (typeof _callback2 == "function") {
                    $('#CancelBtn,#CloseBtn').one("click", function(){
                        _callback2();    
                    });
                };

                if (typeof _callback2 == "string") {
                    $('#CancelBtn').attr("href", "javascript:" + _callback2 + "();");
                    $('#CloseBtn').attr("href", "javascript:" + _callback2 + "();");
                };
            } else {
                $('#CancelBtn').hide();

                if (typeof _callback == "function") {
                    $('#CloseBtn').one("click", function(){
                        _callback();    
                    });
                };

                if (typeof _callback == "string") {
                    $('#CloseBtn').attr("href", "javascript:" + _callback + "();");
                };
            };

            /*输入框光标移出*/
            $('#SendMsgChatBox').blur();
            window.mgc.popmanager.layerControlShow($("#CommonDialog"), 5, 1, 1);

            DialogObj = null;
        },
        hideDialog: function(isCloseAll) {
            //use the new code
            mgc.tools.hideDialog(isCloseAll);
            return;
            if (isCloseAll)
                showDialog.hide();
            $('#ConfirmBtn,#CancelBtn,#CloseBtn').off("click");
            window.mgc.popmanager.layerControlHide($("#CommonDialog"), 5, 1);
        },

        ChangeClass: function(Id, className) {
            if (typeof (Id) == "string") {
                $('#' + Id).toggleClass(className);
            } else {
                $(Id).toggleClass(className);
            };

        },

        ChangeLogin: function(resp) {
            console.log("检测到您的登录状态异常，请重新登录   old :" + JSON.stringify(resp));
            var NoteObj = {};
            if (resp.res == 1) {
                NoteObj.Note = "哎呀，程序哥哥发呆了，快去刷新重试吧";
            } else if (resp.res == 2) {
                NoteObj.Note = "您的登录状态发生了异常，需要重新登录哦";
            } else if (resp.res == 3) {
                NoteObj.Note = "世界那么大，程序哥哥出门散步了~亲！需要刷新重试哦";
            } else {
                NoteObj.Note = "检测到您的登录状态异常，请重新登录";
            }
            if ((MgcAPI.SNSBrowser.IsQQGameLiveArea() == 'true') && (resp.res != 1) && (resp.res != 3)) {
                //检测登录异常时，清除缓存
                mgc.account.hasSkey = false;
                mgc.account.logout();
                mgc.account.clear_cookie();
                mgc.comm_model.getLoginBarModel.toggle(false);
                mgc.callcenter.query_clear_login_cookie(function() {
                    console.log("cookie cleared!");
                    var myTime = new Date();
                    var filename = window.location.href;
                    mgc.tools.cookie("mgc_logError_qqaccount_checkLoginCallback", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___Test-the-login-state-expired___web--qqaccount_checkLoginCallback-islogin-false___filename" + filename, {
                        path: '/',
                        domain: '.qq.com'
                    });
                });
                MGC_Comm.CommonDialog(NoteObj, function() {
                    $("#login-bar-btn").click();
                });
            } else {
                MGC_Comm.CommonDialog(NoteObj, function() {
                    /*window.location.href = home + "?isLogin=1";*/
                    window.location.href = window.mgc.tools.changeUrlToLivearea(home);
                });
            }
        },

        getRemainDate: function(remainTime) {
            if (remainTime <= 0) return false;
            var _myVipDuration;
            _myVipDuration = Math.ceil(remainTime / 86400);
            _myVipDuration = _myVipDuration + '天';
            return _myVipDuration;
        },

        // 加载飞屏swf
        setFlyScreenSwfObj: function() {
            var swfVersionStr = "11.1.0";
            var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
            var flashvars = {};
            flashvars.isConcert = MGCData.isConcert;
            var params = {};
            params.quality = "high";
            params.bgcolor = "#000";
            params.allowscriptaccess = "always";
            params.allowfullscreen = "true";
            params.allowFullScreenInteractive = "true";
            params.wmode = "transparent";
            // params.wmode = "gpu";
            var attributes = {};

            attributes.id = "FlyMessageModule";
            attributes.name = "FlyMessageModule";
            attributes.align = "middle";
            var swfurl = "/assets/FlyMessageModule.swf?v=3_8_8_2016_15_4_final_3";

            if (MGC.browser().ie7 || MGC.browser().qqbrowser) {
                swfurl += "&r=" + Math.random();
            }
            //FlyScreenSwfContainer 页面上有对应的div
            swfobject.embedSWF(swfurl, "flyScreenContent", "100%", "100%",
                swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
            MGC_Comm.isFlyLayerOpened = false;
        },
        isFlyLayerOpened:false,
        // 重置飞屏组件大小
        showFlyScreenSwf: function () {
            if (MGC_Comm.isFlyLayerOpened) {
                var $flyScreenContent = $('.flyScreen');

                $flyScreenContent.css('width','100%');
                $flyScreenContent.css('pointer-events', 'none');
                if (MGCData.isConcert) {
                    $flyScreenContent.height(250);
                } else {
                    $flyScreenContent.height(250);
                }
                $flyScreenContent.show();
                //window.mgc.popmanager.layerControlShow($flyScreenContent, 2, 3);
            }
        },
        // 添加一个开通贵族的飞屏
        addOpenVIPFlyScreenMsg: function (resp, params) {
            //player_name, vip_level, wealth_level, anchor_name
            var data = {};
            data.senderName = resp.player_name;
            data.senderdefend = 0;
            data.viplevel = resp.vip_level;
            data.wealth_level = resp.weath_level;
            data.isTakeVip = false;
            data.isSelf = 0;
            if (resp.vip_level > 3) {
                data.MsgStr = "立刻变身【"+window.mgc.consts.vipLevelTab[resp.vip_level]+"】独宠【"+ resp.anchor_name +"】，后宫三千佳丽，请默默哭泣~";
            } else {
                data.MsgStr = "立刻变身【"+window.mgc.consts.vipLevelTab[resp.vip_level]+"】宠幸了【"+ resp.anchor_name +"】";
            }
            data.chatnodes = [];
            data.chatnodes[0] = {"content": data.MsgStr, "nodeType": 0};
            data.src = 1;
            MGC_Comm.addFlyScreenMsg(data, false);
            resp = null;
            data = null;
        },
        //添加飞屏
        addFlyScreenMsg: function (data, isDef) {
            //width:100%; height:630px;
            var swfobj = getSWF('FlyMessageModule');
            
            if (MGC_Comm.isFlyLayerOpened == false) {
                MGC_Comm.isFlyLayerOpened = true;
                MGC_Comm.showFlyScreenSwf();
                swfobj.openModule(MGCData.isConcert);
            }
            data.MsgStr = data.MsgStr.replace(/&lt/g, "<");
            data.MsgStr = data.MsgStr.replace(/&gt/g, ">");
            data.MsgStr = data.MsgStr.replace(/&nbsp/g, " ");
            swfobj.addFlyScreenMsg(data, isDef);
            data = null;
            swfobj = null;
        },
        //添加火箭飞屏
        addRocketScreenMsg: function (data) {
            if (MGC_Comm.isFlyLayerOpened == false) {
                MGC_Comm.isFlyLayerOpened = true;
                MGC_Comm.showFlyScreenSwf();
            }
            var $flyScreenContent = $('.flyScreen');
            $flyScreenContent.css('pointer-events', '');
            // window.mgc.popmanager.layerControlShow($flyScreenContent, 2, 3);
            var swfobj = getSWF('FlyMessageModule');
            swfobj.addRocketScreenMsg(data);
            data = null;
            $flyScreenContent = null;
            swfobj = null;
        },
        onRocketScreenMsgClick: function (room_id) {
            //是否游客
            if (MGC_Comm.CheckGuestStatus(false)) return;
            
            if(room_id != MGCData.roomID)
            {
                // 新需求所有跳转都在当前页进行。--XW80582
                // location.href = "transfer.shtml?roomId=" + room_id + "&source=8";
                // if(MgcAPI.SNSBrowser.IsQQGame() || MgcAPI.SNSBrowser.IsX52())
                // {
                window.open("transfer.shtml?roomId=" + room_id + "&source=8&param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea(), "_self");
                // }
                // else{
                //     window.open("transfer.shtml?roomId=" + room_id + "&source=8");
                // }
            }
        },
        hideFlyScreenSwf: function () {
            MGC_Comm.isFlyLayerOpened = false;
            var $flyScreenContent = $('.flyScreen');
            $flyScreenContent.width(1);
            $flyScreenContent.height(1);
        },
        closeRocketPolicy: function() {
            var $flyScreenContent = $('.flyScreen');
            $flyScreenContent.css('pointer-events', 'none');
        }
    };

    // 一些公用和需要缓存的数据，统一存储在这里
    var MGCData = {
        // 梦工厂的固定大区ID
        mgcZoneId: 888,

        // 是否正在走注册流程
        isRegister: false,

        // 我的playId
        myPlayerId: 0,

        // 我的vip等级
        myVipLevel: 0,

        // 是否关注0-未关注 1-已关注
        followAnchor: 0,
        // 是房间的还是名片的关注 0 - 房间 1-主播名片
        isAnchorOrRoom: 0,
        difFollowAnchor: [{followAnchor:0},{followAnchor:0}],

        //主播id
        anchorID: 0,

        //演唱会视频质量
        showRoomDefinition: 0,

        //是否隐身 true隐身
        invisible: false,

        //是否演唱会
        isConcert: false,

        //主播等级
        anchor_level: 0,

        //主播等级底板
        anchor_level_bg: 0,

        //主播等级瓶颈标识
        is_bottleneck: false,

        //主播等级当前经验
        anchor_exp: 0,

        //主播等级当前经验需要达到下一经验的经验值
        anchor_levelup_exp: 0,

        //主播瓶颈礼物
        bottleneck_gift_name: 0,

        //主播瓶颈送的礼物数量
        bottleneck_count: 0,

        //主播瓶颈需要送的礼物数量
        bottleneck_need_count: 0,

        //主播瓶颈送的礼物ID
        bottleneck_gift_id: 0,

        //主播经验槽百分比
        anchor_Per: 0,

        //送主播最大值上限梦幻币礼物
        max_anchor_exp: 0,

        //目前总共送主播最大值上限梦幻币礼物
        total_anchor_exp: 0,

        //通过星耀值还可为主播增加的经验值上限
        starlight_rest_exp_today: 0,

        //通过收梦幻币礼物还可为主播增加的主播经验上限
        dream_gift_rest_exp_today: 0,
        
        //通过收抽奖为主播增加的主播经验上限
        lucky_draw_rest_exp_today: 0,

        //主播满级标识
        anchor_level_max: false,

        //主播区域加载标识
        anchor_area: true,

        //礼物数据
        giftData: [],

        //设置礼物数据
        setGiftData: function(data) {
            MGCData.giftData = data;
            MGCData.getFantasyGift(data);
        },
        //梦幻币礼物
        fantasyGiftData: [],
        fantasyGiftData_30: [],
        fantasyGiftData_31: [],
        fantasyGiftData_32: [],
        //设置梦幻币礼物：获取梦幻币礼物给主播的经验值
        getFantasyGift: function(data) {
            $.each(data, function(k, v) {
                if (MGCData.fantasyGiftData.length != 3) {
                    if (v.id == 30) {
                        v.anchorexp;
                        v.name;
                        MGCData.fantasyGiftData_30.push(v.anchorexp);
                        MGCData.fantasyGiftData_30.push(v.name);
                    } else if (v.id == 31) {
                        v.anchorexp;
                        v.name;
                        MGCData.fantasyGiftData_31.push(v.anchorexp);
                        MGCData.fantasyGiftData_31.push(v.name);
                    } else if (v.id == 32) {
                        v.anchorexp;
                        v.name;
                        MGCData.fantasyGiftData_32.push(v.anchorexp);
                        MGCData.fantasyGiftData_32.push(v.name);
                    }

                }
            })

            if (MGCData.fantasyGiftData.length < 3 && MGCData.fantasyGiftData_30.length > 0 && MGCData.fantasyGiftData_31.length > 0 && MGCData.fantasyGiftData_32.length > 0) {

                MGCData.fantasyGiftData.push(MGCData.fantasyGiftData_30);
                MGCData.fantasyGiftData.push(MGCData.fantasyGiftData_31);
                MGCData.fantasyGiftData.push(MGCData.fantasyGiftData_32);
            }
        },
        attention:false,
        //所有房间
        totalRoomList:[],
        //根据id获取礼物数据
        getGiftData:function(id){
            var data;
            for(var i = 0;i<this.giftData.length;i++)
            {
                if(id == this.giftData[i].id)
                {
                    data = this.giftData[i];
                }
            }
            return data;
        }
        
    };
    /**
    *   获得flash对象
    */
    common.getSWF = function(a) {
        if (navigator.appName.indexOf("Microsoft") != -1) {
            return window[a];
        } else {
            if (window.navigator.userAgent.indexOf("Firefox") != -1) {
                return document[a];
            } else {
                if (window.navigator.userAgent.indexOf("Chrome") != -1) {
                    return document[a];
                } else {
                    if (window.navigator.userAgent.indexOf("Safari") != -1) {
                        return document.getElementById(a);
                    } else {
                        if (window.navigator.userAgent.indexOf("Opera") != -1) {
                            return document[a];
                        }
                    }
                }
            }
            return document[a];
        }
    }
    common.mgc_comm = MGC_Comm;
    common.mgcData = MGCData;

    callcenter.addRespListener(callcenter.OP_TYPE.GET_SIGN_INFO, common.SignResp.getSignInfoCallBack);
    callcenter.addRespListener(callcenter.OP_TYPE.GET_DONE_ACT, common.IndexResp.hasActCallBack);
    callcenter.addRespListener(callcenter.OP_TYPE.GET_TASK_CENTER_GUIDE, common.IndexResp.taskCenterGuideCallBack);
    //异常检测
    callcenter.addRespListener(callcenter.OP_TYPE.CHANGE_LOGIN, common.IndexResp.ChangeLoginCallback);
    if (!window.mgc) {
        window.mgc = {};
    }
    window.mgc.common_contral = common;
    return common;
});