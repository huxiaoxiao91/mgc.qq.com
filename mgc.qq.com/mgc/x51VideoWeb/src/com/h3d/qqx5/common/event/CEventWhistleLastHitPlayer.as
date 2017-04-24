package com.h3d.qqx5.common.event
{
	import avmplus.getQualifiedClassName;
	
	import com.h3d.qqx5.common.event.eventid.HotboxSecretBoxLastHitPlayerEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.modules.surprise_box.share.RewardBasicItem;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventWhistleLastHitPlayer extends INetMessage
	{
		public override function CLSID():int
		{
			return HotboxSecretBoxLastHitPlayerEventID.CLSID_CEventWhistleLastHitPlayer;
		}
		//当客户端完成教学任务时，发送对应的教学任务的flag,给服务器
		public function CEventWhistleLastHitPlayer()
		{
			registerField("guard_level","",Descriptor.Int32,1);//守护等级
			registerField("wealth_level","",Descriptor.Int32,2);//财富等级
			registerField("vip_level","",Descriptor.Int32,3);//vip等级
			registerField("nick_name","",Descriptor.TypeString,4);//昵称
			registerField("zone_name","",Descriptor.TypeString,5);//大区名
			registerField("text","",Descriptor.TypeString,6);//内容
			registerField("has_portrait","",Descriptor.Int32,7);//是否有头像
			registerField("player_pstid","",Descriptor.Int64,8);//补刀王id
			registerField("invisible","",Descriptor.TypeBoolean,9);//是否隐身
		}
		public var guard_level:int;
		public var wealth_level:int;
		public var vip_level:int;
		public var zone_name:String;
		public var nick_name:String;
		public var text:String;
		public var has_portrait:int;
		public var player_pstid:Int64;
		public var invisible : Boolean;
	}
}