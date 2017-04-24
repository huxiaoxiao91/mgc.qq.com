package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.modules.video_guild.VideoGuildMemberInfo;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;

	public class CEventLoadDBVideoGuildMemberRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventLoadDBVideoGuildMemberRes;
		}
		
		public function CEventLoadDBVideoGuildMemberRes()
		{
			registerField("vg_id", "", Descriptor.Int64, 1);
			registerFieldForList("vg_members", getQualifiedClassName(VideoGuildMemberInfo), Descriptor.Compound, 2);
		}
		
		public var vg_id : Int64;
		public var vg_members : Array = new Array();
	}
}
