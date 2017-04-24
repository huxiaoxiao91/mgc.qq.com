package com.tencent.x5.components
{
	import flash.display.Shape;

	public class BackgroundUI extends Component
	{
		private var _background:Shape
		private var _line:Shape
		public function BackgroundUI()
		{
			super();
		}
		
		override protected function addChilded():void
		{
			// TODO Auto Generated method stub
			super.addChilded();
			_background = new Shape();
			addChild(_background);
			_line = new Shape()
			addChild(_line);
		}
		
		override protected function draw():void
		{
			// TODO Auto Generated method stub
			super.draw();
			_background.graphics.clear()
			_background.graphics.beginFill(0xfbfbfb)
			_background.graphics.drawRect(0,0,width,height);			
			_line.graphics.clear();
			_line.graphics.lineStyle(0,0xe4e0e9);
			_line.graphics.moveTo(490,82);
			_line.graphics.lineTo(490,470);
				
		}
		
		
	}
}