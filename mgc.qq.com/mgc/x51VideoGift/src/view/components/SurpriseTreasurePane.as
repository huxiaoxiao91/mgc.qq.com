package view.components
{
	import com.bit101.components.Component;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import model.DataProxy;
	import model.data.SurpriseTreasurePaneVo;
	
	/**
	 * 惊喜宝箱——弃用
	 * @author gaolei
	 * 
	 */	
	public class SurpriseTreasurePane extends Component
	{
		public var vo:SurpriseTreasurePaneVo;
		public var surpriseTreasureBG:Sprite;
		public var surpriseTreasure:SurpriseTreasure;
		public var flowersText:TextField;
		public var flowersProgress:TextField;
		private var _flowersNum:uint = 0;
		private var _count:uint = 0;
		public var timeProgress:TextField;
		private var _type:uint = 0;
		private var tipText:TextField;
		
		private var flowersProgressNum:uint = 0;
		private var timeProgressNum:uint = 0;
		private var parentDisplayObject:DisplayObjectContainer;
		
		public function SurpriseTreasurePane(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			parentDisplayObject = parent;
			super(parent, xpos, ypos);
			initUI();
		}
		
		public function initUI():void
		{
			var tf:TextFormat = new TextFormat();
			tf.color = 0xffffff;
			tf.font = "微软雅黑";
			tf.size = 12;
			tf.align = TextFormatAlign.CENTER;
			
			if(!DataProxy.isCaveolaeBo)
			{
				surpriseTreasureBG = new SurpriseTreasureBG();
			}
			else
			{
				surpriseTreasureBG = new SurpriseTreasureBG1();
			}
			surpriseTreasure = new SurpriseTreasure();
			surpriseTreasure.buttonMode = true;
			surpriseTreasure.addEventListener(MouseEvent.ROLL_OVER,rollOver);
			surpriseTreasure.addEventListener(MouseEvent.ROLL_OUT,rollOut);
			
			flowersText = new TextField();
			flowersText.width = 75;
			flowersText.height = 20;
			flowersText.selectable = false;
			flowersText.mouseEnabled = false;
			flowersText.multiline = false;
			flowersText.defaultTextFormat = tf;
			flowersProgress = new TextField();
			flowersProgress.width = 75;
			flowersProgress.height = 20;
			flowersProgress.selectable = false;
			flowersProgress.mouseEnabled = false;
			flowersProgress.multiline = false;
			flowersProgress.defaultTextFormat = tf;
			
			var tf1:TextFormat = new TextFormat();
			tf1.color = 0xf8d600;
			tf1.font = "微软雅黑";
			tf1.size = 12;
			tf1.align = TextFormatAlign.CENTER;
			timeProgress = new TextField();
			timeProgress.selectable = false;
			timeProgress.mouseEnabled = false;
			timeProgress.height = 20;
			timeProgress.multiline = false;
			timeProgress.width = 64;
			timeProgress.defaultTextFormat = tf1;
			timeProgress.filters = [new GlowFilter(0x000000, 1, 2, 2, 10, 1)];
			
			addChild(surpriseTreasureBG);
			addChild(flowersText);
			addChild(flowersProgress);
			addChild(surpriseTreasure);
			addChild(timeProgress);
			
			tipText = new TextField();
			flowersText.text = "鲜 花";
			setFlowersProgress(100);
			setTimeProgress(0);
			
		}
		
		private function setChestState():void
		{
			if(_type != 0)
			{
				setTtipText("点击开启");
			}
			else
			{
				setTtipText("请等待激活惊喜宝箱，每次激活需要房间中送出" + flowersNum + "朵鲜花，下一次需等待" + timeProgress.text +"，今天还剩余" + count +"次");
			}
		}
		
		/**
		 * 更新宝箱状态
		 * @param e
		 * 
		 */	
		public function updateChestState(type:uint):void
		{
			_type = type;
			if(type == 0)
			{
				surpriseTreasure.gotoAndStop(1);
			}
			else
			{
				surpriseTreasure.gotoAndPlay(2);
			}
			setChestState();
		}
		
		/**
		 * 百分比
		 * @param e
		 * 
		 */	
		public function setFlowersProgress(p:uint):void
		{
			if(p > 100 )
			{
				p = 100;
			}
			flowersProgressNum = p;
			flowersProgress.text = p + "%";
		}
		
		/**
		 * cd时间
		 * @param e
		 * 
		 */	
		public function setTimeProgress(p:uint):void
		{
			timeProgressNum = p;
			var s:uint;
			var m:uint = Math.floor(p/60);
			
			var ss:String = "";
			var mm:String = "";
			
			
			if(m < 10)
			{
				mm = "0" + m;
			}
			else
			{
				mm = m.toString();
			}
			
			s = p%60;
			
			if(s < 10)
			{
				ss = "0" + s;
			}
			else
			{
				ss = s.toString();
			}
			
			timeProgress.text = mm + ":" + ss;
			setChestState();
		}
		
		override public function setSize(w:Number, h:Number):void
		{
			super.setSize(w,h);
			
			surpriseTreasureBG.y = 25;
			surpriseTreasureBG.x = w - surpriseTreasureBG.width;
			flowersText.y = 25;
			flowersText.x = surpriseTreasureBG.x;
			
			flowersProgress.y = 40;
			flowersProgress.x = surpriseTreasureBG.x;
			surpriseTreasure.y = 0;
			surpriseTreasure.x = w - surpriseTreasure.width; 
			timeProgress.y = surpriseTreasure.y + surpriseTreasure.height - 17;
			timeProgress.x = w - timeProgress.width;
		}
		
		public var tipSprite:Sprite;
		
		private function rollOver(e:MouseEvent):void
		{
			if(tipSprite && parentDisplayObject.contains(tipSprite))
			{
				parentDisplayObject.removeChild(tipSprite);
			}
			
			tipSprite = new Sprite();
			
			var tf:TextFormat = new TextFormat();
			tf.color = 0xD6F9FE;
			tf.font = "微软雅黑";
			tf.size = 14;
			
			
			tipText.defaultTextFormat = tf;
			tipText.wordWrap = true;
			tipText.x = 5 ;
			tipText.y = 5;
			
			tipSprite.addChild(tipText);
			
			parentDisplayObject.addChild(tipSprite);
			upadteTip();
		}
		
		private function upadteTip():void
		{
			setChestState();
			if(_type == 1)
			{
				tipText.width = 60;
				tipText.height = tipText.textHeight + 5;
			}
			else
			{
				tipText.width = 300;
				tipText.height = tipText.textHeight + 5;
			}
			
			tipSprite.graphics.clear();
			tipSprite.graphics.beginFill(0xd75fff,1);
			tipSprite.graphics.drawRoundRect(0,0,tipText.width+10,tipText.height+10,5);
			tipSprite.graphics.endFill();
			
			tipSprite.y = surpriseTreasureBG.height + surpriseTreasureBG.y - 5;
			tipSprite.x = width - (tipText.width+10) - 30;
			
		}
		
		private function rollOut(e:MouseEvent):void
		{
			if(tipSprite && parentDisplayObject.contains(tipSprite))
			{
				parentDisplayObject.removeChild(tipSprite);
			}
		}

		public function getTipText():String
		{
			return tipText.text;
		}

		public function setTtipText(value:String):void
		{
			tipText.text = value;
		}

		public function get flowersNum():uint
		{
			return _flowersNum;
		}
		
		/**
		 * 免费花数量
		 * @param e
		 * 
		 */	
		public function set flowersNum(value:uint):void
		{
			_flowersNum = value;
			setChestState();
		}

		public function get count():uint
		{
			return _count;
		}
		/**
		 *宝箱开启的次数
		 * @param e
		 * 
		 */	
		public function set count(value:uint):void
		{
			_count = value;
			setChestState();
		}
	}
}