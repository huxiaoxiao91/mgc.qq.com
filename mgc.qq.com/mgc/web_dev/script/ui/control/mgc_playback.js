/**
 * Created by 77 on 2015/10/8.
 */
/**
 * Todo:1.处理直播房间tab、及列表操作
 */
define(['mgc_callcenter', 'mgc_show_view', 'mgc_tool'], function(callcenter, show_view, tool) {
    var playback = {};
    var playbackPageIndex = 1;//演唱会回放第几页
    var currentAnchorName ;//当前点击的演唱会回放列表title
    var isCloseBtn = false; //是否是弹出框的确定和关闭按钮
    var currentIndex = 0; //判断房间索引从哪个位置开始请求
    
    var testData = [];
    var testPageIndex = 0;

    /**
     * 获取演唱会回放房间列表结果
     * @total_cnt  {[Int]}      房间总数量
     * @rooms      {[Array]}    房间列表 {concert_id,concert_name,preview_pic,accumulate_watch}
     */
    playback.concertPlaybackRoomGetRoomlistRes = function(resp, params){
        console.log("演唱会回放列表：" + JSON.stringify(resp));
        if(resp.rooms.length == 0){
            return;
        }
        var _str = "roomlist_00_0_" + playbackPageIndex;
        $("#RoomContainer").addClass("show-playback");
        var data = $("#RoomContainer").data(_str);
        if (typeof data == "undefined") {
            $("#RoomContainer").data(_str, resp)
        }
        $("#RoomContainer").addClass("playback-list");
        var room_item_coll = new mgc.show_coll.CallbackRoomItemColl();
        room_item_coll.reset_data(resp.rooms);
        var room_list_view = new show_view.RoomListView("#RoomContainer", room_item_coll, "#PlaybackListTmpl", null);
        scroll_load_fun.toggle(false);
        // 下次请求的 index
        currentIndex += resp.rooms.length;
        // $("#tag-" + scroll_load_fun.data.id).attr("pageindex", params.pageIndex);
        var imgs = $("#RoomContainer .room-img img");
        for(var i=0,n=imgs.length; i<n; i++){
            var img = new Image();
            img.src = imgs[i].src;
            img._img = imgs[i];

            $(img).error(function(){
                $(this).attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/common/mgc_auto.png?v=3_8_8_2016_15_4_final_3");
                $(this._img).attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/common/mgc_auto.png?v=3_8_8_2016_15_4_final_3");
                tool.adjustPics(img);
            });

            if(img.complete){
                tool.adjustPics(img);
            } else{
                img.onload = function(e){
                    tool.adjustPics(e==undefined?this: e.target);
                }
            }
        }
        
        scroll_load_fun.data.isSteep = true;
        $('#RoomContainer').find('a').removeAttr('href','onclick');
        $('#RoomContainer').find('a').bind('click',function(e){
            //发送请求，判断视频是否过期
            var roomId = $(this).attr("roomId");
            currentAnchorName = $(this).attr("anchorName");
            callcenter.start_concert_playback(roomId, playback.startConcetPlaybackRes);
        });

        //下拉加载
        scroll_load_fun.scroll();
        
    }

    /**
     * 开始观看演唱会回放结果事件
     * @error_code  {[Int]}         错误码
     * @concert_id  {[Int]}         演唱会id
     * @video_url   {[String]}      视频地址
     */
    playback.startConcetPlaybackRes = function(resp, params){
        console.log("开始观看演唱会回放结果事件：" + JSON.stringify(resp));
        isCloseBtn = false;
        if(resp.error_code == 1){//过期，提示框
            isCloseBtn = true;
            mgc.tools.commonDialog({ "Title": "提示信息", "Note": "该场演唱会已经失效了哦~去看看别的演唱会吧~" }, playback.sendRequestRoomlist, playback.sendRequestRoomlist);
            return;
        } else if(resp.error_code == 2){
            return;
        }
        $("#iframeBox .playback-title").html(currentAnchorName);
        // 演唱会回放窗口打开播放
        $("#iframeURL").attr("src", resp.video_url); //resp.video_url
        $("#iframeBox").show();
        var h = parseInt($('#iframeBox .playback-title').css("height")) + parseInt($('#iframeBox iframe').css("height")) + 1;
        $('#iframeBox').css("height", h);
        $('#iframeBox').centerDisp();
        window.mgc.popmanager.layerControlShow($("#iframeBox"), 5, 1);
        // 关闭弹窗
        $('#iframeBox').find('.pop_close').bind('click',function(){
            $("#iframeURL").attr("src", "");
            $("#iframeBox").hide();
            window.mgc.popmanager.layerControlHide($("#iframeBox"), 5, 1);
        });
    }
    // 刷新演唱会回放页面
    playback.sendRequestRoomlist = function(){
        $("#RoomContainer").children().remove();
        playbackPageIndex = 1;
        currentIndex = 0;
        setTimeout(function(){
            callcenter.concert_playback_room_get_roomlist(currentIndex, 30, playback.concertPlaybackRoomGetRoomlistRes);
            isCloseBtn = false;
        },1);
        
    }

    /*
    * 下拉加载提示
    */
    var scroll_load_fun = {
        data: {
            category: 0,
            id: 0,
            pageNum: 30,
            pageIndex: 1,
            isSteep: false
        },
        toggle: function(isShow, msg) {
            if (isShow) {
                $(".scroll-load").removeClass("hide").html('<img alt="loading" src="http://ossweb-img.qq.com/images/mgc/css_img/common/loading_normal.gif?v=3_8_8_2016_15_4_final_3" />');
            } else {
                if (msg) {
                    $(".scroll-load").html("<i>" + msg + "</i>");
                } else {
                    $(".scroll-load").addClass("hide");
                }
            }
        },
        scroll: function() {
            $(window).scroll(function() {
                if (!scroll_load_fun.data.isSteep)
                    return;
                var scrollTop = $(this).scrollTop();
                var scrollHeight = $(document).height();
                var windowHeight = $(this).height();
                if (scrollTop + windowHeight == scrollHeight) {
                    if(!isCloseBtn){
                        callcenter.concert_playback_room_get_roomlist(currentIndex, 30, playback.concertPlaybackRoomGetRoomlistRes);
                        ++playbackPageIndex;
                    } else{
                        playbackPageIndex = 1;
                        currentIndex = 0;
                    }
                }
            });
        }
    };
    window.mgc.playback = playback;
    return playback;
});