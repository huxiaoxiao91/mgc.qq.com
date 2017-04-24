package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventVideoGuildModifyMemberPosition extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildModifyMemberPosition;
		}
		
		public function CEventVideoGuildModifyMemberPosition()
		{
			registerField("position_id", "", Descriptor.Int32, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("result", "", Descriptor.Int32, 3);
			registerField("vg_id", "", Descriptor.Int64, 4);
			registerField("target_id", "", Descriptor.Int64, 5);
			registerField("trans_id", "", Descriptor.Int64, 6);
			registerField("serial_id", "", Descriptor.Int32, 7);
		}
		
		public var position_id : int;
		public var player_id : Int64 = new Int64();
		public var result : int;
		public var vg_id : Int64  = new Int64();
		public var target_id : Int64  = new Int64();
		public var trans_id : Int64  = new Int64();
		public var serial_id : int;
	}
}
