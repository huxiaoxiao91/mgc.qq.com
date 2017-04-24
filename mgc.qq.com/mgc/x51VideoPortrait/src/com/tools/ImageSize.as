package com.tools 
{
	import flash.display.Sprite;
	/**
	 * 设置图片大小类
	 * @author xiaofeng
	 */
	public class ImageSize 
	{
		public function ImageSize() 
		{
		}
		/**
		 * 参数说明
		 * @param	Image：需要设置大小的显示对象
		 * @param	FrameWidth:框架宽度
		 * @param	FrameHeight:框架高度
		 * @param	ImageWidth:图片加载进来时宽度
		 * @param	ImageHeight:图片加载进来时高度
		 */
		public static function setImageSize(Image:*,FrameWidth:Number,FrameHeight:Number,ImageWidth:Number, ImageHeight:Number):void
		{
			if ((ImageWidth / ImageHeight) > (FrameWidth / FrameHeight))
			{
				Image.width = FrameWidth;
				Image.height = FrameWidth / (ImageWidth / ImageHeight);
			}
			else if ((ImageWidth / ImageHeight) < (FrameWidth / FrameHeight))
			{
				Image.height = FrameHeight;
				Image.width = FrameHeight * (ImageWidth / ImageHeight);
			}
			else if ((ImageWidth / ImageHeight) == (FrameWidth / FrameHeight))
			{
				Image.width = FrameWidth;
				Image.height = FrameHeight;
			}
		}
	}
}