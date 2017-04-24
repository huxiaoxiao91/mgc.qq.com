package 
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import 	flash.filters.GlowFilter;
	import 	flash.external.ExternalInterface;

	public class RoomSentiment extends MovieClip
	{
		public static var roomSentimentNumText:TextField;

		public function RoomSentiment()
		{
			// constructor code
			this.mouseChildren = false;
			this.mouseEnabled = false;
			Security.allowDomain("*");
			addEventListener(Event.ADDED_TO_STAGE,addHandler);
			ExternalInterface.addCallback("roomSentiment",initShow);
			super();
		}

		private function addHandler(e:Event):void
		{
			var paramObj:Object = LoaderInfo(this.root.loaderInfo).parameters;

			init();
			initShow(paramObj.roomSentimentNum);
		}
		
		public function initShow(num:uint):void
		{
			this.gotoAndPlay(2);
			text.text = "房间人气+" + num;
		}

		private function init():void
		{
			roomSentimentNumText = new TextField();
			tf = new TextFormat();
			tf.align = "center";
			tf.color = 0xf;
			tf.size = 14;
			tf.font = "微软雅黑";
			tf.bold = true;
			roomSentimentNumText.defaultTextFormat = tf;
			roomSentimentNumText.filters = [new GlowFilter(0x000000,1.0,2.0,2.0,10,1,false,false)];
			roomSentimentNumText.y = 95;
			roomSentimentNumText.x = 17.5;
		}
	}

}