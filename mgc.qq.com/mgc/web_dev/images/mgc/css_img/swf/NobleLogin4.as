package 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filters.GlowFilter;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.events.MouseEvent;

	public class NobleLogin4 extends MovieClip
	{

		public static var glowFilter:GlowFilter;
		public static var userNamText:TextField;
		public static var userZoneText:TextField;
		public static var loader:Loader;
		public static var iconBit:Bitmap;

		private var guardIcon:String;

		public function NobleLogin4()
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			Security.allowDomain("*");
			addEventListener(Event.ADDED_TO_STAGE,addHandler);
			super();
		}

		private function addHandler(e:Event):void
		{
			var paramObj:Object = LoaderInfo(this.root.loaderInfo).parameters;

			init();
			initShow(paramObj.guardIcon,paramObj.userName,paramObj.userZone);
			//initShow("F:/WebStom工程文件夹/branch_20150819rc/img/css-img/flash/icon/identity_vip_lv3.png","的是非得失发送是","[梦工厂]");

		}

		private function init():void
		{
			var tf:TextFormat = new TextFormat();
			tf.bold = true;
			tf.color = 0xFF00C0;
			tf.size = 13;

			glowFilter = new GlowFilter(0x424242);
			glowFilter.blurX = 2;
			glowFilter.blurY = 2;
			glowFilter.strength = 50;
			userNamText = new TextField();
			userNamText.multiline = false;
			userNamText.defaultTextFormat = tf;
			//userNamText.border = true;
			userNamText.width = 100;

			var tf1:TextFormat = new TextFormat();

			tf1.color = 0xffffff;
			tf1.size = 12;

			tf1.align = TextFormatAlign.CENTER;
			//tf1.bold = true;

			userZoneText = new TextField();
			userZoneText.defaultTextFormat = tf1;
			userZoneText.multiline = false;
			userZoneText.width = 125;
			//userZoneText.border = true;
			userZoneText.y = 50;

			iconBit = new Bitmap();
		}

		public function initShow(guardIcon:String,userNameStr:String,userZoneStr:String):void
		{
			this.gotoAndPlay(1);
			var num:uint = 0;
			trace(userNameStr.length);
			if (userNameStr.length > 6)
			{
				for (var i:uint = 0; i<userNameStr.length; i++)
				{
					var chat_code:Number = userNameStr.charCodeAt(i);//获得一个字符的ASCII编码 
					if ((chat_code>=19968 && chat_code<=40869))
					{
						num +=  2;
					}
					else
					{
						num +=  1;
					}
				}
			}

			if (num > 6)
			{
				userNameStr = userNameStr.substr(0,6) + "...";
			}

			userNamText.text = userNameStr;

			userZoneText.text = userZoneStr;
			//userNamText.filters = [glowFilter];
			this.guardIcon = guardIcon;
			//createLoader();
		}


		private var count:uint = 0;
		private function createLoader():void
		{
			if (loader)
			{
				try
				{
					loader.close();
				}
				catch (e:Error)
				{
					trace("loader.close() 错误");
				}

				removeEventListenerAll();
			}
			else
			{
				loader = new Loader();
			}

			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.load(new URLRequest(this.guardIcon));
		}

		private function onComplete(e:Event):void
		{
			iconBit.bitmapData = (loader.content as Bitmap).bitmapData;
		}

		private function onIOError( e:IOErrorEvent ):void
		{
			removeEventListenerAll();
			if (count < 3)
			{
				createLoader();
			}
			count++;
		}

		private function removeEventListenerAll():void
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}
	}
}