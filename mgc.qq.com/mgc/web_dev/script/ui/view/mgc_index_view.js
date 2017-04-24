/*
* Author:             77
* Version:            1.0 (2015/11/11)
* Discription:        index模块视图
*/
define(['backbone', 'jquery', 'mgc_templates', 'mgc_index_coll'], function (backbone, $, templates, index_coll) {
    var index_view = {};
    /*
    * 梦工厂快报-视图
    * @type {void|*}
    */
    index_view.AdView = backbone.View.extend({
        tagName: "li",
        template: _.template(templates.get_ad_tmpl()),
        initialize: function () {
            this.listenTo(this.model, 'reset', this.render);
        },
        render: function () {
            this.$el.html(this.template(this.model.attributes));
            return this;
        }
    });
    if (!window.mgc) {
        window.mgc = {};
    }
    window.mgc.index_view = index_view;
    return index_view;
});