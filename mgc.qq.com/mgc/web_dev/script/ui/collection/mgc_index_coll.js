/*
* Author:             77
* Version:            1.0 (2015/11/11)
* Discription:        index模块集合
*/
define(['backbone', 'jquery', 'mgc_index_model'], function (backbone, $, index_model) {
    var index_coll = {};
    /*
    * 梦工厂快报-集合
    * @type {void|*}
    */
    index_coll.AdColl = backbone.Collection.extend({
        model: index_model.AdModel,
        initialize: function (models) {
            if (models) {
                this.reset(models);
            }
        }
    }); 
    if (!window.mgc) {
        window.mgc = {};
    }
    window.mgc.index_coll = index_coll;
    return index_coll;
});