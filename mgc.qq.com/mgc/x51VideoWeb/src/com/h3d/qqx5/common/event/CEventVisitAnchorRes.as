package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.AnchorCard;
	import com.h3d.qqx5.common.event.eventid.VideoPersonalCardEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.video_service.serviceinf.AnchorImpressionDataServer;
	
	import flash.utils.getQualifiedClassName;

	public class CEventVisitAnchorRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoPersonalCardEventID.CLSID_CEventVisitAnchorRes;
		}
		
		public function CEventVisitAnchorRes()
		{
			registerField("player_id", "", Descriptor.Int64, 1);//请求者id
			registerField("video_server_id", "", Descriptor.Int32, 2);//如果是来自主播客户端，记录video server id
			registerField("res", "", Descriptor.Int32, 3);//返回状态
			registerField("card", getQualifiedClassName(AnchorCard), Descriptor.Compound, 4);//主播名片
			registerField("trans_id", "", Descriptor.Int64, 5);
			registerField("proxy_id", "", Descriptor.Int32, 6);
			registerField("tunnel_id", "", Descriptor.Int32, 7);
			registerField("serialid", "", Descriptor.Int32, 8);
			registerField("impressions", getQualifiedClassName(AnchorImpressionDataServer), Descriptor.Compound, 9);
			registerField("anchor_room", "", Descriptor.Int32, 10);//主播所在的房间
			registerField("total_anchor_exp", "", Descriptor.Int32, 11);//今天对当前主播通过送梦幻币礼物增加了多少经验值
			registerField("max_anchor_exp", "", Descriptor.Int32, 12);//每天通过送梦幻币礼物能够对主播增加的经验值上限
			registerField("is_follow", "", Descriptor.TypeBoolean, 13);//是否关注主播
		}
		
		public var player_id:Int64;
		public var video_server_id:int;
		public var res:int;
		public var card :AnchorCard = new AnchorCard;
		public var trans_id:Int64;
		public var proxy_id:int;
		public var tunnel_id : int;
		public var serialid : int;
		public var impressions :AnchorImpressionDataServer = new AnchorImpressionDataServer;
		public var anchor_room : int;
		public var total_anchor_exp : int;
		public var max_anchor_exp : int;
		public var is_follow : Boolean;
		
		public static const VAR_Succ:int = 0;
		public static const VAR_Fail:int =1;
		public static const VAR_Busy :int =2;
	}
}
