package com.h3d.video
{
	import com.bit101.components.TextArea;
	
	import flash.display.Sprite;
	import flash.text.TextFormat;
	
	public class InfoPane extends Sprite
	{
		public var text_info:TextArea;
		
		public function InfoPane()
		{
			text_info = new TextArea(this,0,0);
			text_info.autoHideScrollBar = true;
			text_info.setSize(240,180);
			text_info.textFormat = new TextFormat("Microsoft YaHei",12,0xff0000);
		}
		
		public function log(log:String):void
		{
			text_info.text = log;
		}
		
	}
}