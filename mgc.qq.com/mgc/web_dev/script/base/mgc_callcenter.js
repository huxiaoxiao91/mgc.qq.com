/**
 * Created by user on 2015/9/28.
 */
requirejs.config({
    shim: {
        login_manager: {
            deps: [],
            exports: 'LoginManager'
        },
        eas: {
            exports: 'eas'
        },
        tgadshow: {
            exports: 'tgadshow'
        },
        mgc_ad: {
            deps: [],
            exports: 'mgc_ad'
        }
    },
    paths: {
        login_manager: 'http://ossweb-img.qq.com/images/js/login/loginmanagerv3',
        eas: 'http://ossweb-img.qq.com/images/js/eas/eas',
        tgadshow: 'http://ossweb-img.qq.com/images/js/comm/tgadshow.min',
        mgc_ad: 'http://mgc.qq.com/upload/x5/x5mgc/ad'
    }
});
define(['mgc_network', 'mgc_account', 'mgc_consts', 'mgc_tool'], function(network, account, consts, tools) {
    console.log("body mgc_callcenter.js load");
    var callcenter = {};
    //普通消息回调表
    var msg_callback_map = {};
    //登录消息回调
    var login_callback = null;
    //底层初始化完成状态
    var network_inited = false;
    //上层监听初始化完成的回调
    var init_listeners = [];
    /**
     * 没有被监听的广播消息分发
     * @param resp      消息
     * @param params    附加参数
     */
    var broadcast_callback = function(resp, params) {
        console.log("broadcast_callback");
        triggerRespListener(resp.op_type, resp, params);
        resp = null;
        params = null;
    };
    var login_change_callback = function() {
        alert("登录状态改变");
    };
    /**
     * 初始化， 加载完成则初始化完成。并通知所有监听者初始化完成
     */
    (function() {
        console.log("load listen");
        network.listenToBroadcastMsg(broadcast_callback);
        network.listenToLoginChanged(login_change_callback);
        network.FlashInit();
    })();
    /**
     * 外部监听callcenter的初始化完成状况，如果监听时已经初始化完成则立即回调。
     * @param callback
     */
    callcenter.listenToInited = function(callback) {
        if (network_inited) {
            callback();
        }
        else {
            init_listeners.push(callback);
        }
    };
    /**
     * 增加消息监听
     * @param resp_id   请求的op_type值
     * @param callback  回调函数
     */
    callcenter.addRespListener = function(resp_id, callback) {
        var _callback = msg_callback_map[resp_id];
        msg_callback_map[resp_id] = !_callback ? callback : function(resp, params) { _callback(resp, params), callback(resp, params); };
    };
    /**
     * 去掉指定消息的监听
     * @param resp_id   请求的op_type值
     */
    callcenter.removeRespListener = function(resp_id) {
        delete msg_callback_map[resp_id];
    };
    /**
     * 触发指定的消息回调
     * @param resp_id   请求的op_type值
     * @param respObj   包含消息.resp和附加参数.param
     */
    var triggerRespListener = function(resp_id, resp, params) {
        if (resp_id == OP_TYPE.INIT_FLASH) {
            network.isFlashInited();
            network_inited = true;
            console.log("network_inited -3");
            for (var i = 0, a; a = init_listeners[i++];) {
                a();
            }
            init_listeners = [];
        } else {
            var callback = msg_callback_map[resp_id];
            if (callback)
                callback(resp, params);
            callback = null;
        }
        resp = null;
        params = null;
    };
    /**
     * 获得一个新param供sendMsg使用
     * @param callback  填入params 的回调函数
     * @returns {{}}
     */
    var get_new_param_with_callback = function(callback, params) {
        if (!callback) {
            return;
        }
        params || (params = {});
        params.callback_str = callback.toString();
        return params;
    };
    callcenter.get_new_param_with_callback = get_new_param_with_callback;
    /**********REQUEST  START ************/
    /**
     * 消息id
     * @type {{HAS_COOKIE: number}}
     */
    var OP_TYPE = {
        SET_COOKIE: -101,                                   //设置as缓存
        INIT_FINISHED_BOX: -100,                            //惊喜宝箱初始化
        INIT_FLASH: -3,                                     //swf初始化完成
        LOGIN_ZONE: -2,                                     //链接大区
        HAS_COOKIE: -1,                                     //查询as缓存
        VIDEO_ROOM_LIST: 0,                                 //房间列表
        REFRESH_PLAYER: 2,                                  //刷新视频区玩家
        GET_ANCHOR_XINGYAO_RANK: 3,                         //主播榜-星耀榜
        GET_ANCHOR_QINMIDU_RANK: 4,                         //主播榜-亲密度榜
        GET_ANCHOR_JIFEN_RANK: 8,                           //主播榜-积分榜
        GET_FANS_HOUYUAN_RANK: 9,                           //粉丝榜-后援团榜
        ENTER_ROOM: 12,                                     //进房
        OUT_OF_THE_ROOM: 13,                                //退房
        GET_ANCHOR_CARD_RANKLIST_INFO: 14,                  //获取排行榜主播名片信息
        GET_ROLELIST_INFO: 15,                              //获取角色列表
        SEND_GIFT: 19,                                      //送礼消息
        SEND_MSG_CHAT: 24,                                  //聊天区发送消息请求
        GET_PLAYER_VIP_PRICE_INFO: 25,                      //获取VIP价格信息
        RECEIVE_VIP_LIST: 27,                               //下发嘉宾席
        RECEIVE_FANS_GUARDS: 28,                            //下发粉丝守护
        RefreshAnchorOpType: 29,                            //刷新主播面板
        RECEIVE_REFRESH_ROOM: 30,                           //刷新房间信息
        RECEIVE_HOT_VALUE: 34,                              //热度值
        RECEIVE_ROOM_STATUS: 35,                            //下发房间状态
        GIFT_INFO_BROADCAST: 36,                            //礼物消息广播
        FREE_GIFT_UPDATE: 38,                               // 免费礼物更新
        LOTS_OF_GIFTS: 39,                                  // 送礼超过一定数量全部房间滚动提醒
        ROOM_BROADCAST_ALL_ROOM: 40,                         //一定级别的贵族进房间提醒
        FORBIDDEN_TYPE: 44,                                 //禁言和取消禁言
        RECEIVE_CHAT_INFO: 46,                              //下发聊天消息
        VIDEO_PLAY: 52,                                     //视频  开播
        VIDEO_STOP: 53,                                     //视频  关播
        GET_GROUP_INFO: 54,                                 //加载我的后援团
        QUIT_GROUP: 57,                                     //退出后援团
        GET_GROUP: 60,                                      //获取后援团列表
        FANS_INVITE: 72,                                    //邀请加入后援团
        UPLOAD_USER_AVATAR: 78,                             //上传用户头像
        EDIT_SIGNATURE: 79,                                 //修改个人签名
        SIGN_GROUP: 81,                                     //后援团签到
        OPEN_VIP: 105,                                      //开通VIP
        RENEWAL_VIP: 106,                                   //续费vip
        GET_FANS_GUIZU_RANK: 109,                           //粉丝榜-贵族榜
        CANCEL_FOLLOW_ANCHOR: 117,                          //取消关注主播
        CREATE_ROLE: 119,                                   //创建角色
        PUBLISH_ANCHOR_TASK: 121,                            //发布主播任务，玩家在房间的回调
        ACCEPT_ANCHOR_TASK: 122,                             //接受主播任务
        GIVEUP_ANCHOR_TASK: 123,                             //放弃主播任务
        GET_TASK_INFO: 124,                                  //查询主播任务
        CANCEL_TASK_INFO: 125,                               //取消主播任务
        GET_PLAYER_ZONE_LIST: 128,                          //拉取角色列表
        GET_MEMBER_INFO: 129,                               //成员操作列表
        GET_BALANCE: 130,                                   //查询余额
        CHECK_DUPNICK: 134,                                 //检查昵称重名
        GET_PRIVATE_MSG_CHAT_LIST: 136,                     //获取最近私聊列表
        SET_PLAYER_STATUS: 140,                             //设置在线隐身状态
        GET_SUPRISE_BOX: 142,                               //获得了宝箱
        COMPLETE_ANCHOR_TASK: 143,                           //完成主播任务
        GET_PLAYER_INFO: 147,                               //获取玩家信息
        IS_IGNORE: 145,                                     //屏蔽
        GET_FANS_DENGJI_RANK: 148,                          //粉丝榜-等级榜
        GET_FANS_CAIFU_RANK: 149,                           //粉丝榜-财富榜
        GET_DAILY_WAGE: 150,                                //领取每日工资
        GET_ACT_CENTER: 151,                                //进入活动中心
        GET_ACT_REWARDS: 152,                               //领取活动奖励
        GET_DONE_ACT: 153,                                  //获取未领取任务数量
        GET_VIDEO_MONEY: 154,                               //查询梦幻币余额
        EDIT_USERNICK: 156,                                 //修改用户昵称
        FORBID_CHAT: 170,                                   //屏蔽聊天（除主播和管理员）
        LOGOUT: 171,                                        //登出
        CHECK_ROOM_STATUS: 172,                             //查询是否可以进入房间
        GET_PLAYER_VIP_INFO: 176,                           //获取玩家VIP信息
        CLEAR_LOGIN_COOKIE: 179,                            //清除本地登录缓存
        RECV_BALANCE_CHANGE: 182,                           //个人钱数发生改变通知
        GET_DREAM_GIFT: 183,                                //查询梦幻币礼物数量
        GET_GOOD_FRIEND_PAY: 185,                           //好友充值炫豆
        CHECK_IS_FIRST_LOGIN: 189,                          //检查首登
        RECV_LOGIN_FIRST_GIFTS: 190,                        //获取首登礼包
        CHECK_IS_SIGN: 191,                                 //检查是否签到
        GET_SIGN_INFO: 192,                                 //获取签到信息
        RECEIVE_DAILY_REWARD: 193,                          //领取每日签到奖励
        RECEIVE_CUMULATIVE_REWARD: 194,                     //领取累计签到奖励
        RECV_GIFTS_CONFIG: 197,                             //演唱会礼物配置下发
        REGIST_GUEST_ACCOUNT: 198,                          //请求游客账号
        VIDEO_SPLIT_STATUS: 200,                            //视频  分屏状态
        VIDEO_SPLIT_PLAY: 201,                              //视频  分屏开启
        VIDEO_SPLIT_STOP: 202,                              //视频  分屏关闭
        HAS_GUEST_ACCOUNT: 204,                             //查询缓存的游客账号
        RECEIVE_GROUP_AUTH: 205,                            //是否有后援团以及权限，当前直播的主播是否是后援团所支持的主播
        QUERY_SUPRISE_REWARDS: 224,                         //查询惊喜奖励
        OPEN_SUPRISE_BOX_RETURN: 225,                       //打开惊喜宝箱返回
        UPDATE_SUPRISE_BOX: 226,                            //更新惊喜宝箱
        GET_SUPRISE_REWARDS: 227,                           //获得惊喜宝箱奖励
        GRAP_SEAT: 230,                                     //抢座
        LOST_SEAT: 231,                                     //座位被抢通知
        RECEIVE_SEAT_LIST: 232,                             //下发守护宝座
        CUSTOM_TAB_LIST: 233,                               //获取自定义页签
        GET_RAND_NICK: 234,                                 //获取随机昵称
        VIDEO_RANK_CHANGE_BROADCAST_ALL_PLAYER: 235,        //榜单变化时的走马灯消息
        RECV_PLAYER_GUARD_LEVEL: 236,                       //玩家守护等级
        GET_ROOMPIC_URL: 237,                               //非直播阶段，查看房间的默认图片
        UPDATA_GUARD_LEVEL: 239,                            //守护升级
        RedPacketOpType: 251,                                //服务器下发红包
        GrabRedPacketOpType: 252,                           //抢红包
        ShowRedPacketOpType: 253,                           //红包信息
        GET_ANCHOR_DENGJI_RANK: 255,                        //主播榜-等级榜
        BATCH_VIDEO_TREASURE_BOX_REWARD_WEB: 257,           //主播下线时 主动开启宝箱
        CHANGE_LOGIN: 258,                                  //change login
        GET_WEEK_GIFT_RANK: 270,                            //周星礼物榜
        GET_FIRST_LIST_RANK: 271,                           //周星冠军榜
        RECV_STAR_GIFTS: 274,                               //刷新周星礼物列表/冠名接口消息ID
        GRAB_DREAMBOX: 282,                                 //抢梦幻宝箱
        GET_DREAMBOX_RECORD: 283,                           //查看抢梦幻宝箱记录
        PUSH_DREAMBOX: 284,                                 //发布梦幻宝箱通知
        PUSH_DREAMBOX_COUNT: 285,                           //刷新梦幻宝箱数量
        PUSH_DREAMBOX_CLEAR: 288,                           //通知清空梦幻宝箱
        GET_TASK_CENTER_GUIDE: 289,                         //弹出任务中心提示引导tips
        GET_CHANGE_NAME: 291,                               //首登改名
        IGNORE_FREE_GIFT_INFO: 292,                         //忽略免费礼物消息  
        RENEWAL_ACCOUNT_LOGIN: 293,                         //账号续期    
        DRAW_GET: 295,                                      //打开抽奖界面
        DRAW_CLOSE: 296,                                    //关闭抽奖界面
        DRAW_BEGIN: 297,                                    //抽奖
        DRAW_FREE: 294,                                     //可以免费抽的主动下发
        Broadcast_All_Room_Rocket_Gift: 286,                //火箭礼物飞屏
        DRAW_RECORD: 298,                                   //中奖信息的主动下发
        DRAW_REFRESH: 299,                                  //奖品信息更新的主动下发
        GET_PUNCH_CARD_INFO: 300,                           //获取打卡界面信息
        PUNCH_CARD: 301,                                    //打卡 、 补打卡
        UNLOCK_TASK_INFO: 303,                              //下发解锁皮肤任务进度信息
        UNLOCK_TASK_FINISH: 304,                            //下发解锁皮肤任务完成
        ROOM_TASK_INFO: 305,                                //房间皮肤升级任务信息
        ROOM_TASK_INFO_MAX: 306,                            //房间皮肤满级任务信息
        INFORM_ROOM_SKIN_UP: 308,                           //通知房间皮肤升级
        RECV_TASK_REWARD_SKIN_UP: 309,                      //皮肤满级后每日任务奖励消息
        RECV_TOP_MEILI: 310,                                //魅力榜第一通知
        GET_ANCHOR_MEILI_RANK: 311,                         //主播榜-魅力榜
        UNLOCK_NEW_SKIN: 312,                               //解锁皮肤成功信息
        GET_SYSTEM_TIME: 314,                               //同步服务器时间   
        GET_AD: 315,                                        //贴边广告      
        NOTICE_OPEN_VIP: 317,                               //开通新贵族飞屏消息
        POPUP_TASK_POP: 319,                                //任务气泡弹出完毕通知
        REFRESH_ANCHOR_PKRank: 320,                         //PK  主播PK总榜
        REFRESH_PLAYER_PKRank: 321,                         //PK  玩家贡献榜
        PK_REFRESH_ROCKET_BUFFER: 322,                      //PK  刷新火箭buffer
        PK_REFRESH_PROGRESS_INFO: 323,                      //PK  刷新PK进度
        PK_REFRESH_GAME_INFO: 324,                          //PK  刷新比赛信息
        PK_REFRESH_VALUE: 325,                              //PK  刷新PK值
        PK_REFRESH_GIFTS: 326,                              //PK  刷新PK礼物、PK角标
        COMMON_ACTIVITY_INFO_BEGIN: 327,                    //向客户端发送通用活动开始信息
        COMMON_ACTIVITY_INFO_END: 328,                      //向客户端发送通用活动结束信息
        COMMON_ACTIVITY_INFO_REFRESH: 329,                  //向客户端发送通用活动配置更新信息
        COMMON_ACTIVITY_REFRESH_DATA: 330,                  //向客户端发送通用活动地板数据信息（包括主播排名，主播收到的礼物数，底板等级）
        COMMON_ACTIVITY_PLAYER_RANK: 331,                   //向客户端发送的玩家贡献榜信息
        NOTIFY_ALL_USER_ADMIN: 332,                          //通知当前房间中所有移动管理员的pstid信息
        PUSH_ROOM_BAN_NOTICE: 333,                           // 主播禁言所有人，禁止公众聊天
        //密令新增消息
        NOTIFY_SECRET_HEAT_BOX_INFO: 334,                   //下发宝箱开启的差值,活动标题和内容
        SEND_FINISHED_EDUCATION: 335,                       //当客户端完成教学任务时，发送对应的教学任务的flag,给服务器。
        NOTIFY_ANCHOR_SECRET_CODE: 336,                      //下发主播设置（默认）的密令
        PLAYER_DRAW_SECRET_HEAT_BOX_REWARD: 337,             //玩家点击密令宝箱发消息给服务器
        NOTIFY_PLAYER_SECRET_HEAT_BOX: 338,                  //通知玩家密令宝箱倒计时变化
        NOTIFY_LAST_HIT_PLAYER_REWARD: 339,                  //通知补刀王玩家获得的奖励
        WHISTLE_LAST_HIT_PLAYER: 340,                        // 广播补刀王飞屏
        CONCERT_PLAYBACK_ROOM_GET_ROOMLIST: 341,             // 获取演唱会回放房间列表事件
        START_CONCERT_PLAYBACK: 342,                          // 开始观看演唱会回放事件
        RECEIVE_WEEKSTAR_NOTIFY_SUCC: 343,                   //周星赛结算和获奖提示确认
        GET_WEEKSTAR_URL_CONFIG: 344,                        //周星赛URL配置请求
        RECEIVE_ANCHOR_WEEKSTAR_LEVELUP_NOTIFY:345,          //通知主播周星等级升级
        RECEIVE_ANCHOR_WEEKSTAR_MATCH_SETTLE_NOTIFY: 346,    //通知主播周星积分结算
        GET_WEEKSTAR_RANKLIST: 347                           //获取周星积分榜数据
    };
    callcenter.OP_TYPE = OP_TYPE;
    /**
    * @设置as缓存登录信息
    * @param callback
    */
    callcenter.query_set_cookie = function(qq, zoneid) {
        console.log("callcenter.query_set_cookie");
        var _req = { op_type: OP_TYPE.SET_COOKIE, qq: qq, zoneid: zoneid };
        network.sendMsg(_req);
    };
    /**
    * 登录视频大区
    * @param zoneid    视频大区id
    * @param channel   渠道channel
    * @param ischecklogin 是否检测续期
    * @param callback
    */
    callcenter.query_login_zone = function(zoneid, channel, callback, params) {
        var _req = { op_type: OP_TYPE.LOGIN_ZONE, roomId: mgc.tools.roomid() || 0, qq: account.getUin() || 0, vertify_info: account.getCookie(), zoneid: zoneid || tools.pageSource().zoneid, channel: channel || tools.pageSource().channel, m_appid: tools.pageSource().appid, m_skey: account.getSkey() ? account.getSkey() : "", m_device_type: tools.pageSource().device_type };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /**
    * 游客登陆视频大区
    * @param id        游客id
    * @param ticket    游客凭据
    * @param zoneid    大区
    * @param callback
    */
    callcenter.query_guest_login_zone = function(id, ticket, zoneid, channel, callback, params) {
        var _req = { op_type: OP_TYPE.LOGIN_ZONE, roomId: mgc.tools.roomid() || 0, qq: id, vertify_info: ticket, zoneid: zoneid, channel: channel, m_appid: tools.pageSource().appid, m_skey: account.getSkey() ? account.getSkey() : "", m_device_type: tools.pageSource().device_type };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /*
    * 登录续期
    * @param appid 
    * @param key  
    */
    callcenter.renewal_account_login = function(callback, params) {
        var _req = { op_type: OP_TYPE.RENEWAL_ACCOUNT_LOGIN, appid: tools.pageSource().appid, key: account.getSkey() ? account.getSkey() : "" };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /**
    *查询as缓存登录信息
    * @param callback
    */
    callcenter.query_has_cookie = function(callback, params) {
        console.log("callcenter.query_has_cookie");
        var _req = { op_type: OP_TYPE.HAS_COOKIE, qq: account.getUin() || 0, zoonid: account.getCookie("mgc_zoneid") || tools.pageSource().zoneid };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /**
    * 请求各种房间列表
    * @param _category     推荐类型
    * @param _cur_page     当前请求页
    * @param _counts_per_page  每页请求数量
    * @param _tag          自定义标签
    * @param _position     0，首页，1，娱乐表演
    * @param callback      界面回调
    * @param params        附加参数
    */
    callcenter.query_video_room_list = function(_category, _cur_page, _counts_per_page, _tag, _position, _module_type, _source, callback, params) {
        var _req = {
            op_type: OP_TYPE.VIDEO_ROOM_LIST,
            type: 0,         //0表示视频房间，1表示音频房间。目前没有用到音频房间
            zoneid: account.getCookie("mgc_zoneid") || tools.pageSource().zoneid,
            category: _category,
            beginIndex: (_cur_page - 1) * _counts_per_page,
            requestNum: _counts_per_page,
            tag: _tag,
            position: _position,
            module_type:_module_type,
            source: _source
        };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /**
    * 刷新玩家
    * @param callback
    */
    callcenter.refresh_video_client_charinfo = function(callback, params) {
        var _req = { op_type: OP_TYPE.REFRESH_PLAYER };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /**
    * 进房请求
    * @param rooid             房间id
    * @param crowd_into        是否可挤房进入
    * @param source            进房间的类型
    * @param callback
    */
    callcenter.enter_room = function(roomid, crowd_into, source, tag, module_type, page_capacity, room_list_pos, callback, params) {
        var _req = { op_type: OP_TYPE.ENTER_ROOM, roomID: roomid, crowd_into: crowd_into, invisible: false, source: source, tag: tag, module_type:module_type, page_capacity: page_capacity, room_list_pos: room_list_po };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };

    /**
     * 房间状态请求
     * @param callback
     */
    callcenter.request_room_status = function(callback, params) {
        var _req = { op_type: OP_TYPE.RECEIVE_ROOM_STATUS };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };

    /**
    * 创建角色
    * @param nick  昵称
    * @param gender    性别
    * @is_auto_create   是否自动注册
    * @param callback
    */
    callcenter.query_create_role = function(nick, gender, zoneid, nick_pool, nick_record_id, callback, params) {
        var _req = { op_type: OP_TYPE.CREATE_ROLE, nick: nick, gender: gender, zoneid: zoneid, nick_pool: nick_pool, nick_record_id: nick_record_id, is_auto_create: params.is_auto_create };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /**
    * 获取角色大区列表
    * @param callback
    */
    callcenter.query_player_zone_list = function(callback, params) {
        var _req = { op_type: OP_TYPE.GET_PLAYER_ZONE_LIST, roomId: mgc.tools.roomid() || 0, qq: account.getUin() || 0, vertify_info: account.getCookie(), m_appid: tools.pageSource().appid, m_skey: account.getSkey() ? account.getSkey() : "", m_device_type: tools.pageSource().device_type, m_channel: tools.pageSource().channel };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /**
    * 检测昵称重名
    * @param callback
    */
    callcenter.check_dupnick = function(nick, callback, params) {
        var _req = { op_type: OP_TYPE.CHECK_DUPNICK, nick: nick };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /*
    * 设置玩家在线隐身状态
    * @params  status false在线 true隐身
    */
    callcenter.set_player_status = function(status, callback, params) {
        var _req = { op_type: OP_TYPE.SET_PLAYER_STATUS, invisible: status, client: false };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /**
    * 获取角色信息
    * @param reqtype
    * @param callback
    * @param params
    */
    callcenter.query_player_info = function(reqtype, callback, params) {
        var _req = { op_type: OP_TYPE.GET_PLAYER_INFO, reqtype: reqtype };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /**
    * 视频登出
    * @param callback
    */
    callcenter.query_logout = function(callback, params) {
        var _req = { op_type: OP_TYPE.LOGOUT };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /**
    * 检查房间状态
    * @param roomid        房间id
    * @param callback
    */
    callcenter.check_room_status = function(roomid, callback, params) {
        var _req = { op_type: OP_TYPE.CHECK_ROOM_STATUS, roomid: roomid };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /**
    * 页面没有登录态时通知flash清除登录态，保持登录态同步
    * @param callback
    */
    callcenter.query_clear_login_cookie = function(callback, params) {
        var _req = { qq: account.getUin() || 0, op_type: OP_TYPE.CLEAR_LOGIN_COOKIE };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /**
    * 检查是否首登
    */
    callcenter.check_is_first_login = function(callback, real_login, params) {
        var _req = { op_type: OP_TYPE.CHECK_IS_FIRST_LOGIN, real_login: real_login };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /**
    * 领取首登礼包
    */
    callcenter.receive_login_gifts = function(callback, params) {
        var _req = { op_type: OP_TYPE.RECV_LOGIN_FIRST_GIFTS };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /*
    *检查签到状态
    */
    callcenter.check_sign = function(callback, params) {
        var _req = { op_type: OP_TYPE.CHECK_IS_SIGN };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /*
    *获取签到信息
    */
    callcenter.query_sign_info = function(callback, params) {
        var _req = { op_type: OP_TYPE.GET_SIGN_INFO };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /*
    *领取每日签到奖励
    */
    callcenter.receive_daily_reward = function(callback, params) {
        var _req = { op_type: OP_TYPE.RECEIVE_DAILY_REWARD };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /*
    * 领取累计签到奖励 （n:累计天数）
    */
    callcenter.receive_cumulative_reward = function(n, callback, params) {
        var _req = { op_type: OP_TYPE.RECEIVE_CUMULATIVE_REWARD, accday: n };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /**
    * 申请游客账号
    * @param callback
    */
    callcenter.query_get_guest_account = function(callback, params) {
        var _req = { op_type: OP_TYPE.REGIST_GUEST_ACCOUNT };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /**
    * 查询是否有游客账号缓存
    * @param callback
    */
    callcenter.query_has_guest_account = function(callback, params) {
        var _req = { op_type: OP_TYPE.HAS_GUEST_ACCOUNT };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /*
    * 获取玩家的vip信息
    * @param callback
    */
    callcenter.query_player_vip_info = function(callback, params) {
        var _req = { op_type: OP_TYPE.GET_PLAYER_VIP_INFO };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /*
    * 获取vip价格信息
    * @param callback
    */
    callcenter.query_player_vip_price_info = function(callback, params) {
        var _req = { op_type: OP_TYPE.GET_PLAYER_VIP_PRICE_INFO };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /*
    * 开通VIP
    * @param callback
    */
    callcenter.open_vip = function(viplevel, duration, costtype, anchor_id, callback, params) {
        var _req = { op_type: OP_TYPE.OPEN_VIP, vip_level: viplevel, duration: duration, costtype: costtype, anchor_id: anchor_id };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /*
    * 续费VIP
    * @param callback
    */
    callcenter.renewal_vip = function(viplevel, duration, costtype, anchor_id, callback, params) {
        var _req = { op_type: OP_TYPE.RENEWAL_VIP, vip_level: viplevel, duration: duration, costtype: costtype, anchor_id: anchor_id };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /*
    *请求房间列表的自定义tab标签
    * @param _type          tab标签类型 bool
    * @param callback       界面回调
    * @param params         附加参数
    */
    callcenter.query_custom_tab_list = function(_type, callback, params) {
        var _req = { op_type: OP_TYPE.CUSTOM_TAB_LIST, is_home: _type };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /*
    * 随机获取玩家昵称
    * @param last_nick_pool 上一次随机的昵称id
    * @param gender         性别
    * @param callback       界面回调
    * @param params         附加参数
    */
    callcenter.query_rand_nick = function(last_nick_pool, gender, callback, params) {
        var _req = { op_type: OP_TYPE.GET_RAND_NICK, last_nick_pool: last_nick_pool, gender: gender };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /*
    * 获取未完成任务数
    */
    callcenter.query_done_act_count = function(callback, params) {
        var _req = { op_type: OP_TYPE.GET_DONE_ACT };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /*
    *请求主播榜-等级榜
    * @param callback       界面回调
    * @param params         附加参数
    */
    callcenter.query_anchor_dengji_rank = function(callback, params) {
        var _req = { op_type: OP_TYPE.GET_ANCHOR_DENGJI_RANK };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /*
    *请求主播榜-积分榜
    * @param timedimension  时间维度
    * @param callback       界面回调
    * @param params         附加参数
    */
    callcenter.query_anchor_jifen_rank = function(timedimension, callback, params) {
        var _req = { op_type: OP_TYPE.GET_ANCHOR_JIFEN_RANK, timedimension: timedimension };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /*
    *请求主播榜-星耀榜
    * @param timedimension  时间维度
    * @param callback       界面回调
    * @param params         附加参数
    */
    callcenter.query_anchor_xingyao_rank = function(timedimension, callback, params) {
        var _req = { op_type: OP_TYPE.GET_ANCHOR_XINGYAO_RANK, timedimension: timedimension };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /*
    *请求主播榜-亲密度榜
    * @param timedimension  时间维度
    * @param callback       界面回调
    * @param params         附加参数
    */
    callcenter.query_anchor_qinmidu_rank = function(timedimension, callback, params) {
        var _req = { op_type: OP_TYPE.GET_ANCHOR_QINMIDU_RANK, timedimension: timedimension };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /*
    *请求主播榜-魅力榜
    * @param begin          开始索引
    * @param end            结束索引
    * @param timedimension  时间维度
    * @param callback       界面回调
    * @param params         附加参数
    */
    callcenter.query_anchor_meili_rank = function(begin, end, timedimension, callback, params) {
        var _req = { op_type: OP_TYPE.GET_ANCHOR_MEILI_RANK, begin_index: begin, end_index: end, timedimension: timedimension };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /*
    *请求粉丝榜-财富榜
    * @param begin          开始索引
    * @param end            结束索引
    * @param timedimension  时间维度
    * @param callback       界面回调
    * @param params         附加参数
    */
    callcenter.query_fans_caifu_rank = function(begin, end, timedimension, callback, params) {
        var _req = { op_type: OP_TYPE.GET_FANS_CAIFU_RANK, begin_index: begin, end_index: end, timedimension: timedimension };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /*
    *请求粉丝榜-贵族榜
    * @param begin          开始索引
    * @param end            结束索引
    * @param callback       界面回调
    * @param params         附加参数
    */
    callcenter.query_fans_guizu_rank = function(begin, end, callback, params) {
        var _req = { op_type: OP_TYPE.GET_FANS_GUIZU_RANK, begin_index: begin, end_index: end };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /*
    *请求粉丝榜-等级榜
    * @param begin          开始索引
    * @param end            结束索引
    * @param callback       界面回调
    * @param params         附加参数
    */
    callcenter.query_fans_dengji_rank = function(begin, end, callback, params) {
        var _req = { op_type: OP_TYPE.GET_FANS_DENGJI_RANK, begin_index: begin, end_index: end };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /*
    *请求粉丝榜-后援团榜
    * @param callback       界面回调
    * @param params         附加参数
    */
    callcenter.query_fans_houyuan_rank = function(callback, params) {
        var _req = { op_type: OP_TYPE.GET_FANS_HOUYUAN_RANK };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /**
    * 发送普通请求
    */
    callcenter.standard_req = function(optype, callback, reqParams) {
        if (!OP_TYPE[optype]) {
            console.log("No such optype:" + optype);
            throw new Error("No such optype:" + optype);
        }
        var _req = { op_type: OP_TYPE[optype] };
        $.extend(_req, reqParams);
        network.sendMsg(_req, callback, get_new_param_with_callback(callback));
    };

    callcenter.callbackStr_req = function(optype, callback, callbackStr, reqParams) {
        if (!OP_TYPE[optype]) {
            console.log("No such optype:" + optype);
            throw new Error("No such optype:" + optype);
        }
        var _req = { op_type: OP_TYPE[optype] };
        $.extend(_req, reqParams);
        network.sendMsg(_req, callback, get_new_param_with_callback(callbackStr));
    };

    /**
     * 获取后援团信息
     * from_home
     * @param callback
     */
    callcenter.getGroupInfo = function(from_home, callback, params) {
        var _req = {
            op_type: OP_TYPE.GET_GROUP_INFO,
            from_home: true
        };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /**
     * 后援团签到
     * @param callback
     */
    callcenter.signGroup = function(callback, params) {
        var _req = {
            op_type: OP_TYPE.SIGN_GROUP
        };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };

    /**
     * 退出后援团
     * @param callback
     */
    callcenter.quitGroup = function(callback, params) {
        var _req = {
            op_type: OP_TYPE.QUIT_GROUP
        };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };

    /**
     * 获取后援团列表
     * @param page 页数
     * @param name_pattern 关键字
     * @param sort_type 排序
     */
    callcenter.getGroup = function(page, name_pattern, sort_type, callback, params) {
        var _req = {
            op_type: OP_TYPE.GET_GROUP,
            page: page,
            name_pattern: name_pattern,
            sort_type: sort_type
        };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };

    /**
     * 周星礼物榜
     * @param callback
     */
    callcenter.getWeekGiftRank = function(callback, params) {
        var _req = {
            op_type: OP_TYPE.GET_WEEK_GIFT_RANK
        };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };

    /**
     * 周星冠军榜
     * @param callback
     */
    callcenter.getFirstListRank = function(callback, params) {
        var _req = {
            op_type: OP_TYPE.GET_FIRST_LIST_RANK
        };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /**
    * 好友充值请求
    */
    callcenter.check_goodFriendPay = function(callback) {
        var _req = { op_type: OP_TYPE.GET_GOOD_FRIEND_PAY };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback));
    };
    /*
    * 获取房间打卡信息
    */
    callcenter.get_punch_card_info = function(callback, params) {
        var _req = { op_type: OP_TYPE.GET_PUNCH_CARD_INFO };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback));
    }
    /*
    **点击打卡
    * punch_in_id     打卡周期id
    * today_index     今日索引
    * day_index       打卡日期索引
    * retrieve        是否补打卡
    * retrieve_price  补打卡价格
    */
    callcenter.punch_card = function(punch_in_id, today_index, day_index, retrieve, retrieve_price, callback, params) {
        var _req = { op_type: OP_TYPE.PUNCH_CARD, punch_in_id: punch_in_id, today_index: today_index, day_index: day_index, retrieve: retrieve, retrieve_price: retrieve_price };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback));
    }
    /*
    * 获取排行榜主播名片信息
    */
    callcenter.get_anchor_card_ranklist_info = function(anchorID, callback, params) {
        var _req = { op_type: OP_TYPE.GET_ANCHOR_CARD_RANKLIST_INFO, anchorID: anchorID };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /*
    * 获取房间打卡信息
    */
    callcenter.popup_task_pop = function() {
        var _req = { op_type: OP_TYPE.POPUP_TASK_POP };
        network.sendMsg(_req);
    }
    /*
    * 同步服务器时间
    */
    callcenter.get_system_time = function(callback, params) {
        var _req = { op_type: OP_TYPE.GET_SYSTEM_TIME };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /**
     * 聊天区发送消息请求 24
     */
    callcenter.sendChatMsg = function(_MsgChannel,recver_id,_receiverName, _receiverZoneName, MsgChat, callback, params) {
        var _req = { op_type: OP_TYPE.SEND_MSG_CHAT, channelID: _MsgChannel, receiverName: _receiverName, receiverZoneName: _receiverZoneName, msg: MsgChat,recver_id:recver_id };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /**
     * 获取最近私聊列表
     */
    callcenter.getPrivateMsgChatList = function(callback, params) {
        var _req = { op_type: OP_TYPE.GET_PRIVATE_MSG_CHAT_LIST };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /**
     * 获取角色列表信息 15
     */
    callcenter.getRoleListInfo = function(callback, params) {
        var _req = { op_type: OP_TYPE.GET_ROLELIST_INFO, pageIndex: 0 };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /**
     * 忽略免费礼物消息接口 292
     */
    callcenter.ignoreFreeGiftInfo = function(is_ignore, callback, params) {
        var _req = { op_type: OP_TYPE.IGNORE_FREE_GIFT_INFO, is_ignore: is_ignore };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /**
     * 送礼消息 19
     * @params 　gift_id:int　礼物id
     * @params 　gift_cnt:int　礼物数量
     * @params 　anchor_id:int　主播id
     */
    callcenter.sendGift = function(gift_id, gift_cnt, callback, params) {
        var _req = { op_type: OP_TYPE.SEND_GIFT, gift_id: gift_id, gift_cnt: gift_cnt};
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /*
     * 抢宝箱
     */
    callcenter.grab_dreambox = function(box_id, callback, params) {
        var _req = { op_type: OP_TYPE.GRAB_DREAMBOX, box_id: box_id };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /*
    * 查询惊喜宝箱奖励 224
    */
    callcenter.querySurpriseBoxReward = function(callback, params){
        var _req = { op_type: OP_TYPE.QUERY_SUPRISE_REWARDS};
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /*
    * 开启惊喜宝箱 225
    */
    callcenter.openSurpriseBox = function(boxId, activityId, callback, params){
        var _req = { op_type: OP_TYPE.OPEN_SUPRISE_BOX_RETURN, box_id: boxId, activity_id: activityId };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
   
    /*
    * 查询余额
    * @params 　save_num:int　充值数量，大于0时，根据充值数量查询对应的余额，等于0时即为查询当前余额
    * 向客户端发送的玩家贡献榜信息
    */
    callcenter.get_common_activity_player_rank = function(callback, params) {
        var _req = { op_type: OP_TYPE.COMMON_ACTIVITY_PLAYER_RANK };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /*
     * 非直播，查看房间默认图片
     */
    callcenter.get_room_url = function(callback, params) {
        var _req = { op_type: OP_TYPE.GET_ROOMPIC_URL };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };

    /*
     * 未开播推荐位
     */
    callcenter.get_recommend = function(callback, params) {
        console.log("未开播推荐为");
        var _req = { op_type: OP_TYPE.VIDEO_ROOM_LIST, type: 0, category: 12, beginIndex: 0, requestNum: 5, tag: 0, position: 0,module_type:1};
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };

    /*
     * 查询梦幻宝箱记录
     */
    callcenter.grab_getdreambox_record = function(box_id, index, callback, params) {
        var _req = { op_type: OP_TYPE.GET_DREAMBOX_RECORD, box_id: box_id, index: index };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    
    /**
     * 聊天区屏蔽 145
     */
    callcenter.ifIgnore = function(name, area, isIgnore, callback, params) {
        var _req = { op_type: OP_TYPE.IS_IGNORE, strNickName: name, strZoneName: area, bAdd: isIgnore };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    };
    /*
    * 刷新周星礼物 、 冠名接口通知  274
    */
    callcenter.get_star_gifts = function(callback, params) {
        var _req = { op_type: OP_TYPE.RECV_STAR_GIFTS };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /*
    * 刷新PK礼物，pk角标  326
    */
    callcenter.get_pk_refresh_gifts = function(callback, params) {
        var _req = { op_type: OP_TYPE.PK_REFRESH_GIFTS };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /*
     * 向客户端发送的玩家贡献榜信息
     */
    callcenter.get_common_activity_player_rank = function(callback, params) {
        var _req = { op_type: OP_TYPE.COMMON_ACTIVITY_PLAYER_RANK };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /**
     * 当客户端完成教学任务时，发送对应的教学任务的flag,给服务器: 335
     */
    callcenter.send_finish_education = function(flag, callback, params){
        var _req = { op_type: OP_TYPE.SEND_FINISHED_EDUCATION, flag: flag };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /**
     * 玩家点击密令按钮发送消息,无返回 337
     */
    callcenter.send_secret_box_clicked = function(isForbidTalk, callback, params){
        var _req = { op_type: OP_TYPE.PLAYER_DRAW_SECRET_HEAT_BOX_REWARD, is_forbid_talk:isForbidTalk };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /**
     * 获取演唱会回放房间列表事件 341
     */
    callcenter.concert_playback_room_get_roomlist = function(from, req_count, callback, params){
        var _req = { op_type: OP_TYPE.CONCERT_PLAYBACK_ROOM_GET_ROOMLIST, from: from, req_count: req_count };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /**
     * 开始观看演唱会回放事件 342
     * concert_id 演唱会房间 id
     */
    callcenter.start_concert_playback = function(concert_id, callback, params){
        var _req = { op_type: OP_TYPE.START_CONCERT_PLAYBACK, concert_id: concert_id };
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /*
    *周星赛URL配置请求
    * @param callback       界面回调
    * @param params         附加参数
    */
    callcenter.query_weekstar_url_config = function(callback, params) {
        var _req = { op_type: OP_TYPE.GET_WEEKSTAR_URL_CONFIG};
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
     /*
    *周星赛排行榜列表请求
    * @param callback       界面回调
    * @param params         附加参数
    */
    callcenter.query_weekstar_ranklist = function(sub_rank_name, begin_index, end_index, callback, params) {
        var _req = { op_type: OP_TYPE.GET_WEEKSTAR_RANKLIST, sub_rank_name: sub_rank_name, begin_index: begin_index, end_index: end_index};
        network.sendMsg(_req, callback, get_new_param_with_callback(callback, params));
    }
    /**********REQUEST  END ************/

    if (!window.mgc) {
        window.mgc = {};
    }
    window.mgc.callcenter = callcenter;
    return callcenter;
});