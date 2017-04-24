package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventVideoRoomDelNestAssistant extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventVideoRoomDelNestAssistant;
		}
		
		public function CEventVideoRoomDelNestAssistant()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("oper_id", "", Descriptor.Int64, 3);
		}
		
		public var room_id : int;
		public var player_id : Int64;
		public var oper_id : Int64;
	}
}
