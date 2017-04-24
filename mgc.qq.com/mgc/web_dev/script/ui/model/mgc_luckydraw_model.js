/**

 * @Description:   梦工厂web-视图-抽奖
 * @author         lpf
 * @Date           2016/10/11
 * @Company        horizon3d
 */
define(['backbone', 'mgc_tool', 'mgc_consts'], function(backbone, mgc_tool, mgc_consts) {
    var luckydraw_model = {};
    luckydraw_model.luckyItemModel = backbone.Model.extend({
        defaults: function() {
            return {
                numid: 0,              //第几个id
                url: '',              //角色图片的URL
                channel: 0,          //渠道
                count_desc:1,       //数量
                type:0,             //奖励类型
                rare:false,        //是否稀有
                star_gift:false,    //是否周星
                prizeTips:null,
                tipsWidth:null
            }
        },
    });
    luckydraw_model.luckyNoticesModel = backbone.Model.extend({
        defaults: function(obj) {
            return {
                nick: "obj.nick",         //玩家昵称
                prize: ""//奖项名称及个数
            }
        },
    });

    return luckydraw_model;
});
