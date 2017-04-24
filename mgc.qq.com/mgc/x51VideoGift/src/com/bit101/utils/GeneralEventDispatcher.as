package com.bit101.utils
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class GeneralEventDispatcher extends EventDispatcher
	{
		public function GeneralEventDispatcher(target:IEventDispatcher=null)
		{
			super(target);
			if (instance) {  
				throw new Error("只能用getInstance()来获取实例");  
			}
		}
		
		
		private static var instance:GeneralEventDispatcher;  /* 单例类实例 */
		
		public var isConcertPlay:Boolean = false;
		public var isConcert:Boolean = false;
		public static function getInstance():GeneralEventDispatcher
		{
			if (!instance) 
				instance = new GeneralEventDispatcher();
			
			return instance;
		}
	}
}