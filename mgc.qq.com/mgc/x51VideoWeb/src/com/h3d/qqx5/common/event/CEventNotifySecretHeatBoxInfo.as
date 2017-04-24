package com.h3d.qqx5.common.event
{
	import avmplus.getQualifiedClassName;
	
	import com.h3d.qqx5.common.event.eventid.HotboxSecretBoxLastHitPlayerEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventNotifySecretHeatBoxInfo extends INetMessage
	{
		public override function CLSID():int
		{
			return HotboxSecretBoxLastHitPlayerEventID.CLSID_CEventNotifySecretHeatBoxInfo;
		}
		//下发宝箱开启的差值，活动标题和活动内容
		public function CEventNotifySecretHeatBoxInfo()
		{
			registerFieldForList("diff_value", "", Descriptor.Int32, 1);////4个开启差值
			registerField("title", "", Descriptor.TypeString, 2);//活动标题
			registerField("content", "", Descriptor.TypeString, 3);//活动内容
		}
		public var diff_value:Array 	= 	new Array;
		public var title:String	= 	"";
		public var content:String	= 	"";
	}
}