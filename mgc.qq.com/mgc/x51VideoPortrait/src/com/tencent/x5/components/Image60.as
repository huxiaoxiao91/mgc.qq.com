package com.tencent.x5.components
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	
	public class Image60 extends ImageView
	{
		private var _m:VIEWPVE2
		public function Image60()
		{
			super();
		}
		
		override protected function addChilded():void
		{
			// TODO Auto Generated method stub
			_m =new VIEWPVE2();
			addChild(_m)
			super.addChilded();
			this._mask.graphics.beginFill(0,.2);
			this._mask.graphics.drawCircle(30+5,30+5,30)
			this._bitmap.x = 5;
			this._bitmap.y = 5
			_bitmap.mask = _mask	
			
		}
		
		override public function set bitmapData(value:BitmapData):void
		{
			// TODO Auto Generated method stub
			super.bitmapData = value;
			_bitmap.bitmapData = bitmapData;
			_bitmap.smoothing =true;
			_bitmap.width = 60;
			_bitmap.height = 60;
			
		}
		
		override protected function draw():void
		{
			// TODO Auto Generated method stub
			super.draw();
		}
		
		
	}
}


