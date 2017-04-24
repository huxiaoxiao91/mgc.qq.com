package view.components
{
	import com.bit101.components.OverrideScrollPane;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import model.data.MessagePaneVO;
	import flash.external.ExternalInterface;
	import com.bit101.components.OverrideScrollPane;
	import flash.events.Event;
	import com.bit101.utils.GeneralEventDispatcher;
	import com.bit101.components.PushButton;
	
	public class MessagePane extends OverrideScrollPane
	{
		public var vo:MessagePaneVO;
		
//		public var messageContainer:Sprite;
//		public var containerController:ContainerController;
	
		
		//背景元件
		private var background:Sprite = new MC_MessagePane_1();
		
		private var isRollOver:Boolean = false;


		public function MessagePane(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0)
		{
			super(parent, xpos, ypos);
			this.visible = false;
		}
		
		public function initUI():void
		{
			this.autoHideScrollBar = true;
			//滚轮事件
			stage.addEventListener(MouseEvent.MOUSE_WHEEL,wheelHandler);
			stage.addEventListener(MouseEvent.MOUSE_OVER,rollOver);
			stage.addEventListener(MouseEvent.MOUSE_OUT,rollOut);
			
			vo.content = content;
			vo.listWidth = width;
			content.addEventListener("updateEvent",compositionComplete);
			
			ExternalInterface.addCallback("callbackWheelHandler",callbackWheelHandler);
			
			//this.addEventListener(Event.ENTER_FRAME,ef);
			
		}
		
		//刷新  防止黑边
		private function ef(e:Event):void
		{
			draw();
		}
		
		private function rollOver(e:MouseEvent):void
		{
			isRollOver = true;
		}
		
		private function rollOut(e:MouseEvent):void
		{
			isRollOver = false;
		}
		
		private function callbackWheelHandler(delta:int):void
		{
			if(isRollOver)
			{
				if(this.vScrollbar.value >= this.vScrollbar.maximum || this.vScrollbar.value <= this.vScrollbar.minimum)
				{
					//Cc.log("滚动条调用1       " + delta);
					ExternalInterface.call("callPageWheelHandler",true,delta);
				}
				else
				{
					//Cc.log("滚动条调用2      " + delta);
					ExternalInterface.call("callPageWheelHandler",false,delta);
				}
				
				this.vScrollbar.value += -delta;
				this.update();
			}
			else
			{
				//Cc.log("滚动条调用3   " + delta);
				ExternalInterface.call("callPageWheelHandler",true,delta);
			}
		}
		
		private function wheelHandler(e:MouseEvent):void
		{
			trace(e.delta);
			//Cc.log("滚动条调用4   " + e.delta);
			this.vScrollbar.value += -e.delta;
			this.update();
		}
		
		private function compositionComplete(e:Event):void
		{
			//超过100个段落不保存
			if(content.numChildren > 100)
			{
				//vo.textFlow.removeChildAt(0);
				//vo.textFlow.flowComposer.updateAllControllers(); 
			}
			
			if(content.numChildren > 0)
			{
				this.visible = true;
			}

//			import flashx.textLayout.tlf_internal;
//			use namespace tlf_internal;
//			var contentHeight:Number = vo.textFlow.flowComposer.getControllerAt(0).tlf_internal::contentHeight;
			//messageContainer.height = vo.textFlow.flowComposer.getControllerAt(0).tlf_internal::contentHeight + 15;
			//messageContainer.height = contentHeight;
			//this.content.height = 25 * content.numChildren;

			if (content.numChildren > 0)
			{
				this.content.height = vo.listContentHeight;
			}
			else
			{
				this.content.height = 0;
			}
			
			draw();
			//containerController.setCompositionSize(width,contentHeight);
			this.vScrollbar.value = this.vScrollbar.maximum;
			this.update();
		}
		
		/**
		 * Draws the visual ui of the component, in this case, laying out the sub components.
		 */
		override public function draw() : void
		{
			super.draw();
			
			/*this.graphics.clear();
			this.graphics.lineStyle(1, 0x642FBA, 1);
			this.graphics.beginFill(0x000000);
			this.graphics.drawRect(0, 0, width, height);
			this.graphics.endFill();*/
		}
		
		/**
		 * Sets the size of the component.
		 * @param w The width of the component.
		 * @param h The height of the component.
		 */
		override public function setSize(w:Number, h:Number):void
		{
			super.setSize(w, h);
			
			if(vo != null){
				vo.listWidth = w;
			}
			
			background.width = w;
			background.height = h;
		}
		
	}
}