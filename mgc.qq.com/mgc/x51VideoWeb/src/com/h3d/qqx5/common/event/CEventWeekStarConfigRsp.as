package com.h3d.qqx5.common.event
{
	import avmplus.getQualifiedClassName;
	
	import com.h3d.qqx5.common.event.eventid.WeekStarEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventWeekStarConfigRsp  extends INetMessage
	{
		public override function CLSID():int
		{
			return WeekStarEventID.CLSID_CEventWeekStarConfigRsp ;
		}
		//下发宝箱开启的差值，活动标题和活动内容
		public function CEventWeekStarConfigRsp()
		{
			registerField("anchor_url", "", Descriptor.TypeString, 1);//主播的url
			registerField("player_url", "", Descriptor.TypeString, 2);//玩家的url
		}
		public var anchor_url:String;
		public var player_url:String;
	}
}