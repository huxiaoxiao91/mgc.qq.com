package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	
	public class CEventLoadAllNestForRank extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventLoadAllNestForRank;
		}
		
		public function CEventLoadAllNestForRank()
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
		}
		
		public var trans_id : Int64;
	}
}
