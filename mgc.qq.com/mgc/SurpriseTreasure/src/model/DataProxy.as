package model
{
	import br.com.stimuli.loading.BulkLoader;
	
	import com.bit101.utils.GeneralEventDispatcher;
	import com.junkbyte.console.Cc;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.SecurityErrorEvent;
	import flash.external.ExternalInterface;
	import flash.globalization.DateTimeFormatter;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.setTimeout;
	
	import model.data.*;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import view.mediators.ApplicationMediator;
	

	public class DataProxy extends Proxy implements IProxy
	{
		
		public static const NAME:String = "DataProxy";
		public static var isCaveolaeBo:Boolean = false;
		
		/**
		 * 是否是演唱会
		 */
		public static var isConcert:Boolean = false;
		
		/**
		 * 是否游客
		 */
		public static var isVisitor:Boolean = false;

		/**
		 * 专属皮肤1——迷情舞台
		 */
		public static const SKIN_ID_1_STAGE:uint                 = 1;
		/**
		 * 专属皮肤2——海底世界
		 */
		public static const SKIN_ID_2_SEA:uint                   = 2;
		/**
		 * 专属皮肤3——游乐园
		 */
		public static const SKIN_ID_3_PARK:uint                  = 3;
		
		/**
		 * 皮肤id
		 */
		public static var skinId:int;
		/**
		 * 皮肤等级
		 */		
		public static var skinLevel:int;
		
		/**
		 * 皮肤已经开启
		 * @return 
		 * 
		 */		
		public static function get isSkinOpened():Boolean {
			return skinId > 0 && skinLevel > 0;
		}
		
		/**
		 * 惊喜宝箱 
		 */		
		public var surpriseTreasurePaneVo:SurpriseTreasurePaneVo = new SurpriseTreasurePaneVo();
		
		private var surpriseTreasureObj:Object = null;
		
		public function DataProxy()
		{
			super(NAME);
			
			//Js调用Flash
			ExternalInterface.addCallback("request_as", request_as);
			
			var tojson:Object = new Object();
			tojson.op_type = -100;
//			var str:String = JSON.stringify(tojson);
			ExternalInterface.call("response_as",tojson);
		}
		
		/**
		 * JS回调接口
		 */
		/**
		 * 
		 * @param jsonparam
		 */
		public function request_as(jsonparam:*):void
		{
			//Cc.log(jsonparam);
			var params:Object; 
			
			//判断obj str
			if(jsonparam is String)
			{
				try{
					params = JSON.parse(jsonparam);
				}
				catch(e:SyntaxError)
				{
					return;
				}
			}
			else
			{
				params = jsonparam;
			}
			
			if(params == null)return;
			
			var dtf:DateTimeFormatter = new DateTimeFormatter("zh-CN"); 
			dtf.setDateTimePattern("yyyy-MM-dd HH:mm:ss:SSSSS");
			//Cc.warn("登录回调：",JSON.stringify(jsonparam) + dtf.format(new Date()));
			switch(params.op_type as int)
			{
				case 226:
					if(!DataProxy.isConcert)
					{
						params.updateTime = (new Date()).time;
						
						if(DataProxy.isCaveolaeBo)
						{
							params.left_open_box_times = params.nest_left_open_times;
							//Cc.log("params.left_open_box_times = " + params.left_open_box_times + "     params.nest_left_open_times =  " + params.nest_left_open_times );
						}
						
						//Cc.log("surpriseTreasurePaneVo.isOpen = " + surpriseTreasurePaneVo.isOpen + "   DataProxy.isCaveolaeBo = " + DataProxy.isCaveolaeBo);
						
						if(!surpriseTreasurePaneVo.isOpen)
						{
							updateSurpriseTreasure(params)
						}
						else
						{
							surpriseTreasureObj = params;
							
							if(surpriseTreasureObj.percent == 100 &&　surpriseTreasureObj.cd_seconds == 0 )
							{
								if(surpriseTreasureObj.left_open_box_times == surpriseTreasurePaneVo.left_open_box_times){
									surpriseTreasureObj.left_open_box_times -= 1; 
								}
//								surpriseTreasureObj.percent = 0;
//								surpriseTreasureObj.cd_second = surpriseTreasureObj.total_cd_seconds;
							}
						}
					}
					else
					{
						surpriseTreasurePaneVo.visible = false;
					}
					break;
				//打开惊喜宝箱
				case 225:
					if(params.result == 0)
					{
						surpriseTreasurePaneVo.isOpen = false;
						var tojson1:Object = new Object();
						tojson1.op_type = 183;
						ExternalInterface.call("gift_send",tojson1);
						updateSurpriseTreasureObj();
					}
					break;
				case 35:
					if(params.status == 2)
					{
						if(surpriseTreasurePaneVo.left_open_box_times == 0 || DataProxy.isVisitor)
						{
							surpriseTreasurePaneVo.visible = false;
						}
						else
						{
							surpriseTreasurePaneVo.visible = true;
						}
					}
					else
					{
						surpriseTreasurePaneVo.visible = false;
						
						//停播时清宝箱状态
						surpriseTreasurePaneVo.isOpen = false;
					}
					break;
				case 280:
					if(params.hasOwnProperty("isCaveolaeBo"))
						DataProxy.isCaveolaeBo = params.isCaveolaeBo;
					
					if(params.hasOwnProperty("isConcert"))
						DataProxy.isConcert = params.isConcert;
					
					if(params.hasOwnProperty("isVisitor"))
						DataProxy.isVisitor = params.isVisitor;

					if (params.hasOwnProperty("skinId")) {
						DataProxy.skinId = params.skinId;
					}
					
					if (params.hasOwnProperty("skinLevel")) {
						DataProxy.skinLevel = params.skinLevel;
					}

					surpriseTreasurePaneVo.updateBg = DataProxy.isCaveolaeBo;
					
					if(!DataProxy.isConcert || DataProxy.isVisitor)
					{
						surpriseTreasurePaneVo.visible = false;
					}
					else
					{
						surpriseTreasurePaneVo.visible = true;
					}
					break;
			}
		}
		
		private function updateSurpriseTreasureObj():void
		{
			if(surpriseTreasureObj)
			{
				surpriseTreasureObj.cd_seconds = surpriseTreasureObj.cd_seconds  - Math.round(((new Date()).time - surpriseTreasureObj.updateTime)/1000);
				updateSurpriseTreasure(surpriseTreasureObj);
				surpriseTreasureObj = null;
			}
			else
			{
				if(surpriseTreasurePaneVo.need_flower_count > 0)
				{
					surpriseTreasurePaneVo.percent = 0;
					surpriseTreasurePaneVo.left_open_box_times -= 1;
					surpriseTreasurePaneVo.cd_seconds = surpriseTreasurePaneVo.total_cd_seconds  - Math.round(((new Date()).time - surpriseTreasurePaneVo.updateTime)/1000);
					if(surpriseTreasurePaneVo.left_open_box_times == 0 || isVisitor)
					{
						surpriseTreasurePaneVo.visible = false;
					}
					else
					{
						surpriseTreasurePaneVo.visible = true;
					}
				}
			}
		}
		
		private function updateSurpriseTreasure(obj:Object):void
		{
			surpriseTreasurePaneVo.active = obj.active;
			surpriseTreasurePaneVo.activity_id = obj.activity_id;
			surpriseTreasurePaneVo.percent = obj.percent;
			surpriseTreasurePaneVo.cd_seconds= obj.cd_seconds;
			surpriseTreasurePaneVo.need_flower_count= obj.need_flower_count;
			surpriseTreasurePaneVo.left_open_box_times = obj.left_open_box_times;
			surpriseTreasurePaneVo.updateTime = obj.updateTime;
			surpriseTreasurePaneVo.total_cd_seconds = obj.total_cd_seconds;
			
			
			//Cc.log("surpriseTreasurePaneVo.left_open_box_times"+ surpriseTreasurePaneVo.left_open_box_times +"    isVisitor " + isVisitor);
			if(surpriseTreasurePaneVo.left_open_box_times == 0 || DataProxy.isVisitor)
			{
				surpriseTreasurePaneVo.visible = false;
			}
			else
			{
				surpriseTreasurePaneVo.visible = true;
			}
		}

	}
}

