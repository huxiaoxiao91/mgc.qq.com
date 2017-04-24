package view.components
{
	import com.bit101.components.Component;
	import com.bit101.components.GiftTileList;
	import com.bit101.components.HBox;
	import com.bit101.components.List;
	import com.bit101.components.PushButton;
	import com.bit101.components.TileList;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import model.DataProxy;
	import model.data.GiftPaneVO;
	
	import view.components.GiftCell;
	
	public class GiftPane extends HBox
	{
		public var vo:GiftPaneVO;
		
		public var list:GiftTileList;
		
		public var btn_left:PushButton;
		public var btn_right:PushButton;
		
		//占位元件
		public var blank:Component;
		
		public function GiftPane(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0)
		{
			super(parent, xpos, ypos);
			
			initUI();
		}
		
		public function initUI():void
		{
			this.alignment = HBox.MIDDLE;
			this.setSize(550,45);
			
			/*this.graphics.lineStyle(1, 0, 0.1);
			this.graphics.beginFill(0x0A0622);
			this.graphics.drawRect(0, 0, 550, 50);
			this.graphics.endFill();*/
			
			blank = new Component(this);
			blank.setSize(20,25);
			blank.visible = false;
			if(blank.parent != null){
				blank.parent.removeChild(blank);
			}
			
			btn_left = new PushButton(this,0,5);
			btn_left.upSkin = new MC_GiftPane_1_1();
			btn_left.overSkin = new MC_GiftPane_1_2();
			btn_left.downSkin = new MC_GiftPane_1_3();
			btn_left.enabledSkin = new MC_GiftPane_1_4();
//			btn_left.enabled = false;
			btn_left.setSize(12,22);
			btn_left.addEventListener(MouseEvent.CLICK,btn_left_Click);
			this.addChild(btn_left);
			//btn_left.visible = false;
			
			var giftCell:GiftCell;
			//list = new TileList(vo.giftList,"view.components.GiftCell","",0,0,50,50,400,50);
			list = new GiftTileList(this,0,5,null,50,50,11,1);
			list.listItemClass = GiftCell;
			//list = new List(this,0,0,vo.giftList);
			list.setSize(500,50);
			list.addEventListener("componentDraw",componentDraw);
			this.addChild(list);

			btn_right = new PushButton(this,0,5);
			btn_right.upSkin = new MC_GiftPane_2_1();
			btn_right.overSkin = new MC_GiftPane_2_2();
			btn_right.downSkin = new MC_GiftPane_2_3();
			btn_right.enabledSkin = new MC_GiftPane_2_4();
//			btn_right.enabled = false;
			btn_right.setSize(12,22);
			btn_right.addEventListener(MouseEvent.CLICK,btn_right_Click);
			this.addChild(btn_right);

			if (DataProxy.isCaveolaeBo) {
				if (DataProxy.isSkinOpened) {
					//if (DataProxy.skinId == DataProxy.SKIN_ID_1_STAGE) {
						btn_left.skinOffsetY = 2;
						btn_right.skinOffsetY = 2;
					//}
				}
			}
		}
		
		private function componentDraw(e:Event):void
		{
			setButtonState();
		}
		
		private function btn_left_Click(e:MouseEvent):void
		{
			list.value -= list.columnCount;
			setButtonState();
		}
		
		public function setButtonState():void
		{
			if(list.value > list.scrollBar.scrollSlider.min)
				btn_left.enabled = true;
			else
				btn_left.enabled = false;
			
			if(list.value >= list.scrollBar.scrollSlider.max )
				btn_right.enabled = false;
			else
				btn_right.enabled = true;
		}
		
		private function btn_right_Click(e:MouseEvent):void
		{
			list.value += list.columnCount;
			setButtonState();
		}
	}
}