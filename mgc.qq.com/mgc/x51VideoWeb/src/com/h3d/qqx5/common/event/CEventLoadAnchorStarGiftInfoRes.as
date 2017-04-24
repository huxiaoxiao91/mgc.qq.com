package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.video_rank_server.shared.StarGiftInfo;
	import com.h3d.qqx5.video_rank_server.shared.AnchorWeekStarMatchInfo;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventLoadAnchorStarGiftInfoRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventLoadAnchorStarGiftInfoRes;
		}
		
		public function CEventLoadAnchorStarGiftInfoRes()
		{
			registerField("m_anchor_id", "", Descriptor.Int64, 1);
			registerFieldForList("star_gift_info", getQualifiedClassName(StarGiftInfo), Descriptor.Compound, 2);
			registerField("match_info", getQualifiedClassName(AnchorWeekStarMatchInfo), Descriptor.Compound, 3);
		}
		
		public var m_anchor_id : Int64;
		public var star_gift_info : Array = [];
		public var match_info :AnchorWeekStarMatchInfo = new AnchorWeekStarMatchInfo();
	}
}