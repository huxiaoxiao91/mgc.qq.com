package com.h3d.qqx5.video_rank_server.shared
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	/**
	 * @author Administrator
	 */
	public class GuildRank extends ProtoBufSerializable
	{
		public function GuildRank()
		{
			registerField("guild_id", "", Descriptor.Int64, 1);
			registerField("score", "", Descriptor.Int32, 2);
			registerField("version", "", Descriptor.Int32, 3);
		}
		
		public var guild_id:Int64;
		public var  score:int;
		public var  version:int = 1;
	}	
}