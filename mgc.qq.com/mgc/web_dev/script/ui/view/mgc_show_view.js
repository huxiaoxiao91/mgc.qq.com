/*
* Author:             77
* Version:            1.0 (2015/11/11)
* Discription:        show模块视图
* @todo:              Tab页单个按钮视图、房间列表list：标签切换tab视图、Tab按钮组视图
* @todo:              room面板列表基础视图、房间列表list：room集合视图
*/
define(['backbone', 'jquery', 'mgc_templates', 'mgc_show_coll', 'mgc_tool'], function(backbone, $, templates, show_coll, tool) {
    var show_view = {};
    /**
     * Tab页单个按钮视图  click
     * @type {void|*}
     */
    show_view.TabView = backbone.View.extend({
        tagName: 'li',                                                  //这个可能根据视图不同而值不同，要派生
        template: _.template(templates.get_tab_pagetag_tmpl()),   //这个可能根据视图不同而值不同，要派生
        initialize: function() {
            this.listenTo(this.model, 'change:selected', this.render_select_change);
        },
        render: function() {
            return this.render_select_change();
        },
        //视图的各种交互时间监听
        events: {
            "click": "click"
        },
        click: function() {
            //触发一个自定义事件,用于子视图将消息传递给其他视图。
            this.trigger("mgc_click:tab", this.model.get_id());
        },
        render_select_change: function() {
            //绘制视图，这里根据视图不同而不同，可以派生
            //console.log("TabView render_select_change:" + this.model.get_tag_name() + ",status:" + this.model.get_selected());
            //变换显示
            this.$el.html(this.template(this.model.attributes));
            if (this.model.attributes.display != undefined) {
                this.$el.addClass(this.model.attributes.display);
            }
            return this;
        },
        render_pageindex_change: function() {
            //下一页
            //console.log("TabView render_pageindex_change:" + this.model.get_tag_name() + ",pageindex:" + this.model.get_pageindex());

        }
    });
    /**
     * Tab页单个按钮视图  hover
     * @type {void|*}
     */
    show_view.TabHoverView = backbone.View.extend({
        tagName: 'li',                                                  //这个可能根据视图不同而值不同，要派生
        template: _.template(templates.get_tab_rank_tmpl()),   //这个可能根据视图不同而值不同，要派生
        initialize: function() {
            this.listenTo(this.model, 'change:selected', this.render_select_change);
        },
        render: function() {
            return this.render_select_change();
        },
        //视图的各种交互时间监听
        events: {
            "mouseover": "mouseover"
        },
        mouseover: function() {
            //触发一个自定义事件,用于子视图将消息传递给其他视图。
            this.trigger("mgc_mouseover:tab", this.model.get_id());
        },
        render_select_change: function() {
            //绘制视图，这里根据视图不同而不同，可以派生
            //console.log("TabView render_select_change:" + this.model.get_tag_name() + ",status:" + this.model.get_selected());
            //变换显示
            this.$el.html(this.template(this.model.attributes));
            return this;
        }
    });
    /*
    *排行榜时间维度：tab切换
    */
    show_view.RankTabView = backbone.View.extend({
        className: "rank_tab",
        model_coll: null,
        select_change_callback: null,
        initialize: function(id, model_coll, default_select, _select_change_callback) {
            this.id = id;
            this.el = $("#" + id + "_tab");
            this.show_tab_ul = this.el.find("ul");
            this.select_change_callback = _select_change_callback;
            this.model_coll = model_coll;
            this.listenTo(this.model_coll, 'mgc_sel_change:tab', this.on_select_changed);
            this.listenTo(this.model_coll, 'reset', this.on_select_changed);
            var len = this.model_coll.length;
            this.show_tab_ul.children().remove();
            for (var i = 0; i < len; i++) {
                var tab_hover_view = new show_view.TabHoverView({ model: this.model_coll.models[i] });
                this.listenTo(tab_hover_view, 'mgc_mouseover:tab', this.tab_mouseover);
                this.show_tab_ul.append(tab_hover_view.render().el);
            }
            //触发默认选择
            default_select = default_select || 0;
            this.tab_mouseover(default_select);
        },
        render: function() {
            return this;
        },
        tab_mouseover: function(id) {
        	if (this.id == "anchor_meili") {
                switch (id) {
                    case 0:
                        $m('.rc_meili .score').html("今日魅力值");
                        $m(".rc_meili .tips2").html("日榜房间魅力值<strong>每天0点</strong>清空重新累计。");
                        break;
                    case 1:
                        $m('.rc_meili .score').text("本周魅力值");
                        $m(".rc_meili .tips2").html("周榜房间魅力值<strong>每周一0点</strong>清空重新累计。");
                        break;
                    case 2:
                        $m('.rc_meili .score').text("本月魅力值");
                        $m(".rc_meili .tips2").html("月榜房间魅力值<strong>每月1日0点</strong>清空重新累计。");
                        break;
                    case 3:
                        $m('.rc_meili .score').text("总魅力值");
                        $m(".rc_meili .tips2").html("统计房间总魅力值，不会清空");
                        break;
                    default:
                        break;
                }
            }
            if (this.id == "anchor_xingyao") {
                switch (id) {
                    case 0:
                        $m('.rc_xy_info .score').html("今日星耀值");
                        $m(".xy_con .tips").html("日榜星耀值<strong>每天0点</strong>清空重新累计。");
                        break;
                    case 1:
                        $m('.rc_xy_info .score').text("本周星耀值");
                        $m(".xy_con .tips").html("周榜星耀值<strong>每周一0点</strong>清空重新累计。");
                        break;
                    case 2:
                        $m('.rc_xy_info .score').text("本月星耀值");
                        $m(".xy_con .tips").html("月榜星耀值<strong>每月1日0点</strong>清空重新累计。");
                        break;
                    case 3:
                        $m('.rc_xy_info .score').text("星耀值");
                        $m(".xy_con .tips").html("");
                        break;
                    default:
                        break;
                }
            }
            if (this.id == "anchor_qinmidu") {
                switch (id) {
                    case 0:
                        $m('.rc_qmd_info .zqmd').html("日亲密度");
                        break;
                    case 1:
                        $m('.rc_qmd_info .zqmd').text("周亲密度");
                        break;
                    case 2:
                        $m('.rc_qmd_info .zqmd').text("月亲密度");
                        break;
                    case 3:
                        $m('.rc_qmd_info .zqmd').text("亲密度");
                        break;
                    default:
                        break;
                }
            }
            if (this.id == "anchor_jifen") {
                switch (id) {
                    case 0:
                        $m('.rc_jifen .rc_con_info .score').html("今日主播积分");
                        $m(".jf_con .tips strong").html("每天0点");
                        break;
                    case 1:
                        $m('.rc_jifen .rc_con_info .score').text("本周主播积分");
                        $m(".jf_con .tips strong").html("每周一0点");
                        break;
                    case 2:
                        $m('.rc_jifen .rc_con_info .score').text("本月主播积分");
                        $m(".jf_con .tips strong").html("每月1日0点");
                        break;
                    default:
                        break;
                }
            }
            this.model_coll.select(id);
        },
        on_select_changed: function(selected_id) {
            console.log("rank tab view on_select_changed:" + selected_id);
            if (this.select_change_callback) {
                this.select_change_callback(selected_id, 1);
            }
        }
    });
    /*
    *房间列表list：标签切换tab视图
    */
    show_view.PageTagTabView = backbone.View.extend({
        el: $("#show_tab"),
        events: {
            "click .pageUp": "PrePage",
            "click .pageDown": "NextPage"
        },
        model_coll: null,
        page_sum: 0,        //总页数
        page_count: 0,      //总条数
        page_index: 1,      //当前页
        page_num: 8,        //每页条数
        page_li_width: 0,   //每条宽度
        select_change_callback: null,
        initialize: function(model_coll, default_select, page_num, _select_change_callback) {
            this.page_num = page_num || 8;
            this.show_tab_ul = this.$el.find("ul");
            this.select_change_callback = _select_change_callback;
            this.model_coll = model_coll;
            this.listenTo(this.model_coll, 'mgc_sel_change:tab', this.on_select_changed);
            this.listenTo(this.model_coll, 'reset', this.on_select_changed);
            var len = this.model_coll.length;
            this.show_tab_ul.children().remove();
            for (var i = 0; i < len; i++) {
                var tab_view = new show_view.TabView({ model: this.model_coll.models[i] });
                tab_view.template = _.template(templates.get_tab_pagetag_tmpl());
                this.listenTo(tab_view, 'mgc_click:tab', this.tab_clicked);
                this.show_tab_ul.append(tab_view.render().el);
            }
            this.page_count = len;
            this.page_sum = Math.ceil(this.page_count / this.page_num);
            this.page_li_width = this.show_tab_ul.find("li:eq(0)").width();
            if (this.page_count > this.page_num) {
                this.$el.find(".page-opt").show();
            } else {
                this.$el.find(".page-opt").hide();
            }
            //触发默认选择
            if (default_select) {
                this.tab_clicked(default_select);
                //初始化当前tab位置
                var _left = 0;
                var current_index = this.$el.find(".current").parent().index() + 1;
                if (current_index > this.page_num) {//当前选择项不在第一页
                    var _page_index = Math.ceil(current_index / this.page_num);
                    if (_page_index == this.page_sum) {//当前选项在最后一页
                        _left = (this.page_count - this.page_num) * this.page_li_width;
                        //禁用右翻页按钮
                        this.$el.find("#pageDown").removeClass().addClass("pageDown_prev");
                    } else {
                        _left = (_page_index - 1) * this.page_num * this.page_li_width;
                    }
                    this.page_index = _page_index;//初始化当前页码
                } else {
                    //禁用左翻页按钮
                    this.$el.find("#pageUp").removeClass().addClass("pageUp_prev");
                }
                this.show_tab_ul.css("left", -_left);
            }
        },
        render: function() {
            return this;
        },
        tab_clicked: function(id) {
            this.model_coll.select(id);
        },
        on_select_changed: function(selected_id, pageindex) {
            console.log("PageTagTabView on_select_changed:" + selected_id);
            if ($("#ylby_more")) {
                $("#ylby_more").attr("href", "show.shtml#" + selected_id);
            }
            $(".show_con ul").children().remove();
            if (this.select_change_callback) {
                this.select_change_callback(selected_id, pageindex, this.show_tab_ul);
            }
        },
        PrePage: function() {
            var start_index = 0;
            var end_index = 0;
            if (this.page_index > 1) {
                this.page_index--;
                var _left = this.page_li_width * this.page_num * (this.page_index - 1);
                this.show_tab_ul.animate({ "left": -_left }, 100);
                //随着翻页的变化，去改变当前选定的项
                start_index = (this.page_index - 1) * this.page_num;
                end_index = start_index + this.page_num - 1;
                this.NewPageSelect(start_index, end_index);
            }
            if (this.page_index == 1) {
                this.$el.find("#pageUp").removeClass().addClass("pageUp_prev");
                this.$el.find("#pageDown").removeClass().addClass("pageDown");
            } else {
                this.$el.find("#pageUp").removeClass().addClass("pageUp");
                this.$el.find("#pageDown").removeClass().addClass("pageDown");
            }
        },
        NextPage: function() {
            var start_index = 0;
            var end_index = 0;
            if (this.page_index < this.page_sum) {
                var differ_num = 0; //翻页过程中不足一页的情况下，补齐
                if (this.page_index == this.page_sum - 1) {
                    differ_num = this.page_num - this.page_count % this.page_num;
                }
                var _left = this.page_li_width * (this.page_num * this.page_index - differ_num);
                this.show_tab_ul.animate({ "left": -_left }, 100);
                //随着翻页的变化，去改变当前选定的项
                start_index = this.page_num * this.page_index - differ_num;
                end_index = start_index + this.page_num - 1;
                this.NewPageSelect(start_index, end_index);
                this.page_index++;
            }
            if (this.page_index == this.page_sum) {
                this.$el.find("#pageUp").removeClass().addClass("pageUp");
                this.$el.find("#pageDown").removeClass().addClass("pageDown_prev");
            } else {
                this.$el.find("#pageUp").removeClass().addClass("pageUp");
                this.$el.find("#pageDown").removeClass().addClass("pageDown");
            }
        },
        /*
        *@_start_index     当前页的开始索引
        *@_end_index       当前页的结束索引
        */
        NewPageSelect: function(_start_index, _end_index) {
            var current_index = this.$el.find(".current").parent().index();
            if (current_index < _start_index || current_index > _end_index) {
                //当前选中的项目不在本页面时，默认选中本页的第一条项目
                this.$el.find("li").eq(_start_index).click();
            }
        }
    });
    /**
     * Tab按钮组视图
     * @type {void|*}
     */
    show_view.TabNavView = backbone.View.extend({
        el: $("#nav"),                                  //具体显示根据使用的地方不同而不同，可以派生
        select_change_callback: null,                   //执行一次变更后告知外部执行其他逻辑，这里可以用自定义事件？
        model_coll: null,                               //tab组用的模型集合，初始化时传入
        initialize: function(id, model_coll, default_select, _select_change_callback) {
            this.$el = $(id);
            this.select_change_callback = _select_change_callback;
            this.model_coll = model_coll;
            this.listenTo(this.model_coll, 'mgc_sel_change:tab', this.on_select_changed);
            this.listenTo(this.model_coll, 'reset', this.on_select_changed);
            var len = this.model_coll.length;
            this.$el.children().remove();
            for (var i = 0; i < len; i++) {
                var tab_view = new show_view.TabView({ model: this.model_coll.models[i] });
                tab_view.template = _.template(templates.get_header_nav_menu_tmpl());
                var _el = tab_view.render().el;
                if (id != "#nav" && id != "#h-nav") {
                    this.listenTo(tab_view, 'mgc_click:tab', this.tab_clicked);
                }
                this.$el.append(_el);
            }
            var dis_block = this.$el.find('.dis-block');
            if (id == "#nav") {
                dis_block.eq(dis_block.length - 1).addClass("background-none");
            } else if (id == "#h-nav") {
                if(tool.is_caveolae_room() || tool.is_nest_room()){
                    var len = dis_block.length;
                    var dis_none = this.$el.find('.dis-none');
                    var aside = dis_none[dis_none.length - 1];
                    $(aside).removeClass().addClass("dis-block");
                    dis_block[len] = dis_none[dis_none.length - 1];
                    dis_block.length += 1;
                }
                dis_block.eq(dis_block.length - 1).find("strong").addClass("background-none");
            }
            $('.nav7').addClass('target-blank');
            //触发默认选择
            default_select = default_select || 0;
            if (default_select) {
                this.tab_clicked(default_select);
            }
        },
        tab_clicked: function(id) {
            this.model_coll.select(id);
        },
        on_select_changed: function(selected_id, pageindex) {
            console.log("TabNavView on_select_changed:" + selected_id);
            if (this.$el.selector == "#rc_tab")
                $(".rc_con").hide().eq(selected_id - 1).show();
            if (this.select_change_callback) {
                this.select_change_callback(selected_id, pageindex);
            }
        }
    });
    /**
     * room面板列表基础视图
     * @type {void|*}
     */
    show_view.RoomItemView = backbone.View.extend({
        tagName: 'li',                                                  //这个可能根据视图不同而值不同，要派生
        template: _.template(templates.get_room_item_tmpl()),           //这个可能根据视图不同而值不同，要派生
        status: 0, //标识是否是演唱会回放页面
        initialize: function(_model) {
            if(_model._tmpl != null){
                this.template = $("#PlaybackListTmpl");
                this.status = 1;
            } else{
                this.template = $("#RoomListTmpl");
                this.status = 0;
            }
            
            this.listenTo(this.model, 'reset', this.render);
        },
        render: function() {
            //绘制视图，这里根据视图不同而不同，可以派生
            //console.log("RoomItemView render:" + this.model.get_roomid());
            //变换显示
            if(this.status == 1){
                var tmpl = this.template.render(this.model.attributes);
            } else{
                var tmpl = this.template.tmpl(this.model.attributes);
            }
            
            this.$el.html(tmpl);
            tmpl = null;
            return this;
        },
        //视图的各种交互时间监听
        events: {
            "mouseover": "mouseover",
            "mouseout": "mouseout",
            "mouseover .badge": "mouseoverBadge",
            "mouseout .badge": "mouseoutBadge"
        },
        mouseover: function() {
            //不添加事件的元素
            if (this.$el.parent(".no-event").length > 0)
                return;
            this.$el.css("border-color", "#6a41c6");
            this.$(".room-cover").show();
        },
        mouseout: function() {
            //不添加事件的元素
            if (this.$el.parent(".no-event").length > 0)
                return;
            this.$el.css("border-color", "#f5f5f5");
            this.$(".room-cover").hide();
        },
        mouseoverBadge: function() {
            $('body').on('mouseover', 'em[class^="badge"],i[class^="badge"]', function(e) {
                var badge_id = $(this).attr('mgc_data');
                var tips='';
                if (badge_id == '0') {
                    return;
                } else if (badge_id) {
                    tips = window.mgc.config.BADGE_CONFIG[badge_id].badge_tips;
                }
                if($(this).hasClass("big_badge")){
                    tool.susTipsBadge(e, 1, tips);
                } else{
                    tool.susTipsHtmlPop(e, 1, tips);
                }
                

            });
        },
        mouseoutBadge: function() {
            $('body').on('mouseout', 'em[class^="badge"],i[class^="badge"]', function(e) {
                tool.susTipsHtmlPop(e, 0);
            });
        }
    });
    /*
    *房间列表list：room集合视图
    */
    show_view.RoomListView = backbone.View.extend({
        el: null,
        model_coll: null,
        callback: null,
        initialize: function(_el, _model_coll, _tmpl, _callback) {
            this.el = $(_el);
            this.model_coll = _model_coll;
            this.callback = _callback;
            this._tmpl = _tmpl;
            var len = this.model_coll.length;
            for (var i = 0; i < len; i++) {
                var num = this.model_coll.models[i].attributes["playerCount"];
                this.model_coll.models[i].attributes["playerCount"] = tool.roomListNumFormat(num);
                var room_item_view = new show_view.RoomItemView({ model: this.model_coll.models[i], _tmpl: _tmpl, _el: _el });
                this.el.append(room_item_view.render().el);
            }
        },
        render: function() {
            return this;
        }
    });
    if (!window.mgc) {
        window.mgc = {};
    }
    window.mgc.show_view = show_view;
    return show_view;
});