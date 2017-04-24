package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_activity.VideoLevelRank;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	
	public class CEventLoadVideoLevelRankRes extends INetMessage	
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventLoadVideoLevelRankRes;
		}
		public function CEventLoadVideoLevelRankRes()
		{
			registerFieldForList("rank", getQualifiedClassName(VideoLevelRank), Descriptor.Compound, 1);
			registerField("req_rank_player", "", Descriptor.Int64, 2);
			registerField("total_size", "", Descriptor.Int32, 3);
			registerField("my_rank", "", Descriptor.Int32, 4);
		}
		public var rank : Array = new Array;
		public var req_rank_player : Int64;
		public var total_size : int;
		public var my_rank:int;
	}
}
