package com.h3d.qqx5.enum
{
	/**
	 * @author liuchui
	 */
	public class VideoChatChannel
	{
		public static const VIDEOCHNL_Public:int = 0; 
		public static const VIDEOCHNL_Private:int = 1; 
		public static const VIDEOCHNL_Whistle:int = 2; 
		public static const VIDEOCHNL_System:int = 3; 
		public static const VIDEOCHNL_Guild:int = 4;
		public static const VIDEOCHNL_SUPERSTARHORN:int = 5;
		
		public static function toVideoChatChannel(channel:int) : int
		{
			var videoChatChannel:int = 0;
			switch(channel)
			{
				case 32: // CHNL_VIDEOROOM_PRIVATE
					videoChatChannel = VideoChatChannel.VIDEOCHNL_Private;
					break;
				case 31: // CHNL_VIDEOROOM_WHISTLE
					videoChatChannel = VideoChatChannel.VIDEOCHNL_Whistle; 
					break;
				case 33: // CHNL_VIDEOROOM_GUILD
					videoChatChannel = VideoChatChannel.VIDEOCHNL_Guild;
					break;
				case 34: // CHNL_VIDEOROOM_SUPERSTARHORN
					videoChatChannel = VideoChatChannel.VIDEOCHNL_SUPERSTARHORN;
					break;
				case 30: // CHNL_VIDEOROOM_PUBLIC
				default:
					videoChatChannel = VideoChatChannel.VIDEOCHNL_Public;
					break;
			}
			return videoChatChannel;
		}
		
		public static function fromVideoChatChannel(channel:int) : int
		{
			var x5ChatChannel:int = 0;
			switch(channel)
			{
				case VideoChatChannel.VIDEOCHNL_Private:
					x5ChatChannel = 32; // CHNL_VIDEOROOM_PRIVATE
					break;
				case VideoChatChannel.VIDEOCHNL_Whistle:
					x5ChatChannel = 31; // CHNL_VIDEOROOM_WHISTLE
					break;
				case VideoChatChannel.VIDEOCHNL_Guild:
					x5ChatChannel = 33; // CHNL_VIDEOROOM_GUILD
					break;
				case VideoChatChannel.VIDEOCHNL_SUPERSTARHORN:
					x5ChatChannel = 34; // CHNL_VIDEOROOM_SUPERSTARHORN
					break;
				case VideoChatChannel.VIDEOCHNL_Public:
				case VideoChatChannel.VIDEOCHNL_System:
				default:
					x5ChatChannel = 30; // CHNL_VIDEOROOM_PUBLIC
					break;
			}
			return x5ChatChannel;
		}
	}	
}