package view.components {

	import com.bit101.components.ListItem;
	import com.bit101.components.Style;
	import com.bit101.utils.OverrideBulkLoader;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import model.DataProxy;
	import model.data.GiftVO;

	public class GiftCell extends ListItem {
		
		static public var defaultIcon:String = "http://ossweb-img.qq.com/images/mgc/css_img/flash/gift/gift_default.png";
		
		private var bulkLoader:OverrideBulkLoader = OverrideBulkLoader.getInstance();

		private var text_num:TextField;

		private var mc_GiftCell_1:Sprite;

		private var mc_lock:MC_Lock;

		private var mc_GiftStar:MC_GiftStar;
		
		private var mc_pk:MC_PK;

		/**
		 * 置灰滤镜
		 */
		private var filter:ColorMatrixFilter = new ColorMatrixFilter([0.3, 0.6, 0, 0, 0, 0.3, 0.6, 0, 0, 0, 0.3, 0.6, 0, 0, 0, 0, 0, 0, 1, 0]);

		public function GiftCell(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, data:Object = null) {
			super(parent, xpos, ypos, data);

			if (DataProxy.isCaveolaeBo) {
				if (DataProxy.isSkinOpened) {
					if (DataProxy.skinId == DataProxy.SKIN_ID_1_STAGE) {
						mc_GiftCell_1 = new Skin_1_MC_Gift_Cell_Frame();
						mc_GiftCell_1.x = 0;
						mc_GiftCell_1.y = 0;
					} else if (DataProxy.skinId == DataProxy.SKIN_ID_2_SEA) {
						mc_GiftCell_1 = new Skin_2_GiftCell_Frame();
						mc_GiftCell_1.x = 0;
						mc_GiftCell_1.y = 0;
					} else if (DataProxy.skinId == DataProxy.SKIN_ID_3_PARK) {
						mc_GiftCell_1 = new Skin_3_GiftCell_Frame();
						mc_GiftCell_1.x = 0;
						mc_GiftCell_1.y = 0;
					} else {
						mc_GiftCell_1 = new Skin_1_MC_Gift_Cell_Frame();
						mc_GiftCell_1.x = 0;
						mc_GiftCell_1.y = 0;
					}
				} else {
					mc_GiftCell_1 = new MC_GiftCell_2();
					mc_GiftCell_1.x = 1;
					mc_GiftCell_1.y = 1;
				}
			} else {
				mc_GiftCell_1 = new MC_GiftCell_1();
				mc_GiftCell_1.x = 0;
				mc_GiftCell_1.y = 0;
			}

			initUI();
		}

		private var textFormat:TextFormat;
		private var bg:Shape;

		public function initUI():void {
			this.addEventListener(MouseEvent.CLICK, clickHandler);

			var offsetY:int = 0;
			if (BottomPane.isOSMac) {
				offsetY += BottomPane.macTextOffsetY;
			}
			if (BottomPane.IsSafari) {
				offsetY += 1;
			}
			//礼物数量
			text_num = new TextField();
			text_num.embedFonts = Style.embedFonts;
			text_num.selectable = false;
			text_num.mouseEnabled = false;
			textFormat = new TextFormat("微软雅黑", 12, 0xfaf8fc);
			textFormat.align = TextFormatAlign.CENTER;
			text_num.defaultTextFormat = textFormat;
			text_num.width = 20;
			text_num.x = 35;
			text_num.y = offsetY;

			bg = new Shape();
			bg.graphics.beginFill(0xef2017);
			bg.graphics.drawCircle(5, 10, 10);
			bg.graphics.endFill();
			bg.x = 40;

			this.buttonMode = true;

		}

		/**
		 * Draws the visual ui of the component.
		 */
		public override function draw():void {
			if (_data == null) {
				return;
			}

			/**
			 * 移除全部显示对象
			 */
			while (this.numChildren > 0) {
				var disObj:DisplayObject = this.removeChildAt(0);
				disObj = null;
			}


			//bulkLoader = OverrideBulkLoader.getInstance();

			/**
			 * 移除bulkLoader监听
			 */

			if (bulkLoader.hasItem(data.icon)) {
				initIcon();
			} else {
				bulkLoader.add(data.icon, null, onComplete,onError);
			}
		}
		
		/**
		 * 礼物图片加载失败
		 * 显示默认图标
		 */
		private function onError():void {
			data.icon = defaultIcon;
		}

		/**
		 * 礼物图片加载完毕
		 */
		private function onComplete(data:Object = null):void {
			initIcon();
		}


		private function initIcon():void {
			var icon:Bitmap = bulkLoader.getBitmap(data.icon);
			if(!icon)return;
			icon.width = 35;
			icon.height = 35;
			icon.x = (width - icon.width) / 2;
			icon.y = (height - icon.height) / 2
			this.addChild(icon);

			//免费礼物 显示右上角的数量
			if (_data.type == 1 || _data.type == 6 || (_data as GiftVO).skinsubject > 0) {
				var tmpnum:int = _data.num;
				if (tmpnum <= 99) {
					text_num.text = String(tmpnum);
				} else {
					text_num.text = "99";
				}
//				text_num.text = String(_data.num);
//				addChild(text_num);
				this.addChild(bg);
				this.addChild(text_num);
				
			}else{
//				_data.type == 2 || _data.type == 3 || _data.type == 4 || _data.type == 5 || _data.type == 7 
				var tmpnum:int = _data.num;
//				tmpnum = 3;
				if(tmpnum > 0){
					if (tmpnum <= 99) {
						text_num.text = String(tmpnum);
					} else {
						text_num.text = "99";
					}
					this.addChild(bg);
					this.addChild(text_num);
				}
			}

			//是否置灰
			if (_data.enabled) {
				//免费礼物数量为0置灰
				if (_data.type == 1 && _data.num == 0) {
					icon.filters = [filter];

					text_num.visible = false;
					bg.visible = false;
				} else {
					icon.filters = [];

					text_num.visible = true;
					bg.visible = true;
				}
			} else {
				icon.filters = [filter];

				text_num.visible = false;
				bg.visible = false;

				if (_data.isLock) {
					if (!mc_lock) {
						mc_lock = new MC_Lock();
						mc_lock.x = (width - mc_lock.width) / 2;
						mc_lock.y = (height - mc_lock.height) / 2;
						mc_lock.mouseEnabled = false;
					}
					text_num.visible = true;
					bg.visible = true;

					addChild(mc_lock);
				}
			}

			if (_data.isStar) {
				if (!mc_GiftStar) {
					mc_GiftStar = new MC_GiftStar();
					mc_GiftStar.x = -1;
					mc_GiftStar.mouseEnabled = false;
				}

				addChild(mc_GiftStar);
			}
			
			if(_data.isPK)
			{
				if (!mc_pk) {
					mc_pk = new MC_PK();
					mc_pk.x = -1;
					mc_pk.mouseEnabled = false;
				}
				addChild(mc_pk);
			}

			if (_data.type == 6 && _data.num != 0) {
				text_num.visible = true;
				bg.visible = true;
			} else if (_data.type == 6 && _data.num == 0) {
				text_num.visible = false;
				bg.visible = false;
			}

			mc_GiftCell_1.mouseChildren = false;
			mc_GiftCell_1.mouseEnabled = false;
			addChildAt(mc_GiftCell_1, 0);

			if (_selected) {
				//graphics.beginFill(_selectedColor);
				mc_GiftCell_1.visible = true;
			} else if (_mouseOver) {
				/*graphics.lineStyle(2,0x000000);
				graphics.drawRoundRect(5,5,40,40,20,20);
				graphics.endFill();*/
				//graphics.beginFill(_rolloverColor);

				mc_GiftCell_1.visible = true;
			} else {
				//graphics.beginFill(_defaultColor);
				mc_GiftCell_1.visible = false;
			}
		}

		private function clickHandler(e:MouseEvent):void {
			if (!_data.enabled) {
				e.stopImmediatePropagation();
			}
		}

		/**
		 * 数据更新后显示也更新
		 */
		private function drawHandler(e:Event):void {
			draw();
		}


		/**
		 * Sets/gets the string that appears in this item.
		 */
		public override function set data(value:Object):void {
			//移除之前的监听
			if (_data) {
				if ((_data as GiftVO).hasEventListener("draw")) {
					(_data as GiftVO).removeEventListener("draw", drawHandler);
				}
			}

			_data = value;

			//监听新的数据更新事件
			if (_data) {
				(_data as GiftVO).addEventListener("draw", drawHandler);
			}
			
			invalidate();
		}

	}
}
