var $ad = jQuery.noConflict(); // 重新设置jquery对象
/**
 * Created by zhaojingsi on 2015/4/28.
 */
//轮播大广告
var TopAdCallBack = function(adData)
{
    var HotPhotoBoardListCon = $ad('#TopBannerTmpl');
    var HotPhotoBoardListTmpl;
    var HotPhotoBoardListContainer = $ad('#topBanner');
    HotPhotoBoardListContainer.children().remove();
    HotPhotoBoardListTmpl = HotPhotoBoardListCon.tmpl(adData);
    HotPhotoBoardListTmpl.appendTo(HotPhotoBoardListContainer);

    var _carouseHtml = '';
    for (var i = 0, j = adData.TOP.length; i < j; i++) {
        if (i == 0) {
            _carouseHtml += '<span class="current compatible_css3"></span>';
        } else {
            _carouseHtml += '<span class="compatible_css3"></span>';
        }
    }
    $ad("#TopBannerTmplcarousel").html(_carouseHtml);
    MGC.carousel("banner","ban_pic","ban_btn",300,5000,"top");
    //css3兼容 
    //try {
    //    $ad("#TopBannerTmplcarousel").find(".compatible_css3").each(function () {
    //        PIE.attach(this);
    //    });            
    //} catch (e) {
    //    console.log("error:css3兼容 " + e.message + " mgc_ad.js;line:23");
    //}
    HotPhotoBoardListTmpl = null;
    HotPhotoBoardListCon = null;
};

//快报
var QuickAdCallBack = function(imgData, textData)
{
    if (imgData.length > 0) {
        $ad("#quick_href").attr('href', imgData[0]["sAdUrl"]);
        $ad("#quick_href").attr('title', imgData[0]["sDesc"]);
        $ad("#quick_img").attr('src', imgData[0]["sImageUrl"]);
		$ad("#quick_href").on('click',function(){
            try {
                EAS.SendClick({'e_c': 'mgc.quick.0', 'c_t': 4});
            }catch(e){

            }
		});
        var HotPhotoBoardListCon = $ad('#quickContainerTmpl');
        var HotPhotoBoardListTmpl;
        var HotPhotoBoardListContainer = $ad('#quickContainer');
        HotPhotoBoardListContainer.children().remove();
        HotPhotoBoardListTmpl = HotPhotoBoardListCon.tmpl(textData);
        HotPhotoBoardListTmpl.appendTo(HotPhotoBoardListContainer);
        HotPhotoBoardListTmpl = null;
        HotPhotoBoardListCon = null;
    }
};

//预留
var YuliuAdCallBack = function(textData)
{
    var HotPhotoBoardListCon = $ad('#yuliuadTmpl');
    var HotPhotoBoardListTmpl;
    var HotPhotoBoardListContainer = $ad('#yuliuad');
    HotPhotoBoardListContainer.children().remove();
    HotPhotoBoardListTmpl = HotPhotoBoardListCon.tmpl(textData);
    HotPhotoBoardListTmpl.appendTo(HotPhotoBoardListContainer);
    HotPhotoBoardListTmpl = null;
    HotPhotoBoardListCon = null;
};

//根据时间戳计算日期
var GetDayTime = function(_nowUinxTime, iDays)
{
    var _tommrow = new Date((_nowUinxTime + (86400000 * iDays)));
    var _year = _tommrow.getFullYear();
    var _month = _tommrow.getMonth() + 1;
    _month = (_month < 10) ? '0'+ _month : _month;
    var _day = _tommrow.getDate();
    _day = (_day < 10) ? '0'+ _day : _day;
    var _nowDate = _year + '-' + _month + '-' + _day;
    return _nowDate;
};

var UserTips = function(iActId,obj)
{
	MGC_Comm.commonCheckLogin(function () {
			var _url = "http://apps.game.qq.com/x5/x5mgc/UserTips.php?iActId="+iActId+"&t="+Math.random();
			MGC_Comm.ajax(_url, function(data) {
				var dialog = {};
			if (data.ret_code == '0') {
				dialog.Note = '订阅活动成功。';
					$m(obj).attr({"class":"subscribed","href":"javascript:;"}).html('已订阅');
				} else {
					dialog.Note = data.msg;
				}
				MGC_Comm.CommonDialog(dialog);
			});
		}, function() {
		MGC_Comm.commonLogin();
		});
};

var hasYg = 0;

//活动预告
var YUGAOAdCallBack = function(adData)
{
    //先获得今天的日期
    $ad.ajax({type: "HEAD",cache: false,complete: function(xhr){
            var str = xhr.getResponseHeader("Date");
            var now = null;
            if(str != null) {
                now = new Date(str);
            } else {
                now = new Date();
            }
            //当前的小时
            var iHour = now.getHours();
            var _year = now.getFullYear();
            var _month = now.getMonth() + 1;
            _month = (_month < 10) ? '0'+ _month : _month;
            var _day = now.getDate();
            _day = (_day < 10) ? '0'+ _day : _day;
            var _nowDate = _year + '-' + _month + '-' + _day;

            //获得今天的时间戳，根据时间戳计算天数
            var _nowUinxTime = now.getTime();

            //计算明天的
            var _tommorwDate = GetDayTime(_nowUinxTime, 1), _threeDate = GetDayTime(_nowUinxTime, 2), _otherStart = GetDayTime(_nowUinxTime, 3), _otherEnd = GetDayTime(_nowUinxTime, 6);

            var todayData = new Array(), tommrowData = new Array(), threeData = new Array(), otherData = new Array();
            //看看今天有没有活动
            for (var i = 0, j = adData.length; i < j; i++) {
                var _adDate = adData[i]['dtStartTime'].substr(0, 10);
                if (_adDate == _nowDate) {
                    //今天的
                    adData[i]["actHour"] = adData[i]['dtStartTime'].substr(11, 5);
                    todayData.push(adData[i]);
                } else if (_adDate == _tommorwDate) {
                    adData[i]["actHour"] = adData[i]['dtStartTime'].substr(11, 5);
                    tommrowData.push(adData[i]);
                } else if (_adDate == _threeDate) {
                    adData[i]["actHour"] = adData[i]['dtStartTime'].substr(11, 5);
                    threeData.push(adData[i]);
                } else if (_adDate >= _otherStart && _adDate <= _otherEnd) {
                    adData[i]["actHour"] = adData[i]['dtStartTime'].substr(5, 11);
                    otherData.push(adData[i]);
                }
            }
            var _menuList = new Array(), _yugaoHtml = '';
            if (todayData.length > 0) {
                hasYg = 1;
                _menuList.push("今天");
                _yugaoHtml += '<ul>';
                for (var m = 0, n = todayData.length; m < n; m++) {
                    _yugaoHtml += '<li>';
                    _yugaoHtml += '<p class="fc_info"><strong>'+todayData[m]['actHour']+'</strong>'+todayData[m]['sDesc']+'<a href="javascript:;" onclick="UserTips('+todayData[m]['iSeqId']+',this);return false;">订阅</a></p>';
                    _yugaoHtml += '<a href="'+todayData[m]['sAdUrl']+'" onclick="try{EAS.SendClick({\'e_c\': \'mgc.yugao.1\',\'c_t\':4});}catch(e){}" target="_blank"><img src="'+todayData[m]['sImageUrl']+'" width="238" height="70" alt="'+todayData[m]['sDesc']+'"></a>';
                    _yugaoHtml += '</li>';
                }
                _yugaoHtml += '</ul>';
            }

            if (tommrowData.length > 0) {
                hasYg = 1;
                _menuList.push("明天");
                _yugaoHtml += '<ul>';
                for (var m = 0, n = tommrowData.length; m < n; m++) {
                    _yugaoHtml += '<li>';
                    _yugaoHtml += '<p class="fc_info"><strong>'+tommrowData[m]['actHour']+'</strong>'+tommrowData[m]['sDesc']+'<a href="javascript:;" onclick="UserTips('+tommrowData[m]['iSeqId']+',this);return false;">订阅</a></p>';
                    _yugaoHtml += '<a href="'+tommrowData[m]['sAdUrl']+'" onclick="try{EAS.SendClick({\'e_c\': \'mgc.yugao.2\',\'c_t\':4});}catch(e){}" target="_blank"><img src="'+tommrowData[m]['sImageUrl']+'" width="238" height="70" alt="'+tommrowData[m]['sDesc']+'"></a>';
                    _yugaoHtml += '</li>';
                }
                _yugaoHtml += '</ul>';
            }

            if (threeData.length > 0) {
                hasYg = 1;
                _menuList.push("后天");
                _yugaoHtml += '<ul>';
                for (var m = 0, n = threeData.length; m < n; m++) {
                    _yugaoHtml += '<li>';
                    _yugaoHtml += '<p class="fc_info"><strong>'+threeData[m]['actHour']+'</strong>'+threeData[m]['sDesc']+'<a href="javascript:;" onclick="UserTips('+threeData[m]['iSeqId']+',this);return false;">订阅</a></p>';
                    _yugaoHtml += '<a href="'+threeData[m]['sAdUrl']+'" onclick="try{EAS.SendClick({\'e_c\': \'mgc.yugao.3\',\'c_t\':4});}catch(e){}" target="_blank"><img src="'+threeData[m]['sImageUrl']+'" width="238" height="70" alt="'+threeData[m]['sDesc']+'"></a>';
                    _yugaoHtml += '</li>';
                }
                _yugaoHtml += '</ul>';
            }

            if (otherData.length > 0) {
                hasYg = 1;
                _menuList.push("其它");
                _yugaoHtml += '<ul>';
                for (var m = 0, n = otherData.length; m < n; m++) {
                    _yugaoHtml += '<li>';
                    _yugaoHtml += '<p class="fc_info"><strong>'+otherData[m]['actHour']+'</strong>'+otherData[m]['sDesc']+'<a href="javascript:;" onclick="UserTips('+otherData[m]['iSeqId']+',this);return false;">订阅</a></p>';
                    _yugaoHtml += '<a href="'+otherData[m]['sAdUrl']+'" onclick="try{EAS.SendClick({\'e_c\': \'mgc.yugao.4\',\'c_t\':4});}catch(e){}" target="_blank"><img src="'+otherData[m]['sImageUrl']+'" width="238" height="70" alt="'+otherData[m]['sDesc']+'"></a>';
                    _yugaoHtml += '</li>';
                }
                _yugaoHtml += '</ul>';
            }

            $ad("#fc_con").html(_yugaoHtml);
			$ad("#fc_con ul").hide();
            if(hasYg == 0){
				$ad('#fc_tab').prev().show();
            }else{
                $ad("#fc_con ul").eq(0).css('display', 'block');
                $ad('#fc_tab').prev().hide();
            }
            

            var _menuHtml = '';
            for (var i = 0, j = _menuList.length; i < j; i++) {
                if (i == 0) {
                    _menuHtml += '<li class="current">'+_menuList[i]+'</li>';
                } else {
                    _menuHtml += '<li>'+_menuList[i]+'</li>';
                }
            }
            $ad("#yuMenu").html(_menuHtml);

            //增加动作
            var tabArr=$ad("#yuMenu").find("li"),len=tabArr.length;
            tabArr.each(function(index) {
                $ad(this).bind("mouseenter",function(){
                    tabArr.removeClass().eq(index).addClass("current");
                    $ad("#fc_con ul").hide();
                    if(hasYg == 0){
                        $ad('#fc_tab').prev().show();
                    }else{
                        $ad("#fc_con").find("ul").eq(index).show();
                        $ad('#fc_tab').prev().hide();
                    }
                    
                })
            });
        }
    });
};

$ad(function(){
    //加载广告
    var _url = "http://mgc.qq.com/upload/x5/x5mgc/ad.js?v=3_8_8_2016_15_4_final_3";
    $ad.getScript(_url, function(data) {
		var urlArr = window.location.href.split('/'),
		    _last = urlArr.pop();
		if(_last == '' || _last.indexOf('index.shtml') != -1){
			//首页额外加载
			QuickAdCallBack(MGC_AD.QUICK_IMG, MGC_AD);
			YuliuAdCallBack(MGC_AD);
			YUGAOAdCallBack(MGC_AD.YUGAO);
		}
		TopAdCallBack(MGC_AD);
    });
});/*  |xGv00|a3c10a9a6d9e9ce2ce185b0f093ce64f */
