/**
 * Created by WJ on 2016/8/22.
 */

define(['underscore','backbone', 'jquery','mgc_callcenter'], function (_,Backbone,$,callcenter) {

    var pkrank = {};

    pkrank.RankPaneModel = Backbone.Model.extend({
        defaults:{
            /**
             * TAB索引
             */
            tabIndex:-1,

            visible:false,

            /**
             * PK总值榜
             */
            anchorList:null,

            /**
             * 本场贡献榜
             */
            fansList:null,

            /**
             * PK总值
             */
            totalPK:0
        }
    });

    pkrank.RankPaneView = Backbone.View.extend({

        el:".pk-rank",

        model:pkrank.RankPaneModel,

        template:_.template($("#pkRankTmpl").html()),

        template1:_.template($("#pkFansRankTmpl").html()),

        events:{
            "click .btn-close":"closeClick",
            "click .btn-tab":"tabClick"
        },

        initialize: function () {
            this.model.on("change:visible",this.visibleChange,this);
            this.model.on("change:tabIndex",this.tabIndexChange,this);
            this.model.on("change:totalPK",this.totalPKChange,this);
            this.model.on("change:anchorList",this.anchorListChange,this);
            this.model.on("change:fansList",this.fansListChange,this);

            this.model.set("tabIndex",0);

            this.model.set("anchorList",[]);
            this.model.set("fansList",[]);

            //$(window).resize(this,this.onResize);

            //滚动条
            this.$el.find(".row-anchor .row4").jScrollPane({
                autoReinitialise: true,
                animateScroll: true
            });

            this.$el.find(".row-fans .row4").jScrollPane({
                autoReinitialise: true,
                animateScroll: true
            });
        },

        closeClick:function(){
            this.model.set("visible",false);
        },

        tabClick:function(e){
            var tabIndex = $(e.target).data("tabindex");
            this.model.set("tabIndex",tabIndex);
        },

        documentClick:function(e){
            var _this = e.data;
            if($(e.target).parents(".pk-rank").length == 0)
            {
                _this.model.set("visible",false);
            }
        },

        visibleChange:function(){
            var visible = this.model.get("visible");
            if(visible)
            {
                this.$el.show();
                this.resize();
                //重绘滚动条
                var scrollAPI = this.$el.find('.row-anchor .row4').data('jsp');
                if(scrollAPI){
                    scrollAPI.initScroll();
                }

                $(document).off().mousedown(this,this.documentClick);
            }
            else{
                this.$el.hide();
                this.model.set("tabIndex",0);
                $(document).off();
            }
        },

        tabIndexChange:function(){
            var tabIndex = this.model.get("tabIndex");
            this.$el.find(".btn-tab").removeClass("on");
            this.$el.find(".btn-tab[data-tabIndex=" + tabIndex + "]").addClass("on");

            this.$el.find(".tab").hide();
            this.$el.find(".tab").eq(tabIndex).show();

            var scrollAPI = this.$el.find('.tab .row4').eq(tabIndex).data('jsp');
            if(scrollAPI)
            {
                scrollAPI.initScroll();
            }
        },

        totalPKChange:function(){
            var totalPK = this.model.get("totalPK");
            totalPK = Math.round(totalPK/1000);
            this.$el.find(".text-total span").html(totalPK);
        },

        anchorListChange:function(){
            var anchorList = this.model.get("anchorList");
            $.each(anchorList,function(k,v) {
                if (k % 2 == 0)
                {
                    v.background_color = "#f3f3f3";
                }
                else{
                    v.background_color = "#ffffff";
                }

                v.anchor_level_bg = Math.floor(v.m_anchor_level / 10) + 1;
                if (v.m_anchor_level == 0) {
                    v.anchor_level_bg = 0;
                }

                v.rank = k + 1;

                v.m_pk_value = Math.round(v.m_pk_value/1000);
            });

            var $ul = this.$el.find(".row-anchor ul");
            var $tip = this.$el.find(".row-anchor .tip");
            if(anchorList.length == 0)
            {
                $tip.show();
                $ul.html("");
            }else
            {
                $tip.hide();
                $ul.html(this.template(anchorList));
            }

            //重绘滚动条
            var scrollAPI = this.$el.find('.row-anchor .row4').data('jsp');
            if(scrollAPI)
            {
                scrollAPI.initScroll();
            }
        },

        fansListChange:function(){
            var fansList = this.model.get("fansList");
            $.each(fansList,function(k,v) {
                if (k % 2 == 0)
                {
                    v.background_color = "#f3f3f3";
                }
                else {
                    v.background_color = "#ffffff";
                }
                v.rank = k + 1;
                v.m_pk_score = Math.round(v.m_pk_score/1000);
            });

            var $ul = this.$el.find(".row-fans ul");
            var $tip = this.$el.find(".row-fans .tip");
            if(fansList.length == 0)
            {
                $tip.show();
                $ul.html("");
            }else
            {
                $tip.hide();
                $ul.html(this.template1(fansList));
            }

            //重绘滚动条
            var scrollAPI = this.$el.find('.row-fans .row4').data('jsp');
            if(scrollAPI)
            {
                scrollAPI.initScroll();
            }
        },

        resize:function(){
            //PK榜按钮位置
            var top = $(".btn-pk").offset().top;
            var left = $(".btn-pk").offset().left;

            //PK榜按钮长宽
            var width = $(".btn-pk").width();
            var height = $(".btn-pk").height();

            this.$el.offset({top: top + height, left: left + 6});
        },

        onResize:function(e){
            var _this = e.data;
            _this.resize();
        }

    });



    //mgc.rankPaneView = rankPaneView;
    //mgc.rankPaneModel = rankPaneModel;

    //rankPaneModel.set("anchorList",[{m_anchor_level:1,m_anchor_name:"主播名八个大字",m_pk_value:"9999999"},{m_anchor_level:25,m_anchor_name:"主播名八个大字",m_pk_value:"999999"},{m_anchor_level:8,m_anchor_name:"主播名八个大字",m_pk_value:"9999999"},{m_anchor_level:12,m_anchor_name:"主播名八个大字",m_pk_value:"9999999"},{m_anchor_level:62,m_anchor_name:"主播名八个大字",m_pk_value:"9999999"},{m_anchor_level:78,m_anchor_name:"主播名八个大字",m_pk_value:"9999999"},{m_anchor_level:66,m_anchor_name:"主播名八个大字",m_pk_value:"9999999"},{m_anchor_level:51,m_anchor_name:"主播名八个大字",m_pk_value:"9999999"},{m_anchor_level:36,m_anchor_name:"主播名八个大字",m_pk_value:"9999999"},{m_anchor_level:40,m_anchor_name:"主播名八个大字",m_pk_value:"9999999"}]);
    //rankPaneModel.set("fansList",[{m_level:5,m_nick:"玩家名字八个大字",m_pk_score:"9999999"},{m_level:3,m_nick:"玩家名字八个大字",m_pk_score:"9999999"},{m_level:1,m_nick:"玩家名字八个大字",m_pk_score:"9999999"},{m_level:6,m_nick:"玩家名字八个大字",m_pk_score:"9999999"},{m_level:6,m_nick:"玩家名字八个大字",m_pk_score:"9999999"},{m_level:9,m_nick:"玩家名字八个大字",m_pk_score:"9999999"},{m_level:8,m_nick:"玩家名字八个大字",m_pk_score:"9999999"},{m_level:8,m_nick:"玩家名字八个大字",m_pk_score:"9999999"},{m_level:4,m_nick:"玩家名字八个大字",m_pk_score:"9999999"},{m_level:2,m_nick:"玩家名字八个大字",m_pk_score:"9999999"}]);
    //rankPaneModel.set("totalPK",9998);

    var rankPaneModel;
    var rankPaneView;

    callcenter.listenToInited(function() {
        rankPaneModel = new pkrank.RankPaneModel();
        rankPaneView = new pkrank.RankPaneView({model:rankPaneModel, el:".pk-rank"});
        mgc.rankPaneModel = rankPaneModel;
        mgc.rankPaneView = rankPaneView;

        var $btn_pk = $(".btn-pk");
        $btn_pk.off().click(function() {
            if (isLoginCallback) {
                var visible = rankPaneModel.get("visible");
                rankPaneModel.set("visible", !visible);
            }
        });
    });

    callcenter.addRespListener(callcenter.OP_TYPE.REFRESH_ANCHOR_PKRank, onRefreshAnchorPKRank);
    callcenter.addRespListener(callcenter.OP_TYPE.REFRESH_PLAYER_PKRank, onRefreshPlayerPKRank);

    function onRefreshAnchorPKRank(resp, param){
        rankPaneModel.set("anchorList",resp.m_rank);
        rankPaneModel.set("totalPK",resp.m_anchor_pk_value);
    }

    function onRefreshPlayerPKRank(resp, param){
        rankPaneModel.set("fansList",resp.m_rank);
    }

    return pkrank;
});