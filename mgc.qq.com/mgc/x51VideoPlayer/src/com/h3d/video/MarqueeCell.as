package com.h3d.video
{
	import com.bit101.components.Component;
	import com.bit101.components.HBox;
	import com.bit101.components.Image;
	import com.bit101.components.Label;
	import com.junkbyte.console.Cc;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.getDefinitionByName;
	import flash.utils.setTimeout;
	
	import gs.TweenLite;
	
	public class MarqueeCell extends HBox
	{
		private var icon_2:ICON_2 = new ICON_2();
		private var icon_3:ICON_3 = new ICON_3();
		private var icon_4:ICON_4 = new ICON_4();
		private var icon_5:ICON_5 = new ICON_5();
		private var icon_6:ICON_6 = new ICON_6();
		
		public function MarqueeCell(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			
			spacing = 0;
		}
		
		public var startTime:int;
		public var startX:int;
		public function setText(text:String):void
		{
			removeAll();
			
			var arr:Array = text.split("#");
			
			for(var i:int = 0;i<arr.length;i++)
			{
				var str:String = arr[i];
				if(str.indexOf("IMG") != -1)
				{
					//IMG?type=room_level&a=1&b=2
					var arr1:Array = str.split("?");
					var arr2:Array = arr1[1].split("&");
					var arr3:Array = arr2[0].split("=");
					var arr4:Array = arr2[1].split("=");
					var type:String = arr3[1];
					var a:String = arr4[1];
					
					//var icon:MovieClip;
					var img:Image;
					
					switch(type)
					{
						//贵族
						case "icon_honor":
							//icon = new ICON_2();
							icon_2.gotoAndStop(a);
							//icon.y = 5;
							//addChild(icon_2);
							img = new Image(this);
							img.setSize(icon_2.width,icon_2.height);
							img.y = 3;
							img.source = icon_2;
							break;
						
						//守护
						case "icon_lv":
							//icon = new ICON_4();
							if(a == "10"){
								a = "1";
							}
							else if(a == "20"){
								a = "2";
							}
							else if(a == "50"){
								a = "3";
							}
							else if(a == "100"){
								a = "4";
							}
							else if(a == "200"){
								a = "5";
							}
							else if(a == "300"){
								a = "6";
							}
							else if(a == "400"){
								a = "7";
							}
							else if(a == "500"){
								a = "8";
							}
							
							icon_4.gotoAndStop(a);
							img = new Image(this);
							img.y = 3;
							img.setSize(icon_4.width,icon_4.height);
							img.source = icon_4;
							//addChild(icon_4);
							break;
						
						//主播等级
						case "anchor_level":
							var arr5:Array = arr2[2].split("=");
							//icon = new ICON_6();
							icon_6.gotoAndStop(a);
							icon_6.text.text = arr5[1];
							//addChild(icon_6);
							img = new Image(this);
							img.setSize(icon_6.width,icon_6.height);
							img.source = icon_6;
							break;
						
						//名次变化
						case "rank_icon":
							//icon = new ICON_3();
							icon_3.gotoAndStop(a);
							icon_3.y = 5;
							//addChild(icon_3);
							img = new Image(this);
							img.setSize(icon_3.width,icon_3.height);
							img.source = icon_3;
							break;
						
						//房间等级
						case "room_level":
							var arr6:Array = arr2[2].split("=");
							//icon = new ICON_5();
							icon_5.gotoAndStop(a);
							icon_5.text.text = arr6[1];
							//addChild(icon_5);
							img = new Image(this);
							img.setSize(icon_5.width,icon_5.height);
							img.source = icon_5;
							break;
						
						//礼物
						case "gift_icon":
							//var img:Image = new Image(this);
							//img.setSize(30,30);
							//var c:Class = getDefinitionByName("gift_" + a) as Class;
							var bd:BitmapData = MarqueePane.getGift("gift_" + a);//new c();
							var bitmap:Bitmap = new Bitmap(bd);
							//bitmap.width = 30;
							//bitmap.height = 30;
							//addChild(bitmap);
							img = new Image(this);
							img.setSize(30,30);
							img.source = bitmap;
							break;
					}
				}
				else if(str.indexOf("任性土豪") != -1){//周星升级跑马灯：后面部分显示不同颜色字体
					var sg:TextFormat = new TextFormat("微软雅黑",19,0xFFC560); 
					sg.align = TextFormatAlign.LEFT;
					
					var label_sg:Label = new Label(this);
					label_sg.text = str;
					label_sg.textFormat = sg;
					
					label_sg.textField.filters = [new GlowFilter(0x360000, 1.0, 2.0, 2.0, 10, 1, false, false)]; 
				}else
				{
					var tf:TextFormat = new TextFormat("微软雅黑",19,0xFFFFFF); 
					tf.align = TextFormatAlign.LEFT;
					
					var label:Label = new Label(this);
					label.text = str;
					label.textFormat = tf;
					
					label.textField.filters = [new GlowFilter(0x870069, 1.0, 2.0, 2.0, 10, 1, false, false)];  
				}
			}	
			
			//Cc.error("走马灯宽度: ",this.width);
			//setTimeout(refresh,100);
			//TweenLite.killTweensOf(this);
			//TweenLite.to(this,0.1,{onComplete:refresh});
		}
		
		private function removeAll():void
		{
			while(numChildren > 0)
			{
				removeChildAt(0);
			}
		}
		
		private function refresh():void
		{
			var xpos:Number = 0;
			
			for(var i:int = 0;i<this.numChildren;i++)
			{
				var displayObject:DisplayObject = this.getChildAt(i);
				displayObject.x = xpos;
				xpos += displayObject.width;
				
				displayObject.y = 0;
			}

			this.setSize(xpos,50);
		}
	}
}