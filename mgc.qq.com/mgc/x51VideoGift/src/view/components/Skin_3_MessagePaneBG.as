package view.components {

	import com.bit101.components.Component;

	import flash.display.DisplayObjectContainer;

	import model.DataProxy;

	/**
	 * 新皮肤3（游乐园）礼物区背景
	 * @author gaolei
	 *
	 */
	public class Skin_3_MessagePaneBG extends Component {
		public function Skin_3_MessagePaneBG(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0) {
			super(parent, xpos, ypos);
		}

		override public function draw():void {
			super.draw();

			this.graphics.clear();
			this.graphics.beginFill(DataProxy.SKIN_3_MESSAGE_BG_COLOR, 0.60);
			this.graphics.drawRect(3, 0, width - 6, height);
			this.graphics.endFill();
		}
	}
}
