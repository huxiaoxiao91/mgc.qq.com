package com.h3d.video
{
	import com.bit101.components.Component;
	import com.bit101.components.Label;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class StopPane extends Component
	{
		private var bg:MC_LoadingPane_1;
		
		private var mc_label:MC_LoadingPane_2;
		private var mc_label_1:MC_LoadingPane_2_1;
		
		private var label:Label;
		
		/**
		 * 是否分屏
		 */
		private var _isSplit:Boolean = false;
		
		public function StopPane(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			
			initUI();
		}
		
		public function initUI():void
		{
			mouseEnabled = mouseChildren = false;
			
			bg = new MC_LoadingPane_1();
			addChild(bg);
			
			mc_label = new MC_LoadingPane_2();
			mc_label.y = 80;
			addChild(mc_label);
			
			mc_label_1 = new MC_LoadingPane_2_1();
			mc_label_1.y = 80;
			addChild(mc_label_1);
			
			var tf:TextFormat = new TextFormat("微软雅黑",14,0x6712b3); 
			tf.align = TextFormatAlign.CENTER;
			label = new Label(this,0,200,"艺人正在赶来的路上，先逛逛其他直播间吧~",tf);	
			label.autoSize = false;
			
			isSplit = false;
			
		}
		
		/**
		 * 是否分屏
		 */
		public function get isSplit():Boolean
		{
			return _isSplit;
		}
		
		/**
		 * @private
		 */
		public function set isSplit(value:Boolean):void
		{
			_isSplit = value;
			
			if(isSplit)
			{
				mc_label.visible = false;
				mc_label_1.visible = true;
				label.text = "请等待主播发出分屏邀请";
			}
			else
			{
				mc_label.visible = true;
				mc_label_1.visible = false;
				label.text = "艺人正在赶来的路上，先逛逛其他直播间吧~";
			}
		}
		
		/**
		 * Sets the size of the component.
		 * @param w The width of the component.
		 * @param h The height of the component.
		 */
		override public function setSize(w:Number, h:Number):void
		{
			super.setSize(w, h);
			
			bg.width = w;
			bg.height = h;
			
			label.setSize(w,24);
			mc_label.x = (w - mc_label.width)/2;
			mc_label_1.x = (w - mc_label_1.width)/2;
			
			mc_label.y = (h - mc_label.height)/2 - 30;
			mc_label_1.y = (h - mc_label_1.height)/2 - 30;
			label.y = mc_label.y + mc_label.height + 10;
		}
		
	}
}