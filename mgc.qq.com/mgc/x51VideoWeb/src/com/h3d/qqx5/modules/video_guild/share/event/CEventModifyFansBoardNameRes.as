package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventModifyFansBoardNameRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventModifyFansBoardNameRes;
		}
		
		public function CEventModifyFansBoardNameRes()
		{
			registerField("result", "", Descriptor.Int32, 1);
			registerField("vg_id", "", Descriptor.Int64, 2);
			registerField("new_name", "", Descriptor.TypeString, 3);
			registerField("player_id", "", Descriptor.Int64, 4);
			registerField("room_id", "", Descriptor.Int32, 5);
			registerField("serial_id", "", Descriptor.Int32, 6);
			registerField("cur_vg_wealth", "", Descriptor.Int32, 7);
			registerField("transid", "", Descriptor.Int64, 8);
		}
		
		public var result : int;
		public var vg_id : Int64;
		public var new_name : String;
		public var player_id : Int64;
		public var room_id : int;
		public var serial_id : int;
		public var cur_vg_wealth : int;
		public var transid : Int64;
	}
}
