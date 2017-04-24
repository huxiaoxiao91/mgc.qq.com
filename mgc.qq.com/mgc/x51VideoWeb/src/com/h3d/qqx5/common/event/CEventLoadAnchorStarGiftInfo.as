package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventLoadAnchorStarGiftInfo extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventLoadAnchorStarGiftInfo;
		}
		
		public function CEventLoadAnchorStarGiftInfo()
		{
			registerField("m_anchor_id", "", Descriptor.Int64, 1);
		}
		
		public var m_anchor_id : Int64;
	}
}