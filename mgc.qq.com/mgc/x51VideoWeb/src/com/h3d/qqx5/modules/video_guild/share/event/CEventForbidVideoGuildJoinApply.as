package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventForbidVideoGuildJoinApply extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventForbidVideoGuildJoinApply;
		}
		
		public function CEventForbidVideoGuildJoinApply()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("vgid", "", Descriptor.Int64, 2);
			registerField("is_forbid", "", Descriptor.TypeBoolean, 3);
			registerField("serial_id", "", Descriptor.Int32, 4);
		}
		
		public var player_id : Int64  = new Int64();
		public var vgid : Int64  = new Int64();
		public var is_forbid : Boolean;
		public var serial_id : int;
	}
}
