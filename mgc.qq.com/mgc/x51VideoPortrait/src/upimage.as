package 
{
	import com.tencent.tgideas.code.utils.Base64;
	import com.tencent.tgideas.code.utils.JPGEncoderIMP;
	import com.tencent.x5.components.BackgroundUI;
	import com.tencent.x5.components.EditImage;
	import com.tencent.x5.components.Image160;
	import com.tencent.x5.components.Image60;
	import com.tencent.x5.components.ImageView;
	import com.tencent.x5.components.Interface;
	import com.tencent.x5.proxy.FileProxy;
	import com.tencent.x5.utils.OverrideBulkLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.filters.ColorMatrixFilter;
	import flash.ui.ContextMenu;
	
	[SWF(backgroundColor="#0", frameRate="30",width="976",height="581")]
	public class upimage extends Sprite
	{
		private var _file:FileProxy;
		private var _upbtn:BTNMC1;
		private var _save:SAVEMC;
		private var _background:BackgroundUI;
		private var _text1:TXT1;
		private var _text2:TXT2;
		private var _view1:ImageView;
		private var _view2:ImageView;
		private var upLoadBitmapData:BitmapData;
		//		private var _edit:EditImage;
		
		private var headUrl:String;
		private var Image:Sprite;
		private var ImageOriginalWidth:Number = 0;
		private var ImageOriginalHeight:Number = 0;
		private var _interface:Interface;
		private var overrideBulkLoader:OverrideBulkLoader;
		
		public function upimage()
		{
			init();
			ExternalInterface.addCallback("request_as",request_as);
			overrideBulkLoader = OverrideBulkLoader.getInstance();
//			var tojson:Object = new Object();
//			tojson.op_type = "186";
//			ExternalInterface.call("gift_send",tojson);
		}
		
		
		private function request_as(jsonparam:*):void
		{
			//屏蔽加载已上传头像
			return;
			
			
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
			
			if(params.pUrl && params.pUrl.length)
			{
				headUrl = params.pUrl;
				if(overrideBulkLoader.hasItem(headUrl))
				{
					onBulkLoaderComplete();
				}
				else
				{
					overrideBulkLoader.add(headUrl,null,onBulkLoaderComplete);
				}
			}
		}
		private function onBulkLoaderComplete(data:Object=null):void
		{
			var headBitmap:Bitmap = overrideBulkLoader.getBitmap(headUrl);
			_view2.bitmapData =_view1.bitmapData = headBitmap.bitmapData;
		}
		
		protected function init():void
		{
			// TODO Auto Generated method stub
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode =StageScaleMode.NO_SCALE
			addChilded();
			
			var context:ContextMenu= new ContextMenu();
			context.hideBuiltInItems();			
			this.contextMenu = context;	
			_upbtn.addEventListener(MouseEvent.CLICK,onClick)
			_file = new FileProxy();
			_file.addEventListener(Event.COMPLETE,onSelectComplete);
			
		}
		
		protected function addChilded():void
		{
			// TODO Auto Generated method stub
			
			_background = new BackgroundUI();			
			addChild(_background)
			_background.width = 976;
			_background.height = 581;
			
			
			_interface = new Interface();
			addChild(_interface);
			_interface.x = 120;
			_interface.y = 150;
			
			_interface.addEventListener(Event.CHANGE,onChange);
			_upbtn = new BTNMC1();
			
			addChild(_upbtn)
			_upbtn.x = 120;
			_upbtn.y = 48;
			
			_text1 = new TXT1();
			addChild(_text1);
			_text1.x = 120;
			_text1.y = 100
			_text2 = new TXT2();
			addChild(_text2);
			_text2.x = 550;
			_text2.y = 100
			_view1 =new Image160();
			_view1.x =550
			_view1.y = 240
			addChild(_view1);
			_view2 = new Image60();
			addChild(_view2);
			_view2.x = 780;
			_view2.y = 340
			_save = new SAVEMC();
			addChild(_save);
			_save.x = 240;
			_save.y = 490;
			_save.addEventListener(MouseEvent.CLICK,onSave);
			isDisabled(false);
		}
		
		protected function onSave(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			var pg:JPGEncoderIMP = new JPGEncoderIMP(80);
			pg.addEventListener(Event.COMPLETE,onComplete);
			
			var bitmap:Bitmap = new Bitmap();
			bitmap.bitmapData = _view1.bitmapData;
			bitmap.width = 160;
			bitmap.height = 160;
			upLoadBitmapData = new BitmapData(160,160);
			upLoadBitmapData.draw(bitmap,bitmap.transform.matrix);
			
			pg.encodeAsync(upLoadBitmapData);
			isDisabled(false);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			_file.open()
		}	
		
		protected function onSelectComplete(event:Event):void
		{
			// TODO Auto-generated method stub
			_interface.bitmapData = _file.bitmapData	;
			isDisabled(true);
		}
		
		protected function onComplete(event:Event):void
		{
			// TODO Auto-generated method stub
			var e:JPGEncoderIMP = event.currentTarget as JPGEncoderIMP;
			var s:String = Base64.encodeByteArray(e.ba);
			trace(s);
			ExternalInterface.call("saveImage",s);
			upLoadBitmapData.dispose();
			upLoadBitmapData = null;
			isDisabled(true);
		}
		
		private function isDisabled(b:Boolean):void
		{
			_save.enabled = b;
			_save.mouseEnabled = b;
			if(b)
			{
				_save.filters = [];
			}
			else
			{
				var matrix:Array=[0.3086, 0.6094, 0.0820, 0, 0,  
					0.3086, 0.6094, 0.0820, 0, 0,  
					0.3086, 0.6094, 0.0820, 0, 0,  
					0,      0,      0,      1, 0];  
				//初始化一个ColorMatrixFilter对象(matrix作为参数)  
				var myfilter:ColorMatrixFilter=new ColorMatrixFilter([0.3,0.6,0,0,0,0.3,0.6,0,0,0,0.3,0.6,0,0,0,0,0,0,1,0])
				//将滤镜应用于图片  
				_save.filters=[myfilter];
			}
		}
		
		protected function onChange(event:Event):void
		{
			// TODO Auto-generated method stub
			_view2.bitmapData =_view1.bitmapData= (_interface.cutbitmapdata);
		}
	}
}