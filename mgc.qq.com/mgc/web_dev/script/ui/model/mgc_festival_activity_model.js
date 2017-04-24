/* ========================================================================
* 【本类功能概述】
* 节日活动模块model
* 作者：shixinqi 时间：2016-09-28
* 文件名：mgc_festival_activity_model
* 版本：V1.0.1
* 修改者： 时间： 
* 修改说明：
* ========================================================================
*/
define(['jquery', 'backbone'], function($, backbone) {
    var model = {};
    /*
    * 节日活动模板单元model
    */
    model.FestivalActivityModel = backbone.Model.extend({
        // Default attributes for the todo item.
        defaults: function() {
            return {
                m_activity_id: 0,
                m_end_time: "",
                m_gift_id: 0,
                m_max_send_num: 0,
                m_anchor_rank: 0,
                m_recv_gift_count: 0,
                m_more_detail_url: '',
                m_pannel_level: 1,
                m_is_level_up: false,
                status: false
            };
        },
        resetData: function() {
            this.set({
                m_end_time: "",
                m_gift_id: 0,
                m_max_send_num: 0,
                m_anchor_rank: 0,
                m_recv_gift_count: 0,
                m_more_detail_url: '',
                m_pannel_level: 1,
                m_is_level_up: false,
                status: false
            });
        }
    });
    model.FestivalActivity = new model.FestivalActivityModel;
    model.GiftRankModel = backbone.Model.extend({
        defaults: {

            visible: false,

            /**
             * 粉丝贡献榜
             */
            giftList: null,
        }
    });
    return model;
});