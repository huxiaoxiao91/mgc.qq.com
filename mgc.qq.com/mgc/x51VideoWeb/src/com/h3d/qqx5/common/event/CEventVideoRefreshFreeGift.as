package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.FreeGiftInfo;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventVideoRefreshFreeGift extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventVideoRefreshFreeGift;
		}
		public function CEventVideoRefreshFreeGift()
		{
			registerFieldForList("free_gift", getQualifiedClassName(FreeGiftInfo), Descriptor.Compound, 1);
		}
		public var free_gift : Array = new Array;
	}
}
