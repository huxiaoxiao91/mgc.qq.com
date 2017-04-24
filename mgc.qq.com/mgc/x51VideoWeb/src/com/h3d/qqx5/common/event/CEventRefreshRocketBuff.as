package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.VideoAnchorPKRank;
	import com.h3d.qqx5.common.event.eventid.AnchorPKEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	//刷新火箭buff 主动下发
	public class CEventRefreshRocketBuff extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorPKEventID.CLSID_CEventRefreshRocketBuff;
		}
		public function CEventRefreshRocketBuff()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("buff_end_time", "", Descriptor.Int32, 2);
			registerField("buff_left_time", "", Descriptor.Int32, 3);
		}
		
		//房间id
		public var room_id:int;
		//秒
		public var buff_end_time:int;
		//剩余时间
        public var buff_left_time:int;
	}
}
