package model.data
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * 
	 * 礼物数据模型
	 */
	public class FaceVO extends EventDispatcher
	{
		
		/**
		 * 表情id
		 */
		public var id:int;
		
		/**
		 * 表情名称
		 */
		public var name:String;
		
		/**
		 * 表情图标地址
		 */
		public var icon:String;
		
		/**
		 * 表情类型
		 * 1 活动 2 守护  3特权1 4特权2
		 */	
		public var type:int;
		
		public var props:Object;

		public function FaceVO()
		{
			
		}
		

	}
}