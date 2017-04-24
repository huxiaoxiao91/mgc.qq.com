package 
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import gs.TweenLite;
	import flash.events.Event;
	import flash.system.Security;

	public class DreamBox extends MovieClip
	{

		/*
		      * 宝箱状态
		      * 0:隐藏
		      * 1:倒计时
		      * 2:可领取
		      * 3:已领取
		      */
		public var status:int = 0;
		
		/*
     	 * 宝箱数量
     	 */
    	private var count:int = 0;
		
		/*
     	* 倒计时时间 秒
     	*/
		private var leftTime:int = 0;

		public function DreamBox()
		{
			Security.allowDomain("*");
			
			ExternalInterface.addCallback("setData",setData);
			ExternalInterface.addCallback("setTime",setTime);
			ExternalInterface.addCallback("setStatus",setStatus);
			ExternalInterface.addCallback("setCount",setCount);
			ExternalInterface.addCallback("setRole",setRole);
			
			this.addEventListener(MouseEvent.CLICK,onClick);
			this.addEventListener(MouseEvent.ROLL_OVER,onOver);
			this.addEventListener(MouseEvent.ROLL_OUT,onOut);
			
			hideAll();
			
			text_count.mouseEnabled = false;
			
			setRole(ExternalInterface.call("mgc.tools.isNewRole"));
			ExternalInterface.call("DreamBox.initComplete");
		}


		public function setData(data:Object):void
		{

			
			//已领取
			if (data.info.has_grabbed)
			{
				this.setStatus(3);
				//return;
			}

			//可领取
			else if (data.info.count_down <= 0)
			{
				this.setStatus(2);
				//return;
			}
			
			//倒计时
			else{
				this.setStatus(1);
			}
			
			
			setCount(data.box_count);
			setReward(data.info.total_money);

		}

		//设置宝箱状态
		private function setStatus(status)
		{
			this.status = status;
			//dispatchEvent(new Event("DreamBox.status"));

			this.alpha = 1;
			
			TweenLite.killTweensOf(this);

			switch (status)
			{
					//隐藏
				case 0 :
					TweenLite.to(this,1,{alpha:0,onComplete:function(){
						 hideAll();
					}});
					break;

					//倒计时
				case 1 :
					hideAll();
					box_1.visible = true;
					
					//数量小于1时出特效
					if(count < 1)
					{
						box_1.alpha = 0;
						box_1.scaleX = box_1.scaleY = 0.1;
						TweenLite.to(box_1,1,{alpha:1,scaleX:1,scaleY:1,onComplete:function(){
						text_time.visible = true;
						text_reward.visible = true;
						text_count.visible = true;
					
						mc_reward.visible = true;
						mc_tip.visible = true;
						}});
					}
					else{
						text_time.visible = true;
						text_reward.visible = true;
						text_count.visible = true;
					
						mc_reward.visible = true;
						mc_tip.visible = true;
						
					}
					
					
					
					
					break;

					//可领取
				case 2 :
					hideAll();
					box_2.visible = true;
					text_reward.visible = true;
					text_tip.text = "可领取";
					text_tip.visible = true;
					text_count.visible = true;
					
					mc_reward.visible = true;
					mc_tip.visible = true;
					
					mc_hot.visible = true;
					break;

					//已领取
				case 3 :
					hideAll();
					box_3.visible = true;
					//text_tip.text = "已领取";
					//text_tip.visible = true;
					text_count.visible = true;
					
					//mc_tip.visible = true;
					
					break;
			}
		}

		private function hideAll():void
		{
			for (var i:int = 0; i<this.numChildren; i++)
			{
				this.getChildAt(i).visible = false;
			}
			
		}
		
		public function setTime(str:String):void
		{
			text_time.text = str;
		}
		
		//设置点券数量
    	public function setReward(_count){
			if(_count >= 100000)
			{
				text_reward.text = "99999+";
			}
			else{
				text_reward.text = _count;
			}
    	}
		
		//设置宝箱数量
    	public function setCount(_count){
			
			count = _count;
			
			if(count >= 100)
			{
				text_count.text = "x99+";
			}
			else if(count <= 1)
			{
				text_count.text = "";
			}
			else{
				text_count.text = "x" + count;
			}
    	}
		
		//设置新老角色
		public function setRole(b:Boolean){
			if(b)
			{
				mc_reward.alpha = 0;
				text_reward.alpha = 0;
			}
			else{
				mc_reward.alpha = 1;
				text_reward.alpha = 1;
			}
			
			//区分炫舞2点劵图标
			if(ExternalInterface.call("MgcAPI.SNSBrowser.IsX52"))
			{
				mc_reward.gotoAndStop(2);
			}
			else
			{
				mc_reward.gotoAndStop(1);
			}
		}
		
		

		private function onClick(e:MouseEvent):void
		{
			if(status == 2)
        	{
				ExternalInterface.call("DreamBox.grab");
			}
		}
		
		private function onOver(e:MouseEvent):void
		{
			ExternalInterface.call("DreamBox.showTip",true,e.stageY);
		}
		
		private function onOut(e:MouseEvent):void
		{
			ExternalInterface.call("DreamBox.showTip",false,e.stageY);
		}

	}

}