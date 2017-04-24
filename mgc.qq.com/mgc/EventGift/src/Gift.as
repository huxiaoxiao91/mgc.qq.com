package
{
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.CurveModifiers;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	
	public class Gift extends Sprite
	{
		/**
		 * 存放路径的数组 
		 */
		public var path:Array;
		
		/**
		 * 动画类型，1 送单个礼物效果， 0 送n个礼物时效果
		 */
		public var type:int = 1;
		
		private var _effectid:int = 1;
		
		/**
		 * true 自己送的礼物
		 */
		public var isSelf:Boolean = false;
		
		private var mc:MovieClip;
		
		public function Gift()
		{
			
		}

		/**
		 * 图片样式 1-4为单个礼物 0为n个礼物的图片样式
		 */
		public function get effectid():int
		{
			return _effectid;
		}

		/**
		 * @private
		 */
		public function set effectid(value:int):void
		{
			_effectid = value;
			
			var c:Class = getDefinitionByName("MC_" + effectid.toString() + (isSelf?"_2":"")) as Class;
			mc = new c();
			addChild(mc);
		}
		
		public function updata():void
		{
			
		}
		
		public function start():void
		{
			CurveModifiers.init();
			
			/**
			 * 底部坐标 
			 */
			var bottom:Number = stage.stageHeight;
			this.y = bottom;
			this.x = 50;
			
			//随机坐标
			var point1:Point;
			var point2:Point;
			if(Math.random() < 0.5)
			{
				point1 = new Point(Math.random()* 30,bottom - bottom/3);
				point2 = new Point(Math.random()* 30 + 70,bottom - bottom/2);
			}
			else
			{
				point1 = new Point(Math.random()* 30 + 70,bottom - bottom/3);
				point2 = new Point(Math.random()* 30,bottom - bottom/2);
			}
	
			//圣诞老人播放吹雪动画
			if(type == 0)
			{
				//this.y = 0;//新年活动圣诞老人位置
				//this.x = 15;//新年活动圣诞老人位置
				this.y = bottom/2-mc.height/2;//swf高度/2-动画高度/2，15为js视频区中event-gift的top和bottom的差值/2
				this.x = stage.stageWidth/2-mc.width/2;//swf宽度/2-动画宽度/2
				//Tweener.addTween(this, {alpha:0,delay:2.5,time:0.4,transition:"linear"});
				Tweener.addTween(this, {time:3,onComplete:complete});
			}
			else
			{
				Tweener.addTween(this, {x:50, y:50, _bezier:[{x:point1.x, y:point1.y}, {x:point2.x, y:point2.y}], time:3, transition:"linear",onComplete:complete});
				this.scaleX = this.scaleY = 0.8;
				Tweener.addTween(this, {alpha:0,delay:2.5,time:0.4,transition:"linear"});
				Tweener.addTween(this, {scaleX:1,scaleY:1,time:3,transition:"linear"});
			}
		}
		
		private function complete():void
		{
			this.parent.removeChild(this);
		}
		
		private function play():void
		{
			mc.mc.play();
		}
	}
}