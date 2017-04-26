# mgc.qq.com
1.web_dev 下的文件是需要使用的，跟 web_dev　同级的文件夹都是 as 文件，生成的对应的 .swf 文件都在 web_dev 文件夹下：
    (1) EventGift 文件夹对应 web_dev 的 web_dev/assets/eventGift.swf
    (2) flyMessage 文件夹对应 web_dev 的 web_dev/assets/FlyMessageModule.swf
    (3) SurpriseTreasure 文件夹对应 web_dev/assets 的 SurpriseTreasureSwf.swf
    (4) x51VideoGift 文件夹对应 web_dev/images/mgc/css_img/swf 的 x51VideoGift.swf
    (5) x51VideoPlayer 文件夹对应 web_dev 的 x51VideoPlayer.swf
    (6) x51VideoWeb 文件夹对应 web_dev 的 x51VideoWeb.swf
本地运行时，只要有 web_dev 文件即可，web_dev 是本地配置 iis　时的指向，
2.本地　IIS 配置：打开 iis ，网站名称（可以自己命名） trunk.qq.com 指向 web_dev　文件，同时在默认文档里添加 index.shtml，同时添加网站名称（不可以修改网站名称，此处是图片服务器的地址） ossweb-img.qq.com 指向 web_dev
3.本地 host 配置C:\Windows\System32\drivers\etc\hosts: 需要加上两个网站的名称 127.0.0.1 trunk.qq.com 和 127.0.0.1 ossweb-img.qq.com
4.本地运行时，需要修改 web_dev\config\auto_patch_client.xml:此处是修改服务器地址的，可以指向 mgc 的现网 <addr ip="rp.mgc.qq.com" port="31000" />
