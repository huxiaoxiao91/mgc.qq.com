package view.components
{
	import com.bit101.components.Component;
	import com.bit101.components.HBox;
	import com.bit101.components.Image;
	import com.bit101.components.Label;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	
	public class GiftTipPane extends Component
	{
		public var image:Image;
		
		//收费礼物名称价格容器
		public var hbox1:HBox;
		
		//免费礼物名称价格容器
		public var hbox2:HBox;
		
		public var text_name1:Label;
		public var text_name2:Label;
		
		public var text_price:Label;
		
		public var text_free:Label;
		public var text_dream_currency:Label;
		
		public var text_intro:Sprite;
		
		public var text_leftTime:Free;
		
		private var bg:Shape = new Shape();
		
		public var text_1:Label;
		
		public function GiftTipPane(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0)
		{
			super(parent, xpos, ypos);
			
			initUI();
		}
		
		public function initUI():void
		{
			this.visible = false;
			this.setSize(330,95);
			
			//图标
			image = new Image(this,8,20);
			image.setSize(50,50);
			addChild(image);
			
			hbox1 = new HBox(this,60,0);
			text_name1 = new Label(hbox1);
			text_name1.textFormat = new TextFormat("微软雅黑",16,0xffffff,true);
			text_price = new Label(hbox1,0,2);
			text_price.textFormat = new TextFormat("微软雅黑",14,0xffee79,true);
			text_1 = new Label(hbox1,0,2,"炫豆");
			text_1.textFormat = new TextFormat("微软雅黑",14,0xd6f9fe,true);
			
					
			hbox2 = new HBox(this,60,0);
			text_name2 = new Label(hbox2);
			text_name2.textFormat = new TextFormat("微软雅黑",16,0xffffff,true);
			text_free = new Label(hbox2,0,0,"免费");
			text_free.textFormat = new TextFormat("微软雅黑",16,0xffffff,true);
			
			text_dream_currency = new Label(hbox1,0,2,"每次单击全部送出");
			text_dream_currency.textFormat = new TextFormat("微软雅黑",14,0xcfe7eb,true);
			
			text_intro = new Sprite();
			text_intro.x = 60;
			text_intro.y = 25;
			addChild(text_intro);
			
			text_leftTime = new Free();
			text_leftTime.x = 60;
			text_leftTime.y = 25;
			addChild(text_leftTime);
		}
		
		
		override public function setSize(w:Number, h:Number):void
		{
			//背景
			if(this.contains(bg))
			{
				this.removeChild(bg);
			}
			bg = new Shape()
			
			bg.graphics.clear();
			bg.graphics.beginFill(0xd75fff,1);
			bg.graphics.drawRoundRect(0,0,w,h,5);
			bg.graphics.endFill();
			this.addChildAt(bg,0);
			super.setSize(w,h);
		}
		
		private var fistY:Boolean = false;
		private var fistYNum:Number;
		
		override public function set y(value:Number):void
		{
			if(!fistY && !isNaN(value) && value != 0)
			{
				fistYNum = value;
				fistY = true;
			}
			super.y = value;
		}
		
		public function upateSize():void
		{
			var num:Number ;
			
			if(!text_leftTime.visible)
			{
				num = text_name1.textField.numLines*20 + text_intro.height + 13;
			}
			else
			{
				num = text_name1.textField.numLines*20  + text_leftTime.height + 13 ;
			}
			
			image.y = (num - 50)/2;
			
			this.setSize(330,num); 
		}
	}
}