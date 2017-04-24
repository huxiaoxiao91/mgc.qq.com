/**
 * 公会直播间
 * Created by WangJian on 2015/11/18.
 */

define(['backbone', 'jquery', 'mgc_room_view','mgc_network','mgc_toos'], function (Backbone,$,room_view,network) {

    var o = {};

    //视频view
    o.videoView = null;

    o.init = function(){
        network.listenToBroadcastMsg(o.broadcast);
        o.videoView = new room_view.VideoView({id:"LiveVideoSwfContainer"});
    };

    o.broadcast = function(jsonstr, params){
        o.videoView.broadcast(jsonstr);
    };

    return o;
});