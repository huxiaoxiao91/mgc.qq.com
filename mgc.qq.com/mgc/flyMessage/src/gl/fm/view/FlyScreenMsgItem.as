package gl.fm.view {

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;

	import gl.fm.ResGetter;
	import gl.fm.data.FlyScreenMsgData;

	import org.bytearray.gif.player.GIFPlayer;

	public class FlyScreenMsgItem extends Sprite {
		public function FlyScreenMsgItem() {
			super();

			this.mouseEnabled = false;
			this.mouseChildren = false;

			cacheLayer = new Sprite();
			this.addChild(cacheLayer);

			aniLayer = new Sprite();
			this.addChild(aniLayer);

			backgroud = new FlyItemBackground();
		}

		private var cacheLayer:Sprite;
		private var aniLayer:Sprite;

		private var backgroud:FlyItemBackground;

		private var iconDef:Bitmap;
		private var iconVIP:Bitmap;
		private var iconWealth:Bitmap;

		private var textLeft:TextField;
		private var textName:TextField;
		private var textRight:TextField

		public var rowIndex:int;

		public function init(data:FlyScreenMsgData, isConcert:Boolean, rowIndex:int):void {
			var textFormat:TextFormat = ResGetter.getTextFormat(data.isTakeVip, data.vipLevel, data.lastKing);

			this.rowIndex = rowIndex;

			ResGetter.resetFlyItemBG(backgroud, data.isTakeVip, false, data.vipLevel, data.lastKing);
			if (backgroud != null) {
				cacheLayer.addChild(backgroud);
			}

			if (data.isDef && isConcert == false) {
				var iconDefBMD:BitmapData = ResGetter.getIconBitmapData(ResGetter.ICON_DEFEND + data.defend);
				if (iconDefBMD != null) {
					if (iconDef == null) {
						iconDef = new Bitmap(iconDefBMD);
					} else {
						iconDef.bitmapData = iconDefBMD;
					}
				}
			}
			var iconVIPBMD:BitmapData = ResGetter.getIconBitmapData(ResGetter.ICON_VIP + data.vipLevel);
			if (iconVIPBMD != null) {
				if (iconVIP == null) {
					iconVIP = new Bitmap(iconVIPBMD);
				} else {
					iconVIP.bitmapData = iconVIPBMD;
				}
			}
			var iconWealthBMD:BitmapData = ResGetter.getIconBitmapData(ResGetter.ICON_WEALTH + data.wealthLevel);
			if (iconWealthBMD != null) {
				if (iconWealth == null) {
					iconWealth = new Bitmap(iconWealthBMD);
				} else {
					iconWealth.bitmapData = iconWealthBMD;
				}
			}

			var centerLine:int = 33;
			var left:int       = 120;
			if(data.lastKing){
				left = 80;
			}

			if (data.isTakeVip) {
				if (iconWealth != null && iconWealth.bitmapData != null) {
					iconWealth.x = left;
					iconWealth.y = centerLine - iconWealth.bitmapData.height / 2;
					cacheLayer.addChild(iconWealth);
					left += iconWealth.bitmapData.width;
				}
				if (iconDef != null && iconDef.bitmapData != null) {
					iconDef.x = left;
					iconDef.y = centerLine - iconDef.bitmapData.height / 2;
					cacheLayer.addChild(iconDef);
					left += iconDef.bitmapData.width;
				}

				if (iconVIP != null && iconVIP.bitmapData != null) {
					iconVIP.x = left;
					iconVIP.y = centerLine - iconVIP.bitmapData.height / 2;
					cacheLayer.addChild(iconVIP);
					left += iconVIP.bitmapData.width;
				}

				if (textName == null) {
					textName = new TextField();
				}
				textName.text = data.senderName;
				textName.setTextFormat(textFormat);
				textName.filters = ResGetter.getTextFilter();
				textName.width = textName.textWidth + 5;
				textName.x = left;
				textName.y = centerLine - (textName.textHeight / 2 + 2);
				cacheLayer.addChild(textName);
				left += textName.width;

				if (textRight == null) {
					textRight = new TextField();
				}
				textRight.multiline = false;
				textRight.wordWrap = false;
				textRight.text = transferStr(data.msgStr);
				textRight.setTextFormat(textFormat);
				textRight.filters = ResGetter.getTextFilter();
				textRight.width = textRight.textWidth + 5;
				textRight.x = left;
				textRight.y = centerLine - (textRight.textHeight / 2 + 2);
				cacheLayer.addChild(textRight);
				left += textRight.width;
			} else {
				if (textLeft == null) {
					textLeft = new TextField();
				}
				if(data.lastKing){
					textLeft.text = "补刀王【";
				} else{
					textLeft.text = "【";
				}
				
				textLeft.setTextFormat(textFormat);
				textLeft.filters = ResGetter.getTextFilter();
				textLeft.width = textLeft.textWidth + 5;
				textLeft.x = left;
				textLeft.y = centerLine - (textLeft.textHeight / 2 + 2);
				cacheLayer.addChild(textLeft);
				left += textLeft.width;

				if (iconWealth != null && iconWealth.bitmapData != null) {
					iconWealth.x = left;
					iconWealth.y = centerLine - iconWealth.bitmapData.height / 2;
					cacheLayer.addChild(iconWealth);
					left += iconWealth.bitmapData.width;
				}
				if (iconDef != null && iconDef.bitmapData != null) {
					iconDef.x = left;
					iconDef.y = centerLine - iconDef.bitmapData.height / 2;
					cacheLayer.addChild(iconDef);
					left += iconDef.bitmapData.width;
				}

				if (textName == null) {
					textName = new TextField();
				}
				textName.text = data.senderName;
				textName.setTextFormat(textFormat);
				textName.filters = ResGetter.getTextFilter();
				textName.width = textName.textWidth + 5;
				textName.x = left;
				textName.y = centerLine - (textName.textHeight / 2 + 2);
				cacheLayer.addChild(textName);
				left += textName.width;

				if (iconVIP != null && iconVIP.bitmapData != null) {
					iconVIP.x = left;
					iconVIP.y = centerLine - iconVIP.bitmapData.height / 2;
					cacheLayer.addChild(iconVIP);
					left += iconVIP.bitmapData.width;
				}

				if (textRight == null) {
					textRight = new TextField();
				}
				textRight.text = "】:"; // + transferStr(data.msgStr);
				textRight.setTextFormat(textFormat);
				textRight.filters = ResGetter.getTextFilter();
				textRight.width = textRight.textWidth + 5;
				textRight.x = left;
				textRight.y = centerLine - (textRight.textHeight / 2 + 2);
				cacheLayer.addChild(textRight);
				left += textRight.width;

				if (data.chatNodes != null && data.chatNodes.length > 0) {
					for each (var node:Object in data.chatNodes) {
						if (node.nodeType == 0) {
							var nodeText:TextField = ResGetter.getNodeText();
							nodeText.multiline = false;
							nodeText.wordWrap = false;
							nodeText.text = transferStr(node.content);
							nodeText.setTextFormat(textFormat);
							nodeText.filters = ResGetter.getTextFilter();
							nodeText.width = nodeText.textWidth + 5;
							nodeText.x = left;
							nodeText.y = centerLine - (nodeText.textHeight / 2 + 2);
							cacheLayer.addChild(nodeText);
							left += nodeText.width;
						} else if (node.nodeType == 1) {
							var nodeIcon:DisplayObject = ResGetter.getChatIcon(node.content);
							nodeIcon.x = left;
							nodeIcon.y = centerLine - 10;
							aniLayer.addChild(nodeIcon);
							left += 20;
						}
					}
				}
			}

			
			if(data.lastKing){
				backgroud.setWidth(left + 80);
			} else{
				backgroud.setWidth(left + 120);
			}
			cacheLayer.cacheAsBitmap = true;
		}

		private function transferStr(info:String):String {
			var reg1:RegExp = /&lt/g;
			var reg2:RegExp = /&gt/g;
			var reg3:RegExp = /&nbsp/g;
			info = info.replace(reg1, "\<");
			info = info.replace(reg2, "\>");
			info = info.replace(reg3, " ");
			info = info.replace(/\r\n/g, " ");
			info = info.replace(/\n/g, " ");
			return info;
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
		}

		public function move(dt:int):void {
			moveTime += dt;
			this.x = (targetPoint + (duration - moveTime) / duration * distance);
//			if (this.parent != null) {
//				var p:DisplayObjectContainer = this.parent;
//				this.parent.removeChild(this);
//				p.addChild(this);
//			}
		}

		public function dispose(disposeAniLayer:Boolean = true):void {
			while (cacheLayer.numChildren > 0) {
				var csubDObj:DisplayObject = cacheLayer.removeChildAt(cacheLayer.numChildren - 1);
				if (csubDObj is GIFPlayer) {
					(csubDObj as GIFPlayer).dispose();
				} else if (csubDObj is FlyItemBackground) {
					(csubDObj as FlyItemBackground).dispose();
				} else if (csubDObj is Bitmap) {
					(csubDObj as Bitmap).bitmapData = null;
				} else if (csubDObj is TextField) {
					var textfield:TextField = csubDObj as TextField;
					textfield.text = "";
					textfield.setTextFormat(textfield.defaultTextFormat);
					if (textfield != textLeft && textfield != textName && textfield != textRight) {
						ResGetter.removeNodeText(textfield);
					}
				}
			}
			if (disposeAniLayer) {
				while (aniLayer.numChildren > 0) {
					var asubDObj:DisplayObject = aniLayer.removeChildAt(aniLayer.numChildren - 1);
					if (asubDObj is GIFPlayer) {
						(asubDObj as GIFPlayer).dispose();
					} else if (asubDObj is Bitmap) {
						(asubDObj as Bitmap).bitmapData = null;
					}
				}
			}

//			backgroud = null;
		}

		public function getMessageWidth():int {
			if (backgroud != null) {
				return backgroud.getWidth();
			}
			return 0;
		}
	}
}
