package com.h3d.video
{
	import com.bit101.components.Component;
	import com.bit101.components.Label;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * 顶部文字
	 * @author WJ
	 * 
	 */	
	public class TopBar extends Component
	{
		private var text_tip:Label;
		
		public function TopBar(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			
			initUI();
		}
		
		public function initUI():void
		{
			text_tip = new Label(this,0,0,"精彩互动正在进行，赶紧退出全屏去看看");	
			text_tip.autoSize = false;
			var tf:TextFormat = new TextFormat("微软雅黑",14,0xffffff); 
			tf.align = TextFormatAlign.CENTER;
			text_tip.textFormat = tf;
		}
		
		/**
		 * Sets the size of the component.
		 * @param w The width of the component.
		 * @param h The height of the component.
		 */
		override public function setSize(w:Number, h:Number):void
		{
			super.setSize(w, h);
			
			text_tip.setSize(w,24);
			
			this.graphics.clear();
			this.graphics.beginFill(0x000000,0.45);
			this.graphics.drawRect(0,0,width,height);
			this.graphics.endFill();
		}
	}
}