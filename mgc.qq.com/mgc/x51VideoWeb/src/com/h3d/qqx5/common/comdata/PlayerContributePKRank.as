package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class PlayerContributePKRank extends ProtoBufSerializable
	{
		public function PlayerContributePKRank()
		{
			registerField("m_player_id", "", Descriptor.Int64, 1);
			registerField("m_pk_score", "", Descriptor.Int64, 2);
			registerField("m_wealth", "", Descriptor.Int64, 3);
			registerField("m_level", "", Descriptor.Int32, 4);
			registerField("m_onboard_time", "", Descriptor.Int32, 5);
			registerField("m_nick", "", Descriptor.TypeString, 6);
		}
		
		//玩家ID
		public var m_player_id:Int64;
		//玩家本场PK值
		public var m_pk_score:Int64;
		//玩家财富值
		public var m_wealth:Int64;
		//玩家等级
		public var m_level:int;
		//上榜时间
		public var m_onboard_time:int;
		//玩家昵称
		public var m_nick:String;
	}
}