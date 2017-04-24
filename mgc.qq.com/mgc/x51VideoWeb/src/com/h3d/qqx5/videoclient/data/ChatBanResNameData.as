package com.h3d.qqx5.videoclient.data
{
	public class ChatBanResNameData
	{
		public function ChatBanResNameData(zoneName:String = "",nickName:String = "")
		{
			target_nickName = nickName;
			target_zoneName = zoneName;
		}
		public var target_nickName:String = "";
		public var target_zoneName:String = "";
	}
}