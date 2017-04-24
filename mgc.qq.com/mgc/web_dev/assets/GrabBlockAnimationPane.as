package {

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.system.Security;

	public class GrabBlockAnimationPane extends Sprite {
		public function GrabBlockAnimationPane() {
			super();
			Security.allowDomain("*");
			Security.allowInsecureDomain("*")
			
			//this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			ani_0.gotoAndStop(1);
			ani_1.gotoAndStop(1);
			ani_2.gotoAndStop(1);
			ani_3.gotoAndStop(1);
			ani_4.gotoAndStop(1);
			ani_5.gotoAndStop(1);
			ani_6.gotoAndStop(1);
			ani_7.gotoAndStop(1);
			ani_8.gotoAndStop(1);
			
			this.mouseChildren = false;
			this.mouseEnabled = false;
			
			onAddedToStage();
		}

		private static const ANI_AMOUNT:int = 9;

		public var ani_0:MovieClip;
		public var ani_1:MovieClip;
		public var ani_2:MovieClip;
		public var ani_3:MovieClip;
		public var ani_4:MovieClip;
		public var ani_5:MovieClip;
		public var ani_6:MovieClip;
		public var ani_7:MovieClip;
		public var ani_8:MovieClip;

		private function onAddedToStage(event:Event=null):void {
			//this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			if (ani_0.parent != null) {
				ani_0.parent.removeChild(ani_0);
			}
			if (ani_1.parent != null) {
				ani_1.parent.removeChild(ani_1);
			}
			if (ani_2.parent != null) {
				ani_2.parent.removeChild(ani_2);
			}

			if (ani_3.parent != null) {
				ani_3.parent.removeChild(ani_3);
			}
			if (ani_4.parent != null) {
				ani_4.parent.removeChild(ani_4);
			}
			if (ani_5.parent != null) {
				ani_5.parent.removeChild(ani_5);
			}

			if (ani_6.parent != null) {
				ani_6.parent.removeChild(ani_6);
			}
			if (ani_7.parent != null) {
				ani_7.parent.removeChild(ani_7);
			}
			if (ani_8.parent != null) {
				ani_8.parent.removeChild(ani_8);
			}
			
			ExternalInterface.addCallback("showGrabAni", showGrabAni);
			//ExternalInterface.call("alert", "showGrabAni completed");
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}

		public function showGrabAni(index:int):void {
			//ExternalInterface.call("alert", "showGrabAni index=" + index);
			if (index < 1 || index > ANI_AMOUNT) {
				return;
			} else {
				var selectedAni:MovieClip = this["ani_" + (index-1)];
				this.addChild(selectedAni);
				selectedAni.gotoAndPlay(1);

				if (this.hasEventListener(Event.ENTER_FRAME)) {
					this.removeEventListener(Event.ENTER_FRAME, onPlayAniEnterFrame);
				}
				this.addEventListener(Event.ENTER_FRAME, onPlayAniEnterFrame);
			}
		}

		private var isPlayAllAniEnd:Boolean = false;

		private function onPlayAniEnterFrame(event:Event):void {
			isPlayAllAniEnd = true;
			for (var i:int = 0; i < ANI_AMOUNT; i++) {
				var ani:MovieClip = this["ani_" + i];
				if (ani.parent != null) {
					if (ani.currentFrame != ani.totalFrames) {
						isPlayAllAniEnd = false;
					} else {
						ani.stop();
						ani.parent.removeChild(ani);
					}
				}
			}
			if (isPlayAllAniEnd) {
				this.removeEventListener(Event.ENTER_FRAME, onPlayAniEnterFrame);
				ExternalInterface.call.apply(null, ["MGC_Comm.hideGrabBlockAnimation"]);
			}
		}
	}
}
