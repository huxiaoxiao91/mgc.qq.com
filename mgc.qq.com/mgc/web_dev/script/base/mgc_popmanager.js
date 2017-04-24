/**
 * @Description:   梦工厂web-入口-任务中心
 *
 * @author         Created by 杨永鑫,change by Xu XiaoJing
 * @version        V2.0
 * @Date           2015/12/09
 * @Company        horizon3d
 *
 *  UI基础层使用相对父级定位
 *  优先级规则
 *  登录等插件层> Loading界面层>特殊提示框层>提示性功能弹出框层>功能弹框层>常驻界面层>Flash特效层>UI基础层
 *  除登录等插件层和Loading界面层外其他每层又区分为浮层>子功能弹出层>基本界面层
 *  登录等插件层 z-index = 999999;
 *  Loading界面层 z-index = 989999;
 *  特殊提示框层 z-index = 979999 —— z-index = 970000;
 *  提示性功能弹出框层 z-index = 969999 —— z-index = 960000; 浮层 z-index = 969999 —— z-index = 969000; 子功能弹出层 z-index = 968999 —— z-index = 968000; 基本界面层 z-index = 967999 —— z-index = 960000;
 *  功能弹框层 z-index = 959999 —— z-index = 950000; 浮层 z-index = 959999 —— z-index = 959000; 子功能弹出层 z-index = 958999 —— z-index = 958000; 基本界面层 z-index = 957999 —— z-index = 950000;
 *  常驻界面层 z-index = 949999 —— z-index = 940000; 浮层 z-index = 949999 —— z-index = 949000; 子功能弹出层 z-index = 948999 —— z-index = 948000; 基本界面层 z-index = 947999 —— z-index = 940000;
 *  Flash特效层 z-index = 939999 —— z-index = 930000; 浮层 z-index = 939999 —— z-index = 939000; 子功能弹出层 z-index = 938999 —— z-index = 938000; 基本界面层 z-index = 937999 —— z-index = 930000;
 *  UI基础层 即使需要设置z-index 也要在 900000以下 不许超过这个深度;
 */

define(['jquery'], function($j) {
    var popManager = {};
    //存储456级别最小zindex
    var minLayer = {
        1: 920000,
        2: 930010,
        3: 940001,
        4: 950001,
        5: 960001,
        6: 970001,
        7: 989999,
        8: 999999
    };
    //层级累加计数
    var layerDictionary = {
        "1": {
            "1": minLayer[1],
            "2": 928000,
            "3": 929000
        },
        "2": {
            "1": minLayer[2],
            "2": 938001,
            "3": 939002
        },
        "3": {
            "1": minLayer[3],
            "2": 948000,
            "3": 949000
        },
        "4": {
            "1": minLayer[4],
            "2": 958000,
            "3": 959000
        },
        "5": {
            "1": minLayer[5],
            "2": 968000,
            "3": 969000
        },
        "6": {
            "1": minLayer[6]
        },
        "7": {
            "1": minLayer[7]
        },
        "8": {
            "1": minLayer[8]
        }
    };
    //层级对象存储
    var displayObjectList = {
        1: {},
        2: {},
        3: {},
        4: {},
        5: {},
        6: {},
        7: {},
        8: {}
    };
    //浮层存储
    var overlayTemp = {
        1: 0,
        2: 0,
        3: 0,
        4: 0,
        5: 0,
        6: 0,
        7: 0,
        8: 0
    };

    if (!Object.keys) {
        Object.keys = function(o) {
            if (o !== Object(o))
                throw new TypeError('Object.keys called on a non-object');
            var k = [], p;
            for (p in o)
                if (Object.prototype.hasOwnProperty.call(o, p))
                    k.push(p);
            return k;
        };
    }

    /**
     * @param container 深度控制的容器#id  .class
     * @param mainType 1:ui基础层,2:flash特效层,3:常驻界面层,4:功能弹框层,5:提示性功能弹框层,6:特殊提示框层,7:loding层,8:登录第三方插件层
     * @param subType  1:基本界面,2:子功能弹框层,3:浮层
     * @param replace  4,5级显示状态，0或不填，忽略 ; 1:替换  (去掉先前该级别界面); 2:同时存在
     * @param extendParam 可扩展参数:哈希对象
     *                   {
     *                      saveFocus:true      //是否保留底层输入框的焦点状态：[true:保留],[false,丢掉]，默认false
     *                   }
     */

    popManager.layerControlShow = function(container, mainType, subType, replace, extendParam) {
        if (typeof (replace) == "undefined") {
            replace = false;
        }
        ///////////////////////////////////////////////////////////////////////////
        //第一步先判断是不是忽略关系，忽略关系的不显示，8,5-1
        if (mainType == 8 && displayObjectList[8][1]) {
            return;
        }
            //第5级忽略
        else if (mainType == 5) {
            if (displayObjectList[5][1] && subType == 1 && !replace) {
                return;
            }
            if (subType == 2 || subType == 3) {
                if (displayObjectList[8][1] || displayObjectList[7][1] || displayObjectList[6][1]) {
                    return;
                }
            }
        }
            //第4级忽略
        else if (mainType == 4) {
            if (displayObjectList[5][1]) {
                return;
            }
            if (displayObjectList[4][1] && subType == 1 && !replace) {
                return;
            }
            if (subType == 2 || subType == 3) {
                if (displayObjectList[8][1] || displayObjectList[7][1] || displayObjectList[6][1]) {
                    return;
                }
            } else {
                if (displayObjectList[7][1] || displayObjectList[6][1]) {
                    return;
                }
            }
        }
            //第3和1级忽略
        else if (mainType == 3 || mainType == 1) {
            if (subType == 2 || subType == 3) {
                if (displayObjectList[8][1] || displayObjectList[7][1] || displayObjectList[6][1]) {
                    return;
                }
                if (displayObjectList[5][1] || displayObjectList[5][2] || displayObjectList[5][3]) {
                    return;
                }
                if (displayObjectList[4][1] || displayObjectList[4][2] || displayObjectList[4][3]) {
                    return;
                }
            }
        }
            //第2级忽略
        else if (mainType == 2) {
            if (displayObjectList[7][1]) {
                return;
            }
        }

        ///////////////////////////////////////////////////////////////////////////
        //第二步关闭替换关系的层
        if (mainType == 8) {
            removeLayer(5, 3);
            removeLayer(5, 2);
            removeLayer(4, 3);
            removeLayer(4, 2);

        }
        if (mainType == 7) {
            removeLayer(7, 1);
            removeLayer(5, 3);
            removeLayer(4, 3);
        }
        if (mainType == 6) {
            removeLayer(6, 1);
            removeLayer(5, 3);
            removeLayer(5, 2);
            removeLayer(4, 3);
            removeLayer(4, 2);
        }
        if (mainType == 5) {
            removeLayer(4, 3);
            removeLayer(4, 2);
            if (subType == 1 && replace && replace == 1) {
                removeLayer(5, 1);
            }
            if (subType == 2) {
                removeLayer(5, 3);
                removeLayer(5, 2);
            }
            if (subType == 3) {
                removeLayer(5, 3);
            }
        }
        if (mainType == 4) {
            if (subType == 1 && replace && replace == 1) {
                removeLayer(4, 1);
            }
            if (subType == 2) {
                removeLayer(4, 3);
                removeLayer(4, 2);
            }
            if (subType == 3) {
                removeLayer(4, 3);
            }
        }
        if (mainType == 8 || mainType == 5 || mainType == 4) {
            removeLayer(3, 3);
            removeLayer(3, 2);
            removeLayer(1, 3);
            removeLayer(1, 2);
        }

        if ((mainType == 3 || mainType == 1) && subType == 3) {
            removeLayer(3, 3);
            removeLayer(1, 3);
        }

        if ((mainType == 3 || mainType == 1) && subType == 2) {
            removeLayer(3, 3);
            removeLayer(1, 3);
            removeLayer(3, 2);
            removeLayer(1, 2);
        }
        ///////////////////////////////////////////////////////////////////////////
        //第三步如需要建立遮罩，显示图层
        var displayObjectName = getDisplayObjectName(container);

        if (!displayObjectList[mainType][subType]) {
            displayObjectList[mainType][subType] = {};
        }

        if (displayObjectList[mainType][subType][displayObjectName]) {
            displayObjectList[mainType][subType][displayObjectName].hide();
        }
        if ((mainType == 8 || mainType == 6 || mainType == 5 || mainType == 4) && subType == 1) {
            var cssObj = {
                backgroundColor: '#111',
                borderTop: '1px solid ' + '#111',
                position: 'fixed',
                height: $j(window).height() + 'px',
                zIndex: minLayer[mainType],
                width: '100%',
                left: '0',
                top: '0',
                opacity: '0.5',
                filter: 'alpha(opacity=50)'
            };
            if ($j("#overlay").length == 0) {
                $j("body").append('<div id="overlay"></div>');
                $j("#overlay").css(cssObj);
            } else {
                if ($j("#overlay").css("display") != "none" && (layerDictionary[mainType][subType] > minLayer[mainType])) {
                    $j("#overlay").hide();
                    layerDictionary[mainType][subType]--;
                }
            }
            $j("#overlay").css("z-index", layerDictionary[mainType][subType]);
            $j("#overlay").show();
            overlayTemp[mainType] = layerDictionary[mainType][subType];
            //console.log("show    overlay showIndex = " + $j("#overlay").css("z-index"));
            layerDictionary[mainType][subType]++;
        }
        container.css("z-index", layerDictionary[mainType][subType]);
        container.show();
        displayObjectList[mainType][subType][displayObjectName] = container;
        //console.log("show    displayObjectName = " + displayObjectName + "  mainType = " + mainType + "   subType = " + subType + " showIndex = " + container.css("z-index"));
        layerDictionary[mainType][subType]++;
        //是否丢掉当前输入框的焦点
        if (!(extendParam && extendParam.saveFocus))
            $j("input[type=text]").blur();
    };

    popManager.layerControlHide = function(container, mainType, subType) {
        var displayObjectName = getDisplayObjectName(container);
        if (displayObjectList[mainType] && displayObjectList[mainType][subType] && displayObjectList[mainType][subType][displayObjectName]) {
            var objLength = Object.keys(displayObjectList[mainType][subType]).length;
            //删除层级
            displayObjectList[mainType][subType][displayObjectName].hide();
            //console.log("hide    displayObjectName = " + displayObjectName + "  mainType = " + mainType + "   subType = " + subType + " showIndex = " + displayObjectList[mainType][subType][displayObjectName].css("z-index"));
            layerDictionary[mainType][subType]--;
            delete displayObjectList[mainType][subType][displayObjectName];
            objLength--;
            if (objLength == 0) {
                delete displayObjectList[mainType][subType];
                if (subType == 1) {
                    layerDictionary[mainType][1] = minLayer[mainType];
                }
            }
            //删除overlay
            if ((mainType == 8 || mainType == 6 || mainType == 5 || mainType == 4) && subType == 1) {
                if (objLength == 0) {
                    //本级别没有了就把本级别的overlay删了
                    $j("#overlay").hide();
                    //console.log("hide    overlay   mainType = " + mainType + " showIndex = " + $j("#overlay").css("z-index"));
                    layerDictionary[mainType][subType]--;
                    overlayTemp[mainType] = 0;
                    //显示别的级别的overlay
                    for (var i = mainType - 1; i >= 1; i--) {
                        if (overlayTemp[i]) {
                            $j("#overlay").css("z-index", overlayTemp[i]);
                            $j("#overlay").show();
                            //console.log("show    tmpoverlay   mainType = " + i + " showIndex = " + $j("#overlay").css("z-index"));
                            break;
                        }
                    }
                } else {
                    //本级还有，就把本级别的overlay改为最顶层的本级别窗口的zindex减1
                    var propNames = Object.keys(displayObjectList[mainType][subType]);
                    var topIndex = displayObjectList[mainType][subType][propNames[objLength - 1]].css("z-index");
                    $j("#overlay").css("z-index", topIndex - 1);
                    overlayTemp[mainType] = topIndex - 1;
                }
            }

        }
    };

    var getDisplayObjectName = function(container) {
        var returnName = "";
        if (container.attr("id") && container.attr("id").length > 0) {
            returnName = container.attr("id");
        } else if (container.attr("class") && container.attr("class").length > 0) {
            returnName = container.attr("class");
        } else {
            returnName = "temp" + (new Date()).getTime();
            container.attr("id", returnName);
        }
        return returnName;
    };

    var removeLayer = function(mType, sType) {
        var listObj = displayObjectList[mType][sType];
        if (listObj) {
            var objLength = Object.keys(listObj).length;
            if (objLength) {
                $j.each(listObj, function(n, value) {
                    value.hide();
                    layerDictionary[mType][sType] = layerDictionary[mType][sType] - 1;
                    delete listObj[n];
                });
                //console.log("hide    displayObjectList  mainType = " + mType + "   subType = " + sType);
                delete displayObjectList[mType][sType];
                if (sType == 1) {
                    layerDictionary[mType][1] = minLayer[mType];
                }
            }
        }
    };

    popManager.commonPop45 = function(container, mainType, subType, replace) {
        popManager.layerControlShow(container, mainType, subType, replace);
        container.centerDisp();
        container.find(".pop_close").off('click').on('click', function() {
            window.mgc.popmanager.layerControlHide(container, mainType, subType);
        });
    };

    $j(window).resize(function() {
        $j("#overlay").css("height", $j(window).height());
    });

    if (!window.mgc) {
        window.mgc = {};
    };
    window.mgc.popmanager = popManager;
    return popManager;
});
