package gl.fm.view {

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.text.TextField;
	import flash.text.TextFormat;

	import gl.fm.ResGetter;
	import gl.fm.data.RocketData;

	public class RocketItem extends Sprite {
		public function RocketItem() {
			super();
			backgroud = new FlyItemBackground();
		}

		private var backgroud:FlyItemBackground;
		private static var textFormat:TextFormat;
		private static var anchorFormat:TextFormat;

		private var rocketData:RocketData;

		private var iconDef:Bitmap;
		private var iconVIP:Bitmap;
		private var iconWealth:Bitmap;
		private var iconRocket:Bitmap;

		private var textLeft:TextField;
		private var textName:TextField;
		private var textMsg1:TextField;
		private var textMsg2:TextField;
		private var textMsg3:TextField;
		private var textMsg4:TextField;

		public function init(data:RocketData):void {
			rocketData = data;

			//		this.mouseEnabled = false;

			//[{{if wealth_level!=0}}<i class="wealth_level_${wealth_level}"></i>
			//{{/if}}{{if guard_level!=0}}<i class="icon_lv icon_lv${guard_level}"></i>
			//{{/if}}${player_name}
			//{{if vip_level!=0}}<i class="icon_honor icon_honor${vip_level}"></i>
			//{{/if}}]为<span>${room_id}房间的[${anchor_name}]</span>送上了<img src="http://ossweb-img.qq.com/images/mgc/css_img/video_room/fly/hj_icon.png?v=3_8_8_2016_15_4_final_3">X${rocket_cnt}，点击进入房间抢宝箱啊~

			if (textFormat == null) {
				textFormat = new TextFormat();
				textFormat.font = "Arial";
				textFormat.size = 15;
				textFormat.color = 0x930098;
				textFormat.bold = true;
			}
			if (anchorFormat == null) {
				anchorFormat = new TextFormat();
				anchorFormat.font = "Arial";
				anchorFormat.size = 15;
				anchorFormat.color = 0x563fff;
				anchorFormat.bold = true;
			}

			ResGetter.resetFlyItemBG(backgroud, false, true, data.vip_level);
			if (backgroud != null) {
				this.addChild(backgroud);
			}

			var iconDefBMD:BitmapData = ResGetter.getIconBitmapData(ResGetter.ICON_DEFEND + data.guard_level);
			if (iconDefBMD != null) {
				if (iconDef == null) {
					iconDef = new Bitmap(iconDefBMD);
				} else {
					iconDef.bitmapData = iconDefBMD;
				}
			}
			var iconVIPBMD:BitmapData = ResGetter.getIconBitmapData(ResGetter.ICON_VIP + data.vip_level);
			if (iconVIPBMD != null) {
				if (iconVIP == null) {
					iconVIP = new Bitmap(iconVIPBMD);
				} else {
					iconVIP.bitmapData = iconVIPBMD;
				}
			}
			var iconWealthBMD:BitmapData = ResGetter.getIconBitmapData(ResGetter.ICON_WEALTH + data.wealth_level);
			if (iconWealthBMD != null) {
				if (iconWealth == null) {
					iconWealth = new Bitmap(iconWealthBMD);
				} else {
					iconWealth.bitmapData = iconWealthBMD;
				}
			}

			var centerLine:int = 33;
			var left:int       = 130;

			if (textLeft == null) {
				textLeft = new TextField();
			}
			textLeft.text = "[";
			textLeft.setTextFormat(textFormat);
			textLeft.filters = ResGetter.getTextFilter();
			textLeft.width = textLeft.textWidth + 5;
			textLeft.x = left;
			textLeft.y = centerLine - (textLeft.textHeight / 2 + 2);
			this.addChild(textLeft);
			textLeft.mouseEnabled = false;
			textLeft.mouseWheelEnabled = false;
			left += textLeft.width;

			if (iconWealth != null && iconWealth.bitmapData != null) {
				iconWealth.x = left;
				iconWealth.y = centerLine - iconWealth.bitmapData.height / 2;
				this.addChild(iconWealth);
				left += iconWealth.bitmapData.width;
			}
			if (iconDef != null && iconDef.bitmapData != null) {
				iconDef.x = left;
				iconDef.y = centerLine - iconDef.bitmapData.height / 2;
				this.addChild(iconDef);
				left += iconDef.bitmapData.width;
			}

			if (textName == null) {
				textName = new TextField();
			}
			textName.text = data.player_name;
			textName.setTextFormat(textFormat);
			textName.filters = ResGetter.getTextFilter();
			textName.width = textName.textWidth + 5;
			textName.x = left;
			textName.y = centerLine - (textName.textHeight / 2 + 2);
			this.addChild(textName);
			textName.mouseEnabled = false;
			textName.mouseWheelEnabled = false;
			left += textName.width;

			if (iconVIP != null && iconVIP.bitmapData != null) {
				iconVIP.x = left;
				iconVIP.y = centerLine - iconVIP.bitmapData.height / 2;
				this.addChild(iconVIP);
				left += iconVIP.bitmapData.width;
			}

			//{{/if}}]为<span>${room_id}房间的[${anchor_name}]</span>送上了<img src="http://ossweb-img.qq.com/images/mgc/css_img/video_room/fly/hj_icon.png?v=3_8_8_2016_15_4_final_3">X${rocket_cnt}，点击进入房间抢宝箱啊~
			if (textMsg1 == null) {
				textMsg1 = new TextField();
			}
			textMsg1.text = "]为";
			textMsg1.setTextFormat(textFormat);
			textMsg1.filters = ResGetter.getTextFilter();
			textMsg1.width = textMsg1.textWidth + 5;
			textMsg1.x = left;
			textMsg1.y = centerLine - (textMsg1.textHeight / 2 + 2);
			this.addChild(textMsg1);
			textMsg1.mouseEnabled = false;
			textMsg1.mouseWheelEnabled = false;
			left += textMsg1.width;

			if (textMsg2 == null) {
				textMsg2 = new TextField();
			}
			textMsg2.text = data.room_id + "房间的[" + data.anchor_name + "]"
			textMsg2.setTextFormat(anchorFormat);
			textMsg2.filters = ResGetter.getTextFilter();
			textMsg2.width = textMsg2.textWidth + 5;
			textMsg2.x = left;
			textMsg2.y = centerLine - (textMsg2.textHeight / 2 + 2);
			this.addChild(textMsg2);
			textMsg2.mouseEnabled = false;
			textMsg2.mouseWheelEnabled = false;
			left += textMsg2.width;

			if (textMsg3 == null) {
				textMsg3 = new TextField();
			}
			textMsg3.text = "送上了"
			textMsg3.setTextFormat(textFormat);
			textMsg3.filters = ResGetter.getTextFilter();
			textMsg3.width = textMsg3.textWidth + 5;
			textMsg3.x = left;
			textMsg3.y = centerLine - (textMsg3.textHeight / 2 + 2);
			this.addChild(textMsg3);
			textMsg3.mouseEnabled = false;
			textMsg3.mouseWheelEnabled = false;
			left += textMsg3.width;

			var iconRocketBMD:BitmapData = ResGetter.getIconBitmapData(ResGetter.ICON_ROCKET);
			if (iconRocketBMD != null) {
				if (iconRocket == null) {
					iconRocket = new Bitmap(iconRocketBMD);
				} else {
					iconRocket.bitmapData = iconRocketBMD;
				}
				iconRocket.x = left;
				iconRocket.y = centerLine - iconRocket.bitmapData.height / 2;
				this.addChild(iconRocket);
				left += iconRocket.bitmapData.width;
			}

			if (textMsg4 == null) {
				textMsg4 = new TextField();
			}
			textMsg4.text = "X" + data.rocket_cnt + "，点击进入房间抢宝箱啊~";
			textMsg4.setTextFormat(textFormat);
			textMsg4.filters = ResGetter.getTextFilter();
			textMsg4.width = textMsg4.textWidth + 5;
			textMsg4.x = left;
			textMsg4.y = centerLine - (textMsg4.textHeight / 2 + 2);
			this.addChild(textMsg4);
			textMsg4.mouseEnabled = false;
			textMsg4.mouseWheelEnabled = false;
			left += textMsg4.width;

			backgroud.setWidth(left + 100);

			this.cacheAsBitmap = true;

			this.useHandCursor = true;
			this.buttonMode = true;
			this.addEventListener(MouseEvent.CLICK, onMouseClick);
		}

		private function onMouseClick(event:MouseEvent):void {
			if (ExternalInterface.available) {
				ExternalInterface.call("MGC_Comm.onRocketScreenMsgClick", rocketData.room_id);
			}
		}

		public function getBGWidth():int {
			if (backgroud != null) {
				return backgroud.getWidth();
			}
			return 0;
		}

		private var moveTime:int;
		private var duration:int;
		private var distance:int;
		private var targetPoint:int;

		public function start(srcPoint:int, targetPoint:int):void {
			this.targetPoint = targetPoint;
			distance = Math.abs(targetPoint - srcPoint);
			moveTime = 0;
			duration = distance / FlyMessageModule.MOVE_D * FlyMessageModule.MOVE_S * 1000;
//			trace("distance =" + distance + "  duration = " + duration);
		}

		public function move(dt:int):void {
			moveTime += dt;
			var d:int = (duration - moveTime) / duration * distance;
			this.x = int(targetPoint + (duration - moveTime) / duration * distance);
//			trace("moveTime=" + moveTime + " moveD=" + d + " x=" + this.x + " targetPoint=" + targetPoint);
//			if (this.parent != null) {
//				var p:DisplayObjectContainer = this.parent;
//				this.parent.removeChild(this);
//				p.addChild(this);
//			}
		}

		public function dispose():void {
			while (this.numChildren > 0) {
				var subDisObj:DisplayObject = this.removeChildAt(this.numChildren - 1);
				if (subDisObj is FlyItemBackground) {
					(subDisObj as FlyItemBackground).dispose();
				} else if (subDisObj is Bitmap) {
					(subDisObj as Bitmap).bitmapData = null;
				} else if (subDisObj is TextField) {
					(subDisObj as TextField).text = "";
					(subDisObj as TextField).setTextFormat((subDisObj as TextField).defaultTextFormat);
					(subDisObj as TextField).filters = null;
				}
			}
		}
	}
}
