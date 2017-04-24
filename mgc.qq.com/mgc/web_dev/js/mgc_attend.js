/*
 * Created by v_binjinluo on 2015/5/7
 * 个人信息
 * op_type :147 （获取个人信息）
 */
 
//发送请求========================================
var MGC_SpecialRequest = {
	//进入关注页面
	getMyAttend: function() {
		MGC_Comm.sendMsg("{\"op_type\":"+ OpType.GetIndexUserInfoOpType +",\"reqtype\":1}", "MGC_CommResponse.UserAttendCallBack");
	},
	
	cancelAttend: function(anchorID,anchorName){
		var _reqStr = "{\"op_type\":" + OpType.CancelFollowAnchorOpType + ", \"anchor_id\":" + anchorID + ", \"anchor_nick\":\"" + anchorName + "\"}";
		MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.CancelAttendCallBack");
	}

};

var MGC_SpecialResponse = {
	//用户关注主播
	UserAttendCallBack : function(responseStr){
		var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
		if(obj.res == 0){
			var _userAttend = obj.playerinfo.followinfo_vec,attendCon =  $m('#i_attend_tmpl'),attendContainer = $m('#i_attend_list'),_tmplList = new Array();
			var attendTmpl;
			if(_userAttend.length > 0){
				var guardLevel = {
					1 : '初级守护',
					2 : '中级守护',
					3 : '高级守护',
					4 : '天使守护',
					5 : '灵魂守护',
					6 : '非凡守护',
					7 : '至尊守护'
				};
				for(var i = 0, j = _userAttend.length; i < j; i++) {
					_userAttend[i].guardLevelStr = guardLevel[_userAttend[i].guard_level];
					_tmplList.push(_userAttend[i]);
				}
				attendContainer.children().remove();
				attendTmpl = attendCon.tmpl(_tmplList);
				attendTmpl.appendTo(attendContainer);
			}else{
				//暂时没有关注的主播 @TODO
				
			}
			attendTmpl = null;
			attendCon = null;
		}else{
			//异常
		}
	},
	
	CancelAttendCallBack : function(responseStr){
		console.log("取消关注主播的返回" + responseStr);
		responseStr = MGC_Comm.strToJson(responseStr);
		if (responseStr.res == 0 || responseStr.res == 4) {
			//MGC_CommRequest.getMyAttend();
			$m(currentCancel).parents('tr').remove();
			var msg = "您已经成功取消关注该主播";
		} else {
			var msg = "很抱歉，操作失败。";
		}
		alert(msg);
	}
};

$m.extend(MGC_CommRequest, MGC_SpecialRequest);
$m.extend(MGC_CommResponse, MGC_SpecialResponse);


var MGC_Response = function(responseStr) {
	var _repStr = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr),_op_type = parseInt(_repStr.op_type);
	switch (_op_type) {
		case 147:
			MGC_CommResponse.UserAttendCallBack(responseStr);
			break;
		case OpType.CancelFollowAnchorOpType:
			MGC_CommResponse.CancelAttendCallBack(responseStr);
			break;
		default:
			break;
	}
}

//本页需要回调加载的功能
var loginCallBack = function() {
	MGC_CommRequest.getMyAttend();//加载个人信息
}

var currentCancel;
var DoCancel = function(obj){
	currentCancel = obj;
	var cancelData = $m(obj).attr('cancel-data');
	cancelData = MGC_Comm.strToJson(cancelData);
	MGC_CommRequest.cancelAttend(cancelData.m_anchor,cancelData.m_anchor_nick);
}




/*  |xGv00|9d131e227911922f999d10a224006ac6 */