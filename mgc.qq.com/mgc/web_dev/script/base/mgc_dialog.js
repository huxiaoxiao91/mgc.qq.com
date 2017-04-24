/**
 * @Description:   梦工厂web-基础库-对话框
 *
 * @author         Xu XiaoJing
 * @version        V1.0
 * @Date           2015/12/09
 * @Company        horizon3d
 */
define(['mgc_popmanager'], function(mgc_popmanager) {
    var dialog = {};
    //layer层级管理器的maintype,subtype这里都是1
    dialog.simpleDialog = function(layer, DialogObj, _callback) {
        if (DialogObj.Title) {
            $('#TitleP').html(DialogObj.Title);
        };
        if (DialogObj.Note) {
            $('#NoteP').html(DialogObj.Note);
        };

        $('#CancelBtn').html("取消").hide();
        if (DialogObj.BtnName) {
            $('#ConfirmBtn').html(DialogObj.BtnName);
        } else {
            $('#ConfirmBtn').html("确定");
        };
        mgc_popmanager.layerControlShow($("#CommonDialog"), layer, 1);
        $("#CommonDialog").centerDisp();
        $('#ConfirmBtn,#CloseBtn,#CancelBtn').attr("href", "javascript:;");
        if (DialogObj.BtnNum > 1) {
            if (DialogObj.BtnName2) {
                $('#CancelBtn').html(DialogObj.BtnName2);
            } else {
                $('#CancelBtn').html("取消");
            }
            $('#CancelBtn').show();
            //避免弹窗中取消按钮显示错误
            $("#CancelBtn").css("display", "inline-block");
            $('#ConfirmBtn').unbind('click').click(function() {
                if (typeof _callback == "function") {
                    _callback();
                }
                mgc_popmanager.layerControlHide($("#CommonDialog"), layer, 1);
                $('#ConfirmBtn').unbind('click');
            });

            $('#CancelBtn,#CloseBtn').unbind('click').click(function() {
                mgc_popmanager.layerControlHide($("#CommonDialog"), layer, 1);
                $('#ConfirmBtn').unbind('click');
            });
        } else {
            $('#ConfirmBtn,#CloseBtn').unbind('click').click(function() {
                if (typeof _callback == "function") {
                    _callback();
                }
                mgc_popmanager.layerControlHide($("#CommonDialog"), layer, 1);
                $('#ConfirmBtn,#CloseBtn').unbind('click');
            });
        }
    };
    window.alert = function(Str) {
        dialog.simpleDialog(5, {
            Title: "提示",
            Note: Str
        });
    };
    return dialog;
});
