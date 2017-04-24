package {

	import com.bit101.components.PushButton;
	import com.bit101.components.VBox;
	import com.junkbyte.console.Cc;
	
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.system.Security;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.setTimeout;
	
	import model.DataProxy;
	
	import view.components.*;

	//[SWF(width="550", height="600", frameRate="30", backgroundColor="#FFFFFF")]
	public class x51VideoGift extends Sprite {
		private var version_number:String        = "version:388.3.3.1";

		public var facade:ApplicationFacade;

		/**
		 * 已经移除flash区域了，有页面实现
		 */
		public var messageTip:TextField;

		//礼物消息区背景
		private var messageBackGround:Sprite;

		//底部背景
		private var bottomBackGround:Sprite;

		//竖排容器 礼物消息 礼物列表 操作区
		private var vbox:VBox;

		public var messagePane:MessagePane;

		public var giftPane:GiftPane;

		public var bottomPane:BottomPane;

		public var effectPane:EffectPane;

		public var numberPane:NumberPane;

		public var flyInputPane:FlyInputPane;

		public var facePane:FacePane;

		//周星礼物按钮
		public var weekStar:PushButton;

		//梦幻宝箱
		private var dreambox:DreamBoxPane;

		public function x51VideoGift() {
			Security.allowDomain("*");

			addEventListener(Event.ADDED_TO_STAGE, addStageHandler);
		}

		private function addStageHandler(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, addStageHandler);

			var lastIndex:int = stage.loaderInfo.url.indexOf("/", 7);
			DataProxy.Domain = stage.loaderInfo.url.substring(0, lastIndex);

			setTimeout(loadVersionConfigCompleted,500);
//			new VersionConfigLoader().loadConfig(loadVersionConfigCompleted, DataProxy.Domain + VersionConfigLoader.DEFAULT_CONFIG_URL);
			//new VersionConfigLoader().loadConfig(loadVersionConfigCompleted, "http://mgc.qq.com/config/client_version_config.xml?v=" + (new Date()).time);
		}

		private function loadVersionConfigCompleted():void {
			version_number = "version:395.8.2.1";
			//外网设置图片域地址
			DataProxy.ImgDomain = "http://ossweb-img.qq.com/images/mgc";
			//本地图片路径
			//DataProxy.ImgDomain = DataProxy.Domain + "/img";
			
			//初始化Log
			initLoggerConsole();
			
			//ExternalInterface.addCallback("showLog", showLog);
			//ExternalInterface.addCallback("hideLog", hideLog);

			initVersion();

			initApp();
		}

		private function initApp():void {
			var paramObj:Object = LoaderInfo(this.root.loaderInfo).parameters;
			if (paramObj.isCaveolae == "true") {
				DataProxy.isCaveolaeBo = true;
			} else {
				DataProxy.isCaveolaeBo = false;
			}

//			paramObj["skinId"] = 2;
//			paramObj["skinLevel"] = 2;

			if (paramObj.hasOwnProperty("skinId")) {
				DataProxy.skinId = parseInt(paramObj["skinId"], 10);
				if (DataProxy.skinId == DataProxy.SKIN_ID_1_STAGE) {
					DataProxy.skinTextBgColor = DataProxy.SKIN_1_TEXT_BG_COLOR;
				} else if (DataProxy.skinId == DataProxy.SKIN_ID_2_SEA) {
					DataProxy.skinTextBgColor = DataProxy.SKIN_2_TEXT_BG_COLOR;
				} else if (DataProxy.skinId == DataProxy.SKIN_ID_3_PARK) {
					DataProxy.skinTextBgColor = DataProxy.SKIN_3_TEXT_BG_COLOR;
				}
			} else {
				DataProxy.skinId = 0;
			}

			if (paramObj.hasOwnProperty("skinLevel")) {
				DataProxy.skinLevel = parseInt(paramObj["skinLevel"], 10);
			}

			DataProxy.videoGift = this;

			initUI();

			facade = ApplicationFacade.getInstance();
			facade.sendNotification(ApplicationFacade.STARTUP, this);

			/*var userData:SharedObject = SharedObject.getLocal("userData");
			userData.data.user = "jason";
			userData.flush();
			Cc.log(userData.data.user);*/

			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.RESIZE, resizeHandler);

			resizeUpdate();

			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			this.stage.addEventListener(MouseEvent.MOUSE_OVER, rollOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, rollOut);
			this.addEventListener(MouseEvent.CLICK, stageClick);

			ExternalInterface.addCallback("jsClick", jsClick);
		}

		private var isThis:Boolean               = false;

		private function rollOver(e:MouseEvent):void {
			isThis = true;
			//Cc.log("鼠标移入" + isThis);
		}

		private function rollOut(e:MouseEvent):void {
			isThis = false;
			//Cc.log("鼠标移出" + isThis);
		}

		//通知JS  flash舞台被点击
		private function stageClick(e:MouseEvent):void {
			//Cc.log("flash 调用js的flashClick()");
			ExternalInterface.call("flashClick");
		}

		//JS通知页面被点击
		private function jsClick():void {
//			stage.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			//Cc.log("js调用jsClick()");
			if (facade && !isThis) {
				//Cc.log("js调用jsClick()" + "  开始执行" + isThis);
				hideView();
			}
		}
		
		
		private function hideView():void
		{
			var dataProxy:DataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			dataProxy.numberPaneVO.visible = false;
			dataProxy.flyInputPaneVO.visible = false;
			dataProxy.facePaneVO.visible = false;
			dataProxy.bottomPaneVO.numSelected = false;
		}

		private function keyDownHandler(e:KeyboardEvent):void {
			//F5键强制刷新
			if (e.keyCode == 116) {
				ExternalInterface.call(" location.reload", true);
			}
		}

		private var resizeWidth:Number           = 0;
		private var resizeHeight:Number          = 0;

		private function resizeHandler(e:Event = null):void {
//			Cc.log("调整swf大小   " + stage.stageWidth + "     "+ stage.stageHeight);
//			Cc.log("调整swf大小   " + stage.width + "     "+ stage.height);
//			Cc.log("调整swf大小前   this的值 " + this.width + "     "+ this.height);
//			Cc.log("调整swf大小前   resizeWidth = " + resizeWidth + "     resizeHeight = "+ resizeHeight);
			if (Math.abs(stage.stageWidth - resizeWidth) > 3 || Math.abs(stage.stageHeight - resizeHeight) > 3) {
				resizeWidth = stage.stageWidth;
				resizeHeight = stage.stageHeight;
				resizeUpdate();
			}
		}

		private static const STAGE_MIN_WIDTH:int = 600;

		private function resizeUpdate():void {
			this.graphics.clear();
			if (DataProxy.isCaveolaeBo) {
				this.graphics.beginFill(0x0A0622, 0);
			} else {
				this.graphics.lineStyle(1, 0, 0.1);
				this.graphics.beginFill(0x0A0622);
			}
			this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			this.graphics.endFill();
//			Cc.log("查询调整大小后   " + this.width + "     "+ this.height);

			bottomBackGround.width = stage.stageWidth;
			bottomBackGround.y = stage.stageHeight - bottomBGHeight;
//			Cc.log("查询调整大小后   bottomBackGround = " + bottomBackGround.width + "     "+ bottomBackGround.height);
			messageBackGround.width = stage.stageWidth;
			messageBackGround.height = stage.stageHeight - bottomBGHeight;

			//周星礼物按钮位置
			weekStar.y = weekStarY;

			messagePane.setSize(stage.stageWidth, messagePaneHeight);
//			Cc.log("查询调整大小后   messagePane = " + messagePane.width + "     "+ messagePane.height);

//			giftPane.x = 40;
			giftPane.width = stage.stageWidth;
			giftPane.list.columnCount = Math.floor((stage.stageWidth - 50 - 26) / 50);
			giftPane.list.width = giftPane.list.columnCount * 50 + 5;
//			Cc.log("查询调整大小后   giftPane = " + giftPane.width + "     giftPane.list.width = "+ giftPane.list.width + "           giftPane.list.columnCount   " + giftPane.list.columnCount);

			messageTip.width = messageTip.textWidth + 5;
			messageTip.x = (messagePane.width - messageTip.width) / 2 - 10;
			messageTip.y = (messagePane.height - messageTip.height) / 2;

			effectPane.setSize(stage.stageWidth, stage.stageHeight - bottomBGHeight);

			flyInputPane.setSize(stage.stageWidth, 34);
			if (flyInputPane.visible) {
				flyInputPane.y = flyInputPane.stage.stageHeight - flyInputPane.height - 5;
			}

			dreambox.x = stage.stageWidth - dreambox.width - 10;

			onBottomPaneResize();
			
			var dataProxy:DataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			if (dataProxy != null && dataProxy.numberPaneVO.visible) {
				var p:Point  = new Point(bottomPane.btn_num.x, bottomPane.btn_num.y);
				var p1:Point = bottomPane.btn_num.localToGlobal(p);
				numberPane.x = p1.x - 56;
				numberPane.y = p1.y - dataProxy.numberPaneVO.numList.length * 20 - 5;
			}
		}

		private function onBottomPaneResize():void {
			if (bottomPane.width > 0) {
				var stageWidth:int = stage.stageWidth;
				if (stageWidth < STAGE_MIN_WIDTH) {
					stageWidth = STAGE_MIN_WIDTH;
				}
				if (stageWidth > bottomPane.getElementTotalWidth()) {
					var spacing:int = (stageWidth - bottomPane.getElementTotalWidth()) / 7;
					if (weekStar.parent != null && weekStar.visible) {
						if (spacing < weekStar.width) {
							spacing = (stageWidth - bottomPane.getElementTotalWidth() - weekStar.width * 2) / 5;
						}
					}

					if (spacing > 0) {
						bottomPane.spacing = spacing;
						if (weekStar.parent != null && weekStar.visible) {
							if (spacing < weekStar.width) {
								bottomPane.width = stageWidth - weekStar.width * 2;
							} else {
								bottomPane.width = stageWidth - spacing * 2;
							}
						} else {
							bottomPane.width = stageWidth - spacing * 2;
						}
					} else {
						bottomPane.spacing = 0;
						if (weekStar.parent != null && weekStar.visible) {
							bottomPane.width = stageWidth - weekStar.width * 2;
						}
					}
						//bottomPane.width = stage.stageWidth - weekStar.width * 2;
				} else {
					bottomPane.spacing = 0;
						//bottomPane.width = stage.stageWidth - weekStar.width * 2;
				}
				bottomPane.draw();
				bottomPane.x = (stage.stageWidth - bottomPane.width) / 2;
				bottomPane.y = bottomPaneY;
			}
		}

		private function initUI():void {
			//礼物消息区背景
			messageBackGround = createMessageBackGround();
			this.addChild(messageBackGround);
			//底部背景
			bottomBackGround = createBottomBackGround();
			this.addChild(bottomBackGround);

			messageTip = new TextField();
			var textFormat:TextFormat = new TextFormat();
			textFormat.font = "微软雅黑";
			textFormat.size = 14;
			textFormat.color = 0xffffff;
//			textFormat.bold = true;
			textFormat.align = TextFormatAlign.CENTER;
			textFormat.letterSpacing = 3;
			messageTip.mouseEnabled = true;
			messageTip.selectable = false;
//			messageTip.autoSize = TextFieldAutoSize.CENTER;
//			messageTip.defaultTextFormat = textFormat;
			messageTip.text = "还没人送礼哦~宝贝们的礼物快快刷起来吧！";
			messageTip.setTextFormat(textFormat);
			messageTip.width = messageTip.textWidth + 5;
			messageTip.height = messageTip.textHeight + 5;

			vbox = new VBox(this, 0, 0);
			vbox.alignment = VBox.CENTER;
			vbox.spacing = vboxSpacing;
			vbox.y = vboxY;

			//vbox.addChild(new MC_GiftCell_1);
			messagePane = new MessagePane(vbox);

			giftPane = new GiftPane(vbox);

			bottomPane = new BottomPane(this);
			bottomPane.y = bottomPaneY;

			weekStar = new PushButton(this, 0, this.stage.stageHeight - 83);
			weekStar.visible = false;
			setWeekStarSkin();
			weekStar.addEventListener(MouseEvent.CLICK, weekStarClick);

			effectPane = new EffectPane(this);
			flyInputPane = new FlyInputPane(this);
			messageTip.visible = false;
			this.addChild(messageTip);

			dreambox = new DreamBoxPane(this, this.stage.stageWidth - 110, 60);
			dreambox.source = DataProxy.ImgDomain + "/css_img/swf/dreambox.swf";

			numberPane = new NumberPane(this);
			facePane = new FacePane(this);

			this.addChild(CostTip.getInstance());

			shapePane.mouseEnabled = false;
			this.addChild(shapePane);

			this.addEventListener(Event.ENTER_FRAME, ef);
		}

		private var shapePane:Sprite             = new Sprite();

		private var lastWeekStarVisible:Boolean  = false;

		private function ef(e:Event):void {
//			onBottomPaneResize();
			shapePane.graphics.clear();
			shapePane.graphics.beginFill(0xff0000, 0);
			shapePane.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			shapePane.graphics.endFill();
			if (weekStar.parent != null) {
				if (lastWeekStarVisible != weekStar.visible) {
					lastWeekStarVisible = weekStar.visible;
					onBottomPaneResize();
				}
			} else {
				if (lastWeekStarVisible) {
					lastWeekStarVisible = false;
					onBottomPaneResize();
				}
			}
		}

		//点击周星礼物按钮	
		private function weekStarClick(e:MouseEvent):void {
			ExternalInterface.call("flashClick");
			e.stopImmediatePropagation();
			ExternalInterface.call("GiftRankPane.show", true);
			
			if (facade ) {
				hideView();
			}
		}


		private function initLoggerConsole():void {
			Cc.visible = true;
			Cc.config.style.big();
			Cc.config.style.whiteBase();
			Cc.config.style.backgroundAlpha = 1;
			Cc.width = 200;
			Cc.height = 100;
			Cc.x = 0;
			Cc.y = 0;
			Cc.start(this, "h3d.com");
		}

		private function showLog():void {
//			Cc.start(this);
		}

		private function hideLog():void {
//			Cc.remove();
		}

		private function initVersion():void {
			var myContextMenu:ContextMenu = new ContextMenu();
			myContextMenu.hideBuiltInItems();
			this.contextMenu = myContextMenu;

			var item:ContextMenuItem = new ContextMenuItem(version_number);
			myContextMenu.customItems.push(item);
		}

		//========================================================================
		//
		// 样式相关
		//
		//========================================================================
		private function createMessageBackGround():Sprite {
			if (DataProxy.isCaveolaeBo) {
				if (DataProxy.isSkinOpened) {
					if (DataProxy.skinId == DataProxy.SKIN_ID_1_STAGE) {
						return new Skin_1_MessagePaneBG();
					} else if (DataProxy.skinId == DataProxy.SKIN_ID_2_SEA) {
						return new Skin_2_MessagePaneBG();
					} else if (DataProxy.skinId == DataProxy.SKIN_ID_3_PARK) {
						return new Skin_3_MessagePaneBG();
					} else {
						return new Skin_1_MessagePaneBG();
					}
				} else {
					return new MC_MessagePane_5();
				}
			} else {
				return new MC_MessagePane_1();
			}
		}

		private function createBottomBackGround():Sprite {
			if (DataProxy.isCaveolaeBo) {
				if (DataProxy.isSkinOpened) {
					if (DataProxy.skinId == DataProxy.SKIN_ID_1_STAGE) {
						return new Skin_1_MC_BottomPane_BG();
					} else if (DataProxy.skinId == DataProxy.SKIN_ID_2_SEA) {
						return new Skin_2_BottomPane_BG();
					} else if (DataProxy.skinId == DataProxy.SKIN_ID_3_PARK) {
						return new Skin_3_BottomPane_BG();
					} else {
						return new Skin_1_MC_BottomPane_BG();
					}
				} else {
					return new MC_BottomPane_10();
				}
			} else {
				return new MC_BottomPane_5();
			}
		}

		private function setWeekStarSkin():void {
			if (DataProxy.isCaveolaeBo) {
				if (DataProxy.isSkinOpened) {
					if (DataProxy.skinId == DataProxy.SKIN_ID_1_STAGE) {
						weekStar.upSkin = new Skin_1_MC_WeekStar_1();
						weekStar.overSkin = new Skin_1_MC_WeekStar_2();
						weekStar.downSkin = new Skin_1_MC_WeekStar_3();
						weekStar.setSize(29, 88);
					} else if (DataProxy.skinId == DataProxy.SKIN_ID_2_SEA) {
						weekStar.upSkin = new Skin_2_WeekStar_Btn_Up();
						weekStar.overSkin = new Skin_2_WeekStar_Btn_Over();
						weekStar.downSkin = new Skin_2_WeekStar_Btn_Down();
						weekStar.setSize(29, 91);
					} else if (DataProxy.skinId == DataProxy.SKIN_ID_3_PARK) {
						weekStar.upSkin = new Skin_3_WeekStar_Btn_Up();
						weekStar.overSkin = new Skin_3_WeekStar_Btn_Over();
						weekStar.downSkin = new Skin_3_WeekStar_Btn_Down();
						weekStar.setSize(29, 88);
					} else {
						weekStar.upSkin = new Skin_1_MC_WeekStar_1();
						weekStar.overSkin = new Skin_1_MC_WeekStar_2();
						weekStar.downSkin = new Skin_1_MC_WeekStar_3();
						weekStar.setSize(29, 88);
					}
				} else {
					weekStar.upSkin = new MC_WeekStar_1();
					weekStar.overSkin = new MC_WeekStar_2();
					weekStar.downSkin = new MC_WeekStar_3();
					weekStar.setSize(22, 81);
				}
			} else {
				weekStar.upSkin = new MC_WeekStar_1();
				weekStar.overSkin = new MC_WeekStar_2();
				weekStar.downSkin = new MC_WeekStar_3();
				weekStar.setSize(22, 81);
			}
		}

		private function get bottomBGHeight():int {
			if (DataProxy.isCaveolaeBo) {
				if (DataProxy.isSkinOpened) {
					return 89 - 6;
				} else {
					return bottomBackGround.height;
				}
			} else {
				return bottomBackGround.height;
			}
		}

		private function get weekStarY():int {
			if (DataProxy.isCaveolaeBo) {
				if (DataProxy.isSkinOpened) {
					if (DataProxy.skinId == DataProxy.SKIN_ID_3_PARK) {
						return stage.stageHeight - 89 + 2;
					} else {
						return stage.stageHeight - 89;
					}
				} else {
					return stage.stageHeight - 82;
				}
			} else {
				return stage.stageHeight - 82;
			}
		}

		private function get messagePaneHeight():int {
			if (DataProxy.isCaveolaeBo) {
				if (DataProxy.isSkinOpened) {
					return stage.stageHeight - bottomBGHeight - 6 - vboxY;
				} else {
					return stage.stageHeight - bottomBGHeight;
				}
			} else {
				return stage.stageHeight - bottomBGHeight;
			}
		}

		private function get vboxSpacing():int {
			if (DataProxy.isCaveolaeBo) {
				if (DataProxy.isSkinOpened) {
					if (DataProxy.skinId == DataProxy.SKIN_ID_3_PARK) {
						return 4;
					} else {
						return 2;
					}
				} else {
					return 0;
				}
			} else {
				return 0;
			}
		}
		private function get vboxY():int {
			if (DataProxy.isCaveolaeBo) {
				if (DataProxy.isSkinOpened) {
					if (DataProxy.skinId == DataProxy.SKIN_ID_2_SEA) {
						return 17;
					} 
				} 
			}
			return 0;
		}
		
		private function get bottomPaneY():int{
			if (DataProxy.isCaveolaeBo) {
				if (DataProxy.isSkinOpened) {
					if (DataProxy.skinId == DataProxy.SKIN_ID_2_SEA) {
						return this.stage.stageHeight - 32;
					} else if (DataProxy.skinId == DataProxy.SKIN_ID_3_PARK) {
						return this.stage.stageHeight - 33;
					}
				}
			}
			return this.stage.stageHeight - 35;
		}
	}
}
