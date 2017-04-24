package gl.fm.data {

	/**
	 * 火箭数据
	 * @author gaolei
	 *
	 */
	public class RocketData {

		public function RocketData(data:Object):void {
			if (data != null) {
				if (data.hasOwnProperty("anchor_name")) {
					anchor_name = data["anchor_name"];
				}
				if (data.hasOwnProperty("player_name")) {
					player_name = data["player_name"];
				}
				if (data.hasOwnProperty("player_zone")) {
					player_zone = data["player_zone"];
				}
				if (data.hasOwnProperty("rocket_cnt")) {
					rocket_cnt = data["rocket_cnt"];
				}
				if (data.hasOwnProperty("vip_level")) {
					vip_level = data["vip_level"];
				}
				if (data.hasOwnProperty("guard_level")) {
					guard_level = data["guard_level"];
				}
				if (data.hasOwnProperty("wealth_level")) {
					wealth_level = data["wealth_level"];
				}
				if (data.hasOwnProperty("room_id")) {
					room_id = data["room_id"];
				}
				if (data.hasOwnProperty("is_nest")) {
					is_nest = data["is_nest"];
				}
			}
		}

		public var anchor_name:String = "";
		public var player_name:String = "";
		public var player_zone:String = "";
		public var rocket_cnt:int;
		public var vip_level:int;
		public var guard_level:int;
		public var wealth_level:int;
		public var room_id:int;
		public var is_nest:Boolean;
	}
}
