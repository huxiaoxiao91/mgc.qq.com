package com.h3d.qqx5.videoclient.data
{
		import com.h3d.qqx5.framework.network.Descriptor;
		import com.h3d.qqx5.framework.network.ProtoBufSerializable;
		
		import flash.utils.Dictionary;
		import flash.utils.getQualifiedClassName;
		
		public class DailySigninRewardContent extends ProtoBufSerializable
		{
			public function DailySigninRewardContent()
			{
				registerField("accumulate_day", "",Descriptor.Int32,1);				
				registerField("year", "", Descriptor.Int32, 2);
				registerField("month", "", Descriptor.Int32, 3);
				registerFieldForDict("daily_rewards", "", Descriptor.Int32, getQualifiedClassName(DailySignInRewardList), Descriptor.Compound, 4);
				registerFieldForDict("accumulate_rewards", "", Descriptor.Int32, getQualifiedClassName(RewardBox), Descriptor.Compound, 5);
				registerField("is_signin_today", "", Descriptor.TypeBoolean, 6);
			}
			public var accumulate_day : int;
			public var year : int;
			public var month : int;
			public var daily_rewards : Dictionary = new Dictionary;
			public var accumulate_rewards : Dictionary = new Dictionary;
			public var is_signin_today:Boolean;
		}
}