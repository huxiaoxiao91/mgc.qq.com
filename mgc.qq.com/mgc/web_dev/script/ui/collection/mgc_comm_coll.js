/*
* Author:             77
* Version:            1.0 (2015/11/11)
* Discription:        公共模块集合
*/
define(['backbone', 'jquery', 'mgc_comm_model', 'mgc_consts'], function(backbone, $, comm_model, consts) {
    var common = {};
    /**
     * 登录时的大区列表集合
     * @type {void|*}
     */
    var SelectRoleColl = backbone.Collection.extend({
        model: comm_model.SelectRoleModel,
        mgc_def_chara: function() {
            return this.where({ zoneid: consts.pageSourceConfig.mgc.zoneid });
        },
        mgc_chara: function() {
            return this.where({ is_new_role: true, is_lastRole: false });
        },
        last_chara: function () {
            return this.where({ is_lastRole: true });
        },
        old_charas: function() {
            return this.where({ is_new_role: false, channel: 0, is_lastRole: false });
        },
        old_charas_two: function () {
            return this.where({ is_new_role: false, channel: 4, is_lastRole: false });
        },
        has_mutiple_pages: function(count_per_page) {
            return Math.floor(this.old_charas().length / count_per_page);
        },
        has_mutiple_pages_two: function (count_per_page_two) {
            return Math.floor(this.old_charas_two().length / count_per_page_two);
        },
        has_mgc_chara: function() {
            if (this.where({ is_new_role: true }).length) {
                return true;
            }
            else {
                return false;
            }
        },
        has_lastRole_chara: function () {
            if (this.where({ is_lastRole: true }).length) {
                return true;
            }
            else {
                return false;
            }
        },
        reset_zone_list: function (old_role_zone_list, mgc_zone, old_two_role_zone_list, lastAccount) {
            
            if (old_role_zone_list || mgc_zone || old_two_role_zone_list || lastAccount) {                
                var list = [];
                var lastAccountArr = [];                
           
                for (var i = 0; i < mgc_zone.length; i++) {
                    var zone_model = new comm_model.SelectRoleModel();
                    zone_model.set_data(mgc_zone[i].zoneid, mgc_zone[i].zonename, mgc_zone[i].channel, true, false, mgc_zone[i].is_false);
                    list.push(zone_model);
                }
                for (var i = 0; i < old_role_zone_list.length; i++) {
                    var zone_model = new comm_model.SelectRoleModel();
                    zone_model.set_data(old_role_zone_list[i].zoneid, old_role_zone_list[i].zonename, old_role_zone_list[i].channel, false, false);
                    list.push(zone_model);
                }
                for (var i = 0; i < old_two_role_zone_list.length; i++) {
                    var zone_model = new comm_model.SelectRoleModel();
                    zone_model.set_data(old_two_role_zone_list[i].zoneid, old_two_role_zone_list[i].zonename, old_two_role_zone_list[i].channel, false, false);
                    list.push(zone_model);
                }
                if (lastAccount != null) {
                    lastAccountArr.push(lastAccount);

                    for (var i = 0; i < lastAccountArr.length; i++) {
                        var zone_model = new comm_model.SelectRoleModel();
                        zone_model.set_data(lastAccountArr[i].zoneid, lastAccountArr[i].zonename, lastAccountArr[i].channel, false, true);
                        list.push(zone_model);
                    }
                }
                console.log("reset_zone_list");
                this.reset(list);
            }
            else {
                this.reset();
            }
        }
    });
    common.sel_role_collection = SelectRoleColl;
    common.getCollSelRole = new SelectRoleColl();
    /*
    * 顶条登录组件-玩家信息-集合
    * @type {void|*}
    */
    var PlayerInfoColl = backbone.Collection.extend({
        model: comm_model.PlayerInfoModel,
        initialize: function(models) {
            if (models) {
                this.reset(models);
            }
        },
        get_followinfo_vec: function() {
            return this.get("followinfo_vec");
        },
        set_viplevel_name: function(_viplevel) {
            this.set({ vipLevelname: consts.vipLevelTab[_viplevel] });
        },
        reset_playerinfo: function(_playerinfo) {
            _playerinfo.vipLevelname = consts.vipLevelTab[_playerinfo.vip_level];
            this.reset(_playerinfo);
        },
        has_followinfo_vec: function() {
            if (this.get_followinfo_vec() != null && this.get_followinfo_vec().length > 0) {
                return true;
            } else {
                return false;
            }
        }
    });
    common.player_info_coll = PlayerInfoColl;
    common.getPlayerInfoColl = new PlayerInfoColl();
    /*
    * banner-集合
    * @type {void|*}
    */
    var BannerColl = backbone.Collection.extend({
        model: comm_model.BannerModel,
        initialize: function(models) {
            if (models) {
                this.reset(models);
            }
        }
    });
    common.BannerColl = BannerColl;
    /*
    * 奖励-集合
    * @type {void|*}
    */
    common.RewardColl = backbone.Collection.extend({
        model: comm_model.RewardModel,
        initialize: function(models) {
            if (models) {
                this.reset(models);
            }
        },
        reset_reward_list: function(data) {
            if (data && data.length > 0) {
                var list = [];
                for (var i = 0; i < data.length; i++) {
                    data[i].num = i + 1;
                    data[i].id = i + 1;
                    //data[i].id = data[i].id == 0 ? i + 1 : data[i].id;
                    this.fill_rewardinfo(data[i]);
                    var reward_model = new comm_model.RewardModel();
                    reward_model.set_data(data[i]);
                    list.push(reward_model);
                }
                this.reset(list);
            }
            else {
                this.reset();
            }
        },
        fill_rewardinfo: function(o) {
            var url = (o.channel == 0 || o.channel == 3 || o.channel == 4) ? o.url : (o.url.indexOf("ossweb-img.qq.com") >= 0 ? o.url : ("http://ossweb-img.qq.com/images/mgc/css_img" + o.url));
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
    common.getRewardColl = new common.RewardColl();
    if (!window.mgc) {
        window.mgc = {};
    }
    window.mgc.comm_coll = common;
    return common;
});