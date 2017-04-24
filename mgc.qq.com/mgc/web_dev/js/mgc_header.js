var $h = jQuery.noConflict();
var switchTab = function () {
	var pathName = window.location.pathname;
	var htmlIndex = pathName.indexOf(".shtml");
    if (htmlIndex <= 0) {
        $h(".header_index").addClass("current").siblings().removeClass();
    } else {
        var pName = pathName.substring(1,htmlIndex);
        $h(".header_"+pName).addClass("current").siblings().removeClass();
    }
};

// 初始化签到效果swf
var signFlashInit = function () {
    var flashvars = {};
    var params = {};
    params.quality = "high";
    params.bgcolor = "#000";
    params.allowscriptaccess = "always";
    params.allowfullscreen = "true";
    params.allowFullScreenInteractive = "true";
    params.wmode = "transparent";
    var attributes = {};

    var swfurl = "assets/signin.swf?v=3_8_8_2016_15_4_final_3";
    swfobject.embedSWF(swfurl, "header_sign_flash",
        "100%", "100%", "11.1.0", '', flashvars, params, attributes);
};

$h(function () {
    switchTab();
    signFlashInit();
    $h(".logined_nav .fg").click(function () {
        if (filename == "showroom.shtml")
            return false;
    });
    if (filename == "showroom.shtml") {
        $h(".logined_nav .fg").css("background-color", "#ddd");
    }
   
});
