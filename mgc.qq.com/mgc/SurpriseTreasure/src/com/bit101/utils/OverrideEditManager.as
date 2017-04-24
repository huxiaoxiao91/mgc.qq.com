package com.bit101.utils
{
	import com.junkbyte.console.Cc;
	
	import flashx.textLayout.edit.EditManager;
	import flashx.textLayout.edit.SelectionState;
	import flashx.undo.IUndoManager;
	
	public class OverrideEditManager extends EditManager
	{
		public function OverrideEditManager(undoManager:IUndoManager=null)
		{
			super(undoManager);
		}
		
		override public function insertText(text:String, origOperationState:SelectionState=null):void
		{
			
			//Cc.log("飞屏输入文字" + text);
			super.insertText(text,origOperationState);
			if(hasSelection())
				updateAllControllers();
		}
	}
	
	
}