package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class WeekStarPlayerContributeRank extends ProtoBufSerializable
	{
		public function WeekStarPlayerContributeRank()
		{
			registerField("anchor_id", "", Descriptor.Int64, 1);//id
			registerField("have_portrait", "", Descriptor.Int32, 2);
			registerField("player_contribution", "", Descriptor.Int32, 3);
			registerField("player_nick", "", Descriptor.TypeString, 4);
			registerField("player_pstid", "", Descriptor.Int64, 5);
			registerField("session", "", Descriptor.Int32, 6);
			registerField("player_portrait", "", Descriptor.TypeString, 7);
		}
		public var anchor_id : Int64;
		public var have_portrait : int;
		public var player_contribution : int;
		public var player_nick : String = "";
		public var player_pstid : Int64;
		public var session : int;
		public var player_portrait : String = "";
	}
}
