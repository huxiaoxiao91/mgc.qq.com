/**
 * @Description:   梦工厂web-控制-守护宝座
 *
 * @author         Xu XiaoJing
 * @version        V1.0
 * @Date           2015/12/05
 * @Company        horizon3d
 */
define(['mgc_callcenter', 'mgc_seat_view', 'mgc_seat_model', 'mgc_tool', 'mgc_consts', 'mgc_popmanager', 'mgc_account', 'mgc_dialog'], function(callcenter, mgc_seat_view, mgc_seat_model, mgc_tool, consts, mgc_popmanager, mgc_account, mgc_dialog) {
    var control = {};
    $(".seat").html($("#seattemp").html());
    $("#seattemp").children().remove();
    var seatListModel = new mgc_seat_model.seatListModel();
    var seatListView = new mgc_seat_view.seatListView({
        model: seatListModel
    });
    //问号
    $(".seattipbtn").off('mouseover mouseout').on({
        mouseover: function(e) {
            var thisEle = e.srcElement || e.target;
            var t = $(thisEle).offset().top - 80;
            var l = $(thisEle).offset().left - 79;
            $("#seatListTip1").css({
                top: t,
                left: l
            });
            mgc_popmanager.layerControlShow($("#seatListTip1"), 1, 3);
        },
        mouseout: function() {
            mgc_popmanager.layerControlHide($("#seatListTip1"), 1, 3);
        }
    });
    //监听下发========================================
    //守护宝座列表232
    callcenter.addRespListener(callcenter.OP_TYPE.RECEIVE_SEAT_LIST, function(resp, params) {
        seat_callBack.receiveSeatList(resp);
    });
    //座位被抢通知231
    callcenter.addRespListener(callcenter.OP_TYPE.LOST_SEAT, function(resp, params) {
        seat_callBack.seatLost(resp);
    });

    //发送请求========================================
    var seat_request = {
        //点击抢座
        onGrap: function(e) {
            //是否游客
            if (mgc_account.checkGuestStatus(false))
                return;
            //是否直播
            if (!consts.MGCData.isLiveOpen) {
                var obj = {
                    res: 5
                };
                seat_callBack.grapCallBack(obj);
                return;
            }

            var $a = $(e.currentTarget);
            seatListModel.seatIndex = $a.data("seatid");
            seatListModel.owner = $a.data("playerid");
            seatListModel.cost = $a.data("cost");

            //是否自己
            if (consts.MGCData.myPlayerId == seatListModel.owner) {
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '亲，您已经在座位上了！';
                dialog.BtnName = '知道了';
                mgc_dialog.simpleDialog(5, dialog);
                return;
            }

            //是否隐身
            if (consts.MGCData.invisible) {
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.BtnNum = 2;
                dialog.BtnName = '立即抢';
                dialog.BtnName2 = '算了吧';
                dialog.Note = '您现在是隐身登陆，抢座成功后会自动现身。';
                mgc_dialog.simpleDialog(5, dialog, seat_request.grap);
                return;
            }

            seat_request.grap();
        },
        //抢座位
        grap: function() {
            var reqParams = {
                seatIndex: seatListModel.seatIndex,
                owner: seatListModel.owner,
                cost: seatListModel.cost
            };
            callcenter.callbackStr_req("GRAP_SEAT", seat_callBack.grapCallBack, "seat_callBack.grapCallBack", reqParams);
        }
    };

    //请求回调========================================
    var seat_callBack = {
        //守护宝座
        receiveSeatList: function(obj) {
            try {
                console.log('守护宝座' + JSON.stringify(obj));
                seatListModel.set(obj);
            } catch (e) {
                console.log(e);
            }
        },
        grapCallBack: function(obj) {
            switch (parseInt(obj.res)) {
                case 0:
                    var dialog = {};
                    dialog.Title = '提示信息';
                    dialog.Note = '恭喜您成功抢到了守护宝座！';
                    dialog.BtnName = '知道了';
                    break;
                case 4:
                    var dialog = {};
                    dialog.Title = '提示信息';
                    dialog.BtnNum = 2;
                    dialog.BtnName = '立即充值';
                    dialog.BtnName2 = '算了';
                    dialog.url = "http://pay.qq.com/ipay/index.shtml?c=qxwwqp";
                    dialog.Note = '亲，您的炫豆不够了，快去充值吧！~';
                    break;

                case 14:
                    var dialog = {};
                    dialog.Title = '提示信息';
                    dialog.Note = '亲，您已经拥有一个宝座了，不要太贪心哦！';
                    dialog.BtnName = '好吧';
                    break;

                case 5:
                    var dialog = {};
                    dialog.Title = '提示信息';
                    dialog.Note = '只有主播开播时才能抢座哦！';
                    break;

                case 8:
                    var dialog = {};
                    dialog.Title = '提示信息';
                    dialog.Note = '只有主播开播时才能抢座哦！';
                    break;

                case 13:
                    var oneSeat = seatListModel.getSeat(obj.seatIndex);
                    var dialog = {};
                    dialog.Title = '提示信息';
                    dialog.Note = '该座位已经被' + oneSeat.m_nick + '买断了哦！';

                case 15:
                    var dialog = {};
                    dialog.Title = '提示信息';
                    dialog.Note = '世界上最远的距离就是晚了0.001秒，请稍后再试！';
                    break;

                default:
                    var dialog = {};
                    dialog.Title = '提示信息';
                    dialog.Note = '产品经理被妖怪抓走了！请稍后再试！';
                    break;
                mgc_dialog.simpleDialog(5, dialog);
            }
        },
        //座位被抢
        seatLost: function(obj) {
            var dialog = {};
            dialog.Title = '提示信息';
            dialog.BtnNum = 2;
            dialog.BtnName = '立即夺回';
            dialog.BtnName2 = '算了吧';
            dialog.Note = "亲，您被" + obj.nick + "用" + obj.last_cost + "炫豆请下座位，立即用" + obj.cost + "炫豆夺回宝座！";
            var tool=mgc_tool;
            mgc_dialog.simpleDialog(5, dialog, seat_request.grap);
        }
    };
    /**
     * 某个id的玩家是否在座位上
     */
    var isSeat = function(id) {
        var b = false;
        for (var i = 0; i < seatListModel.seats.length; i++) {
            if (seatListModel.seats[i].m_player_id == id) {
                if (seatListModel.seats[i].m_take_cost > 0) {
                    b = true;
                }
            }
        }
        return b;
    };
    control.seat_request = seat_request;
    control.seat_callBack = seat_callBack;
    control.isSeat = isSeat;
    return control;
});
