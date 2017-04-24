package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.PlayerContributePKRank;
	import com.h3d.qqx5.common.event.eventid.AnchorPKEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	//玩家贡献榜
	public class CEventRefreshPlayerContributePKRank extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorPKEventID.CLSID_CEventRefreshPlayerContributePKRank;
		}
		
		public function CEventRefreshPlayerContributePKRank()
		{
			registerField("m_room_id", "", Descriptor.Int32, 1);
			registerFieldForList("m_rank", getQualifiedClassName(PlayerContributePKRank), Descriptor.Compound, 2);
		}
		
		//房间ID
		public var m_room_id:int;
		//排行榜信息
		public var m_rank:Array;
	}
}
