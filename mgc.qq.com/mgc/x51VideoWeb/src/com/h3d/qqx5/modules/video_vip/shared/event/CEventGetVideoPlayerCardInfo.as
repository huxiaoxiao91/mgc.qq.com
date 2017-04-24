package com.h3d.qqx5.modules.video_vip.shared.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventGetVideoPlayerCardInfo extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoVipEventID.CLSID_CEventGetVideoPlayerCardInfo;
		}
		
		public function CEventGetVideoPlayerCardInfo()
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("target_id", "", Descriptor.Int64, 3);
			registerFieldForList("followed_anchors", "", Descriptor.Int64, 4);
			registerField("room_id", "", Descriptor.Int32, 5);
			registerField("source", "", Descriptor.Int32, 6);
		}
		
		public var trans_id : Int64 = new Int64;
		public var player_id : Int64 = new Int64;
		public var target_id : Int64 = new Int64;//target_id传0，表示拉取自己的名片
		public var followed_anchors : Array = new Array;
		public var room_id : int;
		public var source : int;//从哪里拉取的名片    0:未知    1:玩家列表	 2:守护宝座    3:vip座位    4:超级粉丝榜    5:超级守护榜    6:聊天区    7:主播粉丝排名    8:后援团成员列表    9:自己的名片    10:送礼区    11:弹幕    12:vip进场特效    13:小窝房间捧场纪录     14：演唱会中奖纪录    15:排行榜

	}
}
