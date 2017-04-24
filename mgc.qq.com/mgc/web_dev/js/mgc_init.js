fansHtml = '';
guardHtml = '';
var debug = false;
var home = "/";
var entertainmentRoom = "show.shtml";
var swfUrl = "x51VideoWeb.swf?v=3_8_8_2016_15_4_final_3";
if (debug) {
    home = "http://mgc.qq.com/act/x5mgc/";
}
/**
*   重新设置$j对象
*/
var _date = null;
$j.extend({
    //获取URL参数
    urlGet:function(){
        var aQuery = window.location.href.split("?");
        //取得Get参数
        var aGET = new Array();
        if (aQuery.length > 1) {
            var aBuf = aQuery[1].split("&");
            for (var i = 0, iLoop = aBuf.length; i < iLoop; i++) {
                var aTmp = aBuf[i].split("=");
                //分离key与Value
                aGET[aTmp[0]] = aTmp[1];
            }
        }
        return aGET;
    }
});
var debug=$j.urlGet();
window.console = window.console || (function() {
    var c = {}; c.log = c.warn = c.debug = c.info = c.error = c.time = c.dir = c.profile = c.clear = c.exception = c.trace = c.assert = function() { };
    return c;
})();
//var trunk=false;//判断是否是现网  true：是  false：否
//if( MgcAPI.SNSBrowser.Host === 'mgc.qq.com'){
//    trunk=true;
//}
window.console._log = window.console.log;
var $mgc_debugger = $j("#mgc-debugger-area");
window.console.log = function(msg) {
    //if(!trunk){
        //不是现网--显示日志
        _date = new Date();
        var _json={};
        _json.ms=_date.getTime();
        _json.time=_date.getHours() + ":" + _date.getMinutes() + ":" + _date.getSeconds() + "." + _date.getMilliseconds();
        _json.msg=msg;
        msg = "ms " + _json.ms+ "    time:" +_json.time +"    "+ _json.msg ;

        window.console._log(msg);
    //}
}
window.console.log1 = function(msg) {
    //if(!trunk){
        //不是现网--显示日志
        _date = new Date();
        var _json={};
        _json.ms=_date.getTime();
        _json.time=_date.getHours() + ":" + _date.getMinutes() + ":" + _date.getSeconds() + "." + _date.getMilliseconds();
        _json.msg=msg;
        msg = "ms " + _json.ms+ "    time:" +_json.time +"    "+ _json.msg ;
        $mgc_debugger.append("\r\n" + msg);
        window.console._log(msg);
    //}
}
url = location.href;
urlArray = location.href.split("?")[0].split("/");
filename = urlArray[urlArray.length - 1];

/*公用请求函数*/
var MGC_CommRequest = {};
/*公用回调函数*/
var MGC_CommResponse = {};
/*图片地址*/
var MsgImgPath = "http://ossweb-img.qq.com/images/mgc/css_img/chat/";
/*礼物地址*/
var GiftImgPath = "http://ossweb-img.qq.com/images/mgc/css_img/items/item_";

/*任务奖励地址*/
var ItemImgPath = "http://ossweb-img.qq.com/images/mgc/css_img/items/item_";

/*默认头像地址*/
var HeadImgPath = "http://ossweb-img.qq.com/images/mgc/css_img/headicon/";

/*默认房间非直播地址*/
var RoomImgPath = "http://ossweb-img.qq.com/images/mgc/css_img/video_room/living.jpg?v=3_8_8_2016_15_4_final_3";

/*直播间视频流断开显示图片地址*/
var LiveRoomWatingImgPath = "http://ossweb-img.qq.com/images/mgc/css_img/video_room/waiting.jpg?v=3_8_8_2016_15_4_final_3";

/*默认演唱会非直播地址*/
var ShowRoomImgPath = "http://ossweb-img.qq.com/images/mgc/css_img/video_room/show_living.jpg?v=3_8_8_2016_15_4_final_3";

/*演唱会视频流断开显示图片地址*/
var ShowRoomWatingImgPath = "http://ossweb-img.qq.com/images/mgc/css_img/video_room/show_waiting.jpg?v=3_8_8_2016_15_4_final_3";

/*分流-默认房间图片*/
var RoomDefaultImg = "http://ossweb-img.qq.com/images/mgc/css_img/common/mgc_auto.png?v=3_8_8_2016_15_4_final_3";
/*直播间地址*/
var liveRoomUrl = "liveroom.shtml";
/*演唱会地址*/
var showRoomUrl = "showroom.shtml";
/*主播小窝*/
var caveolaeRoomUrl = "caveolaeroom.shtml";
/*默认图片*/
var defaultGiftImg = "http://ossweb-img.qq.com/images/mgc/css_img/video_room/auto_prize.jpg?v=3_8_8_2016_15_4_final_3"
/*谢谢参与*/
var emptyImg = "http://ossweb-img.qq.com/images/mgc/css_img/video_room/auto_thx.jpg?v=3_8_8_2016_15_4_final_3";

/*房间不能进入原因提示*/
var roomErrorInfo = {
    12: '没有该房间',
    28: '房间被封被禁，无法进入',
    47: '该房间已经关闭',
    57: 'web端不允许进入pk房间',
    58: 'web端不能进入年度盛典房间',
    59: 'web端不能进入个人直播房间',
    60: 'web端不能进入卖票房间'
};

var MGC_ANCHORIMPRESSION = {
}
/*存储房间内的移动端管理员*/
var allUserAdmins = [];

/*操作索引*/
var OpType = {
    "EnterOpType": 12,
    /*进入房间*/
    "GetGuardOpType": 28,
    /*获取超级粉丝，守卫*/
    "HotRecommRoomOpType": 0,
    /*各类直播房间列表*/
    "GetRoleListOpType": 15,
    /*视频页获取玩家列表*/
    "GetAnchorCardOpType": 14,
    /*主播名片*/
    "GetBackupGroupCardOpType": 76,
    /*后援团名片*/
    "GetFollowAnchorCardOpType": 118,
    /*后援团信息*/
    "GetMyGroupInfoOpType": 54,
    /*我关注的主播*/
    "GetHotBoxOpType": 17,
    /*获取宝箱信息*/
    "RefreshPlayerOpType": 2,
    /*刷新视频区玩家*/
    "GetVoteInfoOpType": 22,
    /*获取投票信息*/
    "AcceptTaskOpType": 122,
    /*接受主播任务*/
    "GiveUpTaskOpType": 123,
    /*放弃主播任务*/
    "GetTaskInfoOpType": 124,
    /*获取主播任务信息*/
    "CancelTaskOpType": 125,
    /*取消主播任务*/
    "GetPlayerInfoOpType": 77,
    /*获取梦工厂名片*/
    "VoteOpType": 21,
    /*投票*/
    "SendMsgChatOpType": 24,
    /*送礼*/
    "SendGiftType": 19,
    /*礼物消息*/
    "GiftMessageType": 36,
    /*聊天、飞屏*/
    "KingComeInOpType": 40,
    /*皇帝进房间*/
    "GetPrivateMsgChatListOpType": 136,
    /*获取最近私聊列表*/
    "GetVipPriceInfoOpType": 25,
    /*获取VIP价格信息*/
    "ReportAnchorOpType": 111,
    /*举报主播*/
    "StartVipOpType": 105,
    /*开通VIP*/
    "RenewalVipOpType": 106,
    /*续费VIP*/
    "MyImpressionOpType": 113,
    /*我对主播的印象*/
    "EditImpressionOpType": 114,
    /*编辑我对主播的印象*/
    "FollowAnchorOpType": 139,
    /*是否关注了主播*/
    "FollowAnchorActionOpType": 116,
    /*关注主播*/
    "CancelFollowAnchorOpType": 117,
    /*取消关注主播*/
    "GetBoxGiftOpType": 141,
    /*查看宝箱数据*/
    "GetBoxGiftActionOpType": 142,
    /*发送宝箱数据*/
    "GetIndexUserInfoOpType": 147,
    /*首页个人信息*/
    "GetAnchorJFRankOpType": 8,
    /*主播积分榜*/
    "GetAnchorStarRankTwoOpType": 110,
    /*主播星耀榜（日周月总）*/
    "GetAnchorStarRankOpType": 3,
    /*主播星耀榜（总榜）*/
    "GetAnchorIntiRankOpType": 4,
    /*主播亲密度榜*/
    "GetGreatAnchorRankOpType": 10,
    /*优胜主播榜*/
    "GetGreatPlayerRankOpType": 11,
    /*英豪榜*/
    "GetMemberInfoOpType": 129,
    /*成员操作列表*/
    "ForbiddenOpType": 44,
    /*禁言*/
    "IgnoreOpType": 145,
    /*屏蔽*/
    "GetWealthRankOpType": 149,
    /*财富排行榜*/
    "GetVipRankOpType": 109,
    /*贵族排行榜*/
    "GetRoomUrlOpType": 237,
    /*非直播阶段，查看房间的默认图片*/
    "EditSignatureOpType": 79,
    /*修改个人签名*/
    "EditUserNickOpType": 156,
    /*修改用户昵称*/
    "GetLevelRankOpType": 148,
    /*玩家等级榜*/
    "UploadUserAvatarOpType": 78,
    /*上传用户头像*/
    "CheckMyVoteOpType": 138,
    /*查看自己有没有投票*/
    "SelectDefinitionOpType": 160,
    /*查看演唱会可选的视频清晰度*/
    "ChangeDefinitionOpType": 162,
    /*改变演唱会视频的清晰度*/
    "ForbidChatOpType": 170,
    /*屏蔽聊天（除主播和管理员）*/
    "GetTicketUrlOpType": 164,
    /*演唱会购票地址*/
    "CheckDupNickOpType": 134,
    /*检查昵称重名*/
    "GetShowRoomGiftOpType": 167,
    /*抽奖展示接口*/
    "ShowRoomGiftLuckyOpType": 168,
    /*抽奖接口*/
    "GetDailyWageOpType": 150,
    /*领取每日工资*/
    "GetActCenterOpType": 151,
    /*获取活动中心信息*/
    "GetActRewardsOpType": 152,
    /*领取活动奖励*/
    "VOT_GetGuestInfo": 198,
    "ForBidGifts": 250,

    /*创建后援团请求*/
    "createGroup": 66,
    /*加载我的后援团*/
    "GetGroupInfo": 54,
    /*请求后援团成员列表*/
    "getGroupMember": 55,
    /*开除后援团成员*/
    "KickMember": 56,
    /*退出后援团*/
    "QuitGroup": 57,
    /*修改玩家的职位*/
    "ChangePosition": 58,
    /*后援团签到*/
    "SignGroup": 81,
    /*修改职位信息*/
    "UpdateGroupPosition": 59,
    /*加载后援团列表*/
    "GetGroup": 60,
    /*加载职位列表*/
    "getGroupPosition": 65,
    /*修改自己后援团公告*/
    "updateMygroupNotice": 103,
    /*修改自己后援团描述*/
    "updateMygroupDesc": 102,
    /*请求后援团申请审核列表*/
    "getGroupApply": 68,
    /*请求后援团申请审核请求*/
    "getGroupApplyRequest": 69,
    /*助威*/
    "SendCheer": 82,
    /*后援团申请审核拒绝设置请求*/
    "getGroupApplyRefuse": 94,
    /*获取后援团日志*/
    "GetGroupLog": 96,

    /*修改团名*/
    "RenameHead": 80,
    /*更改支持主播*/
    "ChangeAnchor": 75,
    /*团长传位*/
    "Demise": 63,
    /*取消团长传位*/
    "CancelDemise": 64,
    /*解散后援团*/
    "DismissGroup": 61,
    /*取消解散后援团*/
    "CancelDismissGroup": 62,
    /*获取玩家关注的主播列表*/
    "GetAnchorList": 118,
    /*获取成员列表(团长传位)*/
    "GetMemberList": 206,
    /*玩家获取申请入团回调信息*/
    "getPlayerApplyGroupRequest": 67,

    /*抢座*/
    "Grap": 230,
    /*抢VIP席位*/
    "GrapVIP": 276,
    /*抢VIP席位_零点提醒*/
    "GrapZero": 280,
    /*获取旗下 主播列表*/
    "GetZhuBoList": 219,
    /*抢红包*/
    "GrabRedPacketOpType": 252,
    /*红包信息*/
    "ShowRedPacketOpType": 253,
    /*获取主播等级榜*/
    "GetAnchorLevelRankOpType": 255,

    /*抢梦幻宝箱*/
    "GrabDreamBox": 282,
    /*查看抢梦幻宝箱记录*/
    "GetDreamBoxRecord": 283,
    /*申请游客账号*/
    "GoodFrendPay": 185,
    /*好友充值炫豆*/

    "HideFreeGift": 292
    /*屏蔽免费礼物*/
}; /*  |xGv00|371ac6ea4f3e2423b69fb8c9e772a4d2 */

/* 标识从哪里拉取的名片    
    0:未知    
    1:玩家列表     
    2:守护宝座    
    3:vip座位    
    4:超级粉丝榜    
    5:超级守护榜    
    6:聊天区    
    7:主播粉丝排名    
    8:后援团成员列表    
    9:自己的名片    
    10:送礼区    
    11:弹幕    
    12:vip进场特效    
    13:小窝房间捧场记录
    14：演唱会中奖纪录
    15：排行榜
*/
var card_source;
function setCardSource(source){
    card_source = source;
}