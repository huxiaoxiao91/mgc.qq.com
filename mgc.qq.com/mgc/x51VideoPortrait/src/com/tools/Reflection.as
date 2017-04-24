package com.tools
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.display.GradientType;
	/**
	 * 反射倒影生成类...
	 */
	public class Reflection extends Sprite
	{
		private var _reflection:Bitmap;
		private var _bit:BitmapData;
		private var _mtx:Matrix;
		private var _rBox:Shape;
		private var _Alpha:BitmapData;

		public function Reflection($Target:DisplayObject,$Height:Number=200,$Alpha:Number=1,AddHeight:Number =0):void
		{
			_reflection = new Bitmap(getReflection($Target,$Height));//
			_reflection.smoothing = true;//平滑
			_reflection.alpha = $Alpha;
			addChild(_reflection);
			this.x = $Target.x;
			this.y = $Target.y + $Target.height + AddHeight;
		}
		private function getReflection(target:DisplayObject, Height:Number = -1):BitmapData
		{
			if (Height < 0)
			{
				Height = target.height;
			}
			_bit = new BitmapData(target.width,Height,true,0);
			_bit.draw(target, new Matrix(1, 0, 0, -1, 0, target.height));
			_mtx = new Matrix();
			_mtx.createGradientBox(target.width, Height, 0.5 * Math.PI);
			_rBox = new Shape();
			_rBox.graphics.beginGradientFill(GradientType.LINEAR, [0, 0], [0.5, 0], [0, 255], _mtx);
			_rBox.graphics.drawRect(0, 0, target.width, Height);
			_rBox.graphics.endFill();
			_Alpha = new BitmapData(target.width,Height,true,0);
			_Alpha.draw(_rBox);
			_bit.copyPixels(_bit, _bit.rect, new Point(0, 0), _Alpha, new Point(0, 0), false);
			return _bit.clone();
		}
	}
}