package view.mediators
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import model.DataProxy;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.components.SurpriseTreasurePane;
	
	public class SurpriseTreasurePaneMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "SurpriseTreasurePaneMediator";
		private var dataProxy:DataProxy;
		
		public function SurpriseTreasurePaneMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
			dataProxy = facade.retrieveProxy(DataProxy.NAME) as DataProxy;
			
			component.vo = dataProxy.surpriseTreasurePaneVo;
			component.vo.addEventListener("visible",visibleHandler);
			component.vo.addEventListener("upadtePercent",upadtePercent);
			component.vo.addEventListener("upadteCDSeconds",upadteCDSeconds);
			component.vo.addEventListener("upadteFlowerCount",upadteFlowerCount);
			component.vo.addEventListener("upadteOpenBoxTimes",upadteOpenBoxTimes);
			component.vo.addEventListener("upadteActiv",upadteActiv);
			component.vo.addEventListener("isOpen",isOpen);
			component.vo.addEventListener("updateBg",updateBg);
			
			component.initUI();
			component.surpriseTreasure.addEventListener(MouseEvent.CLICK,openSurpriseTreasure);
			component.surpriseTreasure.addEventListener(MouseEvent.ROLL_OVER,rollOver);
			component.surpriseTreasure.addEventListener(MouseEvent.ROLL_OUT,rollOut);
			
			visibleHandler(null);
			upadtePercent(null);
			upadteCDSeconds(null);
			upadteFlowerCount(null);
			upadteOpenBoxTimes(null);
			upadteActiv(null);
			isOpen(null);
		}
		/**
		 * 更新宝箱状态
		 * @param e
		 * 
		 */		
		public function upadteActiv(e:Event):void
		{
			component.visible = dataProxy.surpriseTreasurePaneVo.active;
		}
		
		
		public function isOpen(e:Event):void
		{
			if(dataProxy.surpriseTreasurePaneVo.isOpen)
			{
				component.updateChestState(1);
			}
			else
			{
				component.updateChestState(0);
			}
		}
		
		public function get component():SurpriseTreasurePane
		{
			return viewComponent as SurpriseTreasurePane;
		}
		
		private function visibleHandler(e:Event):void
		{
			if(component)
			{
				component.visible = dataProxy.surpriseTreasurePaneVo.visible;
				
				if(component.tipSprite && !component.visible)
				{
					component.tipSprite.visible = false;
				}
			}
		}
		
		
		private function rollOver(e:MouseEvent):void
		{
			ExternalInterface.call("$chat_surpruse.showSurpriseTips",dataProxy.surpriseTreasurePaneVo.need_flower_count,dataProxy.surpriseTreasurePaneVo.cd_seconds,dataProxy.surpriseTreasurePaneVo.left_open_box_times,dataProxy.surpriseTreasurePaneVo.percent);	
		}
		
		private function rollOut(e:MouseEvent):void
		{
			ExternalInterface.call("$chat_surpruse.hideSurpriseTips");	
		}
		
		/**
		 *宝箱开启的次数
		 * @param e
		 * 
		 */		
		private function upadteOpenBoxTimes(e:Event):void
		{
			component.count = dataProxy.surpriseTreasurePaneVo.left_open_box_times;
		}
		
		/**
		 * 百分比
		 * @param e
		 * 
		 */		
		private function upadtePercent(e:Event):void
		{
			component.setFlowersProgress(dataProxy.surpriseTreasurePaneVo.percent);
		}
		
		/**
		 * cd时间
		 * @param e
		 * 
		 */		
		private function upadteCDSeconds(e:Event):void
		{
			component.setTimeProgress(dataProxy.surpriseTreasurePaneVo.cd_seconds)
		}
		
		/**
		 * 免费花数量
		 * @param e
		 * 
		 */		
		private function upadteFlowerCount(e:Event):void
		{
			component.flowersNum = dataProxy.surpriseTreasurePaneVo.need_flower_count;
		}
		
		private function updateBg(e:Event):void
		{
			component.updateBG();
		}
		
		private function openSurpriseTreasure(e:MouseEvent):void
		{
			var tojson:Object = new Object();
			if(!dataProxy.surpriseTreasurePaneVo.isOpen)
			{
				tojson.op_type = 224;
				tojson.activity_id = dataProxy.surpriseTreasurePaneVo.activity_id;
				if(DataProxy.isCaveolaeBo)
				{
					tojson.box_id = 11;
				}
				else
				{
					tojson.box_id = 4;
					
				}
				ExternalInterface.call("gift_send",tojson);
			}
			else
			{
				tojson.op_type = 225;
				ExternalInterface.call("gift_send",tojson);
			}
		}
	}
}