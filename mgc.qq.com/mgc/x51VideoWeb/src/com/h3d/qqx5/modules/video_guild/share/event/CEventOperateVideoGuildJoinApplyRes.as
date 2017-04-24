package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventOperateVideoGuildJoinApplyRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventOperateVideoGuildJoinApplyRes;
		}
		
		public function CEventOperateVideoGuildJoinApplyRes()
		{
			registerField("op_type", "", Descriptor.Int32, 1);
			registerField("result", "", Descriptor.Int32, 2);
			registerField("target_name", "", Descriptor.TypeString, 3);
			registerField("target_zname", "", Descriptor.TypeString, 4);
			registerField("trans_id", "", Descriptor.Int64, 5);
			registerField("player_id", "", Descriptor.Int64, 6);
			registerField("target_id", "", Descriptor.Int64, 7);
		}
		
		public var op_type : int;
		public var result : int;
		public var target_name : String = "";
		public var target_zname : String = "";
		public var trans_id : Int64 = new Int64();
		public var player_id : Int64 = new Int64();
		public var target_id:Int64 = new Int64();
	}
}
