package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.videoclient.data.DailySigninRewardContent;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventGetDailySigninRewardContentRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventGetDailySigninRewardContentRes;
		}
		public function CEventGetDailySigninRewardContentRes()
		{
			registerField("status", "", Descriptor.Int32, 1);
			registerField("content",getQualifiedClassName(DailySigninRewardContent), Descriptor.Compound, 2);
		}
		public var status : int;
		public var content : DailySigninRewardContent = new DailySigninRewardContent;
	}
}
