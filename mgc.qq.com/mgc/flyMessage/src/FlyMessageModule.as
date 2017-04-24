package {

	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import gl.fm.ResGetter;
	import gl.fm.data.FlyScreenMsgData;
	import gl.fm.data.RocketData;
	import gl.fm.view.FlyScreenMsgItem;
	import gl.fm.view.RocketItem;

	public class FlyMessageModule extends Sprite {
		public function FlyMessageModule() {
			if (stage == null) {
				this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			} else {
				onAddedToStage(null);
			}
		}

		public static const MOVE_SPEED:int                 = 2;
		public static const FLY_ITEM_INTERVAL:int          = 120;
		public static const ROKECT_ITEM_INTERVAL:int       = 120;

		private var initedJSFun:Boolean                    = false;
		private var isConcert:Boolean                      = false;
		private var viewWidth:int;
		private var viewHeight:int;

		/**
		 * 飞屏数据编号
		 */
		private var flyItemNum:int                         = 0;
		/**
		 * 飞屏数据列表
		 */
		private var flyItemDataList:Array                  = [];
		private var flyItemList:Array                      = [];
		/**
		 * 火箭数据编号
		 */
		private var rocketNum:int                          = 0;
		/**
		 * 火箭数据列表
		 */
		private var rocketDataList:Array                   = [];
		private var rocketItemList:Array                   = [];

		private static const FLY_ITEM_ADJUST_Y:int         = 55;
		private static var FLY_ITEM_PY_LIST:Array          = [10, 62, 282, 332];
		private static const ROKECT_ITEM_Y:int             = 10;
		private var rowItemCountList:Array                 = [0, 0, 0, 0];

		private var aniTimer:Timer                         = new Timer(20); //20, 100;

		private static const isDebug:Boolean               = false;

		private function onAddedToStage(event:Event):void {
			if (event != null) {
				this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			}
			
			initVersion();
			
			var paramObj:Object = LoaderInfo(this.root.loaderInfo).parameters;
			if (paramObj.isConcert == "true") {
				isConcert = true;
			} else {
				isConcert = false;
			}
			jsCallOpenModule(isConcert);

			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.frameRate = 30;
			this.mouseEnabled = false;

			initExternalJSFun();

			this.stage.addEventListener(Event.RESIZE, onStageResize);

			aniTimer.addEventListener(TimerEvent.TIMER, onAniMoveTimer);

			if (isDebug) {
				test();
			}
//			testLoadIcon();
		}
		
		private function initVersion():void {
			var myContextMenu:ContextMenu = new ContextMenu();
			myContextMenu.hideBuiltInItems();
			this.contextMenu = myContextMenu;
			
			var item:ContextMenuItem = new ContextMenuItem("1.0");
			myContextMenu.customItems.push(item);
		}

		private function onStageResize(event:Event):void {
			viewWidth = stage.stageWidth;
			viewHeight = stage.stageHeight;
		}

		private function test():void {
			var testDataList:Array = [
				{senderName: "test111", senderdefend: "0", viplevel: "0", wealth_level: "0", isTakeVip: false, isSelf: "0", MsgStr: "wwwwwwwwwwwwwWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"},
				{senderName: "test222", senderdefend: "10", viplevel: "1", wealth_level: "1", isTakeVip: false, isSelf: "0", MsgStr: "<img src='http://ossweb-img.qq.com/images/mgc/css_img/chat/chat_f01.gif' width='20' height='20' alt='' >"},
				{senderName: "test33", senderdefend: "20", viplevel: "2", wealth_level: "2", isTakeVip: false, isSelf: "0", MsgStr: "wwwwwwwwwwwwwWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"},
				{senderName: "test44", senderdefend: "50", viplevel: "3", wealth_level: "3", isTakeVip: false, isSelf: "0", MsgStr: "wwwwwwwwwwwwwWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"},
				{senderName: "test555", senderdefend: "100", viplevel: "4", wealth_level: "4", isTakeVip: false, isSelf: "0", MsgStr: "wwwwwwwwwwwwwWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"},
				{senderName: "test666", senderdefend: "200", viplevel: "5", wealth_level: "5", isTakeVip: false, isSelf: "0", MsgStr: "wwwwwwwwwwwwwWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"},
				{senderName: "test777", senderdefend: "300", viplevel: "4", wealth_level: "6", isTakeVip: false, isSelf: "0", MsgStr: "wwwwwwwwwwwwwWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"},
				{senderName: "test888", senderdefend: "400", viplevel: "3", wealth_level: "7", isTakeVip: false, isSelf: "0", MsgStr: "wwwwwwwwwwwwwWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"},
				{senderName: "test99", senderdefend: "500", viplevel: "2", wealth_level: "8", isTakeVip: false, isSelf: "0", MsgStr: "wwwwwwwwwwwwwWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"},
				{senderName: "testaaa", senderdefend: "500", viplevel: "1", wealth_level: "9", isTakeVip: false, isSelf: "0", MsgStr: "wwwwwwwwwwwwwWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"},
				{senderName: "testbbb", senderdefend: "400", viplevel: "5", wealth_level: "9", isTakeVip: false, isSelf: "0", MsgStr: "wwwwwwwwwwwwwWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"},
				{senderName: "testccc", senderdefend: "400", viplevel: "3", wealth_level: "7", isTakeVip: true, isSelf: "3", MsgStr: "wwwwwwwwwwwwwWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"},
				{senderName: "testddd", senderdefend: "500", viplevel: "2", wealth_level: "8", isTakeVip: true, isSelf: "4", MsgStr: "wwwwwwwwwwwwwWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"},
				{senderName: "testeee", senderdefend: "500", viplevel: "1", wealth_level: "9", isTakeVip: true, isSelf: "3", MsgStr: "wwwwwwwwwwwwwWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"},
				{senderName: "testfff", senderdefend: "400", viplevel: "5", wealth_level: "9", isTakeVip: true, isSelf: "4", MsgStr: "<img src='http://ossweb-img.qq.com/images/mgc/css_img/chat/chat_f01.gif' width='20' height='20' alt='' >"}];

			for each (var obj:Object in testDataList) {
				jsCallAddFlyScreenMsg(obj, true);
			}

			var testRocketDataList:Array = [
				{anchor_name: "80533-相公", guard_level: 400, is_nest: true, player_name: "gl_ak", player_zone: "梦工厂", rocket_cnt: 1, room_id: 101500, vip_level: 1, wealth_level: 9},
				{anchor_name: "80533-相公", guard_level: 500, is_nest: true, player_name: "梦工厂gl_ak", player_zone: "梦工厂", rocket_cnt: 100, room_id: 101500, vip_level: 2, wealth_level: 8},
				{anchor_name: "80533-相公", guard_level: 300, is_nest: true, player_name: "gl_ak", player_zone: "梦工厂", rocket_cnt: 30, room_id: 101500, vip_level: 3, wealth_level: 7},
				{anchor_name: "80533-相公", guard_level: 200, is_nest: true, player_name: "梦工厂gl_ak", player_zone: "梦工厂", rocket_cnt: 66, room_id: 101500, vip_level: 4, wealth_level: 6},
				{anchor_name: "80533-相公", guard_level: 100, is_nest: true, player_name: "gl_ak", player_zone: "梦工厂", rocket_cnt: 888, room_id: 101500, vip_level: 5, wealth_level: 5},
				{anchor_name: "80533-相公", guard_level: 50, is_nest: true, player_name: "梦工厂gl_ak", player_zone: "梦工厂", rocket_cnt: 15, room_id: 101500, vip_level: 4, wealth_level: 4},
				{anchor_name: "80533-相公", guard_level: 10, is_nest: true, player_name: "gl_ak", player_zone: "梦工厂", rocket_cnt: 88, room_id: 101500, vip_level: 3, wealth_level: 3}];

			for each (var rocketObj:Object in testRocketDataList) {
				jsCallAddRocketMsg(rocketObj);
			}
		}

		private function testLoadIcon():void {
			var d1:DisplayObject = ResGetter.getGifPlayer("res/chat_f0.gif");
			d1.x = 100;
			d1.y = 10;
			this.addChild(d1);

			var d2:DisplayObject = ResGetter.getPNG("res/chat_h0.png");
			d2.x = 50;
			d2.y = 30;
			this.addChild(d2);

			setTimeout(testLoadGif, 5000);
		}

		private function testLoadGif():void {
			var d1:DisplayObject = ResGetter.getGifPlayer("res/chat_f0.gif");
			d1.x = 100;
			d1.y = 40;
			this.addChild(d1);
		}

		private function initExternalJSFun():void {
			if (ExternalInterface.available) {
				initedJSFun = true;
				//TODO 添加一些数据
//				ExternalInterface.addCallback("viewResize", jsCallViewResize);
				ExternalInterface.addCallback("addFlyScreenMsg", jsCallAddFlyScreenMsg);
				ExternalInterface.addCallback("addRocketScreenMsg", jsCallAddRocketMsg);

				ExternalInterface.addCallback("openModule", jsCallOpenModule);
			} else {
				setTimeout(initExternalJSFun, 500);
			}
		}

		private function jsCallViewResize(vWidth:int, vHeight:int):void {
			viewWidth = vWidth;
			viewHeight = viewHeight;
		}

		private function jsCallAddFlyScreenMsg(data:Object, isDef:Boolean):void {
			flyItemDataList.push(new FlyScreenMsgData(data, isDef, flyItemNum));
			flyItemNum++;
			//排序 自己->别人->数据顺序
			flyItemDataList.sortOn(["isSelf", "isOther", "num"], [Array.DESCENDING, Array.DESCENDING, Array.NUMERIC]);

			if (aniTimer.running == false) {
				aniTimer.reset();
				aniTimer.start();
			}
		}

		private function jsCallAddRocketMsg(data:Object):void {
			rocketDataList.push(new RocketData(data));
			if (aniTimer.running == false) {
				aniTimer.reset();
				aniTimer.start();
			}
		}

		private function jsCallOpenModule(isConcert:Boolean):void {
			this.isConcert = isConcert;
			if (isConcert) {
				FLY_ITEM_PY_LIST = [10, 50, 90, 130];
			} else {
				FLY_ITEM_PY_LIST = [10, 50, 90, 130];
			}
			_timerStart = getTimer();
			_timer = getTimer();
		}

		/**
		 * 重置飞屏消息列表。
		 *
		 */
		private function resetFlyMsgList():void {

		}

		private var _frames:int;
		private var _framesTotal:int;
		private var _timer:int;
		private var _timerStart:int;

		private var hasAni:Boolean                         = false;

		private static const FLY_ITEM_TIME_INTERVAL:int    = 5000;
		private static const ROKECT_ITEM_TIME_INTERVAL:int = 5000;

		private var lastAniTime:int                        = 0;
		private var flyItemTimeCount:int                   = 0;
		private var rokectItemTimeCount:int                = 0;

		private var timerCount:int                         = 0;
		private var timerTotalCount:int                    = 0;
		private var timerLastTime:int                      = 0;

		private function onAniMoveTimer(event:TimerEvent):void {
			if (viewWidth < 300) {
				return;
			}
			if (lastAniTime == 0) {
				lastAniTime = getTimer();
				return;
			}

			var ct:int = getTimer();
			var dt:int = ct - lastAniTime;
			lastAniTime = ct;

			if (flyItemList.length > 0 || rocketItemList.length > 0) {
				for (var fi:int = flyItemList.length - 1; fi >= 0; fi--) {
					var flyItem:FlyScreenMsgItem = flyItemList[fi];
					flyItem.move(dt);
					if (flyItem.x + flyItem.getMessageWidth() <= 0) {
						flyItemList.splice(fi, 1);
						destroyFlyItem(flyItem);
					}
				}

				for (var ri:int = rocketItemList.length - 1; ri >= 0; ri--) {
					var rocketItem:RocketItem = rocketItemList[ri];
					rocketItem.move(dt);
					if (rocketItem.x + rocketItem.width <= 0) {
						rocketItemList.splice(ri, 1);
						destroyRocketItem(rocketItem);
					}
				}
			}

			flyItemTimeCount -= dt;
			if (flyItemTimeCount <= 0) {
				if (showNextFlyItem()) {
					hasAni = true;
					flyItemTimeCount = FLY_ITEM_TIME_INTERVAL;
				} else {
					flyItemTimeCount = 0;
				}
			}
			rokectItemTimeCount -= dt;
			if (rokectItemTimeCount <= 0) {
				if (showNextRokectItem()) {
					hasAni = true;
					rokectItemTimeCount = ROKECT_ITEM_TIME_INTERVAL;
				} else {
					rokectItemTimeCount = 0;
				}
			}

			if (hasAni) {
				if (flyItemList.length == 0 && rocketItemList.length == 0
					&& flyItemDataList.length == 0 && rocketDataList.length == 0) {
					if (ExternalInterface.available) {
						ExternalInterface.call("MGC_Comm.hideFlyScreenSwf");
					}

					if (isDebug) {
						test();
					} else {
						hasAni = false;
						aniTimer.stop();
					}
				}
			}

			if (needNotifyRokectAniChange) {
				if (rocketItemList.length == 0 && rocketDataList.length == 0) {
					if (ExternalInterface.available) {
						ExternalInterface.call("MGC_Comm.closeRocketPolicy");
					}
					needNotifyRokectAniChange = false;
				}
			}

			event.updateAfterEvent();
		}

		//标准20秒走1920像素
		public static const MOVE_S:int                     = 20;
		public static const MOVE_D:int                     = 1920;

		private function getMoveTime(sp:int, tp:int):Number {
			var dist:int = Math.abs(tp - sp);
			try {
				return dist / MOVE_D * MOVE_S;
			} catch (error:Error) {

			}
			return 20;
		}

		private function showNextFlyItem():Boolean {
			if (flyItemDataList.length > 0) {
				if (flyItemList.length < FLY_ITEM_PY_LIST.length) {
					//需求：1.不能和上一条在一行；2.不能和同一行上的消息重合。
					var rowIndex:int = findFlyRowIndex();
					if (rowIndex >= 0) {
						var flyItem:FlyScreenMsgItem = getFlyItemByCache();
						flyItem.init(flyItemDataList.shift(), isConcert, rowIndex);
						flyItem.x = viewWidth;
						flyItem.y = FLY_ITEM_PY_LIST[rowIndex] + FLY_ITEM_ADJUST_Y;
						this.addChild(flyItem);
						var targetX:int = -flyItem.getMessageWidth() - 100;
						flyItem.start(viewWidth, targetX);
						flyItemList.push(flyItem);
						rowItemCountList[rowIndex] += 1;
//						trace("+++ " + rowItemCountList);
						return true;
					}
				}
			}
			return false;
		}

		private function findFlyRowIndex():int {
			if (flyItemList.length > 0) {
				//需求：1.不能和上一条在一行；2.不能和同一行上的消息重合。
				var lastFlyItem:FlyScreenMsgItem = flyItemList[flyItemList.length - 1];
				var rowList:Array                = [];
//				trace(rowItemCountList);
				for (var i:int = 0; i < rowItemCountList.length; i++) {
					if (i != lastFlyItem.rowIndex) {
						if (rowItemCountList[i] == 0) {
							rowList.push(i);
						} else {
							var item:FlyScreenMsgItem;
							for each (var fItem:FlyScreenMsgItem in flyItemList) {
								if (fItem.rowIndex == i) {
									item = fItem;
									break;
								}
							}
							if (item != null) {
								if (item.x + item.getMessageWidth() + 60 < viewWidth) {
									rowList.push(i);
								}
							} else {
								rowItemCountList[i] = 0;
								rowList.push(i);
							}
						}
					}
				}
				if (rowList.length > 0) {
					return rowList[int(rowList.length * Math.random())]
				} else {
					return -1;
				}
//				do {
//					flyItem.y = FLY_ITEM_PY_LIST[int(Math.random() * FLY_ITEM_PY_LIST.length)] + FLY_ITEM_ADJUST_Y;
//				} while (int(flyItem.y) == int(lastFlyItem.y));
			} else {
				return int(FLY_ITEM_PY_LIST.length * Math.random());
			}
		}

		private var flyItemCache:Array                     = [];
		private function getFlyItemByCache():FlyScreenMsgItem {
			var flyItem:FlyScreenMsgItem;
			if (flyItemCache.length > 0) {
				flyItem = flyItemCache.pop() as FlyScreenMsgItem;
			} else {
				flyItem = new FlyScreenMsgItem();
			}
			return flyItem;
		}

		private function destroyFlyItem(item:FlyScreenMsgItem):void {
			if (item.parent != null) {
				item.parent.removeChild(item);
			}
			item.dispose();
			rowItemCountList[item.rowIndex] -= 1;

			flyItemCache.push(item);
		}

		private var needNotifyRokectAniChange:Boolean      = false;
		private function showNextRokectItem():Boolean {
			if (rocketDataList.length > 0) {
				needNotifyRokectAniChange = true;
				if (rocketItemList.length < 2) {
					var rocketItem:RocketItem;
					if (rocketItemList.length > 0) {
						var lastRocketItem:RocketItem = rocketItemList[rocketItemList.length - 1];
						if (lastRocketItem.x + lastRocketItem.getBGWidth() + 80 > viewWidth) {
							return false;
						}
					}

					rocketItem = getRocketItemByCache();
					rocketItem.init(rocketDataList.shift());
					rocketItem.y = ROKECT_ITEM_Y;
					rocketItem.x = viewWidth;
//					this.addChild(rocketItem);
					this.addChildAt(rocketItem, 0);
					var targetX:int = -rocketItem.getBGWidth() - 100;
					rocketItem.start(viewWidth, targetX);
					rocketItemList.push(rocketItem);
					return true;
				}
			}
			return false;
		}

		private var rocketItemCache:Array                  = [];
		private function getRocketItemByCache():RocketItem {
			var rocketItem:RocketItem;
			if (rocketItemCache.length > 0) {
				rocketItem = rocketItemCache.pop() as RocketItem;
			} else {
				rocketItem = new RocketItem();
			}
			return rocketItem;
		}

		private function destroyRocketItem(item:RocketItem):void {
			if (item.parent != null) {
				item.parent.removeChild(item);
			}
			item.dispose();
			rocketItemCache.push(item);
		}
	}
}
