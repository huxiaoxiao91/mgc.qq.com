package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventVideoRoomModifyNick extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventVideoRoomModifyNick;
		}
		
		public function CEventVideoRoomModifyNick()
		{
			registerField("m_nick", "", Descriptor.TypeString, 1);
			registerField("m_source_type", "", Descriptor.Int32, 2);
			registerField("m_rand_nick_pool", "", Descriptor.Int32, 3);
			registerField("m_nick_record_id", "", Descriptor.Int32, 4);
		}
		
		public var m_nick : String= "";
		public var m_source_type : int;
		public var m_rand_nick_pool : int;
		public var m_nick_record_id : int;
	}
}