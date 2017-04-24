package view.components
{
	import br.com.stimuli.loading.BulkLoader;
	
	import com.bit101.components.Component;
	import com.bit101.components.Image;
	import com.bit101.components.Label;
	import com.bit101.utils.OverrideBulkLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import model.DataProxy;
	
	/**
	 * 
	 * 财富等级图标
	 * @author Jason
	 * 
	 */	
	public class WealthIcon extends Component
	{
		private var image:Image;
		private var label:Label;
		
		private var source:String;
		private var bulkLoader:BulkLoader;
		
		private var overrideBulkLoader:OverrideBulkLoader;
		
		public function WealthIcon(level:int)
		{
			this.setSize(24,24);
			
			//var n:int = level/10;
			//bulkLoader = BulkLoader.getLoader("gift");
			
			overrideBulkLoader = OverrideBulkLoader.getInstance();
			
			source = DataProxy.ImgDomain + "/css_img/flash/icon/wealth_" + level.toString() + ".png";
			if(overrideBulkLoader.hasItem(source))
			{
				initUI();
			}
			else{
				overrideBulkLoader.add(source,null,initUI);
			}
			
			/*if(overrideBulkLoader.hasItem(source))
			{
				initUI();
			}
			else
			{
				overrideBulkLoader.add(source,null,initUI);
			}*/
			
			
			
			/*label = new Label(this,0,2,level.toString());
			label.autoSize = false;
			var textFormat:TextFormat = new TextFormat("微软雅黑",12,0xFFFFFF);
			textFormat.align = TextFormatAlign.CENTER;
			label.textFormat = textFormat;
			label.setSize(24,24);*/
		}
		
		private function complete(e:Event):void
		{
			initUI();
		}
		
		private function initUI(data:Object = null):void
		{
			var bitmapdata:BitmapData = overrideBulkLoader.getBitmap(source).bitmapData;
			var bitmap:Bitmap = new Bitmap(bitmapdata);
			bitmap.width = 24;
			bitmap.height = 24;
			addChild(bitmap);
			//image = new Image(this,0,0,bitmap);
			//image.setSize(24,24);
		}
	}
}