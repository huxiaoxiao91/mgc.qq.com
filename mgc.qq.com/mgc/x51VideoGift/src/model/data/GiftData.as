package model.data
{
	
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * 
	 * 礼物消息
	 * 
	 */	
	public class GiftData
	{		
		//圣诞活动礼物id
		static public var activity_gift_id:int = 55;
		
		public var giftItemID:int = 0;
		public var count:int = 0;//这次送礼数量
		public var popularityChange:int = 0;	// 增加的人气值，本次送礼总共增加量
		public var sender_channelid:int = 0;
		public var senderPlayerID:String = "";
		public var anchorID:String = "";
		public var senderName:String;
		public var anchorName:String;
		public var giftName:String;
		public var zoneName:String;	// 玩家所在的大区名字
		public var giftIcon:String;	// 礼物图标uir ID
		public var vip_level:int;		// 送礼玩家的贵族身份
		public var vipIcon:String = "";//// 送礼玩家的贵族身份图标
		public var guardIcon:String = "";//送礼玩家的守护身份图标
		public var ceremony:Boolean;//是否在盛典活动时送的 UI自己用 逻辑不用管
		public var occupyIndex:int;//霸屏礼物第几响的标记  UI自己用 逻辑不用管		
		public var male:Boolean = false;
		public var support_degree_add:int = 0;		
		public var invisible:Boolean = false;
		/**
		 * 连送次数   大于1为有连送
		 */
		public var continuous_send_gift_times:int = 0;
		/**
		 * 本次送礼增加了多少主播经验值
		 */
		public var anchor_exp:int = 0;
		/**
		 * 财富等级
		 */
		public var wealth_level:int = 0;
		/**
		 * 礼物来源。0-聊天发送；1-抽奖 2 免费抽奖  3通用活动
		 */
		public var source:int;
		
		//=============以上是服务器数据==============
		
		//=============以下是本地数据==============
		
		public var createTime:Number = 0;
		//是不是自己
		public var isSelf:Boolean = true;
		
		/**
		 * 最大播放的数量
		 */
		public var maxCount:int = 1;
		
		/**
		 * 当前播放的数量
		 */
		public var curCount:int = 1;
		
		/**
		 * 每帧播放几个
		 */
		public var perCount:int = 1;
		
		/**
		 * 特效等级
		 */
		public var level:int = 1;
		
		/**
		 * 筛子3个点数
		 * 骰子数值 0是无效 1-6
		 */
		public var m_dice_val_1:int = 1;
		public var m_dice_val_2:int = 1;
		public var m_dice_val_3:int = 1;
		/**
		 * 特效等级0无效 1级特效 2级特效
		 */
		public var m_level:int = 1;
		
		private var _type:int = 2;
		
		public function GiftData(obj:Object)
		{
			for(var i:String in obj)
			{
				if(i != "data" && this.hasOwnProperty(i))
					this[i] = obj[i];
			}
			
			maxCount = count;
			//梦幻币礼物 后援团礼物只显示一条
			if(giftItemID == 30 || giftItemID == 31 || giftItemID == 32 || giftItemID == 16 || giftItemID == 300){
				curCount = count;
			}
			
			//通用活动礼物只显示一条
			if(source == 3)
			{
				curCount = count;
			}
			
			setPlayTime(3);
		}
		
		/**
		 *
		 * 设置播完的时间 秒
		 * 
		 */		
		public function setPlayTime(sec:Number):void
		{
			var leftCount:int = maxCount - curCount;
			
			perCount = Math.max(perCount,leftCount/sec/50 + 1);
			
			//最大每帧20条
			perCount = Math.min(perCount,30);
			
			trace(leftCount + "    " + perCount)
		}
		
		/**
		 *
		 * 获取消息序列 
		 * @param quick 是否加速
		 * @return 
		 * 
		 */		
		public function getMessageList(quick:Boolean):Array
		{
			//100以下的数量不丢帧
			if(count <= 150){
				quick = false;
			}
			
			var arr:Array = [];
			var i:int;
			var vo:Object;
			
			//梦幻币礼物只显示一条
			if(giftItemID == 30 || giftItemID == 31 || giftItemID == 32){
				arr = [this];
				return arr;
			}
			
			if(quick)
			{
				var scale:Number = 150/count/3;
				var numArr:Array = [];
				var start:int = int(count*scale);
				var end:int = count - int(count*scale);
				
				//取前n个
				for(i = 1;i <= start; i++)
				{
					numArr.push(i);
				}
				
				//取后n个
				for(i = end;i <= count; i++)
				{
					numArr.push(i);
				}
				
				//取中间n个
				var tempArr:Array = [];
				for(var j:int = start + 1;j < end;j++)
				{
					tempArr.push(j);
				}
				
				tempArr = randomArr(tempArr);
				tempArr.splice(int(count*scale));
				
				numArr = numArr.concat(tempArr);
				numArr.sort(Array.NUMERIC);	
				
				for(i = 0;i < numArr.length; i++)
				{
					vo = clone(this);
					vo.count = numArr[i];
					arr.push(vo);
				}
				
			}
			else
			{
				for(i = 1;i <= count; i++)
				{
					vo = clone(this);
					vo.count = i;
					arr.push(vo);
				}
			}
			
			return arr;
		}
		
		public function clone(obj:Object):* 
		{
			var copier:ByteArray = new ByteArray();
			copier.writeObject(obj);
			copier.position = 0;
			return copier.readObject();
		}
		
		/** 随机排列数组里的顺序 */
		public function randomArr(arr:Array):Array
		{
			var _arr:Array = [];
			var length:uint = arr.length;
			for(var i:uint; i<length; i++)
			{
				var random:uint = Math.random() * arr.length;
				_arr.push(arr[random]);
				arr.splice(random, 1);
			}
			return _arr;
		}

		public function get isFullScreenGfit():Boolean {
			return giftItemID == 41 || giftItemID == 43 ||
				giftItemID == 44 || giftItemID == 45 ||
				giftItemID == 47 || giftItemID == 48 ||
				giftItemID == 49 || giftItemID == 46 || 
				giftItemID == 54 || giftItemID == 61 ;
		}

		/**
		 * 礼物类别
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
			
			//梦幻币礼物只显示一条
			
			if(type == 6){
				curCount = count;
			}
		}

	}
}