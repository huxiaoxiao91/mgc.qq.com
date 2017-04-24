package com.tencent.x5.components
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Component extends Sprite
	{
		protected var _width:Number = 1;
		protected var _height:Number = 1
		public function Component()
		{
			super();
			init();
		}
		protected function init():void
		{

			addChilded()
			this.addEventListener(Event.ENTER_FRAME,onEnter);
		}
		
	
		public function remove():void
		{
			
		}
		protected function onEnter(event:Event):void
		{
			// TODO Auto-generated method stub
			this.removeEventListener(Event.ENTER_FRAME,onEnter);
			draw();
		}
		protected function draw():void
		{
		}
		protected function addChilded():void
		{
			// TODO Auto-generated method stub
		
		}
		override public function get width():Number
		{
			return _width;
		}

		override public function set width(value:Number):void
		{
			_width = value;
			draw()
		}

		override public function get height():Number
		{
			return _height;
		}

		override public function set height(value:Number):void
		{
			_height = value;
			draw();
		}
		

	}
}