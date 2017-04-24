package com.h3d.qqx5.modules.dream_box.data
{
	import com.h3d.qqx5.util.Int64;

	public class DreamBoxForUI
	{
		public function DreamBoxForUI()
		{

		}
		public var box_id:String = "" ;	// 宝箱id
		public var  count_down:int;   // 倒计时时间
		public var  total_money:int;  // 总点券数量
		public var  has_grabbed:Boolean; // 是否领取过
	}
}