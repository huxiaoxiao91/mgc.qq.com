package com.h3d.qqx5.common.event
{
	import avmplus.getQualifiedClassName;
	
	import com.h3d.qqx5.common.event.eventid.HotboxSecretBoxLastHitPlayerEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventFinishEducation extends INetMessage
	{
		public override function CLSID():int
		{
			return HotboxSecretBoxLastHitPlayerEventID.CLSID_CEventFinishEducation;
		}
		//当客户端完成教学任务时，发送对应的教学任务的flag,给服务器
		public function CEventFinishEducation()
		{
			registerField("flag", "", Descriptor.Int32, 1);//教学索引
		}
		public var flag:int;
	}
}