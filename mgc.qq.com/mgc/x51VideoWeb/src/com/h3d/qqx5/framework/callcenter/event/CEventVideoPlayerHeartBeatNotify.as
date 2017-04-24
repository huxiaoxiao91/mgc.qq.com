package com.h3d.qqx5.framework.callcenter.event
{
	import com.h3d.qqx5.common.comdata.UserIdentity;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	/**
	 * @author Administrator
	 */
	public class CEventVideoPlayerHeartBeatNotify extends INetMessage
	{
		public  override function CLSID() : int
		{
			return CallCenterMessageID.CLSID_CEventVideoPlayerHeartBeatNotify;
		}
		
		public function CEventVideoPlayerHeartBeatNotify()			
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
		}
		
		public var trans_id:Int64;
	}	
}