package model.data
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * 
	 * 效果数据模型
	 */
	public class EffectVO extends EventDispatcher
	{
		
		/**
		 * 触发数量
		 */
		public var count:int;
		
		/**
		 * 效果等级
		 */
		public var level:int;
		
		/**
		 * 礼物类别
		 * 1免费 2普通 3魔法 4尊贵 5后援团礼物
		 * 10 全屏礼物
		 */
		public var type:int;
		
		/**
		 * 效果动画地址
		 */
		public var path:String;
		
		/**
		 * 0为礼物区内显示 1为在礼物区外显示
		 */
		public var showType:int = 0;
		
		/**
		 * isVipEffect是否显示vip特效(0否1是)
		 * 皇帝亲王的标识
		 */
		public var isVipEffect:int = 0;
		
		
		/**
		 * 发送礼物的用户id
		 */
		public var userId:String;
		
		public var senderName:String;
		
		/**
		 * 礼物id
		 */
		public var giftID:int;
		
		public var createTime:Number;
		
		public var giftData:GiftData;
		
		public var isSelf:Boolean = false;
		
		public function EffectVO(o:Object = null)
		{
			if(o)
			{
				for(var i:String in o)
				{
					if(this.hasOwnProperty(i))
					{
						this[i] = o[i];
					}
				}
			}
		}


	}
}