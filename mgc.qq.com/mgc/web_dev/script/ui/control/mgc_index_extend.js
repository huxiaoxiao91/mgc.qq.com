/*
*首页逻辑扩展
*/
//qgame特有：获取urlparam中的roomid 如果url中携带param参数，则为引流到相应页面 
//http://qgame.mgc.qq.com?param=RoomId-123 指定房间
//http://qgame.mgc.qq.com?param=TagId-1 指定娱乐表演页签
//&param=RoomId-110  引流进入110房间
//&param=TagId-10     引流进入娱乐表演页面 tagid为10的页签下
//x52 http://xw2.mgc.qq.com/?userName=%E3%83%A1%E5%A4%99%E9%A3%8F%E5%A2%A8&gender=1&qq=39343663&key=3d707acbbece3ff9b893d3b7fa932c1b|39343663|3178978468827410479|1|1476675864&zoneid=3105&param=RoomId-100001
var param = STATIC_RESOURCE.getUrlParam("param");
if (param && param != "") {
    if (param == "true") {
        // MgcAPI.SNSBrowser.IsQQGameLiveArea = true;
        var roomtype = STATIC_RESOURCE.getUrlParam("room_type");
        var roomId = STATIC_RESOURCE.getUrlParam("room_id");
        // roomType : 0 公会 2 小窝 3 演唱会
        if (roomtype == 0) {
            window.location.href = "liveroom.shtml?roomId=" + roomId + "&param=true";
        } else if (roomtype == 2) {
            var roomSkinId = STATIC_RESOURCE.getUrlParam("skin_id");
            if (roomSkinId == 0) {
                window.location.href = "caveolaeroom.shtml?roomId=" + roomId + "&skin_id=0&skin_level=0&param=true";
            } else {
                var roomSkinLeve = STATIC_RESOURCE.getUrlParam("skin_level");
                window.location.href = "nest.shtml?roomId=" + roomId + "&skin_id=" + roomSkinId + "&skin_level=" + roomSkinLeve + "&param=true";
            }
        } else if (roomtype == 3) {
            window.location.href = "showroom.shtml?roomId=" + roomId + "&param=true";
        }
    } else {
        var _params = "";
        if (MgcAPI.SNSBrowser.IsX52()) {
            _params = window.location.href.slice(window.location.href.indexOf('?') + 1);
        }
        var params = param.split('-');
        if (params.length >= 2) {
            params[1] = params.length == 2 ? params[1] : ("-" + params[2]);
            if (params[0] == "RoomId") {            //引流进入指定房间
                window.location.href = "transfer.shtml?" + _params + "&roomId=" + params[1] + "&source=3";
            } else if (params[0] == "TagId") {      //引流进入指定标签下的房间列表页
                window.location.href = "show.shtml" + _params + "#" + params[1];
            }
        }
    }
}