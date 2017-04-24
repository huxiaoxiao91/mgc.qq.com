package com.bit101.utils
{
	import flash.events.Event;
	
	public class SelectFreeEvent extends Event
	{
		
		public static var SELECT_FREE:String = "SELECT_FREE";
		
		public var data:Object;
		
		public function SelectFreeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}