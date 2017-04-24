package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_guild.VideoGuildLogRecord;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventSaveVideoGuildLogToDB extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventSaveVideoGuildLogToDB;
		}
		
		public function CEventSaveVideoGuildLogToDB()
		{
			registerField("video_guild_id", "", Descriptor.Int64, 1);
			registerField("log_record", getQualifiedClassName(VideoGuildLogRecord), Descriptor.Compound, 2);
		}
		
		public var video_guild_id : Int64;
		public var log_record :VideoGuildLogRecord = new VideoGuildLogRecord;
	}
}
