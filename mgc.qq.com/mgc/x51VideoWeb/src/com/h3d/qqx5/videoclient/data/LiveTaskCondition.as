package com.h3d.qqx5.videoclient.data
{
	import flashx.textLayout.elements.BreakElement;
	
	public class LiveTaskCondition
	{
		public function LiveTaskCondition()
		{
		}
		private static var LTCT_FreeGift:String  = " 累计赠送免费花:";
		private static var LTCT_GiftValue:String  = " 累计赠送礼物的炫豆值:";
		private static var LTCT_Whistle:String  = " 累计发出";
		
		public static function GetCondition(index:int, progress:int):String
		{
			var str:String = "";
			switch( index)
			{
				case 0:
					str= LTCT_FreeGift + progress;
					break;
				case 1:
					str= LTCT_GiftValue+ progress;
					break;
				case 2:
					str= LTCT_Whistle+ progress+"个飞屏哨子";
					break;
				default :
					break;
			}
			
			return str;
		}
		
		
	}
}