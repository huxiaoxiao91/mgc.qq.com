package com.h3d.qqx5.common.specialevent
{
	import com.h3d.qqx5.common.comdata.VideoToClientChatMessage;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.NetBuffer;
	import com.h3d.qqx5.util.Int64;

	/**
	 * CEventVideoToClientChatMessageForWeb这个消息适用于发送广播类消息，发送给多人的，如公聊和后援团聊天，非发送者账号会收到这个消息。
	 * 其他情况都走的CEventVideoToClientChatMessage消息。
	 * @author gaolei
	 * 
	 */
	public class CEventVideoToClientChatMessageForWeb extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventVideoToClientChatMessageForWeb;
		}
		public function CEventVideoToClientChatMessageForWeb()
		{
			
		}
		
		public function LoadStream(from:NetBuffer):void
		{
			var index:int = 0;
			from.resetPosition();
			from.getInt();
			m_sender_id = from.getLong();
			m_sender_name = from.getString();
			m_recver_name = from.getString();
			m_sender_zoneName = from.getString();
			m_recver_zoneName = from.getString();
			m_message = from.getString();
			m_type = from.getInt();
			m_sender_type = from.getInt();
			m_receiver_type = from.getInt();
			m_vip_level = from.getInt();
			m_guard_level_new = from.getInt();
			m_credit_level =  from.getInt();
			m_wealth_level = from.getInt();
			m_add_anchor_exp = from.getInt();
		}
		
		public function GetMessage():VideoToClientChatMessage
		{
			var msg:VideoToClientChatMessage = new VideoToClientChatMessage();
			msg.sender_ID = this.m_sender_id;
			msg.receiver_ID = Int64.fromNumber(0);
			msg.sender_name = this.m_sender_name;
			msg.recver_name = this.m_recver_name;
			msg.sender_zoneName = this.m_sender_zoneName;
			msg.recver_zoneName = this.m_recver_zoneName;
			msg.message = this.m_message;
			msg.type = this.m_type;
		  //public var is_purple : int;
			msg.in_vip_seat = 0;
			msg.sender_type = this.m_sender_type;
			msg.receiver_type = this.m_receiver_type;
		  //public var roomid : int;
			msg.sender_jacket = 0;
		  //public var guard_level : int;
			msg.vip_level = this.m_vip_level;
			msg.is_free_whistle = false;
			msg.judge_type = 0;
			msg.videoguild_id = Int64.fromNumber(0);
			msg.sender_device_type = 0;
			msg.guard_level_new = this.m_guard_level_new;
			msg.invisible = false;
			msg.forbid_talk_all_room = false;
			msg.nest_assistant = false;
			msg.wealth_level = this.m_wealth_level;
			msg.add_anchor_exp = this.m_add_anchor_exp;
			return msg;
		}
		
		public var m_sender_id:Int64;
		public var m_sender_name:String;
		public var m_recver_name:String;
		public var m_sender_zoneName:String;
		public var m_recver_zoneName:String;
		public var m_message:String;
		public var m_type:int;
		public var m_sender_type:int;
		public var m_receiver_type:int;
		public var m_vip_level:int;
		public var m_guard_level_new:int;
		public var m_credit_level:int;
		public var m_wealth_level:int;//财富等级
		public var m_add_anchor_exp:int;//主播增加的经验
		
	}
}