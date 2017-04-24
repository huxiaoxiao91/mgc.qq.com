package model.data
{	
	import br.com.stimuli.loading.BulkLoader;
	
	import com.bit101.utils.OverrideBulkLoader;
	import com.bit101.utils.SingleLoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import model.DataProxy;

	/**
	 * 表情界面数据模型
	 */
	public class FacePaneVO extends EventDispatcher
	{
		/**
		 * 表情界面数据模型
		 */
		public var faceList:Array = new Array();
		
		/**
		 * 默认为1 活动
		 */
		private var _type:int = 1;
		
		private var _isShowGuardFace:Boolean = true;
		
		private var _visible:Boolean = false;
		
		private var _currentPage:int;
		
		private var _totalPage:int;
		
		private var xmlUrl:String; 
		
		private var bulkLoader:BulkLoader = BulkLoader.getLoader("gift");
		
		public function FacePaneVO()
		{
			//initXML();
			
			initFace();
		}
		
		/**
		 * 是否显示守护表情 
		 */
		public function get isShowGuardFace():Boolean
		{
			return _isShowGuardFace;
		}

		/**
		 * @private
		 */
		public function set isShowGuardFace(value:Boolean):void
		{
			_isShowGuardFace = value;
			dispatchEvent(new Event("isShowGuardFace"));
		}

		/**
		 * 初始化表情
		 * 0-134
		 * 186-206
		 * 176-185
		 */		
		private function initFace():void
		{
			var vo:FaceVO;
			var vo1:FaceVO;
			for(var i:int = 0;i <= 134;i++)
			{
				vo = new FaceVO();
				vo.id = i;
				vo.icon = getIcon(vo.id);
				vo.type = 1;
				faceList.push(vo); 
			}
			
			for(i = 186;i <= 206;i++)
			{
				vo = new FaceVO();
				vo.id = i;
				vo.icon = getIcon(vo.id);
				vo.type = 1;
				faceList.push(vo); 
			}
			
			for(i = 176;i <= 185;i++)
			{
				vo = new FaceVO();
				vo.id = i;
				vo.icon = getIcon(vo.id);
				vo.type = 2;
				faceList.push(vo); 
			}
			
			i = 207
			while(i <= 216)
			{
				vo = new FaceVO();
				vo.id = i;
				vo.icon = getIcon(vo.id);
				vo.type = 3;
				faceList.push(vo); 
				i++;
			}
			
			while(i <= 226)
			{
				vo = new FaceVO();
				vo.id = i;
				vo.icon = getIcon(vo.id);
				vo.type = 4;
				faceList.push(vo); 
				i++;
			}
		}
		
		/**
		 * 表情类型
		 * 1 活动 2 守护 ,3特权1,4特权2
		 */
		public function get type():int
		{
			return _type;
		}

		/**
		 * @private
		 */
		public function set type(value:int):void
		{
			_type = value;
			
			dispatchEvent(new Event("type"));
		}

		/**
		 * 总页数
		 */
		public function get totalPage():int
		{
			return _totalPage;
		}

		/**
		 * @private
		 */
		public function set totalPage(value:int):void
		{
			_totalPage = value;
			
			dispatchEvent(new Event("page"));
		}

		/**
		 * 当前页
		 */
		public function get currentPage():int
		{
			return _currentPage;
		}

		/**
		 * @private
		 */
		public function set currentPage(value:int):void
		{
			_currentPage = value;
			
			dispatchEvent(new Event("page"));
		}

		/**
		 * 加载XML数据
		 */
		public function initXML():void
		{
			xmlUrl = DataProxy.Domain + "/config/face.xml";
			
			bulkLoader.add(xmlUrl);
			bulkLoader.addEventListener(BulkLoader.COMPLETE, onComplete);
			bulkLoader.start();
		}
		
		/**
		 * XML加载完毕
		 */		
		private function onComplete(e:Event):void
		{
			bulkLoader.removeEventListener(BulkLoader.COMPLETE, onComplete);
			
			//解析
			var xml:XML = bulkLoader.getXML(xmlUrl);
			
			for(var i:int = 0;i < xml.face.length();i++)
			{
				var vo:FaceVO = new FaceVO();
				vo.id = xml.face[i].@id;
				vo.name = xml.face[i].@name;
				vo.icon = getIcon(vo.id);
				vo.type = xml.face[i].@type;
				
				OverrideBulkLoader.getInstance().add(vo.icon);
				faceList.push(vo); 
			}
			
			dispatchEvent(new Event("type"));
		}
		
		/**
		 * 
		 * @param type 表情类型
		 * @return 表情列表
		 * 
		 */		
		public function getListByType(type:int):Array
		{
			var arr:Array = new Array();
			for(var i:int = 0;i < faceList.length;i++)
			{
				var vo:FaceVO = faceList[i] as FaceVO; 
				if(vo.type == type)
				{
					arr.push(vo);
				}
			}
			
			return arr;
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
		
		/**
		 * 通过id获取表情地址的规则 
		 * @param id
		 * @return 
		 * 
		 */		
		static public function getIcon(id:int):String
		{
			var icon:String;
			if(id < 100)
			{
				if(id < 10)
				{
					icon = DataProxy.ImgDomain + "/css_img/flash/chat/chat_f0" + id.toString() + ".png";
				}
				else
				{
					icon = DataProxy.ImgDomain + "/css_img/flash/chat/chat_f" + id.toString() + ".png";
				}
			}
			else if(id < 200 && id >= 100)
			{
				icon = DataProxy.ImgDomain + "/css_img/flash/chat/chat_g" + id.toString().substr(1,2) + ".png";	
			}
			else if(id > 206 && id < 227)
			{
				icon = DataProxy.ImgDomain + "/css_img/flash/chat/chat_h" + id.toString().substr(1,2) + ".png";	
			}
			else if(id < 300 && id >= 200)
			{
				icon = DataProxy.ImgDomain + "/css_img/flash/chat/chat_h" + id.toString().substr(1,2) + ".png";
			}
			
			return icon;
		} 
		
		
		/**
		 * 通过表情地址  返回JS需要的格式
		 * @param url 表情地址
		 * @return 返回JS需要的格式
		 */		
		static public function getIcon2(url:String):String
		{
			var icon:String;
			
			var start:int = url.indexOf("chat_");
			var end:int = url.indexOf(".png");
			
			if(start != -1)
			{
				icon = "/mgcchat_" + url.slice(start + 5,end);
			}
			
			/*if(id < 100)
			{
				if(id < 10)
				{
					icon = "/mgcchat_f0" + id.toString();
				}
				else
				{
					icon = "/mgcchat_f" + id.toString();
				}
			}
			else if(id < 200 && id >= 100)
			{
				icon = "/mgcchat_g" + id.toString().substr(1,2);	
			}
			else if(id < 300 && id >= 200)
			{
				icon = "/mgcchat_h" + id.toString().substr(1,2);
			}*/
			
			return icon;
		}
		
		
		/**
		 * 通过表情地址获取id 
		 * @param url 表情地址
		 * @return 表情id
		 * 
		 */		
		static public function getIconId(url:String):int
		{
			var start:int;
			var end:int = url.indexOf(".png");
			var id:int = -1;
			
			start = url.indexOf("chat_f0");
			if(start != -1)
			{
				id = int(url.slice(start + 7,end));
				return id;
			}
			
			start = url.indexOf("chat_f");
			if(start != -1)
			{
				id = int(url.slice(start + 6,end));
				return id;
			}
			
			start = url.indexOf("chat_g");
			if(start != -1)
			{
				id = int(url.slice(start + 6,end));
				return id;
			}
			
			start = url.indexOf("chat_h");
			if(start != -1)
			{
				id = int(url.slice(start + 6,end));
				return id;
			}
			
			return id;
		}
		
	}
}