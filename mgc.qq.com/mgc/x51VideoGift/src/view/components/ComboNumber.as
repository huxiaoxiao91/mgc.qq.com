package view.components
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	
	import gs.TweenLite;
	import gs.easing.Elastic;
	import gs.easing.Linear;
	import gs.easing.Quart;
	
	public class ComboNumber extends Sprite
	{
		/*
		 *连送数量
		 */
		private var _num:int;
		
		private var bitmap:Bitmap = new Bitmap();
		
		static private var mcArr:Array = 
			[ComboWord,
			ComboNumber_0,
			ComboNumber_1,
			ComboNumber_2,
			ComboNumber_3,
			ComboNumber_4,
			ComboNumber_5,
			ComboNumber_6,
			ComboNumber_7,
			ComboNumber_8,
			ComboNumber_9];
		
		public function ComboNumber()
		{
			/*num = _num;	
			
			var bitmapData:BitmapData = new BitmapData(150,28,true,0);
			var bd:BitmapData = new ComboWord();
			bitmapData.copyPixels(bd,new Rectangle(0,0,28,28),new Point(0,0));
			
			var numStr:String = String(num);
			for(var i:int = 0;i < numStr.length;i++)
			{
				var str:String = numStr.substr(i,1);
				var c:Class = getDefinitionByName("ComboNumber_" + str) as Class;
				bd = new c();
				bitmapData.copyPixels(bd,new Rectangle(0,0,18,23),new Point(28 + 18*i,0));
			}
			
			bitmap.bitmapData = bitmapData;
			bitmap.x = -bitmap.width * 5/4;
			bitmap.y = -bitmap.height * 5/4;
			addChild(bitmap);
			
			bitmap.scaleX = bitmap.scaleY = 5;
			
			bitmap.visible = false;
			TweenLite.to(bitmap,0.3,{onComplete:onComplete});*/
			
		}
		
		public function get num():int
		{
			return _num;
		}

		public function set num(value:int):void
		{
			_num = value;
			
			bitmap.visible = false;
			
			if(num <= 1)return;
			
			var bitmapData:BitmapData = new BitmapData(150,28,true,0);
			var bd:BitmapData = new ComboWord();
			bitmapData.copyPixels(bd,new Rectangle(0,0,28,28),new Point(0,0));
			
			var numStr:String = String(num);
			for(var i:int = 0;i < numStr.length;i++)
			{
				var str:String = numStr.substr(i,1);
				var c:Class = getDefinitionByName("ComboNumber_" + str) as Class;
				bd = new c();
				bitmapData.copyPixels(bd,new Rectangle(0,0,18,23),new Point(28 + 18*i,0));
			}
			
			bitmap.bitmapData = bitmapData;
			bitmap.x = -bitmap.width * 5/4;
			bitmap.y = -bitmap.height * 5/4;
			addChild(bitmap);
			
			bitmap.scaleX = bitmap.scaleY = 5;
			
			TweenLite.to(bitmap,0.3,{onComplete:onComplete});
		}

		private function onComplete():void
		{
			bitmap.visible = true;
			TweenLite.to(bitmap,0.3,{x:0,y:0,scaleX:1,scaleY:1,ease:Quart.easeOut});
		}
	}
}