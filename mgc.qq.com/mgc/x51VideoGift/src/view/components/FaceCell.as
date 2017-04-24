package view.components
{
	import br.com.stimuli.loading.BulkLoader;

	import com.bit101.components.ListItem;
	import com.bit101.utils.OverrideBulkLoader;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class FaceCell extends ListItem
	{
		private var bulkLoader:BulkLoader;

		private var overrideBulkLoader:OverrideBulkLoader;

		private var mc_GiftCell_1:MC_GiftCell_1 = new MC_GiftCell_1();

		public function FaceCell(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, data:Object = null)
		{
			super(parent, xpos, ypos, data);
			this.buttonMode = true;
		}

		/**
		 * Draws the visual ui of the component.
		 */
		public override function draw():void
		{

			graphics.clear();

			if (_mouseOver)
			{
				graphics.beginFill(0x0, 0);
				graphics.lineStyle(1, 0x4ca0d9);
				graphics.drawRect(0, 0, 24, 24);
				graphics.endFill();
				graphics.lineStyle(1, 0x4ca0d9, 0);
			}

			/**
			 * 移除全部显示对象
			 */
			while (this.numChildren > 0)
			{
				var disObj:DisplayObject = this.removeChildAt(0);
				disObj = null;
			}

			if (_data == null)
				return;

//			bulkLoader = BulkLoader.getLoader("gift");
//			if(bulkLoader.hasItem(_data.icon))
//			{
//				initIcon();
//			}
//			else
//			{
//				bulkLoader.add(_data.icon);
//				bulkLoader.addEventListener(BulkLoader.COMPLETE, onImageComplete);
//				bulkLoader.start();
//			}

			overrideBulkLoader = OverrideBulkLoader.getInstance();
			if (overrideBulkLoader.hasItem(_data.icon))
			{
				initIcon();
			}
			else
			{
				overrideBulkLoader.add(_data.icon, null, onComplete);
			}
		}


		/**
		 * 礼物图片加载完毕
		 */
		private function onComplete(data:Object = null):void
		{
			initIcon();
		}

		private function onImageComplete(data:Object = null):void
		{
			bulkLoader.removeEventListener(BulkLoader.COMPLETE, onImageComplete);
			if (bulkLoader.hasItem(_data.icon))
			{
				initIcon();
			}
		}

		private function initIcon():void
		{
			var icon:DisplayObject = overrideBulkLoader.getBitmap(_data.icon);

			if (!icon)
				return;

			if (icon.width != 24)
			{
				icon.x = (24 - icon.width) / 2;
			}

			if (icon.height != 24)
			{
				icon.y = (24 - icon.height) / 2;
			}

			/*icon.width = 24;
			icon.height = 24;*/
			this.addChild(icon);

			mc_GiftCell_1.mouseChildren = false;
			mc_GiftCell_1.mouseEnabled = false;
			//addChild(mc_GiftCell_1);

			if (_selected)
			{
				//graphics.beginFill(_selectedColor);
				mc_GiftCell_1.visible = true;
			}
			else if (_mouseOver)
			{
				/*graphics.lineStyle(2,0x000000);
				graphics.drawRoundRect(5,5,40,40,20,20);
				graphics.endFill();*/
				//graphics.beginFill(_rolloverColor);

				mc_GiftCell_1.visible = true;
			}
			else
			{
				//graphics.beginFill(_defaultColor);
				mc_GiftCell_1.visible = false;
			}
		}

	}
}
