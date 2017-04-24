package com.h3d.qqx5.common.event
{
	import avmplus.getQualifiedClassName;
	
	import com.h3d.qqx5.common.comdata.VideoAnchorPKRank;
	import com.h3d.qqx5.common.event.eventid.CommonActivityEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
		public class CEventCommonActivityPlayerRankModel extends ProtoBufSerializable
		{
			//拉取玩家贡献榜返回结果
			public function CEventCommonActivityPlayerRankModel()
			{
				registerField("m_score", "", Descriptor.Int64, 1);
				registerField("m_video_wealth_level", "", Descriptor.Int32, 2);
				registerField("m_player_nick", "", Descriptor.TypeString, 3);
			}
			//玩家给某个主播赠送的礼物数
			public var m_score : int;
			//财富等级
			public var m_video_wealth_level : int;
			//玩家昵称
			public var m_player_nick : String;
		}
}