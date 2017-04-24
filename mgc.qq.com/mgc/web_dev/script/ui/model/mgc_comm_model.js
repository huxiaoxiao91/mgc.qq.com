/*
* Author:             77
* Version:            1.0 (2015/11/11)
* Discription:        公共模块模型
*/
define(['backbone', 'jquery', 'mgc_consts'], function(backbone, $, consts) {
    var common = {};
    /**
     * 登录时的角色大区模型
     * @type {void|*}
     */
    common.SelectRoleModel = backbone.Model.extend({
        defaults: function() {
            return {
                zoneid: 0,          //角色id
                zonename: '',       //角色name
                channel: 0,         //渠道
                is_new_role: false, //是否新角色
                is_false: false     //是否为伪造角色(针对888大区开放注册添加)
            }
        },
        set_data: function(zoneid, zonename, channel, is_new_role,is_lastRole, is_false) {
            this.set({ zoneid: zoneid, zonename: zonename, channel: channel, is_new_role: is_new_role, is_lastRole: is_lastRole,is_false: is_false  });
        },
        get_zone_id: function() {
            return this.get("zoneid");
        },
        get_zone_name: function() {
            return this.get("zonename");
        },
        get_channel: function() {
            return this.get("channel");
        },
        is_new_role: function() {
            return this.get("is_new_role");
        },
        is_lastRole: function () {
            return this.get("is_lastRole");
        },
        is_false: function() {
            return this.get("is_false");
        }
    });
    common.getSelectRoleModel = new common.SelectRoleModel();
    /**
     * 创建角色模型
     * @type {void|*}
     */
    common.CreateRoleModel = backbone.Model.extend({
        defaults: function() {
            return {
                nick: '默认昵称',
                gender: 0,
                occupied_names: []
            };
        },
        get_nick: function() {
            return this.get("nick");
        },
        set_nick: function(_nick) {
            this.set({ nick: _nick });
        },
        get_gender: function() {
            return this.get("gender");
        },
        set_gender: function(_gender) {
            this.set({ gender: _gender });
        },
        set_occupied: function(nick) {
            var names = this.get("occupied_names");
            names.push(nick);
            this.set({ occupied_names: names });
        },
        is_occupied: function(nick) {
            var names = this.get("occupied_names");
            return (names.indexOf(nick) != -1)
        },
        get_default_infos: function() {
            //获取QQ昵称和性别 Todo
            this.set_nick("QQ默认昵称");
            this.set_gender(0);
        },
        get_random_name: function() {
            //从服务器获取随机姓名 Todo
            this.set_nick("随机名称");
        }
    });
    common.getCreateRoleModel = new common.CreateRoleModel();
    /*
    * 顶条登录组件模型
    * @type {void|*}
    */
    common.LoginBarModel = backbone.Model.extend({
        defaults: function() {
            return {
                ctrl_login_status: null
            }
        },
        toggle: function(_status) {
            console.log("登录态：LoginBarModel : toggle ：" + _status);
            this.set({ ctrl_login_status: _status });
        }
    });
    common.getLoginBarModel = new common.LoginBarModel();
    /*
    * 顶条登录组件-玩家信息-模型
    * @type {void|*}
    */
    common.PlayerInfoModel = backbone.Model.extend({
        defaults: function() {
            return {
                playerinfo: {}
            }
        },
        set_data: function(_playerinfo) {
            this.set({ playerinfo: _playerinfo });
        },
        reset_playerinfo: function(_playerinfo) {
            _playerinfo.vipLevelname = consts.vipLevelTab[_playerinfo.vip_level];
            this.set_data(_playerinfo);
        }
    });
    common.getPlayerInfoModel = new common.PlayerInfoModel();
    /*
    * banner-模型
    * @type {void|*}
    */
    common.BannerModel = backbone.Model.extend({
        defaults: function() {
            return {
                sAdId: 0,           //id
                sAdUrl: "",         //广告外链
                sImageUrl: ""       //广告图
            }
        }
    });
    common.getBannerModel = new common.BannerModel();
    /*
    * 奖励-模型
    * @type {void|*}
    */
    common.RewardModel = backbone.Model.extend({
        defaults: function() {
            return {
                num: 0,
                id: 0,
                borderFlashShow: "",
                bgcolor1: "",
                isTrue: true,
                gameMark: false,
                url: "",
                name: "",
                tips: "",
                isSign: "",
                doubleIcon: "",
                isDouble: "",
                bgcolor2: "",
                count_desc: "",
                errorMsg: ""
            }
        },
        get_name: function() {
            return this.get("name");
        },
        get_tips: function() {
            return this.get("tips");
        },
        set_data: function(data) {
            this.set(data);
        }
    });
    common.getRewardModel = new common.RewardModel();

    if (!window.mgc) {
        window.mgc = {};
    }
    window.mgc.comm_model = common;
    return common;
});