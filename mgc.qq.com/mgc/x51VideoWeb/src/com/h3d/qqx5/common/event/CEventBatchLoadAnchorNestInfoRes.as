package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	
	public class CEventBatchLoadAnchorNestInfoRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventBatchLoadAnchorNestInfoRes;
		}
		
		public function CEventBatchLoadAnchorNestInfoRes()
		{
		}
		
	}
}
