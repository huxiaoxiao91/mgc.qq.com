package com.h3d.video
{
	import com.bit101.components.Component;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import gs.TweenLite;
	
	/**
	 * 
	 * 走马灯
	 * 
	 * 160527 XW78256 更改走马灯实现方式，使用定时器计算方法，帧动画运行速度会受到运行效率影响。
	 * 
	 */	
	public class MarqueePane extends Component
	{
		/**
		 * 走马灯对象池  2个
		 */
		private var objArr:Array;
		
		/**
		 * 走马灯队列
		 */
		private var marqueeArr:Array = [];
		
		private var index:int = 0;
		
		private var canPlay:Boolean = true;
		
		private var background:Shape = new Shape();
		
		private var stop:Boolean = true;
		
		/*private var giftIcon:Array = [
			gift_1,gift_2,gift_3,gift_4,gift_5,gift_6,gift_7,gift_8,gift_9,
			gift_10,gift_11,gift_12,gift_14,gift_15,gift_16,gift_17,gift_18,gift_19,
			gift_20,gift_22,
			gift_30,gift_31,gift_32,gift_33,gift_34,gift_37,gift_38,gift_39,
			gift_40,gift_41,gift_42,gift_43,gift_44,gift_45,gift_46,gift_47,gift_48,gift_49,
			gift_50,gift_51,gift_52,gift_53,gift_54,
			gift_99,gift_100,gift_200,gift_201,gift_202,gift_300
		];*/
		
		static private var giftIcons:Object = {};
		
		public function MarqueePane(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			
			initUI();
			
			initGift();
			
			ExternalInterface.addCallback("addMarquee", add);
		}
		
		private var aniTimer:Timer = new Timer(16.6);
		private function initUI():void
		{
			//this.cacheAsBitmap = true;
			
			background.graphics.clear();
			background.graphics.beginFill(0xea7756);
			background.graphics.drawRect(0,0,2000,38);
			background.graphics.endFill();
			background.alpha = 0;
			addChild(background);
			
			objArr = new Array();
			
			for(var i:int = 0;i<4;i++)
			{
				var marqueeCell:MarqueeCell = new MarqueeCell(this,0,5);
				objArr.push(marqueeCell);
			}
			
			
//			for(var i:int = 0;i<4;i++)
//			{
//				//add("aaaaaaaaaaaa#IMG?type=rank_icon&a=3&b=1#bbbbbbbbbbbb   " + i.toString());
//			}
			
//			this.addEventListener(Event.ENTER_FRAME,ef);
			aniTimer.addEventListener(TimerEvent.TIMER, onAniMoveTimer);
		}
		
		/**
		 * 添加走马灯
		 */ 
		public function add(text:String):void
		{
			marqueeArr.push(text);
			play();
			
			
			if(aniTimer.running == false){
				aniTimer.reset();
				aniTimer.start();
			}
			
			
			if(stop)
			{
				stop = false;
				TweenLite.to(background,0.5,{alpha:1});
			}
		}
		
		private function play():void
		{
			if(marqueeArr.length == 0)return;
			
			if(!canPlay)return;
			
			canPlay = false;
			
			var text:String = marqueeArr.shift();
			index = getNextIndex();
			MarqueeCell(objArr[index]).startTime = getTimer();
			MarqueeCell(objArr[index]).startX = width;
			MarqueeCell(objArr[index]).setText(text);
			MarqueeCell(objArr[index]).x = width;
		}
		
		private function getNextIndex():int
		{
			var i:int = index + 1;
			return i==objArr.length ? 0:i;
		}
		
		private function ef(e:Event):void
		{
			if(stop)return;
			
			for(var i:int = 0;i<objArr.length;i++)
			{
				objArr[i].x -= 1;
			}
			
			if((width - (objArr[index].x + objArr[index].width)) > 200)
			{
				canPlay = true;
				play();
			}
			
			if((objArr[index].x + objArr[index].width)<0)
			{
				stop = true;
				TweenLite.to(background,0.5,{alpha:0});
			}
		}

		/**
		 * 每秒走多少像素
		 */		
		private static const MOVE_SPEED_PER_SECOND:int = 60;
		private function onAniMoveTimer(event:TimerEvent):void {
			if (stop)
				return;
			
			var ct:int = getTimer();

			for (var i:int = 0; i < objArr.length; i++) {
				objArr[i].x =  MarqueeCell(objArr[i]).startX - MOVE_SPEED_PER_SECOND * (ct - MarqueeCell(objArr[i]).startTime) / 1000;
			}

			if ((width - (objArr[index].x + objArr[index].width)) > 200) {
				canPlay = true;
				play();
			}

			if ((objArr[index].x + objArr[index].width) < 0) {
				stop = true;
				if(aniTimer.running){
					aniTimer.stop();
				}
				TweenLite.to(background, 0.5, {alpha: 0});
			}
			
			event.updateAfterEvent();
		}
		
		private function initGift():void
		{
			giftIcons["gift_1"] = new gift_1();
			giftIcons["gift_2"] = new gift_2();
			giftIcons["gift_3"] = new gift_3();
			giftIcons["gift_4"] = new gift_4();
			giftIcons["gift_5"] = new gift_5();
			giftIcons["gift_6"] = new gift_6();
			giftIcons["gift_7"] = new gift_7();
			giftIcons["gift_8"] = new gift_8();
			giftIcons["gift_9"] = new gift_9();
			
			giftIcons["gift_10"] = new gift_10();
			giftIcons["gift_11"] = new gift_11();
			giftIcons["gift_12"] = new gift_12();
			giftIcons["gift_14"] = new gift_14();
			giftIcons["gift_15"] = new gift_15();
			giftIcons["gift_16"] = new gift_16();
			giftIcons["gift_17"] = new gift_17();
			giftIcons["gift_18"] = new gift_18();
			giftIcons["gift_19"] = new gift_19();
			
			giftIcons["gift_20"] = new gift_20();
			giftIcons["gift_22"] = new gift_22();
			
			giftIcons["gift_30"] = new gift_30();
			giftIcons["gift_31"] = new gift_31();
			giftIcons["gift_32"] = new gift_32();
			giftIcons["gift_33"] = new gift_33();
			giftIcons["gift_34"] = new gift_34();
			giftIcons["gift_37"] = new gift_37();
			giftIcons["gift_38"] = new gift_38();
			giftIcons["gift_39"] = new gift_39();
			
			giftIcons["gift_40"] = new gift_40();
			giftIcons["gift_41"] = new gift_41();
			giftIcons["gift_42"] = new gift_42();
			giftIcons["gift_43"] = new gift_43();
			giftIcons["gift_44"] = new gift_44();
			giftIcons["gift_45"] = new gift_45();
			giftIcons["gift_46"] = new gift_46();
			giftIcons["gift_47"] = new gift_47();
			giftIcons["gift_48"] = new gift_48();
			giftIcons["gift_49"] = new gift_49();
			
			giftIcons["gift_50"] = new gift_50();
			giftIcons["gift_51"] = new gift_51();
			giftIcons["gift_52"] = new gift_52();
			giftIcons["gift_53"] = new gift_53();
			giftIcons["gift_54"] = new gift_54();
			
			giftIcons["gift_99"] = new gift_99();
			giftIcons["gift_100"] = new gift_100();
			giftIcons["gift_200"] = new gift_200();
			giftIcons["gift_201"] = new gift_201();
			giftIcons["gift_202"] = new gift_202();
			giftIcons["gift_300"] = new gift_300();
		}
		
		static public function getGift(str:String):BitmapData
		{
			return giftIcons[str] as BitmapData;
		}
		
		override public function setSize(w:Number, h:Number):void
		{
			super.setSize(w,h);
			
			//background.width = w;
			//background.height = h;	
		}
	}
}