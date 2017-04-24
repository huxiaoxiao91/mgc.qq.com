package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.VideoAnchorLevelRank;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventRefreshAnchorLevelRank extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventRefreshAnchorLevelRank;
		}
		public function CEventRefreshAnchorLevelRank()
		{
			registerFieldForList("rank_vec", getQualifiedClassName(VideoAnchorLevelRank), Descriptor.Compound, 1);
		}
		public var rank_vec:Array;
	}
}