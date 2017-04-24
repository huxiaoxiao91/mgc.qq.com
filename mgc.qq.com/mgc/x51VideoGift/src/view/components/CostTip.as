package view.components
{
	import com.bit101.components.Component;
	import com.bit101.components.Image;
	import com.bit101.components.Label;
	import com.bit101.components.Style;
	import com.bit101.components.TextArea;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	
	public class CostTip extends Component
	{	
		private static var _instance:CostTip;
		
		public var text_cost:TextField;
		public var text_cost1:TextField;
		public var format:TextFormat;
		public var format1:TextFormat;
		
		public function CostTip(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0)
		{
			super(parent, xpos, ypos);
			
			initUI();
		}
		
		public function initUI():void
		{
			this.visible = false;
			
			text_cost = new TextField();
			text_cost.x = 10;
			text_cost.y = 5;
			text_cost.embedFonts = Style.embedFonts;
			text_cost.multiline = false;
			text_cost.wordWrap = false;
			text_cost.selectable = false;
			text_cost.mouseEnabled = false;
			text_cost.type = TextFieldType.INPUT;
			format = new TextFormat("微软雅黑",14,0xffee79);
			format.bold = true;
			text_cost.defaultTextFormat = format;
			
			
			text_cost1 = new TextField();
			text_cost1.x = 5;
			text_cost1.y = 5;
			text_cost1.embedFonts = Style.embedFonts;
			text_cost1.multiline = false;
			text_cost1.wordWrap = false;
			text_cost1.selectable = false;
			text_cost1.mouseEnabled = false;
			text_cost1.type = TextFieldType.INPUT;
			format1 = new TextFormat("微软雅黑",14,0xffffff);
			format1.bold = true;
			text_cost1.defaultTextFormat = format1;
			
			this.addChild(text_cost);
			this.addChild(text_cost1);
		}
		
		public function show(str:String,type:int,xpos:Number = 0, ypos:Number =  0):void
		{
			
			text_cost.text = str;
			text_cost.height = text_cost.textHeight + 5;
			text_cost.width = text_cost.textWidth + 5 ;
			text_cost.setTextFormat(format);
			
			if(type == 6)
				text_cost1.text = "梦幻币";
			else if(type == 5)
				text_cost1.text = "个人积分";
			else
				text_cost1.text = "炫豆";
			text_cost1.height = text_cost1.textHeight + 5;
			text_cost1.width = text_cost1.textWidth + 5 ;
			text_cost1.setTextFormat(format1);
			text_cost1.x = text_cost.x+text_cost.width;
			
			var w:Number = text_cost.textWidth + text_cost1.textWidth + 28;
			var h:Number = text_cost.textHeight + 13;
			
			this.graphics.clear();
			this.graphics.beginFill(0x59c8ff);
			this.graphics.drawRoundRect(0, 0, w, h,10);
			this.graphics.endFill();
			
			
			this.x = xpos;
			this.y = ypos - h - 10;
			this.setSize(w,h);
			this.visible = true;
		}
		
		public function hide():void
		{
			this.visible = false;
		}
		
		/**
		 *实现单例模式
		 * @return Tooltip
		 *
		 */               
		static public function getInstance():CostTip
		{
			if(_instance==null) _instance = new CostTip();
			return _instance;
		}
		
	}
}