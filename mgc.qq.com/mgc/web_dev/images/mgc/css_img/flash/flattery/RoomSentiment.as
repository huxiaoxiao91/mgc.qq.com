package 
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.filters.GlowFilter;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	import flash.display.LoaderInfo;

	public class RoomSentiment extends MovieClip
	{
		public static var roomSentimentNumText:TextField;
		public static var isnormal:int = 0;

		public function RoomSentiment()
		{
			// constructor code
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
			initShow(paramObj.roomSentiment,paramObj.roomIsNormal);
		}
		/*
		*num:人气数值
		*isnormal:是否是普通捧场
		*/
		private function initShow(num:Number,isnormal:int):void
		{
			this.gotoAndPlay(2);
			RoomSentiment.isnormal = isnormal;
			RoomSentiment.roomSentimentNumText.text = "房间人气+" + num;
		}

		private function init():void
		{
			roomSentimentNumText = new TextField();
			var tf:TextFormat = new TextFormat();
			tf.align = "center";
			tf.color = 0xffffff;
			tf.size = 14;
			tf.font = "微软雅黑";
			tf.bold = true;
			RoomSentiment.roomSentimentNumText.defaultTextFormat = tf;
			RoomSentiment.roomSentimentNumText.width = 165;
			RoomSentiment.roomSentimentNumText.filters = [new GlowFilter(0x000000,1.0,2.0,2.0,10,1,false,false)];
			RoomSentiment.roomSentimentNumText.y = 95;
			RoomSentiment.roomSentimentNumText.x = 17.5;
			
		}
	}

}