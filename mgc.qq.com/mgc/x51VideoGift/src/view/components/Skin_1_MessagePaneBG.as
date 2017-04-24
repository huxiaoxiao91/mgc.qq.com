package view.components {

	import com.bit101.components.Component;

	import flash.display.DisplayObjectContainer;

	import model.DataProxy;

	/**
	 * 皮肤1礼物区背景
	 * @author gaolei
	 *
	 */
	public class Skin_1_MessagePaneBG extends Component {
		public function Skin_1_MessagePaneBG(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0) {
			super(parent, xpos, ypos);

			border_left = new Skin_1_MC_MessagePane_BG_Border();
			this.addChild(border_left);
			border_right = new Skin_1_MC_MessagePane_BG_Border();
			this.addChild(border_right);

			border_original_height = border_left.height;
		}

		private var border_left:Skin_1_MC_MessagePane_BG_Border;
		private var border_right:Skin_1_MC_MessagePane_BG_Border;

		private var border_original_height:int;

		override public function draw():void {
			super.draw();

			this.graphics.clear();
			this.graphics.beginFill(DataProxy.SKIN_1_MESSAGE_BG_COLOR, 0.66);
			this.graphics.drawRect(3, 0, width - 7, height);
			this.graphics.endFill();

			border_left.x = 3;
			border_right.x = width - 4;

			if (height + 60 >= border_original_height) {
				border_left.height = border_original_height;
				border_right.height = border_original_height;
			} else {
				border_left.height = height + 60;
				border_right.height = height + 60;
			}
		}
	}
}
