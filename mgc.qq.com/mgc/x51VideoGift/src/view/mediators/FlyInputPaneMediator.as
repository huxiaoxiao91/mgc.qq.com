package view.mediators
{	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.external.ExternalInterface;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import flashx.textLayout.conversion.ConversionType;
	import flashx.textLayout.conversion.ITextExporter;
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.events.CompositionCompleteEvent;
	
	import model.DataProxy;
	import model.data.FacePaneVO;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.components.*;
	import view.mediators.*;
	
	public class FlyInputPaneMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "FlyInputPaneMediator";
		
		private var dataProxy:DataProxy;
		
		public function FlyInputPaneMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
			
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			
			component.vo = dataProxy.flyInputPaneVO;
			component.initUI();
			
			component.addEventListener(MouseEvent.CLICK,clickHandler);
			
			component.btn_face.addEventListener(MouseEvent.CLICK,btn_face_Click);
			component.btn_send.addEventListener(MouseEvent.CLICK,btn_send_Click);
			component.inputContainer.addEventListener(TextEvent.TEXT_INPUT, textInputHandler);
//			component.inputContainer.addEventListener(Event.PASTE,pasteText);
			
			component.vo.textFlow.addEventListener(CompositionCompleteEvent.COMPOSITION_COMPLETE,completeHandler);
			
			//component.text_input.addEventListener(Event.CHANGE,text_input_change);
			
			dataProxy.flyInputPaneVO.addEventListener("tip",tipHandler);
			dataProxy.flyInputPaneVO.addEventListener("visible",visibleHandler);
		}
		
		/**
		 * 输入框手动输入时
		 */		
		/*private function text_input_change(e:Event):void
		{
		var text:String = component.text_input.text;
		
		dataProxy.flyInputPaneVO.text = text;
		}*/
		
		/**
		 * 点击表情
		 */		
		private function btn_face_Click(e:MouseEvent):void
		{
			dataProxy.facePaneVO.visible =  !dataProxy.facePaneVO.visible;
			sendNotification(ApplicationFacade.ShowFacePane,{visible:true});
		}
		
		/**
		 * 发送飞屏
		 */		
		private function btn_send_Click(e:MouseEvent):void
		{
			if(dataProxy.isVisitor)
			{
				ExternalInterface.call("MGC_Comm.CheckGuestStatus");
				return;
			}
			
			if(dataProxy.flyInputPaneVO.flyCount >= 0)
				dataProxy.flyInputPaneVO.flyCount = dataProxy.flyInputPaneVO.flyCount - 1;
			
			dataProxy.facePaneVO.visible =  false;
			sendNotification(ApplicationFacade.ShowFacePane,{visible:false});
			
			sendNotification(ApplicationFacade.SendMessage);
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */	
		private function pasteText(e:Event):void
		{
			var text:String = Clipboard.generalClipboard.getData(ClipboardFormats.TEXT_FORMAT).toString();
			var newText:String ;
			var temp:String;
			var temp2:String;
			var paragraphElement:ParagraphElement = dataProxy.flyInputPaneVO.textFlow.getChildAt(0) as ParagraphElement;
			
			var str:String = getTextFlowText();
			var num:uint = chineseNum(str);
			
			num = str.length + num;
			
			if(num >= dataProxy.flyInputPaneVO.wordNum)
			{
				e.stopImmediatePropagation();
				return;
			}
			
			
			for(var i:uint = 0;i<text.length;i++)
			{
				var chat_code:Number=text.charCodeAt(i);//获得一个字符的ASCII编码 
				if((chat_code>=19968 && chat_code<=40869) || chat_code == 92)
				{
					num+=2;
				}
				else
				{
					num+=1;
				}
				
				if(num == dataProxy.flyInputPaneVO.wordNum)
				{
					newText = text.substr(0,i+1);
					break;
				}
				else if(num > dataProxy.flyInputPaneVO.wordNum)
				{
					newText = text.substr(0,i);
					break;
				}
				if(i == (text.length - 1))
					newText = text;
			}
			
			
			var span:SpanElement = new SpanElement();
			span.color = 0xffffff;
			span.text = newText;
			span.fontSize = 20;
			span.fontFamily = "宋体";
			
			
			paragraphElement.addChild(span);
			dataProxy.flyInputPaneVO.textFlow.flowComposer.updateAllControllers(); 
			e.stopImmediatePropagation();
		}
		
		private function getTextFlowText():String
		{
			var exporter:ITextExporter = TextConverter.getExporter(TextConverter.TEXT_LAYOUT_FORMAT);
			
			var xml:XML = exporter.export(component.vo.textFlow,ConversionType.XML_TYPE) as XML;
			var xmlList:XMLList = xml.children();
			var msg:String = "";
			for each(var node:XML in xmlList.children())
			{
				switch(node.localName())
				{
					case "img":
						var source:String = node.@source;
						//var id:int = FacePaneVO.getIconId(source);
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
			var pattern:RegExp=/[\u4e00-\u9fa5]|\\/g;
			return msg.match(pattern).length;
		}
		
		/**
		 * 回车发送飞屏
		 */
		private function textInputHandler(e:TextEvent):void
		{
			trace("textInputHandler",component.inputContainer.numChildren);
			
			//添加文字
			//dataProxy.flyInputPaneVO.addText(e.text);
			
			//限制字数
			//			var paragraphElement:ParagraphElement = dataProxy.flyInputPaneVO.textFlow.getChildAt(0) as ParagraphElement;
			
//			var str:String = getTextFlowText();
//			var num:uint = chineseNum(str);
//			num = str.length + num;
//			
//			if(num >= dataProxy.flyInputPaneVO.wordNum)
//			{
//				e.stopImmediatePropagation();
//			}
//			
//			num = e.text.length + chineseNum(e.text) + num;
//			
//			if(num > dataProxy.flyInputPaneVO.wordNum)
//			{
//				e.stopImmediatePropagation();
//			}
			
			if(e.text == "\r")
			{
				if(dataProxy.isVisitor)
				{
					ExternalInterface.call("MGC_Comm.CheckGuestStatus");
					return;
				}
				Mouse.cursor=MouseCursor.ARROW;
				Mouse.cursor=MouseCursor.AUTO;
				dataProxy.flyInputPaneVO.textFlow.interactionManager.refreshSelection();
				sendNotification(ApplicationFacade.SendMessage);
			}
		}
		
		/**
		 * 输入框文字更新
		 */		
		private function tipHandler(e:Event):void
		{
			component.text_tip.text = dataProxy.flyInputPaneVO.tip;
		}
		
		/**
		 * 文本渲染完毕
		 */		
		private function completeHandler(e:Event):void
		{
			//XW78840 不判断多行，一旦回车就会发送消息。增加删除最后是空行的逻辑
			//防止多行
//			while(dataProxy.flyInputPaneVO.textFlow.numChildren > 1)
//			{
//				dataProxy.flyInputPaneVO.textFlow.removeChildAt(1);
//			}
			if (dataProxy.flyInputPaneVO.textFlow.numChildren > 1) {
				for (var i:int = dataProxy.flyInputPaneVO.textFlow.numChildren - 1; i > 0; i--) {
					var lineElement:ParagraphElement = dataProxy.flyInputPaneVO.textFlow.getChildAt(i) as ParagraphElement;
					if (lineElement.getText() == "") {
						dataProxy.flyInputPaneVO.textFlow.removeChildAt(i);
					} else {
						break;
					}
				}
			}

			//是否需要清除提示文字
			if(dataProxy.flyInputPaneVO.tip != "")
			{
				var paragraphElement:ParagraphElement = dataProxy.flyInputPaneVO.textFlow.getChildAt(0) as ParagraphElement;
				//判断内容是否为空
				if(paragraphElement.getText() != "")
				{
					dataProxy.flyInputPaneVO.tip = "";
				}
			}
		}
		
		/**
		 * 界面是否显示
		 */		
		private function visibleHandler(e:Event):void
		{
			component.visible = dataProxy.flyInputPaneVO.visible;
		}
		
		/**
		 * 点击自身防止触发stage事件而消失
		 */		
		private function clickHandler(e:MouseEvent):void
		{
			e.stopImmediatePropagation();
		}
		
		override public function listNotificationInterests():Array
		{
			return new Array();
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
		}
		
		public function get component():FlyInputPane
		{
			return viewComponent as FlyInputPane;
		}
		
		
	}
}