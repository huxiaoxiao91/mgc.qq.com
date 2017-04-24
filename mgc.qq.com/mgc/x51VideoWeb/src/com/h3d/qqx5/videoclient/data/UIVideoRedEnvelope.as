package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.util.Int64;

	public class UIVideoRedEnvelope
	{
		public var m_publisher:String = "";// 发红包的人
		public var m_nick:String      = "";			// 昵称
		public var m_zone:String      = "";			// 大区名
		public var m_publish_time:int = 0;				// 发红包时间
		public var m_total_money:int  = 0;				// 红包总额度
		public var m_remain_money:int = 0;				// 红包剩余钱数
		public var m_divide_count:int = 0;				// 红包分发数量
		public var m_grabbers:Array   = new Array();	// 抢红包记录 std::vector<UIVideoRedEnvelopeGrabberInfo> 
		public var m_red_id:String    = "";	// 红包id
	}
}