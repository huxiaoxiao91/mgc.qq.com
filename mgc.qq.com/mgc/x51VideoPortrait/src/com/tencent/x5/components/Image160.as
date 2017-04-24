package com.tencent.x5.components
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;

	public class Image160 extends ImageView
	{
		private var _m:VIEWPVE1
		public function Image160()
		{
			super();
		}
		
		override protected function addChilded():void
		{
			// TODO Auto Generated method stub
			_m =new VIEWPVE1();
			addChild(_m)
			super.addChilded();
			this._mask.graphics.beginFill(0,.2);
			this._mask.graphics.drawCircle(80+6,80+5,80)
				this._bitmap.x = 6;
				this._bitmap.y = 5
			_bitmap.mask = _mask	
			
		}
		
		override public function set bitmapData(value:BitmapData):void
		{
			// TODO Auto Generated method stub
			super.bitmapData = value;
			_bitmap.bitmapData = bitmapData;
			_bitmap.smoothing =true;
			_bitmap.width = 160;
			_bitmap.height = 160;
			
		}
		
		override protected function draw():void
		{
			// TODO Auto Generated method stub
			super.draw();
		}
		
		
	}
}