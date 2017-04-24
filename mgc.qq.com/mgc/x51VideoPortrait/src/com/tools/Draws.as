package com.tools
{
	import flash.display.Sprite;
	import flash.display.Shape;

	/**
	*绘制格式图形类
	*@Author:xiaofeng
	*/
	public class Draws
	{
		public function Draws():void
		{
		}
		/**
		*绘制黑白格方法,X、Y：返回的Sprite对象的x轴和y轴坐标，Width、Height：返回的Sprite的总宽度以及高度，PixelSize：绘制格子的大小，以像素为单位
		*/
		public static function DrawLattice(X:Number = 0,Y:Number = 0,Width:int = 100,Height:int = 100,PixelSize:int = 5):Sprite
		{
			//管理小格子对象
			var LatticeCount:Sprite = new Sprite();
			//计算外层需要循环的次数
			var num:int = Height / PixelSize;
			//计算内层需要循环的次数
			var num2:int = Width / PixelSize;
			//保存颜色值，初始为白色
			var colors:uint = 0xFFFFFF;
			for (var i:int = 0; i<num; i++)
			{
				for (var j:int = 0; j<num2; j++)
				{
					var SmallLattice:Shape = new Shape();
					//判断颜色是黑还是白
					if(i % 2)
					{
						if(j % 2)
						{
							colors = 0xC0C0C0;
						}
						else
						{
							colors = 0xFFFFFF;
						}
					}
					else
					{
						if( j % 2)
						{
							colors = 0xFFFFFF;
						}
						else
						{
							colors = 0xC0C0C0;
						}
					}
					SmallLattice.graphics.beginFill(colors);
					SmallLattice.graphics.drawRect(X,Y,PixelSize,PixelSize);
					SmallLattice.graphics.endFill();
					LatticeCount.addChild(SmallLattice);
					SmallLattice.x = j * PixelSize;
					SmallLattice.y = i * PixelSize;
				}
			}
			return LatticeCount;
		}
		/**
		 * 绘制矩形线框方法
		 */
		public static function DrawRects(w:Number, h:Number):Sprite
		{
			var rect:Sprite = new Sprite();
			rect.graphics.beginFill(0xFFFFFF);
			rect.graphics.lineStyle(1, 0x000000);
			rect.graphics.drawRect(0, 0, w, h);
			rect.graphics.endFill();
			
			return rect;
		}
	}
}