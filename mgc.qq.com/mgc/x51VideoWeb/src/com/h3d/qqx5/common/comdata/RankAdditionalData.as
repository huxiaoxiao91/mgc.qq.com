package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class RankAdditionalData extends ProtoBufSerializable
	{
		public function RankAdditionalData()
		{
			registerField("rank_score","", Descriptor.Int32, 1);
			registerField("operator_id", "", Descriptor.Int64, 2);
			registerField("music_index", "", Descriptor.Int32, 3);
			registerField("game_mode","", Descriptor.Int32, 4);
			registerField("session", "", Descriptor.Int32, 5);
		}
		public var rank_score : int = 0;
		public var operator_id : Int64 = new Int64();
		public var music_index : int = 0;
		public var game_mode : int = 0;
		public var session : int = 0;
	}
}
