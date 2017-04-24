/*
*列表页逻辑扩展
*/
if (MgcAPI.SNSBrowser.IsQQGame() && !(MgcAPI.SNSBrowser.IsQQGameLiveArea())) {
    try {
        $.getScript("http://qqgameplatcdn.qq.com/social_hall/js/jquery.pm.js", function() {
            $.getScript("http://qqgameplatcdn.qq.com/social_hall/app_frame/qqgamelib.js", function() {
                $(function() { if (GameAPI.SNSBrowser.IsQQGame()) { GameAPI.SNSBrowser.SetSize(768, 1024); GameAPI.SNSBrowser.SetTitle('newgame534', '炫舞梦工厂'); GameAPI.SNSBrowser.SetOK(); } });
            });
        });
    } catch (e) {
        //
    }
}