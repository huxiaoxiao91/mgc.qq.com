package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.display.StageScaleMode;
	
	public class Gif_skinGrab extends MovieClip {
		
		public function Gif_skinGrab() {
			this.gotoAndStop(1);
			this.visible = false;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void {
			ExternalInterface.addCallback("showGrabAni", showGrabAni);
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		private var aniIndex:int;
		public function showGrabAni(index:int):void {
			aniIndex = index;
			this.gotoAndPlay(1);
			this.visible = true;
			this.addEventListener(Event.ENTER_FRAME, onPlayAniEnterFrame);
		}
		private function onPlayAniEnterFrame(event:Event):void {
			if (this.currentFrame == this.totalFrames) {
				this.gotoAndStop(1);
				this.visible = false;
				this.removeEventListener(Event.ENTER_FRAME, onPlayAniEnterFrame);
				ExternalInterface.call("MGC_Comm.hideSkinGrabBlockAnimation", aniIndex);
			}
		}
	}
}
