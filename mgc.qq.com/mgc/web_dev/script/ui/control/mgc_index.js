/**
 * Created by 77 on 2015/10/8.
 */
/**
 * Todo:1.处理首页逻辑
 */
define(['mgc_callcenter', 'mgc_show_coll', 'mgc_show_view', 'mgc_index_coll', 'mgc_index_view', 'mgc_ranklist_coll', 'mgc_ranklist_view', 'mgc_tool', 'mgc_templates'], function(callcenter, show_coll, show_view, index_coll, index_view, ranklist_coll, ranklist_view, tool, templates) {
    var common = {};
    var pages = 0; //记录当前是第几页
    var roomNum = 0;// 记录一页请求的数量
    common.InitRanks = {
        tabArr: [{ "tag_id": 0, "tag_name": "日" }, { "tag_id": 1, "tag_name": "周" }, { "tag_id": 2, "tag_name": "月" }, { "tag_id": 3, "tag_name": "总" }],
        //初始化所有榜单
        Init: function() {
            //主播榜-星耀榜-时间维度tab
            common.InitRanks.InitRankTab(common.InitRanks.tabArr, 'start_top10', common.getStartTop10Rank);
        },
        //初始化排行榜时间维度tab
        InitRankTab: function(data, id, callback) {
            var tab_hover_coll = new show_coll.TabColl();
            tab_hover_coll.reset(data);
            new show_view.RankTabView(id, tab_hover_coll, 0, callback);
        },
        //初始化视图
        InitView: function(_id, _rankData, _max_len, _begin_index) {
            var rank_item_coll = new ranklist_coll.RankItemColl();
            rank_item_coll.reset_rank_list(_rankData, _max_len, _begin_index, true);
            var rank_list_view = new ranklist_view.RankContainerView(_id, rank_item_coll);
        }
    }
    //请求星耀榜top10
    common.getStartTop10Rank = function(timedimension) {
        var cacheData = $('#start_top10_container').data('showlist' + timedimension);
        if (typeof cacheData == 'undefined') {
            callcenter.query_anchor_xingyao_rank(timedimension, common.getStartTop10RankCallback);
        } else {
            common.getStartTop10RankCallback(cacheData);
        }
    }
    //请求星耀榜top10回调
    common.getStartTop10RankCallback = function(resp, params) {
        console.log("getStartTop10RankCallback:" + resp.timedimension);

        $('.ranking_con').find('.icon_card,.icon_card_img').off("mouseenter");
        $('.ranking_con').find('.icon_card,.icon_card_img').off("mouseleave");

        var _id = "start_top10";
        var _container = $("#" + _id + "_container");
        var _rankData = $.extend(true, [], resp.rank.anchorRank);
        if (_rankData.length > 0) {
            var _max_len = 10;//每页条数
            var _begin_index = 0;//当前开始序列
            if (typeof _container.data('showlist' + resp.timedimension) == 'undefined') {
                _container.data('showlist' + resp.timedimension, resp);//缓存
            }
            $.each(_rankData, function(i, o) {
                if (i >= 3) {
                    o._icon = o.order_change > 0 ? "up" : o.order_change == 0 ? "nor" : o.order_change < 0 ? "down" : "nor";
                } else {
                    o._icon = o.order_change > 0 ? "up1" : o.order_change == 0 ? "nor" : o.order_change < 0 ? "down" : "nor";
                }
                o._order_change = o.order_change == 0 ? "" : Math.abs(o.order_change);
            });
            //初始化view
            common.InitRanks.InitView(_id, _rankData, _max_len, _begin_index);
            //节日活动
            tool.ACT.DO_ACT();
        } else {
            _container.html('<div class="bg_none"><p class="bg_none_img"></p><p class="bg_none_txt">主播排队中，快去支持喜爱的主播吧</p></div>');
        }

        $('.ranking_con').find('.icon_card,.icon_card_img').on("mouseenter", function (e) {
            var mouse_enter_info = "e{clientX:" + e.clientX + ", clientY:" + e.clientY + ", pageX:" + e.pageX + ", pageY:" + e.pageY + ", offsetX:" + e.offsetX + ", offsetY:" + e.offsetY + "}"
              + "<br/>this.offset{offset.left:" + $(this).offset().left+ ", offset.top:" + $(this).offset().top + "}";//", pageXOffset:" + this.pageXOffset + ", pageYOffset:" + this.pageYOffset + "}";
            console.log("mouse_enter_info:" + mouse_enter_info);
            //alert(mouse_enter_info);                
            var z = 0;
            var x = 0, y = 0;
            if ($(this).hasClass('icon_card')) {
                z = 25;
            } else if ($(this).hasClass('icon_card_img')) {
                z = 63;
            }
            var parentName = $(this)[0].parentNode.parentNode.className;
            var parentTwoOrThreeName = $(this)[0].parentNode.parentNode.parentNode.className;
            var parentNameLive= $(this)[0].parentNode.className;
            var parentText = $(this)[0].parentNode.innerText.indexOf("直播中");

            if (parentText > 0) {
                if ((parentNameLive == "fourth" || parentNameLive == "fifth" || parentNameLive == "sixth" || parentNameLive == "seventh" || parentNameLive == "eighth" || parentNameLive == "ninth" || parentNameLive == "tenth") && ($(this).hasClass('icon_card_img'))) {
                    x += 65 - e.offsetX;
                    y += -15 - e.offsetY;
                } else if ((parentNameLive == "second" || parentNameLive == "third" || parentNameLive == "fourth" || parentNameLive == "fifth" || parentNameLive == "sixth" || parentNameLive == "seventh" || parentNameLive == "eighth" || parentNameLive == "ninth" || parentNameLive == "tenth") && ($(this).hasClass('icon_card'))) {
                    x += 165 - e.offsetX;
                    y += -15 - e.offsetY;
                } else if ((parentNameLive == "first") && ($(this).hasClass('icon_card_img'))) {
                    x += 45 - e.offsetX;
                    y += - e.offsetY;
                } else if ((parentNameLive == "first") && ($(this).hasClass('icon_card'))) {
                    x += 45 - e.offsetX;
                    y += -e.offsetY;
                } else if ((parentNameLive == "second" || parentNameLive == "third")&& ($(this).hasClass('icon_card_img'))) {
                    x += 33 - e.offsetX;
                    y += -5 - e.offsetY;
                }
            } else {
                if ((parentName == "fourth" || parentName == "fifth" || parentName == "sixth" || parentName == "fourth" || parentName == "fifth" || parentName == "sixth" || parentName == "seventh" || parentName == "eighth" || parentName == "ninth" || parentName == "tenth")&&($(this).hasClass('icon_card_img'))) {
                    x += 32 - e.offsetX;
                    y += -23 - e.offsetY;
                } else if ((parentTwoOrThreeName == "fourth" || parentTwoOrThreeName == "fifth" || parentTwoOrThreeName == "sixth" || parentTwoOrThreeName == "fourth" || parentTwoOrThreeName == "fifth" || parentTwoOrThreeName == "sixth" || parentTwoOrThreeName == "seventh" || parentTwoOrThreeName == "eighth" || parentTwoOrThreeName == "ninth" || parentTwoOrThreeName == "tenth") && ($(this).hasClass('icon_card'))) {
                    x += - e.offsetX;
                    y += -5- e.offsetY;
                } else if ((parentName == "second" || parentName == "third") && ($(this).hasClass('icon_card_img'))) {
                    x += 33 - e.offsetX;
                    y += -13 - e.offsetY;                                 
                } else if ((parentTwoOrThreeName == "second" || parentTwoOrThreeName == "third") && ($(this).hasClass('icon_card'))) {
                    x += - e.offsetX;
                    y += -5 - e.offsetY;                    
                } else {
                    if ((parentName == "first")&& ($(this).hasClass('icon_card_img'))) {
                        x += 40 - e.offsetX;
                        y += -e.offsetY;
                    } else if ((parentTwoOrThreeName == "first") && ($(this).hasClass('icon_card'))) {
                        x += - e.offsetX;
                        y += -5 - e.offsetY;
                    }
                }
            }
            var hostId = $(this).attr('hostId');
            window.mgc.common_contral.anchorTips.doShow(hostId, x, y + z, e);
        });
        $('.ranking_con').find('.icon_card,.icon_card_img').on("mouseleave", function (e) {
            window.mgc.common_contral.anchorTips.doHide();
        });

    }
    //快报
    common.quickAdCallBack = function(imgData, textData) {
        var quickText = {};
        quickText.QUICK_TEXT = imgData;
        var quinkImg = quickText.QUICK_TEXT.shift();
        if (imgData.length > 0) {
            $("#quick_href").attr('href', quinkImg["sAdUrl"]);
            $("#quick_href").attr('title', quinkImg["sDesc"]);
            $("#quick_img").attr('src', quinkImg["sImageUrl"]);
            var HotPhotoBoardListCon = $('#quickContainerTmpl');
            var HotPhotoBoardListTmpl;
            var HotPhotoBoardListContainer = $('#quickContainer');
            HotPhotoBoardListContainer.children().remove();
            HotPhotoBoardListTmpl = HotPhotoBoardListCon.tmpl(quickText);
            HotPhotoBoardListTmpl.appendTo(HotPhotoBoardListContainer);
            $('#yuliuad').children().remove();
            var ad_coll = new index_coll.AdColl();
            ad_coll.reset(textData.YULIU);
            for (var i = 0; i < textData.YULIU.length; i++) {
                var ad_view = new index_view.AdView({ model: ad_coll.models[i] });
                $('#yuliuad').append(ad_view.render().el);
            }
            HotPhotoBoardListTmpl = null;
            HotPhotoBoardListCon = null;
        }
    };
    /*
    热门推荐房间列表回调
    */
    common.getHotRoomListCallBack = function(resp, params) {
        console.log("get hot room list:" + JSON.stringify(resp.rooms));
        var _roomList = resp.rooms;
        var module = tool.cookie("hotModule");//判断是模块1还是模块2
        for(var i=0, n=_roomList.length; i<n; i++){
            if(_roomList[i].module_type == -1){
                _roomList[i].module_type = module;
            }
            _roomList[i].page_capacity = 30;
            _roomList[i].room_list_pos = 30 * mgc.hotRoomPage + i;
            _roomList[i].sub_level = (_roomList[i].week_star_sub_level + "").split("");
            _roomList[i].tag_id = -1;
        }
        mgc.hotRoomPage ++;
        var _totleCount = parseInt(resp.totalCount);
        var _superRoom = new Array();
        var _normalRoom = new Array();
        var _superRoomTemp = 0;

        if (resp.ret == 0) {
            //先特殊处理
            $.each(_roomList, function(k, v) {
                if(resp.super_module_room_count != 0){
                    if(k == 0){
                        ++_superRoomTemp;
                        _superRoom.push(v);
                    }else{
                        _normalRoom.push(v);
                    }
                }else{
                    _normalRoom.push(v);
                }
            });
            if(_superRoomTemp == 0){
                var _caslRoom = _normalRoom.slice(0, 4);
            } else {
                var _caslRoom = _superRoom;
            }

            for (var i = 0; i < _caslRoom.length; i++) {
                _caslRoom[i].small_anchor_posing_url = _caslRoom[i].large_anchor_posing_url;
                // 区分是大图还是小图，大/小 图使用中秋节月饼徽章 大/小 图图标
                _caslRoom[i].is_big_badge = 1;
            }
            var big_room_item_coll = new show_coll.RoomItemColl();
            big_room_item_coll.reset_data(_caslRoom);
            $("#SlideHotRoomListContainer").children().remove();
            var big_room_list_view = new show_view.RoomListView("#SlideHotRoomListContainer", big_room_item_coll, null);
            var imgs = $("#SlideHotRoomListContainer .room-img img");
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
            if (_superRoomTemp == 0) {
                var _caslRoom2 = _normalRoom.slice(4, _totleCount);
            } else {
                var _caslRoom2 = _normalRoom.slice(0, 8);
            }

            for (var i = 0; i < _caslRoom2.length; i++) {
                // 区分是大图还是小图，大/小 图使用中秋节月饼徽章 大/小 图图标
                _caslRoom2[i].is_big_badge = 2;
            }
            var small_room_item_coll = new show_coll.RoomItemColl();
            small_room_item_coll.reset_data(_caslRoom2);
            $("#FixedHotRoomListContainer").children().remove();
            var small_room_list_view = new show_view.RoomListView("#FixedHotRoomListContainer", small_room_item_coll, null);
            var imgs = $("#FixedHotRoomListContainer .room-img img");
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
            //处理轮播
            if (_caslRoom.length > 1) {
                $("#SlideHotCarousel").show();
                var _carouseHtml = '';
                for (var i = 0, j = _caslRoom.length; i < j; i++) {
                    if (i == 0) {
                        _carouseHtml += '<span></span>';
                    } else {
                        _carouseHtml += '<span></span>';
                    }
                }
                $("#SlideHotCarousel").html(_carouseHtml);
            } else {
                $("#SlideHotRoomListContainer").css("left", "0");
                $("#SlideHotCarousel").hide();
            }
            tool.carousel("HotCarousel", "room-li-s", "rc-btn", 358, 5000, "left");
            if (MgcAPI.SNSBrowser.IsQQGame() || MgcAPI.SNSBrowser.IsX52()) {
                $('#pop_hot_lodding').hide();
                $("#overlay_loading").hide();
            }
        } else {
            if (MgcAPI.SNSBrowser.IsQQGame() || MgcAPI.SNSBrowser.IsX52()) {
                $('#pop_hot_lodding').hide();
                $('#pop_hot_lodding_error').show();
                $('#pop_hot_lodding_error #refreshBtn').unbind('click').bind('click', function() {
                    $('#pop_hot_lodding_error').hide();
                    $("#overlay_loading").hide();
                    location.reload();
                });
            }

        }
    }
    /*
     *手机直播列表回调
     */
    common.getMobileLiveList = function(resp, params){
        console.log("get mobile room list:" + resp.rooms.length);
        var _roomList = resp.rooms;
        var module = tool.cookie("hotModule");//判断是模块1还是模块2
        for(var i=0, n=_roomList.length; i<n; i++){
            if(_roomList[i].module_type == -1){
                _roomList[i].module_type = module;
            }
            _roomList[i].page_capacity = 30;
            _roomList[i].room_list_pos = 30 * mgc.mobilePage + i;
            _roomList[i].sub_level = (_roomList[i].week_star_sub_level + "").split("");
            _roomList[i].tag_id = -1;
        }
        mgc.mobilePage ++;
        var _totleCount = parseInt(resp.totalCount);
        var _caslRoom = _roomList.slice(0, 8);
        for (var i = 0; i < _caslRoom.length; i++) {
            _caslRoom[i].is_big_badge = 0;
        }
        
        var pop_room_item_coll = new show_coll.RoomItemColl();
        Array.prototype.push.apply(common.totalRoomList, _roomList);
        common.ghflag = true;
        pop_room_item_coll.reset_data(_caslRoom);
        $("#MobileRoomListContainer").children().remove();
        var pop_room_list_view = new show_view.RoomListView("#MobileRoomListContainer", pop_room_item_coll, null);
        var imgs = $("#MobileRoomListContainer .room-img img");
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
        common.RoomRequertCallBack();
    }
    /*
    人气公会房间列表回调
    */
    common.getPopRoomListCallBack = function(resp, params) {
        console.log("get pop room list:" + resp.rooms.length);
        var _roomList = resp.rooms;
        var module = tool.cookie("hotModule");//判断是模块1还是模块2
        for(var i=0, n=_roomList.length; i<n; i++){
            if(_roomList[i].module_type == -1){
                _roomList[i].module_type = module;
            }
            _roomList[i].page_capacity = 30;
            _roomList[i].room_list_pos = 30 * mgc.popRoomPage + i;
            _roomList[i].sub_level = (_roomList[i].week_star_sub_level + "").split("");
            _roomList[i].tag_id = -1;
        }
        mgc.popRoomPage ++;
        var _totleCount = parseInt(resp.totalCount);
        var _caslRoom = _roomList.slice(0, 8);
        for (var i = 0; i < _caslRoom.length; i++) {
            _caslRoom[i].is_big_badge = 0;
        }
        var pop_room_item_coll = new show_coll.RoomItemColl();
        Array.prototype.push.apply(common.totalRoomList, _roomList);
        common.ghflag = true;
        pop_room_item_coll.reset_data(_caslRoom);
        $("#PopularityRoomListContainer").children().remove();
        var pop_room_list_view = new show_view.RoomListView("#PopularityRoomListContainer", pop_room_item_coll, null);
        var imgs = $("#PopularityRoomListContainer .room-img img");
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
        common.RoomRequertCallBack();
    }
    /*
    新星主播房间列表回调
    */
    common.getNewStarRoomListCallBack = function(resp, params) {
        console.log("get new star room list:" + resp.rooms.length);
        var _roomList = resp.rooms;
        var module = tool.cookie("hotModule");//判断是模块1还是模块2
        for(var i=0, n=_roomList.length; i<n; i++){
            if(_roomList[i].module_type == -1){
                _roomList[i].module_type = module;
            }
            _roomList[i].page_capacity = 30;
            _roomList[i].room_list_pos = 30 * mgc.newstarRoomPage + i;
            _roomList[i].sub_level = (_roomList[i].week_star_sub_level + "").split("");
            _roomList[i].tag_id = -1;
        }
        mgc.newstarRoomPage ++;
        var _totleCount = parseInt(resp.totalCount);
        var _caslRoom = _roomList.slice(0, 8);
        for (var i = 0; i < _caslRoom.length; i++) {
            _caslRoom[i].is_big_badge = 0;
        }
        var newstar_room_item_coll = new show_coll.RoomItemColl();
        Array.prototype.push.apply(common.totalRoomList, _roomList);
        common.xxflag = true;
        newstar_room_item_coll.reset_data(_caslRoom);
        $("#StarRoomListContainer").children().remove();
        var newstar_room_list_view = new show_view.RoomListView("#StarRoomListContainer", newstar_room_item_coll, null);
        var imgs = $("#StarRoomListContainer .room-img img");
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
        common.RoomRequertCallBack();
    }
    /*
    娱乐表演房间列表回调
    */
    /*
    自定义标签
    */
    common.getCustomTabListCallBack = function(resp, params) {
        console.log("getCustomTabListCallBack:" + JSON.stringify(resp));
        //创建tab页视图
        if (resp.tags && resp.tags.length > 0) {
            var default_select = resp.tags[0].tag_id;
            var tab_coll = new show_coll.TabColl();
            tab_coll.reset(resp.tags);
            var page_tag_tab_view = new show_view.PageTagTabView(tab_coll, default_select, 7, select_change_callback);
        }
    }
    common.goodFriendArr = {}
    /*
    *好友充值提醒回调
    */
    common.goodFriendPayCallBack = function(responseStr) {
        console.log("好友充值回调_repStr:" + responseStr);
        if (!(mgc.account.checkGuestStatus(true))) {
            var _repStr = responseStr;
            if (typeof (_repStr.friendpay) == 'undefined') {
                common.goodFriendArr = _repStr;
            } else {
                common.goodFriendArr = _repStr.friendpay;
            }
            if (common.goodFriendArr.length > 0) {
                //填充第一个数据，弹窗，删除第一个数据
                common.goodFriendPaypop();
            }
        }
    }
    common.goodFriendHas = function() {
        if (common.goodFriendArr.length > 0) {
            common.goodFriendPayCallBack(common.goodFriendArr);
        }
    }
    common.goodFriendPaypop = function() {
        //填充第一个数据，弹窗，删除第一个数据            
        var obj = common.goodFriendArr[0];
        var con = $('#goodFriendPayTmpl');
        var tmpl;
        var container = $('#goodFriendPayContainer');
        container.children().remove();
        tmpl = con.tmpl(obj);
        tmpl.appendTo(container);
        common.goodFriendArr.shift();
        window.mgc.popmanager.layerControlShow($('#goodFriendPay'), 5, 1);
        $('#confirmBtn2,#closeBtn2').unbind('click').bind('click', function() {
            window.mgc.popmanager.layerControlHide($('#goodFriendPay'), 5, 1);
            common.goodFriendHas();
        });
        con = null;
        tmpl = null;
    }

    /*首页引导调用公共方法*/
    common.RoomRequertCallBack = function() {
        if (common.ghflag == true && common.xxflag == true && common.ylflag == true) {
            common.flag = true;
            if (common.flag && (common.totalRoomList.length > 0)) {
                common.checkIsFirstLoginCallBack2();
            }
        }
    }
    common.ghflag = false;
    common.xxflag = false;
    common.ylflag = false;
    common.flag = false;
    common.totalRoomList = [];
    common.arrRoomOn = [];
    common.arrRoom = [];
    //*检查是否首页首次引导-回调
    common.checkIsFirstLoginCallBack2 = function(obj) {
        var cookieIndexValue = '1024';
        var href = '';
        var getUIN = false;
        if (mgc.account.getUin() != null && mgc.account.getUin() != "" && mgc.account.getUin() != 'undefined') {
            getUIN = true;
        } else {
            getUIN = false;
        }
        common.randomRoom();
        if (typeof (obj) == 'undefined') {
            if ((tool.cookie("mgc_indexGuide_" + obj + "_") == cookieIndexValue) || getUIN) {
                return;
            }

            if (tool.is_home_page()) {

                console.log("首页引导弹窗：" + JSON.stringify(obj));
                //随机一个房间 :MGCData.totalRoomList                
                window.mgc.popmanager.layerControlShow($("#pop_guide"), 4, 1);
                $('#guideBtn_room_a').off('click').on('click', function() {
                    window.mgc.popmanager.layerControlHide($('#pop_guide'), 4, 1);
                });
                //非首登状态下 - 立即判断签到状态                  

                //只弹出一次  记录cookie

                tool.cookie("mgc_indexGuide_" + obj + "_", cookieIndexValue, {
                    expires: 24 * 60 * 60 * 1000,
                    path: '/',
                    domain: '.qq.com'
                });

            }

        }
    },
    //新手礼包领取成功以后N分钟后显示引导
    common.indexRoomGuideCallBack = function() {
        common.randomRoom('#index_newPlayer_enter');

    },
    //随机房间--除去热门推荐的首页房间列表（个人直播间和公会房间）
    common.randomRoom = function() {

        $.each(common.totalRoomList, function(k, v) {
            if (!v.bSuperRoom) {
                if (v.status == 2) {
                    common.arrRoomOn.push(v);
                } else if (v.status == 1) {
                    common.arrRoom.push(v);
                }
            }

        });
        if (common.arrRoomOn.length > 0) {
            var arrRoomOnLength = common.arrRoomOn.length;
            var arrRoomOnLengthNum = 0;
            arrRoomOnLengthNum = Math.floor(Math.random() * arrRoomOnLength + 1);
            common.arrRoomOn[arrRoomOnLengthNum];
            if (arrRoomOnLength == 1 && arrRoomOnLengthNum == 1) {
                arrRoomOnLengthNum = arrRoomOnLengthNum - 1;
            }
            if (common.arrRoomOn[arrRoomOnLengthNum].isNest) {
                href = "caveolaeroom.shtml?roomId=" + common.arrRoomOn[arrRoomOnLengthNum].roomID + "&source=5"
            } else if (!(common.arrRoomOn[arrRoomOnLengthNum].isNest)) {
                href = "liveroom.shtml?roomId=" + common.arrRoomOn[arrRoomOnLengthNum].roomID + "&source=5"
            }
        } else if (common.arrRoom.length > 0) {
            var arrRoomLength = common.arrRoom.length;
            var arrRoomLengthNum = 0;
            arrRoomLengthNum = Math.floor(Math.random() * arrRoomLength + 1);
            common.arrRoom[arrRoomLengthNum];
            if (arrRoomLength == 1 && arrRoomLengthNum == 1) {
                arrRoomLengthNum = arrRoomLengthNum - 1;
            }
            if (common.arrRoom[arrRoomLengthNum].isNest) {
                href = "caveolaeroom.shtml?roomId=" + common.arrRoom[arrRoomLengthNum].roomID + "&source=5"
            } else if (!(common.arrRoom[arrRoomLengthNum].isNest)) {
                href = "liveroom.shtml?roomId=" + common.arrRoom[arrRoomLengthNum].roomID + "&source=5"
            }
        }
        $('#index_newPlayer_enter,#guideBtn_room').attr('href', href);
    },
    /**
     * 首页演唱会回放模块配置的第一张图片
     * total_cnt 房间总数量
     * rooms [Object] 房间列表 concert_id,concert_name,preview_pic,accumulate_watch
     */
    common.playCallbackFirstImg = function(resp, params){
        console.log("演唱会回放配置的第一张图片" + JSON.stringify(resp));
        var url = resp.rooms.length > 0 ? resp.rooms[0].preview_pic : "http://ossweb-img.qq.com/images/mgc/css_img/common/mgc_auto.png?v=3_8_8_2016_15_4_final_3";

        $("#playback-img").attr("src", url);      
        
        // 调整图片大小
        var firstImg = $("#playback-img");
        var img = new Image();
        img.src = url;
        img._img = firstImg;

        $(img).error(function(){
            $(this).attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/common/mgc_auto.png?v=3_8_8_2016_15_4_final_3");
            $(this._img).attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/common/mgc_auto.png?v=3_8_8_2016_15_4_final_3");
            tool.adjustPics(img);
        });
        if(img.complete){
            mgc.tools.adjustPics(img);
        } else{
            img.onload = function(e){
                mgc.tools.adjustPics(e==undefined?this: e.target);
            }
        }
    }
    /*
    tab切换：room lis 请求
    */
    var select_change_callback = function(_id, _pageindex) {
        console.log("callback selected:" + _id + " ; pageindex:" + _pageindex);
        roomNum = 30;
        callcenter.query_video_room_list(0, 1, 8, _id, mgc.tools.is_home_page(), 1, 1, video_room_list_callback);
    }
    /*
    room list 回调
    */
    var video_room_list_callback = function(resp, params) {
        console.log("get yule room list:" + resp.rooms.length);
        var _roomList = resp.rooms;
        var module = tool.cookie("hotModule");//判断是模块1还是模块2
        for(var i=0, n=_roomList.length; i<n; i++){
            if(_roomList[i].module_type == -1){
                _roomList[i].module_type = module;
            }
            _roomList[i].page_capacity = roomNum;
            _roomList[i].room_list_pos = roomNum * pages + i;
            _roomList[i].sub_level = (_roomList[i].week_star_sub_level + "").split("");
            _roomList[i].tag_id = -1;
        }
        var _totleCount = parseInt(resp.totalCount);
        var _caslRoom = _roomList.slice(0, 8);
        var room_item_coll = new show_coll.RoomItemColl();
        $.each(_roomList, function (k, v) {
            v.is_big_badge = 2;
        })
        Array.prototype.push.apply(common.totalRoomList, _roomList);
        common.ylflag = true;
        room_item_coll.reset_data(_roomList);
        $("#YuleRoomListContainer").children().remove();
        var room_list_view = new show_view.RoomListView("#YuleRoomListContainer", room_item_coll, null);
        var imgs = $("#YuleRoomListContainer .room-img img");
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
        common.RoomRequertCallBack();
        pages ++;
    }
    callcenter.addRespListener(callcenter.OP_TYPE.GET_GOOD_FRIEND_PAY, common.goodFriendPayCallBack);
    return common;
});