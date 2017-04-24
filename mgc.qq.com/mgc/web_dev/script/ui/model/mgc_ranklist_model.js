/*
* Author:             77
* Version:            1.0 (2015/11/11)
* Discription:        排行榜模块模型
*/
define(['backbone', 'jquery', 'mgc_consts'], function (backbone, $, consts) {
    var ranklist_model = {};
    /*
     * 排行榜玩家-模型
     * @type {void|*} 排名 class 主播头像 主播名称 主播状态  房间id 排名变化 排名变化绝对值 排名图标 积分数值 主播等级  玩家头像 玩家昵称  玩家财富等级  玩家大区 贵族等级 贵族等级名称 后援团名称 
     * 此处因左右榜单字段命名不尽相同，so  暂时先不统一化 ： 后期处理
     */
    ranklist_model.RankItemModel = backbone.Model.extend({
        defaults: function () {
            return {
                no: 1,                          //排名no
                noStr: "",                       //排名字符串
                m_is_nest: true,                //是否个人直播间
                m_anchor_status: 0,             //直播状态
                m_anchor_name: "",              //主播名
                m_anchor_level: 0,              //主播等级
                m_score: "",                    //主播积分
                m_room_id: 0,                   //房间id
                m_order_change: 0,              //排名变化
                m_anchor_portrait_url: ""       //主播头像
            }
        },
        set_data: function (data) {
            this.set(data);
        }
    });
    ranklist_model.getRankItemModel = new ranklist_model.RankItemModel();
    return ranklist_model;
});