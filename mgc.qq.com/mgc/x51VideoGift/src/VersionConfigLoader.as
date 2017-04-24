package
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * 客户端版本配置加载器
	 * 数据配置如下：
	 * <config>
	 *   <client>
	 *     <versions>
	 *       <web version="version:387.2.23.2" flvrul=".flv?apptype=live&xHttpTrunk=1&buname=x5h3d_platform&uin=23222439" giftconfigurl="/img/css_img/config/gift.xml" iconpath="/img/css_img/flash/gift/gift_" />
	 * 	  	 <gift version="version:387.2.23.3" />
	 * 	  	 <player version="version:387.2.23.4" />
	 * 	  	 <portrait version="version:387.2.23.5" />
	 *		 <surpriseTreasure version="version:387.2.23.6" />
	 *     </versions>
	 *   </client>
	 * </config>
	 * @author gaolei
	 *
	 */
	public class VersionConfigLoader
	{
		public function VersionConfigLoader()
		{
		}

		private var loader:URLLoader                  = new URLLoader();

		private var callbackFun:Function;

		public static const DEFAULT_CONFIG_URL:String = "/config/client_version_config.xml";

		/**
		 * 读取配置。
		 * 	成功后会调用回调函数，函数的参数为本身。返回参数为空时表示失败。
		 * 	path配置路径如果不传，使用默认地址/config/client_version_config.xml
		 * @param callback	回调函数，参数this
		 * @param path		配置路径
		 *
		 */
		public function loadConfig(callback:Function, path:String = ""):void
		{
			callbackFun = callback;
			try
			{
				if (path == null || path == "")
				{
					loader.load(new URLRequest(DEFAULT_CONFIG_URL));
				}
				else
				{
					loader.load(new URLRequest(path));
				}

				loader.addEventListener(Event.COMPLETE, onLoadXMLComlete);
				loader.addEventListener(IOErrorEvent.IO_ERROR, onAutoPatchConfigLoadError);
			}
			catch (error:Error)
			{
				callbackFun = null;
//				Cc.log("read version_config.xml faile");
			}
		}

		private function onAutoPatchConfigLoadError(event:IOErrorEvent):void
		{
//			Cc.error("Read xml error:" + event.toString());
			if (callbackFun != null)
			{
				callbackFun(null);
			}

			callbackFun = null;
			loader.removeEventListener(Event.COMPLETE, onLoadXMLComlete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onAutoPatchConfigLoadError);
		}

		private function onLoadXMLComlete(event:Event):void
		{
			try
			{
				var xml:XML = new XML(loader.data);
				_webClientVer = xml.client[0].versions[0].web[0].@version;
				_webGiftConfigURL = xml.client[0].versions[0].web[0].@giftconfigurl;
				_webGiftIconPath = xml.client[0].versions[0].web[0].@iconpath;
//				_flvurl = xml.client[0].versions[0].web[0].@flvurl;

				_giftClientVer = xml.client[0].versions[0].gift[0].@version;
				_giftConfigURL = xml.client[0].versions[0].gift[0].@giftconfigurl;
				_giftImgDomain = xml.client[0].versions[0].gift[0].@imgdomain;

				_playerClientVer = xml.client[0].versions[0].player[0].@version;
//				_portraitClientVer = xml.client[0].versions[0].portrait[0].@version;
				_stClientVer = xml.client[0].versions[0].surpriseTreasure[0].@version;

				if (callbackFun != null)
				{
					callbackFun(this);
				}
			}
			catch (e:TypeError)
			{
//				Cc.error("parse the XML file fail!");
				if (callbackFun != null)
				{
					callbackFun(null);
				}
			}

			callbackFun = null;
			loader.removeEventListener(Event.COMPLETE, onLoadXMLComlete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onAutoPatchConfigLoadError);
		}

		private var _webClientVer:String;
		private var _giftClientVer:String;
		private var _playerClientVer:String;
		private var _portraitClientVer:String;
		private var _stClientVer:String;

		private var _webGiftConfigURL:String;
		private var _webGiftIconPath:String;

		private var _giftConfigURL:String;
		private var _giftImgDomain:String;

		private var _flvurl:String;

		/**
		 * web客户端版本号
		 * @return
		 *
		 */
		public function get webClientVer():String
		{
			return _webClientVer;
		}

		/**
		 * web端礼包配置路径
		 * @return
		 *
		 */
		public function get webGiftConfigURL():String
		{
			return _webGiftConfigURL;
		}

		/**
		 * web端图标相对地址
		 * @return
		 *
		 */
		public function get webGiftIconPath():String
		{
			return _webGiftIconPath;
		}

		/**
		 * 礼物区客户端版本号
		 * @return
		 *
		 */
		public function get giftClientVer():String
		{
			return _giftClientVer;
		}

		/**
		 * 礼物区礼物配置路径
		 * @return
		 *
		 */
		public function get giftConfigURL():String
		{
			return _giftConfigURL;
		}

		/**
		 * web端图标相对地址
		 * @return
		 *
		 */
		public function get giftImgDomain():String
		{
			return _giftImgDomain;
		}

		/**
		 * 播放器版本号
		 * @return
		 *
		 */
		public function get playerClientVer():String
		{
			return _playerClientVer;
		}

		/**
		 * 惊喜宝箱版本号
		 * @return
		 *
		 */
		public function get stClientVer():String
		{
			return _stClientVer;
		}

		public static function isHttp(url:String):Boolean
		{
			if (url != null && url != "")
			{
				if (url.indexOf("http:") == 0 || url.indexOf("https:") == 0)
				{
					return true;
				}
			}
			return false;
		}

//		/**
//		 * 视频端url
//		 * CVideoRoomClient 2814
//		 * @return
//		 *
//		 */
//		public function get flv_url():String
//		{
//			return _flvurl;
//		}
	}
}
