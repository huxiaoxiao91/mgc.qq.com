package com.h3d.qqx5.modules.rand_nick
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventGetRandNickRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return RandNickEventID.CLSID_CEventGetRandNickRes;
		}
		public function CEventGetRandNickRes()
		{
			registerField("nick_pool", "", Descriptor.Int32, 1);
			registerField("nick", "", Descriptor.TypeString, 2);
			registerField("nick_record_id", "", Descriptor.Int32, 3);
			
		}
		public var nick_pool : int;
		public var nick : String = "";
		public var nick_record_id:int;
	}
}