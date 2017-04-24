package com.h3d.qqx5.modules.video_guild
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class VideoGuildLogRecord extends ProtoBufSerializable
	{
		public function VideoGuildLogRecord()
		{
			registerField("record_id_db", "", Descriptor.Int64, 1);
			registerField("video_guild_id_db", "", Descriptor.Int64, 2);
			registerField("recordTime", "", Descriptor.Int32, 3);
			registerField("msg", "", Descriptor.TypeString, 4);
			registerField("flag_db", "", Descriptor.Int32, 5);
		}
		
		public var record_id_db : Int64  = new Int64();
		public var video_guild_id_db : Int64  = new Int64();
		public var recordTime : int;
		public var msg : String = "";
		public var flag_db:int = 0;//标志，区分用于pc还是手机，亦或是web
	}
}
