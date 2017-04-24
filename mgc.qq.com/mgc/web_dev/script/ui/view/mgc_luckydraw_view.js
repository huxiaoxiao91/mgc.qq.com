/**
 * @Description:   梦工厂web-视图-抽奖
 * @author         lpf
 * @Date           2016/10/11
 * @Company        horizon3d
 */
define(['jquery','backbone', 'mgc_tool','jsrender','mgc_luckydraw_coll', 'mgc_popmanager', 'mgc_account', 'mgc_tips'], function($,backbone, mgc_tool,jsrender,mgc_luckydraw_coll, mgc_popmanager, mgc_account, mgc_tips) {
    var lucky_view = {};
    lucky_view.luckydrawView = backbone.View.extend({
        el: "#draw_container",
        initialize: function() {
            this.template = $('#prize_tepl');
            this.listenTo(this.model, 'change', this.render);
        },
        render: function() {
            var luckInfoList = this.model.attributes;
            var tmpl = this.template.render(luckInfoList);
            this.$el.append(tmpl);
            // 设置奖品的位置
            $('#draw_container').find("#prize1").attr("class", "prize selected");
            var size = 113;
            var spaceRight = 24;
            var spaceBottom = -1;
            var top = 0;
            var left = 10;
            var top1 = top;
            var top2 = top + size + spaceBottom;
            var top3 = top + (size + spaceBottom) * 2;
            var top4 = top + (size + spaceBottom) * 3;
            var left1 = left;
            var left2 = left + size + spaceRight;
            var left3 = left + (size + spaceRight) * 2;
            var left4 = left + (size + spaceRight) * 3;
            $("#prize1,#prize2,#prize3,#prize4").css({
                "top": top1
            });
            $("#prize7,#prize8,#prize9,#prize10").css({
                "top": top4
            });
            $("#prize6,#prize11").css({
                "top": top3
            });
            $("#prize5,#prize12").css({
                "top": top2
            });
            $("#prize1,#prize10,#prize11,#prize12").css({
                "left": left1
            });
            $("#prize2,#prize9").css({
                "left": left2
            });
            $("#prize3,#prize8").css({
                "left": left3
            });
            $("#prize4,#prize5,#prize6,#prize7").css({
                "left": left4
            });
            return this;
        },
    });
    lucky_view.luckyNoticesView = backbone.View.extend({
        el: "#record_list_con",
        initialize: function() {
            this.template = $.templates('#draw_record_tmpl');
            this.listenTo(this.model, 'change', this.render);
        },
        render:function () {
            var luckInfoList = this.model.attributes;
            var tmpl = this.template.render(luckInfoList);  //用数据渲染模板
            this.$el.append(tmpl);   //添加到页面元素中
        }
    });
    return lucky_view;
});