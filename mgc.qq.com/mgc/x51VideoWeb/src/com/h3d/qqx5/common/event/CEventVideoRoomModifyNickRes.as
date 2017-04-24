package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventVideoRoomModifyNickRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventVideoRoomModifyNickRes;
		}
		
		public function CEventVideoRoomModifyNickRes()
		{
			registerField("res", "", Descriptor.Int32, 1);
			registerField("m_recommend_nick", "", Descriptor.TypeString, 2);
			registerField("m_source_type", "", Descriptor.Int32, 3);
		}
		public var res:int;
		public var m_recommend_nick : String;
		public var m_source_type : int;
	}
}