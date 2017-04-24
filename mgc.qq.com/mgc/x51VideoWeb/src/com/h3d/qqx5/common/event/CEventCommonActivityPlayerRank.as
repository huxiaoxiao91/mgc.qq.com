package com.h3d.qqx5.common.event
{
	import avmplus.getQualifiedClassName;
	
	import com.h3d.qqx5.common.comdata.VideoAnchorPKRank;
	import com.h3d.qqx5.common.event.eventid.CommonActivityEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class CEventCommonActivityPlayerRank extends INetMessage
	{
		public override function CLSID():int
		{
			return CommonActivityEventID.CLSID_CEventCommonActivityPlayerRank;
		}
		//拉取玩家贡献榜返回结果
		public function CEventCommonActivityPlayerRank()
		{
			registerFieldForList("m_rank", getQualifiedClassName(CEventCommonActivityPlayerRankModel), Descriptor.Compound, 1);
		}
		public var m_rank:Array;
	}
}