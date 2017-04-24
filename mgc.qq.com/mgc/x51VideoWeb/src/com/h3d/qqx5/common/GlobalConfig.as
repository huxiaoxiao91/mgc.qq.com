package com.h3d.qqx5.common
{
	import com.h3d.qqx5.enum.ClientDeviceType;

	/**
	 * @author liuchui
	 */
	public class GlobalConfig
	{
		/**
		 * 客户端版本号
		 */	
		
		public static const Client_Version:int = MakeVideoClientVersion(3, 7, 7, 0);
		/**
		 * 视频web端的设备类型，暂使用手机的
		 */
		public static const WebDeviceType:int = ClientDeviceType.CDT_WEB;
		/**
		 * 视频web端的业务channel,0表示x51
		 */
		public static const WebChannelType:int = 0;
		public static const WebChannelTypeGuest:int = 1;
		
		private static function MakeVideoClientVersion(major:int, minor:int, revision:int, build:int):int
		{
			return (((major) << 24) | ((minor) << 16) | ((revision) << 8) | (build));
		}
	}	
}