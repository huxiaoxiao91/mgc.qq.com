/**
 * Created by WJ on 2016/8/3.
 */

define(['underscore','backbone', 'jquery'], function (_,Backbone,$) {

    var hotbox = {};

    hotbox.RewardTipModel = Backbone.Model.extend({
        defaults:{
            /**
             * 奖励消息队列
             */
            tipList:[],

            isPlay:false
        },

        /**
         tipObj.showTips
         tipObj.name
         tipObj.count_desc
         tipObj.buff_percent
         tipObj.showTips_game
         */
        addTip:function(tipObj){
            var tipList = this.get("tipList");
            var html;
            if (tipObj.isLastking && tipObj.lastHitPlayerName) {
                html = "<span id='last-king-des'><span>" + tipObj.showTips + "</span>" +
                    "<span class='name'>" + tipObj.name + "</span><span class='count'>" + " x" + tipObj.count_desc + "</span>" +
                    "<span class='percent'>" + tipObj.buff_percent + "</span>" +
                    "<span>" + tipObj.showTips_game + "</span></span><span id='last-king'>补刀王：" + tipObj.lastHitPlayerName + "</span>";
            } else if(tipObj.isLastkingReward){
                html = "<span>" + tipObj.showTips + "</span>" +
                    "<span class='name'>" + tipObj.name + "</span><span class='count'>" + " x" + tipObj.count_desc + "</span>" +
                    "<span>" + tipObj.showTips_game + "</span>";
            }else{
                html = "<span>" + tipObj.showTips + "</span>" +
                    "<span class='name'>" + tipObj.name + "</span><span class='count'>" + " x" + tipObj.count_desc + "</span>" +
                    "<span class='percent'>" + tipObj.buff_percent + "</span>" +
                    "<span>" + tipObj.showTips_game + "</span>";
            }

            tipList.push(html);
            if(!this.get("isPlay"))
            {
                this.set("isPlay",true);
            }
        }

    });

    hotbox.RewardTipView = Backbone.View.extend({

        el:".rewardtip",

        model:hotbox.RewardTipModel,

        top1:5,

        top2:35,

        initialize: function () {
            this.model.on("change:isPlay",this.isPlayChange,this);
            this.$el.css("top","5px");
            this.$el.hide();
        },

        isPlayChange:function(){
            var isPlay = this.model.get("isPlay");
            if(isPlay)
            {
                this.show(true);
            }
        },

        play:function(){

            var tipList = this.model.get("tipList");
            var html = tipList.shift();
            var $tip = this.$el.find(".tip");
            $tip.css("opacity",0);
            $tip.html(html);
            //调整补刀王 tips 显示 ...
            if($("#last-king-des").length > 0){
                var allW = $("#last-king-des").width();
                var spanTags = $("#last-king-des span");
                if(spanTags.length == 5){
                    var tipsWidth = 0;
                    for(var i=0; i<4; i++){
                        tipsWidth += spanTags.eq(i).width();
                    }  
                    spanTags.eq(4).width(allW - tipsWidth); 
                    spanTags.eq(4).css({"overflow": "hidden", "white-space": "nowrap", "text-overflow": "ellipsis"});
                }
                
            }
            

            var _this = this;
            $tip.animate({opacity:1},500).animate({opacity:1},2000).animate({opacity:0},500,function(){
                if(tipList.length > 0)
                {
                    _this.play();
                }
                else{
                    _this.show(false);
                }
            });
        },

        show:function(b){
            var _this = this;
            if(b)
            {
                this.$el.show();
                this.$el.animate({top:this.top2},500,function(){
                    _this.play();
                });
            }
            else{
                this.$el.animate({top:this.top1},500,function(){
                    _this.$el.hide();
                    _this.model.set("isPlay",false);
                });
            }
        }

    });


    hotbox.OpenTipModel = Backbone.Model.extend({
        defaults:{
            /**
             * 开启的宝箱id
             */
            boxid:-1
        }
    });

    hotbox.OpenTipView = Backbone.View.extend({
        el:".opentipbox ul",

        model:hotbox.OpenTipModel,

        template:_.template($("#opentipTmpl").html()),

        initialize: function (data) {
            this.model.on("change:boxid",this.boxidChange,this);

            var template = this.template(data.tmplData);
            this.$el.html(template);
        },

        boxidChange:function(){
            var boxid = this.model.get("boxid");
            var $li = this.$el.find("li[data-boxid=" + boxid +"]");
            
            var _this = this;
            $li.show();
            $li.css("opacity",1);
            $li.animate({opacity:1},1500).animate({opacity:0},500,function(){
                $li.hide();
                _this.model.set({boxid:-1},{silent:true});
            });
        }
    });

    return hotbox;

});