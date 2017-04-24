package com.h3d.qqx5.util
{
	import flash.utils.getTimer;

	public class TimeUtil
	{
		public static const ONEDAY_HOURS:int		= 24;		///< 1天的小时数
		public static const ONEDAY_SECONDS : int = 86400;	///< 1天的秒数
		public static const ONE_HOUR_SECONDS   : int = 60 * 60;
		public static const ONE_MINUTE_SECONDS : int = 60;    
		public static const ONE_WEEK_SECONDS : int = 7 * 86400;      //一周的秒数
		public static const ONE_YEAR_MONTHS : int = 12;     ///< 一年的月份数
		public static const ONE_MINUTE_MS : int = 60*1000;	// 1分钟的毫秒数
		public static const ONE_SECOND_MS : int = 1000;      ///1秒钟的毫秒数
		
//		public static const MIN_TIME_T_VALUE ;
//		public static const MAX_TIME_T_VALUE ;
//		public static const MAX_TIME_T_VALUE_1 ;
//		
//		//时间零点对应的时刻
//		public static const HOUR_AT_ZERO_TIME : int = 8;	
//		public static const MIN_AT_ZERO_TIME : int = 0;
//		public static const SEC_AT_ZERO_TIME : int = 0;
//		
//		//时间零点距离当天0点的秒数
//		public static const SECONDS_OFFSET : int = HOUR_AT_ZERO_TIME * ONE_HOUR_SECONDS;
		
		public function TimeUtil()
		{
		}
		public static function IsSameWeek(t1:uint, t2:uint):Boolean
		{
			if(t1 < t2)
			{
				var tmp:uint = t2;
				t2= t1;
				t1 = tmp;		
			}
			
			var d:Date = new Date(t1 * 1000);
			if(null ==d)
			{
				return false ;
			}
			
			//调整周末
			var day:Number = (d.day == 0 ) ? 7 : d.day;
			
			//周一凌晨到现在的时间差值
			var differ:uint = (day- 1) * ONEDAY_SECONDS +
				d.hours * ONE_HOUR_SECONDS     +
				d.minutes * ONE_MINUTE_SECONDS    +
				d.seconds;
			
			var weekbegin:uint = t1 - differ;             //把时间调整每周的开始（周一早上0点）
			
			return((t2 >= weekbegin) && (t2 <= t1));
		}

	}
}