package view.components {

	import br.com.stimuli.loading.BulkLoader;
	
	import com.bit101.components.Component;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.text.TextField;
	
	import gs.TweenLite;
	
	import model.DataProxy;
	import model.data.EffectPaneVO;
	import model.data.MessagePaneVO;

	/**
	 * 
	 * @author gaolei
	 */
	public class EffectPane extends Component {
		/**
		 * 
		 * @default 
		 */
		public var vo:EffectPaneVO;

		private var bulkLoader:BulkLoader;

		private var path:String;

		private var swf:MovieClip;

		private var maskSprite:Sprite;

		private var giftLayer:Component;

		private var giftTipSprite:Sprite;

		private var rollPane:RollPane;

		private var giftComboTipPane:GiftComboTipPane = new GiftComboTipPane();

		/**
		 * 
		 * @param parent
		 * @param xpos
		 * @param ypos
		 */
		public function EffectPane(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0) {
			super(parent, xpos, ypos);

			initUI();
		}

		/**
		 * 
		 */
		public function initUI():void {
			this.mouseChildren = false;
			this.mouseEnabled = false;

			maskSprite = new Sprite();
			addChild(maskSprite);
			this.mask = maskSprite;

			rollPane = new RollPane(this);
			rollPane.visible = false;

			giftLayer = new Component(this);
			giftLayer.mouseEnabled = false;
			giftLayer.mouseChildren = false;
		}

		/**
		 * Sets the size of the component.
		 * @param w The width of the component.
		 * @param h The height of the component.
		 */
		override public function setSize(w:Number, h:Number):void {
			super.setSize(w, h);

			//筛子界面尺寸
			rollPane.setSize(w, h);
			giftLayer.setSize(w, h);

			if (giftTipSprite != null && vo != null) {
				if (vo.giftData.continuous_send_gift_times > 0) {
					var tipWidth:Number = getContinuousTipWidth();
					giftTipSprite.x = (width - tipWidth) / 2;
					giftTipSprite.y = height - 50 + 10;
				} else {
					giftTipSprite.x = (width - giftTipSprite.width) / 2 - 20;
					giftTipSprite.y = height - giftTipSprite.height;
				}
			}

			if (swf != null && swf.parent != null) {
				//天使动画  玛萨拉蒂动画 翅膀动画 需要特殊处理（width=645,height=255）
				//暂时全部都是用固定长宽方法计算中心点。
				if (true || vo.giftData.giftItemID == 14 || vo.giftData.giftItemID == 38 || vo.giftData.giftItemID == 40) {
					var swf_width:int    = 645;
					var swf_height:int   = 255;
					var swf_scale:Number = height / swf_height;

					if (swf_scale > 1) {
						swf_scale = 1;
					}

					swf_width = swf_width * swf_scale;
					swf_height = swf_height * swf_scale;

					swf.scaleX = swf_scale;
					swf.scaleY = swf_scale;

					swf.x = (width - swf_width) / 2;
					swf.y = (height - swf_height) / 2;
				} else {
					var scale:Number = height / swf.height;
					if (scale <= 1) {
						swf.scaleX = scale;
						swf.scaleY = scale;
					} else {
						swf.scaleX = 1;
						swf.scaleY = 1;
					}

					swf.x = (width - swf.width) / 2;
					swf.y = (height - swf.height) / 2;
				}
			}

			if (maskSprite != null) {
				maskSprite.graphics.clear();
				maskSprite.graphics.beginFill(0xFFFFFF);
				maskSprite.graphics.drawRect(0, 0, width, height);
				maskSprite.graphics.endFill();
			}
		}

		/**
		 * 播放特效
		 * @param path 特效地址
		 */
		public function play(path:String):void {
			this.path = path;

			bulkLoader = BulkLoader.getLoader("gift");

			if (bulkLoader.hasItem(path)) {
				onComplete();
			} else {
				bulkLoader.add(path);
				//bulkLoader.addEventListener(BulkLoader.PROGRESS, onComplete);
				bulkLoader.addEventListener(BulkLoader.COMPLETE, onComplete);
				bulkLoader.addEventListener(BulkLoader.ERROR, onLoadError);
				bulkLoader.start();
			}
		}

		private function getContinuousTipWidth():Number {
			var tipWidth:Number = 380;
			if (vo != null) {
				var length:int = vo.giftData.continuous_send_gift_times.toString().length;
				if (vo.giftData.continuous_send_gift_times == 1) {
					tipWidth = 380;
				} else if (length == 1) {
					tipWidth = 420;
				} else if (length == 2) {
					tipWidth = 450;
				} else if (length == 3) {
					tipWidth = 480;
				} else if (length == 4) {
					tipWidth = 500;
				}
			}
			return tipWidth;
		}

		private function onComplete(e:Event = null):void {
			
			var guardIcon:String = vo.giftData.guardIcon;
			if (guardIcon != "") {
				guardIcon = MessagePaneVO.getGuardIcon(guardIcon)
			}
			
			var vipIcon:String = vo.giftData.vipIcon;
			if (vipIcon != "") {
				vipIcon = MessagePaneVO.getVipIcon(vipIcon);
			}
			
			if (giftTipSprite != null) {
				if (giftTipSprite.parent != null) {
					giftTipSprite.parent.removeChild(giftTipSprite);
				}
				giftTipSprite = null;
			}
			
			//是否连送
			if (vo.giftData.continuous_send_gift_times > 0) {
				var tipWidth:Number = getContinuousTipWidth();
				giftComboTipPane.data = vo.giftData;
				giftTipSprite = giftComboTipPane;
				giftTipSprite.x = (width - tipWidth) / 2;
				giftTipSprite.y = height - 50 + 10;
			} else {
				if (vo.isSelf) {
					giftTipSprite = new GiftTipSprite(guardIcon, vipIcon, " " + vo.giftData.senderName, " 送了  ", " ×" + vo.giftData.maxCount, vo.giftData, true);
				} else {
					giftTipSprite = new GiftTipSprite(guardIcon, vipIcon, " " + vo.giftData.senderName, " 送了  ", " ×" + vo.giftData.maxCount, vo.giftData, false);
				}
				
				giftTipSprite.x = (width - giftTipSprite.width) / 2 - 20;
				giftTipSprite.y = height - giftTipSprite.height;
			}
			
			//捧场不显示铭牌
			if (vo.giftData.giftItemID == 98) {
				giftTipSprite = null;
			}
			
			giftLayer.removeChildren();
			if (giftTipSprite) {
				giftLayer.addChild(giftTipSprite);
			}
			
			
			if (bulkLoader.hasItem(path)) {
				bulkLoader.removeEventListener(BulkLoader.COMPLETE, onComplete);

				if (swf && this.contains(swf)) {
					this.removeChild(swf);
				}

				swf = bulkLoader.getMovieClip(path);
				swf.cacheAsBitmap = true;
				swf.gotoAndStop(1);
				swf.scaleX = 1;
				swf.scaleY = 1;

				//主播 用户昵称
				var anchorName:String   = DataProxy.AnchorName;
				/*if(anchorName.length > 5)
				{
					anchorName = anchorName.substr(0,5);
					anchorName += "...";
				}*/

				//超凡守护3级效果添加主播名称
				var textField:TextField = swf.text_name1;
				if (textField) {
					textField.text = "";
					for (var i:int = 0; i < anchorName.length; i++) {
						var s:String = anchorName.substr(i, 1);
						textField.appendText(s);
						if ((textField.width - textField.textWidth) < 60) {
							//XW79269 剩下未显示的字要大于等于3个
							if ((anchorName.length - (i + 1)) >= 3) {
								textField.appendText("...");
								break;
							}
						}
					}
				}
				//if(swf.text_name2)swf.text_name2.text = vo.senderName;

				var scale:Number = height / swf.height;
				if (scale <= 1) {
					swf.scaleX = scale;
					swf.scaleY = scale;
				}

				swf.x = (width - swf.width) / 2;
				swf.y = (height - swf.height) / 2;

				//皮鞭由页面来显示效果
				if (vo.giftData.giftItemID == 41) {
					//this.removeChild(swf);
					ExternalInterface.call("MGC_Comm.showGiftEffect", vo.playEffectVO);
				}
				//全屏礼物：火箭 香蕉 热气球 粉红炸弹 哈雷 舔屏
				else if (vo.giftData.type == 10) {
					ExternalInterface.call("DreamBoxEffect.show", vo.playEffectVO);
				}
				//筛子
				else if (vo.giftData.giftItemID == 46) {
					ExternalInterface.call("DiceEffect.show", vo);
				} else {
					this.addChildAt(swf, 1);
				}

//				//适配聊天区尺寸
//				swf.width = width;
//				swf.height = height;
				//绘制遮罩
				//maskSprite.width = width;
				//maskSprite.height = height;
				maskSprite.graphics.clear();
				maskSprite.graphics.beginFill(0xFFFFFF);
				maskSprite.graphics.drawRect(0, 0, width, height);
				maskSprite.graphics.endFill();

				swf.gotoAndPlay(1);

				swf.addEventListener(Event.ENTER_FRAME, ef);
				//effectSwfPlayFrame = 1;
				//vo.isPlay = true;
			}
		}
		private var playFrame:int;

		private function onLoadError(event:Event):void {
			//重新加载礼物配置
			//ApplicationFacade.getInstance().sendNotification(ApplicationFacade.LoadGiftConfig);
			
			if (vo.isPlay == false) {
				return;
			}
			playFrame = 20;
			this.addEventListener(Event.ENTER_FRAME, playTipEnterFrame);
		}

		private function playTipEnterFrame(event:Event):void {
			playFrame--;
			if (playFrame <= 0) {
				this.removeEventListener(Event.ENTER_FRAME, playTipEnterFrame);

				if (giftTipSprite != null) {
					if (giftTipSprite.parent != null) {
						giftTipSprite.parent.removeChild(giftTipSprite);
					}
					giftTipSprite = null;
				}

				vo.isPlay = false;
			}
		}

		//private var effectSwfPlayFrame:int            = 0;

		private function isFullEffectEnd():Boolean {
			if (vo != null && vo.giftData != null && vo.giftData.isFullScreenGfit) {
				if (swf != null) {
					if (swf.currentFrame + 1 >= swf.totalFrames) {
						return true;
					}
				}
			}
			return false;
		}

		private function ef(e:Event):void {
			//effectSwfPlayFrame++;
			/*if (isFullEffectEnd()) {
				if (vo.fullEffectOver) {
					vo.fullEffectOver = false;
						//swf.gotoAndStop(swf.totalFrames);
				} else {
					swf.stop();
					//等待js端通知。
					if (effectSwfPlayFrame >= swf.totalFrames * 2) {
						//超过两倍帧数 认为已经播放完毕。
					} else {
						//等待js端通知。
						return;
					}
				}
			}*/

			//全屏效果动画不播放最后一帧，最后一帧里面有逻辑代码有可能触发（QGame端会触发）
			if (swf.currentFrame == swf.totalFrames) {
				swf.removeEventListener(Event.ENTER_FRAME, ef);
				if (giftTipSprite != null) {
					if (giftTipSprite.parent != null) {
						giftTipSprite.parent.removeChild(giftTipSprite);
					}
					giftTipSprite = null;
				}
				if (this.contains(swf)) {
					this.removeChild(swf);
				}
				swf.stop();
				swf = null;
				
				//隐藏皮鞭页面的礼物效果
				if (vo.giftData.giftItemID == 41) {
					ExternalInterface.call("MGC_Comm.hideGiftEffect");
					TweenLite.to(this, 0.1, {onComplete: function():void {vo.isPlay = false;}});
					var dataProxy:DataProxy = ApplicationFacade.getInstance().retrieveProxy(DataProxy.NAME) as DataProxy;
					dataProxy.messagePaneVO.content.dispatchEvent(new Event("updateEvent"));
					return;
				}
				
				//隐藏全屏礼物
				if (vo.giftData.type == 10) {
					ExternalInterface.call("DreamBoxEffect.hide");
					TweenLite.to(this, 0.1, {onComplete: function():void {vo.isPlay = false;}});
					return;
				}
				
				//筛子礼物
				if (vo.giftData.giftItemID == 46) {
					//rollPane.roll([vo.giftData.m_dice_val_1,vo.giftData.m_dice_val_2,vo.giftData.m_dice_val_3]);
					//rollPane.visible = true;
					ExternalInterface.call("DiceEffect.hide");
					TweenLite.to(this, 0.1, {onComplete: function():void {vo.isPlay = false;}});
					return;
				}
				
				vo.isPlay = false;
			}
			
		}

		/**
		 * 
		 */
		public function clearEffect():void {
			if (giftTipSprite != null) {
				if (giftTipSprite.parent != null) {
					giftTipSprite.parent.removeChild(giftTipSprite);
				}
				giftTipSprite = null;
			}

			this.removeEventListener(Event.ENTER_FRAME, playTipEnterFrame);

			if (swf != null) {
				
				if (this.contains(swf)) {
					swf.removeEventListener(Event.ENTER_FRAME, ef);
					this.removeChild(swf);
					swf.stop();
					swf = null;
				} else {
					new HoldEffectAni(vo.giftData, swf);
				}
			}
		}
	}
}


import flash.display.MovieClip;
import flash.events.Event;
import flash.external.ExternalInterface;

import model.DataProxy;
import model.data.GiftData;

class HoldEffectAni {
	/**
	 * 
	 * @param giftData
	 * @param swf
	 */
	public function HoldEffectAni(giftData:GiftData, swf:MovieClip):void {
		this.giftData = giftData;
		this.swf = swf;
		if (swf != null) {
			swf.addEventListener(Event.ENTER_FRAME, onSwfEnterFrame);
		}
	}

	private var giftData:GiftData;
	private var swf:MovieClip;

	private function onSwfEnterFrame(event:Event):void {
		if (swf.currentFrame == swf.totalFrames) {
			swf.removeEventListener(Event.ENTER_FRAME, onSwfEnterFrame);

			if (giftData != null) {
				//隐藏皮鞭页面的礼物效果
				if (giftData.giftItemID == 41) {
					ExternalInterface.call("MGC_Comm.hideGiftEffect");
					var dataProxy:DataProxy = ApplicationFacade.getInstance().retrieveProxy(DataProxy.NAME) as DataProxy;
					dataProxy.messagePaneVO.content.dispatchEvent(new Event("updateEvent"));
				}
				//隐藏全屏礼物
				else if (giftData.type == 10) {

					ExternalInterface.call("DreamBoxEffect.hide");
				}
				//筛子礼物
				else if (giftData.giftItemID == 46) {
					ExternalInterface.call("DiceEffect.hide");
				}
			}

			giftData = null;
			swf = null;
		}
	}
}
