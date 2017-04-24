package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.common.comdata.UserIdentity;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class GamePlayerJoinInfo extends ProtoBufSerializable
	{
		
		public function GamePlayerJoinInfo()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("name", "", Descriptor.TypeString, 2);
			registerField("sex", "", Descriptor.Int32, 3);
			registerField("level", "", Descriptor.Int32, 4);
			registerField("uid", getQualifiedClassName(UserIdentity), Descriptor.Compound, 5);
			registerField("zone_name", "", Descriptor.TypeString, 6);
			registerField("portrait_info", "", Descriptor.Int32, 8);
			registerField("diamond_info", "", Descriptor.Int32, 9);
		}
		
		public var player_id :Int64;
		public var name : String = "";
		public var sex : int;
		public var level : int;
		public var uid :UserIdentity = new UserIdentity;
		public var zone_name : String = "";
		public var portrait_info : int;
		public var diamond_info : int;
	}
}
