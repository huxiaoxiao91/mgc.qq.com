package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventGetAnchorListInRoom extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventGetAnchorListInRoom;
		}
		
		public function CEventGetAnchorListInRoom()
		{
			registerField("operator", "", Descriptor.Int64, 1);
		}
		
		public var operator : Int64;
	}
}
