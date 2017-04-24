package com.h3d.qqx5.util
{
	/**
	 * @author liuchui
	 */
	public class NumberUtil
	{
		private static const MAX_LOW:Number = 4294967296.0;
		
		public function NumberUtil()
		{
			
		}
		
		public static function GetLow(n:Number):uint
		{
			return Math.floor(n % MAX_LOW);
		}
		
		public static function GetHigh(n:Number):int
		{
			return Math.floor(n / MAX_LOW);
		}
		
		public static function MakeNumber(low:uint, high:int):Number
		{
			return high * MAX_LOW + low;
		}
	}	
}