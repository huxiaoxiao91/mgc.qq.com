package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventVideoRoomDelNestAssistantRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventVideoRoomDelNestAssistantRes;
		}
		
		public function CEventVideoRoomDelNestAssistantRes()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("anchor_id", "", Descriptor.Int64, 2);
		}
		
		public var player_id : Int64 = new Int64(0,0);
		public var anchor_id : Int64 = new Int64(0,0);
	}
}
