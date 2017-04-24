package view.components {

	import com.bit101.components.Component;
	
	import flash.display.DisplayObjectContainer;
	
	import model.DataProxy;

	/**
	 * 新皮肤2（海底世界）背景
	 * @author gaolei
	 *
	 */
	public class Skin_2_MessagePaneBG extends Component {
		public function Skin_2_MessagePaneBG(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0) {
			super(parent, xpos, ypos);

			border_left = new Skin_2_MessagePane_BG_Border();
			this.addChild(border_left);
			border_right = new Skin_2_MessagePane_BG_Border_Right();
			this.addChild(border_right);

			border_original_height = border_left.height;
		}

		private var border_left:Skin_2_MessagePane_BG_Border;
		private var border_right:Skin_2_MessagePane_BG_Border_Right;

		private var border_original_height:int;

		override public function draw():void {
			super.draw();

			this.graphics.clear();
			this.graphics.beginFill(DataProxy.SKIN_2_MESSAGE_BG_COLOR, 0.45);
			this.graphics.drawRect(3, 0, width - 6, height);
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
