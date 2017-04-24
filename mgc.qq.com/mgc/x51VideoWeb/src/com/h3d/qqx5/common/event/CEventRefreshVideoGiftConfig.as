package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.video_service.serviceinf.GiftConfigData;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	public class CEventRefreshVideoGiftConfig extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventRefreshVideoGiftConfig;
		}
		public function CEventRefreshVideoGiftConfig()
		{
			registerFieldForDict("gift_data", "", Descriptor.Int32,getQualifiedClassName(GiftConfigData),Descriptor.Compound,1);
			registerField("exclusive_screen_time", "", Descriptor.Int32, 2);
			registerField("continuous_send_gift_time_limit", "", Descriptor.Int32, 3);
		}
		
		public var gift_data:Dictionary = new Dictionary();
		public var exclusive_screen_time:int = 0;
		public var continuous_send_gift_time_limit:int = 0;
	}
}