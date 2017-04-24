package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.video_rank_server.shared.VideoVIPRank;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventRefreshVideoVIPRank extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventRefreshVideoVIPRank;
		}
		
		public function CEventRefreshVideoVIPRank()
		{
			registerFieldForList("rank", getQualifiedClassName(VideoVIPRank ), Descriptor.Compound, 1);
			registerField("req_rank_player", "", Descriptor.Int64, 2);
			registerField("total_size", "", Descriptor.Int32, 3);
			registerFieldForDict("id_to_rank_index","",Descriptor.Int64,"", Descriptor.Int32, 4);
		}
		
		public var rank : Array = new Array;
		public var req_rank_player : Int64;
		public var total_size : int;
		public var id_to_rank_index :Dictionary =new  Dictionary;
	}
}
