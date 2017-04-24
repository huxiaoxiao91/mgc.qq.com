/*
* Author:             77
* Version:            1.0 (2015/11/11)
* Discription:        show模块集合
*/
define(['backbone', 'jquery', 'mgc_show_model', 'mgc_consts'], function(backbone, $, show_model, consts) {
    var show_coll = {};
    /**
     * Tab页基础集合
     * @type {void|*}
     */
    show_coll.TabColl = backbone.Collection.extend({
        model: show_model.TabModel,
        last_selected: -10000,
        initialize: function(models) {
            if (models) {
                this.reset(models);
            }
        },
        /**
         * 由视图点击触发的选择
         * @param id    受到触发的视图模型id
         */
        select: function(id) {
            //检查该视图是否已经在选中状态
            if (this.last_selected === id) {
                return;
            }
            console.log("TabColl,View triggered a select:" + id);
            //一个新tab被触发，关闭旧tab，再打开新tab
            var last_sel = this.where({ tag_id: this.last_selected });
            var i = last_sel.length;
            while (i--) {
                var last_pageindex = $("#tag-" + last_sel[i].get_id()).attr("pageindex");
                last_sel[i].set_pageindex(last_pageindex);
                last_sel[i].set_selected(false);
            }
            var list = this.where({ tag_id: id });
            var i = list.length;
            while (i--) {
                var _pageindex = $("#tag-" + id).attr("pageindex");
                list[i].set_pageindex(_pageindex);
                list[i].set_selected(true);
                //触发一个自定义的选择变更消息
                this.trigger("mgc_sel_change:tab", id, list[i].get_pageindex());
            }
            //记录当前被触发的视图id
            this.last_selected = id;
        }
    });
    /**
     * room面板列表基础集合
     * @type {void|*}
     */
    show_coll.RoomItemColl = backbone.Collection.extend({
        model: show_model.RoomItemModel,
        initialize: function(models) {
            if (models) {
                this.reset(models);
            }
        },
        reset_data: function(data) {
            $.each(data, function(i, o) {
                o.anchor_level_temp = Math.floor(o.anchor_level / 10) + 1;
                if (o.anchor_level == 0) {
                    o.anchor_level_temp = 0;
                }
                if (o.isNest) {
                    if (o.room_skin_id && o.room_skin_id != 0 && o.room_skin_level > 0) {
                        o.url = consts.url.NEST_ROOM + "?roomId=" + o.roomID + "&source=14&skin_id=" + o.room_skin_id + "&skin_level=" + o.room_skin_level + "&param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea() + "&module_type=" + o.module_type + "&page_capacity=" + o.page_capacity + "&room_list_pos=" + o.room_list_pos + "&tag_id=" + o.tag_id;
                    } else {
                        o.url = consts.url.CAVEOLAE_ROOM + "?roomId=" + o.roomID + "&source=14&skin_id=" + o.room_skin_id + "&skin_level=" + o.room_skin_level + "&param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea() + "&module_type=" + o.module_type + "&page_capacity=" + o.page_capacity + "&room_list_pos=" + o.room_list_pos + "&tag_id=" + o.tag_id;
                    }
                    if (o.is_anchor_pk_room) {
                        o.url += "&is_pk=" + o.is_anchor_pk_room;
                    }
                } else if (o.bSuperRoom) {
                    o.url = consts.url.SHOW_ROOM + "?roomId=" + o.roomID + "&source=14&param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea() + "&module_type=" + o.module_type + "&page_capacity=" + o.page_capacity + "&room_list_pos=" + o.room_list_pos + "&tag_id=" + o.tag_id;
                } else {
                    o.url = consts.url.LIVE_ROOM + "?roomId=" + o.roomID + "&source=14&param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea() + "&module_type=" + o.module_type + "&page_capacity=" + o.page_capacity + "&room_list_pos=" + o.room_list_pos + "&tag_id=" + o.tag_id;
                }
            });
            this.reset(data);
        }
    });
    /**
     * 演唱会回放列表（单独的）
     * @type {void|*}
     */
    show_coll.CallbackRoomItemColl = backbone.Collection.extend({
        model: show_model.RoomItemModel,
        initialize: function(models) {
            if (models) {
                this.reset(models);
            }
        },
        reset_data: function(data) {
            $.each(data, function(i, o) {
                o.roomID = o.concert_id;
                o.anchorName = o.concert_name;
                o.pcVideoUrl = o.preview_pic;
                o.playerCount = o.accumulate_watch;
            });
            this.reset(data);
        }
    });
    if (!window.mgc) {
        window.mgc = {};
    }
    window.mgc.show_coll = show_coll;
    return show_coll;
});