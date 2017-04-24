/**
 * @Description:   梦工厂web-模型-守护宝座
 *
 * @author         Xu XiaoJing
 * @version        V1.0
 * @Date           2015/12/04
 * @Company        horizon3d
 */
define(['backbone', 'mgc_tool', 'mgc_consts'], function(backbone, mgc_tool, mgc_consts) {
    var seat_model = {};
    seat_model.seatListModel = backbone.Model.extend({
        initialize: function() {
            this.listenTo(this, 'change', this.initSeatList);
        },
        initSeatList: function() {
            var obj = this.attributes;
            var seats = obj.seats;
            if (seats) {
                for (var i = 0; i < obj.seats.length; i++) {
                    var seat = obj.seats[i];
                    //没有头像的玩家用默认头像
                    if (seat.m_pic_url == "") {
                        if (seat.m_gender == 0) {
                            seat.m_pic_url = "http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_female.png?v=3_8_8_2016_15_4_final_3";
                        } else {
                            seat.m_pic_url = "http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_male.png?v=3_8_8_2016_15_4_final_3";
                        }
                    }
                    //大区
                    seat.m_zone = mgc_tool.mZone(seat.m_zone);
                    //守护名称
                    seat.guardName = mgc_consts.guardLevelTab[seat.m_guard_level];
                    //是否可抢 根据当前座位的花销判断宝座的状态：>0 可抢、<0 不可抢
                    if (seat.m_take_cost > 0) {
                        seat.canseat = true;
                    }
                    //空座位
                    if (seat.m_player_id == 0) {
                        seat.canseat = true;
                        seat.m_pic_url = "http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_head_null.png?v=3_8_8_2016_15_4_final_3";
                    }

                }
                this.seatList = seats;
            }

        },
        //根据座位id获取某个宝座的数据
        getSeat: function(id) {
            var seatList = this.getSeatList();
            var obj;
            for (var i = 0; i < seatList.length; i++) {
                if (seatList[i].m_seat_id == id) {
                    obj = seatList[i];
                }
            }
            return obj;
        },
        getSeatList: function() {
            return this.seatList;
        }
    });
    return seat_model;
});
