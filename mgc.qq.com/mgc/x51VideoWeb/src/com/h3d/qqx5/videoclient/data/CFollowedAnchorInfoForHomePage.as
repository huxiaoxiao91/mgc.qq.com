package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CFollowedAnchorInfoForHomePage extends INetMessage
	{
		public function CFollowedAnchorInfoForHomePage()
		{
			registerField("m_anchor", "", Descriptor.Int64, 1);
			registerField("m_anchor_type", "", Descriptor.Int32, 2);
			registerField("m_anchor_nick", "", Descriptor.TypeString, 3);
			registerField("m_starlight", "", Descriptor.Int64, 4);
			registerField("m_videoroom_id", "", Descriptor.Int32, 5);
			registerField("m_status", "", Descriptor.Int32, 6);
			registerField("m_photo_url", "", Descriptor.TypeString, 7);
			registerField("m_nest_id", "", Descriptor.Int32, 8);
			registerField("affinity", "", Descriptor.Int32, 9);
			registerField("guard_level", "", Descriptor.Int32, 10);
			registerField("m_anchor_url", "", Descriptor.TypeString, 11);
			registerField("is_nest", "", Descriptor.TypeBoolean, 12);
			registerField("affinity_statistics", getQualifiedClassName(AnchorPlayerAffinityStatstics), Descriptor.Compound, 13);
			registerField("anchor_level", "", Descriptor.Int32, 14);
			
		}
		
		public var m_anchor:Int64 = new Int64(0,0);
		public var m_anchor_type:int;
		public var m_anchor_nick:String = "";
		public var m_starlight:uint;
		public var m_videoroom_id:int;
		public var m_status:int;
		public var m_photo_url:String= "";
		public var m_nest_id:int;
		public var affinity:int  =0  ;//默认值是0
		public var guard_level:int  ;
		public var is_nest:Boolean;//是否是在小窝中直播
		public var affinity_statistics:AnchorPlayerAffinityStatstics;
		public var anchor_level:int;//主播等级
		//uiinfo
		public var guardIcon:String ="";
		public var m_anchor_url:String = "";
	}
}