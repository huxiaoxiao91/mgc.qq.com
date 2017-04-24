package 
{
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;

	public class effect_luck extends MovieClip
	{

		private var index:int = 0;

		private var effectArr:Array = [];

		private var timer:Timer = new Timer(110);

		//stop start end
		private var status:String = "stop";

		//剩余的步数
		private var endNum:int = 0;

		public function effect_luck()
		{
			ExternalInterface.addCallback("startEffect",startEffect);
			ExternalInterface.addCallback("stopEffect",stopEffect);
			
			this.mouseChildren = false;
			this.mouseEnabled = false;

			for (var i:int = 0; i<this.numChildren; i++)
			{
				var mc:MovieClip = this["mc_" + i];
				effectArr.push(mc);
				mc.visible = false;
				mc.alpha = 1;
			}

			timer.addEventListener(TimerEvent.TIMER,timeHandler);
			timer.start();
		}

		private function startEffect():void
		{
			index = 0;
			hide();
			status = "start";
		}

		private function stopEffect(n:Number):void
		{
			endNum = int(n) - index;
			
			if(endNum < 0)
			{
				endNum = 12 + n - index;
			}

			status = "end";
		}

		private function hide():void
		{
			for (var i:int = 0; i<effectArr.length; i++)
			{
				effectArr[i].visible = false;
			}
		}

		private function timeHandler(e:TimerEvent):void
		{
			if (status == "start")
			{
				hide();
				
				nextIndex();

				effectArr[index].visible = true;
			}
			else if (status == "end")
			{
				if(endNum == 0)
				{
					status = "stop";
					ExternalInterface.call("window.mgc.luckyFlashStop");
					return;
				}
				
				endNum--;
				
				hide();
				
				nextIndex();

				effectArr[index].visible = true;
			}
		}

		private function nextIndex():void
		{
			index++;
			if (index == effectArr.length)
			{
				index = 0;
			}
		}

	}

}