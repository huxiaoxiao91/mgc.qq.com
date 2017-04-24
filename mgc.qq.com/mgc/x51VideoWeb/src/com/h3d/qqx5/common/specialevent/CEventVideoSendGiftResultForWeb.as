package com.h3d.qqx5.common.specialevent
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.NetBuffer;
	import com.h3d.qqx5.util.Int64;
	
	/**
	 * 待定、暂时未使用，跟数据时发现使用的是CEventVideoSendGiftResult。
	 * @author 
	 * 
	 */	
	public class CEventVideoSendGiftResultForWeb extends INetMessage
	{
		public function CEventVideoSendGiftResultForWeb()
		{

		}
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventVideoSendGiftResultForWeb;
		}
		
		public function LoadStream(from:NetBuffer):void
		{
			var index:int = 0;
			from.resetPosition();
			from.getInt();
			m_result = from.getInt();
			m_sender_id = from.getLong();
			m_gift_id = from.getInt();
			m_gift_count = from.getInt();
			m_anchor_qq = from.getLong();
			m_zone_name = from.getString();
			m_sender_name = from.getString();
			m_anchor_name = from.getString();
			m_anchor_pstid = from.getLong();
			m_anchor_starlight = from.getInt();
			m_anchor_popularity = from.getInt();
			m_anchor_followed = from.getInt();
			m_gift_name = from.getString();
			m_vip_level = from.getInt();
			m_trans_id = from.getLong();
			m_diamond_balance = from.getInt();
			m_res_ext = from.getInt();
			m_reason_ext = from.getString();
			m_support_degree_add =from.getInt();
			m_invisible = from.getBoolean();
			m_video_money = from.getInt();
			m_guard_level = from.getInt();
			m_credit_level = from.getInt();
			m_continuous_send_gift_times = from.getInt();
			anchor_exp = from.getInt();
			wealth_level = from.getInt();
			source = from.getInt();
			
			m_gift_ext_info = new NetBuffer();
			from.buffer().readBytes(m_gift_ext_info.buffer());
		}
		
		public var result:int;
		public var m_result:int;
		public var m_sender_id:Int64;
		public var m_gift_id:int;
		public var m_gift_count:int;
		public var m_anchor_qq:Int64;
		public var m_zone_name:String;
		public var m_sender_name:String;
		public var m_anchor_name:String;
		public var m_anchor_pstid:Int64;
		public var m_anchor_starlight:int;
		public var m_anchor_popularity:int;
		public var m_anchor_followed:int;
		public var m_gift_name:String;
		public var m_vip_level:int;
		public var m_trans_id:Int64;
		public var m_diamond_balance:int;
		public var m_res_ext:int;
		public var m_reason_ext:String;
		public var m_support_degree_add:int;
		public var m_invisible:Boolean;
		public var m_video_money:int;
		public var m_guard_level:int;
		public var m_credit_level:int;
		public var m_continuous_send_gift_times:int;
		public var anchor_exp:int;//本次送礼增加了多少主播经验值
		public var wealth_level:int;//财富等级
		/**
		 * 礼物来源
		 */
		public var source:int;
		public var m_gift_ext_info:NetBuffer;
		
		//VideoGiftSource
		public static const VGS_SEND:int       = 0;
		public static const VGS_LUCKY_DRAW:int = 1;
	}
}