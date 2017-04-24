package com.h3d.video
{
	import com.bit101.components.Component;
	import com.bit101.components.HBox;
	import com.bit101.components.HSlider;
	import com.bit101.components.ProgressBar;
	import com.bit101.components.PushButton;
	
	import flash.display.DisplayObjectContainer;
	
	public class SoundBar extends Component
	{
		/**
		 * 静音按钮 
		 */		
		public var btn_mute:PushButton;
		
		/**
		 * 音量条
		 */		
		public var volumeBar:HSlider;
		
		public function SoundBar(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			
			initUI();
		}
		
		private function initUI():void
		{
			this.setSize(199,25);
			this.addChild(new MC_1());
			
			/*var hbox:HBox = new HBox(this);
			hbox.setSize(227,25);
			hbox.alignment = HBox.MIDDLE;*/
			
			btn_mute = new PushButton(this,10,6);
			btn_mute.setSize(20,12);
			btn_mute.toggle = true;
			btn_mute.upSkin = new MC_2_1();
			btn_mute.overSkin = new MC_2_2();
			btn_mute.downSkin = new MC_2_2();
			btn_mute.selectUpSkin = new MC_3_1();
			btn_mute.selectOverSkin = new MC_3_2();
			btn_mute.selectDownSkin = new MC_3_2();
			
			volumeBar = new HSlider(this,35,10);
			volumeBar.setSize(154,5);
			volumeBar.maximum = 100;
			volumeBar.value = 80;
			volumeBar.buttonMode = true;
			volumeBar.useHandCursor = true;
		}
		
		
	}
}