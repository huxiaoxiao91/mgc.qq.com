package com.h3d.qqx5.common.event
{
	import avmplus.getQualifiedClassName;
	
	import com.h3d.qqx5.common.event.eventid.HotboxSecretBoxLastHitPlayerEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.modules.surprise_box.share.RewardBasicItem;
	
	public class CEventNotifyLastHitPlayerReward extends INetMessage
	{
		public override function CLSID():int
		{
			return HotboxSecretBoxLastHitPlayerEventID.CLSID_CEventNotifyLastHitPlayerReward;
		}
		//当客户端完成教学任务时，发送对应的教学任务的flag,给服务器
		public function CEventNotifyLastHitPlayerReward()
		{
			registerFieldForList("rewards", getQualifiedClassName(RewardBasicItem), Descriptor.Compound, 1);//获得的奖励
		}
		public var rewards:Array;
	}
}