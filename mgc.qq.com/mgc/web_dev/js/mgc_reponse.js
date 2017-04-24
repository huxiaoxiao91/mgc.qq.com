/**
 **梦工厂首页整合
 **/
var MGCReponse = {

    //响应请求的处理方法
    doReponse : function(repStr) {

        //获得op_type及category
        var _opType = parseInt(repStr.op_type), _cateId = repStr.category;
        if (_opType == -2) {
            //连接大区成功后，把返回的信息写到cookie中
            MGC_Comm.commonCheckLogin(function () {
                MGC_Comm.commonGetUin(function (_uin) {
                    if (repStr.res == 0) {
                        $m.cookie("mgc_ip_" + _uin, repStr.ip);
                        $m.cookie("mgc_port_" + _uin, repStr.port);
                        $m.cookie("mgc_zone_" + _uin, repStr.zoneid);
                    } else if (repStr.res == 2) {
                        //需要清空cookie
                        $m.cookie("mgc_ip_" + _uin, null);
                        $m.cookie("mgc_port_" + _uin, null);
                        $m.cookie("mgc_zone_" + _uin, null);
                    } else {
                        //失败 @todo
                    }
                });
            });
        }
    }
};/*  |xGv00|3e24cba7501c2472745625add76fcdb6 */
