package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.VideoAnchorPKRank;
	import com.h3d.qqx5.common.event.eventid.AnchorPKEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	//主播PK总榜
	public class CEventRefreshAnchorPKRank extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorPKEventID.CLSID_CEventRefreshAnchorPKRank;
		}
		public function CEventRefreshAnchorPKRank()
		{
			registerField("m_room_id", "", Descriptor.Int32, 1);
			registerField("m_anchor_pk_value", "", Descriptor.Int64, 2);
			registerFieldForList("m_rank", getQualifiedClassName(VideoAnchorPKRank), Descriptor.Compound, 3);
		}

		//房间ID
		public var m_room_id:int;
		//当前主播PK值
		public var m_anchor_pk_value:Int64;
		//排行榜具体信息
		public var m_rank:Array;
	}
}
