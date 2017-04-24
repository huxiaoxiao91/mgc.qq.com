package com.h3d.qqx5.videoclient.gamereward
{
		import com.h3d.qqx5.framework.network.Descriptor;
		import com.h3d.qqx5.framework.network.ProtoBufSerializable;
		
		public class RewardReqestWebCountRes extends ProtoBufSerializable
		{
			public function RewardReqestWebCountRes()
			{
				registerField("amount_desc", "", Descriptor.TypeString,1);      //奖励源
				
			}
			public var amount_desc:String = "";//图片地址
		}
}