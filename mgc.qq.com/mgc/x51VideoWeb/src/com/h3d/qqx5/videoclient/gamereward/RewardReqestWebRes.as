package com.h3d.qqx5.videoclient.gamereward
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;

	public class RewardReqestWebRes extends ProtoBufSerializable
	{
		public function RewardReqestWebRes()
		{
			registerField("type", "", Descriptor.Int32,1);      //奖励类型
			registerField("id", "", Descriptor.Int32,2);      //奖励id
			registerField("name", "", Descriptor.TypeString,3);      //名称
			registerField("tips", "", Descriptor.TypeString,4);      //描述
			registerField("url", "", Descriptor.TypeString,5);      //url
			registerField("amount", "", Descriptor.Int32,6);      //数量
			registerField("amount_desc", "", Descriptor.TypeString,7);      //数量描述
			registerField("channel", "", Descriptor.Int32,8);      // 奖励来源
			
		}
		
		public var id:int ;
		public var type:int ;
		public var amount:int ;
		public var url:String = "";//图片地址
		public var name:String = "";//名称
		public var tips:String = "";//tips
		public var amount_desc:String = "";
		public var channel:int;
	}
}