package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.data.AnchorPlayerAffinityStatstics;
	
	import flash.utils.getQualifiedClassName;

	public class FollowAnchorAffinityInfo extends ProtoBufSerializable
	{
		public function FollowAnchorAffinityInfo()
		{
			registerField("anchor_pstid", "", Descriptor.Int64, 1);
			registerField("anchor_name", "", Descriptor.TypeString, 2);
			registerField("affinity", "", Descriptor.Int32, 3);
			registerField("guard_level", "", Descriptor.Int32, 4);
			registerField("anchor_status", "", Descriptor.Int32, 5);
			registerField("room_id", "", Descriptor.Int32, 6);
			registerField("nest_id", "", Descriptor.Int32, 7);
			registerField("is_nest", "", Descriptor.TypeBoolean, 8);
			registerField("affinity_statistics", getQualifiedClassName(AnchorPlayerAffinityStatstics), Descriptor.Compound, 9);
			registerField("anchor_level", "", Descriptor.Int32, 10);
		}
		
		public var anchor_pstid : Int64;
		public var anchor_name : String = "";
		public var affinity : int;
		public var guard_level : int;
		public var anchor_status : int;
		public var room_id : int;
		public var nest_id : int;
		public var is_nest:Boolean;//是否在小窝中直播
		public var affinity_statistics:AnchorPlayerAffinityStatstics = new AnchorPlayerAffinityStatstics();
		public var anchor_level:int;//财富等级
	}
}
