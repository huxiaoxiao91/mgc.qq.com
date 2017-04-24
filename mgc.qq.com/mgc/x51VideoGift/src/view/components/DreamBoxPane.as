package view.components
{
	import com.bit101.components.Image;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class DreamBoxPane extends Image
	{
		/*
		* 宝箱状态
		* 0:隐藏
		* 1:倒计时
		* 2:可领取
		* 3:已领取
		*/
		public var status:int = 0;
		
		public function DreamBoxPane(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0, source:Object=null)
		{
			super(parent, xpos, ypos, source);
			
			this.setSize(85,100);
			this.mouseEnabled = true;
			this.mouseChildren = true;
			
			super.addEventListener("Image.COMPLETE",completeHandler);
		}
		
		private function completeHandler(e:Event):void
		{
			super.loader.content.addEventListener("DreamBox.status",dreamBoxstatus);
		}
		
		private function dreamBoxstatus(e:Event):void
		{
			status = MovieClip(super.loader.content).status;
			
			if(status == 0)
			{
				if(super.contains(loader))
				{
					super.removeChild(loader);
				}
			}
			else
			{
				super.addChild(loader);
			}
			
			dispatchEvent(e);
		}
	}
}