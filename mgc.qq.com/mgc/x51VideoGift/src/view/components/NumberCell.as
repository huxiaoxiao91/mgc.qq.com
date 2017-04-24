package view.components {

	import com.bit101.components.Label;
	import com.bit101.components.ListItem;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.text.TextFormat;

	import model.DataProxy;

	public class NumberCell extends ListItem {
		private var text_num:Label;

		public function NumberCell(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, data:Object = null) {
			super(parent, xpos, ypos, data);

			initUI();
		}

		public function initUI():void {
			text_num = new Label(this);
			if (DataProxy.isCaveolaeBo && DataProxy.isSkinOpened) {
				if (DataProxy.skinId == DataProxy.SKIN_ID_2_SEA) {
					text_num.textFormat = new TextFormat("微软雅黑", 12, 0xffffff);
				} else {
					text_num.textFormat = new TextFormat("微软雅黑", 12, 0xfafafa);
				}
			} else {
				text_num.textFormat = new TextFormat("微软雅黑", 12, 0xfafafa);
			}
		}


		/**
		 * Draws the visual ui of the component.
		 */
		public override function draw():void {

			if (_data == null) {
				return;
			}
			this.mouseEnabled = true;
			this.buttonMode = true;
			/**
			 * 移除全部显示对象
			 */
			while (this.numChildren > 0) {
				var disObj:DisplayObject = this.removeChildAt(0);
				disObj = null;
			}

			graphics.clear();

			if (_mouseOver) {
				graphics.beginFill(0xde582e);
			} else {
				graphics.beginFill(_defaultColor, 0);
			}
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();

			text_num.text = _data.str;
			addChild(text_num);
		}
	}
}
