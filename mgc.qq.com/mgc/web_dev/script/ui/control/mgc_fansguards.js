/**
 * @Description:   梦工厂web-控制-粉丝和守护
 *
 * @author         Xu XiaoJing
 * @version        V1.0
 * @Date           2015/12/07
 * @Company        horizon3d
 */
define(['mgc_callcenter', 'mgc_fansguards_view', 'mgc_fansguards_model', 'mgc_tool', 'mgc_consts', 'mgc_popmanager', 'mgc_account', 'mgc_dialog'], function(callcenter, mgc_seat_view, mgc_seat_model, tool, consts, mgc_popmanager, mgc_account, mgc_dialog) {
    var control = {};
    $(".sl_rank").html($("#ranktemp").html());
    $("#ranktemp").children().remove();
    var fgModel = new mgc_fansguards_model.fgModel();
    //工会小窝
    var lcView = new mgc_fansguards_view.lcView({
        model: fgModel
    });
    //演唱会
    var showView = new mgc_fansguards_view.showView({
        model: fgModel
    });
    //监听下发========================================
    //粉丝和守护28
    callcenter.addRespListener(callcenter.OP_TYPE.RECEIVE_FANS_GUARDS, function(resp, params) {
        fansguards_callBack.getFans(resp);
    });


    //发送请求========================================
    var fansguards_request = {
        
    };

    //请求回调========================================
    var fansguards_callBack = {
        
        
    };
    
    control.seat_request = seat_request;
    control.seat_callBack = seat_callBack;
    control.isSeat = isSeat;
    return control;
});
