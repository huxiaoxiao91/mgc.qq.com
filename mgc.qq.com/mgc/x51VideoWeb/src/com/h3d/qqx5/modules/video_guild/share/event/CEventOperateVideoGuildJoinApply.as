package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventOperateVideoGuildJoinApply extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventOperateVideoGuildJoinApply;
		}
		
		public function CEventOperateVideoGuildJoinApply()
		{
			registerField("op_type", "", Descriptor.Int32, 1);
			registerField("target_id", "", Descriptor.Int64, 2);
			registerField("player_id", "", Descriptor.Int64, 3);
			registerField("vgid", "", Descriptor.Int64, 4);
			registerField("trans_id", "", Descriptor.Int64, 5);
			registerField("serial_id", "", Descriptor.Int32, 6);
		}
		
		public var op_type : int;
		public var target_id : Int64;
		public var player_id : Int64;
		public var vgid : Int64;
		public var trans_id : Int64;
		public var serial_id : int;
		
		public static const OVGJA_NONE:int   = 0;       //无效值
		public static const OVGJA_ACCEPT:int = 1;       //批准入团申请
		public static const OVGJA_REFUSE:int = 2;       //拒绝入团申请
	}
}
