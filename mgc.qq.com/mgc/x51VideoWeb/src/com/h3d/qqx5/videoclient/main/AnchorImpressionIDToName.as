package com.h3d.qqx5.videoclient.main
{
		
	
	import com.h3d.qqx5.videoclient.data.AnchorImpressinoIDName;
	
	import flash.utils.Dictionary;

	public class AnchorImpressionIDToName
	{
		private static var impression:Array = new Array;
		
		public static function GetImpressionIDToName():Array
		{
			return impression;
		}
		
		public static function PushImpressin(id:int,name:String):void
		{
			var imp:AnchorImpressinoIDName = new AnchorImpressinoIDName;
			imp.impressionID = id;
			imp.impressionName = name;
			impression.push(imp);
		}
	}
}