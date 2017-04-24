package com.h3d.qqx5.util
{
	/**
	 * @author liuchui
	 */
	public class PersistIDUtil
	{
		public static function get_channel_id(pstid:Int64):int
		{
			var channel:int = (pstid.high >> 27);
			channel &= 0x0F;
			return channel;
		}
		
		public static function get_zone_id(pstid:Int64):int
		{
			var zone:int = (pstid.high >> 11);
			zone &= 0x0FFFF;
			return zone;
		}
		
		public static function get_account_id(pstid:Int64):uint
		{
			return pstid.low;
		}
		
		public static function get_gender(pstid:Int64):int
		{
			var c:int = pstid.high & 0x01;
			return c;
		}
	}	
}