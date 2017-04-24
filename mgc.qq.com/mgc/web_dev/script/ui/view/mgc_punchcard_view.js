/*
* Author:             77
* Version:            1.0 (2015/11/11)
* Discription:        打卡视图 
*/
define(['backbone', 'jquery', 'mgc_tips', 'mgc_callcenter', 'mgc_consts', 'mgc_tool', 'mgc_popmanager', 'js_scrollpane', 'mgc_comm_view'], function(backbone, $, mgc_tips, callcenter, consts, tool, mgc_popmanager, jscrollpane, comm_view) {
    var common = {};
    /*
    *打卡界面视图
    */
    var PunckCardView = backbone.View.extend({
        el: $("#pop_punch_card"),
        events: {
            "click .pop_close": "click_close"
        },
        data: null,
        punch_card_callback: null,
        punch_card_add_callback: null,
        cancel_callback: null,
        click_punch_card: true,
        click_punch_card_add: true,
        initialize: function(data, _punch_card_callback, _punch_card_add_callback, _cancel_callback) {
            var _this = this;
            _this.data = data;
            _this.punch_card_callback = _punch_card_callback;
            _this.punch_card_add_callback = _punch_card_add_callback;
            _this.cancel_callback = _cancel_callback;
            //初始化每日打卡状态
            data.info.punch_day_list = [];
            $.each(data.info.punch_in_rec_list, function(k, v) {
                //每日的打卡状态
                var day = {};
                day.num = k;
                //补打卡第一次的索引
                if (!v && data.info.retrieve_punch_in_left_index == undefined) {
                    data.info.retrieve_punch_in_left_index = day.num;
                }                                   //日期
                day.is_punch_today = v;                              //今日是否已打卡
                day.is_today = data.info.today_index == day.num;     //当前是否为今日
                if (day.is_today) {
                    data.info.is_punch_today = v;
                }
                if (Math.ceil((k + 1) / 6) % 2 == 0) {//奇数行                 
                    if ((k + 1) % 2 == 0) {//奇数列
                        day.bgcolor = "#eaeae8";
                    } else {               //偶数列
                        day.bgcolor = "#f3f3f3";
                    }
                } else {                   //偶数行
                    if ((k + 1) % 2 == 0) {//奇数列
                        day.bgcolor = "#f3f3f3";
                    } else {               //偶数列
                        day.bgcolor = "#eaeae8";
                    }
                }
                data.info.punch_day_list.push(day);
            });
            //补齐空缺的表格
            for (var i = data.info.punch_day_list.length ; i < 36; i++) {
                var day = {};
                day.num = -1;
                if (Math.ceil((i + 1) / 6) % 2 == 0) {//奇数行                 
                    if ((i + 1) % 2 == 0) {//奇数列
                        day.bgcolor = "#eaeae8";
                    } else {         //偶数列
                        day.bgcolor = "#f3f3f3";
                    }
                } else {             //偶数行
                    if ((i + 1) % 2 == 0) {//奇数列
                        day.bgcolor = "#f3f3f3";
                    } else {         //偶数列
                        day.bgcolor = "#eaeae8";
                    }
                }
                data.info.punch_day_list.push(day);
            }
            data.info.is_accumulate_today = false;
            //初始化累计奖励区
            $.each(data.info.accumulate_rewards, function(k, v) {
                $.each(v.rewards, function(i, o) {
                    //修改图片URL
                    _this.fill_rewardinfo(o);
                    o.tips = o.name + "×" + o.count_desc;
                });
            });
            //获取守护等级名称
            data.info.guardLevelName = consts.guardLevelTab[data.info.mutiply_guard_level];
            var punchCardCon = $('#punchCardTmpl');
            var punchCardTmpl;
            var punchCardContainer = this.$('#punchCardContainer');
            punchCardContainer.children().remove();
            punchCardTmpl = punchCardCon.tmpl(data.info);
            punchCardTmpl.appendTo(punchCardContainer);
            //添加tips时间
            this.$el.find(".mouse_tips").mouseover(function(e) {
                mgc_tips.suswTips4(e, 1, $(this).data("name"), $(this).data("tips"), "punch_card");
            }).mouseout(function(e) {
                mgc_tips.suswTips4(e, 0, "", "", "punch_card");
            });
            //更新title
            this.$el.find(".current_month").html(new Date(parseInt(data.info.punch_in_id) * 1000).format("yyyy年M月"));
            this.reset_view_ui();
            window.mgc.popmanager.layerControlShow(this.$el, 3, 1);
            //设置累计奖励滚动条
            if (data.info.accumulate_rewards && data.info.accumulate_rewards.length > 3) {
                this.$el.find('.punch_card_opt_con').jScrollPane({ autoReinitialise: true, animateScroll: true, autoReinitialiseDelay: 100 });
                //重绘滚动条
                var scrollAPI = this.$el.find('.punch_card_opt_con').data('jsp');
                if(scrollAPI){
                    scrollAPI.initScroll();
                }
            }
            punchCardTmpl = null;
            punchCardCon = null;
        },
        render: function() {
            return this;
        },
        //重置UI表现
        reset_view_ui: function() {
            var _this = this;
            //更新提示文字信息
            this.$el.find(".opt_bottom_txt1 b").html(this.data.info.room_left);//今日可为n个房间打卡
            this.$el.find(".opt_bottom_txt2 b").html(this.data.info.mutiply);//至尊及守护以上获得n倍奖励
            this.$el.find(".opt_bottom_txt3 b").html(this.data.info.punch_in_count);//已打卡n天
            this.$el.find(".opt_bottom_txt4 b").html(this.data.info.retrieve_punch_in_left);//可补打卡n天
            //打卡
            if (!this.data.info.is_punch_today) {    //今日可打卡
                this.$el.find(".punch_card_btn").addClass("punch_card_btn_yes").unbind("click").click(function() {
                    _this.click_punch_card_fun(_this);
                });
            } else {                            //今日已打卡
                this.$el.find(".punch_card_btn").removeClass("punch_card_btn_yes").addClass("punch_card_btn_no").unbind("click");
                //去除打卡红点
                SKIN.can_punch_in_room = false;
                $('.layer-mission-con').find(".daka_btn .icon-red-dot").hide();
            }
            //补打卡
            if (this.data.info.retrieve_punch_in_left > 0) {
                this.$el.find(".punch_card_btn_add").addClass("punch_card_btn_add_yes").unbind("click").click(function(e) {
                    _this.click_punch_card_add_fun(_this);
                });
            } else {
                this.$el.find(".punch_card_btn_add").removeClass("punch_card_btn_add_yes").addClass("punch_card_btn_add_no").unbind("click");
            }
        },
        //点击打卡
        click_punch_card_fun: function(_this) {
            if (_this.data.info.room_left == 0 && _this.data.info.punch_in_count <= 0) {
                //达到打卡房间上线
                tool.commonDialog({ "Title": "提示", "Note": "亲，今日您的打卡房间已达到上限！" });
                return;
            }
            if (_this.click_punch_card) {
                _this.click_punch_card = false;
                _this.punch_card_callback(_this.data.info.punch_in_id, _this.data.info.today_index, _this.data.info.today_index, false, _this.data.info.retrieve_punch_in_prce);
            }
        },
        //点击补打卡
        click_punch_card_add_fun: function(_this) {
            if (_this.data.info.room_left == 0 && _this.data.info.punch_in_count <= 0) {
                //达到打卡房间上线
                tool.commonDialog({ "Title": "提示", "Note": "亲，今日您的打卡房间已达到上限！" });
                return;
            }
            var dialog = {};
            dialog.Note = '本次补打卡需要花费' + _this.data.info.retrieve_punch_in_prce + '炫豆。';
            dialog.BtnNum = 2;
            dialog.BtnName = '补打卡';
            dialog.BtnName2 = '算了吧';
            tool.commonDialog(dialog, function() {
                //补打卡
                if (_this.click_punch_card_add) {
                    _this.click_punch_card_add = false;
                    _this.punch_card_callback(_this.data.info.punch_in_id, _this.data.info.today_index, _this.data.info.retrieve_punch_in_left_index, true, _this.data.info.retrieve_punch_in_prce);
                }
            });
        },
        //打卡特效  数字tip提醒 参数:是否补打卡 info.retrieve, info.day_index, info.charm
        effects: function(info) {
            var left = 30, top = -5, obj = this.$el.find("#punch_card_rewards_list li").eq(info.day_index), _this = this;
            obj.append('<div class="p-c-tip"><b>+' + info.charm + '<\/b></\div>');
            obj.find('.p-c-tip').css({ 'position': 'absolute', 'z-index': '4', 'color': '#e03838', 'font-size': '12px', 'left': left + 'px', 'top': top + 'px' }).animate({ top: top - 20, left: left + 20, 'font-size': '15px' }, 'slow', function() {
                $(this).fadeIn('fast').remove();
                obj.find(".r_gou").show();
                if (info.rewards && info.rewards.length > 0) {
                    _this.reward_dialog(info);
                }
            });
            if (!info.retrieve) {
                obj.find(".r_punch_card_swf").hide();
            }
        },
        reset_view_data: function(_info) {
            //重置UI
            this.data.info.room_left = _info.room_left;
            this.data.info.retrieve_punch_in_prce = _info.retrieve_punch_in_prce;
            this.data.info.punch_in_rec_list[_info.day_index] = true;
            this.data.info.punch_day_list[_info.day_index].is_punch_today = true;
            this.data.info.punch_in_count += 1;
            if (_info.retrieve) {
                if (this.data.info.retrieve_punch_in_left > 0) {
                    this.data.info.retrieve_punch_in_left -= 1;
                    this.data.info.retrieve_punch_in_left_index += 1;
                }
            } else {
                this.data.info.is_punch_today = true;
            }
            this.reset_view_ui();
            //单个房间打卡次数达到日上限后
            if (_info.charm == 0) {
                var obj = this.$el.find("#punch_card_rewards_list li").eq(_info.day_index);
                obj.find(".r_gou").show();
                if (_info.rewards && _info.rewards.length > 0) {
                    this.reward_dialog(_info);
                }
                
                if (!_info.retrieve) {
                    obj.find(".r_punch_card_swf").hide();
                }
            } else {
                //播放特效
                this.effects(_info);
            }
        },
        reward_dialog: function(info) {
            //领取成功 弹出奖励信息
            var data = {};
            data.rewards = info.rewards;
            $.each(data.rewards, function(i, o) {
                o.tips = "";
            });
            data.title = "打卡奖励";
            data.showTips = info.charm == 0 ? "亲，您获得以下连续打卡奖励：" : "恭喜你获得以下奖励：";
            data.showTips_game = "";
            var reward_dialog_view = new comm_view.RewardDialogView(data);
        },
        //关闭
        click_close: function() {
            window.mgc.popmanager.layerControlHide(this.$el, 3, 1);
            if (this.cancel_callback)
                this.cancel_callback();
        },
        //点击其它区域关闭
        click_other_dom: function(_this) {
            $(document).unbind("click").click(function(e) {
                e = e || window.event; // 兼容IE7
                obj = $(e.srcElement || e.target);
                if (!$(obj).is("#pop_punch_card,#pop_punch_card *,.daka_btn")) {
                    _this.click_close();
                }
            });
        },
        fill_rewardinfo: function(o) {
            if (o.channel == 3) {
                if (o.url == '') {
                    o.url = "common/game_default.png?v=3_8_8_2016_15_4_final_3";
                }
            }
            //o.url = (o.channel == 0 || o.channel == 3) ? o.url : (consts.filePath.IMG_PATH + o.url);
            o.url = o.url.indexOf("ossweb-img.qq.com") >= 0 ? o.url : (consts.filePath.IMG_PATH + o.url);
        }
    });
    common.PunckCardView = PunckCardView;
    return common;
});