package com.h3d.qqx5.videoclient.data
{
	import flash.utils.getQualifiedClassName;
	
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	public class DailySignInRewardList extends ProtoBufSerializable
	{
		public function DailySignInRewardList()
		{
			registerFieldForList("rewards", getQualifiedClassName(CDailySiginReward),Descriptor.Compound,1);
		}
		
		override public function isPureContainerWrapper():Boolean	
		{
			return true;
		}
		public var rewards:Array = new Array();
	}
}