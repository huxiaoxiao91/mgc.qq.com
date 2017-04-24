package com.h3d.qqx5.videoclient.data
{
	//【货币类型改动】现在服务器只会下发货币0了。不用货币类型2了。所有货币类型2的地方改用货币类型0  
	
	public class ChangeCostType
	{

		public static function ChangeServerCostType(costtype:int):int
		{
			if(costtype == CurrencyCostType.VVPT_XuanBei)
				return  CurrencyCostType.VVPT_XuanDou;
			else
				return costtype;
		}
		
		public static function ChangeJSCostType(costtype:int):int
		{
			if(costtype == CurrencyCostType.VVPT_XuanDou)
				return  CurrencyCostType.VVPT_XuanBei;
			else
				return costtype;
		}
	}
}