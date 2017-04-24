package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_guild.VideoGuildInfo;
	import com.h3d.qqx5.modules.video_guild.VideoGuildMemberBriefInfo;
	import com.h3d.qqx5.modules.video_guild.VideoGuildMemberInfo;
	import com.h3d.qqx5.modules.video_guild.VideoGuildPositionInfo;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	public class CEventLoadMyVideoGuildResult extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventLoadMyVideoGuildResult;
		}
		
		public function CEventLoadMyVideoGuildResult()
		{
			registerField("vg_info", getQualifiedClassName(VideoGuildInfo), Descriptor.Compound, 1);
			registerField("self_info", getQualifiedClassName(VideoGuildMemberInfo), Descriptor.Compound, 2);
			registerFieldForList("members", getQualifiedClassName(VideoGuildMemberBriefInfo), Descriptor.Compound, 3);
			registerFieldForDict("positions","",Descriptor.Int32,getQualifiedClassName(VideoGuildPositionInfo), Descriptor.Compound,  4);
			registerField("transid", "", Descriptor.Int64, 5);
			registerField("vg_id", "", Descriptor.Int64, 6);
			registerField("anchor_score", "", Descriptor.Int32, 7);
			registerField("anchor_rank", "", Descriptor.Int32, 8);
			registerField("result", "", Descriptor.Int32, 9);
			registerField("player_id", "", Descriptor.Int64, 10);
			registerField("rename_vg_cost", "", Descriptor.Int32, 11);
			registerField("change_anchor_cost", "", Descriptor.Int32, 12);
			registerField("dismiss_require", "", Descriptor.Int32, 13);
			registerField("notify_ui", "", Descriptor.TypeBoolean, 14);
			registerField("vg_url", "", Descriptor.TypeString, 15);
			registerField("notify_vg_name", "", Descriptor.TypeString,16); //本来这个字段是在进房间里的，web端需求差异在这里也加一个吧
			registerField("offline_become_member","",Descriptor.TypeBoolean, 17); //也是从进房间搬过来的
		}
		
		public var vg_info :VideoGuildInfo =new VideoGuildInfo;
		public var self_info :VideoGuildMemberInfo = new VideoGuildMemberInfo;
		public var members :Array =new Array();
		public var positions :Dictionary = new Dictionary();
		public var transid : Int64 = new Int64();
		public var vg_id : Int64 = new Int64();
		public var anchor_score : int;
		public var anchor_rank : int;
		public var result : int;
		public var player_id : Int64 = new Int64();
		public var rename_vg_cost : int;
		public var change_anchor_cost : int;
		public var dismiss_require : int;
		public var notify_ui : Boolean = true;
		public var vg_url : String = "";
		public var notify_vg_name:String = "";
		public var offline_become_member:Boolean;
	}
}
