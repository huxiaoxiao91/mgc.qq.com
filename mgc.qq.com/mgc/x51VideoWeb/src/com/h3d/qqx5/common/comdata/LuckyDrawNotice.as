package com.h3d.qqx5.common.comdata {

	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.modules.surprise_box.share.RewardBasicItem;
	
	import flash.utils.getQualifiedClassName;

	/**
	 * 抽奖中奖通知
	 * @author gaolei
	 *
	 */
	public class LuckyDrawNotice extends ProtoBufSerializable {
		public function LuckyDrawNotice() {
			super();

			registerField("nick", "", Descriptor.TypeString, 1);
			registerField("reward", getQualifiedClassName(RewardBasicItem), Descriptor.Compound, 2);
		}

		/**
		 * 中奖玩家名称
		 */
		public var nick:String    = "";
		/**
		 * 奖品信息信息
		 */
		public var reward:RewardBasicItem = new RewardBasicItem();
	}
}
