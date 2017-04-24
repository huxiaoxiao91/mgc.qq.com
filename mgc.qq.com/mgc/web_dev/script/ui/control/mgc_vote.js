/**
 * @Description:   梦工厂web-控制-投票
 *
 * @author         Xu XiaoJing
 * @version        V1.0
 * @Date           2015/12/12
 * @Company        horizon3d
 */
define(['mgc_callcenter', 'mgc_vote_view', 'mgc_vote_model', 'mgc_tool', 'mgc_consts', 'mgc_popmanager', 'mgc_account', 'mgc_dialog'], function(callcenter, mgc_seat_view, mgc_seat_model, tool, consts, mgc_popmanager, mgc_account, mgc_dialog) {
    var control = {};
    var voteModel = new mgc_vote_model.voteModel();
    var voteView = new mgc_vote_view.lcView({
        model: voteModel
    });

    //发送请求========================================
    var vote_request = {

    };

    //请求回调========================================
    var vote_callBack = {

    };
    return control;
});
