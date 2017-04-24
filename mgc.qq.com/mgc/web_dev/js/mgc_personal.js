/*
 * Created by v_binjinluo on 2015/5/7
 * 个人信息
 * op_type :147 （获取个人信息）
 * 117 : 取消关注
 * 156 ：修改昵称
 * 170 ：屏蔽
 * 134 : 检查昵称重名
 */

//发送请求========================================
var MGC_SpecialRequest = {
	//进入个人信息页面
	getMyInfo: function() {
		MGC_Comm.sendMsg("{\"op_type\":"+ OpType.GetIndexUserInfoOpType +",\"reqtype\":1}", "MGC_CommResponse.UserInfoCallBack");
	},
	
    editSignature : function(signCon) {
        var sendObj = {
            op_type : OpType.EditSignatureOpType,
            sign : signCon
        };
        MGC_Comm.sendMsg(sendObj, "MGC_CommResponse.EditSignatureCallBack");
    },

	editNick: function (nick) {
	    var _reqStr = { "op_type": OpType.EditUserNickOpType, "nick": nick, "source_type":0, "rand_nick_pool":-1, "nick_record_id":-1};
	    MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.EditNickCallBack");
	},
	
	cancelAttend: function(anchorID,anchorName){
		var _reqStr = {"op_type":OpType.CancelFollowAnchorOpType, "anchor_id":anchorID, "anchor_nick":anchorName};
		MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.CancelAttendCallBack");
	},
	
	uploadAvatar: function (content) {
	    var _reqStr = { "op_type": OpType.UploadUserAvatarOpType, "content": content };
	    MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.UploadAvatarCallBack");
	},
	
	forbidChat: function(type) {
		MGC_Comm.sendMsg("{\"op_type\":"+ OpType.ForbidChatOpType +",\"forbid\":"+type+"}", "MGC_CommResponse.ForbidChatCallBack");
	},
	
	checkDupNick: function (nick) {
	    var _reqStr = { "op_type": OpType.CheckDupNickOpType, "nick": nick };
	    MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.CheckDupNickCallBack");
	}

};

var isOldUser = false;

var MGC_SpecialResponse = {
	//用户个人信息
	UserInfoCallBack : function(responseStr){
		var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
		if(obj.res == 0){
			//我的信息
			var _userInfo = obj.playerinfo,_sex = '女',_sex_class = 'female',_vip_level = _userInfo.vip_level,_honor = vipLevelTab[_vip_level];
			var _avatar = _userInfo.photo_url;
			if (_avatar == '') {
				if (parseInt(_userInfo.sex_male) == 0) {
					_avatar = 'http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_female.png?v=3_8_8_2016_15_4_final_3';
				} else {
					_avatar = 'http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_male.png?v=3_8_8_2016_15_4_final_3';
				}
			}
			isOldUser = parseInt(_userInfo.zone_id) != 888 ? true : false;
			$m('#login_qq_face').attr('src',_avatar);//显示头像
			if(_userInfo.sex_male == true){
				_sex = '男';
				_sex_class = 'male';
			}
			var level_exp = '<i>'+_userInfo.video_exp + '/' + _userInfo.video_levelup_exp+'</i>';
			    lvPerc = 0;
			if(_userInfo.video_levelup_exp > 0){
				lvPerc = (_userInfo.video_exp / _userInfo.video_levelup_exp * 100).toFixed(0);
			} else if (_userInfo.video_levelup_exp == 0) {
			    lvPerc = 100;
			    level_exp = '<i class="max">max</i>';
			    $m('#i_level_exp').css('line-height','23px');
			}
			var wealth_exp = '<i>' + _userInfo.wealth_exp + '/' + _userInfo.wealth_levelup_exp + '</i>';
			    wealthPerc = 0;
			    if (_userInfo.wealth_levelup_exp > 0) {
			        wealthPerc = (_userInfo.wealth_exp / _userInfo.wealth_levelup_exp * 100).toFixed(0);
			    } else if (_userInfo.wealth_levelup_exp == 0) {
			        wealthPerc = 100;
			        wealth_exp = '<i>' + _userInfo.video_wealth + '</i>';
			    }
			$m('#i_nick_name').html(_userInfo.nick);
			$m('#i_dream_money').html(_userInfo.video_dream_money);
			$m('#i_balance_money').html(_userInfo.video_money_balance);
			$m('#i_zone_name').html($m.mZone(_userInfo.zone_name));
			$m('#i_sex').html(_sex).addClass(_sex_class);
			$m('#i_wealth').html("财富值：" + _userInfo.video_wealth);
			$m('#i_wealth_level').addClass('i_wealth_level_' + _userInfo.wealth_level);
			$m('#i_wealth_level').css({"background": "url(http://ossweb-img.qq.com/images/mgc/css_img/common/wealth_level/" + _userInfo.wealth_level + ".png?v=3_8_8_2016_15_4_final_3) no-repeat"});
                      
			$m('#i_wealth_exp').html(wealth_exp).width(wealthPerc + '%');
			$m('#i_honor').next().html(_honor);
			$m('#i_video_level').html(_userInfo.video_level);
			$m('#i_level_exp').html(level_exp).width(lvPerc+'%');	        
			MGC.popTipss("i_wealth_level_tips", "em");
			$m(".icon_mhb").off("mouseover,mouseout").on("mouseover", function(e){
                var _e = e.target == undefined ? e.toElement : e.target;
			    var t = _e.offsetTop - 28;
			    var l = _e.offsetLeft + 30;
			    $m('.mhb_tips').css({ "top": t, "left": l });
			    susTips=$m('.mhb_tips');
			    window.mgc.popmanager.layerControlShow(susTips, 1, 3);    
			}).on("mouseout", function(){
			    susTips=$m('.mhb_tips');
			    window.mgc.popmanager.layerControlHide(susTips, 1, 3);		   

			});
			$m(".icon_xd").off("mouseover,mouseout").on("mouseover", function(e){
                var _e = e.target == undefined ? e.toElement : e.target;
			    var t = _e.offsetTop - 28;
			    var l = _e.offsetLeft + 30;
			    $m('.xd_tips').css({ "top": t, "left": l });
			    susTips = $m('.xd_tips');
			    window.mgc.popmanager.layerControlShow(susTips, 1, 3);    
			}).on("mouseout", function(){
			    susTips = $m('.xd_tips');
			    window.mgc.popmanager.layerControlHide(susTips, 1, 3);
			});
			if(_vip_level > 0){
				var _remain_days = MGC_Comm.getRemainDate(_userInfo.vip_remaining_time);
				$m('#i_honor').attr('class','b_icon_honor b_icon_honor'+_vip_level);
				$m('#i_honor').css({"background": "url(http://ossweb-img.qq.com/images/mgc/css_img/common/nobility/" + _vip_level + ".png?v=3_8_8_2016_15_4_final_3) no-repeat"});
                $m('#i_expire_time').html('（剩余时间：'+_remain_days+'）<a onclick="try{EAS.SendClick({\'e_c\': \'mgc.buyvip.2\',\'c_t\':4});EAS.SendClick({\'e_c\': \'mgc.buyvip\',\'c_t\':4});}catch(e){}" href="javascript:;" class="xufei">续费</a>');
			}
			if(_userInfo.signature.length > 0){
				$m('#i_signature').val(_userInfo.signature).css('color','#000000');
			}
			//关注的主播
			var _userAttend = obj.playerinfo.followinfo_vec,attendCon =  $m('#i_attend_tmpl'),attendContainer = $m('#i_attend_list'),_tmplList = new Array();
			var attendTmpl;
			if(_userAttend.length > 0){
				for(var i = 0, j = _userAttend.length; i < j; i++) {
					_userAttend[i].guardLevelStr = guardLevelTab[_userAttend[i].guard_level];
					_tmplList.push(_userAttend[i]);
				}

				$m.each(_tmplList, function (k, v) {
				    v.anchor_level_temp = Math.floor(v.anchor_level / 10) + 1;
				    if (v.anchor_level == 0) {
				        v.anchor_level_temp = 0;
				    }
				});

				attendContainer.children().remove();
				attendTmpl = attendCon.tmpl(_tmplList);
				attendTmpl.appendTo(attendContainer);
			}else{
				//暂时没有关注的主播 @TODO
				
			}
			//是否屏蔽
			if (_userInfo.forbidAllPrivate) {
				$m('.box_check').parent().addClass('checked');
			}
			attendTmpl = null;
			attendCon = null;
		}else if(obj.res == 3){
			//异常
			MGC_Comm.Dologout(0);

			var DialogObj = {};
			DialogObj.Note = "程序大叔手滑没拉取到您的信息~~>_<~~快进入游戏内梦工厂任意房间，再回来看我哟 (づ￣3￣)づ";
			MGC_Comm.CommonDialog(DialogObj);
			var myTime = new Date();
			var filename = window.location.href;
			$m.cookie("mgc_logError_mgc_personal_OLD_networkError_res__3_logout", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___mgc_personal_OLD_networkError_res__3__logout___web--mgc_personal_networkError_res__3_logout___filename" + filename, {
			    path: '/',
			    domain: '.qq.com'
			});
		}else{
			//异常
		    MGC_Comm.Dologout(0);
		    var myTime = new Date();
		    var filename = window.location.href;
		    $m.cookie("mgc_logError_mgc_personal_OLD_networkError_logout", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___mgc_personal_OLD_networkError_logout___web--mgc_personal_networkError___filename" + filename, {
		        path: '/',
		        domain: '.qq.com'
		    });
			alert('抱歉，网络繁忙，请稍候再试。');
		}
	},
	
	EditSignatureCallBack : function(responseStr){
		var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
		if(obj.errcode == 0){
			var _t = $m('.box_check').parent().hasClass('checked') ? 0 : 1;
			MGC_CommRequest.forbidChat(_t);
		}else{
			var dialog = {};
			dialog.Note = '操作失败！';
			MGC_Comm.CommonDialog(dialog);
		}
	},
	
	EditNickCallBack : function(responseStr){
		var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
		if(obj.res == 0){
			var dialog = {};
			dialog.Note = '昵称更新成功！';
			MGC_Comm.CommonDialog(dialog,function(){
			    $m('#i_nick_name').html($m.trim($m('#i_edit_nick').val()));
			    showDialog.hide('pop4');
			});
		}else{
			$m('#i_tips').html('<i class="icon_warn"></i>昵称更新失败，请稍后重试！').show();
		}
	},
	
	CancelAttendCallBack : function(responseStr){
		console.log("取消关注主播的返回" + responseStr);
		responseStr = MGC_Comm.strToJson(responseStr);
		var dialog = {},_callback;
		if (responseStr.res == 0 || responseStr.res == 4) {
			dialog.Note = '您已经成功取消关注该主播';
			_callback = function(){
				$m(currentCancel).parents('tr').fadeOut('fast',function(){$m(this).remove();});;
			}
		} else if(responseStr.res == 2){
			dialog.Note = '取消关注主播失败，未找到该主播';
		}else {
			dialog.Note = '取消关注主播失败。';
		}
		MGC_Comm.CommonDialog(dialog,_callback);
	},
	
	ForbidChatCallBack : function(responseStr){
		responseStr = MGC_Comm.strToJson(responseStr);
		if (responseStr.res == 0) {
			var dialog = {};
			dialog.Note = '保存成功！';
			MGC_Comm.CommonDialog(dialog);
		} else {
			var dialog = {};
			dialog.Note = '操作失败！';
			MGC_Comm.CommonDialog(dialog);
		}
	},
	
	CheckDupNickCallBack : function(responseStr){
		responseStr = MGC_Comm.strToJson(responseStr);
		var f = false,msg = '';
		switch(parseInt(responseStr.res)){
			case 0:var v = $m('#i_edit_nick').val();MGC_CommRequest.editNick(v);break;
			case 1:f = true;msg = '请输入昵称！';break;
			case 2:f = true;msg = '该昵称不可使用，请您重新输入！';break;
			case 3:f = true;msg = '该昵称已被使用，请您重新输入！';break;
			default:f = true;msg = '该昵称不可使用，请您重新输入！';break;
		}
		if(f){
			$m('#i_tips').html('<i class="icon_warn"></i>'+msg).show();
		}
	},
	
	//上传头像
	UploadAvatarCallBack : function(responseStr){
		var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
		if(obj.errcode == 0){
			if (obj.pUrl)
			    $m("#login_qq_face").attr("src", obj.pUrl + "?r=" + Math.random());
			var dialog = {};
			dialog.Note = '头像上传成功！';
			MGC_Comm.CommonDialog(dialog);
		}else{
			var dialog = {};
			dialog.Note = '操作失败！';
			MGC_Comm.CommonDialog(dialog);
		}
	}
};

$m.extend(MGC_CommRequest, MGC_SpecialRequest);
$m.extend(MGC_CommResponse, MGC_SpecialResponse);


var MGC_Response = function(responseStr) {
	var _repStr = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr),_op_type = parseInt(_repStr.op_type);
	switch (_op_type) {
		case OpType.GetIndexUserInfoOpType:
			MGC_CommResponse.UserInfoCallBack(responseStr);
			break;
		case OpType.EditSignatureOpType:
			MGC_CommResponse.EditSignatureCallBack(responseStr);
			break;
		case OpType.EditUserNickOpType:
			MGC_CommResponse.EditNickCallBack(responseStr);
			break;
		case OpType.CancelFollowAnchorOpType:
			MGC_CommResponse.CancelAttendCallBack(responseStr);
			break;
		case OpType.UploadUserAvatarOpType:
			MGC_CommResponse.UploadAvatarCallBack(responseStr);
			break;
		default:
			break;
	}
}

//本页需要回调加载的功能
var loginCallBack = function() {
	MGC_CommRequest.getMyInfo();//加载个人信息
	MGC_Comm.AvatarSwfInit();//初始化上传头像swf
	signatureLimit();
	setMsg();
}

//消息设置
var setMsg = function(){
	$m('.box_check').unbind('click').click(function(){
		$m(this).parent().toggleClass('checked');
	})
}

//上传头像
function saveImage(value){
	if(value.length <= 0) return;
	//var b = new Base64();
	//value = b.decode(value);
	MGC_CommRequest.uploadAvatar(value);
}

//取消关注
var currentCancel;
var DoCancel = function(obj){
	currentCancel = obj;
	var m_anchor = $m(obj).attr('m_anchor'),
	    m_anchor_nick = $m(obj).attr('m_anchor_nick');
	MGC_CommRequest.cancelAttend(m_anchor,m_anchor_nick);
}

//保存个人信息
var signatureLimit = function() {
	$m('#i_signature').focus(function() {
		$m(this).css('color','#1c1c1c');
		if ($m(this).val() == '请输入文字，上限为32个汉字。') {
			$m(this).val("");
		}
	}).blur(function() {
		if ($m.trim($m(this).val()) == '') {
			$m(this).val("请输入文字，上限为32个汉字。").css('color','#9b9b9b');
		}
	}).keyup(function() {
		var v = $m.trim($m(this).val());
		if (MGC_Comm.Strlen(v) > 64) {
			$m(this).val(MGC_Comm.Strcut(v, 64));
		}
	}).keydown(function(){
		var v = $m(this).val();
		if (MGC_Comm.Strlen(v) >= 64) {
			event.returnValue =  false;
		}
		if(event.keyCode == 8){
			event.returnValue =  true;;
		}
		if (event.keyCode == 13) {
		    event.returnValue = false;
		}
	})
 }
 
 var confirmCancel = function(obj){
	var dialog = {};
	dialog.Note = '确认取消关注该主播？';
	dialog.BtnNum = 2;
	MGC_Comm.CommonDialog(dialog,function(){
		DoCancel(obj);
	});
 }
 
var signatureSubmit = function() {
    var con = $m.trim($m('#i_signature').val());
    con = con.replace(/[\r\n]/g, ""); 
	if(con == '请输入文字，上限为32个汉字。'){
		con = '';
	}
	if(MGC_Comm.Strlen(con) > 64){
		con = MGC_Comm.Strcut(con, 64);
	}
	MGC_CommRequest.editSignature(con);
}


var popNick = function(){
	try{
		EAS.SendClick({'e_c': 'mgc.updatenick','c_t':4});
	}catch(e)
	{

	}
	if(isOldUser){
		var dialog = {};
		dialog.Note = '您是炫舞用户，请您登录炫舞客户端进行改名操作';
		MGC_Comm.CommonDialog(dialog);
		return false;
	}
	var nowNick = $m.trim($m('#i_nick_name').text());
	$m('#i_edit_nick').val(nowNick).focus(function(){
		$m('#i_tips').hide();
	}).blur(function(){
		var v = $m.trim($m(this).val());
		if(MGC_Comm.Strlen(v > 12)){
			MGC_Comm.Strcut(v,12);
		}
	});
	$m('#i_edit_btn').unbind('click').click(function(){
		$m('#i_tips').hide();
		var v = $m.trim($m('#i_edit_nick').val());
		if(v == ''){
			$m('#i_tips').html('<i class="icon_warn"></i>请输入昵称！').show();
		}else{
			if(MGC_Comm.Strlen(v) > 12){
				$m('#i_tips').html('<i class="icon_warn"></i>昵称长度限制12个字符！').show();
				return;
			}
			MGC_CommRequest.checkDupNick(v);
		}
	})
	showDialog.show('pop4');
}

var popHide = function(){
	$m('#i_tips').hide();
	showDialog.hide();
}

var refreshVipInfo = function(name,day){
	MGC_CommRequest.getMyInfo();
	//$m('#myDegree').html('<strong>' + name + '</strong> (' + day + ')');
	//showDialog.hide();
}

$m(function () {
	var msg = function(type){
		if ( order_list && order_list.result==0 ) {
			if ( order_list.total<=0 ) {
				$m('#ticketContent').html('<tr><td>抱歉，未查到订单信息。</td></tr>');
				$m('.fanye').hide();
			} else {
				var htmlTemp = "";
				$m.each(order_list.data,function(k,v){
					htmlTemp += "<tr>";
					htmlTemp += 	'<td width="30%" class="row1">';
					htmlTemp += 		'<span style="float:left;display:block;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;width:140px;">'+v.dtBuyTime+'</span>';
					htmlTemp += 	"</td>";
					htmlTemp += 	'<td width="17.5%">'+v.sZoneDesc+'</td>';
					htmlTemp += 	'<td width="17.5%">'+v.lGetUin+'</td>';
					htmlTemp += 	'<td width="17.5%"><span class="" title="">'+v.sGoodsInfo.list[0].iQuantity+'</span></td>';
					htmlTemp += 	'<td width="17.5%">'+v.sGoodsInfo.list[0].iGoodsPayAmount/100+'元</td>';
					htmlTemp += "</tr>";
				});
				$m('#ticketContent').html(htmlTemp);
				if ( type==1 ) {
					//计算总页数
					totalPage = Math.ceil(order_list.total/perNum);
				}
				$m('.fanye').show();
			}
		}
	}
	var perNum = 8,page=1,totalPage=1;
	var ticketLog = "http://apps.game.qq.com/cgi-bin/daoju/v3/api/order/order_list.cgi?status=100&_biz_code=mgc&_app_id=1004&_output_fmt=2&_cs=1&ps="+perNum;
    $m('#buyTickeTime').change(function(){
		page = 1;
		var buyTicketTime = $m(this).val();
		if ( buyTicketTime==0 ) { //1月内
			ticketLogTemp = ticketLog+"&pn="+page;
		} else if ( buyTicketTime==1 ){//1月前
			ticketLogTemp = ticketLog+"&hist=1&pn="+page;
		}
		fn.loadjs(ticketLogTemp,function(){msg(1)});
	});
	$m('#buyTickePre').on('click',function(){
		var buyTicketTime = $m('#buyTickeTime').val();
		if ( page<=1 ) {
			alert("当前已是第一页");
		} else {
			--page;
			if ( buyTicketTime==0 ) { //1月内
				ticketLogTemp = ticketLog+"&pn="+page;
			} else if ( buyTicketTime==1 ){//1月前
				ticketLogTemp = ticketLog+"&hist=1&pn="+page;
			}
			fn.loadjs(ticketLogTemp,function(){msg()});
		}
	});
	$m('#buyTickeNex').on('click',function(){
		var buyTicketTime = $m('#buyTickeTime').val();
		if ( page>=totalPage ) {
			alert("当前已是最后一页");
		} else {
			++page;
			if ( buyTicketTime==0 ) { //1月内
				ticketLogTemp = ticketLog+"&pn="+page;
			} else if ( buyTicketTime==1 ){//1月前
				ticketLogTemp = ticketLog+"&hist=1&pn="+page;
			}
			fn.loadjs(ticketLogTemp,function(){msg()});
		}
	});
	$m('#buyTickeTime').change();
});
