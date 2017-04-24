package com.h3d.qqx5.gift
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * 
	 * 礼物数据模型
	 */
	public class GiftVO extends EventDispatcher
	{
		
		/**
		 * 礼物id
		 */
		public var id:int;
		
		/**
		 * 礼物名称
		 */
		public var name:String;
		
		/**
		 * 礼物图标地址
		 */
		public var icon:String;
		
		/**
		 * 礼物价格
		 */
		public var price:Number = 0;
		
		/**
		 * 礼物介绍
		 */
		public var intro:String;
		/**
		 * 皮肤主题id，默认为0
		 */		
		public var skinsubject:int = 0;
		
		/**
		 * 效果列表
		 * [EffectVO]
		 */
		public var effectList:Array = [];
		
		/**
		 * 下拉列表
		 * [{count,str}]
		 */
		public var dropList:Array = [];
		
		
		private var _type:int;
		
		private var _num:int = 0;
		
		private var _leftTime:int = 600;
		
		private var timer:Timer;
		
		private var _enabled:Boolean = true;
		private var _isShow:Boolean = false;
		
		public function get isShow():Boolean
		{
			return _isShow;
		}
		
		public function set isShow(value:Boolean):void
		{
			_isShow = value;
			dispatchEvent(new Event("draw"));
		}
		
		public function GiftVO(o:Object = null)
		{
			if(o)
			{
				for(var i:String in o)
				{
					if(this.hasOwnProperty(i.toLocaleLowerCase()))
					{
						this[i.toLocaleLowerCase()] = o[i];
					}
					else if(i == "gift_type")
					{
						this.type = uint(o[i]);
					}
				}
			}
		}
		
		/**
		 * 玩家所拥有礼物数量
		 */
		public function get num():int
		{
			return _num;
		}
		
		/**
		 * @private
		 */
		public function set num(value:int):void
		{
			_num = value;
			
			dispatchEvent(new Event("draw"));
		}
		
		/**
		 * 免费礼物下次刷新剩余时间  秒
		 */
		public function get leftTime():int
		{
			return _leftTime;
		}
		
		/**
		 * @private
		 */
		public function set leftTime(value:int):void
		{
			if(value <= 0)
			{
				return;
				//value = 600;
				
				//num++;
			}
			
			_leftTime = value;
		}
		
		private function timerHandler(e:TimerEvent):void
		{
			leftTime--;
		}
		
		/**
		 * 礼物类别
		 * 1免费 2普通 3魔法 4尊贵 5后援团礼物
		 */
		public function get type():int
		{
			return _type;
		}
		
		/**
		 * @private
		 */
		public function set type(value:int):void
		{
			_type = value;
			
			//免费礼物需要计时
			if(type == 1)
			{
				if(!timer)
				{
					timer = new Timer(1000);
					timer.addEventListener(TimerEvent.TIMER,timerHandler);
					timer.start();
				}
			}
		}
		
		
		/**
		 * 是否处于活动状态
		 */
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		/**
		 * @private
		 */
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
			
			dispatchEvent(new Event("draw"));
		}
		
	}
}