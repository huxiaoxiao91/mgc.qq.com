package com.tencent.x5.components
{
	import com.tools.CutImage;
	import com.tools.Draws;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;

	public class Interface extends Sprite
	{
		public var grayPlaid:Sprite;
		public var image:Sprite;
		private var _bitmap:Bitmap;
		private var _bitmapData:BitmapData;
		private var bounds:EditBounds;
		private var alphaMask:Sprite;
		private var obj:Sprite;
		public function Interface():void
		{
			var backGround:VIEWPIC = new VIEWPIC();
			this.addChild(backGround);
			UIInit();
		}
		

		public function UIInit():void
		{
			grayPlaid = new Sprite();
			this.addChild(grayPlaid);
			var Mask:Shape = new Shape();
			Mask.graphics.beginFill(0x000000);
			Mask.graphics.drawRect(0,0,300,300);
			Mask.graphics.endFill();
			this.addChild(Mask);
			grayPlaid.mask = Mask;
			image = new Sprite();
			grayPlaid.addChild(image);
			_bitmap = new Bitmap();
			image.addChild(_bitmap);
		}
		
		
		private function updateShow():void
		{
			if(alphaMask && this.contains(alphaMask))
			{
				this.removeChild(alphaMask);
			}
			
			if(bounds && this.contains(bounds))
			{
				bounds.removeEventListener("draw",draw);
				this.removeChild(bounds);
			}
			
			alphaMask = new Sprite();
			alphaMask.graphics.beginFill(0x000000,0.5);
			alphaMask.graphics.drawRect(_bitmap.x,_bitmap.y,_bitmap.width,_bitmap.height);
			alphaMask.graphics.endFill();
			this.addChild(alphaMask);
			obj = new Sprite();
			obj.graphics.beginFill(0xFFFFFF);
			obj.graphics.drawRect(0,0,160,160);
			obj.graphics.endFill();
			obj.x = _bitmap.x  + (_bitmap.width - 140)/2;
			obj.y = _bitmap.y + (_bitmap.height - 140)/2 ;
			alphaMask.blendMode = BlendMode.LAYER;
			alphaMask.addChild(obj);
			obj.blendMode = BlendMode.ERASE;
			bounds = new EditBounds();
			bounds.addEventListener("draw",draw);
			bounds.target = obj;
			this.addChild(bounds);
			bounds.maxWidth = _bitmap.width;
			bounds.maxHeight = _bitmap.height;
			bounds.minWidth = 8;
			bounds.minHeight = 7;
			if(image.width < 60 || image.height < 60)
			{
				setBoundsSize();
			}
			CalculateBounds();
			bounds.dispatchEvent(new Event("draw"));
		}
		
		public var cutbitmapdata:BitmapData;
		private function draw(e:Event):void
		{
			cutbitmapdata = CutImage.cutOutSuper(image,obj);
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function CalculateBounds():void
		{
			var numx:Number = _bitmap.x ;
			var numy:Number = _bitmap.y
			var numw:Number = _bitmap.width + numx;
			var numh:Number = _bitmap.height + numy;
			
			this.bounds.selectBounds = new Rectangle(numx,numy,numw,numh);
		}
		
		private function setBoundsSize():void
		{
			if(image.width != image.height)
			{
				this.obj.width = this.obj.height = 50;
				this.obj.x = 0;
				this.obj.y = 0;
				this.bounds.target = this.obj;
			}
		}
		
		public function get bitmapData():BitmapData
		{
			return _bitmapData;
		}
		
		public function set bitmapData(value:BitmapData):void
		{
			
			if (_bitmapData)
			{
				_bitmapData.dispose()
			}
			
			_bitmapData = value;
			_bitmap.bitmapData = value;
			_bitmap.smoothing = true;
			_bitmap.scaleX = _bitmap.scaleY =1;
			var tf:Number = 0;
			if (_bitmap.width >_bitmap.height)
			{
				tf = 300/_bitmap.width;
			}else 
			{
				tf = 300/_bitmap.height
			}
			
			_bitmap.scaleX = _bitmap.scaleY = tf;
			
			
			if(_bitmap.width < 160)
			{
				_bitmap.width = 300;
			}
			
			if(_bitmap.height < 160)
			{
				_bitmap.height = 300;
			}
			
			_bitmap.x =(300 - _bitmap.width)/2;
			_bitmap.y = (300 -_bitmap.height)/2;
			
			updateShow();
		}

	}
}