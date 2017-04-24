package 
{

	import flash.display.MovieClip;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	import flash.events.Event;

	public class secret_order_flash extends MovieClip
	{

		private var status:int = 0;

		public function secret_order_flash()
		{
			Security.allowDomain("*");
			setBoxStatus(0);
			ExternalInterface.addCallback("setBoxStatus",setBoxStatus);
			
			this.addEventListener(Event.ENTER_FRAME,ef);
		}
		
		private function ef(e:Event){
			if(box_2.currentFrame == box_2.totalFrames)
			{
				setBoxStatus(0);
			}
		}


		public function setBoxStatus(_status:int)
		{
			if (_status == 0)
			{
				box_1.visible = true;
				box_2.visible = false;
			}
			else if (_status == 1)
			{
				if(status == 1)return;
				
				box_1.visible = false;
				box_2.visible = true;
				box_2.gotoAndPlay(1);
			}
			
			status = _status;
		}
	}

}