package view.components
{
	import com.bit101.components.Component;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import model.DataProxy;
	import model.data.SurpriseTreasurePaneVo;
	
	import view.BrowserInfo;
	
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
		}
		
		public function initUI():void
		{
			var tf:TextFormat = new TextFormat();
			tf.color = 0xffffff;
			tf.font = "微软雅黑";
			tf.size = 12;
			tf.align = TextFormatAlign.CENTER;

			if (DataProxy.isCaveolaeBo) {
				if (DataProxy.isSkinOpened) {
					//DataProxy.skinId == 1
					if (DataProxy.skinId == DataProxy.SKIN_ID_3_PARK) {
						surpriseTreasureBG = new Skin_3_ST_BG();
					} else if (DataProxy.skinId == DataProxy.SKIN_ID_2_SEA) {
						surpriseTreasureBG = new Skin_2_ST_BG();
					} else {
						surpriseTreasureBG = new SurpriseTreasureBG();
					}
				} else {
					surpriseTreasureBG = new SurpriseTreasureBG1();
				}
			} else {
				surpriseTreasureBG = new SurpriseTreasureBG();
			}
			
			surpriseTreasure = new SurpriseTreasure();
			surpriseTreasure.buttonMode = true;
//			surpriseTreasure.addEventListener(MouseEvent.ROLL_OVER,rollOver);
//			surpriseTreasure.addEventListener(MouseEvent.ROLL_OUT,rollOut);
			
			flowersText = new TextField();
			flowersText.width = 50;
			flowersText.height = 20;
			flowersText.selectable = false;
			flowersText.mouseEnabled = false;
			flowersText.multiline = false;
			flowersText.defaultTextFormat = tf;
			flowersProgress = new TextField();
			flowersProgress.width = 50;
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
			
			addChildAt(surpriseTreasureBG,0);
			addChild(flowersText);
			addChild(flowersProgress);
			addChild(surpriseTreasure);
			addChild(timeProgress);
			
			tipText = new TextField();
			flowersText.text = "鲜 花";
			setFlowersProgress(100);
			setTimeProgress(0);
			
			surpriseTreasureBG.y = 15;
			surpriseTreasureBG.x = 0;
			flowersText.y = 15;
			flowersText.x = surpriseTreasureBG.x;
			flowersProgress.y = 29;
			flowersProgress.x = surpriseTreasureBG.x;
			surpriseTreasure.y = -3;
			surpriseTreasure.x = 91 - surpriseTreasure.width ; 
			timeProgress.y = surpriseTreasure.y + surpriseTreasure.height - 15;
			timeProgress.x = 91 - timeProgress.width + 8;
			
			BrowserInfo.getBrowserInfo();
			
			if(BrowserInfo.name == BrowserInfo.SAFARI){
				var offset:int = 1;
				if(isOSMac){
					offset += 3;
					
					flowersText.height = 24;
					flowersText.text = "鲜 花";
				}
				flowersText.y += offset;
				flowersProgress.y += offset;
				
				surpriseTreasure.y += offset;
				timeProgress.y += offset;
			}
		}
		
		private function get isOSMac():Boolean{
			var os:String;
			try
			{
				os = Capabilities.os.toLowerCase();
			} 
			catch(error:Error) 
			{
				os = "";
			}
			return os.indexOf("mac") >= 0;
		}
		
		
		public function updateBG():void
		{
			if(surpriseTreasureBG && this.contains(surpriseTreasureBG))
				removeChild(surpriseTreasureBG);

			if (DataProxy.isCaveolaeBo) {
				if (DataProxy.isSkinOpened) {
					if (DataProxy.skinId == DataProxy.SKIN_ID_3_PARK) {
						surpriseTreasureBG = new Skin_3_ST_BG();
					} else if (DataProxy.skinId == DataProxy.SKIN_ID_2_SEA) {
						surpriseTreasureBG = new Skin_2_ST_BG();
					} else {
						surpriseTreasureBG = new SurpriseTreasureBG();
					}
				} else {
					surpriseTreasureBG = new SurpriseTreasureBG1();
				}
			} else {
				surpriseTreasureBG = new SurpriseTreasureBG();
			}

			surpriseTreasureBG.y = 15;
			surpriseTreasureBG.x = 0;
			
			addChildAt(surpriseTreasureBG,0);
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