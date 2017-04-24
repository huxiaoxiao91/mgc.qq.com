package model.data
{	
	import com.bit101.utils.OverrideEditManager;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.text.engine.BreakOpportunity;
	import flash.text.engine.TextBaseline;
	
	import flashx.textLayout.conversion.ConversionType;
	import flashx.textLayout.conversion.ITextExporter;
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.edit.EditManager;
	import flashx.textLayout.edit.SelectionManager;
	import flashx.textLayout.elements.InlineGraphicElement;
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.LineBreak;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	import flashx.undo.UndoManager;

	/**
	 * 
	 * 飞屏界面数据模型
	 */
	public class FlyInputPaneVO extends EventDispatcher
	{	
		private var _visible:Boolean = false;
		
		private var _tip:String = "";
		
		/**
		 * 文本数据
		 */
		public var textFlow:TextFlow;
		
		public var paragraphElement:ParagraphElement;
		
		public var editManager:OverrideEditManager;
		
		/**
		 * 聊天文字上限（单位：字符）
		 */
		public var wordNum:int = 72;
		
		/**
		 * 免费飞屏数量
		 */
		public var count:int = 0;
		
		/**
		 * 存储要发送的消息
		 */
		public var content:String = "";
		
		public function FlyInputPaneVO()
		{
			var textFormat:TextLayoutFormat = new TextLayoutFormat();
			textFormat.fontFamily = "宋体";
			textFormat.fontSize = 20;
			textFormat.color = 0xffffff;
			//textFormat.lineHeight = 30;
			//textFormat.paddingTop = 0;
			//textFormat.verticalAlign = VerticalAlign.JUSTIFY;
			textFormat.dominantBaseline = TextBaseline.DESCENT;
			textFormat.lineBreak = LineBreak.EXPLICIT;
			
			textFlow = new TextFlow();
			textFlow.hostFormat = textFormat;
			//textFlow.breakOpportunity = BreakOpportunity.NONE;
			editManager = new OverrideEditManager(new UndoManager());
			textFlow.interactionManager = editManager;
			
			/*paragraphElement = new ParagraphElement();
			textFlow.addChildAt(0,paragraphElement);
			textFlow.flowComposer.updateAllControllers(); */
		}
		
		public function get flyCount():uint
		{
			return _flyCount;
		}

		public function set flyCount(value:uint):void
		{
			_flyCount = value;
			//显示提示文字
			if(_flyCount != 0)
			{
				tip = "您还剩余" + _flyCount.toString() + "条免费飞屏";
			}
			else
			{
				tip = "请输入飞屏文字，每条消耗炫豆199";
			}
		}

		/**
		 * 删除所有内容
		 */
		public function removeAll():void
		{
			var paragraphElement:ParagraphElement = textFlow.getChildAt(0) as ParagraphElement;

			while(paragraphElement.numChildren > 1)
			{
				paragraphElement.removeChildAt(0);
			}
			
			var span:SpanElement = paragraphElement.getChildAt(0) as SpanElement;
			span.text ="";
			
			//content = "";
		}
		
		/**
		 * 
		 * 添加文本
		 * 
		 */		
		public function addText(text:String):void
		{
			content += text;
		}
		
		/**
		 * 
		 * 添加表情
		 * id 表情id
		 */		
		public function addFace(id:int):void
		{
			
			var str:String = getTextFlowText();
//			var num:uint = chineseNum(str);
//			num = str.length + num;
			
			var source:String = FacePaneVO.getIcon(id);
			var icon:String = FacePaneVO.getIcon2(source);
			
//			if((num + icon.length) > wordNum)
//				return;
			
			
			//添加选中的表情
			editManager.insertInlineGraphic(FacePaneVO.getIcon(id),24,24);
			//焦点设为输入框
			textFlow.interactionManager.setFocus();
			
			//content += FacePaneVO.getIcon2(id);
		}
		
		
		
		private function getTextFlowText():String
		{
			var exporter:ITextExporter = TextConverter.getExporter(TextConverter.TEXT_LAYOUT_FORMAT);
			
			var xml:XML = exporter.export(textFlow,ConversionType.XML_TYPE) as XML;
			var xmlList:XMLList = xml.children();
			var msg:String = "";
			for each(var node:XML in xmlList.children())
			{
				switch(node.localName())
				{
					case "img":
						var source:String = node.@source;
						var icon:String = FacePaneVO.getIcon2(source);
						msg += icon;
						break;
					
					case "span":
						msg += node.toString();
						break;
				}
			}
			
			return msg;
		}
		
		/**
		 * 
		 * @param msg 要检查的字符串
		 * @return 中文字的个数
		 * 
		 */		
		private function chineseNum(msg:String):uint
		{
			var i:uint = 0;
			var num:uint = 0;
			for(i;i<msg.length;i++)
			{
				var chat_code:Number=msg.charCodeAt(i);//获得一个字符的ASCII编码 
				if((chat_code>=19968 && chat_code<=40869) || chat_code == 92)
				{
					num++;
				}
			}
			return num;
		}
		
		
		private var _flyCount:uint = 0;
		
		/**
		 * 提示框文本
		 */
		public function get tip():String
		{
			return _tip;
		}

		/**
		 * @private
		 */
		public function set tip(value:String):void
		{
			_tip = value;
			
			dispatchEvent(new Event("tip"));
		}

		/**
		 * 界面是否显示
		 */
		public function get visible():Boolean
		{
			return _visible;
		}
		
		/**
		 * @private
		 */
		public function set visible(value:Boolean):void
		{
			_visible = value;
			
			dispatchEvent(new Event("visible"));
		}

	}
}