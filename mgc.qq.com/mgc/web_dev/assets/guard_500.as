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

	import br.com.stimuli.loading.BulkLoader;

	public class guard_500 extends MovieClip
	{

		public static var glowFilter:GlowFilter;
		public static var userNamText:TextField;
		public static var userZoneText:TextField;
		public static var loader:Loader;
		public static var vipBit:Bitmap = new Bitmap();
		public static var guardBit:Bitmap = new Bitmap();

		private var vipIcon:String;
		private var guardIcon:String;

		private var bulkLoader:BulkLoader = new BulkLoader("gift");


		public function guard_500()
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			Security.allowDomain("*");
			addEventListener(Event.ADDED_TO_STAGE,addHandler);
		}

		private function addHandler(e:Event):void
		{
			var paramObj:Object = LoaderInfo(this.root.loaderInfo).parameters;

			init();
			initShow(paramObj.userName,paramObj.userZone,paramObj.vipIcon,paramObj.guardIcon);

		}

		private function init():void
		{
			var tf:TextFormat = new TextFormat();

			tf.color = 0x005890;
			tf.size = 12;
			tf.align = TextFormatAlign.CENTER;

			glowFilter = new GlowFilter(0x62090B);
			glowFilter.blurX = 2;
			glowFilter.blurY = 2;
			glowFilter.strength = 50;
			userNamText = new TextField();
			userNamText.multiline = false;
			userNamText.defaultTextFormat = tf;
			//userNamText.border = true;
			userNamText.width = 85;

			var tf1:TextFormat = new TextFormat();

			tf1.color = 0x333333;
			tf1.size = 12;

			tf1.align = TextFormatAlign.CENTER;

			userZoneText = new TextField();
			userZoneText.defaultTextFormat = tf1;
			userZoneText.multiline = false;
			userZoneText.width = 118;
			//userZoneText.border = true;
			userZoneText.y = 50;
		}

		public function initShow(userNameStr:String,userZoneStr:String,vipIcon:String,guardIcon:String):void
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

			if (num >= 6)
			{
				userNameStr = userNameStr.substr(0,6) + "...";
			}

			userNamText.text = userNameStr;

			userZoneText.text = userZoneStr;
			//userNamText.filters = [glowFilter];
			this.vipIcon = vipIcon;
			this.guardIcon = guardIcon;


			bulkLoader.add(vipIcon);
			bulkLoader.add(guardIcon);
			bulkLoader.addEventListener(BulkLoader.COMPLETE, onComplete);
			bulkLoader.start();

		}


		/**
		 * 图片加载完毕
		 */
		private function onComplete(e:Event):void
		{
			bulkLoader.removeEventListener(BulkLoader.COMPLETE, onComplete);

			vipBit.bitmapData = bulkLoader.getBitmapData(vipIcon);
			guardBit.bitmapData = bulkLoader.getBitmapData(guardIcon);
		}


	}
}