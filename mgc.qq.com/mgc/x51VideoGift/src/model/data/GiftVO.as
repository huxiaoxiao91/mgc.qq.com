package model.data
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

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
		
		private var _icon:String;
		
		/**
		 * 礼物价格
		 */
		public var price:Number;
		
		/**
		 * 人气
		 */
		public var popularity:Number;
		
		/**
		 * 主播经验
		 */
		public var anchorexp:int = 0;
		
		/**
		 * 是否加锁
		 */
		public var isLock:Boolean = false;
		
		private var _isPK:Boolean = false;
		
		/**
		 * 礼物介绍
		 */
		public var intro:String;
		/**
		 * 皮肤主题id，默认为0
		 */		
		public var skinsubject:int = 0;

		/**
		 * 增加的魅力值
		 */
		public var charm:int = 0;
		/**
		 * 消耗个人积分
		 */
		public var costmemberscore:uint;

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
		
		public var mouseX:Number;
		public var mouseY:Number;
		public var visible:Boolean = false;
		
		/**
		 * 触发连击的数量
		 */
		public var combo:int = 0;
		
		
		/**
		 * 冠名的主播名
		 */
		public var anchor_name:String = "";
		
		/**
		 * 冠名的粉丝名
		 */
		public var player_name:String = "";
		
		private var _isStar:Boolean = false;
		

		/**
		 * 是否PK礼物
		 */
		public function get isPK():Boolean
		{
			return _isPK;
		}

		/**
		 * @private
		 */
		public function set isPK(value:Boolean):void
		{
			_isPK = value;
			
			dispatchEvent(new Event("draw"));
		}

		/**
		 * 是否周星礼物
		 */
		public function get isStar():Boolean
		{
			return _isStar;
		}

		/**
		 * @private
		 */
		public function set isStar(value:Boolean):void
		{
			_isStar = value;
			
			dispatchEvent(new Event("draw"));
		}

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
		 * seo②显示特效的最小礼物单价
		 */
		public static const SHOW_EFFECT_MIN_UNIT_PRICE:int = 4990;
		
		/**
		 * 
		 * 获取对应数量的礼物效果
		 * @param n 送礼数量
		 * @return 效果数据
		 * 
		 */		
		public function getEffect(n:int):EffectVO
		{
			var vo:EffectVO;
			for(var i:int = 0;i < effectList.length;i++)
			{
				var effectVO:EffectVO = effectList[i] as EffectVO;
				if(n >= effectVO.count)
				{
					vo = cloneObject(effectVO);
				}
			}
			return vo;
		}
		
		private function cloneObject(source:Object) :* {  
			var typeName:String = getQualifiedClassName(source);//获取全名  
			//trace(”输出类的结构”+typeName);  
			//return;  
			var packageName:String = typeName.split("::")[0];//切出包名  
			//trace(”类的名称”+packageName);  
			var type:Class = getDefinitionByName(typeName) as Class;//获取Class  
			//trace(type);  
			registerClassAlias(packageName, type);//注册Class  
			//复制对象  
			var copier:ByteArray = new ByteArray();  
			copier.writeObject(source);  
			copier.position = 0;  
			return copier.readObject();  
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
		 * 10 全屏礼物
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

		public function get totalPrice():int {
			return price * num;
		}

		/**
		 * 礼物图标地址
		 */
		public function get icon():String
		{
			return _icon;
		}

		/**
		 * @private
		 */
		public function set icon(value:String):void
		{
			_icon = value;
			
			dispatchEvent(new Event("draw"));
		}

	}
}