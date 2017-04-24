package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;

	public class CEventModifyFansBoardName extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventModifyFansBoardName;
		}
		
		public function CEventModifyFansBoardName()
		{
			registerField("vg_id", "", Descriptor.Int64, 1);
			registerField("new_name", "", Descriptor.TypeString, 2);
			registerField("player_id", "", Descriptor.Int64, 3);
			registerField("room_id", "", Descriptor.Int32, 4);
			registerField("serial_id", "", Descriptor.Int32, 5);
			registerField("transid", "", Descriptor.Int64, 6);
		}
		
		public var vg_id : Int64;
		public var new_name : String;
		public var player_id : Int64;
		public var room_id : int;
		public var serial_id : int;
		public var transid : Int64;
	}
}
