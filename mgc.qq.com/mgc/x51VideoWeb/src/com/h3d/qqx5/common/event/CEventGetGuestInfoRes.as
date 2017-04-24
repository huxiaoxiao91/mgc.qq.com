package com.h3d.qqx5.common.event
{
		import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
		import com.h3d.qqx5.framework.network.Descriptor;
		import com.h3d.qqx5.framework.network.INetMessage;
		
		public class CEventGetGuestInfoRes extends INetMessage
		{
			public override function CLSID() : int
			{
				return EEventIDVideoRoomExt.CLSID_CEventGetGuestInfoRes;
			}
			
			public function CEventGetGuestInfoRes()
			{
				registerField("status", "", Descriptor.Int32, 1);// 0 成功 1 失败
				registerField("id", "", Descriptor.Int32, 2);// 游客账号id
				registerField("encrypt_identity", "", Descriptor.TypeString, 3);// key
			}
			
			public var status:int;
			public var id:int;
			public var encrypt_identity:String;
		}
}