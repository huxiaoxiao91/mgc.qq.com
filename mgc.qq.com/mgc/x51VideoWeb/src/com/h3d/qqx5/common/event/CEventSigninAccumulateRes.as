package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.videoclient.data.CDailySiginReward;
	import com.h3d.qqx5.videoclient.data.DailySigninRewardContent;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventSigninAccumulateRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventSigninAccumulateRes;
		}
		public function CEventSigninAccumulateRes()
		{
			registerField("status", "", Descriptor.Int32, 1);
			registerField("accumulate_day", "", Descriptor.Int32, 2);
			registerField("content", getQualifiedClassName(DailySigninRewardContent), Descriptor.Compound, 3);
			registerField("mylevel", "", Descriptor.Int32, 4);
			registerField("m_is_reissue", "", Descriptor.TypeBoolean, 5);
			registerFieldForList("m_reward_list", getQualifiedClassName(CDailySiginReward), Descriptor.Compound, 6);
			
		}
		public var status : int;
		public var accumulate_day : int;
		public var content : DailySigninRewardContent = new DailySigninRewardContent;
		public var mylevel : int;
		public var m_is_reissue : Boolean;
		public var m_reward_list : Array = [];
	}
}
