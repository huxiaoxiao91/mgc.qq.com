package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_guild.VideoGuildJoinApply;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;

	public class CEventLoadDBVideoGuildApplyRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventLoadDBVideoGuildApplyRes;
		}
		
		public function CEventLoadDBVideoGuildApplyRes()
		{
			registerField("result", "", Descriptor.Int32, 1);
			registerField("video_guild_id", "", Descriptor.Int64, 2);
			registerFieldForList("data_list", getQualifiedClassName(VideoGuildJoinApply), Descriptor.Compound, 3);
		}
		
		public var result :int;
		public var video_guild_id : Int64;
		public var data_list : Array = new Array();
	}
}
