/*
* Author:             77
* Version:            1.0 (2015/11/11)
* Discription:        排行榜模块视图
*/
define(['backbone', 'jquery', 'mgc_ranklist_coll', 'mgc_callcenter', 'mgc_consts', 'mgc_tool'], function(backbone, $, templates, ranklist_coll, callcenter, consts, tool) {
    var ranklist_view = {};
    /*
    *排行榜单行视图
    */
    ranklist_view.RankItemView = backbone.View.extend({
        tagName: "li",
        template: null,
        events: {},
        initialize: function(model) {
            this.listenTo(this.model, 'reset', this.render);
        },
        render: function() {
            this.el = this.template.tmpl(this.model.attributes);
            this.el[0].className = this.model.attributes.noStr;
            return this;
        }
    });
    ranklist_view.RankContainerView = backbone.View.extend({
        el: null,
        model_coll: null,
        initialize: function(_id, _model_coll) {
            this.el = $("#" + _id + "_container");
            this.template = $("." + _id + "_tmpl");
            this.model_coll = _model_coll;
            this.el.children().remove();
            var len = this.model_coll.length;
            for (var i = 0; i < len; i++) {
                var rank_item_view = new ranklist_view.RankItemView({ model: this.model_coll.models[i] });
                rank_item_view.template = this.template;
                this.el.append(rank_item_view.render().el);
            }
        },
        render: function() {
            return this;
        }
    });
    return ranklist_view;
});