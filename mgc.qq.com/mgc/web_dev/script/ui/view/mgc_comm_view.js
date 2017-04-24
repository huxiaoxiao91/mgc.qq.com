/*
* Author:             77
* Version:            1.0 (2015/11/11)
* Discription:        公共模块视图 ：主要初始化站内公共模块视图
* @todo:              登录时的大区按钮视图、登录时的大区列表视图、创建角色视图
* @todo:              顶条登录组件视图、顶条登录组件-玩家信息-视图、顶条登录组件-玩家关注的主播-视图
* @todo:              搜索组件 - 视图、banner-视图、banner组件-视图
*/
define(['backbone', 'jquery', 'mgc_templates', 'mgc_tips', 'mgc_comm_coll', 'mgc_callcenter', 'mgc_consts', 'mgc_tool', 'mgc_popmanager', 'js_scrollpane'], function(backbone, $, templates, mgc_tips, comm_coll, callcenter, consts, tool, mgc_popmanager, jscrollpane) {
    var common = {};
    /**
     * 登录时的大区按钮视图
     * @type {void|*}
     */
    var SelRoleBtnView = backbone.View.extend({
        tagName: "li",
        template: _.template(templates.get_login_old_role_zone_list_tmpl()),
        events: {
            "click": "click_login_zone"
        },
        cur_page: 0,
        click_callback: null,
        initialize: function(model, _login_callback) {
            this.login_callback = _login_callback;
            this.listenTo(this.model, 'change', this.render);
        },
        render: function() {
            this.$el.html(this.template(this.model.attributes));
            //this.$el.toggleClass('done', this.model.get('done'));
            return this;
        },
        click_login_zone: function() {
            var params = {};
            params.caller = this;
            comm_coll.getCollSelRole.reset();
            if (this.model.is_false()) {
                //伪造大区、走自动注册流程
                this.do_login_callback();
            } else {
                //真实大区、走自动登录流程
                callcenter.query_login_zone(this.model.get_zone_id(), this.model.get_channel(), this.do_login_callback, params);
            }
            if (tool.is_home_page()) {
                tool.EAS([{ 'e_c': 'mgc.enteraera.1', 'c_t': 4 }]);
            } else if (tool.is_live_room()) {
                tool.EAS([{ 'e_c': 'mgc.enteraera.2', 'c_t': 4 }]);
            } else if (tool.is_show_room()) {
                tool.EAS([{ 'e_c': 'mgc.enteraera.3', 'c_t': 4 }]);
            } else if (tool.is_caveolae_room()) {
                //todo 
            } else if (tool.is_ticket_page()) {
                tool.EAS([{ 'e_c': 'mgc.enteraera.4', 'c_t': 4 }]);
            }
            tool.EAS({ 'e_c': 'mgc.enteraera', 'c_t': 4 });
        },
        do_login_callback: function(resp, params) {
            console.log("old_role do_login_callback called");
            if (this.login_callback) {
                this.login_callback(resp, params, this.model.is_false());
            }
        }
    });
    /**
     * 登录时的大区列表视图
     * @type {void|*}
     */
    var SelRoleView = backbone.View.extend({
        el: $("#pop_player_select"),
        events: {
            "click .pop_pre": "click_prev",
            "click .pop_next": "click_next",
            "click .pop_pre_two": "click_prev_two",
            "click .pop_next_two": "click_next_two",
            "click .pop_close": "click_close",
            "click #mgcSelectRole": "click_sel_mgc_role",
            "focus #popSr": "focus_nick_input",
            "blur #popSr": "blur_nick_input"
        },
        cur_page: 0,
        cur_page_two: 0,
        counts_per_page_two: 6,
        counts_per_page: 6,
        login_callback: null,
        cancel_callback: null,
        getCollSelRoleCopy: [],
        initialize: function(_login_callback, _cancel_callback) {
            this.login_callback = _login_callback;
            this.cancel_callback = _cancel_callback;
            this.lastRole_block = this.$("#lastRole");
            this.mgc_role_block = this.$(".pop_mgcjs");
            this.old_role_page = this.$(".pop_page");
            this.old_role_page2 = this.$(".pop_page2");
            this.old_role_mgcjs = this.$(".pop_mgcjs");
            this.old_role_xwjs = this.$(".pop_xwjs");
            this.old_role_xwTwojs = this.$(".pop_xwTwojs");
            this.pop_precinct_no = this.$(".pop_precinct_no");
            this.pop_precinct_no_two = this.$(".pop_precinct_no_two");
            this.listenTo(comm_coll.getCollSelRole, 'reset', this.reset_charas);
            //qgame 隐藏关闭按钮
            if (MgcAPI.SNSBrowser.IsQQGame() || MgcAPI.SNSBrowser.IsX52()) {
                this.$(".pop_close").hide();
            }
        },
        render: function() {
            return this;
        },

        click_prev: function() {
            if (this.cur_page > 0) {
                this.cur_page--;
                this.render_old_roles(this.cur_page);
            }
        },
        click_prev_two: function() {
            if (this.cur_page_two > 0) {
                this.cur_page_two--;
                this.render_old_two_roles(this.cur_page_two);
            }
        },
        click_close: function() {
            tool.EAS([{ 'e_c': 'mgc.logout.1', 'c_t': 4 }]);
            comm_coll.getCollSelRole.reset();
            if (this.cancel_callback) {
                this.cancel_callback(consts.ui.RES_USER_CANCEL);
            }
        },
        click_next: function() {
            if (comm_coll.getCollSelRole.old_charas_two().length > 0) {
                if (this.cur_page < (Math.ceil(comm_coll.getCollSelRole.old_charas().length / this.counts_per_page_two) - 1)) {
                    this.cur_page++;
                    this.render_old_roles(this.cur_page);
                }
            } else {
                if (this.cur_page < (Math.ceil(comm_coll.getCollSelRole.old_charas().length / this.counts_per_page) - 1)) {
                    this.cur_page++;
                    this.render_old_roles(this.cur_page);
                }
            }
        },
        click_next_two: function() {
            if (this.cur_page_two < (Math.ceil(comm_coll.getCollSelRole.old_charas_two().length / this.counts_per_page_two) - 1)) {
                this.cur_page_two++;
                this.render_old_two_roles(this.cur_page_two);
            }
        },
        click_sel_mgc_role: function() {
            var params = {};
            params.caller = this;
            callcenter.query_login_zone(consts.pageSourceConfig.mgc.zoneid, consts.pageSourceConfig.mgc.channel, this.do_login_callback, params);
        },
        do_login_callback: function(resp, params) {
            console.log("do_login_callback called");
            comm_coll.getCollSelRole.reset();
            if (this.login_callback) {
                this.login_callback(resp, params);
            }
        },
        render_new_roles: function() {
            this.$(".mgc-current").children().remove();
            var _model = comm_coll.getCollSelRole.mgc_chara();
            var _length = comm_coll.getCollSelRole.old_charas().length;
            var _length_two = comm_coll.getCollSelRole.old_charas_two().length;
            for (var i = 0; i < _model.length; i++) {
                var view = new SelRoleBtnView({ model: _model[i] }, this.login_callback);
                this.$(".mgc-current").append(view.render().el);
            }
            if (_model.length > 1) {
                this.$(".mgc-current").css("width", 350).find("li:odd").css("float", "right");
            } else {
                this.$(".mgc-current").css("width", 130);
                if (comm_coll.getCollSelRole.mgc_def_chara().length > 0) {
                    this.$(".mgc-current").find("li a").html("点击进入");
                }
            }
            if (_model.length == 0) {
                this.$("#mgcRole").hide();
            }
            if (_length < 1 && _length_two < 1) {
                this.$(".pop_mgcjs").css({ 'border-bottom': 'none' });
            } else {
                this.$(".pop_mgcjs").css({ 'border-bottom': '1px solid #d4d4d4' });
            }
        },
        render_last_roles: function() {
            this.$(".mgc-current-last").children().remove();
            var _model = comm_coll.getCollSelRole.last_chara();
            for (var i = 0; i < _model.length; i++) {
                var view = new SelRoleBtnView({ model: _model[i] }, this.login_callback);
                this.$(".mgc-current-last").append(view.render().el);
            }
            if (_model.length == 1) {
                this.$(".mgc-current-last").css("width", 130);
                if (comm_coll.getCollSelRole.last_chara().length > 0) {
                    this.$(".mgc-current-last").find("li a").html(comm_coll.getCollSelRole.last_chara().zonename);
                }
            } else {
                this.$(".pop_mgcjs_last").hide();
            }
        },
        render_old_roles: function(cur_page) {
            this.$(".current").children().remove();
            var _length = comm_coll.getCollSelRole.old_charas().length;

            //检查是否要显示老角色翻页

            if (comm_coll.getCollSelRole.has_mutiple_pages(this.counts_per_page)) {
                this.old_role_page.show();
                this.total_pages = Math.ceil(_length / this.counts_per_page);

                if (this.total_pages > 1) {
                    this.$(".pop_pre").show();
                    this.$(".pop_next").show();
                    this.$("#role_sum_tips").text((cur_page + 1) + "/" + this.total_pages);
                    this.old_role_xwjs.css({ 'height': '165px' });
                    this.$("#roleListGame,#roleListGame .pop_precinct_con").css({ 'height': '94px' });
                } else {
                    this.$(".pop_pre").hide();
                    this.$(".pop_next").hide();
                    this.$("#role_sum_tips").text('');
                    this.old_role_xwjs.css({ 'height': '80px' });
                    this.$("#roleListGame").css({ 'height': '47px' });
                    if (_length > 3) {
                        this.old_role_xwjs.css({ 'height': '127px' });
                        this.$("#roleListGame,#roleListGame .pop_precinct_con").css({ 'height': '94px' });
                    } else {
                        this.$("#roleListGame .pop_precinct_con").css({ 'height': '33px' });
                    }
                }
            } else {
                this.old_role_page.hide();
                if (_length > 3) {
                    this.old_role_xwjs.css({ 'height': '127px' });
                    this.$("#roleListGame,#roleListGame .pop_precinct_con").css({ 'height': '94px' });
                }
            }

            if (_length > 0) {
                this.pop_precinct_no.hide();
            } else {
                //如果没有角色，整个选区模块也隐藏
                this.pop_precinct_no.hide();
                $('#xwOne').hide();
            }

            for (var i = cur_page * this.counts_per_page; i < (cur_page + 1) * this.counts_per_page && i < _length; i++) {
                var view = new SelRoleBtnView({ model: comm_coll.getCollSelRole.old_charas()[i] }, this.login_callback);
                this.$(".current").append(view.render().el);
            }

        },
        render_old_two_roles: function(cur_page_two) {
            this.$(".currentTwo").children().remove();
            var _length_two = comm_coll.getCollSelRole.old_charas_two().length;
            //检查是否要显示老角色翻页
            if (comm_coll.getCollSelRole.has_mutiple_pages_two(this.counts_per_page_two)) {
                this.old_role_page2.show();
                this.total_pages_two = Math.ceil(_length_two / this.counts_per_page_two);

                if (this.total_pages_two > 1) {
                    this.$(".pop_page2").css({ 'display': 'block' });
                    this.$(".pop_pre_two").show();
                    this.$(".pop_next_two").show();
                    this.$("#role_sum_tips2").text((cur_page_two + 1) + "/" + this.total_pages_two);
                    this.$("#roleListGame2,#roleListGame2 .pop_precinct_con2").css({ 'height': '95px' });
                } else {
                    this.$(".pop_page2").css({ 'display': 'none' });
                    this.$(".pop_pre_two").hide();
                    this.$(".pop_next_two").hide();
                    this.$("#role_sum_tips2").text('');
                    this.$("#roleListGame2").css({ 'height': '76px' });
                    if (_length_two > 3) {
                        this.old_role_xwTwojs.css({ 'height': '127px' });
                        this.$("#roleListGame2,#roleListGame2 .pop_precinct_con2").css({ 'height': '96px' });
                    } else {
                        this.$("#roleListGame2,#roleListGame2 .pop_precinct_con2").css({ 'height': '33px' });
                    }
                }
            } else {
                this.old_role_page2.hide();
                this.$(".pop_page2").css({ 'display': 'none' });
                if (_length_two > 3) {
                    this.old_role_xwTwojs.css({ 'height': '127px' });
                    this.$("#roleListGame2,#roleListGame2 .pop_precinct_con2").css({ 'height': '96px' });
                }
            }
            if (_length_two > 0) {
                this.pop_precinct_no_two.hide();
            } else {
                //如果没有角色，整个选区模块也隐藏
                this.pop_precinct_no_two.hide();
                $('#xwTow').hide();
            }
            for (var i = cur_page_two * this.counts_per_page_two; i < (cur_page_two + 1) * this.counts_per_page_two && i < _length_two; i++) {
                var view = new SelRoleBtnView({ model: comm_coll.getCollSelRole.old_charas_two()[i] }, this.login_callback);
                this.$(".currentTwo").append(view.render().el);
            }
        },
        reset_charas: function() {
            if (comm_coll.getCollSelRole.length) {
                $(".pop_loading").hide();
                if (comm_coll.getCollSelRole.old_charas_two().length > 0) {
                    $("#xwTow").show();
                    $(".pop_precinct").css({ 'height': '55px' });
                    $(".pop_xwjs").css({ 'border-bottom': '1px solid #d4d4d4', 'height': '80px' });
                    $(".pop_precinct_no").css({ 'margin-top': '0' });
                    $(".pop_page,pop_page2").css({ 'height': '30px' });
                } else {
                    $("#xwTow").hide();
                    $(".pop_xwjs").css({ 'border-bottom': 'none', 'height': 'inherit' });
                    $(".pop_precinct").css({ 'height': '150px' });
                    $(".pop_precinct_con").css({ 'height': '130px' });
                    $(".pop_precinct_no").css({ 'margin-top': '20px' });
                    $(".pop_page,pop_page2").css({ 'height': '24px' });
                }

                //显示选择框
                window.mgc.popmanager.layerControlShow(this.$el, 8, 1);
                this.$el.centerDisp();
                //检查是否显示上次登录大区记录
                if (comm_coll.getCollSelRole.has_lastRole_chara() && (comm_coll.getCollSelRole.length >= 2)) {
                    //  判断显示逻辑
                    this.lastRole_block.show();
                    this.render_last_roles();
                } else {
                    this.lastRole_block.hide();
                }
                //检查是否要显示新角色区
                if (comm_coll.getCollSelRole.has_mgc_chara()) {
                    this.mgc_role_block.show();
                    this.render_new_roles();
                } else {
                    this.mgc_role_block.hide();
                }
                this.cur_page = 0;
                this.cur_page_two = 0;
                this.render_old_roles(this.cur_page);
                if (comm_coll.getCollSelRole.old_charas_two().length > 0) {
                    this.render_old_two_roles(this.cur_page_two);
                }
            } else {
                window.mgc.popmanager.layerControlHide(this.$el, 8, 1);
            }
        }
    });
    common.getViewSelRole = function(login_callback, cancel_callback) {
        return new SelRoleView(login_callback, cancel_callback);
    };
    /**
     * 创建角色视图
     * @type {void|*}
     */
    var CreateRoleView = backbone.View.extend({
        el: $("#pop_player_create"),
        register_callback: null,
        cancel_callback: null,
        events: {
            "click .pop_close": "click_close",           //关闭
            "click #checkDup": "click_check",           //检查重名
            "click .pop_enter": "click_submit",         //申请角色
            "click .gender": "click_gender",          //选择性别
            "click .color_words": "click_get_nick"   //色子注册
        },
        initialize: function(model, _register_callback, _cancel_callback) {
            this.register_callback = _register_callback;
            this.cancel_callback = _cancel_callback;
            this.popSr = this.$('#popSr');
            this.pop_nick_info = this.$('.pop_nick_info');
            //qgame 隐藏关闭按钮
            if (MgcAPI.SNSBrowser.IsQQGame() || MgcAPI.SNSBrowser.IsX52()) {
                this.$(".pop_close").hide();
            }
            this.$("#SelectGender a").unbind('click').bind('click', function() {
                $("#SelectGender a").removeClass("current");
                $(this).addClass("current");
                $("#userGender").val($(this).attr("idx"));
            });
            // 动态绑定动作
            this.$('#popSr').focus(function() {
                var v = $.trim($(this).val());
                $(this).css({
                    "color": "#1c1c1c"
                });
                if (v == '输入QQ昵称') {
                    $(this).val("");
                }
                if (tool.Strlen(v) > 12) {
                    $('.pop_nick_info').html('昵称长度限制12个字符').css('color', 'red');
                    $(this).val(tool.Strcut(v, 12));
                } else {
                    $('.pop_nick_info').html('点击可修改昵称，最多12位字符').css({
                        "color": "#545454"
                    });
                }
            }).blur(function() {
                var v = $.trim($(this).val());
                if (v == '') {
                    $(this).val('输入QQ昵称').css({
                        "color": "#bcbcbc"
                    });
                }
            }).keyup(function() {
                var v = $.trim($(this).val());
                if (tool.Strlen(v) > 12) {
                    $(this).val(tool.Strcut(v, 12));
                }
            }).keydown(function() {
                var v = $(this).val();
                if (tool.Strlen(v) >= 12) {
                    event.returnValue = false;
                }
                if (event.keyCode == 8) {
                    event.returnValue = true;;
                }
            })
            this.listenTo(this.model, 'change:nick', this.on_nick_changed);
            this.model.get_default_infos();
        },
        render: function() {
            var _this = this;
            //获取昵称
            LoginManager.getNickName(function(loginInfo) {
                if (loginInfo.isLogin && loginInfo.nickName && loginInfo.nickName.length > 0) {
                    _this.popSr.val(loginInfo.nickName);
                }
                else {
                    _this.pop_nick_info.html('获取昵称失败！').css('color', 'red');
                }
            });
            //设置性别
            this.setGender();
            $(".pop_loading").hide();
            //创建角色弹窗时，隐藏首页引导弹窗
            if (tool.is_home_page()) {
                window.mgc.popmanager.layerControlHide($('#pop_guide'), 4, 1);
            }
            window.mgc.popmanager.layerControlShow(this.$el, 4, 1);
            this.$el.centerDisp();
            return this;
        },
        show: function() {
            this.model.get_default_infos();
        },
        randomUserName: "",
        nick_pool: -1,
        nick_record_id: -1,
        click_get_nick: function() {
            //随机获取昵称
            var _userGender = parseInt(this.$("#userGender").val(), 10);
            var params = {};
            params.caller = this;
            callcenter.query_rand_nick(this.nick_pool, _userGender, this.get_rand_nick_callback, params);
        },
        get_rand_nick_callback: function(resp, params) {
            this.randomUserName = resp.nick;
            this.nick_pool = resp.nick_pool;
            this.nick_record_id = resp.nick_record_id;
            if (this.randomUserName && this.randomUserName.length > 0) {
                this.popSr.css("color", "#000000").val(this.randomUserName);
                this.pop_nick_info.children().remove();
            }
            else {
                this.pop_nick_info.html('获取昵称失败！').css('color', 'red');
            }
        },
        on_nick_changed: function() {

        },
        click_close: function() {
            var nickName = this.popSr.val();
            if (nickName == '' || nickName == '输入QQ昵称') {
                tool.EAS([{ 'e_c': 'mgc.regist.close', 'c_t': 4 }]);
            }
            window.mgc.popmanager.layerControlHide(this.$el, 8, 1);
            if (this.cancel_callback) {
                this.cancel_callback(consts.ui.RES_USER_CANCEL);
            }
        },
        click_check: function() {
            //检测重名
            var v = $.trim(this.popSr.val());
            var reg = new RegExp(/[　]{1,12}/);
            if (v == '' || v == '输入QQ昵称' || v == undefined || reg.test(v)) {
                this.pop_nick_info.html('请输入昵称！').css('color', 'red');
            } else {
                var params = {};
                params.caller = this;
                callcenter.check_dupnick(v, this.check_dupnick_callback, params);
            }
        },
        check_dupnick_callback: function(resp, params) {
            var msg = '';
            var color = 'red';
            switch (parseInt(resp.res)) {
                case 0:
                    msg = '该昵称可用！';
                    color = 'green';
                    break;
                case 1:
                    msg = '请输入昵称！';
                    break;
                case 2:
                    msg = '该昵称不可使用，请您重新输入！';
                    break;
                case 3:
                    msg = '该昵称已被使用，请您重新输入！';
                    break;
                default:
                    msg = '该昵称不可使用，请您重新输入！';
                    break;
            }
            this.pop_nick_info.html(msg).css('color', color);
        },
        click_submit: function() {
            var _userNick = $.trim(this.popSr.val());
            var msg = '';
            if (_userNick.length == 0 || _userNick == '输入QQ昵称') {
                msg = '请输入昵称！';
            }
            else if (_userNick.length > 12) {
                msg = '昵称长度限制12个字符';
            }
            else if (_userNick.replace(/&nbsp;/g, "").length == 0 || _userNick.replace(/&nbsp/g, "").length == 0 || $.trim(_userNick).length == 0) {
                msg = '该昵称不可使用，请您重新输入';
            }
            if (msg != '') {
                this.pop_nick_info.html(msg).css('color', 'red');
                return false;
            }
            if (tool.is_home_page()) {
                tool.EAS([{ 'e_c': 'mgc.regist.1', 'c_t': 4 }]);
            } else if (tool.is_live_room()) {
                tool.EAS([{ 'e_c': 'mgc.regist.2', 'c_t': 4 }]);
            } else if (tool.is_show_room()) {
                tool.EAS([{ 'e_c': 'mgc.regist.3', 'c_t': 4 }]);
            } else if (tool.is_caveolae_room()) {
                //todo 
            } else if (tool.is_ticket_page()) {
                tool.EAS([{ 'e_c': 'mgc.regist.4', 'c_t': 4 }]);
            }
            tool.EAS([{ 'e_c': 'mgc.regist', 'c_t': 4 }]);
            var params = {};
            params.caller = this;
            params.nick = _userNick;
            params.gender = this.getGender();
            params.nick_pool = this.nick_pool;
            params.nick_record_id = this.nick_record_id;
            if (this.register_callback) {
                this.register_callback(params);
            }
        },
        do_create_role_callback: function(resp, params) {
            if (resp.res == 0) {
                this.$el.hide();
            }
            if (this.login_callback) {
                this.login_callback(resp, params);
            }
        },
        getGender: function() {
            return $("#SelectGender a.current").attr("idx") || 0;
        },
        setGender: function() {
            var _url = "http://apps.game.qq.com/mgc/index.php?m=GetUserGender&t=" + (new Date()).getTime();
            $("#SelectGender a").removeClass("current");
            $("#SelectGender a").eq(0).addClass("current");
            $.ajax({
                type: 'get',
                url: _url,
                dataType: 'jsonp',
                jsonp: 'jsoncallback',
                success: function(obj) {
                    if (parseInt(obj.ret_code) == 0) {
                        $("#SelectGender a").removeClass("current");
                        if (obj.data.UserGender == "男") {
                            $("#SelectGender a").eq(0).addClass("current");
                            $("#userGender").val($("#SelectGender a").eq(0).attr("idx"));
                        }
                        else {
                            $("#SelectGender a").eq(1).addClass("current");
                            $("#userGender").val($("#SelectGender a").eq(1).attr("idx"));
                        }
                    }
                    else {
                        $("#SelectGender a").removeClass("current");
                        $("#SelectGender a").eq(1).addClass("current");
                        $("#userGender").val($("#SelectGender a").eq(1).attr("idx"));
                    }
                },
                error: function() {
                    alert('抱歉，网络繁忙，请稍候再试！');
                }
            });
        }
    });
    common.getViewCreateRole = function(model, create_callback, cancel_callback) {
        return new CreateRoleView({ model: model }, create_callback, cancel_callback);
    };
    /*
    * 顶条登录组件视图
    * @type {void|*}
    */
    var LoginBarView = backbone.View.extend({
        el: $("#loginbar"),
        events: {
            "click #login-bar-btn": "click_do_login_fun",
            "click #signin": "click_signin_fun",
            "mouseover .signin,.rw,.fg": "mouseover_hide_login_con",
            "mouseleave .logined": "mouseleave_bar_fun",
            "click .logined i": "click_logined_fun",
            "click .loginout": "logout_fun"
        },
        login_callback: null,
        get_playerinfo_callback: null,
        initialize: function(model, _login_callback, _get_playerinfo_callback) {
            this.unlogin_bar = this.$("#unlogin");
            this.logined_bar = this.$("#logined");
            this.logined_con = this.$(".logined_con");
            this.login_callback = _login_callback;
            this.get_playerinfo_callback = _get_playerinfo_callback;
            this.listenTo(this.model, 'change', this.render);
            var _this = this;
            //当前任务数
            common.getDoneActCount();
            //隐身状态切换——列表展示隐藏
            //冒泡阻止是为了阻止点击切换和列表显示隐藏冲突
            $('#logined_status').bind('click', function(e) {
                console.log("隐身状态切换click");
                $('#logined_status #userStatus').toggle();
                e.stopPropagation();
            });
            //隐身状态切换——点击事件——切换状态发请求——更改状态
            //冒泡阻止是为了阻止点击切换和列表显示隐藏冲突
            $('#logined_status #userStatus').find('li').bind('click', function(e) {
                var _class = $(this).attr('class'),
                    _status = _class.substr(_class.length - 1); // 0在线 1隐身
                _status = parseInt(_status, 10) == 0 ? false : true;
                //如果玩家在座位上要隐身  弹提示
                if (typeof (mgc.Seat) != "undefined" && _status == 1) {
                    if (mgc.Seat.isSeat(mgc.consts.MGCData.myPlayerId) || mgc.VipGrab.isSeat(mgc.consts.MGCData.myPlayerId)) {
                        console.log('是否隐身——隐身弹窗提醒前——房间外——隐身（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                        var dialog = {};
                        dialog.Title = '提示信息';
                        dialog.BtnNum = 2;
                        dialog.BtnName = '隐身';
                        dialog.BtnName2 = '算了吧';
                        dialog.Note = "亲，您隐身后将会自动离开座位";
                        tool.commonDialog(dialog, function() {
                            callcenter.set_player_status(true, window.mgc.common_contral.IndexResp.SetUserStatusCallBack);
                        });
                    } else {
                        callcenter.set_player_status(_status, window.mgc.common_contral.IndexResp.SetUserStatusCallBack);
                    }
                } else {
                    callcenter.set_player_status(_status, window.mgc.common_contral.IndexResp.SetUserStatusCallBack);
                }
                e.stopPropagation();
            });
            //隐身状态切换结束

            this.$("#login-bar-head-btn,#follow-bar-btn").mouseover(function() {
                var obj = $(this);
                var objCon = _this.$("#" + obj.data("panl"));
                if (objCon.css("display") == "block") {
                    return;
                }
                _this.get_playerinfo_callback();
                _this.logined_con.hide();
                objCon.show();
                $('.logined_list').jScrollPane({ autoReinitialise: true, animateScroll: true, autoReinitialiseDelay: 100, verticalDragMinHeight: 40 });
                if (!mgc.consts.API.scroll.outsideRoomAttentionList)
                    mgc.consts.API.scroll.outsideRoomAttentionList = $('.logined_list').data('jsp');
                if (mgc.consts.API.scroll.outsideRoomAttentionList)
                    mgc.consts.API.scroll.outsideRoomAttentionList.initScroll();
                obj.click(function(e) {
                    console.log("点击关注");
                    if (MgcAPI.SNSBrowser.IsX52()) {
                        console.log("X52PC=====点击关注");
                        e.preventDefault();
                        return false;
                    }
                });
            });
        },
        render: function() {
            if (this.model.get("ctrl_login_status")) {
                console.log("登录态：view : true");
                //处于登录态时
                this.unlogin_bar.hide();
                this.logined_bar.show();
                //初始化个人信息view/关注的主播view
                common.getViewPlayerInfo();
                common.getViewFollowInfo();
            } else {
                console.log("登录态：view : false");
                //非登录态时
                this.unlogin_bar.show();
                this.logined_bar.hide();
            }
            //return this;
        },
        toggleStatus: function(_status) {
            this.model.toggle();
        },
        //未登录状态下：登录按钮
        click_do_login_fun: function() {
            var _this = this;
            mgc.account.checkLogin(function() {
                _this.login_callback();
            }, function() {
                mgc.account.login(function() {
                    mgc.account.clear_cookie();
                    mgc.account.checkLogin(function() {
                        callcenter.query_clear_login_cookie(function() {
                            console.log("cookie cleared!");
                            var myTime = new Date();
                            var filename = window.location.href;
                            tool.cookie("mgc_logError_mgc_comm_view_UP_LoginBarView_click_do_login_fun", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___unLogin_loginBtn__do_click___web--mgc_comm_view_UP_LoginBarView_click_do_login_fun-loginBtn__do_click___filename" + filename, {
                                path: '/',
                                domain: '.qq.com'
                            });
                        });
                        _this.login_callback();
                        tool.EAS([{ 'e_c': 'mgc.login', 'c_t': 4 }]);
                    }, null, true);
                }, mgc.account.hasSkey ? null : function() {
                    window.location.reload(true);
                });
            }, true);
        },
        mouseover_bar_fun: function(e) {
            this.get_playerinfo_callback();
            e = e || window.event; // 兼容IE7
            var obj = this.$(e.srcElement || e.target);
            var objCon = this.$("#" + obj.data("panl"));
            this.logined_con.hide();
            objCon.show();
        },
        click_logined_fun: function(e) {
            console.log("点击头像");
            if (MgcAPI.SNSBrowser.IsX52()) {
                console.log("X52PC=====点击头像");
                e.preventDefault();
                return false;
            }
        },
        mouseleave_bar_fun: function(e) {
            this.logined_con.hide();
            this.$(".logined_status ul").hide();
            //当鼠标移入，重新打开个人头像信息区，恢复隐身状态列表收起
            $('#logined_status #userStatus').hide();
        },
        mouseover_hide_login_con: function() {
            this.logined_con.hide();
            this.$(".logined_status ul").hide();
            //当鼠标移入，重新打开个人头像信息区，恢复隐身状态列表收起
            $('#logined_status #userStatus').hide();
        },
        logout_fun: function() {
            //主动登出
            mgc.common_logic.logout(true);
            var myTime = new Date();
            var filename = window.location.href;
            tool.cookie("mgc_logError_mgc_comm_view_UP_LoginBarView_logout_fun", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___mgc_comm_view_UP_LoginBarView_logout_fun___web--mgc_comm_view_UP_LoginBarView_logout_fun___filename" + filename, {
                path: '/',
                domain: '.qq.com'
            });
        }
    });
    common.getViewLoginBar = function(_model, _login_callback, _get_playerinfo_callback) {
        return new LoginBarView({ model: _model }, _login_callback, _get_playerinfo_callback);
    };
    /*
    * 顶条登录组件视图
    * @type {void|*}
    */
    var RoomLoginBarView = backbone.View.extend({
        el: $("#loginbar"),
        events: {
            "click #login-bar-btn": "click_do_login_fun",
            "click #login_qq_face,#logined i": "click_logined_fun",
            "click .loginout": "logout_fun"
        },
        login_callback: null,
        get_playerinfo_callback: null,
        initialize: function(model, _login_callback, _cancel_callback, _get_playerinfo_callback) {
            console.log("登录态：initialize ");
            this.unlogin_bar = this.$("#unlogin");
            this.logined_bar = this.$("#logined");
            this.logined_con = this.$("#logined_con");
            this.logined_con_player = this.$("#logined-con-playerinfo_box");
            this.logined_con_follow = this.$("#logined-con-follow");
            this.login_callback = _login_callback;
            this.cancel_callback = _cancel_callback;
            this.get_playerinfo_callback = _get_playerinfo_callback;
            this.listenTo(this.model, 'change', this.render);
            var _this = this;

            //隐身状态切换——列表展示隐藏
            //冒泡阻止是为了阻止点击切换和列表显示隐藏冲突
            $('#logined_status').bind('click', function(e) {
                console.log("隐身状态切换click");
                $('#logined_status #userStatus').toggle();
                e.stopPropagation();
            });
            //隐身状态切换——点击事件——切换状态发请求——更改状态
            //冒泡阻止是为了阻止点击切换和列表显示隐藏冲突
            $('#logined_status #userStatus').find('li').bind('click', function(e) {
                var _class = $(this).attr('class'),
                    _status = _class.substr(_class.length - 1); // 0在线 1隐身
                _status = parseInt(_status, 10) == 0 ? false : true;
                //如果玩家在座位上要隐身  弹提示
                if (typeof (mgc.Seat) != "undefined" && _status == 1) {
                    if (mgc.Seat.isSeat(mgc.consts.MGCData.myPlayerId) || mgc.VipGrab.isSeat(mgc.consts.MGCData.myPlayerId)) {
                        console.log('是否隐身——隐身弹窗提醒前——房间内——隐身（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                        var dialog = {};
                        dialog.Title = '提示信息';
                        dialog.BtnNum = 2;
                        dialog.BtnName = '隐身';
                        dialog.BtnName2 = '算了吧';
                        dialog.Note = "亲，您隐身后将会自动离开座位";
                        tool.commonDialog(dialog, function() {
                            callcenter.set_player_status(true, window.mgc.common_contral.IndexResp.SetUserStatusCallBack);
                        });
                    } else {
                        callcenter.set_player_status(_status, window.mgc.common_contral.IndexResp.SetUserStatusCallBack);
                    }
                } else {
                    callcenter.set_player_status(_status, window.mgc.common_contral.IndexResp.SetUserStatusCallBack);
                }
                e.stopPropagation();
            });
            //隐身状态切换结束

            //先做事件清除
            this.$(".h_user_pic").unbind("mouseover").unbind("mouseout").hover(function() {
                //当个人信息展开时，不再请求147
                if (_this.logined_con_player.css("display") == "block") {
                    return;
                }
                _this.get_playerinfo_callback();
                _this.logined_con_player.show();
            }, function() {
                //当鼠标移出，重新打开个人头像信息区，恢复隐身状态列表收起
                $('#logined_status #userStatus').hide();
                setTimeout(function() { _this.logined_con_player.hide(); }, 200);
            }).trigger("mouseout");
            $(".nav1").append(this.logined_con_follow).unbind("mouseover").unbind("mouseout").hover(function() {
                //当个关注的主播列表展开时，不再请求147
                if (_this.logined_con_follow.css("display") == "block") {
                    return;
                }
                _this.get_playerinfo_callback();
                _this.logined_con_follow.show();
                $m('.logined_list').jScrollPane({ autoReinitialise: true, animateScroll: true, autoReinitialiseDelay: 100, verticalDragMinHeight: 40 });
                if (!mgc.consts.API.scroll.attentionList)
                    mgc.consts.API.scroll.attentionList = $m('.logined_list').data('jsp');
                if (mgc.consts.API.scroll.attentionList)
                    mgc.consts.API.scroll.attentionList.initScroll();
                $(".nav1").click(function(e) {
                    console.log("点击关注");
                    if (MgcAPI.SNSBrowser.IsX52()) {
                        console.log("X52PC=====点击关注");
                        if (e.target.className == 'logined_zb') {
                        } else if (e.target.className == 'hover') {
                        } else {
                            e.preventDefault();
                            return false;
                        }
                    }
                });
            }, function() {
                setTimeout(function() { _this.logined_con_follow.hide(); }, 200);
            }).removeAttr("href").css("cursor", "pointer");
            this.$("#logined-con-follow").remove();
        },
        render: function() {
            if (this.model.get("ctrl_login_status")) {
                console.log("登录态：view : true");
                //处于登录态时
                this.unlogin_bar.hide();
                this.logined_bar.show();
                //初始化个人信息view/关注的主播view
                common.getViewPlayerInfo();
                common.getViewFollowInfo();
            } else {
                console.log("登录态：view : false");
                //非登录态时
                this.unlogin_bar.show();
                this.logined_bar.hide();
            }
            //return this;
        },
        toggleStatus: function(_status) {
            console.log("登录态：view : toggleStatus ：" + _status);
            this.model.toggle();
        },
        //未登录状态下：登录按钮
        click_do_login_fun: function() {
            var _this = this;
            mgc.account.checkLogin(function() {
                if (mgc.account.is_guest) {
                    callcenter.query_logout();
                    var myTime = new Date();
                    var filename = window.location.href;
                    tool.cookie("mgc_logError_mgc_comm_view_RoomLoginBarView_click_do_login_fun__mgc_account_checkLogin__logout__query_logout___mgc_account_is_guest", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___mgc_comm_view_RoomLoginBarView_click_do_login_fun__mgc_account_checkLogin_logout__query_logout___mgc_account_is_guest___filename" + filename, {
                        path: '/',
                        domain: '.qq.com'
                    });
                } else {
                    callcenter.query_clear_login_cookie(function() {
                        console.log("cookie cleared!");
                        var myTime = new Date();
                        var filename = window.location.href;
                        tool.cookie("mgc_logError_mgc_comm_view_RoomLoginBarView_mgc_account_checkLogin_click_do_login_fun", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___mgc_account_checkLogin__not_guest_unLogin__loginBtn__do_click___web--mgc_comm_view_RoomLoginBarView____mgc_account_checkLogin_____click_do_login_fun-loginBtn__do_click___filename" + filename, {
                            path: '/',
                            domain: '.qq.com'
                        });
                    });
                    _this.login_callback();
                }
            }, function() {
                mgc.account.login(function() {
                    if (mgc.account.is_guest) {
                        callcenter.query_logout();
                        var myTime = new Date();
                        var filename = window.location.href;
                        tool.cookie("mgc_logError_mgc_comm_view_RoomLoginBarView_click_do_login_fun__mgc_account_login__logout__query_logout___mgc_account_is_guest", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___mgc_comm_view_RoomLoginBarView_click_do_login_fun__mgc_account_login_logout__query_logout___mgc_account_is_guest___filename" + filename, {
                            path: '/',
                            domain: '.qq.com'
                        });
                    } else {
                        mgc.account.checkLogin(function() {
                            callcenter.query_clear_login_cookie(function() {
                                console.log("cookie cleared!");
                                var myTime = new Date();
                                var filename = window.location.href;
                                tool.cookie("mgc_logError_mgc_comm_view_RoomLoginBarView_mgc_account_login__mgc_account_checkLogin__click_do_login_fun", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___mgc_account_login__mgc_account_checkLogin___not_guest_unLogin__loginBtn__do_click___web--mgc_comm_view_RoomLoginBarView____mgc_account_login___mgc_account_checkLogin_____click_do_login_fun-loginBtn__do_click___filename" + filename, {
                                    path: '/',
                                    domain: '.qq.com'
                                });
                            });
                            _this.login_callback();
                        }, null, true);
                    }
                    tool.EAS([{ 'e_c': 'mgc.login', 'c_t': 4 }]);
                }, _this.cancel_callback);
            }, true);
        },
        click_logined_fun: function(e) {
            console.log("点击头像");
            if (MgcAPI.SNSBrowser.IsX52()) {
                console.log("X52PC=====点击头像");
                e.preventDefault();
                return false;
            }
        },
        logout_fun: function() {
            //主动登出
            mgc.common_logic.logout(true);
            var myTime = new Date();
            var filename = window.location.href;
            tool.cookie("mgc_logError_mgc_comm_view__RoomLoginBarView__logout_fun", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "_____reason___Do_Logout__RoomLoginBarView__logout_fun___web--login_logout___filename" + filename, {
                path: '/',
                domain: '.qq.com'
            });
        }
    });
    common.getViewRoomLoginBar = function(_model, _login_callback, _cancel_callback, _get_playerinfo_callback) {
        return new RoomLoginBarView({ model: _model }, _login_callback, _cancel_callback, _get_playerinfo_callback);
    };
    /*
    * 顶条登录组件-玩家信息-视图
    * @type {void|*}
    */
    var PlayerInfoView = backbone.View.extend({
        el: $("#logined-con-playerinfo"),
        isready: false,
        template: $("#logined-con-playerinfo-tmpl"),//_.template(templates.get_playerinfo_header_bar_tmpl())
        events: {
            "": "",
            "click .recharge-btn": "click_recharge_fun",
            "click .loginout": "click_loginout"
        },
        login_callback: null,
        initialize: function() {
            this.login_qq_face = $("#login_qq_face");
            this.listenTo(this.model, 'reset', this.render);
        },
        render: function() {
            var _this = this;
            var data = this.model.models[0].attributes;
            this.$el.html(this.template.tmpl(data));
            var photo_url = data.photo_url;
            if (photo_url == "") {
                if (data.sex_male == 0) {
                    photo_url = 'http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_female.png?v=3_8_8_2016_15_4_final_3';
                } else {
                    photo_url = 'http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_male.png?v=3_8_8_2016_15_4_final_3';
                }
            }
            //当拉到个人信息数据，展开在线隐身状态
            $('#logined_status').attr('style', '');

            //设置在线、隐身状态 true：隐身 、false:在线
            //隐身不走模板，放到外面，这里进行修改赋值
            if (data.invisible) {
                mgc.consts.MGCData.invisible = true;
                console.log('是否隐身——拉取个人头像信息——隐身（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                $('#icon1').text("隐身").attr('class', 'icon1');
                $('#icon0').text("在线").attr('class', 'icon0');
            } else {
                mgc.consts.MGCData.invisible = false;
                console.log('是否隐身——拉取个人头像信息——在线（mgc.consts.MGCData.invisible）：' + mgc.consts.MGCData.invisible);
                $('#icon1').text("在线").attr('class', 'icon0');
                $('#icon0').text("隐身").attr('class', 'icon1');
            }
            //贵族可以隐身切换
            if (data.vip_level > 0) {
                $('#logined_status').attr('style', '');
            } else {
                $('#logined_status').attr('style', 'display:none');
            }

            if (MgcAPI.SNSBrowser.IsQQGame() || MgcAPI.SNSBrowser.IsX52()) {
                //屏蔽game端 退登
                $(".loginout").hide();
            }
            this.$(".icon_mhb").off("mouseover,mouseout").on("mouseover", function() {
                susTips = $('.mhb_tips_login');
                _this.comm_tips_position(susTips);
                window.mgc.popmanager.layerControlShow(susTips, 3, 3);
            }).on("mouseout", function() {
                susTips = $('.mhb_tips_login');
                window.mgc.popmanager.layerControlHide(susTips, 3, 3);
            });
            this.$(".icon_xd").off("mouseover,mouseout").on("mouseover", function() {
                susTips = $('.xd_tips_login');
                _this.comm_tips_position(susTips);
                window.mgc.popmanager.layerControlShow(susTips, 3, 3);
            }).on("mouseout", function() {
                susTips = $('.xd_tips_login');
                window.mgc.popmanager.layerControlHide(susTips, 3, 3);
            });
            this.$(".icon_caifu").off("mouseover,mouseout").on("mouseover", function() {
                var t = this.offsetTop - 5;
                var l = this.offsetLeft + 60;
                susTips = $('.caifu_tips_login');
                susTips.css({ "top": t, "left": l });
                window.mgc.popmanager.layerControlShow(susTips, 1, 3);
            }).on("mouseout", function() {
                susTips = $('.caifu_tips_login');
                window.mgc.popmanager.layerControlHide(susTips, 1, 3);
            });
            this.$("#mgc_personal").unbind("click").bind("click", function() {
                tool.EAS([{ 'e_c': 'mgc.personal', 'c_t': 4 }]);
            });
            _this.login_qq_face.attr({ "src": photo_url, "style": "background:url(" + photo_url + ") no-repeat scroll center center" });
            return this;
        },
        comm_tips_position: function(obj) {
            var mouseXY = tool.offsetEvent.mouseXY();
            var clientXY = tool.offsetEvent.clientXY();
            var scrollXY = tool.offsetEvent.scrollXY();
            var _w = obj.width();
            var _x = mouseXY.X + 30;
            var _y = mouseXY.Y - (obj.height() / 2);
            if (clientXY.X < _x + _w + 10) {
                _x = clientXY.X - _w - 10;
                _y = mouseXY.Y + 25;
            }
            if (document.all)
                _x += scrollXY.X, _y += scrollXY.Y;
            obj.css({ "top": _y, "left": _x });
        },
        show_tips: function() {

        },
        hide_tips: function() {

        },
        reset_playerinfos: function(_playerinfo) {
            player_info_coll.reset_playerinfo(_playerinfo);
        }
    });
    /*
    * 顶条登录组件-玩家关注的主播-视图
    * @type {void|*}
    */
    var FollowInfoView = backbone.View.extend({
        el: $("#followedContainer"),
        template: $("#followedTmpl"),//_.template(templates.get_player_followed_tmpl())
        initialize: function() {
            this.listenTo(this.model, 'reset', this.render);
        },
        render: function() {
            var followinfos = this.model.models[0].attributes.followinfo_vec;
            this.$el.children().remove();
            if (followinfos && followinfos.length > 0) {
                this.$el.next().hide();
                for (var i = 0; i < followinfos.length; i++) {
                    this.$el.append(this.template.tmpl(followinfos[i]));
                }
            } else {
                this.$el.next().show();
            }
            return this;
        },
        reset_playerinfos: function(_playerinfo) {
            player_info_coll.reset_playerinfo(_playerinfo);
        }
    });
    common.getViewPlayerInfo = function() {
        return new PlayerInfoView({ model: comm_coll.getPlayerInfoColl });
    };
    common.getViewFollowInfo = function() {
        return new FollowInfoView({ model: comm_coll.getPlayerInfoColl });
    };
    /*
    * 搜索组件 - 视图
    * @type{void|*}
    */
    common.SearchBarView = backbone.View.extend({
        el: $("#submitForm"),
        events: {
            "focus #search_con": "search_con_focus",
            "blur #search_con": "search_con_blur",
            "keyup #search_con": "serch_con_keyup",
            "keydown #search_con": "serch_con_keydown",
            "click #searchBtn": "search_btn_click",
            "submit": "submit"
        },
        initialize: function() {
            this.search_con = this.$("#search_con");
            this.formRoomId = this.$("#formRoomId");
            this.submitBtn = this.$("#submitBtn");
        },
        render: function() {
            return this;
        },
        /*
        获得焦点事件
        */
        search_con_focus: function() {
            var txt = $.trim(this.search_con.val());
            this.search_con.css({ "color": "#1c1c1c" });
            if (txt == "输入房间ID 快速查找") {
                this.search_con.val("");
            }
        },
        /*
        失去焦点事件
        */
        search_con_blur: function() {
            var txt = $.trim(this.search_con.val());
            if (txt == "") {
                this.search_con.val("输入房间ID 快速查找").css({ "color": "#bcbcbc" });
            }
        },
        /*
        keyup
        */
        serch_con_keyup: function() {
            var txt = $.trim(this.search_con.val());
            if (txt.length > 20) {
                this.search_con.val(txt.substring(0, 20));
            }
        },
        /*
        keydown
        */
        serch_con_keydown: function() {
            var txt = $.trim(this.search_con.val());
            if (txt.length >= 20) {
                if (event.keyCode == 13)
                    event.returnValue = true;
                else
                    event.returnValue = false;
            }
            if (event.keyCode == 8) {
                event.returnValue = true;;
            }
        },
        /*
        点击事件
        */
        search_btn_click: function() {
            if (this.checkFormSubmit()) {
                this.submitBtn.click();
            }
        },
        /*
        提交表单
        */
        submit: function() {
            if (this.checkFormSubmit()) {
                tool.EAS([{ 'e_c': 'mgc.enterroom.2', 'c_t': 4 }, { 'e_c': 'mgc.enterroom', 'c_t': 4 }]);
                return true;
            }
            return false;
        },
        /*
        检查输入
        */
        checkFormSubmit: function() {
            var txt = $.trim(this.search_con.val());
            if (txt == '' || txt == '请输入房间号') {
                alert('想要快速进入房间，必须输入2位以上数字');
                return false;
            } else if (txt.length > 20) {
                alert('没有该房间哦');
                return false;
            } else if (!/^\d+$/.test(txt)) {
                alert('想要快速进入房间，必须输入2位以上数字');
                return false;
            }
            var roomIdFormat = parseInt(txt, 10);
            if (roomIdFormat < 10) {
                alert('想要快速进入房间，必须输入2位以上数字。');
                return false;
            }
            var _url = "transfer.shtml";
            //this.$el.attr('action', _url);

            if (MgcAPI.SNSBrowser.IsQQGameLiveArea() == "true") {
                $('#param').attr('value', MgcAPI.SNSBrowser.IsQQGameLiveArea());
                this.$el.removeAttr("target");
                this.$el.attr("href", "_self");

            }
            else if (MgcAPI.SNSBrowser.IsQQGame() || MgcAPI.SNSBrowser.IsX52()) {
                $('#param').attr('value', false);
                this.$el.removeAttr("target");
                this.$el.attr("href", "_self");
            }
            else {
                $('#param').attr('value', false);
                this.$el.attr("href", "_blank");
            }
            this.$el.attr('action', _url);
            this.formRoomId.val(txt);
            tool.EAS([{ 'e_c': 'mgc.enterroom.2', 'c_t': 4 }, { 'e_c': 'mgc.enterroom', 'c_t': 4 }]);
            return true;
        }
    });
    /*
    * banner-视图
    * @type {void|*}
    */
    common.BannerView = backbone.View.extend({
        tagName: "li",
        template: _.template(templates.get_banner_tmpl()),
        initialize: function() {
            this.listenTo(this.model, 'reset', this.render);
        },
        render: function() {
            this.$el.html(this.template(this.model.attributes));
            return this;
        }
    });
    /*
    * banner组件-视图
    * @type {void|*}
    */
    common.BannerSliderView = backbone.View.extend({
        el: $("#banner"),
        model_coll: null,
        callback: null,
        initialize: function(_model_coll, _callback) {
            this.model_coll = _model_coll;
            this.callback = _callback;
            this.topBanner = this.$("#topBanner");
            this.topBannerCarousel = this.$("#topBannerCarousel");
            this.topBanner.children().remove();
            var len = this.model_coll.length;
            var _carouseHtml = '';
            for (var i = 0; i < len; i++) {
                this.model_coll.models[i].sAdId = i + 1;
                var banner_view = new common.BannerView({ model: this.model_coll.models[i] });
                this.topBanner.append(banner_view.render().el);
                if (i == 0) {
                    _carouseHtml += '<span class="current"></span>';
                } else {
                    _carouseHtml += '<span></span>';
                }
            }
            this.topBannerCarousel.html(_carouseHtml);
            tool.carousel("banner", "ban_pic", "ban_btn", 111, 5000, "top");
        },
        render: function() {
            return this;
        }
    });
    /*
    *@input组件-视图
    *@基础input类
    *@type   {void|*}
    *@todo  基础操作：获得焦点、失去焦点、回车
    *@params tagname             input/textarea
    *@params type                input类型
    *@params msg                 默认提示文字
    *@params val                 值
    *@params maxlength           最大值
    *@params minlength           最小值
    *@params classtype           值类型
    *@params callback            回调
    */
    common.Input = backbone.View.extend({
        tagName: "input",
        params: {},
        events: {
            "focus": "focus",
            "blur": "blur",
            "click": "click",
            "keyup": "keyup",
            "keydown": "keydown"
        },
        initialize: function(_params) {
            this.params = _params;
            this.tagName = _params.tagname;
            this.attr("type", _params.type);
        },
        render: function() {
            return this;
        },
        focus: function() {

        },
        blur: function() {

        },
        click: function() {

        },
        keyup: function() {

        },
        keydown: function() {

        }
    });
    /*
    *奖励图标  视图
    */
    var RewardView = backbone.View.extend({
        tagName: "li",
        template: null,
        events: {
            "mouseover .mouse_tips": "mouseover",
            "mouseout .mouse_tips": "mouseout"
        },
        initialize: function(model) {
            this.listenTo(this.model, 'reset', this.render);
        },
        render: function() {
            var tmpl = this.template.tmpl(this.model.attributes);
            this.$el.html(tmpl);
            tmpl = null;
            return this;
        },
        mouseover: function(e) {

        },
        mouseout: function(e) {

        }
    });
    common.RewardView = RewardView;
    /*
    *奖励弹窗公共  视图
    *@param data                奖励数据
    *@param ok_callback         确定回调
    *@param cancel_callback     取消回调
    */
    var RewardDialogView = backbone.View.extend({
        el: $("#rewards-dialog"),
        events: {
            "click .btn_open": "click_ok",
            "click .pop_close": "click_close"
        },
        data: null,
        model_coll: null,
        ok_callback: null,
        cancel_callback: null,
        initialize: function(data, _ok_callback, _cancel_callback) {
            //生成数据
            this.model_coll = new comm_coll.RewardColl();
            this.model_coll.reset_reward_list(data.rewards);
            this.data = data;
            this.ok_callback = _ok_callback;
            this.cancel_callback = _cancel_callback;
            //奖励页面元素
            this.rewardListContainer = this.$("#rewardListContainer");
            //奖励模板
            this.rewardListTmpl = $("#rewardListTmpl");
            //清空节点
            this.rewardListContainer.children().remove();
            //遍历单个奖励对象
            var len = this.model_coll.length;
            for (var i = 0; i < len; i++) {
                var reward_view = new common.RewardView({ model: this.model_coll.models[i] });
                reward_view.template = this.rewardListTmpl;
                this.rewardListContainer.append(reward_view.render().el);
            }
            this.rewardListContainer.find(".mouse_tips").mouseover(function(e) {
                mgc_tips.suswTips2(e, 1, $(this).data("name"), $(this).data("tips"));
            }).mouseout(function(e) {
                mgc_tips.suswTips2(e, 0);
            });
            //绑定翻页显示
            if (data.rewards.length <= 5) {
                this.$("#task_pre,#task_next").hide();
            } else {
                this.$("#task_pre,#task_next").show();
                tool.flipOver("#rewards-dialog", 5, 381);
            }
            data.title = data.title || "任务奖励";
            data.showTips = data.showTips || "任务完成，恭喜您获得以下奖励:";
            this.$(".pop_title").html(data.title);
            this.$(".pop_showtips").html(data.showTips);
            this.$(".pop_gametips").html(data.showTips_game);
            window.mgc.popmanager.layerControlShow(this.$el, 5, 1);
            this.$el.centerDisp();
        },
        render: function() {
            return this;
        },
        //OK
        click_ok: function() {
            window.mgc.popmanager.layerControlHide(this.$el, 5, 1);
            if (this.ok_callback)
                this.ok_callback();
        },
        //CLOSE
        click_close: function() {
            window.mgc.popmanager.layerControlHide(this.$el, 5, 1);
            if (this.cancel_callback)
                this.cancel_callback();
        }
    });
    common.RewardDialogView = RewardDialogView;
    /*
    *首登礼包  视图
    */
    var FirstLoginView = backbone.View.extend({
        el: $("#pop_logingifts"),
        events: {
            "click .submitReceive": "click_receive_gifts",
            "click .pop_close": "click_close"
        },
        data: null,
        model_coll: null,
        ok_callback: null,
        cancel_callback: null,
        initialize: function(data, _ok_callback, _cancel_callback) {
            this.model_coll = new comm_coll.RewardColl();
            this.model_coll.reset_reward_list(data.rewards);
            this.data = data;
            this.ok_callback = _ok_callback;
            this.cancel_callback = _cancel_callback;
            this.logingiftsList = this.$("#logingiftsList");
            this.logingiftsTmpl = $("#logingiftsTmpl");
            this.logingiftsList.children().remove();
            var Qgame = false;
            $.each(data.rewards, function(k, v) {
                if (v.channel == 3) {
                    Qgame = true;
                }
            })
            if (MgcAPI.SNSBrowser.IsQQGame()) {
                Qgame = true;
            }
            var len = this.model_coll.length;
            for (var i = 0; i < len; i++) {
                var reward_view = new common.RewardView({ model: this.model_coll.models[i] });
                reward_view.template = this.logingiftsTmpl;
                this.logingiftsList.append(reward_view.render().el);
            }
            this.logingiftsList.find(".mouse_tips").mouseover(function(e) {
                mgc_tips.suswTips2(event, 1, $(this).data("name"), $(this).data("tips"));
            }).mouseout(function(e) {
                mgc_tips.suswTips2(event, 0);
            });
            //绑定tips显示
            if (data.rewards.length <= 5) {
                this.$("#task_pre,#task_next").hide();
            } else {
                tool.flipOver("#pop_logingifts", 5, 381);
            }
            if (data.hasgame == true) {
                if(window.mgc.config.channel == 0){
                    this.$('#hasgame').text('（获得的游戏道具会直接进入游戏背包）');
                }else{
                    this.$('#hasgame').text('（获得的游戏道具以邮件发放到电脑端）');
                }
            } else {
                this.$('#hasgame').text('：');
            }

            if (Qgame) {
                $('#logingifts_title').html("欢迎来到梦工厂！恭喜您获得以下奖励，每期奖励数量有限先到先得哦~");
                $('#logingifts_title').css({ 'right': '23px', 'width': '384px' });
            } else {
                if (data.hasgame) {
                    if(window.mgc.config.channel == 0){
                        $('#logingifts_title').html("欢迎来到梦工厂！恭喜您获得以下奖励（获得的游戏道具会直接进入游戏背包）");
                    }else{
                        $('#logingifts_title').html("欢迎来到梦工厂！恭喜您获得以下奖励（获得的游戏道具以邮件发放到电脑端）");
                    }
                    $('#logingifts_title').css({ 'right': '5px', 'width': '420px' });
                } else {
                    $('#logingifts_title').html("欢迎来到梦工厂！恭喜您获得以下奖励：");
                }
            }

            window.mgc.popmanager.layerControlShow(this.$el, 4, 1);
            this.$el.centerDisp();
        },
        render: function() {
            return this;
        },
        //领取首登礼包
        click_receive_gifts: function() {
            window.mgc.popmanager.layerControlHide(this.$el, 4, 1);
            if (this.ok_callback)
                this.ok_callback();
        },
        //关闭
        click_close: function() {
            window.mgc.popmanager.layerControlHide(this.$el, 4, 1);
            if (this.cancel_callback)
                this.cancel_callback();
        }
    });
    common.FirstLoginView = FirstLoginView;

    /*********************************************/

    /*
*首登礼包-领取补发奖励  视图
*/
    var FirstLoginGetView = backbone.View.extend({
        el: $("#pop_logingiftsGet"),
        events: {
            "click #pop_newPlayer_a_get,click #pop_newPlayer_act_get": "click_receive_gifts"
        },
        data: null,
        model_coll: null,
        ok_callback: null,
        cancel_callback: null,
        initialize: function(data, _ok_callback, _cancel_callback) {
            this.model_coll = new comm_coll.RewardColl();
            this.model_coll.reset_reward_list(data.rewards);
            this.data = data;
            this.ok_callback = _ok_callback;
            this.cancel_callback = _cancel_callback;
            this.logingiftsListGet = this.$("#logingiftsListGet");
            this.logingiftsTmpl = $("#logingiftsGetTmpl");
            this.logingiftsListGet.children().remove();
            var Qgame = false;
            $.each(data.rewards, function(k, v) {
                if (v.channel == 3) {
                    Qgame = true;
                }
            })
            if (MgcAPI.SNSBrowser.IsQQGame()) {
                Qgame = true;
            }
            var len = this.model_coll.length;
            for (var i = 0; i < len; i++) {
                var reward_view = new common.RewardView({ model: this.model_coll.models[i] });
                reward_view.template = this.logingiftsTmpl;
                this.logingiftsListGet.append(reward_view.render().el);
            }
            this.logingiftsListGet.find(".mouse_tips").mouseover(function(e) {
                mgc_tips.suswTips2(event, 1, $(this).data("name"), $(this).data("tips"));
            }).mouseout(function(e) {
                mgc_tips.suswTips2(event, 0);
            });
            //绑定tips显示
            if (data.rewards.length <= 5) {
                this.$("#task_pre,#task_next").hide();
            } else {
                tool.flipOver("#pop_logingiftsGet", 5, 381);
            }

            window.mgc.popmanager.layerControlShow(this.$el, 4, 1);
            this.$el.centerDisp();
        },
        render: function() {
            return this;
        },
        //领取首登补发礼包
        click_receive_gifts: function() {
            window.mgc.popmanager.layerControlHide(this.$el, 4, 1);
            if (this.ok_callback)
                this.ok_callback();
        }
    });
    common.FirstLoginGetView = FirstLoginGetView;

    /*
    *签到界面视图
    */
    var SignView = backbone.View.extend({
        el: $("#pop_sign"),
        events: {
            "click .pop_close": "click_close"
            //"click .sign_submit_btn span": "click_receive_daily_reward",
            //"click .icon_lingqu": "click_receive_cumulative_reward"
        },
        data: null,
        receive_daily_reward_callback: null,
        receive_cumulative_reward_callback: null,
        click_daily_reward: true,
        click_cumulative_reward: true,
        cancel_callback: null,
        initialize: function(data, _receive_daily_reward_callback, _receive_cumulative_reward_callback, _cancel_callback) {
            var _this = this;
            this.receive_daily_reward_callback = _receive_daily_reward_callback;
            this.receive_cumulative_reward_callback = _receive_cumulative_reward_callback;
            this.cancel_callback = _cancel_callback;
            var _fill_rewardinfo = this.fill_rewardinfo;
            var QGAME = false;
            $.each(data.info.daily_rewards, function(w, y) {
                if (y.channel == 3) {
                    QGAME = true;
                }
            });
            if (MgcAPI.SNSBrowser.IsQQGame()) {
                QGAME = true;
            }

            //初始化每日奖励区
            $.each(data.info.daily_rewards, function(k, v) {

                v.num = k + 1;
                _fill_rewardinfo(v);
                if (((v.multiply > 1 && v.level > 0) && (QGAME == false)) || ((v.multiply > 1 && v.level > 0) && (!MgcAPI.SNSBrowser.IsX52()))) {
                    v.doubleIcon = " icon_double_" + v.level;
                    v.isDouble = "";
                } else {
                    v.doubleIcon = "";
                    v.isDouble = "display:none;";
                }
                if (data.info.accumulate_day >= v.num) {
                    v.isSign = "";
                } else {
                    v.isSign = "display:none;";
                }
                v.borderFlashShow = 0;
                if (!data.info.is_signin_today && v.num == data.info.accumulate_day + 1) {
                    //当前每日奖励特殊标示
                    if (data.info.daily_rewards.length > 30) {
                        v.borderFlashShow = 2;//小框
                    } else {
                        v.borderFlashShow = 1;//大框
                    }
                }
            });

            data.info.is_accumulate_today = false;
            //初始化累计奖励区
            $.each(data.info.accumulate_rewards, function(k, v) {
                v.statusRecive = v.status == 0 ? "icon_lingqu" : v.status == 1 ? "icon_yilingqu" : "icon_bukelingqu";
                v.index = k;
                if (v.status == 0)
                    data.info.is_accumulate_today = true;
                $.each(v.rewards, function(i, o) {
                    _fill_rewardinfo(o);
                });
            });
            //更改常驻按钮状态
            if (data.info.is_accumulate_today || !data.info.is_signin_today) {
                $(".header_sign_flash,#h-nav .nav4 .icon-red-dot").show();
            } else {
                $(".header_sign_flash,#h-nav .nav4 .icon-red-dot").hide();
            }
            var signCon = $('#signTmpl');
            var signTmpl;
            var signContainer = this.$('#signContainer');
            signContainer.children().remove();
            signTmpl = signCon.tmpl(data.info);
            signTmpl.appendTo(signContainer);
            //添加tips时间
            this.$el.find("#sign_rewards_list,.sign_opt_rewards_li").find(".mouse_tips").mouseover(function(e) {
                mgc_tips.suswTips4(e, 1, $(this).data("name"), $(this).data("tips"), "sign");
            }).mouseout(function(e) {
                mgc_tips.suswTips4(e, 0, "", "", "sign");
            });
            //更新title
            this.$el.find(".pop_title span").attr("class", "icon_month_" + data.info.month);
            //根据自然月的实际天数 调节页面版式
            if (data.info.daily_rewards.length > 30) {
                this.$el.css("background-image", "url(http://ossweb-img.qq.com/images/mgc/css_img/sign/sign_bg_1.png?v=3_8_8_2016_15_4_final_3)");
            } else {
                this.$el.css("background-image", "url(http://ossweb-img.qq.com/images/mgc/css_img/sign/sign_bg_2.png?v=3_8_8_2016_15_4_final_3)");
                this.$el.find("#sign_rewards_list li").css("height", "109px");
                this.$el.find(".r_img").addClass('r_img r_img_icon');
                this.$el.find(".r_mouse").css("height", "89px");
            }
            //每日签到
            this.$(".sign_submit_btn span").unbind("click").click(function() {
                if (_this.click_daily_reward) {
                    _this.click_daily_reward = false;
                    _this.click_receive_daily_reward(_this)
                }
            });
            //累计签到
            this.$(".icon_lingqu").unbind("click").click(function(e) {
                if (_this.click_cumulative_reward) {
                    _this.click_cumulative_reward = false;
                    _this.click_receive_cumulative_reward(e, _this)
                }
            });
            if (this.$("p#sign_submit_btn_swf").length > 0) {
                this.signBtnFlashInit();
            }
            window.mgc.popmanager.layerControlShow(this.$el, 4, 1);
            console.log("渲染：签到界面");
            this.$el.centerDisp();
            signTmpl = null;
            signCon = null;
        },
        signBtnFlashInit: function() {
            var flashvars = {};
            var params = {};
            params.quality = "high";
            params.bgcolor = "#000";
            params.allowscriptaccess = "always";
            params.allowfullscreen = "true";
            params.allowFullScreenInteractive = "true";
            params.wmode = "transparent";
            var attributes = {};
            var swfurl = "assets/sign_btn.swf?v=3_8_8_2016_15_4_final_3";
            swfobject.embedSWF(swfurl, "sign_submit_btn_swf",
                "100%", "100%", "11.1.0", '', flashvars, params, attributes);
        },
        render: function() {
            return this;
        },
        //领取每日签到奖励
        click_receive_daily_reward: function(_this) {
            if (_this.receive_daily_reward_callback)
                _this.receive_daily_reward_callback();
        },
        click_receive_cumulative_reward: function(e, _this) {
            var n = $(e.srcElement || e.target).attr("rel");
            var m = $(e.srcElement || e.target).attr("data-coord");
            if (_this.receive_cumulative_reward_callback)
                _this.receive_cumulative_reward_callback(n, m);
        },
        //关闭
        click_close: function() {
            $('.signTip').hide();
            window.mgc.popmanager.layerControlHide(this.$el, 4, 1);
            if (this.cancel_callback)
                this.cancel_callback();
        },
        fill_rewardinfo: function(o) {
            var url = o.channel == 0 ? o.url : o.channel == 3 ? o.url : o.channel == 4 ? o.url : o.channel == 2 ? ("http://ossweb-img.qq.com/images/mgc/css_img" + o.url) : ("http://ossweb-img.qq.com/images/mgc/css_img" + o.url);
            o.url = url;
            o.isTrue = true;
            o.gameMark = false;
            if (o.channel == 0) {
                o.gameMark = true;
            } else if (o.channel == 3) {
                o.Qgame = true;
                if (o.url == '') {
                    o.url = "http://ossweb-img.qq.com/images/mgc/css_img/common/game_default.png?v=3_8_8_2016_15_4_final_3";
                }
            }

        }
    });

    common.SignView = SignView;

    /*
     *获取玩家当前任务数
     */
    common.getDoneActCount = function() {
        callcenter.query_done_act_count(common.hasActCallBack);
    };

    var hasActCount = null;
    /*
     * 未完成任务数回调
     */
    common.hasActCallBack = function(resp, params) {
        if (!resp.has_taken_wage_today) {
            if (resp.count - 1 > 0) {
                hasActCount = true;
            }
        } else {
            if (resp.count > 0) {
                hasActCount = true;
            }
        }
        if (resp.status == 65) {
            //window.mgc.common_logic.CheckNameError(153);
            return;
        }

        if (resp.count > 0) {
            $('.logined_nav,#h-nav .nav5').find('b').show();
        } else {
            $('.logined_nav,#h-nav .nav5').find('b').hide();
        };
    }


    if (!window.mgc) {
        window.mgc = {};
    }
    window.mgc.common_view = common;
    return common;
});