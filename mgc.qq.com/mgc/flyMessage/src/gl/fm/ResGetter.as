package gl.fm {

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	import gl.fm.view.FlyItemBackground;
	
	import org.bytearray.gif.events.GIFPlayerEvent;
	import org.bytearray.gif.player.GIFPlayer;

	public class ResGetter {
		public function ResGetter() {
		}

		static private var dataMap:Dictionary       = new Dictionary();

		public static const ICON_DEFEND:String      = "icon_defend_";
		public static const ICON_WEALTH:String      = "icon_wealth_";
		public static const ICON_VIP:String         = "icon_vip_";
		public static const ICON_ROCKET:String      = "icon_rocket";

		static public function getChatIcon(url:String):DisplayObject {
			if (url.lastIndexOf(".gif") == url.length - 4 || url.indexOf(".gif?") != -1) {
				return getGifPlayer(url);
			} else {
				return getPNG(url);
			}
		}

		static private var gifDecoderMap:Dictionary = new Dictionary();

		static public function getGifPlayer(url:String):GIFPlayer {
			var gifPlayer:GIFPlayer = new GIFPlayer(true, true);
			if (gifDecoderMap[url] == null) {
				gifPlayer.load(new URLRequest(url));
				gifPlayer.addEventListener(GIFPlayerEvent.COMPLETE, onGifPlayerDecodeComplete);
			} else {
				gifPlayer.readDecoder(gifDecoderMap[url]);
			}
			return gifPlayer;
		}

		static private function onGifPlayerDecodeComplete(event:Event):void {
			var gifPlayer:GIFPlayer = event.target as GIFPlayer;
			if (gifPlayer != null) {
				var kvObj:Object = gifPlayer.getGifDecoderToSave();
				gifDecoderMap[kvObj["url"]] = kvObj["decoder"];
			}
		}

		private static var pngMap:Dictionary        = new Dictionary();

		static public function getPNG(url:String):DisplayObject {
			if (pngMap[url] == null) {
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadPNGComplete);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadPNGIOError);
				loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onLoadPNGIOError);
				loader.load(new URLRequest(url));
				pngMap[loader] = url;
				return loader;
			} else {
				return new Bitmap(pngMap[url]);
			}
		}

		static public function onLoadPNGComplete(event:Event):void {
			var loaderInfo:LoaderInfo = event.currentTarget as LoaderInfo;
			var url:String            = pngMap[loaderInfo.loader];
			if (url != null) {
				pngMap[url] = (loaderInfo.content as Bitmap).bitmapData;
			}
		}

		static public function onLoadPNGIOError(event:Event):void {
			trace(event.target);
		}

		static public function getIconBitmapData(iconURL:String):BitmapData {
			if (dataMap[iconURL] != null) {
				return dataMap[iconURL] as BitmapData;
			} else {
				var bitmapData:BitmapData;

				//rocket
				if (iconURL == ICON_ROCKET) {
					bitmapData = new Icon_Rocket();
				}
				//vip
				else if (iconURL == ICON_VIP + 1) {
					bitmapData = new Icon_VIP_1();
				} else if (iconURL == ICON_VIP + 2) {
					bitmapData = new Icon_VIP_2();
				} else if (iconURL == ICON_VIP + 3) {
					bitmapData = new Icon_VIP_3();
				} else if (iconURL == ICON_VIP + 4) {
					bitmapData = new Icon_VIP_4();
				} else if (iconURL == ICON_VIP + 5) {
					bitmapData = new Icon_VIP_5();
				}
				//wealth
				else if (iconURL == ICON_WEALTH + 1) {
					bitmapData = new Icon_Wealth_1();
				} else if (iconURL == ICON_WEALTH + 2) {
					bitmapData = new Icon_Wealth_2();
				} else if (iconURL == ICON_WEALTH + 3) {
					bitmapData = new Icon_Wealth_3();
				} else if (iconURL == ICON_WEALTH + 4) {
					bitmapData = new Icon_Wealth_4();
				} else if (iconURL == ICON_WEALTH + 5) {
					bitmapData = new Icon_Wealth_5();
				} else if (iconURL == ICON_WEALTH + 6) {
					bitmapData = new Icon_Wealth_6();
				} else if (iconURL == ICON_WEALTH + 7) {
					bitmapData = new Icon_Wealth_7();
				} else if (iconURL == ICON_WEALTH + 8) {
					bitmapData = new Icon_Wealth_8();
				} else if (iconURL == ICON_WEALTH + 9) {
					bitmapData = new Icon_Wealth_9();
				}
				//defend
				else if (iconURL == ICON_DEFEND + 10) {
					bitmapData = new Icon_Defend_10();
				} else if (iconURL == ICON_DEFEND + 20) {
					bitmapData = new Icon_Defend_20();
				} else if (iconURL == ICON_DEFEND + 50) {
					bitmapData = new Icon_Defend_50();
				} else if (iconURL == ICON_DEFEND + 100) {
					bitmapData = new Icon_Defend_100();
				} else if (iconURL == ICON_DEFEND + 200) {
					bitmapData = new Icon_Defend_200();
				} else if (iconURL == ICON_DEFEND + 250) {
					bitmapData = new Icon_Defend_250();
				} else if (iconURL == ICON_DEFEND + 300) {
					bitmapData = new Icon_Defend_300();
				} else if (iconURL == ICON_DEFEND + 400) {
					bitmapData = new Icon_Defend_400();
				} else if (iconURL == ICON_DEFEND + 500) {
					bitmapData = new Icon_Defend_500();
				}

				dataMap[iconURL] = bitmapData;
				return bitmapData;
			}
			return null;
		}

		static private var bgBMDMap:Dictionary      = new Dictionary();

		static private function getBGBitmapData(bgURL:String):BitmapData {
			if (bgBMDMap[bgURL] != null) {
				return bgBMDMap[bgURL] as BitmapData;
			} else {
				var bitmapData:BitmapData;
				switch (bgURL) {
					case "lk_l":
						bitmapData = new FlyBg_LK_L();
						break;
					case "lk_c":
						bitmapData = new FlyBg_LK_C();
						break;
					case "lk_r":
						bitmapData = new FlyBg_LK_R();
						break;
					
					case "qz_l":
						bitmapData = new FlyBg_QZ_L();
						break;
					case "qz_c":
						bitmapData = new FlyBg_QZ_C();
						break;
					case "qz_r":
						bitmapData = new FlyBg_QZ_R();
						break;

					case "hj_l":
						bitmapData = new FlyBg_HJ_L();
						break;
					case "hj_c":
						bitmapData = new FlyBg_HJ_C();
						break;
					case "hj_r":
						bitmapData = new FlyBg_HJ_R();
						break;

					case "vip0_l":
						bitmapData = new FlyBg_VIP0_L();
						break;
					case "vip0_c":
						bitmapData = new FlyBg_VIP0_C();
						break;
					case "vip0_r":
						bitmapData = new FlyBg_VIP0_R();
						break;

					case "vip1_l":
						bitmapData = new FlyBg_VIP1_L();
						break;
					case "vip1_c":
						bitmapData = new FlyBg_VIP1_C();
						break;
					case "vip1_r":
						bitmapData = new FlyBg_VIP1_R();
						break;

					case "vip2_l":
						bitmapData = new FlyBg_VIP2_L();
						break;
					case "vip2_c":
						bitmapData = new FlyBg_VIP2_C();
						break;
					case "vip2_r":
						bitmapData = new FlyBg_VIP2_R();
						break;

					case "vip3_l":
						bitmapData = new FlyBg_VIP3_L();
						break;
					case "vip3_c":
						bitmapData = new FlyBg_VIP3_C();
						break;
					case "vip3_r":
						bitmapData = new FlyBg_VIP3_R();
						break;

					case "vip4_l":
						bitmapData = new FlyBg_VIP4_L();
						break;
					case "vip4_c":
						bitmapData = new FlyBg_VIP4_C();
						break;
					case "vip4_r":
						bitmapData = new FlyBg_VIP4_R();
						break;

					case "vip5_l":
						bitmapData = new FlyBg_VIP5_L();
						break;
					case "vip5_c":
						bitmapData = new FlyBg_VIP5_C();
						break;
					case "vip5_r":
						bitmapData = new FlyBg_VIP5_R();
						break;

					default:
						bitmapData = new BitmapData(2, 2);
						break;
				}
				bgBMDMap[bgURL] = bitmapData;
				return bitmapData;
			}
		}

		static public function resetFlyItemBG(backgroud:FlyItemBackground, isTakeSeat:Boolean, isRocket:Boolean, vipLv:int, lastKing:Boolean = false):void {
			if (isTakeSeat) {
				backgroud.init(getBGBitmapData("qz_l"), getBGBitmapData("qz_c"), getBGBitmapData("qz_r"));
			} else if (lastKing){
				//补刀王飞屏背景
				backgroud.init(getBGBitmapData("lk_l"), getBGBitmapData("lk_c"), getBGBitmapData("lk_r"));
			} else if (isRocket) {
//				backgroud = new FlyBg_HJ();
				backgroud.init(getBGBitmapData("hj_l"), getBGBitmapData("hj_c"), getBGBitmapData("hj_r"));
			} else if (vipLv == 0) {
//				backgroud = new FlyBg_VIP0();
				backgroud.init(getBGBitmapData("vip0_l"), getBGBitmapData("vip0_c"), getBGBitmapData("vip0_r"));
			} else if (vipLv == 1) {
//				backgroud = new FlyBg_VIP1();
				backgroud.init(getBGBitmapData("vip1_l"), getBGBitmapData("vip1_c"), getBGBitmapData("vip1_r"));
			} else if (vipLv == 2) {
//				backgroud = new FlyBg_VIP2();
				backgroud.init(getBGBitmapData("vip2_l"), getBGBitmapData("vip2_c"), getBGBitmapData("vip2_r"));
			} else if (vipLv == 3) {
//				backgroud = new FlyBg_VIP3();
				backgroud.init(getBGBitmapData("vip3_l"), getBGBitmapData("vip3_c"), getBGBitmapData("vip3_r"));
			} else if (vipLv == 4) {
//				backgroud = new FlyBg_VIP4();
				backgroud.init(getBGBitmapData("vip4_l"), getBGBitmapData("vip4_c"), getBGBitmapData("vip4_r"));
			} else if (vipLv == 5) {
//				backgroud = new FlyBg_VIP5();
				backgroud.init(getBGBitmapData("vip5_l"), getBGBitmapData("vip5_c"), getBGBitmapData("vip5_r"));
			}
		}

		static private function get FONT_NAME():String {
			return "Arial";
		}
		static private var textFormatMap:Dictionary = new Dictionary();
		private static const TF_QZ:String           = "TF_QZ";
		private static const TF_VIP:String          = "TF_VIP_";
		private static const TF_COM:String          = "TF_COM";
		private static const TF_LASTKING:String          = "TF_LASTKING";

		static public function getTextFormat(isTakeSeat:Boolean, vipLv:int, isLastKing: Boolean = false):TextFormat {
			if (isTakeSeat) {
				if (textFormatMap[TF_QZ] == null) {
					var tfQZ:TextFormat = new TextFormat();
					tfQZ.font = FONT_NAME;
					tfQZ.size = 15;
					tfQZ.color = 0xca1902;
					tfQZ.bold = true;
					textFormatMap[TF_QZ] = tfQZ;
				}
				return textFormatMap[TF_QZ];
			}else if (isLastKing) {
				if (textFormatMap[TF_LASTKING] == null) {
					var tfLASTKING:TextFormat = new TextFormat();
					tfLASTKING.font = FONT_NAME;
					tfLASTKING.size = 15;
					tfLASTKING.color = 0xfffc02;
					tfLASTKING.bold = true;
					textFormatMap[TF_LASTKING] = tfLASTKING;
				}
				return textFormatMap[TF_LASTKING];
			} else if (vipLv >= 0 && vipLv <= 5) {
				if (textFormatMap[TF_VIP + vipLv] == null) {
					var tfVIP:TextFormat = new TextFormat();
					tfVIP.font = FONT_NAME;
					tfVIP.size = 15;
					tfVIP.bold = true;
					switch (vipLv) {
						case 0:  {
							tfVIP.color = 0xffffff;
							break;
						}
						case 1:  {
							tfVIP.color = 0x1a6b00;
							break;
						}
						case 2:  {
							tfVIP.color = 0x6772;
							break;
						}
						case 3:  {
							tfVIP.color = 0xa57af;
							break;
						}
						case 4:  {
							tfVIP.color = 0x8f00b1;
							break;
						}
						case 5:  {
							tfVIP.color = 0xae5600;
							break;
						}
					}
					textFormatMap[TF_VIP + vipLv] = tfVIP;
				}
				return textFormatMap[TF_VIP + vipLv];
			}
			if (textFormatMap[TF_COM] == null) {
				var tfCom:TextFormat = new TextFormat();
				tfCom.font = FONT_NAME;
				tfCom.size = 15;
				tfCom.bold = true;
				tfCom.color = 0xfff;
				textFormatMap[TF_COM] = tfCom;
			}
			return textFormatMap[TF_COM];
		}

		static public function getTextFilter():Array {
			return null; //[new DropShadowFilter(1, 45, 0, 1, 0, 0)]; //, new DropShadowFilter(1, 135, 0, 1, 0, 0)];
		}

		static private var nodeTextList:Array       = [];
		static public function getNodeText():TextField {
			if (nodeTextList.length > 0) {
				return nodeTextList.pop() as TextField;
			} else {
				return new TextField();
			}
		}
		static public function removeNodeText(tf:TextField):void {
			if (nodeTextList.indexOf(tf) == -1) {
				nodeTextList.push(tf);
				tf.text = "";
			}
		}
	}
}
