package view.components
{
	import flash.external.ExternalInterface;

	public class BrowserInfo
	{
		private static var _info:String;
		private static var _name:String;
		private static var _version:String;
		private static var _host:String;
		private static var _href:String;
		private static var _pathname:String;
		private static var _webTitle:String;

		public static var is_msie:Boolean    = false;
		public static var is_firefox:Boolean = false;
		public static var is_opera:Boolean   = false;
		public static var is_chrome:Boolean  = false;
		public static var is_safari:Boolean  = false;
		public static var is_other:Boolean   = false;

		public static const MSIE:String      = "msie";
		public static const FIREFOX:String   = "firefox";
		public static const OPERA:String     = "opera";
		public static const CHROME:String    = "chrome";
		public static const SAFARI:String    = "safari";
		public static const OTHER:String     = "other";

		/*
		* @public 在获取信息前首先要加载的函数（初始化）！
		**/
		public static function getBrowserInfo():void
		{
			if (ExternalInterface.available)
			{
				try
				{
					_info = ExternalInterface.call("function BrowserAgent(){return navigator.userAgent;}");
				}
				catch (error:Error)
				{

				}
				//_info = ExternalInterface.call("eval" , "navigator.userAgent");
				_getBrowserInfo();
			}
		}

		/*
		* @public GETTER!
		* @getter name 浏览器名称！
		* @getter version 浏览器版本！
		* @getter info 浏览器内核标识！
		* @getter host 当前域名！
		* @getter href 当前完整URL！
		* @getter pathname 除域名外的部分！
		* @getter webTitle 网页标题！
		**/
		public static function get name():String
		{
			return _name;
		}

		private static function _getBrowserInfo():void
		{
			var rMsie:RegExp = /.*(msie) ([\w.]+).*/, // ie  
				rFirefox:RegExp = /.*(firefox)\/([\w.]+).*/, // firefox  
				rOpera:RegExp = /(opera).+version\/([\w.]+)/, // opera  
				rChrome:RegExp = /.*(chrome)\/([\w.]+).*/, // chrome  
				rSafari:RegExp = /.*version\/([\w.]+).*(safari).*/; // safari
			_execInfo([rMsie, rFirefox, rOpera, rChrome, rSafari]);
		}

		private static function _execInfo(_regArr:Array):void
		{
			if (_info != null && _info != "")
			{
				try
				{
					var _localInfo:String = _info.toLowerCase();
					var _localMatchInfo:Array;
					for each (var regexp:RegExp in _regArr)
					{
						_localMatchInfo = regexp.exec(_localInfo);
						if (_localMatchInfo != null)
						{
							if (_localMatchInfo[2] == SAFARI)
							{
								_name = _localMatchInfo[2];
								_version = _localMatchInfo[1];
							}
							else
							{
								_name = _localMatchInfo[1];
								_version = _localMatchInfo[2];
							}
							BrowserInfo["is_" + _name] = true;
							break;
						}
					}
				}
				catch (error:Error)
				{

				}

				if (_name == null || _name == "")
				{
					_name = OTHER;
					BrowserInfo.is_other = true;
				}
			}
			else
			{
				_name = OTHER;
				BrowserInfo.is_other = true;
			}
		}
	}
}
