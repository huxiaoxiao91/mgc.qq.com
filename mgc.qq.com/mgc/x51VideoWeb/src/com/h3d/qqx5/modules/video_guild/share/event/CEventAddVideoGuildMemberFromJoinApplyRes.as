package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventAddVideoGuildMemberFromJoinApplyRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventAddVideoGuildMemberFromJoinApplyRes;
		}
		
		public function CEventAddVideoGuildMemberFromJoinApplyRes()
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
			registerField("target_id", "", Descriptor.Int64, 2);
			registerField("vgid", "", Descriptor.Int64, 3);
			registerField("player_id", "", Descriptor.Int64, 4);
			registerField("result", "", Descriptor.Int32, 5);
			registerField("target_name", "", Descriptor.TypeString, 6);
			registerField("target_zname", "", Descriptor.TypeString, 7);
		}
		
		public var trans_id : Int64;
		public var target_id : Int64;
		public var vgid : Int64;
		public var player_id : Int64;
		public var result : int;
		public var target_name : String = "";
		public var target_zname : String = "";
	}
}
