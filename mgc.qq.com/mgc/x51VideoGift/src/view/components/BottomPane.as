package view.components {

	import com.bit101.components.Component;
	import com.bit101.components.HBox;
	import com.bit101.components.OverridLabel;
	import com.bit101.components.PushButton;
	import com.bit101.components.Style;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	import model.DataProxy;
	import model.data.BottomPaneVO;

	public class BottomPane extends Component {
		public var vo:BottomPaneVO;

		public var text_money:OverridLabel;
		public var text_money2:OverridLabel;
		public var btn_pay:PushButton;
		public var text_num:TextField;
		public var btn_num:PushButton;
		public var btn_gift:PushButton;
		public var btn_message:PushButton;
		public var numberFrame:Component;
		public var textFormat:TextFormat;

		private var textComp_xd:HBox;
		private var textComp_mhb:HBox;
		private var textComp_sl:HBox;

		public var spacing:int;

		//占位元件
		public var blank:Component;

		public function BottomPane(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0) {
			super(parent, xpos, ypos);

			initUI();

			this.addEventListener(Event.RESIZE, resizeFunction);
		}

		private var widthDict:Array                  = [];

		private var text_1:OverridLabel;
		private var text_3:OverridLabel;

		public function initUI():void {
//			this.alignment = HBox.MIDDLE;
			this.setSize(615, 35);


			/*textTF_Caveo = new TextFormat(FONT_NAME, 12, 0xe5b854, true, null, null, null, null, TextFormatAlign.RIGHT);
			textTF_Alli = new TextFormat(FONT_NAME, 12, 0xfcd263, true, null, null, null, null, TextFormatAlign.RIGHT);
			textTF_New = new TextFormat(FONT_NAME, 12, 0xfcd263, true, null, null, null, null, TextFormatAlign.RIGHT);*/

			//blank = new Component(this);
			//blank.setSize(20,25);
			//blank.visible = false;

			btn_message = new PushButton(this, 0, 0);
			btn_message.upSkin = new MC_BottomPane_4_1();
			btn_message.overSkin = new MC_BottomPane_4_2();
			btn_message.downSkin = new MC_BottomPane_4_3();
			btn_message.selectUpSkin = new MC_BottomPane_4_1();
			btn_message.selectOverSkin = new MC_BottomPane_4_2();
			btn_message.selectDownSkin = new MC_BottomPane_4_3();
			btn_message.label.textFormat = new TextFormat(BTN_LABELFONT_NAME, 12, 0xffffff);
			btn_message.toggle = true;
			btn_message.setSize(60, 25);

			widthDict.push({key: btn_message, value: new Point(60, 25)});

			var offsetY:int = 0;
			if (isOSMac) {
				offsetY += macTextOffsetY;
			}
			if (IsSafari) {
				offsetY += safariTextOffsetY;
			}

			//炫豆面板
			textComp_xd = new HBox(this);
			textComp_xd.setSize(95, 25);
			textComp_xd.alignment = HBox.MIDDLE;
			widthDict.push({key: textComp_xd, value: new Point(95, 25)});

			text_1 = new OverridLabel(textComp_xd, 0, offsetY + 0, "炫豆");
			text_1.autoSize = false;
			text_1.textFormat = getLabelTextFormat();
			text_1.setSize(32, 25);

			text_money = new OverridLabel(textComp_xd, 0, offsetY + 0, "0");
			text_money.autoSize = false;
			text_money.textFormat = getTextTextFormat();
			text_money.setSize(60, 25);

			textComp_xd.draw();

			//梦幻币面板
			textComp_mhb = new HBox(this);
			textComp_mhb.setSize(110, 25);
			textComp_mhb.alignment = HBox.MIDDLE;
			widthDict.push({key: textComp_mhb, value: new Point(110, 25)});

			text_3 = new OverridLabel(textComp_mhb, 0, offsetY + 0, "梦幻币");
			text_3.autoSize = false;
			text_3.textFormat = getLabelTextFormat();
			text_3.setSize(44, 25);

			text_money2 = new OverridLabel(textComp_mhb, 0, 0, "0");
			text_money2.autoSize = false;
			text_money2.textFormat = getTextTextFormat();
			text_money2.setSize(60, 25);

			textComp_mhb.draw();


			textComp_sl = new HBox(this);
			textComp_sl.setSize(80, 25);
			textComp_sl.alignment = HBox.MIDDLE;
			widthDict.push({key: textComp_sl, value: new Point(80, 25)});

			var text_2:OverridLabel = new OverridLabel(textComp_sl, 0, offsetY + 0, "数量");
			text_2.textFormat = getLabelTextFormat();
			text_2.autoSize = false;
			text_2.setSize(32, 25);

			numberFrame = new Component(textComp_sl);
			numberFrame.setSize(45, 25);
			if (DataProxy.isCaveolaeBo) {
				if (DataProxy.isSkinOpened) {
					numberFrame.graphics.clear();
					numberFrame.graphics.beginFill(DataProxy.skinTextBgColor, 1);
					numberFrame.graphics.drawRoundRect(0, 3, 45, 20, 5);
					numberFrame.graphics.endFill();
				} else {
					numberFrame.addChildAt(new MC_BottomPane_11(), 0);
				}
			} else {
				numberFrame.addChildAt(new MC_BottomPane_7(), 0);
			}

			text_num = new TextField();
			text_num.text = "1";
			text_num.embedFonts = Style.embedFonts;
			text_num.selectable = true;
			text_num.type = TextFieldType.INPUT;
			textFormat = new TextFormat(FONT_NAME, 12, 0xfafafa, null, null, null, null, null, TextFormatAlign.CENTER);
			text_num.setTextFormat(textFormat);
			text_num.restrict = "0-9";
			text_num.maxChars = 5;
			text_num.width = 35;
			text_num.height = 25;
			text_num.y = isOSMac ? macTextOffsetY + 3 : 2; //(IsSafari ? safariTextOffsetY : 2);
			numberFrame.addChild(text_num);

			btn_num = new PushButton(numberFrame, 28, 0);
			if (DataProxy.isCaveolaeBo) {
				btn_num.upSkin = new MC_BottomPane_6_1();
				btn_num.overSkin = new MC_BottomPane_6_2();
				btn_num.downSkin = new MC_BottomPane_6_2();
				btn_num.selectUpSkin = new MC_BottomPane_7_4();
				btn_num.selectOverSkin = new MC_BottomPane_7_5();
				btn_num.selectDownSkin = new MC_BottomPane_7_5();
			} else {
				btn_num.upSkin = new MC_BottomPane_1_1();
				btn_num.overSkin = new MC_BottomPane_1_2();
				btn_num.downSkin = new MC_BottomPane_1_2();
				btn_num.selectUpSkin = new MC_BottomPane_1_4();
				btn_num.selectOverSkin = new MC_BottomPane_1_5();
				btn_num.selectDownSkin = new MC_BottomPane_1_5();
			}

			btn_num.toggle = true;
			btn_num.setSize(20, 25);
			textComp_sl.draw();


			btn_gift = new PushButton(this, 0, 0);
			btn_gift.upSkin = new MC_BottomPane_3_1();
			btn_gift.overSkin = new MC_BottomPane_3_2();
			btn_gift.downSkin = new MC_BottomPane_3_3();
			btn_gift.label.textFormat = new TextFormat(BTN_LABELFONT_NAME, 12, 0xffffff);
			btn_gift.setSize(93, 25);
			//btn_gift.enabled = false;
			widthDict.push({key: btn_gift, value: new Point(93, 25)});

			btn_pay = new PushButton(this, 0, 0);
			btn_pay.upSkin = new MC_BottomPane_2_1();
			btn_pay.overSkin = new MC_BottomPane_2_2();
			btn_pay.downSkin = new MC_BottomPane_2_3();
			btn_pay.label.textFormat = new TextFormat(BTN_LABELFONT_NAME, 12, 0xffffff);
			btn_pay.setSize(93, 25);
			widthDict.push({key: btn_pay, value: new Point(93, 25)});

			draw();

			btn_message.visible = false;
			textComp_xd.visible = false;
			textComp_mhb.visible = false;
			textComp_sl.visible = false;
			btn_gift.visible = false;
			btn_pay.visible = false;
		}

		public function showContent():void {
			btn_message.visible = true;
			textComp_xd.visible = true;
			textComp_mhb.visible = true;
			textComp_sl.visible = true;
			btn_gift.visible = true;
			btn_pay.visible = true;
		}

		public static const safariTextOffsetY:int    = 4;

		private static var regWebkit:RegExp          = new RegExp("(webkit)[ \\/]([\\w.]+)", "i");

		public static function get IsSafari():Boolean {
			if (BrowserInfo.name == null || BrowserInfo.name == "") {
				BrowserInfo.getBrowserInfo();
			}
			return BrowserInfo.name == BrowserInfo.SAFARI;
		}

		public static const macTextOffsetY:int       = 3;

		public static function get isOSMac():Boolean {
			var os:String = Capabilities.os.toLowerCase();
			return os.indexOf("mac") >= 0;
		}

		override public function draw():void {
			var totalWidth:int = 0;
			//_height = 0;
			if (widthDict != null) {
				var xpos:Number = 0;
				for (var i:int = 0; i < numChildren; i++) {
					var child:DisplayObject = getChildAt(i);
					var childWidth:int      = getChildWidth(child);
					child.x = xpos;
					if (childWidth == 0) {
						childWidth = child.width;
					}
					xpos += childWidth
					xpos += spacing;
				}
				_width = xpos - spacing;
			}
			super.draw();
		}

		private function getChildWidth(child:DisplayObject):int {
			for each (var dataObj:Object in widthDict) {
				if (dataObj["key"] == child) {
					return Point(dataObj["value"]).x;
				}
			}
			return 0;
		}

		public function getElementTotalWidth():int {
			var totalWidth:int = 0;
			for each (var dataObj:Object in widthDict) {
				totalWidth += Point(dataObj["value"]).x;
			}
			return totalWidth;
		}

		private function resizeFunction(e:Event):void {
			if (DataProxy.isCaveolaeBo) {
				var lineColor:uint = 0x9457f9;
				var fillColor:uint = 0xd79467;
				if (DataProxy.isSkinOpened) {
					lineColor = DataProxy.skinTextBgColor;
					fillColor = DataProxy.skinTextBgColor;
				}
				textComp_xd.graphics.clear();
				textComp_xd.graphics.lineStyle(1, lineColor, 0);
				textComp_xd.graphics.beginFill(fillColor, 1);
				textComp_xd.graphics.drawRoundRect(text_money.x, text_money.y + 3, 60, 20, 5);
				textComp_xd.graphics.endFill();

				textComp_mhb.graphics.clear();
				textComp_mhb.graphics.lineStyle(1, lineColor, 0);
				textComp_mhb.graphics.beginFill(fillColor, 1);
				textComp_mhb.graphics.drawRoundRect(text_money2.x, text_money2.y + 3, 60, 20, 5);
				textComp_mhb.graphics.endFill();
			} else {
				textComp_xd.graphics.clear();
				textComp_xd.graphics.lineStyle(1, 0x9457f9);
				textComp_xd.graphics.beginFill(0xd79467, 0);
				textComp_xd.graphics.drawRoundRect(text_1.x, text_1.y, 95, 25, 5);
				textComp_xd.graphics.endFill();

				textComp_mhb.graphics.clear();
				textComp_mhb.graphics.lineStyle(1, 0x9457f9);
				textComp_mhb.graphics.beginFill(0xd79467, 0);
				textComp_mhb.graphics.drawRoundRect(text_3.x, text_3.y, 110, 25, 5);
				textComp_mhb.graphics.endFill();
			}
		}

		//===========================================================
		//
		// 样式相关
		//
		//===========================================================
		private static var FONT_NAME:String          = "微软雅黑";
		private static var BTN_LABELFONT_NAME:String = "黑体";

		private var labelTF_Caveo:TextFormat;
		private var labelTF_Alli:TextFormat;
		private var labelTF_New:TextFormat;

		private function getLabelTextFormat():TextFormat {
			if (labelTF_Caveo == null || labelTF_Alli == null || labelTF_New == null) {
				labelTF_Caveo = new TextFormat(FONT_NAME, 12, 0xe5b854, true, null, null, null, null, TextFormatAlign.RIGHT);
				labelTF_Alli = new TextFormat(FONT_NAME, 12, 0xfcd263, true, null, null, null, null, TextFormatAlign.RIGHT);
				labelTF_New = new TextFormat(FONT_NAME, 12, 0xfcd263, true, null, null, null, null, TextFormatAlign.RIGHT);
			}

			if (DataProxy.isCaveolaeBo) {
				if (DataProxy.isSkinOpened) {
					return labelTF_New;
				} else {
					return labelTF_Caveo;
				}
			} else {
				return labelTF_Alli;
			}
		}

		private var textTF_Caveo:TextFormat;
		private var textTF_Alli:TextFormat;
		private var textTF_New:TextFormat;

		private function getTextTextFormat():TextFormat {
			if (textTF_Caveo == null || textTF_Alli == null || textTF_New == null) {
				textTF_Caveo = new TextFormat(FONT_NAME, 12, 0x743207, true, null, null, null, null, TextFormatAlign.CENTER);
				textTF_Alli = new TextFormat(FONT_NAME, 12, 0xfafafa, true, null, null, null, null, TextFormatAlign.CENTER);
				textTF_New = new TextFormat(FONT_NAME, 12, 0xfafafa, true, null, null, null, null, TextFormatAlign.CENTER);
			}

			if (DataProxy.isCaveolaeBo) {
				if (DataProxy.isSkinOpened) {
					return textTF_New;
				} else {
					return textTF_Caveo;
				}
			} else {
				return textTF_Alli;
			}
		}
	}
}
