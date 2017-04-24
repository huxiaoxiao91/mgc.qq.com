package com.h3d.qqx5.common.event
{
	import avmplus.getQualifiedClassName;
	
	import com.h3d.qqx5.common.event.eventid.HotboxSecretBoxLastHitPlayerEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventNotifyPlayerSecretHeatBox extends INetMessage
	{
		public override function CLSID():int
		{
			return HotboxSecretBoxLastHitPlayerEventID.CLSID_CEventNotifyPlayerSecretHeatBox;
		}
		//当客户端完成教学任务时，发送对应的教学任务的flag,给服务器
		public function CEventNotifyPlayerSecretHeatBox()
		{
			registerField("last_seconds", "", Descriptor.Int32, 1);//剩余的秒数
			registerField("end_time", "", Descriptor.Int32, 2);//结束的时间戳?
			registerField("box_id", "", Descriptor.Int32, 3);//宝箱id
		}
		public var last_seconds : int;
		public var end_time : int;
		public var box_id : int;
	}
}