package com.h3d.qqx5.framework.callcenter.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	
	/**
	 * @author Administrator
	 */
	public class CEventClientConnectRoomProxyTransResult extends INetMessage
	{
		public  override function CLSID() : int
		{
			return CallCenterMessageID.CLSID_CEventClientConnectRoomProxyTransResult;
		}
		
		public function CEventClientConnectRoomProxyTransResult()			
		{
			registerField("res", "", Descriptor.Int32, 1);
			registerField("trans_id", "", Descriptor.Int64, 2);
		}
		
		public var res:int = 0;
		public var trans_id:Int64;
	}	
}