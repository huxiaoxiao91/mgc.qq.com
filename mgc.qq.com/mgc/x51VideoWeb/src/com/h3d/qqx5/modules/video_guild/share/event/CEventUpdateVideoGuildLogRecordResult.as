package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_guild.VideoGuildLogRecord;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventUpdateVideoGuildLogRecordResult extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventUpdateVideoGuildLogRecordResult;
		}
		
		public function CEventUpdateVideoGuildLogRecordResult()
		{
			registerField("result", "", Descriptor.Int32, 1);
			registerField("videoGuildId", "", Descriptor.Int64, 2);
			registerField("update_log", getQualifiedClassName(VideoGuildLogRecord), Descriptor.Compound, 3);
			registerField("player_id", "", Descriptor.Int64, 4);
			registerField("room_id", "", Descriptor.Int32, 5);
		}
		
		public var result : int;
		public var videoGuildId : Int64 = new Int64();
		public var update_log :VideoGuildLogRecord = new VideoGuildLogRecord; 
		public var player_id : Int64  = new Int64();
		public var room_id : int;
	}
}
