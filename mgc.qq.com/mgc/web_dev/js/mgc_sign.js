/*
 * VERSION: 1.0 LAST UPDATE: 15.08.11
 */
var $$ = jQuery.noConflict();
//首登礼包领取request
var MGC_LoginGiftsReq = {
    //*检查是否首登
    checkIsFirstLogin: function () {
        var _reqStr = { "op_type": 189 };
        console.log("首登礼包请求：" + JSON.stringify(_reqStr));
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.checkIsFirstLoginCallBack");
    },
    //*领取首登礼包
    receiveLoginGifts: function () {
        var _reqStr = { "op_type": 190 };
        console.log("领取首登礼包请求：" + JSON.stringify(_reqStr));
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.receiveLoginGiftsCallBack");
    }
}
//首登response
var MGC_LoginGiftsResp = {
    //*检查是否首登-回调
    checkIsFirstLoginCallBack: function (obj) {
        MGC_Comm.commonGetUin(function (_uin) {
            if (!(filename == "" || filename.indexOf("index.shtml") == 0) || $m.cookie("mgc_logingifts_" + _uin + "_" + $m.cookie("mgcZoneId")) == new Date().format("yyyy-MM-dd")) {
                console.log("登录统计");
                return;
            }
            console.log("首登礼包回调：" + JSON.stringify(obj));
            if (!obj.isToken && obj.rewards && obj.rewards.length > 0) {
                //自动弹出首登礼包领取界面 
                $$.each(obj.rewards, function (k, v) {
                    v.num = k + 1;
                    $$COMM.FillRewardInfo(v);
                });
                var logingiftsCon = $m('#logingiftsTmpl');
                var logingiftsTmpl;
                var logingiftsList = $m('#logingiftsList');
                logingiftsList.children().remove();
                logingiftsTmpl = logingiftsCon.tmpl(obj.rewards);
                logingiftsTmpl.appendTo(logingiftsList);
                //绑定tips显示
                if (obj.rewards.length <= 6) {
                    $$("#task_pre,#task_next").hide();
                } else {
                    MGC.flipOver1("#pop_logingifts");
                }
                //绑定领取提交
                $$("#pop_logingifts").find(".submitReceive").unbind("click").bind("click", function () {
                    MGC_CommRequest.receiveLoginGifts();
                });
                //绑定关闭事件
                $$("#pop_logingifts").find(".pop_close").unbind("click").bind("click", function () {
                    showDialog.hide();
                    //关闭首登礼包界面 - 立即判断签到状态
                    MGC_CommRequest.checkSign(true);
                });
                if (obj.hasgame == true) {
                    if(window.mgc.config.channel == 0){
                        $m('#gameTool').text('（获得的游戏道具会直接进入游戏背包）');
                    }else{
                        $m('#gameTool').text('（获得的游戏道具以邮件发放到电脑端）');
                    }
                } else {
                    $$('#hasgame').text('：');
                }
                showDialog.show('pop_logingifts');
                logingiftsTmpl = null;
                logingiftsCon = null;
            } else {
                //非首登状态下 - 立即判断签到状态
                MGC_CommRequest.checkSign(true);
            }
            //每天只弹出一次  记录cookie
            $m.cookie("mgc_logingifts_" + _uin + "_" + $m.cookie("mgcZoneId"), new Date().format("yyyy-MM-dd"), {
                path: '/',
                domain: '.qq.com'
            });
        });
    },
    //*领取首登礼包-回调
    receiveLoginGiftsCallBack: function (obj) {
        console.log("领取首登礼包回调：" + JSON.stringify(obj));
        showDialog.hide();
        var dialog = { "Title": "提示", "Note": "" };
        if (obj.res == 0) {
            //成功操作 关闭首登礼包领取界面
            dialog.Note = "恭喜您，成功领取首登礼包奖励！";
        } else if (obj.res == 1) {
            //失败操作 不关闭首登礼包领取界面
            dialog.Note = "领取首登礼包奖励失败！";
        } else {
            //重复领取
            dialog.Note = "您已经领取过这个奖励了！";
        }
        MGC_Comm.CommonDialog(dialog, function () {
            //领取首登礼包完成后 - 立即判断签到状态
            MGC_CommRequest.checkSign(true);
        });
    }
}
//签到request
var MGC_SignReq = {
    //*检查签到状态 isAuto:是否自动弹出 ; isStop:是否阻止弹出
    checkSign: function (isAuto, isStop) {
        var _reqStr = { "op_type": 191 };
        console.log("签到状态请求：" + JSON.stringify(_reqStr));
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.checkSignCallBack", { "isAuto": isAuto, "isStop": isStop });
    },
    //*获取签到信息
    getSignInfo: function () {
        var _reqStr = { "op_type": 192 };
        console.log("签到信息请求：" + JSON.stringify(_reqStr));
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getSignInfoCallBack");
    },
    //*领取每日签到奖励
    receiveDailyReward: function () {
        var _reqStr = { "op_type": 193 };
        console.log("领取每日签到奖励请求：" + JSON.stringify(_reqStr));
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.receiveDailyRewardCallBack");
    },
    //*领取累计签到奖励 （n:累计天数）
    receiveCumulativeReward: function (n) {
        var _reqStr = { "op_type": 194, "accday": n };
        console.log("领取累计签到奖励请求：" + JSON.stringify(_reqStr));
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.receiveCumulativeRewardCallBack");
    }
}
//签到response
var MGC_SignResp = {
    //*检查签到回调
    checkSignCallBack: function (obj, param) {
        console.log("签到状态回调：" + JSON.stringify(obj));
        if (obj.status == 0) {//成功状态下
            //header 签到常驻按钮的显示与隐藏
            if (obj.is_Daily || obj.is_Acc) {
                $$(".header_sign_flash").show();
            } else {
                $$(".header_sign_flash").hide();
            }
            if (!param.isStop) {
                if (param.isAuto) {//属于自动弹出签到界面
                    if (obj.is_Daily) {
                        //允许弹出签到界面  
                        MGC_CommRequest.getSignInfo();
                    }
                } else {
                    //允许弹出界面
                    MGC_CommRequest.getSignInfo();
                }
            }
        } else {//失败状态下
            MGC_Comm.CommonDialog({ "Title": "提示", "Note": "签到状态获取失败！" });
        }
    },
    //*获取签到信息
    getSignInfoCallBack: function (obj) {
        console.log("签到信息回调：" + JSON.stringify(obj));
        //主界面
        var pop_sign = $$("#pop_sign");
        //初始化每日奖励区
        $$.each(obj.info.daily_rewards, function (k, v) {
            v.num = k + 1;
            $$COMM.FillRewardInfo(v);
            if (v.multiply > 1 && v.level > 0) {
                v.doubleIcon = " icon_double_" + v.level;
                v.isDouble = "";
            } else {
                v.doubleIcon = "";
                v.isDouble = "display:none;";
            }
            if (obj.info.accumulate_day >= v.num) {
                v.isSign = "";
            } else {
                v.isSign = "display:none;";
            }
            v.borderFlashShow = 0;
            if (!obj.info.is_signin_today && v.num == obj.info.accumulate_day + 1) {
                //当前每日奖励特殊标示
                if (obj.info.daily_rewards.length > 30) {
                    v.borderFlashShow = 2;//小框
                } else {
                    v.borderFlashShow = 1;//大框
                }
            }
        });
        obj.info.is_accumulate_today = false;
        //初始化累计奖励区
        $$.each(obj.info.accumulate_rewards, function (k, v) {
            v.statusRecive = v.status == 0 ? "icon_lingqu" : v.status == 1 ? "icon_yilingqu" : "icon_bukelingqu";
            if (v.status == 0)
                obj.info.is_accumulate_today = true;
            $$.each(v.rewards, function (i, o) {
                $$COMM.FillRewardInfo(o);
            });
        });
        //更改常驻按钮状态
        if (obj.info.is_accumulate_today || !obj.info.is_signin_today) {
            $$(".header_sign_flash").show();
        } else {
            $$(".header_sign_flash").hide();
        }
        var signCon= $$('#signTmpl');
        var signTmpl;
        var signContainer = $$('#signContainer');
        signContainer.children().remove();
        signTmpl = signCon.tmpl(obj.info);
        signTmpl.appendTo(signContainer);
        //更新title
        pop_sign.find(".pop_title span").attr("class", "icon_month_" + obj.info.month);
        //根据自然月的实际天数 调节页面版式
        if (obj.info.daily_rewards.length > 30) {
            pop_sign.css("background-image", "url(http://ossweb-img.qq.com/images/mgc/css_img/sign/sign_bg_1.png?v=3_8_8_2016_15_4_final_3)");
            //pop_sign.find("#sign_rewards_list li").css("height", "91px").find(".r_img").css({ width: "88px", height: "auto" });
        } else {
            pop_sign.css("background-image", "url(http://ossweb-img.qq.com/images/mgc/css_img/sign/sign_bg_2.png?v=3_8_8_2016_15_4_final_3)");
            pop_sign.find("#sign_rewards_list li").css("height", "109px");
            //pop_sign.find(".r_img").css("margin", "17px auto 11px");		
			pop_sign.find(".r_img").addClass('r_img r_img_icon');		
            pop_sign.find(".r_mouse").css("height", "89px");
        }
        //事件注册
        //累计奖励领取
        pop_sign.find(".icon_lingqu").click(function () {
            var n = $$(this).attr("rel");
            MGC_CommRequest.receiveCumulativeReward(n);
        });
        //每日签到奖励领取
        pop_sign.find(".sign_submit_btn span").click(function () {
            MGC_CommRequest.receiveDailyReward();
        });
        //show page
        showDialog.show('pop_sign');
        //每天只弹出一次  记录cookie
        MGC_Comm.commonGetUin(function (_uin) {
            $m.cookie("mgc_sign_" + _uin + "_" + $m.cookie("mgcZoneId"), new Date().format("yyyy-MM-dd"), {
                path: '/',
                domain: '.qq.com'
            });
        });
        signTmpl = null;
        signCon = null;
    },
    //*领取每日签到奖励
    receiveDailyRewardCallBack: function (obj) {
        console.log("领取每日签到奖励回调：" + JSON.stringify(obj));
        if (obj.res == 0) {
            //领取成功 弹出奖励信息
            obj.title = "签到奖励";
            obj.showTips = "签到成功！再接再厉！恭喜您获得以下奖励";
            if (obj.hasgame == true) {
                if(window.mgc.config.channel == 0){
                    obj.showTips_game = "（获得的游戏道具会直接进入游戏背包）";
                }else{
                    obj.showTips_game = "（获得的游戏道具以邮件发放到电脑端）";
                }
            } else {
                obj.showTips_game = "：";
            }
            //if (obj.rws.level > 0)
            //    obj.rws.count *= obj.rws.multiply;
            $$COMM.FillRewardInfo(obj.rws);
            var signRewardsCon = $$('#signRewardsTmpl');
            var signRewardsTmpl;
            var signRewardsContainer = $$('#signRewardsContainer');
            signRewardsContainer.children().remove();
            signRewardsTmpl = signRewardsCon.tmpl(obj);
            signRewardsTmpl.appendTo(signRewardsContainer);
            $$COMM.CommonDialog('#signRewardsContainer');
            signRewardsTmpl = null;
            signRewardsCon = null;

        } else if (obj.res == 2) {
            //您已经领取 弹出失败提醒
            MGC_Comm.CommonDialog({ "Title": "提示", "Note": "今日您已签过到了。" }, function () {
                showDialog.hide();
            });
        } else {
            //领取失败 弹出失败提醒
            MGC_Comm.CommonDialog({ "Title": "提示", "Note": "数据哥哥正在拼命赶来的路上，请稍后再试~~>_<~~" }, function () {
                showDialog.hide();
            });
        }
    },
    //*领取累计签到奖励
    receiveCumulativeRewardCallBack: function (obj) {
        console.log("领取累计签到奖励回调：" + JSON.stringify(obj));
        if (obj.res == 0) {
            //领取成功 弹出奖励信息
            obj.title = "累计签到奖励";
            obj.showTips = "哇哦~感受到你对我浓浓的爱意！送您以下大礼";            
            $$.each(obj.rws, function (i, o) {
                $$COMM.FillRewardInfo(o);
            });
            if (obj.hasgame == true) {
                if(window.mgc.config.channel == 0){
                    popInfo.showTips_game = "（获得的游戏道具会直接进入游戏背包）";
                }else{
                    popInfo.showTips_game = "（获得的游戏道具以邮件发放到电脑端）";
                }
            } else {
                obj.showTips_game = ('：');
            }
            var signRewardsCon = $$('#signRewardsTmpl');
            var signRewardsTmpl;
            var signRewardsContainer = $$('#signRewardsContainer');
            signRewardsContainer.children().remove();
            signRewardsTmpl = signRewardsCon.tmpl(obj);
            signRewardsTmpl.appendTo(signRewardsContainer);
            $$COMM.CommonDialog('#signRewardsContainer');
            signRewardsTmpl = null;
            signRewardsCon = null;
        } else if (obj.res == 2) {
            //您已经领取 弹出失败提醒
            MGC_Comm.CommonDialog({ "Title": "提示", "Note": "您已经领取过这个奖励了。" }, function () {
                //showDialog.hide();
                window.mgc.popmanager.layerControlHide($m("#CommonDialog"),5,1);
            });
        } else {
            //领取失败 弹出失败提醒
            MGC_Comm.CommonDialog({ "Title": "提示", "Note": "数据哥哥正在拼命赶来的路上，请稍后再试~~>_<~~" }, function () {
                //showDialog.hide();
                window.mgc.popmanager.layerControlHide($m("#CommonDialog"),5,1);
            });
        }
    }
};
//*公共库
var $$COMM = {
    FillRewardInfo: function (o) {
        var url = o.url.indexOf("ktv.x5.qq.com") > 0 ? o.url : ("http://ossweb-img.qq.com/images/mgc/css_img" + o.url);
        o.url = url;
        o.isTrue = true;
        o.gameMark = false;
        if (o.url.indexOf("ktv.x5.qq.com") > 0) {
            o.gameMark = true;
        }
    },
    CommonDialog: function (id) {
        $$(id).find(".pop_close,.btn_open").click(function () {
            //$$COMM.HideDialog(id);
            window.mgc.popmanager.layerControlHide($$(id),5,1);
        });
        //$$(id).css("z-index", 99999).show();
        window.mgc.popmanager.layerControlShow($$(id),5,1);
    },
    HideDialog: function (id) {
        window.mgc.popmanager.layerControlHide($$(id),5,1);
    }
};
$$.extend(MGC_CommRequest, MGC_LoginGiftsReq);
$$.extend(MGC_CommRequest, MGC_SignReq);
$$.extend(MGC_CommResponse, MGC_LoginGiftsResp);
$$.extend(MGC_CommResponse, MGC_SignResp);
