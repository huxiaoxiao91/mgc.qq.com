package com.h3d.qqx5.modules.video_activity.event
{

	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_activity.VideoActivityEventID;
	import com.h3d.qqx5.videoclient.data.CReward;
	
	import flash.sampler.getMasterString;
	import flash.utils.getQualifiedClassName;

	public class CEventTakeVideoActivityRewardsRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoActivityEventID.CLSID_CEventTakeVideoActivityRewardsRes;
		}
		public function CEventTakeVideoActivityRewardsRes()
		{
			registerField("activity_id", "", Descriptor.Int32, 1);
			registerField("activity_category", "", Descriptor.Int32, 2);
			registerField("res", "", Descriptor.Int32, 3);
			registerFieldForList("rewards",getQualifiedClassName(CReward), Descriptor.Compound, 4);
			registerField("level", "", Descriptor.Int32, 5);
			registerField("vip_level", "", Descriptor.Int32, 6);
			registerField("m_is_reissue", "", Descriptor.TypeBoolean, 7);
		}
		public var activity_id : int;
		public var activity_category : int;
		public var res : int;
		public var rewards : Array= [];
		public var level : int;
		public var vip_level : int;
		public var m_is_reissue : Boolean;
	}
}
