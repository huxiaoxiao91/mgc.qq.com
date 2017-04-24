/*
* Author:             77
* Version:            1.0 (2015/11/11)
* Discription:        index模块模型
*/
define(['backbone', 'jquery'], function (backbone, $) {
    var index_model = {};
    /*
    * 梦工厂快报-模型
    * @type {void|*}
    */
    index_model.AdModel = backbone.Model.extend({
        defaults: function () {
            return {
                sAdId: 0,           //id
                sAdUrl: "",         //广告外链
                sImageUrl: "",      //广告图
                sDesc: ""
            }
        }
    });
    index_model.getAdModel = new index_model.AdModel();
    if (!window.mgc) {
        window.mgc = {};
    }
    window.mgc.index_model = index_model;
    return index_model;
});