package com.tencent.x5.components
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;

	public class ImageView extends Component
	{
		protected var _bitmapData:BitmapData
		protected var _mask:Shape
		protected var _bitmap:Bitmap
		public function ImageView()
		{
			super();
		}
		
		public function get bitmapData():BitmapData
		{
			return _bitmapData;
		}

		public function set bitmapData(value:BitmapData):void
		{
			_bitmapData = value;
		}

		override protected function addChilded():void
		{
			// TODO Auto Generated method stub
			super.addChilded();
			_bitmap = new Bitmap();
			addChild(_bitmap);
			_mask = new Shape();
			addChild(_mask)
		}
		
		override protected function draw():void
		{
			// TODO Auto Generated method stub
			super.draw();
		}
		
		
	}
}