/*
 * Created by zerochen on 2015/6/30.
 * 提供直播房间的信息
 * op_type :操作类型
 * 12 进入房间
 * 30 刷新房间信息（无请求，主动回调）
 * 13 退出房间
 * 14 主动请求主播名片
 * 27 嘉宾席（无请求，主动回调）
 * 28 超级粉丝（0）和守护（1）
 * 23 热门推荐
 * 15 在线玩家（最多100，有分页信息）
 * 118 加载关注的主播
 *
 */

var DoTransfer = function() {
    var roomId = MGC_Comm.getUrlParam('roomId');
    MGC_Comm.commonGetUin(function (_uin) {
        if (_uin != null && _uin.length > 0) {
            MGC_CommRequest.checkRoomStatus(roomId);
        }
        else {
            MGC_Comm.isTransferRequest = true;
            MGC_Comm.DoLoginFirst()
        }
    });
}

//本页需要回调加载的功能
var loginCallBack = function() {
    DoTransfer();
}
/*  |xGv00|055a674e74129a71e5a1bea27378ce9c */
