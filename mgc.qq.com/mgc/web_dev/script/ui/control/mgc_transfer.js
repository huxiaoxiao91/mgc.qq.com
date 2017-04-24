/**
 * Created by 77 on 2015/10/8.
 */
/**
 * Todo:1.处理直播房间tab、及列表操作
 */
define(['mgc_callcenter', 'mgc_show_view', 'mgc_tool', 'mgc_consts', 'mgc_network', 'mgc_dialog'], function(callcenter, show_view, tools, consts, network, mgc_dialog) {
    var common = {};
    /**
     * 检查房间状态 回调
     * @param roomid        房间id
     * @param callback
     */
    common.checkRoomStatusCallBack = function(resp, params) {
        console.log("check room status callback");
        if (resp.result == 0 || (resp.result == 59 && resp.isNestRoom)) { //可以进入(小窝房间未直播状态也是可以进入的)
            var source = parseInt(tools.getUrlParam('source'), 10);
            source = source >= 0 ? source : 0;
            var _url = "";
            if (resp.isSuperRoom) {
                _url = consts.url.SHOW_ROOM + "?roomId=" + resp.roomId + "&source=" + source + "&tag_id=-1&module_type=0&page_capacity=30&room_list_pos=0";
            } else if (resp.isNestRoom) {
                if (resp.skinId && resp.skinId != 0 && resp.skinLevel > 0) {
                    _url = consts.url.NEST_ROOM + "?roomId=" + resp.roomId + "&source=" + source + "&tag_id=-1&skin_id=" + resp.skinId + "&skin_level=" + resp.skinLevel + "&module_type=0&page_capacity=30&room_list_pos=0";
                } else {
                    _url = consts.url.CAVEOLAE_ROOM + "?roomId=" + resp.roomId + "&source=" + source + "&tag_id=-1&skin_id=" + resp.skinId + "&skin_level=" + resp.skinLevel + "&module_type=0&page_capacity=30&room_list_pos=0";
                }
                if (resp.isPK) {
                    _url += "&is_pk=" + resp.isPK;
                }
            } else {
                _url = consts.url.LIVE_ROOM + "?roomId=" + resp.roomId + "&source=" + source + "&tag_id=-1&module_type=0&page_capacity=30&room_list_pos=0";
            }
            window.location.href = window.mgc.tools.changeUrlToLivearea(_url);
        } else {
            var msg = '';
            switch (resp.result) {
                case 1:
                    msg = '进入房间:未知错误';
                    break;
                case 2:
                    msg = '进入房间错误';
                    break;
                case 3:
                    msg = '服务器忙';
                    break;
                case 11:
                    msg = '对不起，您没有权限';
                    break;
                case 12:
                    msg = '这个房间不存在';
                    break;
                case 17:
                    msg = '您被暂时禁止进入';
                    break;
                case 22:
                    msg = '视频区网路错误';
                    break;
                case 24:
                    msg = '对不起，无法进入主播专用房间';
                    break;
                case 28:
                    msg = '对不起，该房间已封，无法进入';
                    break;
                case 35:
                    msg = '操作频繁，请稍后再试';
                    break;
                case 36:
                    msg = '当前房间内人太多，挤房失败了';
                    break;
                case 41:
                    msg = '视频服务器已关闭';
                    break;
                case 47:
                    msg = '这个房间已经关闭了';
                    break;
                case 50:
                    msg = '当前房间内人太多，挤房失败了';
                    break;
                case 51:
                    msg = '房间人满。如果拥有贵族身份，或者成为当前主播的天使守护及以上，可以优先的进入人满房间哦~<br>今日剩余挤房次数：-';
                    break;
                case 53:
                    msg = '这个房间已经被关闭了';
                    break;
                case 55:
                    msg = '对不起，由于现在进入房间的人数太多，导致服务器压力过大，请稍后再试';
                    break;
                case 56:
                    msg = '您现在没有门票，快去购票吧！购买成功后，需要重新进入演唱会房间才可以观看。';
                    break;
                case 57:
                    msg = '对不起，没有这个房间。';
                    break;
                case 58:
                    msg = '对不起，没有这个房间。';
                    break;
                case 59:
                    msg = '当前房间没有直播内容，精彩内容稍后上演。';
                    break;
                case 60:
                    msg = '对不起，没有这个房间。';
                    break;
                case 61:
                    msg = 'WEB端不能进入音频房间。';
                    break;
                default:
                    msg = '未知错误';
            }
            $(".pop_loading").hide();
            tools.commonDialog({
                "Title": "提示",
                "Note": msg,
                "BtnName": "确定",
                "BtnNum": 1
            }, function() {
                window.location.href = consts.url.HOME;
            });
        }
    };

    return common;
});