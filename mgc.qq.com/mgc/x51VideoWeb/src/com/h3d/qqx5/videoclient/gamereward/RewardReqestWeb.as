package com.h3d.qqx5.videoclient.gamereward
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;

	public class RewardReqestWeb  extends ProtoBufSerializable
	{
		public function RewardReqestWeb()
		{
			registerField("type", "", Descriptor.Int32,1);      //奖励类型
			registerField("id", "", Descriptor.Int32,2);      //奖励id
			registerField("amount", "", Descriptor.Int32,3);      //奖励数量
			registerField("channel", "", Descriptor.Int32,4);      //奖励源
			registerField("rare", "", Descriptor.Int32,5);      //是否稀有
		}
		
		public var channel:int = 0;
		public var type:int = 0;
		public var id:int = 0;
		public var amount:int = 0;//为不需要请求数量描述信息
		public var rare:int = 0;
	}
}