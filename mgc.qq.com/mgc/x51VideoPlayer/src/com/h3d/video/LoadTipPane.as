package com.h3d.video
{
	import com.bit101.components.Component;
	import com.bit101.components.Label;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class LoadTipPane extends Component
	{
		private var label:Label;
		
		public function LoadTipPane(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			
			initUI();
		}
		
		public function initUI():void
		{
			mouseEnabled = mouseChildren = false;
	
			label = new Label(this,0,200,"网络不给力,正在努力加载中...");	
			label.autoSize = false;
			var tf:TextFormat = new TextFormat("微软雅黑",14,0xffffff); 
			tf.align = TextFormatAlign.CENTER;
			label.textFormat = tf;
			
		}
		
		/**
		 * Sets the size of the component.
		 * @param w The width of the component.
		 * @param h The height of the component.
		 */
		override public function setSize(w:Number, h:Number):void
		{
			super.setSize(w, h);
			
			graphics.clear();
			graphics.beginFill(0xffffff,0.2);
			graphics.drawRect(0,0,w,h);
			graphics.endFill();
			
			label.setSize(w,24);
			label.y = (h - label.height)/2;
		}
		
	}
}