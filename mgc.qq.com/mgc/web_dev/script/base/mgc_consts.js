/**
 * Created by user on 2015/9/29.
 */
define(function () {
    var consts = {};
    // 一些公用和需要缓存的数据，统一存储在这里
    consts.MGCData = {
        // 梦工厂的固定大区ID
        mgcZoneId: 888,
        // 梦工厂默认渠道
        channel: 0,
        // 是否正在走注册流程
        isRegister: false,

        // 我的playId
        myPlayerId: 0,

        // 我的vip等级
        myVipLevel: 0,

        // 是否关注0-未关注 1-已关注
        followAnchor: 0,

        //主播id
        anchorID: 0,

        //演唱会视频质量
        showRoomDefinition: 0,

        //是否隐身 true隐身
        invisible: false,

        //是否直播中
        isLiveOpen: false,

        //主播禁止发言，禁止公众聊天
        userBanned: "",

        //房间下发禁言状态
        forbidAllUserChat: false,
        //周星赛URL配置
        player_url:""
    };
    //接平台配置
    consts.pageSourceConfig = {
        guest: {
            zoneid: 10888,
            channel: 1
        },
        "mgc": {
            zoneid: 888,
            zonename: '梦工厂',
            appid: 1600000566,
            device_type: 2,
            channel: 0
        },
        "QGame": {
            zoneid: 30889,
            zonename: 'QQ游戏',
            appid: 1600000566,
            device_type: 4,
            channel: 3
        },
        "X52": {
            zoneid: 40888,
            appid: 1600000566,
            device_type: 6,
            channel: 4
        }
    }
    //mgc_callcenter专用常量
    var callcenter = {};
    //梦工厂大区
    callcenter.DEF_ZONENAME = "梦工厂";
    //梦工厂大区名
    callcenter.E_LOGINED_ANONYMOUS = 0;
    //匿名登录
    callcenter.E_LOGINED_GUEST = 1;
    //游客登录
    callcenter.E_LOGIN_CHARA_LIST = 2;
    //选择角色
    callcenter.E_LOGIN_NO_CHARA = 3;
    //创建角色
    callcenter.E_LOGIN_RAN_NAME = 4;
    //随机角色名
    callcenter.E_LOGIN_FAILED = 5;
    //登录失败
    callcenter.E_LOGIN_SUCCESS = 6;
    //登录成功
    consts.callcenter = callcenter;

    var ui = {};
    ui.RES_NORMAL = 0;
    //请求返回正常
    ui.RES_ERROR = 1;
    //请求返回失败
    ui.RES_TIMEOUT = 2;
    //请求返回超时
    ui.RES_USER_CANCEL = 3;
    //请求返回用户取消操作
    consts.ui = ui;
    var url = {};
    //页面地址
    url.HOME = '/';
    url.SHOW_ROOM = 'showroom.shtml';
    url.LIVE_ROOM = 'liveroom.shtml';
    url.CAVEOLAE_ROOM = 'caveolaeroom.shtml';
    url.NEST_ROOM = 'nest.shtml';
    url.TRANSFER = 'transfer.shtml';
    url.IPAY = 'http://pay.qq.com/ipay/index.shtml?c=qxwwqp';
    consts.url = url;

    //性别常量
    var gender = {};
    gender.FEMALE = 0;
    gender.MALE = 1;
    consts.gender = gender;

    var classtype = {};
    classtype.UNDEFINED = 'undefined';
    classtype.NUMBER = 'number';
    classtype.FUNCTION = 'function';
    consts.classtype = classtype;
    /*
    *   贵族等级定义
    *   Todo:放到其他模块中去，建议MGC_Const
    */
    var vipLevelTab = {
        0: '无',
        1: '近卫',
        2: '骑士',
        3: '将军',
        4: '亲王',
        5: '皇帝'
    };
    consts.vipLevelTab = vipLevelTab;
    /*
    *   守护等级定义
    *   Todo:放到其他模块中去，建议MGC_Const
    */
    var guardLevelTab = {
        0: '无',
        10: '初级守护',
        20: '中级守护',
        50: '高级守护',
        100: '天使守护',
        200: '灵魂守护',
        250: '非凡守护',
        300: '至尊守护',
        400: '天尊守护',
        500: '超凡守护'
    };
    consts.guardLevelTab = guardLevelTab;
    /*
    *资源路径
    */
    var filePath = {};
    filePath.IMG_PATH = 'http://ossweb-img.qq.com/images/mgc/css_img/';
    //图片资源根目录
    filePath.FACE_IMG_PATH = filePath.IMG_PATH + 'chat/';
    //表情图片路径
    filePath.GIFT_IMG_PATH = filePath.IMG_PATH + 'items/item_';
    //礼物图片路径
    filePath.HEAD_IMG_PATH = filePath.IMG_PATH + 'headicon/';
    //默认头像路径
    filePath.ROOM_IMG_PATH = filePath.IMG_PATH + 'video_room/living.jpg?v=3_8_8_2016_15_4_final_3';
    //默认房间非直播地址
    filePath.LIVEROOM_WATING_IMG_PATH = filePath.IMG_PATH + 'video_room/waiting.jpg?v=3_8_8_2016_15_4_final_3';
    //直播间视频流断开显示图片地址
    filePath.SHOWROOM_IMG_PATH = filePath.IMG_PATH + 'video_room/show_living.jpg?v=3_8_8_2016_15_4_final_3';
    //默认演唱会非直播地址
    filePath.SHOWROOM_WATING_IMG_PATH = filePath.IMG_PATH + 'video_room/show_waiting.jpg?v=3_8_8_2016_15_4_final_3';
    //演唱会视频流断开显示图片地址
    filePath.ROOM_DEFAULT_IMG = filePath.IMG_PATH + 'common/mgc_auto.png?v=3_8_8_2016_15_4_final_3';
    //分流-默认房间图片
    filePath.DEFAULT_MALE = filePath.HEAD_IMG_PATH + 'default_male.png?v=3_8_8_2016_15_4_final_3';                                   //默认头衔(男)
    filePath.DEFAULT_FEMALE = filePath.HEAD_IMG_PATH + 'default_female.png?v=3_8_8_2016_15_4_final_3';                               //默认头衔(女)
    consts.filePath = filePath;
    //网络常量
    var network = {};
    //组件常量
    consts.API = {
        scroll: {}
    };

    /*密令按钮倒计时*/
    consts.secretOrderInfo = "666666"; //密令
    // 补刀王数据
    consts.lastKingNeedData = [10000, 30000, 30000, 100000];
    consts.lastKingRewardList = [];
    consts.lastKingTimer = null;
    consts.isFinishEducation = 0;// 通知玩家教学标记信息
    consts.isRongruTime = true;

    if (!window.mgc) {
        window.mgc = {};
    }
    window.mgc.consts = consts;
    return consts;
});