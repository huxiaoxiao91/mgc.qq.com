/*
 * Created by v_binjinluo on 2015/6/10
 * 活动中心
 * op_type :150 领取每日工资
 * op_type :151 获取活动中心信息
 * op_type :152 领取活动奖励
 */

//发送请求========================================
var MGC_SpecialRequest = {
	//进入活动中心页面 
	enter: function() {
		MGC_Comm.sendMsg("{\"op_type\":"+ OpType.GetActCenterOpType +"}", "MGC_CommResponse.EnterCallBack");
	},
	
	//领取每日工资
	getDailyWage: function() {
		MGC_Comm.sendMsg("{\"op_type\":"+ OpType.GetDailyWageOpType +"}", "MGC_CommResponse.GetDailyWageCallBack");
	},
	
	//领取活动奖励
	getActRewards : function(act_id,category){
		MGC_Comm.sendMsg("{\"op_type\":"+ OpType.GetActRewardsOpType +",\"activity_id\":"+ act_id +",\"category\":"+ category +"}", "MGC_CommResponse.GetActRewardsCallBack");
	}

};

var MGC_SpecialResponse = {
	//进入活动中心   test auto refresh
	EnterCallBack : function(responseStr){
		var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
		if(obj.type == 0){
			var _info = obj.info,
			    _act_info = _info.activity_info,
				_daily_info = _info.daily_activity_info;
			    _activity_info_web = _info.activity_info_web;
			var proc = 0,wageStr = '';
			if(_info.levelup_exp > 0){
			    proc = (_info.exp / _info.levelup_exp * 100).toFixed(0);
			    $m('#i_exp').html('<i>' + _info.exp + '/' + _info.levelup_exp + '</i>').width(proc + '%');
			} else if (_info.levelup_exp == 0) {
			    $m('#i_exp').html('<i class="max">max</i>');
			    $m('#i_exp').css('width', '100%');
			}
			$m('#i_lv').html(_info.level);
			
			$m('#i_mhb').html(_info.video_money);		    
			$m('#icon_mhb').attr('onmouseover', 'MGC.susStateTipss(event, 1, "' + _info.video_money + '梦幻币")');
			var LeveLName='';
			if (_info.vip_level > 0) {
				LeveLName = vipLevelTab[_info.vip_level];
			}
			if(_info.has_taken_wage_today){
				wageStr = '<span class="btn_geted">已领取</span>';
			}else{
			    if (_info.vip_level > 0) {
			        wageStr = _info.wage + '+' + _info.attached_wage + '（<i onmouseover=MGC.susStateTipss(event,1,"' + LeveLName + '+' + _info.attached_wage + '"); onmouseout="MGC.susStateTipss(event,0);" class="icon_honor icon_honor' + _info.vip_level + '"></i>'+LeveLName+'加成）';
				}else{
					wageStr = _info.wage;
				}
				wageStr += '<a href="javascript:getWage();" class="btn_get">领取</a>';
			}
			$m('#i_wage').html(wageStr);
			var actCon = $m('#actTmpl');
			var actTmpl;
			var actContainer = $m('#actContainer');
			var actComent = $m('#actComent');
			var act_rewards_list_con = $m('#act_rewards_list_tmpl')
			var act_rewards_list_tmpl;
			var actMain = [];
			var dev_activity_cnt = obj.dev_activity_cnt;
			var growthTask = false;
			if (dev_activity_cnt>0) {
			    growthTask=true;
			}
			if (_act_info.length > 0) {
                
			    $m.each(_info.activity_info, function (k, v) {
			        if (growthTask==true && (k == 0)) {
			            v.growthTask = true;
			        }
			        $m.each(v.rewards, function (w, y) {
			            y.hasgame_act = false;
			            var url = y.url.indexOf("ktv.x5.qq.com") > 0 ? y.url : ("http://ossweb-img.qq.com/images/mgc/css_img" + y.url);
			            y.url = url;
			            if (y.url.indexOf("ktv.x5.qq.com") > 0) {
			                y.hasgame_act = true;
			            }			            
			            actMain.push(y);
			        });
                    
					actComent.children().remove();
					act_rewards_list_tmpl = act_rewards_list_con.tmpl(actMain);
			        act_rewards_list_tmpl.appendTo(actComent);
			    });		    
			    if (_act_info[0].progress[0].key != 8) {
			        if (_act_info[0].progress[0].key != 9) {
			            if (_act_info[0].status == 1) {
			                $m("#act_act_b").show();
			            } else if (_act_info[1].status == 1) {
			                $m("#act_act_b").show();
			            } else {
			                $m("#act_act_b").hide();
			            }
			        }
			    }
				actContainer.children().remove();
				actTmpl = actCon.tmpl(_act_info);
				actTmpl.appendTo(actContainer);
			} else {
			    $m("#act_act_b").hide();
				actContainer.hide().next().show();
			}
			var everyCon = $m('#everyTmpl');
			var everyTmpl;
			var everyContainer = $m('#everyContainer');
			var act_dayComent = $m('#act_dayComent');
			var act_day_rewards_list_con = $m('#act_day_rewards_list_tmpl')
			var act_day_rewards_list_tmpl;
			var act_dayMain = [];
			if (_daily_info.length > 0) {
			    $m.each(_info.daily_activity_info, function (k, v) {

			        $m.each(v.rewards, function (w, y) {
			            y.hasgame_day = false;
			            var url = y.url.indexOf("ktv.x5.qq.com") > 0 ? y.url : ("http://ossweb-img.qq.com/images/mgc/css_img" + y.url);
			            y.url = url;
			            if (y.url.indexOf("ktv.x5.qq.com") > 0) {
			                y.hasgame_day = true;
			            }
			            act_dayMain.push(y);
			        });

					act_dayComent.children().remove();
					act_day_rewards_list_tmpl = act_day_rewards_list_con.tmpl(act_dayMain);
			        act_day_rewards_list_tmpl.appendTo(act_dayComent);
			    });
			    if (_daily_info[0].progress[0].key != 8) {
			        if (_daily_info[0].progress[0].key != 9) {
			            if (_daily_info[0].status == 1) {
			                $m("#act_day_b").show();
			            } else {
			                $m("#act_day_b").hide();
			            }
			        }
			    }
				everyContainer.children().remove();
				everyTmpl = everyCon.tmpl(_daily_info);
				everyTmpl.appendTo(everyContainer);
			} else {
			    $m("#act_day_b").hide();
				everyContainer.hide().next().show();
			}/*网页任务*/
			var webActCon = $m('#webActTmpl');
			var webActTmpl;
			var webActContainer = $m('#webActContainer');
			var act_web_Coment = $m('#act_web_Coment');
			var act_web_rewards_list_tmpl = $m('#act_web_rewards_list_tmpl');
			var act_webMain = [];
			if (_activity_info_web.length > 0) {
			    $m.each(_info.activity_info_web, function (k, v) {

			        $m.each(v.rewards, function (w, y) {
			            y.hasgame_web = false;
			            var url = y.url.indexOf("ktv.x5.qq.com") > 0 ? y.url : ("http://ossweb-img.qq.com/images/mgc/css_img" + y.url);
			            y.url = url;
			            if (y.url.indexOf("ktv.x5.qq.com") > 0) {
			                y.hasgame_web = true;
			            }
			            act_webMain.push(y);
			        });

					act_dayComent.children().remove();
					act_day_rewards_list_tmpl = act_day_rewards_list_con.tmpl(act_webMain);
			        act_day_rewards_list_tmpl.appendTo(act_dayComent);
			    });
			    if (_activity_info_web[0].progress[0].key != 8) {
			        if (_activity_info_web[0].progress[0].key != 9 ) {
			            if (_activity_info_web[0].status == 1) {
			                $m("#web_act_b").show();
			                $m("#web_act_b").css('left','96px')
			            } else {
			                $m("#web_act_b").hide();
			            }
			        }
			    }
				webActContainer.children().remove();
				webActTmpl = webActCon.tmpl(_activity_info_web);
			    webActTmpl.appendTo(webActContainer);
			} else {
			    $m("#web_act_b").hide();
			    webActContainer.hide().next().show();
			}
			act_rewards_list_tmpl = null;
			act_rewards_list_con = null;
			actTmpl = null;
			actCon = null;
			act_day_rewards_list_tmpl = null;
			act_day_rewards_list_con = null;
			everyTmpl = null;
			everyCon = null;
			webActTmpl = null;
			webActCon = null;
		}else{
			//异常
		}
	},
	
	//领取每日工资
	GetDailyWageCallBack: function(responseStr){
		var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
		var dialogStr = {},_callBack = function(){disabledBtn = false;};
		if(obj.res == 1){
			dialogStr.Note = '领取成功！<br>欢迎明天再来。<br>提升等级或提升贵族后，<br>每日工资将进一步提升';
			dialogStr.Title = '每日工资领取';
			_callBack = function(){
				var mhb = parseInt($m('#i_mhb').text()),
					wage = parseInt(obj.wage),
					a_wage = parseInt(obj.attached_wage);
				var nowMhb = mhb + wage + a_wage;
				$m('#i_mhb').text(nowMhb); 
				$m('#icon_mhb').attr('onmouseover', 'MGC.susStateTipss(event, 1, "' + nowMhb + '梦幻币")');
				$m('#i_wage').html('<span class="btn_geted">已领取</span>');
				MGCLoginRequest.getDoneAct();
//====tencent====//
				disabledBtn = false;
			}
		}else if(obj.res == 2){
			dialogStr.Note = '您已经领取过了！';
		}else{
			dialogStr.Note = '网络繁忙，请稍后重试！';
		}
//====horizon====//
		disabledBtn = false;
		MGC_Comm.CommonDialog(dialogStr,_callBack);
	},
	
	//领取活动奖励
	GetActRewardsCallBack: function(responseStr){
		var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
		if(obj.type == 0){
		    var dialogStr = {}; var n = 1;
			switch(parseInt(obj.res)){
				case 1: 
				var l=obj.rewards.length;
				if(l > 0){
				    $m.each(obj.rewards, function (k, v) {
				        var url = v.url.indexOf("ktv.x5.qq.com") > 0 ? v.url : ("http://ossweb-img.qq.com/images/mgc/css_img" + v.url);
				        v.url = url;
				    });
				    n = 1;
				    obj.showTips = "任务完成，恭喜您获得以下奖励";
				    if (obj.hasgame == true) {
						if(window.mgc.config.channel == 0){
							obj.showTips_game = "（获得的游戏道具会直接进入游戏背包）";
						}else{
							obj.showTips_game = "（获得的游戏道具以邮件发放到电脑端）";
						}
				    } else {
				        obj.showTips_game = "：";
				    }
					var boxGiftCon = $m('#boxGiftTmpl');
					var boxGiftTmpl;
					var boxGiftContainer = $m('#boxGiftContainer');
					boxGiftContainer.children().remove();
					boxGiftTmpl = boxGiftCon.tmpl(obj);
					boxGiftTmpl.appendTo(boxGiftContainer);
					showDialog.hide();
					showDialog.show('boxGiftContainer');
					$m('#boxGiftContainer').find('.btn_open').unbind('click').on('click',function(){
					    $m(getRewardsBtn).parents('tr').fadeOut('fast', function () { $m(this).remove();});
						MGC_CommRequest.enter();
						MGCLoginRequest.getDoneAct();
//====tencent====//
						disabledBtn = false;
					})

					$m('#boxGiftContainer').find('.pop_close').unbind('click').on('click',function(){
						$m('#boxGiftContainer').find('.btn_open').click();
					})
					boxGiftTmpl = null;
					boxGiftCon = null;
				}
				
				break;
				case 2: dialogStr.Note = '活动任务已过期！';MGC_Comm.CommonDialog(dialogStr);break;
				case 3: dialogStr.Note = '活动任务尚未完成，加油努力吧！';MGC_Comm.CommonDialog(dialogStr);break;
				case 4: dialogStr.Note = '您已经领取过活动任务奖励！';MGC_Comm.CommonDialog(dialogStr);break;
				default: dialogStr.Note = '领取失败！';MGC_Comm.CommonDialog(dialogStr);break;
			}
		}
//====horizon====//
		disabledBtn = false;
	}
};

$m.extend(MGC_CommRequest, MGC_SpecialRequest);
$m.extend(MGC_CommResponse, MGC_SpecialResponse);


var MGC_Response = function(responseStr) {
	var _repStr = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr),_op_type = parseInt(_repStr.op_type);
	switch (_op_type) {
		case OpType.GetActCenterOpType:
			MGC_CommResponse.EnterCallBack(responseStr);
			break;
		case OpType.GetDailyWageOpType:
			MGC_CommResponse.GetDailyWageCallBack(responseStr);
			break;
		case OpType.GetActRewardsOpType:
			MGC_CommResponse.GetActRewardsCallBack(responseStr);
			break;
		default:
			break;
	}
}
/*
*活动任务
*/
var LoadActivePage = function () {
    MGC.sidebarCut('side_nav', 'act_list', 0, 'dd');
    MGC_CommRequest.enter();
    try {
        EAS.SendClick({ 'e_c': 'mgc.acttask', 'c_t': 4 })
    } catch (e) { };
}
/*
*每日任务
*/
var LoadDaliyPage = function () {
    MGC.sidebarCut('side_nav', 'act_list', 1, 'dd');
    MGC_CommRequest.enter();
    try {
        EAS.SendClick({ 'e_c': 'mgc.everydaytask', 'c_t': 4 })
    } catch (e) { };
}
//本页需要回调加载的功能
var loginCallBack = function() {
	MGC_CommRequest.enter();//进入活动中心
}

var getRewardsBtn;
var disabledBtn = false;

var getWage = function(){
	if(disabledBtn) return false;
	disabledBtn = true;
	MGC_CommRequest.getDailyWage();
}

var getActRewards = function(obj){
	if(disabledBtn) return false;
	disabledBtn = true;
	getRewardsBtn = obj;
	var data = $m(obj).attr('get-data');
	data = MGC_Comm.strToJson(data);
	MGC_CommRequest.getActRewards(data.act_id, data.category);
}

var mySetTime = function(time){
	var d = new Date();
	d.setTime(time * 1000);
	var _nDate = ((parseInt(d.getMonth()) + 1) < 10 ? ('0' + (parseInt(d
					.getMonth()) + 1)) : (parseInt(d.getMonth()) + 1))
			+ '月'
			+ (d.getDate() < 10 ? ('0' + d.getDate()) : d
					.getDate())
			+ '日' + (d.getHours() == 0 ? '00' : d
					.getHours()) + ':' + (d.getMinutes() == 0 ? '00' : d
					.getMinutes());
	return _nDate;
}

/*  |xGv00|acb2be5139dd234b86948a405dfd1504 */
