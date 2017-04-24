package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventStarGiftChampionNotify extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventStarGiftChampionNotify;
		}
		
		public function CEventStarGiftChampionNotify()
		{
			registerFieldForList("gift_ids", "", Descriptor.Int32, 1);
			registerField("anchor_id", "", Descriptor.Int64, 2);
		}
		
		public var gift_ids : Array = new Array;
		public var anchor_id:Int64 = new Int64(0,0);
	}
}