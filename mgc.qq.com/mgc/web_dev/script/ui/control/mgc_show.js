/**
 * Created by 77 on 2015/10/8.
 */
/**
 * Todo:1.处理直播房间tab、及列表操作
 */
define(['mgc_callcenter', 'mgc_show_view', 'mgc_tool'], function(callcenter, show_view, tool) {
    var common = {};
    var pages = 0; //记录当前是第几页
    var roomNum = 0;// 记录一页请求的数量
    var tagId = -1;
    /*
    获取自定义标签集合
    */
    common.getCustomTabListCallBack = function(resp, params) {
        console.log("获取自定义标签集合:" + JSON.stringify(resp));
        //初始化常驻tab选择
        resp.tags.splice(0, 0, { "tag_id": -3, "tag_name": "全部公会" }, { "tag_id": -1, "tag_name": "个人show" }, { "tag_id": -2, "tag_name": "新星主播" }, { "tag_id": -4, "tag_name": "手机直播" });
        //创建tab页视图
        var href = window.location.href;
        var _select = href.substring(href.indexOf("#") + 1);
        var default_select = parseInt(isNaN(_select) ? -3 : _select);
        var tab_coll = new mgc.show_coll.TabColl();
        tab_coll.reset(resp.tags);
        var page_tag_tab_view = new show_view.PageTagTabView(tab_coll, default_select, 8, select_change_callback);
        //下拉加载
        scroll_load_fun.scroll();
    }
    /*
    获取房间列表集合
    */
    var _tag = 0;
    var _category = 0;
    var _module_type = 1;
    var select_change_callback = function(_id, _pageindex, _el) {
        console.log("获取房间列表集合:" + _id + " ; pageindex:" + _pageindex);
        _category = 0;
        _tag = 0;
        var _counts_per_page = scroll_load_fun.data.pageNum;
        var _position = 1;
        tagId = -1;
        if (_id == -1) {
            _category = 9;
        } else if (_id == -2) {
            _category = 4;
        } else if (_id == -3) {
            _category = 11;
        } else if (_id == -4){
            _category = 15;
        }else {
            _category = 0;
            _tag = _id;
            tagId = _id;
        }
        scroll_load_fun.data.isSteep = false;
        scroll_load_fun.data.category = _category;
        scroll_load_fun.data.id = _id;
        scroll_load_fun.toggle(true);
        var tagPageIndex = parseInt($("#tag-" + _id).attr("pageindex"));
        if (tagPageIndex >= _pageindex) {
            _pageindex = tagPageIndex;
            for (var i = 1; i <= _pageindex; i++) {
                doInitRoomList(_category, _tag, i, _counts_per_page, _position, _module_type);
            }
        } else {
            doInitRoomList(_category, _tag, _pageindex, _counts_per_page, _position, _module_type);
        }
    }
    var doInitRoomList = function(_category, _tag, _pageindex, _counts_per_page, _position,_module_type) {
        var data = $("#RoomContainer").data("roomlist_" + _category + "_" + _tag + "_" + _pageindex);
        if (typeof data == "undefined") {
            roomNum = _counts_per_page;
            callcenter.query_video_room_list(_category, _pageindex, _counts_per_page, _tag, _position,_module_type,  1, video_room_list_callback, { pageIndex: _pageindex });
        } else {
            video_room_list_callback(data, { pageIndex: _pageindex });
        }
    }
    /*
    获取房间列表集合回调
    */
    var video_room_list_callback = function(resp, params) {
        console.log("获取房间列表集合回调:" + resp.rooms.length);
        if (resp.category != _category || resp.tag != _tag) {
            //如果拿到的房间列表与当前标签不符的情况下 杀！
            return;
        }
        var _str = "roomlist_" + resp.category + "_" + resp.tag + "_" + params.pageIndex;
        var data = $("#RoomContainer").data(_str);
        if (typeof data == "undefined") {
            $("#RoomContainer").data(_str, resp)
        }
        if (resp.rooms.length > 0) {
            var _roomList = resp.rooms;
            var module = tool.cookie("hotModule");//判断是模块1还是模块2
            for(var i=0, n=_roomList.length; i<n; i++){
                if(_roomList[i].module_type == -1){
                    _roomList[i].module_type = module;
                }
                _roomList[i].tag_id = tagId;
                _roomList[i].page_capacity = roomNum;
                _roomList[i].room_list_pos = roomNum * pages + i;
                _roomList[i].sub_level = (_roomList[i].week_star_sub_level + "").split("");
            }
            var room_item_coll = new mgc.show_coll.RoomItemColl();
            room_item_coll.reset_data(_roomList);
            var room_list_view = new show_view.RoomListView("#RoomContainer", room_item_coll, null);
            scroll_load_fun.toggle(false);
            scroll_load_fun.data.pageIndex = params.pageIndex;
            $("#tag-" + scroll_load_fun.data.id).attr("pageindex", params.pageIndex);
            var imgs = $("#RoomContainer .room-img img");
            for(var i=0,n=imgs.length; i<n; i++){
                var img = new Image();
                img.src = imgs[i].src;
                img._img = imgs[i];
                if(img.complete){
                    tool.adjustPics(img);
                } else{
                    img.onload = function(e){
                        tool.adjustPics(e==undefined?this: e.target);
                    }
                }
            }
        } else {
            scroll_load_fun.toggle(false, "已经没有直播了哦");
        }
        scroll_load_fun.data.isSteep = true;
        pages ++;
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
                    select_change_callback(scroll_load_fun.data.id, scroll_load_fun.data.pageIndex + 1);   
                }
            });
        }
    };
    return common;
});