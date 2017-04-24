package view.components
{
	import com.bit101.components.Component;
	
	import flash.display.DisplayObjectContainer;
	
	/**
	 * 
	 * 骰子结果界面
	 * 
	 */	
	public class RollPane extends Component
	{
		private var mc:MC_RollPane = new MC_RollPane();
		
		public function RollPane(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			
			this.addChild(mc);
		}
		
		/**
		 * Sets the size of the component.
		 * @param w The width of the component.
		 * @param h The height of the component.
		 */
		override public function setSize(w:Number, h:Number):void
		{
			super.setSize(w, h);
			
			//居中
			mc.x = (width - mc.width)/2;
			mc.y = (height - mc.height)/2;
		}
		
		/**
		 * 
		 * @param numArr [1,2,3]
		 * 
		 */		
		public function roll(numArr:Array):void
		{
			for(var i:int = 0;i<numArr.length;i++)
			{
				mc["mc_" + i].gotoAndStop(numArr[i]);
			}
		}
	}
}