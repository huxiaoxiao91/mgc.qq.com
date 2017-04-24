package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventVideoGuildOperateLogicLock extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildOperateLogicLock;
		}
		
		public function CEventVideoGuildOperateLogicLock()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("operate_type", "", Descriptor.Int32, 2);
			registerField("operate_reason", "", Descriptor.Int32, 3);
			registerField("trans_id", "", Descriptor.Int64, 4);
		}
		
		public var player_id : Int64;
		public var operate_type : int;
		public var operate_reason : int;
		public var trans_id : Int64;
	}
}
