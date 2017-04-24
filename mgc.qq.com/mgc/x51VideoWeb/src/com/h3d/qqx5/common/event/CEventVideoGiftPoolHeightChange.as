package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	public class CEventVideoGiftPoolHeightChange extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoGiftPoolHeightChange;
		}
		
		public function CEventVideoGiftPoolHeightChange()
		{
			registerField("cur_height", "", Descriptor.Int32, 1);
			registerField("max_height", "", Descriptor.Int32, 2);
			registerField("room_id", "", Descriptor.Int32, 3);
			registerFieldForList("hasBeenOpenedBox", "", Descriptor.Int32, 4);
			registerFieldForDict("vip_cnt_info", "",Descriptor.Int32,"", Descriptor.Int32, 5);
			registerField("vip_addition", "", Descriptor.Int32, 6);
		}
		
		public var cur_height : int;
		public var max_height : int;
		public var room_id : int;
		public var hasBeenOpenedBox : Array = [];//已开启的宝箱id
		public var vip_cnt_info :Dictionary = new Dictionary();
		public var vip_addition : int;
	}
}
