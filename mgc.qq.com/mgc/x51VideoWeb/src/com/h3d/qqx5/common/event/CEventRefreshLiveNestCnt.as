package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	
	public class CEventRefreshLiveNestCnt extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventRefreshLiveNestCnt;
		}
		
		public function CEventRefreshLiveNestCnt()
		{
			registerField("count", "", Descriptor.Int32, 1);
		}
		
		public var count : int;
	}
}
