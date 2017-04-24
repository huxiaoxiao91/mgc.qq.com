package view.components
{
	import com.bit101.components.List;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	import model.DataProxy;
	
	public class NumberPane extends List
	{
		
		public function NumberPane(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0)
		{
			super(parent, xpos, ypos);
			
			initUI();
		}
		
		public function initUI():void
		{
			this.visible = false;
			autoHideScrollBar = true;
			listItemClass = NumberCell;
			setSize(100,120);
		}
		
		
		override public function setSize(w:Number, h:Number):void
		{
			super.setSize(w,h);
			this.graphics.clear();

			if (DataProxy.isCaveolaeBo) {
				if (DataProxy.isSkinOpened) {
					if(DataProxy.skinId == DataProxy.SKIN_ID_2_SEA){
						this.graphics.beginFill(DataProxy.SKIN_2_NUM_BG_COLOR);
					}else{
						this.graphics.beginFill(DataProxy.skinTextBgColor);
					}
				} else {
					this.graphics.beginFill(0x613309);
				}
			} else {
				this.graphics.beginFill(0x43228E);
			}
			
			this.graphics.drawRoundRect(0,0,w,h,5);
		}
		
		/**
		 * Draws the visual ui of the component.
		 */
		public override function draw() : void
		{
			super.draw();
			
			//背景在最下
//			addChildAt(new MC_NumberPane_1(),0);
		}
		
		
	}
}