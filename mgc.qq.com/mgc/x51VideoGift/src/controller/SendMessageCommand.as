package controller
{	
	import flash.external.ExternalInterface;
	
	import flashx.textLayout.conversion.ConversionType;
	import flashx.textLayout.conversion.ITextExporter;
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.elements.ParagraphElement;
	
	import model.DataProxy;
	import model.data.FacePaneVO;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.mediators.*;
	
	
	public class SendMessageCommand extends SimpleCommand implements ICommand
	{
		private var dataProxy:DataProxy;
		
		override public function execute(notification:INotification):void
		{
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			
			var paragraphElement:ParagraphElement = dataProxy.flyInputPaneVO.textFlow.getChildAt(0) as ParagraphElement;

			//判断内容是否为空
			if (paragraphElement.getText() == "") {
				//XW78840
				var allEmpty:Boolean = true;
				if (dataProxy.flyInputPaneVO.textFlow.numChildren > 1) {
					for (var i:int = 1; i < dataProxy.flyInputPaneVO.textFlow.numChildren; i++) {
						paragraphElement = dataProxy.flyInputPaneVO.textFlow.getChildAt(i) as ParagraphElement;
						if (paragraphElement.getText() != "") {
							allEmpty = false;
							break;
						}
					}
				}

				if (allEmpty) {
					//trace("发送内容为空");
					sendNotification(ApplicationFacade.ShowFlyInputPane, {visible: false});

					while (dataProxy.flyInputPaneVO.textFlow.numChildren > 1) {
						dataProxy.flyInputPaneVO.textFlow.removeChildAt(1);
					}
					return;
				}
			}
			
				
			//发送内容
			/*for(var i:int = 0;i < paragraphElement.numChildren;i++)
			{
				var flowElement:* = paragraphElement.getChildAt(i);
				
				if(flowElement is SpanElement)
				{
					trace(flowElement.getText());
				}
				else if(flowElement is InlineGraphicElement)
				{
					trace(flowElement.source);
				}
			}*/
			
			var exporter:ITextExporter = TextConverter.getExporter(TextConverter.TEXT_LAYOUT_FORMAT);
			//trace(exporter.export(dataProxy.flyInputPaneVO.textFlow,ConversionType.XML_TYPE));
			
			var o:Object = new Object();
			o.op_type = 24;
			o.channelID = 2;
			o.receiverName = "";
			o.receiverZoneName = "";
			//o.msg = dataProxy.flyInputPaneVO.content;
			//o.msg = exporter.export(dataProxy.flyInputPaneVO.textFlow,ConversionType.XML_TYPE);
			
			var msg:String = "";
				
			//解析textFlow中的字符
			var xml:XML = exporter.export(dataProxy.flyInputPaneVO.textFlow,ConversionType.XML_TYPE) as XML;
			var xmlList:XMLList = xml.children();
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
			
			var r1:RegExp =/^\s*/;  
			var r2:RegExp =/\s*$/;  
			var s:String = msg.replace(r1,"").replace(r2,"");  
			if(s.length == 0)
			{
				sendNotification(ApplicationFacade.ShowFlyInputPane,{visible:false});
				
				dataProxy.flyInputPaneVO.removeAll();
				return;
			}
				
			
			var myPattern:RegExp = /\\/g;
			
			o.msg = msg.replace(myPattern, '\\\\');;
			
//			Cc.error("发送飞屏：",o.msg);
			
			//var obj:Object = new Object();
			//obj.nodeType = 0;
			//obj.content = exporter.export(dataProxy.flyInputPaneVO.textFlow,ConversionType.STRING_TYPE);
			
			//o.chatnods = [obj];
			
			/*var json:String = JSON.stringify(o);
			
			ExternalInterface.call("gift_send",json);*/
			
			ExternalInterface.call("gift_send",o);
			
			//Cc.warn("发送飞屏： ",json);
			//删除所有内容
			dataProxy.flyInputPaneVO.removeAll();
			while(dataProxy.flyInputPaneVO.textFlow.numChildren > 1)
			{
				dataProxy.flyInputPaneVO.textFlow.removeChildAt(1);
			}
			sendNotification(ApplicationFacade.ShowFlyInputPane,{visible:false});
		}
	}
}