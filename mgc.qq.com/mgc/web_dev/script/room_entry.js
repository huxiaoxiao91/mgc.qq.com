/**
 * Created by Shixinqi on 2015/11/11.
 */
define(['jqtmpl', 'mgc_consts', 'mgc_login', 'mgc_account', 'mgc_callcenter', 'mgc_skin', 'mgc_comm_view', 'mgc_show_view', 'mgc_comm', 'mgc_tool', 'swfobject', 'mgc_popmanager', 'js_scrollpane', 'js_mousewheel', 'mgc_config', 'mgc_secret_order', 'mgc_last_king'], function (jqtmpl, consts, login, account, callcenter, mgc_skin, comm_view, show_view, mgc_comm, tool, swfobject, mgc_popmanager, js_scrollpane, js_mousewheel, config, secret_order, last_king) {
    var comm = {};

    //针对QGame注册事件:变更链接跳转方式
    tool.changeLinkTo();
    if (MgcAPI.SNSBrowser.IsQQGameLiveArea() != "true") {
        $(".header").css("left", "0");
        $(".side-left").css("display", "block");
        $(".side-hot").css("display", "block");
        $(".side-footer").css("display", "block");
    }
    var loginCallback = null;
    //TAB页加载，默认选中xxTab页
    var tab_coll = new mgc.show_coll.TabColl();
    
    function findRoomId(){
        var href = window.location.href;
        var index = href.indexOf("?");
        if(index == -1){
            return false;
        }

        href = href.slice(index+1).split("&");
        var copy = [];
        for(var i=0,n=href.length; i<n; i++){
            var keyValue = href[i].split("=");
            if(keyValue[0] == "roomId"){
                return keyValue[1];
            }
        }

        return false;
    }

    var roomId = findRoomId();
    var tab_arr = [
        { "tag_id": 1, "tag_name": "关注", "tag_url": "javascript:;", "target": "", "display": "dis-none" },
        { "tag_id": 2, "tag_name": "排行榜", "tag_url": "ranklist.shtml", "target": "_blank", "display": "dis-block" },
        { "tag_id": 3, "tag_name": "活动", "tag_url": "http://mgc.qq.com/cp/a20151231music/index.htm", "target": "_blank", "display": "dis-block" },
        { "tag_id": 4, "tag_name": "签到", "tag_url": "javascript:;", "target": "", "display": "dis-none" },
        { "tag_id": 5, "tag_name": "任务", "tag_url": "act.shtml", "target": "_blank", "display": "dis-none" },
        { "tag_id": 6, "tag_name": "后援团", "tag_url": "group.shtml", "target": "_blank", "display": "dis-none" },
        { "tag_id": 7, "tag_name": "周边", "tag_url": "http://mall.qq.com/x5/"+roomId, "target": "_blank", "display": "dis-none" }
    ];
    var default_select = 0;
    if (tool.filename() == "") {
        default_select = 1;
    } else {
        $.each(tab_arr, function(i, o) {
            if (o.tag_url == tool.filename()) {
                default_select = o.tag_id;
                return;
            }
        });
    }
    tab_coll.reset(tab_arr);
    var tab_nav_view = new show_view.TabNavView('#h-nav', tab_coll, default_select, null);
    if (MgcAPI.SNSBrowser.IsX52()) {
        tool.setXW2Cookie();
    }
    var doLogin = function() {
        comm_view.getViewRoomLoginBar(mgc.comm_model.getLoginBarModel, qqloginCallback, qqloginCancelCallback, getPlayerInfoCallback);
        //先检测、才能获取uin
        account.checkLogin(function() {
            //有登录态的情况下
            console.log("logined" + account.getUin());
            mgc.comm_model.getLoginBarModel.toggle(true);
            qqloginCallback(false);
        }, function() {
            //无登录态的情况下
            console.log("not logined");
            callcenter.query_clear_login_cookie(function() {
                console.log("cookie cleared!");
                var myTime = new Date();
                var filename = window.location.href;
                tool.cookie("mgc_logError_room_entry_doLogin", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___unLogin_state___web--room_entry_doLogin-unLogin_state___account_checkLogin_unLogin___filename" + filename, {
                    path: '/',
                    domain: '.qq.com'
                });
            });
            mgc.comm_model.getLoginBarModel.toggle(false);
            if (tool.getUrlParam("ADUIN")) {
                $("#login-bar-btn").click();
            } else {
                qqloginCallback(true);
            }
        }, true);
    };
    var qqloginCallback = function(use_guest) {
        login.doLoginVideo(loginCallback, use_guest);
    };
    var getPlayerInfoCallback = function() {
        login.getPlayerInfo();
    };
    var qqloginCancelCallback = function() {
        account.checkLogin(function() {
            //todo
            console.log("qqloginCancelCallback:islogin");
        }, function() {
            if (tool.getUrlParam("ADUIN")) {
                window.location.href = window.mgc.tools.changeUrlToLivearea(consts.url.HOME);
            }
        }, true);
        return true;
    };
    comm.onNetworkInited = function(_login_callback) {
        //初始化回调
        loginCallback = _login_callback;
        //监听登录
        doLogin();
    };
    $('.sr_con').css("width", "100%");
    //个人直播房间缩放规则属性
    var c = {};
    c.content_max_width = 1493;//content 最大宽度
    c.content_min_width = 1205;//content 最小宽度
    c.side_moddle_margin = 3; //中间缩放区域的边距
    c.header = 65;//header的宽度
    c.maxHtmlWidth = c.content_max_width + c.header * 2;//当side-left碰撞到header时html的最大宽度
    c.video_percent = 16 / 9;//视频窗口区域的宽高比
    c.flash_percent = 16 / 9;//视频播放区域的宽高比
    c.flash_magin = 10;//视频播放区域的边距 (top)
    c.side_left_width = 260;//左侧宽度
    c.side_right_width = 321;//右侧宽度
    c.maxH = 406;//最大高度 礼物区
    c.minH = 280;//最小高度 礼物区
    c.maxW = c.content_min_width + c.header;//文档最大宽度
    c.minW = c.maxW - c.side_left_width;//文档最小宽度
    c.progress_bg_height = 36;//热度条高度
    c.left_minus_height = 538;//左侧多余高度
    c.right_minus_height = 460;//右侧多余高度
    c.content = $("#content"); //content对象
    c.side_left = $(".side-left");//左侧区域对象
    c.side_moddle = $(".side-middle");//中间区域对象
    c.layer_video = $(".layer-video");//视频框对象
    c.video_play = $(".video_play");//视频播放小框的对象
    c.video_light = $(".video_light");//走马灯对象
    c.video_flash = $(".video_flash");//视频播放器对象
    c.red_bottom = $("#red_bottom");//红包底部对象
    c.online = $(".layer-onlines #sn_con");//在线列表对象
    c.fans = $(".layer-fans .sr_con");//超级粉丝
    c.gifts = $(".layer-gifts");//礼物区
    c.chat = $(".layer-chat .sc_con_panl");//聊天区
    c.small_side_moddle = 635;//最小高度
    c.max_online_height = 176;//在线列表最大高度
    c.__left = 0;//左侧定位
    c.__left_shadow = 0;//左侧浮层的shadow宽度
    c.side_bar_btn_w = 18;//左侧模块收缩按钮宽度
    c.side_left_bg_color = tool.is_caveolae_room() ? "#7e3d18" : tool.is_live_room() ? "#6511b6" : "";//左侧浮动层的底板颜色
    c.video_flash_border_width = 7;//视频框border的宽度
    c.layer_video_top = 0;//礼物区top
    if (tool.is_nest_room()) {
        //新皮肤下 重置某些参数
        c.left_minus_height = 645;//左侧多余高度
        c.right_minus_height = 555;//右侧多余高度
        c.side_bar_btn_w = 23;//左侧模块收缩按钮宽度
        c.video_flash_border_width = 10;//视频框border的宽度
        c.layer_video_top = 5;//礼物区top
        c.__left_shadow = 2;//左侧浮层的shadow宽度
    }
    //演唱会房间缩放规则属性
    var s = {};
    s.content_max_width = 1265;//content 最大宽度
    s.content_min_width = 942;//content 最小宽度
    s.side_moddle_margin = 15; //中间缩放区域的边距
    s.header = 65;//header的宽度
    s.maxHtmlWidth = s.content_max_width + s.header * 2;//当side-left碰撞到header时html的最大宽度
    s.video_percent = 925 / 561;//视频窗口区域的宽高比
    s.flash_percent = 16 / 9;//视频播放区域的宽高比
    s.flash_magin = 43 + 16;//视频播放区域的边距 (top + bottom)
    s.side_left_width = 0;//左侧宽度
    s.side_right_width = 321;//右侧宽度
    s.maxH = 406;//最大高度 礼物区
    s.minH = 168;//最小高度 礼物区
    s.maxW = s.content_min_width + s.header;//文档最大宽度
    s.progress_bg_height = 53;//热度条高度
    s.right_minus_height = 545;//右侧多余高度
    s.content = $("#content"); //content对象 
    s.side_moddle = $(".side-middle");//中间区域对象
    s.layer_video = $(".layer-video");//视频框对象
    s.video_play = $(".video_play");//视频播放小框的对象
    s.video_light = $(".video_light");//走马灯对象
    s.video_flash = $(".video_flash");//视频播放器对象
    s.fans = $(".layer-fans .sr_con");//超级粉丝
    s.gifts = $(".layer-gifts");//礼物区
    s.chat = $(".layer-chat .sc_con_panl");//聊天区
    s.small_side_moddle = 635;//最小高度
    var roomScreen = {
        caveolaeroom: function(isC) {
            //log.debug("房间适配1");
            console.log("房间适配1");
            var w = $(window).width();//浏览器可视区域宽度
            if (w >= c.maxW) {
                $("body").css({ "overflow-x": "hidden" });
                c.content.css("overflow", "visible");
                if (MgcAPI.SNSBrowser.IsQQGameLiveArea() == "true") {
                    c.content.css("overflow", "hidden");
                }
                if (w > c.content_min_width + c.header + c.side_left_width + c.side_moddle_margin && c.side_left.attr("side_state") != undefined) {
                    c.side_left.removeAttr("side_state");//side-left标识状态：0隐藏中 1显示中 undefined常态
                    c.side_left.stop().animate({ left: 0 }, 500, function() { c.side_left.css({ "position": "static", "z-index": "auto", "background-color": "" }); });//左侧常态显示
                    $(".side_bar_btn").stop().animate({ width: 0 }, 200);
                    if (tool.is_nest_room()) {
                        c.side_left.find('[class*="layer-"]').css("left", "0");
                    }
                    c.content_min_width = c.content_min_width + c.side_left_width + c.side_moddle_margin;//修改content最小宽度为添加左侧宽度
                    c.content_max_width = 1493;
                    c.maxHtmlWidth = c.content_max_width + c.header * 2;
                    c.maxW = c.content_min_width + c.header;
                    c.minW = c.maxW - c.side_left_width;
                    c.content.width(c.content_min_width);
                }
            } else {
                $("body").css({ "overflow-x": "scroll" });
                c.content.css("overflow", "hidden");
                if (MgcAPI.SNSBrowser.IsQQGameLiveArea() == "true") {
                    c.content.css("overflow", "hidden");
                }
                if (w <= c.content_min_width + c.header + c.side_left_width + c.side_moddle_margin && c.side_left.attr("side_state") == undefined) {
                    c.content_min_width = c.content_min_width - c.side_left_width - c.side_moddle_margin;//修改content最小宽度为去除左侧宽度
                    c.content_max_width = c.content_min_width;
                    c.maxHtmlWidth = c.content_max_width + c.header * 2;
                    c.maxW = c.content_min_width + c.header;
                    c.minW = c.maxW - c.side_left_width;
                    c.__left = w >= (c.maxW + c.header) ? -((w - c.content_min_width) / 2 - c.header + c.side_left_width) - 1 : -c.side_left_width - 1;
                    c.side_left.attr("side_state", "0");//side-left标识状态：0隐藏中 1显示中 undefined常态 7e3d18  6511b6
                    c.side_left.stop().css({ "position": "absolute", "z-index": "939000", "background-color": c.side_left_bg_color }).animate({ left: c.__left + c.__left_shadow }, 500, function() {
                        $(".side_bar_btn").removeClass("side_bar_btn_1").stop().animate({ width: c.side_bar_btn_w }, 200);
                        if (tool.is_nest_room()) {
                            c.side_left.find('[class*="layer-"]').css("left", "-100px");
                        }
                    });//左侧浮动隐藏
                    c.content.width(c.content_min_width);
                    if (c.content_min_width + c.header <= w) {
                        $("body").css({ "overflow-x": "hidden" });
                        c.content.css("overflow", "visible");
                        if (MgcAPI.SNSBrowser.IsQQGameLiveArea() == "true") {
                            // c.content.css("overflow", "hidden");
                        }
                    }
                    if (tool.is_nest_room()) {
                        //新皮肤下 重置某些参数
                        c.left_minus_height = 562;//左侧多余高度
                    }
                }
            }
            if (c.side_left.attr("side_state") == 1) {
                c.__left = w >= (c.maxW + c.header) ? -((w - c.content_min_width) / 2 - c.header) : 0;
                c.side_left.stop().animate({ left: c.__left + c.__left_shadow }, 500, function() {
                    $(".side_bar_btn").addClass("side_bar_btn_1").width(c.side_bar_btn_w);
                    if (tool.is_nest_room()) {
                        c.side_left.find('[class*="layer-"]').css("left", "0");
                    }
                });
            } else if (c.side_left.attr("side_state") == 0) {
                c.__left = w >= (c.maxW + c.header) ? -((w - c.content_min_width) / 2 - c.header + c.side_left_width) - 1 : -c.side_left_width - 1;
                c.side_left.stop().animate({ left: c.__left + c.__left_shadow }, 500, function() {
                    $(".side_bar_btn").removeClass("side_bar_btn_1").width(c.side_bar_btn_w);
                    if (tool.is_nest_room()) {
                        c.side_left.find('[class*="layer-"]').css("left", "-100px");
                    }
                });
            }
            var h = $(window).height();//浏览器可视区域高度
            var seeH = h;
            //横向缩放
            var _is_small_to_big = c.content.width() + c.header <= w && c.content.width() <= c.content_max_width;
            var _is_big_to_small = c.content.width() + c.header > w && c.content.width() >= c.content_min_width;
            if (_is_small_to_big || _is_big_to_small) {
                //缩放content宽度
                var _content_width = w - c.header;
                if (_is_big_to_small) {
                    if (_content_width < c.content_min_width) {
                        _content_width = c.content_min_width;
                    }
                } else {
                    if (_content_width > c.content_max_width) {
                        _content_width = c.content_max_width;
                    }
                }
                var _side_middle_width;
                if (c.side_left.attr("side_state") != undefined) {
                    _content_width = c.content_min_width;
                    _side_middle_width = _content_width - c.side_right_width - c.side_moddle_margin;
                } else {
                    _side_middle_width = _content_width - c.side_left_width - c.side_right_width - c.side_moddle_margin * 2;
                }
                c.content.width(_content_width);
                //缩放side_middle的宽度                
                c.side_moddle.width(_side_middle_width);
                //缩放layer-video的高（宽已自适应）
                var _layer_video_height = Math.round(_side_middle_width / c.video_percent);
                c.layer_video.height(_layer_video_height);
                //缩放video_play的宽高、边距
                var _video_play_height = _layer_video_height - c.flash_magin - 23;
                var _video_play_width = Math.round(_video_play_height * c.flash_percent);
                /*
                c.video_play.width(_video_play_width).height(_video_play_height);
                //缩放video_flash的宽高
                c.video_flash.width(_video_play_width - c.video_flash_border_width * 2).height(_video_play_height - c.video_flash_border_width * 2);
                 */
                c.video_flash.width(_video_play_width).height(_video_play_height);
                c.video_play.width(_video_play_width + c.video_flash_border_width * 2).height(_video_play_height + c.video_flash_border_width * 2);
                //缩放video_light的宽度
                c.video_light.width(_video_play_width - c.video_flash_border_width * 2);
                //红包缩放
                roomScreen.red_packet_resize(_layer_video_height);
            }
            //content定位
            var _content_margin_left = (w - c.content.width()) / 2;
            c.content.css("margin-left", _content_margin_left < c.header ? c.header : _content_margin_left);
            if (c.maxHtmlWidth >= w) {
                c.content.css("margin-left", c.header);
                if (tool.is_nest_room()) {
                    //新皮肤下 重置某些参数
                    c.left_minus_height = 558;//左侧多余高度
                }
            } else {
                c.content.css("margin-left", "auto");
                if (tool.is_nest_room() && c.side_left.attr("side_state") == undefined) {
                    //新皮肤下 重置某些参数
                    c.left_minus_height = 645;//左侧多余高度
                }
            }
            if (c.content.css("display") == "none") {
                c.content.show();
                if ($(window).width() < w && c.side_left.attr("side_state") != undefined) {
                    //这种情况是当首次刷新界面，并且在content从隐藏到显示后，出现滚动条，并且当前左侧为浮动状态时，需要重新计算当前适配情况
                    this.caveolaeroom();
                    return;
                }
            }
            //纵向缩放
            if (c.small_side_moddle > h) {
                h = c.small_side_moddle;//纵向最小高度
            }
            //礼物区缩放
            var _gifts_height = h - c.layer_video.height() - c.progress_bg_height + c.layer_video_top;
            if (_gifts_height > c.maxH) {
                _gifts_height = c.maxH;
            } else if (_gifts_height < c.minH) {
                _gifts_height = c.minH;
            }
            c.gifts.height(_gifts_height);
            //兼容ie10/ie11浏览器
            c.side_moddle.height(c.layer_video.height() + c.progress_bg_height + _gifts_height);
            if (MgcAPI.SNSBrowser.IsQQGameLiveArea() == "true") {
                c.side_moddle.height(seeH);
                c.content.css("margin-left", "auto");
                if (tool.is_nest_room()) {
                    var skinLevel = MGC_Comm.getUrlParam("skin_id");
                    if (skinLevel == 2) {
                        c.gifts.height(seeH - c.layer_video.height() - c.progress_bg_height - 1);
                    } else {
                        c.gifts.height(seeH - c.layer_video.height() - c.progress_bg_height + c.layer_video_top);
                    }
                } else {
                    c.gifts.height(seeH - c.layer_video.height() - c.progress_bg_height);
                }
            }
            //超级粉丝区域缩放
            if (tool.is_nest_room()) {
                //新皮肤下的布局设配
                var _fans_online_height = c.side_moddle.height() - c.left_minus_height;
                c.fans.height(_fans_online_height);
            } else {
                var _fans_online_height = (c.side_moddle.height() - c.left_minus_height) / 2;
                c.fans.height(_fans_online_height > c.max_online_height ? _fans_online_height * 2 - c.max_online_height : _fans_online_height);
                //在线列表缩放 > 在线列表有最大值上线
                c.online.height(_fans_online_height > c.max_online_height ? c.max_online_height : _fans_online_height);
            }
            //聊天区缩放
            var _chat_height = c.side_moddle.height() - c.right_minus_height;
            c.chat.height(_chat_height);
            //热门推荐缩放
            HotRoom.resize();
            SmallHotRoom.resize();
            //新手引导-礼物池区域自适应
            MGC_roomGuideResp.resize();
            roomScreen.giftAutoCaveolaeroom(_gifts_height);
            roomScreen.giftAutoLiveroom(_gifts_height);
            roomScreen.giftAutoCaveolaeroom_W(_side_middle_width);
            roomScreen.giftAutoLiveroom_W(_side_middle_width);
            //热度条适配
            //progressBarRize();
            console.log("房间适配动画之前");
            //如果是换肤房间执行
            if (tool.is_nest_room()) {
                //左侧header缩放
                roomScreen.header_resize(h);
                console.log("房间适配准备进入抢座自适应");
                //换肤抢座自适应
                roomScreen.changSkinGrabSeat();
                if ($("#meili_div").css("display") == "block") {
                    window.mgc.popmanager.layerControlHide($("#meili_div"), 3, 1);
                }
                console.log("房间适配抢座自适应返回");
            }
            //初始化抽奖按钮
            var bottomPos = tool.is_nest_room() ? 93 : 88;
            var rightPos = tool.is_nest_room() ? 22 : 11;
            $("#draw_button").css({
                "bottom": bottomPos,
                "right": rightPos
            });
            $("#secret-order").css({
                "bottom": bottomPos-3,
                "right": rightPos+68-20
            });
            console.log("房间适配守护动画之前");
            //守护入场动画适配
            MGC_Comm.resizeGuardFlash();
            //恶魔动画适配
            MGC_Comm.resizeGiftEffect();
            //全屏礼物特效适配
            DreamBoxEffect.onResize();
            //筛子礼物特效适配
            DiceEffect.onResize();
            //抢座特效TOP
            roomScreen.resize();
            //缩放过程中需要隐藏的弹出层：成员操作列表 、 抢座
            roomScreen.hidePanl();
            console.log("房间适配礼物插件之前");
            //礼物插件缩放
            GiftRankPane.onResize();
            //PK榜缩放
            if (mgc.rankPaneView) {
                mgc.rankPaneView.resize();
            }
            //粉丝贡献榜缩放
            mgc.giftRankView.resize();
            console.log("房间适配礼物插件之后");
            console.log("房间适配2");
        },
        liveroom: function() {
            this.caveolaeroom(false);
            return;
            var h = $(window).height();//浏览器可视区域高度
            var w = $(window).width();//浏览器可视区域宽度
            var maxH = 664;//最大高度
            var minH = 558;//最小高度
            var maxHtmlWidth = 1075;//html最大宽度
            var maxW = 1007;//文档最大宽度
            var minW = 50 + 477 + 264 + 6;//文档最小宽度
            var fansH = $(".layer-fans .sr_con");//超级粉丝高度
            var giftsH = $(".layer-gifts");//礼物区高度
            var chatH = $(".layer-chat .sc_con_panl");//聊天区高度
            if (w >= maxW) {
                $("body").css({ "overflow-x": "hidden" });
                $("#content").css("overflow", "visible");
                if (MgcAPI.SNSBrowser.IsQQGameLiveArea() == "true") {
                    $("#content").css("overflow", "hidden");
                }
            } else {
                $("body").css({ "overflow-x": "scroll" });
                $("#content").css("overflow", "hidden");
            }
            //纵向缩放
            if (h <= maxH && h >= minH) {
                changeMiddle();
            } else if (h < minH) {
                changeMin();
            } else {
                changeMax();
            }
            function changeMin() {
                fansH.height(122);
                giftsH.height(168);
                chatH.height(183);
            }
            function changeMiddle() {
                fansH.height(h - 436);
                giftsH.height(h - 391);
                chatH.height(h - 376);
            }
            function changeMax() {
                fansH.height(228);
                giftsH.height(272);
                chatH.height(288);
            }
            //横向缩放
            if (maxW >= w) {
                var _left = w < minW ? maxW - minW : maxW - w;
                $(document).scrollLeft(_left);
            }
            if (maxHtmlWidth >= w) {
                $("#content").css("margin-left", "51px");
            } else {
                $("#content").css("margin-left", "auto");
            }
            roomScreen.giftAutoCaveolaeroom(giftsH);
            roomScreen.giftAutoLiveroom(giftsH);
        },
        showroom: function() {
            var w = $(window).width();//浏览器可视区域宽度
            if (w >= s.maxW) {
                $("body").css({ "overflow-x": "hidden" });
                $("#content").css("overflow", "visible");
                if (MgcAPI.SNSBrowser.IsQQGameLiveArea() == "true") {
                    $("#content").css("overflow", "hidden");
                }
            } else {
                $("body").css({ "overflow-x": "scroll" });
                $("#content").css("overflow", "hidden");
            }
            var h = $(window).height();//浏览器可视区域高度
            var seeH = h;
            //横向缩放
            var _is_small_to_big = s.content.width() + s.header <= w && s.content.width() <= s.content_max_width;
            var _is_big_to_small = s.content.width() + s.header > w && s.content.width() >= s.content_min_width;
            if (_is_small_to_big || _is_big_to_small) {
                //缩放content宽度
                var _content_width = w - s.header;
                if (_is_big_to_small) {
                    if (_content_width < s.content_min_width) {
                        _content_width = s.content_min_width;
                    }
                } else {
                    if (_content_width > s.content_max_width) {
                        _content_width = s.content_max_width;
                    }
                }
                var _side_middle_width = _content_width - s.side_right_width - s.side_moddle_margin;
                s.content.width(_content_width);
                //缩放side_middle的宽度                
                s.side_moddle.width(_side_middle_width);
                //缩放layer-video的高（宽已自适应）
                var _layer_video_height = Math.round(_side_middle_width / s.video_percent);
                s.layer_video.height(_layer_video_height);
                //缩放video_play的宽高、边距
                var _video_play_height = _layer_video_height - s.flash_magin - 14;
                var _video_play_width = Math.round(_video_play_height * s.flash_percent);
                s.video_play.width(_video_play_width + 14).height(_video_play_height + 14);
                //缩放video_flash的宽高
                s.video_flash.width(_video_play_width).height(_video_play_height);
                //缩放video_light的宽度
                s.video_light.width(_video_play_width);
            }
            //content定位
            var _content_margin_left = (w - s.content.width()) / 2;
            s.content.css("margin-left", _content_margin_left < s.header ? s.header : _content_margin_left);
            if (s.maxHtmlWidth >= w) {
                $("#content").css("margin-left", s.header);
            } else {
                $("#content").css("margin-left", "auto");
            }
            if (c.content.css("display") == "none") {
                c.content.show();
            }
            //纵向缩放
            if (s.small_side_moddle > h) {
                h = s.small_side_moddle;//纵向最小高度
            }
            //礼物区缩放
            var _gifts_height = h - s.layer_video.height() - s.progress_bg_height;
            if (_gifts_height > s.maxH) {
                _gifts_height = s.maxH;
            } else if (_gifts_height < s.minH) {
                _gifts_height = s.minH;
            }
            s.gifts.height(_gifts_height);
            //兼容ie10/ie11浏览器
            s.side_moddle.height(s.layer_video.height() + s.progress_bg_height + _gifts_height);
            if (MgcAPI.SNSBrowser.IsQQGameLiveArea() == "true") {
                s.content.css("margin-left", "auto");
                s.side_moddle.height(seeH);
                s.gifts.height(seeH - s.layer_video.height() - s.progress_bg_height + 2);
            }
            //聊天区缩放
            var _chat_height = s.side_moddle.height() - s.right_minus_height;
            s.chat.height(_chat_height);

            var bottomPos =  88;
            var rightPos = 11;
            $("#secret-order").css({
                "bottom": bottomPos-3,
                "right": rightPos+68-20
            });
            //热门推荐缩放
            HotRoom.resize();
            //热度条适配
            //progressBarRize();
            //守护入场动画适配
            MGC_Comm.resizeGuardFlash();
            //全屏礼物特效适配
            DreamBoxEffect.onResize();
            //筛子礼物特效适配
            DiceEffect.onResize();
            //恶魔动画适配
            MGC_Comm.resizeGiftEffect();
            //缩放过程中需要隐藏的弹出层：成员操作列表 、 抢座
            roomScreen.hidePanl();
        },
        screen: function() {
            try {
                tool.is_show_room() ? this.showroom() : tool.is_live_room() ? this.liveroom() : tool.is_caveolae_room() ? this.caveolaeroom() : tool.is_nest_room() ? this.caveolaeroom() : null;
            } catch (e) {
                console.log("有你这样玩的么？" + e.message);
            }
        },
        giftAutoCaveolaeroom: function(obj) {
            var gifBottom = (obj / 2 - 15) + 'px';
            $('#giftArea_guide_c').css('bottom', gifBottom)
        },
        giftAutoLiveroom: function(obj) {
            var gifBottom = (obj / 2 - 15) + 'px';
            $('#giftArea_guide').css('bottom', gifBottom);
        },
        giftAutoCaveolaeroom_W: function(obj) {
            var gifLeft = ((obj / 2) - 179.5) + 'px';
            $('#giftArea_guide_c').css('left', gifLeft)
        },
        giftAutoLiveroom_W: function(obj) {
            var gifLeft = ((obj / 2) - 179.5) + 'px';
            $('#giftArea_guide').css('left', gifLeft);
        },
        grabSeatFlash_top: function() {

            var Top = $('.layer-guard').offset().top;
            $('.vipGrabFlash').css('top', Top + 'px');
        },
        resize: function() {
            //  roomScreen.grabSeatFlash_top();
        },
        //左侧header缩放
        header_resize: function(_h) {
            var _h_middle = _h - 68 - 45;
            $(".h-middle").height(_h_middle);
        },
        //红包适配
        red_packet_resize: function(_h) {
            if (_h > 430) {
                $("#red_left,#red_right").css({ height: 430, top: (_h - 430) / 2 });
                $("#red_left").find(".red_packet:last-child").css({ left: 0, top: 0 });
                $("#red_right").find(".red_packet").css({ left: -112, top: 0 });
            } else {
                $("#red_left,#red_right").css({ height: 330, top: (_h - 330) / 2 });
                $("#red_left").find(".red_packet:last-child").css({ left: 117, top: -208 });
                $("#red_right").find(".red_packet:last-child").css({ left: -229, top: -208 });
            }
            $("#red_bottom").css("top", _h);
        },
        hidePanl: function() {
            if ($(".card_tips").css("display") == "block") {
                var card = $j(".card_tips");
                window.mgc.popmanager.layerControlHide(card, 3, 2);
                window.mgc.popmanager.layerControlHide(card, 2, 2);
                window.mgc.popmanager.layerControlHide(card, 1, 2);
            }
        },
        //换肤-抢座自适应方法
        changSkinGrabSeat: function() {
            //  roomScreen.grabSkinHover();
            roomScreen.changeGrabLevelBg();
            var w = $(window).width();//浏览器可视区域宽度
            var typeW = mgc.config.SKIN_CONFIG[SKIN.id][SKIN.level].ui_grab.width;
            s.side_moddle.css('z-index', '1');
            var c_middle_h = c.side_moddle.height() - 96;
            console.log("房间适配抢座自适应c_middle_h：" + c_middle_h);
            if (w > 1622) {
                //个人直播间-抢座自适应-显示
                $('.auto_seatVip').css({ 'width': typeW, 'overflow': 'inherit', 'margin-right': '-80px', 'top': c_middle_h + 'px', 'left': '-144px', 'right': 'inherit', 'z-index': '0' });
                $('.grabEffectsBox').css({ 'width': '1574px', 'height': '94px', 'position': 'relative', 'clear': 'both', 'top': '-90px', 'left': '64px' });//'top': '-183px',
                if ($('.grabEffectsBox li').attr('data-index') == 3 || $('.grabEffectsBox li').attr('data-index') == 4 || $('.grabEffectsBox li').attr('data-index') == 5) {
                    $(this).attr('style', 'float:right');
                }
                $('#vipContainerSkin').css({ 'width': '1572px', 'margin-left': '77px' })
                $('.auto_seatVip .vipShowTips').eq(0).css('float', 'left');
                $('.auto_seatVip .vipShowTips').eq(1).css('float', 'left');
                $('.auto_seatVip .vipShowTips').eq(2).css('float', 'left');
                $('.auto_seatVip .vipShowTips').eq(3).css('float', 'right');
                $('.auto_seatVip .vipShowTips').eq(4).css('float', 'right');
                $('.auto_seatVip .vipShowTips').eq(5).css('float', 'right');
                //$('.auto_seatVip .vipShowTips:lt(3)').css( 'float', 'left' );
                // $('.auto_seatVip .vipShowTips:gt(2)').css( 'float', 'right' );

                $('.sv_list').css('overflow', 'inherit');
                $('.sv_list').removeClass('shrinkBg');
                $('#seatBtn').attr('class', '');
                $('.seatVip_show').unbind("click");
                $('.seatBg').css('display', 'block');
                $('.auto_seatVip .mask').css({ 'display': 'none' });
                $('#middleBg').removeClass('shrinkBg_middle');
                $('#middleBg').css({ 'width': 'inherit' });
                $('.sv_list').css({ 'width': 'inherit', 'overflow': 'inherit' });
                //当缩回去抢座状态时候判断
                if ($('#middleBg').width() <= 700) {
                    $('#middleBg').css({ 'width': typeW, 'overflow': 'overflow' })
                } else {
                    $('#middleBg').css({ 'width': typeW, 'overflow': 'inherit' })
                }
            } else {
                //个人直播间-抢座自适应-隐藏
                $('.auto_seatVip').css({ 'width': '321px', 'overflow': 'inherit', 'margin-right': '0', 'top': c_middle_h + 'px', 'z-index': '939002', 'right': '0', 'left': 'inherit' });
                $('.grabEffectsBox').css({ 'width': '675px', 'height': '94px', 'position': 'relative', 'clear': 'both', 'top': '-5px', 'left': '23px' });//'top': '-100px',
                if ($('.grabEffectsBox li').attr('data-index') == 4 || $('.grabEffectsBox li').attr('data-index') == 3 || $('.grabEffectsBox li').attr('data-index') == 5) {
                    $(this).attr('style', 'float:right');
                }
                $('#vipContainerSkin').css({ 'width': '675px', 'margin-left': '35px' })
                $('.auto_seatVip .mask').css({ 'display': 'inline-block' });
                $('.auto_seatVip .vipShowTips').eq(0).css('float', 'left');
                $('.auto_seatVip .vipShowTips').eq(1).css('float', 'left');
                $('.auto_seatVip .vipShowTips').eq(2).css('float', 'left');
                $('.auto_seatVip .vipShowTips').eq(3).css('float', 'right');
                $('.auto_seatVip .vipShowTips').eq(4).css('float', 'right');
                $('.auto_seatVip .vipShowTips').eq(5).css('float', 'right');
                // $('.auto_seatVip .vipShowTips:lt(3)').css( 'float', 'left' );
                // $('.auto_seatVip .vipShowTips:gt(2)').css( 'float', 'right' );

                $('.sv_list').css('overflow', 'hidden');
                $('.seatBg').css('display', 'none');
                $('.sv_list').addClass('shrinkBg');
                $('#middleBg').addClass('shrinkBg_middle');
                $('#middleBg').css({ 'width': 'inherit' });
                $('#seatBtn').attr('class', 'seatVip_show');
                $('.sv_list').css({ 'width': '309px', 'overflow': 'hidden' });
                roomScreen.tabGrabSeat();
            }
        },
        //换肤-抢座缩回去-按钮切换
        tabGrabSeat: function() {
            $('.seatVip_show').unbind("click").bind("click", function() {
                if (SKIN.id != 3) {
                    if ($('.auto_seatVip').width() == 321) {
                        MGC_Comm.hideSkinShrinkGrabSeat();
                        $('#middleBg').css({ 'width': '700px', 'overflow': 'inherit' });
                        $('.sv_list').css({ 'width': '700px', 'overflow': 'inherit' });
                        $('.auto_seatVip .mask').css({ 'display': 'none' });
                        $('#vipContainerSkin').css({ 'margin-left': '35px' })
                        $('.auto_seatVip').stop().animate({ left: 0 }, 500);
                        $('.auto_seatVip').width(700);
                        $('#seatBtn').addClass('seatVip_show seatVip_hide');
                    } else {
                        if ($('.auto_seatVip').width == 1535) {
                            $('.auto_seatVip .mask').css({ 'display': 'none' });
                        } else {
                            $('.auto_seatVip .mask').css({ 'display': 'inline-block' });
                        }
                        $('#middleBg').css({ 'width': '321px', 'overflow': 'hidden' });
                        $('.sv_list').css({ 'width': '309px', 'overflow': 'hidden' });
                        $('#vipContainerSkin').css({ 'margin-left': '35px' })
                        $('.auto_seatVip').stop().animate({ right: 0 }, 500);
                        $('.auto_seatVip').width(321);
                        $('#seatBtn').removeClass('seatVip_hide');
                    }
                } else {
                    if ($('.auto_seatVip').width() == 321) {
                        MGC_Comm.hideSkinShrinkGrabSeat();
                        $('#middleBg').css({ 'width': '708px', 'overflow': 'inherit' });
                        $('.sv_list').css({ 'width': '708px', 'overflow': 'inherit' });
                        $('.auto_seatVip .mask').css({ 'display': 'none' });
                        $('#vipContainerSkin').css({ 'margin-left': '35px' })
                        $('.auto_seatVip').stop().animate({ left: 0 }, 500);
                        $('.auto_seatVip').width(708);
                        $('#seatBtn').addClass('seatVip_show seatVip_hide');
                    } else {
                        if ($('.auto_seatVip').width == 1535) {
                            $('.auto_seatVip .mask').css({ 'display': 'none' });
                        } else {
                            $('.auto_seatVip .mask').css({ 'display': 'inline-block' });
                        }
                        $('#middleBg').css({ 'width': '321px', 'overflow': 'hidden' });
                        $('.sv_list').css({ 'width': '309px', 'overflow': 'hidden' });
                        $('#vipContainerSkin').css({ 'margin-left': '35px' })
                        $('.auto_seatVip').stop().animate({ right: 0 }, 500);
                        $('.auto_seatVip').width(321);
                        $('#seatBtn').removeClass('seatVip_hide');
                    }
                }

            })
        },
        //换肤-演唱会根据级别替换相应等级的抢座背景
        changeGrabLevelBg: function() {
            if (SKIN != null) {
                $('.auto_seatVip').css('display', 'none');
                if (SKIN.id == 1) {

                    if (SKIN.level >= 1 && SKIN.level < 4) {
                        $('.auto_seatVip').css('display', 'block');
                        $('.layer-vipSeat').css('display', 'none');
                        $('.auto_seatVip').attr('class', 'auto_seatVip auto_seatVip_one');
                        $('.layer-anchor-new .si_face .si_face_links i').attr('class', '');
                    } else if (SKIN.level >= 4 && SKIN.level < 7) {
                        $('.auto_seatVip').css('display', 'block');
                        $('.layer-vipSeat').css('display', 'none');
                        $('.auto_seatVip').attr('class', 'auto_seatVip auto_seatVip_two');
                        $('.layer-anchor-new #anchorImg').attr('class', '');
                    } else if (SKIN.level >= 7 && SKIN.level <= 9) {
                        $('.auto_seatVip').css('display', 'block');
                        $('.layer-vipSeat').css('display', 'none');
                        $('.auto_seatVip').attr('class', 'auto_seatVip auto_seatVip_three');
                        $('.layer-anchor-new #anchorImg').attr('class', 'skin');
                    } else {
                        $('.layer-anchor-new .si_face .si_face_links i').attr('class', '');
                        $('.auto_seatVip').css('display', 'none');
                        $('.layer-vipSeat').css('display', 'block');
                    }
                } else if (SKIN.id == 2) {

                    if (SKIN.level >= 1 && SKIN.level < 4) {
                        $('.auto_seatVip').css('display', 'block');
                        $('.layer-vipSeat').css('display', 'none');
                        $('.auto_seatVip').attr('class', 'auto_seatVip auto_seatVip_one');
                        $('.layer-anchor-new .si_face .si_face_links i').attr('class', '');
                    } else if (SKIN.level >= 4 && SKIN.level < 7) {
                        $('.auto_seatVip').css('display', 'block');
                        $('.layer-vipSeat').css('display', 'none');
                        $('.auto_seatVip').attr('class', 'auto_seatVip auto_seatVip_two');
                        $('.layer-anchor-new #anchorImg').attr('class', 'skin');
                        $('#seaWorld_anchor .part1,#seaWorld_anchor .part2,#seaWorld_anchor .part4,#guardIcon').css('display', 'block');
                    } else if (SKIN.level >= 7 && SKIN.level <= 9) {
                        $('.auto_seatVip').css('display', 'block');
                        $('.layer-vipSeat').css('display', 'none');
                        $('.auto_seatVip').attr('class', 'auto_seatVip auto_seatVip_three');
                        $('.layer-anchor-new #anchorImg').attr('class', 'skin');
                        $('#seaWorld_anchor .part1,#seaWorld_anchor .part2,#seaWorld_anchor .part3,#seaWorld_anchor .part4,#guardIcon').css('display', 'block');
                    } else {
                        $('.layer-anchor-new .si_face .si_face_links i').attr('class', '');
                        $('.auto_seatVip').css('display', 'none');
                        $('.layer-vipSeat').css('display', 'block');
                    }

                } else if (SKIN.id == 3) {

                    if (SKIN.level >= 1 && SKIN.level < 4) {
                        $('.auto_seatVip').css('display', 'block');
                        $('.layer-vipSeat').css('display', 'none');
                        $('.auto_seatVip').attr('class', 'auto_seatVip auto_seatVip_one');
                        $('.layer-anchor-new .si_face .si_face_links i').attr('class', '');
                    } else if (SKIN.level >= 4 && SKIN.level < 7) {
                        $('.auto_seatVip').css('display', 'block');
                        $('.layer-vipSeat').css('display', 'none');
                        $('.auto_seatVip').attr('class', 'auto_seatVip auto_seatVip_two');
                        $('.layer-anchor-new #anchorImg').attr('class', '');
                        $('.layer-anchor-new .seaWorld_anchor .part1').css('display', 'block');
                    } else if (SKIN.level >= 7 && SKIN.level <= 9) {
                        $('.auto_seatVip').css('display', 'block');
                        $('.layer-vipSeat').css('display', 'none');
                        $('.auto_seatVip').attr('class', 'auto_seatVip auto_seatVip_three');
                        $('.layer-anchor-new #anchorImg').attr('class', '');
                        $('.layer-anchor-new .seaWorld_anchor .part2,.layer-anchor-new .seaWorld_anchor .part3').css('display', 'block');
                    } else {
                        $('.layer-anchor-new .si_face .si_face_links i').attr('class', '');
                        $('.auto_seatVip').css('display', 'none');
                        $('.layer-vipSeat').css('display', 'block');
                    }

                }
            } else {
                $('.layer-vipSeat').css('display', 'block');
                $('.auto_seatVip').css('display', 'none');
            }
        },

        grabSkinHover: function() {
            $('.layer-video .sl_vip .sv_list li p,.layer-video .sl_vip .sv_list li i').off("mouseover,mouseout").on("mouseover", function() {
                var grabSpan = $(this).parent().find('span').eq(0);
                grabSpan.css('display', 'block');
            }).on("mouseout", function() {
                $('.layer-video .sl_vip .sv_list li p,.layer-video .sl_vip .sv_list li i').css('display', 'block');
                var grabSpan = $(this).parent().find('span').eq(0);
                grabSpan.css('display', 'none');
            });
            $('.sv_list li p,.sv_list li i').off("mouseover,mouseout").on("mouseover", function() {
                var grabSpan = $(this).parent().find('span').eq(0);
                grabSpan.css('display', 'block');
            }).on("mouseout", function() {
                $('.sv_list li p,.sv_list li i').css('display', 'block');
                var grabSpan = $(this).parent().find('span').eq(0);
                grabSpan.css('display', 'none');
            });
        }
    };
    //设置当前皮肤等级
    if (tool.is_nest_room()) {
        if (SKIN) {
            mgc_skin.dorest.initSkin();
            mgc_skin.resetskin(SKIN.level);
        }
    }
    //控制左侧模块显隐
    $(".side_bar_btn").unbind("click").bind("click", function(e) {
        if (c.side_left.attr("side_state") == 0) {
            c.__left = $(window).width() >= (c.maxW + c.header) ? -(($(window).width() - c.content.width()) / 2 - c.header) : 0;
            c.side_left.attr("side_state", "1").stop().animate({ left: c.__left + c.__left_shadow }, 500);
            $(this).addClass("side_bar_btn_1");
            if (tool.is_nest_room()) {
                c.side_left.find('[class*="layer-"]').css("left", "0");
            }
        } else if (c.side_left.attr("side_state") == 1) {
            c.__left = $(window).width() >= (c.maxW + c.header) ? -(($(window).width() - c.content_min_width) / 2 - c.header + c.side_left_width) - 1 : -c.side_left_width - 1;
            c.side_left.attr("side_state", "0").stop().animate({ left: c.__left + c.__left_shadow }, 500, function() {
                if (tool.is_nest_room()) {
                    c.side_left.find('[class*="layer-"]').css("left", "-100px");
                }
            });
            $(this).removeClass("side_bar_btn_1");
        }
    });
    roomScreen.screen();
    $(window).resize(function() {
        roomScreen.screen();
        //缩放时 重绘滚动条
        if (consts.API.scroll) {
            for (var key in consts.API.scroll) {
                if(consts.API.scroll[key]){
                    consts.API.scroll[key].initScroll();
                }
            }
        }
        
        if (tool.is_nest_room() || tool.is_caveolae_room()) {
            $(".pk-go-effect").css({ "top": $(".layer-video").height() / 2, "margin-top": -230 });
        }
    });
    callcenter.addRespListener(callcenter.OP_TYPE.GET_PLAYER_INFO, mgc.gift_response);
    callcenter.addRespListener(callcenter.OP_TYPE.NOTICE_OPEN_VIP, MGC_Comm.addOpenVIPFlyScreenMsg);//MGC_Comm.addOpenVIPFlyScreenMsg);
    // 通知当前房间中所有移动管理员的pstid信息: 332(62125)
    callcenter.addRespListener(callcenter.OP_TYPE.NOTIFY_ALL_USER_ADMIN, MGC_Comm.notifyAllUserAdmin);



    /**
     * 密令按钮 start
     */
    var secretOrderModel = new secret_order.secretOrderModel();
    var secretOrderView = new secret_order.secretOrderView({model: secretOrderModel});
    mgc.secretOrderModel = secretOrderModel;

    var lastKingModel = new last_king.lastKingModel();
    var lastKingView = new last_king.lastKingView({ model: lastKingModel });
    mgc.lastKingModel = lastKingModel;

    // var resp = {title: "鸟语花箱", content: "全新密令宝箱，活动期间手动开启后宝箱有额外奖励哦", orderText: "999999"}
    // mgc.secretOrderModel.set("isShow", !(mgc.secretOrderModel.get("isShow")));
    // mgc.secretOrderModel.set("hoverTips", resp.tips);
    // mgc.secretOrderModel.set("hoverTipsTitle", resp.title);
    // mgc.secretOrderModel.set("hoverTipsContent", resp.content);
    

    // 热度宝箱优化消息添加监听
    //下发宝箱开启的差值,活动标题和内容 334
    callcenter.addRespListener(callcenter.OP_TYPE.NOTIFY_SECRET_HEAT_BOX_INFO, MGC_Comm.notifySecretHeatBoxInfo);
    
    // 336:当主播开播时，下发主播设置（默认）的密令给玩家
    callcenter.addRespListener(callcenter.OP_TYPE.NOTIFY_ANCHOR_SECRET_CODE, secretOrderView.notifytAnchorSecretCode);
    
    // 338:通知玩家密令宝箱倒计时变化
    callcenter.addRespListener(callcenter.OP_TYPE.NOTIFY_PLAYER_SECRET_HEAT_BOX, secretOrderView.notifyPlayerSecretHeatBox);
    // 339:通知补刀王玩家获得的奖励
    callcenter.addRespListener(callcenter.OP_TYPE.NOTIFY_LAST_HIT_PLAYER_REWARD, lastKingView.notifyLastHitPlayerReward);
    //340:广播补刀王飞屏
    callcenter.addRespListener(callcenter.OP_TYPE.WHISTLE_LAST_HIT_PLAYER, MGC_Comm.addLastKingFlyScreenMsg);
    // 257:主播下线时 主动开启宝箱
    callcenter.addRespListener(callcenter.OP_TYPE.BATCH_VIDEO_TREASURE_BOX_REWARD_WEB, secretOrderView.getBoxGiftActionCallBack);
    return comm;
});