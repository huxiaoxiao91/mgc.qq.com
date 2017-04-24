/* ========================================================================
* 【本类功能概述】
* 节日活动模块视图
* 作者：shixinqi 时间：2016-09-28
* 文件名：mgc_festival_activity_view
* 版本：V1.0.1
* 修改者： 时间： 
* 修改说明：
* ========================================================================
*/
define(['underscore', 'jquery', 'backbone', 'mgc_config', 'mgc_consts', 'mgc_tool', 'mgc_popmanager', 'mgc_festival_activity_model', 'mgc_festival_activity_coll'], function(_, $, backbone, config, consts, tool, mgc_popmanager, festival_activity_model, festival_activity_coll) {
    var view = {};
    /*
    **===================================================
    * 节日活动模块视图
    **===================================================
    */
    view.FestivalActivityModuleView = backbone.View.extend({
        el: "#fa-con",
        model: festival_activity_model.FestivalActivity,
        gift_info: null,
        events: {
            "click #fa-send-one-gift,#fa-send-more-gift": "sendGiftClick",
            "mouseover #fa-send-one-gift,#fa-send-more-gift": "sendGiftTipsShow",
            "mouseout #fa-send-one-gift,#fa-send-more-gift": "sendGiftTipsHide",
            "click #fa-contribute-list-btn": "contributeListBtnClick",
            "click #fa-slide-btn": "slideMove",
            "mousedown #fa-slide-btn": "iconRed",
            "mouseover #fa-slide-btn":"iconShow",
            "mouseout #fa-slide-btn":"iconHide"
        },
        initialize: function(sendGift, getCommonActivityPlayerRank) {
            this.sendGiftCallback = sendGift;
            this.getCommonActivityPlayerRankCallback = getCommonActivityPlayerRank;
            this.faWarp = this.$("#fa-warp");
            this.faSide = this.$("#fa-side");
            this.faEndTimeTxt = this.$(".fa-end-time");
            this.faSendOneGiftBtn = this.$("#fa-send-one-gift");
            this.faSendMoreGiftBtn = this.$("#fa-send-more-gift");
            this.faGiftImg = this.$(".fa-gift-img");
            this.faRecvGiftsCountTxt = this.$("#fa-recv-gifts-count-txt");
            this.faAnchorRankTxt = this.$("#fa-anchor-rank-txt");
            this.faContributeListBtn = this.$("#fa-contribute-list-btn");
            this.faSlideBtn = this.$("#fa-slide-btn");
            this.faMoreInfomationA = this.$("#fa-more-infomation");
            this.faTips = this.$("#fa-tips");
            this.faLevelUpSwf = this.$(".fa-level-up-swf");
            this.faLevelBottomSwf = this.$(".fa-level-bottom-swf");
            this.listenTo(this.model, 'change:m_gift_id', this.giftIdChanged);
            this.listenTo(this.model, 'change:m_pannel_level', this.levelUp);
            this.listenTo(this.model, 'change', this.render);
        },
        render: function() {
            if (this.model.get("status")) {
                this.faWarp.removeClass().addClass("fa-level-" + this.model.get("m_pannel_level"));
                this.faSide.removeClass().addClass("fa-side fa-side-level-" + this.model.get("m_pannel_level"));
                this.faEndTimeTxt.text("结束时间：" + new Date(this.model.get("m_end_time")).format("MM月dd日hh点"));
                this.faEndTimeTxt.removeClass().addClass("fa-end-time fa-end-level-" + this.model.get("m_pannel_level"));
                this.faSendMoreGiftBtn.find(".fa-gift-txt").text("x" + this.model.get("m_max_send_num"));
                this.faMoreInfomationA.attr("href", this.model.get("m_more_detail_url")).addClass('target-blank');
                var _m_recv_gift_count = this.model.get("m_recv_gift_count");
                this.faRecvGiftsCountTxt.text(_m_recv_gift_count.toString().length > 9 ? "999999999+" : _m_recv_gift_count);
                var _m_anchor_rank = this.model.get("m_anchor_rank");
                this.faAnchorRankTxt.text((_m_anchor_rank > 100 || _m_anchor_rank <= 0) ? "未上榜" : _m_anchor_rank);
                this.$el.show();
                if (this.$el.hasClass("fa-hide")) {
                    $('.icon-slide').css({
                        backgroundPosition: '-752px -97px'
                    });
                } else {
                    $('.icon-slide').css({
                        backgroundPosition: '-447px -433px'
                    });
                }
            } else {
                this.$el.hide().width(312).removeClass("fa-hide");
                //捎带隐藏贡献榜
                mgc.giftRankModel.set("visible", false);
            }
            if(this.model.get("m_max_send_num")>1000){
                this.faSendMoreGiftBtn.find(".fa-gift-span").css('marginLeft','-13px');
            }
        },
        /*
        * 礼物id变化时 ， 读取当前礼物下的配置
        */
        giftIdChanged: function() {
            var gift_id = this.model.get("m_gift_id");
            if (MGCData.giftData && MGCData.giftData.length > 0) {
                for (var i = 0, length = MGCData.giftData.length; i < length; i++) {
                    if (MGCData.giftData[i].id == gift_id) {
                        this.gift_info = MGCData.giftData[i];
                        break;
                    }
                }
            }
            //更新礼物图标

            this.faGiftImg.attr("src", consts.filePath.IMG_PATH + "flash/gift/gift_" + gift_id + ".png");
            //清空榜单队列
            mgc.giftRankModel.set("giftList", []);
        },
        /*
        * 升级
        */
        levelUp: function() {
            var level = this.model.get("m_pannel_level");
            var is_level_up = this.model.get("m_is_level_up");
            if (this.$el.hasClass("fa-hide"))
                return;
            if (level > 1 && is_level_up) {
                window.mgc.UI_FA_close_flash_callback = this.levelUpEnd;
                this.faLevelUpSwf.show();
                //2级升3级特效做特殊处理
                if(level == 3){
                    this.faLevelBottomSwf.show();
                    tool.initSwf('fa-level-up-swf', 'fa-level-up-swf', 'assets/fa_level_up_' + level + '.swf');
                    tool.initSwf('fa-level-bottom-swf', 'fa-level-bottom-swf', 'assets/fa_level_bottom_' + level + '.swf');
                }else{
                    tool.initSwf('fa-level-up-swf', 'fa-level-up-swf', 'assets/fa_level_up_' + level + '.swf');
                }
            }
        },
        /*
        * 升级结束
        */
        levelUpEnd: function() {
            $(".fa-level-up-swf").hide().html('<p id="fa-level-up-swf"></p>');
            $(".fa-level-bottom-swf").hide().html('<p id="fa-level-bottom-swf"></p>');
        },
        /*
        * 送礼一个 / N个
        */
        sendGiftClick: function(e) {
            e = e || window.event;
            var obj = this.$(e.srcElement || e.currentTarget);
            var gift_id = this.model.get("m_gift_id");
            var gift_cnt = 1;
            if (obj.attr("id") == "fa-send-more-gift")
                gift_cnt = this.model.get("m_max_send_num");
            if (this.sendGiftCallback)
                this.sendGiftCallback(gift_id, gift_cnt);
        },
        /*
        * 送礼按钮tips show
        */
        sendGiftTipsShow: function(e) {
            e = e || window.event;
            var obj = this.$(e.srcElement || e.currentTarget);
            var gift_cnt = 1, top = 50, txt = "";
            if (obj.attr("id") == "fa-send-more-gift") {
                gift_cnt = this.model.get("m_max_send_num");
                top = 80;
            }
            txt = "点击花费" + this.gift_info.price * gift_cnt + "炫豆赠送活动礼物给心爱的ta，还能帮ta获得周年庆徽章哦~";
            this.faTips.css('top', top).html(txt).show();
        },
        /*
        * 送礼按钮tips hide
        */
        sendGiftTipsHide: function(e) {
            this.faTips.hide();
        },
        /*
        * 点击贡献榜事件
        */
        contributeListBtnClick: function() {
            if (this.getCommonActivityPlayerRankCallback)
                this.getCommonActivityPlayerRankCallback();
        },
        /*
        * 收起展开事件
        */
        slideMove: function() {
            var _this = this;
            if (_this.$el.hasClass("fa-hide")) {
                _this.$el.stop().animate({ width: 312 }, 500, function() {
                    _this.$el.removeClass("fa-hide");
                    _this.$el.find("#fa-warp").css("margin-right","0px");
                    _this.$el.find("#fa-side").css("margin-right","0px");
                    $('.icon-slide').css({
                        backgroundPosition: '-447px -433px'
                    });
                });

            } else {
                _this.$el.find("#fa-warp").css("margin-right","8px");
                _this.$el.find("#fa-side").css("margin-right","8px");
                _this.$el.stop().animate({ width: 46 }, 500, function() {
                    _this.$el.addClass("fa-hide");
                    $('.icon-slide').css({
                        backgroundPosition: '-752px -97px'
                    });
                });
            }
        },
        iconRed: function() {
            var _this = this;
            if (_this.$el.hasClass("fa-hide")) {
                $('.icon-slide').css({
                    backgroundPosition: '-922px -97px'
                });
            } else {
                $('.icon-slide').css({
                    backgroundPosition: '-617px -433px'
                });
            }
        },
        iconShow: function(){
            var _this = this;
            if (_this.$el.hasClass("fa-hide")) {
                $('.icon-slide').css({
                    backgroundPosition: '-832px -97px'
                });
            } else {
                $('.icon-slide').css({
                    backgroundPosition: '-527px -433px'
                });
            }
        },
        iconHide: function(){
            var _this = this;
            if (_this.$el.hasClass("fa-hide")) {
                $('.icon-slide').css({
                    backgroundPosition: '-752px -97px'
                });
            } else {
                $('.icon-slide').css({
                    backgroundPosition: '-447px -433px'
                });
            }
        }
    });


    /*
     * 贡献榜
     */
    view.GiftRankView = backbone.View.extend({
        el: ".gift-rank",

        template: _.template($("#sendGiftRankTmpl").html()),

        events: {
            "click .btn-close": "closeClick"
        },

        initialize: function() {
            this.model.on("change:visible", this.visibleChange, this);
            this.model.on("change:giftList", this.giftListChange, this);

            //滚动条
            this.$el.find(".row3").jScrollPane({
                autoReinitialise: true,
                animateScroll: true
            });
        },

        closeClick: function() {
            this.model.set("visible", false);
        },

        visibleChange: function() {
            var visible = this.model.get("visible");
            if (visible) {
                this.$el.show();
                this.resize();
                //重绘滚动条
                var scrollAPI = this.$el.find('.row3').data('jsp');
                if(scrollAPI){    
                    scrollAPI.initScroll();
                }

                $(document).off().mousedown(this, this.documentClick);
            }
            else {
                this.$el.hide();
                $(document).off();
            }
        },

        giftListChange: function() {
            var giftList = this.model.get("giftList");
            $.each(giftList, function(k, v) {
                if (k % 2 == 0) {
                    v.background_color = "#f3f3f3";
                }
                else {
                    v.background_color = "#ffffff";
                }
                v.rank = k + 1;
                v.m_pk_score = Math.round(v.m_pk_score / 1000);
            });

            var $ul = this.$el.find("ul");
            var $tip = this.$el.find(".tip");
            if (giftList.length == 0) {
                $tip.show();
                $ul.html("");
            } else {
                $tip.hide();
                $ul.html(this.template(giftList));
            }

            //重绘滚动条
            var scrollAPI = this.$el.find('.row3').data('jsp');
            if (scrollAPI) {
                scrollAPI.initScroll();
            }
        },

        documentClick: function(e) {
            var _this = e.data;
            if ($(e.target).parents(".gift-rank").length == 0) {
                _this.model.set("visible", false);
            }
        },

        resize: function() {
            //活动地板位置
            var top = $(".video_play").offset().top;
            var left = $(".video_play").offset().left;

            //活动地板长宽
            var width = $(".video_play").width();
            var height = $(".video_play").height();

            this.$el.offset({ top: top + height - 74, left: left + (tool.is_nest_room() ? 313 : 310) });
        }
    });

    return view;
});