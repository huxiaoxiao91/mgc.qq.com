package model.data
{	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import model.DataProxy;

	/**
	 * 
	 * 礼物效果界面数据模型
	 */
	public class EffectPaneVO extends EventDispatcher
	{
		/**
		 * 效果列表
		 * [EffectVO]
		 */
		public var effectList:Array = new Array();
		
		private var _path:String;
		
		public var senderName:String;
		
		public var giftData:GiftData;
		
		/**
		 * 全屏效果播放完毕
		 */
		public var fullEffectOver:Boolean = false;
		
		public var isSelf:Boolean;
		
		private var _isPlay:Boolean = false;
		
		public function EffectPaneVO()
		{
			
		}
		
		/**
		 * 是否在播放
		 */
		public function get isPlay():Boolean
		{
			return _isPlay;
		}

		/**
		 * @private
		 */
		public function set isPlay(value:Boolean):void
		{
			_isPlay = value;
			
			if(!isPlay)
			{
				nextEffect();
			}
		}

		/**
		 * 要播放的效果地址
		 */
		public function get path():String
		{
			return _path;
		}

		/**
		 * @private
		 */
		public function set path(value:String):void
		{
			_path = value;
			
			dispatchEvent(new Event("path"));
		}
		
		public var playEffectVO:EffectVO;
		
		/**
		 * 播放下一个效果
		 */
		public function nextEffect():void
		{
			if(isPlay)return;
			if(effectList.length == 0)
			{
				//senderPlayerID = "";
				//continuous_send_gift_times = 0;
				return;
			}
			isPlay = true;
			//playEffectVO = effectList.shift();
			playEffectVO = getNextEffect();
			giftData = playEffectVO.giftData;
			isSelf = playEffectVO.isSelf;
			senderName = playEffectVO.senderName;
			path = playEffectVO.path;	
		}
		
		/**
		 * 当前送礼的玩家ID
		 */
		private var senderPlayerID:String = "";
		
		/**
		 * 当前连送次数   大于1为有连送
		 */
		private var continuous_send_gift_times:int = 0;
		
		/**
		 * 
		 * 获取下一个礼物消息
		 * 先播当前连送玩家的  再播自己的
		 * 
		 */
		private function getNextEffect():EffectVO
		{
			var vo:EffectVO;
			
			var i:int = 0;
			
			//是否连送
			/*if(continuous_send_gift_times > 0)
			{
				for(var i:int = 0;i<effectList.length;i++)
				{
					//找到同一个玩家
					if(effectList[i].giftData.senderPlayerID == senderPlayerID)
					{
						vo = effectList.splice(i,1)[0];
						senderPlayerID = vo.giftData.senderPlayerID;
						continuous_send_gift_times = vo.giftData.continuous_send_gift_times;
						return vo;
					}
				}
			}*/
			
			//找到自己
			for(i = 0;i<effectList.length;i++)
			{
				if(effectList[i].giftData.senderPlayerID == DataProxy.userId)
				{
					vo = effectList.splice(i,1)[0];
					//senderPlayerID = vo.giftData.senderPlayerID;
					//continuous_send_gift_times = vo.giftData.continuous_send_gift_times;
					return vo;
				}
			}
			
			//顺序播放
			vo = effectList.shift();
			senderPlayerID = vo.giftData.senderPlayerID;
			continuous_send_gift_times = vo.giftData.continuous_send_gift_times;
			return vo;
		}
		
		
		public function clear():void
		{
			effectList.splice(0,effectList.length);
			
			isPlay = false;
			
			dispatchEvent(new Event("clear"));
		}

		/**
		 * 添加一个效果
		 */
//		public function addEffect(vo:EffectVO):void
//		{
//			effectList.push(vo);
//		}
	}
}