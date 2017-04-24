package com.h3d.qqx5.framework.callcenter.event
{
	import com.h3d.qqx5.common.comdata.UserIdentity;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	/**
	 * @author Administrator
	 */
	public class CEventVideoReconnectVerifyReponse extends INetMessage
	{
		public  override function CLSID() : int
		{
			return CallCenterMessageID.CLSID_CEventVideoReconnectVerifyReponse;
		}
		
		public function CEventVideoReconnectVerifyReponse()			
		{
			registerField("res", "", Descriptor.Int32, 1);
			registerField("trans_id", "", Descriptor.Int64, 2);
			registerField("room_id", "", Descriptor.Int32, 3);
			registerField("vgid", "", Descriptor.Int64, 4);
		}
		
		public var res:int = 0;
		public var trans_id:Int64;
		public var room_id:int = 0;
		public var vgid:Int64;
		
		public function toString():String
		{
			return "[res:" + res + ",room_id:" + room_id + ",vgid:" + vgid + "]";
		}
	}	
}