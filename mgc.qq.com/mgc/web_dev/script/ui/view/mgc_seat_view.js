/**
 * @Description:   梦工厂web-视图-守护宝座
 *
 * @author         Xu XiaoJing
 * @version        V1.0
 * @Date           2015/12/05
 * @Company        horizon3d
 */
define(['backbone', 'mgc_tool', 'mgc_popmanager', 'mgc_account'], function(backbone, mgc_tool, mgc_popmanager, mgc_account) {
    var seat_view = {};
    seat_view.seatListView = backbone.View.extend({
        el: ".seatlist",
        initialize: function() {
            this.template = $('#seatTmpl');
            this.listenTo(this.model, 'change', this.render);
            /*
             //抢座按钮
             seatContainer.find("li a.seatbtn").click(Seat.onGrap);
             //玩家头像点击
             seatContainer.find("li a.userbtn").click(Seat.onClickUser);
             */

        },
        render: function() {
            var seatList = this.model.getSeatList();
            var tmpl = this.template.tmpl(seatList);
            this.$el.html(tmpl);
            tmpl = null;
        },
        events: {
            'mouseover li': 'onOverUser',
            'mouseout li': 'onOutUser',
            'click li a.userbtn': 'onClickUser',
            'click li a.seatbtn': 'onGrap'
        },
        //滑过玩家头像
        onOverUser: function(e) {
            var $li = $(e.currentTarget);
            var seatid = $li.data("seatid");
            var seat = this.model.getSeat(seatid);
            var seatUserTipCon = $('#seatUserTipTmpl');
            var seatUserTipTmpl;
            var container = $('#seatListTip2');
            seatUserTipTmpl = seatUserTipCon.tmpl(seat)
            container.html(seatUserTipTmpl);
            container.css({
                top: $li.offset().top,
                left: $li.offset().left + 80
            });
            mgc_popmanager.layerControlShow($("#seatListTip2"), 1, 3);
            seatUserTipTmpl = null;
            seatUserTipCon = null;
        },
        onOutUser: function(e) {
            mgc_popmanager.layerControlHide($("#seatListTip2"), 1, 3);
        },
        //点击守护 位置
        onClickUser: function(e) {
            //是否游客
            if (mgc_account.checkGuestStatus(false))
                return;

            var $li = $(e.currentTarget);
            var playerid = $li.data("playerid");
            var inroom = $li.data("inroom");
            //是否空座位
            if (playerid == "0")
                return;
            //是否离线
            if (!inroom) {
                Seat.onShowOffLineUserMenu(e);
                return;
            }
            //非空座位
            if (playerid != "0") {
                var mgc_room = require("mgc_room");
                mgc_room.room_request.getPlayerInfo($li.data("name"), $li.data("zone"), e);
            }
        },
        //显示离线玩家菜单
        onShowOffLineUserMenu: function(e) {
            e.stopPropagation();
            var $a = $(e.currentTarget);
            var _playerInfo = {};
            _playerInfo._portrait_url = $a.data("picurl");
            _playerInfo._nickName = $a.data("name");
            _playerInfo._showAreaName = $a.data("zone");
            _playerInfo._sexFemale = ($a.data("sex") == 1 ? "" : "female");
            _playerInfo._vip_level = $a.data("viplevel");
            _playerInfo._guard_level = $a.data("guardlevel");
            switch (_playerInfo._vip_level) {
                case 0:
                    _playerInfo._nickColor = "#111111";
                    //非贵族
                    break;
                case 1:
                    _playerInfo._nickColor = "#1a6b00";
                    //近卫
                    break;
                case 2:
                    _playerInfo._nickColor = "#006772";
                    //骑士
                    break;
                case 3:
                    _playerInfo._nickColor = "#0a57af";
                    //将军
                    break;
                case 4:
                    _playerInfo._nickColor = "#8f00b1";
                    //亲王
                    break;
                case 5:
                    _playerInfo._nickColor = "#ae5600";
                    //皇帝
                    break;
                default:
                    break;
            }
            if (_playerInfo._guard_level > 0) {
                _playerInfo.guardlevelClass = "icon_lv icon_lv" + _playerInfo._guard_level;
            }
            if (_playerInfo._vip_level > 0) {
                _playerInfo.viplevelClass = "icon_honor icon_honor" + _playerInfo._vip_level;
            }
            _playerInfo.card_list_info = '';
            _playerInfo.card_list_info += '<ul class="list_btn">';
            _playerInfo.card_list_info += '<li><a href="javascript:copyToClipBoard();">复制昵称</a></li>';
            _playerInfo.card_list_info += '</ul>';
            _playerInfo._cardClass = 'icon_card';

            var cardTipCon = $('#cardTipTmpl');
            var cardTipTmpl;
            var cardTipContainer = $('#cardTipContainer');
            cardTipContainer.children().remove();
            cardTipTmpl = cardTipCon.tmpl(_playerInfo);
            cardTipTmpl.appendTo(cardTipContainer);

            $('.icon_card').off('click').on('click', function() {
                $(".card_tips").hide();
                //查询名片信息
                MGC_CommRequest.getListCard($a.data("playerid"),2);
            });
            var mgc_room = require("mgc_room");
            mgc_room.room_request.cardTips(e, 's_con_card');
            cardTipTmpl = null;
            cardTipCon = null;
        },
        //点击抢座
        onGrap: function(e) {
        	var mgc_seat = require("mgc_seat");
            mgc_seat.seat_request.onGrap(e);
        },
        susTipsLvList: function(e, n, val, obj, tem) {
            var _e = e.target == undefined ? e.toElement : e.target;
            var arr = {}, sum = 0;

            if ((n == 1 && val == '') || (n == 1 && val == "|@abc|@abc|@abc|@abc|@abc|@abc") || (n == 1 && val == "|@abc|@abc|@abc|@abc|@abc|@abc;cursor: auto") || (n == 1 && val == "|@abc|@abc|@abc|@abc|@abc;cursor: auto") || (n == 1 && val == "|@abc|@abc|@abc|@abc|@abc;cursor: auto|@abc")) {
                return false;
            }
            var susTips = $("." + tem);
            susTips.children().remove();
            if (n == 1) {
                if (val != '') {
                    val = $(obj).attr("name") + "|@abc" + val;
                    arr = val.split('|@abc');
                    if (arr[5] > 5) {
                        sum = 8 - arr[5];
                        sum2 = 0;
                    } else {
                        sum = 5 - arr[5];
                        sum2 = 92;
                    }
                    var t = $(_e).offset().top + 61;
                    var l = $(_e).offset().left + 80;
                    susTips.css({
                        "top": t,
                        "left": l
                    });
                    susTips.append("<p>名字：<strong style='color:" + arr[6] + "'>" + arr[0] + "</strong></p><p>等级：LV" + arr[1] + "</p><p>财富等级：" + arr[2] + "</p><p>财富值：" + arr[3] + "</p><p>贵族身份：" + arr[4] + "</p><p>大区：" + arr[7] + "</p>");
                }
                mgc_popmanager.layerControlShow(susTips, 1, 3);
            } else {
                mgc_popmanager.layerControlHide(susTips, 1, 3);
            }
        }
    });

    return seat_view;
});
