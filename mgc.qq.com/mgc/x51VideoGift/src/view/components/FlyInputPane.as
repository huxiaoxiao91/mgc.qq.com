package view.components
{
	import com.bit101.components.Component;
	import com.bit101.components.HBox;
	import com.bit101.components.InputText;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import flashx.textLayout.container.ContainerController;
	import flashx.textLayout.edit.EditManager;
	import flashx.textLayout.formats.TextLayoutFormat;
	
	import model.DataProxy;
	import model.data.FlyInputPaneVO;
	
	public class FlyInputPane extends Component
	{
		public var vo:FlyInputPaneVO;
		
		public var btn_face:PushButton;
		public var text_tip:Label;
		public var btn_send:PushButton;
		
		//图文混排输入框
		public var inputContainer:Component;
		public var containerController:ContainerController;
		
		//public var tText:TLFTextField;
		
//		private var hbox:HBox;
		
		//背景
		private var background:Sprite;
		
		public function FlyInputPane(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0)
		{
			super(parent, xpos, ypos);
			
			//initUI();
		}
		
		public function initUI():void
		{
			this.visible = false;

			if (DataProxy.isCaveolaeBo) {
				if (DataProxy.isSkinOpened) {
					background = new MC_FlyInputPane_1();
				} else {
					background = new CaveolaeFlyScreenBG();
				}
			} else {
				background = new MC_FlyInputPane_1();
			}
			this.addChild(background);
			
//			hbox = new HBox(this,10);	
//			hbox.alignment = HBox.MIDDLE;
			
			btn_face = new PushButton(this,10,10);
			btn_face.upSkin = new MC_FlyInputPane_2_1();
			btn_face.overSkin = new MC_FlyInputPane_2_2();
			btn_face.downSkin = new MC_FlyInputPane_2_2();
			btn_face.setSize(18,16);
			
			inputContainer = new Component(this,30,8);
			inputContainer.height = 20;
			containerController = new ContainerController(inputContainer,NaN,NaN); 
			vo.textFlow.flowComposer.addController(containerController);
			
			text_tip = new Label(inputContainer);
			text_tip.textFormat = new TextFormat("黑体",14,0xc9c9c9);
			text_tip.height = 40;
			
/*			tText = new TLFTextField();
			tText.type = TextFieldType.INPUT;
			//tText.wordWrap = false;
			//tText.multiline = false;
			tText.maxChars = 50;
			addChild(tText);
			
			var textFormat:TextLayoutFormat = new TextLayoutFormat();
			textFormat.fontFamily = "宋体";
			textFormat.fontSize = 16;
			textFormat.color = 0xffffff;
			
			tText.textFlow.hostFormat = textFormat;
			
			vo.textFlow = tText.textFlow;
			vo.editManager = tText.textFlow.interactionManager as EditManager;*/
			
			btn_send = new PushButton(this,0,0);

			if (DataProxy.isCaveolaeBo) {
				if (DataProxy.isSkinOpened) {
					//skinid=1
					btn_send.upSkin = new MC_FlyInputPane_3_1();
					btn_send.overSkin = new MC_FlyInputPane_3_2();
					btn_send.downSkin = new MC_FlyInputPane_3_3();
				} else {
					btn_send.upSkin = new CaveolaeSendDefault();
					btn_send.overSkin = new CaveolaeSendMouseOver();
					btn_send.downSkin = new CaveolaeSendMouseDown();
				}
			} else {
				btn_send.upSkin = new MC_FlyInputPane_3_1();
				btn_send.overSkin = new MC_FlyInputPane_3_2();
				btn_send.downSkin = new MC_FlyInputPane_3_3();
			}
			btn_send.setSize(68,34);
		}

		
		/**
		 * Sets the size of the component.
		 * @param w The width of the component.
		 * @param h The height of the component.
		 */
		override public function setSize(w:Number, h:Number):void
		{
			super.setSize(w, h);
			
//			hbox.setSize(w,h);
			btn_send.x = w - 68;
			background.width = w;
			background.height = h;
			
			text_tip.width = w - 100;
			inputContainer.width = w -100;
			containerController.setCompositionSize(w -100,30);
			
			//tText.width = w -100;
			
			/*this.graphics.clear();
			this.graphics.lineStyle(1, 0x642FBA, 1);
			this.graphics.beginFill(0x000000);
			this.graphics.drawRect(0, 0, w, h);
			this.graphics.endFill();*/
		}
		
		
	}
}