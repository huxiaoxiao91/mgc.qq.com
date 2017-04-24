package view.components {

	import com.bit101.components.Component;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;

	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.text.TextFormat;

	import model.DataProxy;
	import model.data.FacePaneVO;

	/**
	 * 表情面板
	 * @author gaolei
	 *
	 */
	public class FacePane extends Component {
		public var vo:FacePaneVO;

		public var list:PageList;

		public var tab1:PushButton;
		public var tab2:PushButton;

		public var tab3:PushButton;
		public var tab4:PushButton;

		public var btn_left:PushButton;
		public var btn_right:PushButton;

		public var text_page:Label;

		//背景
		private var background:Shape;

		public function FacePane(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0) {
			super(parent, xpos, ypos);

			initUI();
		}

		public function initUI():void {
			this.visible = false;
			this.setSize(295, 195);

			tab1 = new PushButton(this, 0, 1);
			tab1.toggle = true;
			tab1.setSize(68, 41);
			tab1.addEventListener(MouseEvent.CLICK, tab1_Click);

			tab2 = new PushButton(this, 63, 1);
			tab2.toggle = true;
			tab2.setSize(84, 41);
			tab2.addEventListener(MouseEvent.CLICK, tab2_Click);

			tab3 = new PushButton(this, 142, 1);
			tab3.toggle = true;
			tab3.setSize(68, 41);
			tab3.addEventListener(MouseEvent.CLICK, tab3_Click);

			tab4 = new PushButton(this, 205, 1);
			tab4.toggle = true;
			tab4.setSize(68, 41);
			tab4.addEventListener(MouseEvent.CLICK, tab4_Click);

			if (DataProxy.isCaveolaeBo) {
				tab3.visible = true;
				tab4.visible = true;
			} else {
				tab3.visible = false;
				tab4.visible = false;
			}

			background = new Shape();
			background.y = 30;
			addChild(background);

			btn_left = new PushButton(this, 205, 130);
			btn_left.setSize(22, 22);
			btn_left.addEventListener(MouseEvent.CLICK, btn_left_Click);

			btn_right = new PushButton(this, 240, 130);
			btn_right.setSize(22, 22);
			btn_right.addEventListener(MouseEvent.CLICK, btn_right_Click);

			list = new PageList(this, 25, 40, null, 30, 35, 7, 3);
			list.listItemClass = FaceCell;
			//list = new List(this,0,0,vo.giftList);
			list.setSize(245, 140);
			list.addEventListener("currentPageUpdate", currentPageUpdate);
			text_page = new Label(this, 15, 130);

//			if (DataProxy.isCaveolaeBo) {
//				if (DataProxy.isSkinOpened) {
//					text_page.textFormat = new TextFormat("微软雅黑", 16, 0x2da6e7, true);
//				} else {
//					text_page.textFormat = new TextFormat("微软雅黑", 16, 0xce8139, true);
//				}
//			} else {
//				text_page.textFormat = new TextFormat("微软雅黑", 16, 0x2da6e7, true);
//			}

			setUISkin();
		}

		private function btn_left_Click(e:MouseEvent):void {
			trace("点击左");
			list.currentPage--;

			vo.currentPage = list.currentPage;
		}

		private function btn_right_Click(e:MouseEvent):void {
			trace("点击右");
			list.currentPage++;

			vo.currentPage = list.currentPage;
		}

		private function tab1_Click(e:MouseEvent):void {
			vo.type = 1;
		}

		private function tab2_Click(e:MouseEvent):void {
			vo.type = 2;
		}

		private function tab3_Click(e:MouseEvent):void {
			vo.type = 3;
		}

		private function tab4_Click(e:MouseEvent):void {
			vo.type = 4;
		}

		private function currentPageUpdate(e:Event):void {
			var filter:ColorMatrixFilter = new ColorMatrixFilter([0.3, 0.6, 0, 0, 0, 0.3, 0.6, 0, 0, 0, 0.3, 0.6, 0, 0, 0, 0, 0, 0, 1, 0]);
			if (list.currentPage <= 1) {
				btn_left.filters = [filter];
				btn_left.enabled = false;
			} else {
				btn_left.enabled = true;
				btn_left.filters = [];
			}


			if (list.currentPage >= list.totalPage) {
				btn_right.filters = [filter];
				btn_right.enabled = false;
			} else {
				btn_right.enabled = true;
				btn_right.filters = [];
			}
		}

		private function setUISkin():void {
			if (DataProxy.isCaveolaeBo) {
				if (DataProxy.isSkinOpened) {
					//TODO 待样式全了后补全
					if (DataProxy.skinId == DataProxy.SKIN_ID_1_STAGE) {
						refreshNewSkin1Stage();
					} else if (DataProxy.skinId == DataProxy.SKIN_ID_2_SEA) {
						refreshNewSkin1Stage();
							//refreshNewSkin2Sea();
					} else if (DataProxy.skinId == DataProxy.SKIN_ID_3_PARK) {
						refreshNewSkin1Stage();
							//refreshNewSkin3Park();
					} else {
						refreshNewSkin1Stage();
					}
				} else {
					refreshSkinCaveolaeBo();
				}
			} else {
				refreshSkinAlliance();
			}
		}

		/**
		 * 设置新皮肤1——星光舞台
		 *
		 */
		private function refreshNewSkin1Stage():void {
			tab1.upSkin = new MC_FacePane_1_2();
			tab1.overSkin = new MC_FacePane_1_2();
			tab1.downSkin = new MC_FacePane_1_2();
			tab1.selectUpSkin = new MC_FacePane_1_1();
			tab1.selectOverSkin = new MC_FacePane_1_1();
			tab1.selectDownSkin = new MC_FacePane_1_1();

			tab2.upSkin = new MC_FacePane_2_2();
			tab2.overSkin = new MC_FacePane_2_2();
			tab2.downSkin = new MC_FacePane_2_2();
			tab2.selectUpSkin = new MC_FacePane_2_1();
			tab2.selectOverSkin = new MC_FacePane_2_1();
			tab2.selectDownSkin = new MC_FacePane_2_1();

			tab3.upSkin = new MC_FacePane_11_2();
			tab3.overSkin = new MC_FacePane_11_2();
			tab3.downSkin = new MC_FacePane_11_2();
			tab3.selectUpSkin = new MC_FacePane_11_1();
			tab3.selectOverSkin = new MC_FacePane_11_1();
			tab3.selectDownSkin = new MC_FacePane_11_1();

			tab4.upSkin = new MC_FacePane_12_2();
			tab4.overSkin = new MC_FacePane_12_2();
			tab4.downSkin = new MC_FacePane_12_2();
			tab4.selectUpSkin = new MC_FacePane_12_1();
			tab4.selectOverSkin = new MC_FacePane_12_1();
			tab4.selectDownSkin = new MC_FacePane_12_1();

			background.graphics.clear();
			background.graphics.beginFill(0xeaf8ff);
			background.graphics.drawRoundRect(4, 5, 275, 120, 5);
			background.graphics.endFill();

			btn_left.upSkin = new MC_FacePane_3_1();
			btn_left.overSkin = new MC_FacePane_3_2();
			btn_left.downSkin = new MC_FacePane_3_2();

			btn_right.upSkin = new MC_FacePane_4_1();
			btn_right.overSkin = new MC_FacePane_4_2();
			btn_right.downSkin = new MC_FacePane_4_2();

			text_page.textFormat = new TextFormat("微软雅黑", 16, 0x2da6e7, true);
		}

		/**
		 * 设置新皮肤2——海
		 *
		 */
		private function refreshNewSkin2Sea():void {

		}

		/**
		 * 设置新皮肤3——海
		 *
		 */
		private function refreshNewSkin3Park():void {

		}

		/**
		 * 设置 小窝皮肤
		 *
		 */
		private function refreshSkinCaveolaeBo():void {
			tab1.upSkin = new MC_FacePane_8_2();
			tab1.overSkin = new MC_FacePane_8_2();
			tab1.downSkin = new MC_FacePane_8_2();
			tab1.selectUpSkin = new MC_FacePane_8_1();
			tab1.selectOverSkin = new MC_FacePane_8_1();
			tab1.selectDownSkin = new MC_FacePane_8_1();

			tab2.upSkin = new MC_FacePane_9_2();
			tab2.overSkin = new MC_FacePane_9_2();
			tab2.downSkin = new MC_FacePane_9_2();
			tab2.selectUpSkin = new MC_FacePane_9_1();
			tab2.selectOverSkin = new MC_FacePane_9_1();
			tab2.selectDownSkin = new MC_FacePane_9_1();

			tab3.upSkin = new MC_FacePane_13_2();
			tab3.overSkin = new MC_FacePane_13_2();
			tab3.downSkin = new MC_FacePane_13_2();
			tab3.selectUpSkin = new MC_FacePane_13_1();
			tab3.selectOverSkin = new MC_FacePane_13_1();
			tab3.selectDownSkin = new MC_FacePane_13_1();

			tab4.upSkin = new MC_FacePane_14_2();
			tab4.overSkin = new MC_FacePane_14_2();
			tab4.downSkin = new MC_FacePane_14_2();
			tab4.selectUpSkin = new MC_FacePane_14_1();
			tab4.selectOverSkin = new MC_FacePane_14_1();
			tab4.selectDownSkin = new MC_FacePane_14_1();

			background.graphics.clear();
			background.graphics.beginFill(0xfffdea);
			background.graphics.drawRoundRect(4, 5, 275, 120, 5);
			background.graphics.endFill();

			btn_left.upSkin = new MC_FacePane_5_1();
			btn_left.overSkin = new MC_FacePane_5_2();
			btn_left.downSkin = new MC_FacePane_5_2();

			btn_right.upSkin = new MC_FacePane_6_1();
			btn_right.overSkin = new MC_FacePane_6_2();
			btn_right.downSkin = new MC_FacePane_6_2();

			text_page.textFormat = new TextFormat("微软雅黑", 16, 0xce8139, true);
		}

		/**
		 * 设置 工会皮肤
		 *
		 */
		private function refreshSkinAlliance():void {
			tab1.upSkin = new MC_FacePane_1_2();
			tab1.overSkin = new MC_FacePane_1_2();
			tab1.downSkin = new MC_FacePane_1_2();
			tab1.selectUpSkin = new MC_FacePane_1_1();
			tab1.selectOverSkin = new MC_FacePane_1_1();
			tab1.selectDownSkin = new MC_FacePane_1_1();

			tab2.upSkin = new MC_FacePane_2_2();
			tab2.overSkin = new MC_FacePane_2_2();
			tab2.downSkin = new MC_FacePane_2_2();
			tab2.selectUpSkin = new MC_FacePane_2_1();
			tab2.selectOverSkin = new MC_FacePane_2_1();
			tab2.selectDownSkin = new MC_FacePane_2_1();

			tab3.upSkin = new MC_FacePane_11_2();
			tab3.overSkin = new MC_FacePane_11_2();
			tab3.downSkin = new MC_FacePane_11_2();
			tab3.selectUpSkin = new MC_FacePane_11_1();
			tab3.selectOverSkin = new MC_FacePane_11_1();
			tab3.selectDownSkin = new MC_FacePane_11_1();

			tab4.upSkin = new MC_FacePane_12_2();
			tab4.overSkin = new MC_FacePane_12_2();
			tab4.downSkin = new MC_FacePane_12_2();
			tab4.selectUpSkin = new MC_FacePane_12_1();
			tab4.selectOverSkin = new MC_FacePane_12_1();
			tab4.selectDownSkin = new MC_FacePane_12_1();

			background.graphics.clear();
			background.graphics.beginFill(0xeaf8ff);
			background.graphics.drawRoundRect(4, 5, 275, 120, 5);
			background.graphics.endFill();

			btn_left.upSkin = new MC_FacePane_3_1();
			btn_left.overSkin = new MC_FacePane_3_2();
			btn_left.downSkin = new MC_FacePane_3_2();

			btn_right.upSkin = new MC_FacePane_4_1();
			btn_right.overSkin = new MC_FacePane_4_2();
			btn_right.downSkin = new MC_FacePane_4_2();

			text_page.textFormat = new TextFormat("微软雅黑", 16, 0x2da6e7, true);
		}
	}
}
