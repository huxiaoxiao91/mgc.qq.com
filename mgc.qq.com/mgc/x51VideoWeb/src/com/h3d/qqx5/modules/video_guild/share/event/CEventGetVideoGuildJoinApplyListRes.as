package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_guild.VideoGuildJoinApply;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;

	public class CEventGetVideoGuildJoinApplyListRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventGetVideoGuildJoinApplyListRes;
		}
		
		public function CEventGetVideoGuildJoinApplyListRes()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerFieldForList("join_applys", getQualifiedClassName(VideoGuildJoinApply), Descriptor.Compound, 2);
			registerField("vgid", "", Descriptor.Int64, 3);
			registerField("result", "", Descriptor.Int32, 4);
			registerField("forbid_join_apply", "", Descriptor.TypeBoolean, 5);
			registerField("serial_id", "", Descriptor.Int32, 6);
		}
		
		public var player_id :Int64 = new Int64();
		public var join_applys : Array = new Array();
		public var vgid : Int64 = new Int64();
		public var result : int;
		public var forbid_join_apply : Boolean;
		public var serial_id :int;
	}
}
