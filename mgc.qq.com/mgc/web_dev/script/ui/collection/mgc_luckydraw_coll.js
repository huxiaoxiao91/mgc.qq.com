/*
 * Author:            lpf
 * Version:            1.0 (2015/11/11)
 * Discription:        排行榜模块集合
 */
define(['backbone', 'jquery', 'mgc_luckydraw_model', 'mgc_consts'], function(backbone, $, luckydraw_model, consts) {
    var luckydraw_coll = {};
    luckydraw_coll.luckydrawItemColl = backbone.Collection.extend({
        model: luckydraw_model.luckyItemModel,
        initialize: function(models) {
            if (models) {
                this.reset(models);
            }
        },
        reset_data: function(data) {
            this.reset(data);
        }
    });
    luckydraw_coll.luckyNoticesColl=backbone.Collection.extend({
        model: luckydraw_model.luckyNoticesModel,
        initialize: function(models) {
            if (models) {
                this.reset(models);
            }
        },
        reset_data: function(data) {
            this.reset(data);
        }
    });
    return luckydraw_coll;
});