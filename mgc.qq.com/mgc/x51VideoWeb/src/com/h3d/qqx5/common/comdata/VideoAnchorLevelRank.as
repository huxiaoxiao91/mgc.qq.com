package com.h3d.qqx5.common.comdata
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class VideoAnchorLevelRank extends ProtoBufSerializable
	{
		public function VideoAnchorLevelRank()
		{
			registerField("anchor_id", "", Descriptor.Int64, 1);
			registerField("anchor_nick_str", "", Descriptor.TypeString, 2);
			registerField("level", "", Descriptor.Int32, 3);
			registerField("exp", "", Descriptor.Int32, 4);
			registerField("starlight", "", Descriptor.Int64, 5);
			registerField("anchor_status", "", Descriptor.Int32, 6);
			registerField("room_id", "", Descriptor.Int32, 7);
			registerField("anchor_url", "", Descriptor.TypeString, 8);
			registerField("anchor_gender", "", Descriptor.Int32, 9);
			registerField("record_id", "", Descriptor.Int32, 10);
		}
		public var anchor_id:Int64 = new Int64();
		public var anchor_nick_str:String;
		public var level:int;
		public var exp:int;
		public var starlight:Int64 = new Int64();
		public var anchor_status:int;
		public var room_id:int;
		public var anchor_url:String;
		public var anchor_gender:int;
		public var record_id:int;
	}
}