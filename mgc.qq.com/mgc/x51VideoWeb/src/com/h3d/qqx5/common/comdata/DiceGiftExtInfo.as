package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	public class DiceGiftExtInfo extends ProtoBufSerializable
	{
		public function DiceGiftExtInfo()
		{
			registerField("m_level", "", Descriptor.Int32, 1);
			registerField("m_dice_val_1", "", Descriptor.Int32, 2);
			registerField("m_dice_val_2", "", Descriptor.Int32, 3);
			registerField("m_dice_val_3", "", Descriptor.Int32, 4);
		}
		
		public var m_level : int;
		public var m_dice_val_1 : int;
		public var m_dice_val_2 : int;
		public var m_dice_val_3 : int;
	}
}