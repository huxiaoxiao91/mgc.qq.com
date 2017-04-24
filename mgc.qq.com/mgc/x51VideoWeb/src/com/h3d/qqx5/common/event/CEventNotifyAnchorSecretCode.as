package com.h3d.qqx5.common.event
{
	import avmplus.getQualifiedClassName;
	
	import com.h3d.qqx5.common.event.eventid.HotboxSecretBoxLastHitPlayerEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventNotifyAnchorSecretCode extends INetMessage
	{
		public override function CLSID():int
		{
			return HotboxSecretBoxLastHitPlayerEventID.CLSID_CEventNotifyAnchorSecretCode;
		}
		//下发主播设置（默认）的密令
		public function CEventNotifyAnchorSecretCode()
		{
			registerField("secret_code", "", Descriptor.TypeString, 1);//主播密令，没设置，则为默认
		}
		public var secret_code:String;
	}
}