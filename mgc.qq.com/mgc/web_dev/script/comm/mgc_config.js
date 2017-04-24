/**
 * Created by shixinqi on 2016/1/10.
 * 静态配置
 */
define(function () {
    var CONFIG = {};
    /*
    *活动配置
    *ACT_NAME       活动名称
    *ACT_MARK       活动标识
    *ACT_DATE       活动日期
    *ACT_RESOURCE   活动资源文件配置
    *ACR_STATE      活动状态（0:禁用  1:启用  状态可扩充）
    */
    CONFIG.ACT_CONFIG = {
        SERIES: [
            {
                ACT_ID: "01",
                ACT_MARK: "april_fool_s_day",
                ACT_NAME: "愚人节活动",
                ACT_DATE: "2016/03/18 17:00:00-2016/04/02 00:00:00",
                ACT_RESOURCE: "活动资源文件配置（预留）",
                ACR_STATE: 1
            },
            {
                ACT_ID: "02",
                ACT_MARK: "valentine_s_day",
                ACT_NAME: "情人节活动",
                ACT_DATE: "2016/01/03 11:30:50-2016/01/03 15:10:00",
                ACT_RESOURCE: "活动资源文件配置（预留）",
                ACR_STATE: 0
            }
        ]
    }
    /*
    *皮肤配置
    */
    CONFIG.SKIN_CONFIG = {
        1: {                                        //皮肤类型
            name: "星光舞台",                           //皮肤主题名称
            1: {
                is_ui_change: false,                         //当前级别下ui是否发生改变 false:ui不变化   true:ui有变化
                ui_grab: { width: 1711 }
            },
            2: {
                is_ui_change: false,
                ui_grab: { width: 1711 }
            },
            3: {
                is_ui_change: true,
                ui_grab: { width: 1711 }
            },
            4: {
                is_ui_change: false,
                ui_grab: { width: 1725 }
            },
            5: {
                is_ui_change: false,
                ui_grab: { width: 1725 }
            },
            6: {
                is_ui_change: true,
                ui_grab: { width: 1725 }
            },
            7: {
                is_ui_change: false,
                ui_grab: { width: 1754 }
            },
            8: {
                is_ui_change: false,
                ui_grab: { width: 1754 }
            },
            9: {
                is_ui_change: true,
                ui_grab: { width: 1754 }
            }
        },
        2: {
            name: "欢乐海洋",
            1: {
                is_ui_change: false,
                ui_grab: { width: 1766 }
            },
            2: {
                is_ui_change: false,
                ui_grab: { width: 1766 }
            },
            3: {
                is_ui_change: true,
                ui_grab: { width: 1766 }
            },
            4: {
                is_ui_change: false,
                ui_grab: { width: 1755 }
            },
            5: {
                is_ui_change: false,
                ui_grab: { width: 1755 }
            },
            6: {
                is_ui_change: true,
                ui_grab: { width: 1755 }
            },
            7: {
                is_ui_change: false,
                ui_grab: { width: 1754 }
            },
            8: {
                is_ui_change: false,
                ui_grab: { width: 1754 }
            },
            9: {
                is_ui_change: true,
                ui_grab: { width: 1754 }
            }
        },
        3: {
            name: "梦幻游乐场",
            1: {
                is_ui_change: false,
                ui_grab: { width: 1737 }
            },
            2: {
                is_ui_change: false,
                ui_grab: { width: 1737 }
            },
            3: {
                is_ui_change: true,
                ui_grab: { width: 1737 }
            },
            4: {
                is_ui_change: false,
                ui_grab: { width: 1755 }
            },
            5: {
                is_ui_change: false,
                ui_grab: { width: 1755 }
            },
            6: {
                is_ui_change: true,
                ui_grab: { width: 1755 }
            },
            7: {
                is_ui_change: false,
                ui_grab: { width: 1733 }
            },
            8: {
                is_ui_change: false,
                ui_grab: { width: 1733 }
            },
            9: {
                is_ui_change: true,
                ui_grab: { width: 1733 }
            }
        }
    },
    /*
    *主播徽章配置
    *BADGE_ID       徽章ID
    *badge_tips     徽章tips(徽章名<br/>徽章描述)    
    */
    CONFIG.BADGE_CONFIG = {
        '1': {                                        //徽章ID-----金质徽章
            badge_tips: "金质星耀徽章<br/>属于最强的星耀王者！",                  //徽章tips
            
        },
        '2': {                                        //徽章ID-----银质徽章
            badge_tips: "银质星耀徽章<br/>即将走向人生巅峰！",                   //徽章tips
            
        },
        '3': {                                        //徽章ID-----铜质徽章
            badge_tips: "铜质星耀徽章<br/>一只脚已经踏入名门~",                  //徽章tips

        },
        '4': {                                        //徽章ID-----元宵节徽章
            badge_tips: "元宵节徽章<br/>为了你们快乐的元宵节~",                  //徽章tips

        },
        '5': {                                        //徽章ID-----愚人节徽章
            badge_tips: "愚人节徽章<br/>你说什么我都不会再信了！",                 //徽章tips

        },
        '6': {                                        //徽章ID-----年度盛典徽章
            badge_tips: "年度盛典徽章<br/>你现在看到的就是年度最强的王者！",        //徽章tips

        },
        '7': {                                        //徽章ID-----中秋节徽章
            badge_tips: "中秋节徽章<br/>但愿人长久，千里共婵娟。",                 //徽章tips

        },
        '8': {                                        //徽章ID-----圣诞节徽章
            badge_tips: "圣诞节徽章<br/>别忘记挂上袜子~",                        //徽章tips

        },
        '9': {                                         //徽章ID-----新年徽章
            badge_tips: "新年徽章<br/>新年新气象！"                        //徽章tips
        },
        '10':{                                         //徽章ID-----女生节徽章
            badge_tips:"女神徽章<br/>你本来就很美~"                          //徽章tips
        },
        '11':{                                         //徽章ID-----女生节徽章
            badge_tips:"愚人节徽章<br/>捣了个蛋~"                          //徽章tips
        },
        '12':{                                          //徽章ID-----炫舞周年庆徽章
            badge_tips:"炫舞9周年有你真好"                                  //徽章tips
        }
    }
    CONFIG.channel = 1;
    if (!window.mgc) {
        window.mgc = {};
    }
    window.mgc.config = CONFIG;
    return CONFIG;
});