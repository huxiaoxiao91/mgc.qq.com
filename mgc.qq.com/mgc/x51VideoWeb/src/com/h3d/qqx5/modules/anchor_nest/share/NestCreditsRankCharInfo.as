package com.h3d.qqx5.modules.anchor_nest.share
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class NestCreditsRankCharInfo extends ProtoBufSerializable
	{
		public function NestCreditsRankCharInfo()
		{
			registerField("pstid", "", Descriptor.Int64, 1);
			registerField("nick", "", Descriptor.TypeString, 2);
			registerField("sex", "", Descriptor.Int32, 3);
			registerField("credits", "", Descriptor.Int32, 4);
			registerField("credits_level", "", Descriptor.Int32, 5);
			registerField("online", "", Descriptor.TypeBoolean, 6);
			registerField("is_assistant", "", Descriptor.TypeBoolean, 7);
			registerField("guard_level", "", Descriptor.Int32, 8);
			registerField("video_vip_level", "", Descriptor.Int32, 9);
			registerField("zone_name", "", Descriptor.TypeString, 10);
			registerField("face_url", "", Descriptor.TypeString, 11);
			registerField("rank", "", Descriptor.Int32, 12);
		}
		public var pstid : Int64;
		public var nick : String;
		public var sex : int;
		public var credits : int;
		public var credits_level : int;
		public var online : Boolean;
		public var is_assistant : Boolean;
		public var guard_level : int;
		public var video_vip_level : int;
		public var zone_name : String;
		public var face_url : String;
		public var rank : int;
	}
}
