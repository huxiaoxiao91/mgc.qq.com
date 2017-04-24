package com.h3d.qqx5.modules.rand_nick
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventGetRandNick extends INetMessage
	{
		public override function CLSID() : int
		{
			return RandNickEventID.CLSID_CEventGetRandNick;
		}
		public function CEventGetRandNick()
		{
			registerField("last_nick_pool", "", Descriptor.Int32, 1);
			registerField("nick_pool", "", Descriptor.Int32, 2);
			registerField("gender", "", Descriptor.Int32, 3);
		}
		public var nick_pool : int;// room server向db获得昵称时填写
		public var last_nick_pool : int;// 客户端传来的上次随机池id
		public var gender:int;
	}
}