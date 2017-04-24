/**
 * Created by WJ on 2016/10/17.
 */

define(['underscore','backbone', 'jquery','mgc_tool'], function (_,Backbone,$,tool) {

    var recommend = {};

    recommend.RecommendModel = Backbone.Model.extend({
        defaults:{
            index:0,

            total:0,

            roomWidth:109,

            roomGap:4,

            num:3,

            listWidth:800,

            isMove:false,

            //推荐位列表
            rooms:[],

            enabled:false
        },

    });

    recommend.RecommendView = Backbone.View.extend({

        el:".video_recommend_list",

        model:recommend.RecommendModel,

        events:{
            "click #rl_pre_small":"preClick",
            "click #rl_next_small":"nextClick"
        },

        initialize: function () {
            this.model.on("change:rooms",this.roomsChange,this);
            this.model.on("change:enabled",this.enabledChange,this);

            this.$el.hide();

            $(window).resize(this,this.windowResize);
        },

        windowResize:function(e){
            var _this = e.data;
            _this.resize();
        },

        preClick:function(){
            var index = this.model.get("index");
            var num = this.model.get("num");

            var n = (index - num)<0?index:num;
            this.move(-n);
        },

        nextClick:function(){
            var index = this.model.get("index");
            var num = this.model.get("num");
            var total = this.model.get("total");

            var n = (total - index)>num?num:0;
            this.move(n);
        },

        //向左或向右移动n个位置
        move:function(n){
            if(n == 0)return;

            var isMove = this.model.get("isMove");
            if(isMove)return;

            this.model.set("isMove",true);

            var index = this.model.get("index");
            this.model.set("index",index + n);
            this.refresh();

            var roomWidth = this.model.get("roomWidth");
            var roomGap = this.model.get("roomGap");
            var $videoHotRecommRoomContainer = $("#videoHotRecommRoomContainer");
            var left = $videoHotRecommRoomContainer.position().left;
            var _this = this;
            $videoHotRecommRoomContainer.animate({ "left": left -  n*(roomWidth + roomGap)},function(){
                _this.model.set("isMove",false);
            });
        },

        enabledChange:function()
        {
            if(this.model.get("enabled"))
            {
                this.$el.show();
            }
            else{
                this.$el.hide();
            }
        },

        roomsChange:function()
        {
            var rooms = this.model.get("rooms");

            $.each(rooms, function(k, v) {
                v.anchor_level_temp = Math.floor(v.anchor_level / 10) + 1;
                if (v.anchor_level == 0) {
                    v.anchor_level_temp = 0;
                }
                if(MgcAPI.SNSBrowser.IsQQGameLiveArea() == "true"){
                    if (v.isNest) {
                        if (v.room_skin_id && v.room_skin_id != 0 && v.room_skin_level > 0) {
                            v.url = mgc.consts.url.NEST_ROOM + "?roomId=" + v.roomID + "&source=0&skin_id=" + v.room_skin_id + "&skin_level=" + v.room_skin_level + "&param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea();
                        } else {
                            v.url = mgc.consts.url.CAVEOLAE_ROOM + "?roomId=" + v.roomID + "&source=0&skin_id=" + v.room_skin_id + "&skin_level=" + v.room_skin_level + "&param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea();
                        }
                    } else if (v.bSuperRoom) {
                        v.url = mgc.consts.url.SHOW_ROOM + "?roomId=" + v.roomID + "&source=0&param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea();
                    } else {
                        v.url = mgc.consts.url.LIVE_ROOM + "?roomId=" + v.roomID + "&source=0&param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea();
                    }
                    if (v.is_anchor_pk_room) {
                        v.url += "&is_pk=" + v.is_anchor_pk_room;
                    }
                } else{
                    if (v.isNest) {
                        if (v.room_skin_id && v.room_skin_id != 0 && v.room_skin_level > 0) {
                            v.url = mgc.consts.url.NEST_ROOM + "?roomId=" + v.roomID + "&source=0&skin_id=" + v.room_skin_id + "&skin_level=" + v.room_skin_level;
                        } else {
                            v.url = mgc.consts.url.CAVEOLAE_ROOM + "?roomId=" + v.roomID + "&source=0&skin_id=" + v.room_skin_id + "&skin_level=" + v.room_skin_level;
                        }
                        if (v.is_anchor_pk_room) {
                            v.url += "&is_pk=" + v.is_anchor_pk_room;
                        }
                    } else if (v.bSuperRoom) {
                        v.url = mgc.consts.url.SHOW_ROOM + "?roomId=" + v.roomID + "&source=0";
                    } else {
                        v.url = mgc.consts.url.LIVE_ROOM + "?roomId=" + v.roomID + "&source=0";
                    }
                }
                v.playerCount = mgc.tools.roomListNumFormat(v.playerCount);
            });

            var HotRecommRoomCon = $('#RoomListTmpl');
            var HotRecommRoomTmpl;
            var HotRecommRoomContainer = $('#videoHotRecommRoomContainer');
            HotRecommRoomContainer.children().remove();
            HotRecommRoomTmpl = HotRecommRoomCon.render(rooms);
            HotRecommRoomContainer.append(HotRecommRoomTmpl);
            HotRecommRoomContainer.css("left", 0);

            this.$el.show();

            HotRecommRoomContainer.find("li").off("mouseover,mouseout").on("mouseover", function(){
                $(this).css("border-color", "#6a41c6").find(".room-cover").show();
            }).on("mouseout", function(){
                $(this).css("border-color", "#f5f5f5").find(".room-cover").hide();
            });

            var imgs = $("#videoHotRecommRoomContainer .room-img img");
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

            this.model.set("index",0);
            this.model.set("total",rooms.length);
            this.resize();
        },

        refresh:function(){
            var $rl_pre_small = this.$el.find("#rl_pre_small");
            var index = this.model.get("index");
            var total = this.model.get("total");
            var num = this.model.get("num");

            if(index > 0)
            {
                $rl_pre_small.removeClass().addClass("rl_pre");
            }
            else
            {
                $rl_pre_small.removeClass().addClass("rl_pre rl_pre_un");
            }

            var $rl_next_small = this.$el.find("#rl_next_small");
            if((total - index) > num)
            {
                $rl_next_small.removeClass().addClass("rl_next");
            }
            else
            {
                $rl_next_small.removeClass().addClass("rl_next rl_next_un");
            }
        },

        //自适应宽度
        resize:function(){
            var left = 15 + 4;
            var right = 15;

            var width = this.$el.width();

            //计算能放几个房间
            var total = this.model.get("total");
            var roomWidth = this.model.get("roomWidth");
            var roomGap = this.model.get("roomGap");
            var num = parseInt((width - left - right)/(roomWidth + roomGap));
            num = num > total ? total : num;
            this.model.set("num",num);

            var $rl_con = this.$el.find(".rl_con");
            //列表宽度
            var listWidth = num*(roomWidth + roomGap);
            $rl_con.width(listWidth);
            //列表位置
            var listLeft = (width - listWidth - left - right)/2 + left;
            $rl_con.css("left",listLeft);

            this.refresh();
        }
    });


    return recommend;

});