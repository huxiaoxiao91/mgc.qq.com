package com.tencent.x5.components
{
	import com.senocular.display.TransformTool;
	
	import flash.display.Bitmap;

	public class ShowImage extends Component
	{
		private var _content:TransformTool;
		private var _sheep:Bitmap;
		
		public function ShowImage()
		{
			super();
		}
		
		override protected function addChilded():void
		{
			_width = 300;
			_height = 300;
			super.addChilded();
			_content = new TransformTool();
			_content.rotationEnabled = false;
			_sheep = new Bitmap();
			
			_content.constrainScale =true
			_content.addEventListener(TransformTool.TRANSFORM_TARGET,onMove)
			_contentSpr = new Sprite();
			addChild(_contentSpr)
			_bitmap = new Bitmap();
			_contentSpr.addChild(_bitmap)
			_mask =new Shape();
			addChild(_mask)
			addChild(_content)
			this.mask =_mask
			_ve = new VIEWPIC();
			addChild(_ve);
		}
	}
}