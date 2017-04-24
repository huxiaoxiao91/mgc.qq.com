/*
* Author:             77
* Version:            1.0 (2015/11/11)
* Discription:        show模块模型
*/
define(['backbone', 'jquery'], function(backbone, $) {
    var show_model = {};
    /**
     * Tab页基础模型
     * @type {void|*}
     */
    show_model.TabModel = backbone.Model.extend({
        defaults: function() {
            return {
                tag_id: 0,
                tag_name: '标签名',
                tag_url: '',
                pageindex: 1,
                selected: false
            }
        },
        get_selected: function() {
            return this.get("selected");
        },
        set_selected: function(_selected) {
            if (this.get_selected() === _selected) {
                return;
            }
            this.set({ selected: _selected });
        },
        get_pageindex: function() {
            return this.get("pageindex");
        },
        set_pageindex: function(_pageindex) {
            _pageindex = parseInt(_pageindex);
            if (this.get_pageindex() === _pageindex) {
                return;
            }
            this.set({ pageindex: _pageindex });
        },
        get_tag_name: function() {
            return this.get("tag_name");
        },
        get_id: function() {
            return this.get("tag_id");
        },
        get_tag_url: function() {
            return this.get("tag_url");
        }
    });
    /**
     * room面板列表基础模型
     * @type {void|*}
     */
    show_model.RoomItemModel = backbone.Model.extend({
        defaults: function() {
            return {
                roomID: 0           //属性自然扩充
            }
        },
        get_roomid: function() {
            return this.get("roomID");
        }
    });
    if (!window.mgc) {
        window.mgc = {};
    }
    window.mgc.show_model = show_model;
    return show_model;
});