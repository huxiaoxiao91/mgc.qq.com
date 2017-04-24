package gl.fm.data {

	/**
	 * 飞屏数据
	 * @author gaolei
	 *
	 */
	public class FlyScreenMsgData {
		public function FlyScreenMsgData(data:Object, isDef:Boolean, num:int):void {
			this.isDef = isDef;
			this.num = num;
			if (data != null) {
				//添加补刀王数据
				if(data.hasOwnProperty("lastKing")){
					lastKing = data["lastKing"];
				}
				if (data.hasOwnProperty("senderdefend")) {
					defend = data["senderdefend"];
				}
				if (data.hasOwnProperty("viplevel")) {
					vipLevel = data["viplevel"];
				}
				if (data.hasOwnProperty("wealth_level")) {
					wealthLevel = data["wealth_level"];
				}
				if (data.hasOwnProperty("isTakeVip")) {
					isTakeVip = data["isTakeVip"];
				}
				if (data.hasOwnProperty("isSelf")) {
					selfState = data["isSelf"];
				}
				if (data.hasOwnProperty("MsgStr")) {
					msgStr = data["MsgStr"];
				}
				if (data.hasOwnProperty("senderName")) {
					senderName = data["senderName"];
				}
				if (data.hasOwnProperty("chatnodes")) {
					chatNodes = data["chatnodes"];
				}
			}
		}

		public var lastKing:String;
		public var isDef:Boolean;
		public var num:int;
		public var defend:int;
		public var vipLevel:int;
		public var wealthLevel:int;
		public var isTakeVip:Boolean;
		public var selfState:int;
		public var msgStr:String;
		public var senderName:String;
		public var chatNodes:Array = [];

		public function get isSelf():Boolean {
			return selfState == 3;
		}

		public function get isOther():Boolean {
			return selfState == 4;
		}
	}
}
