package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_activity.VideoRichRank;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	public class CEventRefreshVideoRichRank extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventRefreshVideoRichRank;
		}
		public function CEventRefreshVideoRichRank()
		{
			registerFieldForList("rank", getQualifiedClassName(VideoRichRank), Descriptor.Compound, 1);
			registerField("req_rank_player", "", Descriptor.Int64, 2);
			registerField("total_size", "", Descriptor.Int32, 3);
			registerFieldForDict("id_to_rank_index", "", Descriptor.Int64, "", Descriptor.Int32, 4);
			registerField("weath", "", Descriptor.Int64, 5);
			registerFieldForList("portrait", "",Descriptor.TypeString , 6);
			registerField("rank_timedimension", "", Descriptor.Int32, 7);
		}
		public var rank : Array = new Array;
		public var req_rank_player : Int64 = new Int64();
		public var total_size : int;
		public var id_to_rank_index : Dictionary = new Dictionary;		
		public var weath:Int64 = new Int64();
		public var portrait:Array = new Array();//只有移动端用到
		public var rank_timedimension:int;//时间维度
	}
}
