package com.h3d.qqx5.videoclient.data
{
	public class ClientRedEnvelope
	{
		public var m_publish_time:int = 0;//发布时间
		public var m_red_id:String = "";//红包id
		public var m_nick:String = "";//发红包的玩家昵称
		public var m_zone:String = "";//发红包的玩家大区
		public var m_total_money:int = 0;//总钱数
		public var m_divide_count:int = 0;//分成的分数
		public var m_red_envelope_duration:int = 0;//标识大红包持续时间，单位为秒。
		public var m_small_red_envelope_duration:int = 0;//标识小红包持续时间，单位为秒。
	}
}