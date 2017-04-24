/* ========================================================================
* 【本类功能概述】
* 节日活动模块集合
* 作者：shixinqi 时间：2016-09-28
* 文件名：mgc_festival_activity_coll
* 版本：V1.0.1
* 修改者： 时间： 
* 修改说明：
* ========================================================================
*/
define(['jquery', 'backbone', 'mgc_config', 'mgc_festival_activity_model'], function($, backbone, config, festival_activity_model) {
    var coll = {};
    /*
    * 节日活动模板集合
    */
    coll.FestivalActivityColl = backbone.Collection.extend({
        // Reference to this collection's model.
        model: festival_activity_model.FestivalActivity,
        /*
        * 设置集合数据
        * @param data 模型数据
        */
        resetData: function(data) {
            this.reset(data);
        }
    });
    // Create our global collection of **GiftUnitColl**.
    coll.FestivalActivityList = new coll.FestivalActivityColl;
    return coll;
});