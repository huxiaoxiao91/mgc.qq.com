/*
 * Author:             77
 * Version:            1.0 (2015/11/11)
 * Discription:        room模块模型
 */
define(['backbone', 'jquery', 'mgc_tool', 'mgc_consts'], function(backbone, $, mgc_tool, mgc_consts) {
    var room_model = {};
    room_model.vipListModel = backbone.Model.extend({
    	initialize: function() {
    		this.listenTo(this, 'change', this.initVipInfo);
    	},
        initVipInfo: function() {
            var obj = this.attributes;
            var _vipInfo = obj.data;
            if (obj.data) {
                var _len = obj.data.length;
                var _max = 6;
                $.each(_vipInfo, function(k, v) {
                    var _tmp = 8 - k;
                    v.liClass = "vipShowTips";
                    v.vipIclass = '';
                    v.num = _tmp;
                    if (v.portraitUrl == '') {
                        var headImgPath = mgc_consts.filePath.HEAD_IMG_PATH;
                        if (v.male) {
                            v.portraitUrl = headImgPath + "default_male.png?v=3_8_8_2016_15_4_final_3";
                        } else {
                            v.portraitUrl = headImgPath + "default_female.png?v=3_8_8_2016_15_4_final_3";
                        }
                    }
                    v.vipP = 'sv_' + v.viplevel + '_c';
                    v.vipI = 'sv_' + v.viplevel;
                    v.zoneName = mgc_tool.mZone(v.zoneName);
                });
                if (_len < _max) {
                    for (var i = _len; i < _max; i++) {
                        var _tempObj = {};
                        var _tmp = 8 - i;
                        _tempObj.liClass = "z" + _tmp;
                        _tempObj.portraitUrl = "";
                        _tempObj.playerName = '';
                        _tempObj.vipIclass = 'cursor: auto';
                        _tempObj.nickColor = ';cursor: auto';
                        _tempObj.vipP = 'sv_0_c';
                        _tempObj.vipI = 'sv_0';
                        _vipInfo.push(_tempObj);
                    }
                }
                this._vipInfo = _vipInfo;
            }

        },
        getVipInfoList: function() {
            return this._vipInfo;
        }
    });
    return room_model;
});
