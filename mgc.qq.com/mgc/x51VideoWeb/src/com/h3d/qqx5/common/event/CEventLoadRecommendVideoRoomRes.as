package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.common.comdata.HotVideoRoomInfo;

	public class CEventLoadRecommendVideoRoomRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventLoadRecommendVideoRoomRes;
		}
		
		public function CEventLoadRecommendVideoRoomRes()
		{
			registerFieldForList("hot_room_infos", getQualifiedClassName(HotVideoRoomInfo), Descriptor.Compound, 1);
			registerField("type", "", Descriptor.Int32, 2);
		}
		
		public var hot_room_infos : Array = new Array;
		public var type : int;
	}
}
