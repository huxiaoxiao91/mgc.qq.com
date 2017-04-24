package com.h3d.qqx5.videoclient.interfaces
{
	import com.h3d.qqx5.common.event.CEventCommonActivityInfoBegin;
	import com.h3d.qqx5.common.event.CEventCommonActivityInfoEnd;
	import com.h3d.qqx5.common.event.CEventCommonActivityInfoRefresh;
	import com.h3d.qqx5.common.event.CEventCommonActivityPlayerRank;
	import com.h3d.qqx5.common.event.CEventRefreshCommonActivityData;
	import com.h3d.qqx5.common.event.CEventRefreshAnchorPKRank;
	import com.h3d.qqx5.common.event.CEventNotifyPkMatchInfo;
	import com.h3d.qqx5.common.event.CEventRefreshPkGift;
	import com.h3d.qqx5.common.event.CEventRefreshPkProgressInfo;
	import com.h3d.qqx5.common.event.CEventRefreshPkValue;
	import com.h3d.qqx5.common.event.CEventRefreshRocketBuff;
	import com.h3d.qqx5.common.event.CEventRefreshPlayerContributePKRank;
	import com.h3d.qqx5.modules.anchor_nest.share.AnchorNestAdvSupportLogInfo;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.data.AnchorNestPopularityInfo;
	import com.h3d.qqx5.videoclient.data.AnchorNestSupportInfo;
	import com.h3d.qqx5.videoclient.data.ClientAnchorData;
	
	import flash.utils.Dictionary;

	/**
	 * @author liuchui
	 */
	public interface IUIAnchorNest
	{
		//捧场界面打开回调
		function OnLoadSupportInfo( result:int , info:AnchorNestSupportInfo, task_info:Array , is_anchor_publish_task:Boolean,is_inGuild:Boolean ):void;
		//普通捧场回调
		function OnSendNormalSupport( result:int,  add_popularity:int, nest_star:String ):void;
		//高级捧场触发特效及文字提示
		function NotifyAdvancedSupportSuccess(info:AnchorNestAdvSupportLogInfo,logs:Array, add_popularity:int, nest_star :String) :void;
//		获得小窝的人气和排名及差值回调
//		function void OnLoadAnchorNestSimpleInfo( int result, const AnchorNestPopularityInfo& info) = 0;
//		//获得或刷新小窝中明星值排行榜回调
//		function void OnLoadAnchorNestStarRank( int result, const AnchorNestStarRank& rank) = 0;
//		//刷新小窝人气、排名及差值(变化时主动刷新)
		function RefreshAnchorNestPopularityInfo( info:AnchorNestPopularityInfo ) :void;
		//领取小窝任务回调
		function OnTakeAnchorNestTaskRes( result:int,  nest_tasks:Array) :void;
//		//获取小窝助手列表
//		function void OnLoadNestAssistantList(VideoResultType type, int roomID, const std::vector<AnchorNestAssistantData>& assistants) = 0;
//		function void OnInitNestAssistantList(int roomID, const std::vector<AnchorNestAssistantData>& assistants) = 0;
//		function void OnAddNestAssistant(VideoResultType type, int roomID, AnchorNestAssistantData& assistant) = 0;
//		//删除小窝助手
//		function void OnDelNestAssistant(VideoResultType type, int roomID, VideoInt64 player_id) = 0;
//		function void OnNestAssistantChange(const std::string name, const std::string zone_name, bool is_add) = 0;
		//收到宝箱状态回调
		function  OnTreasureBoxStatus(stat:int) :void;
		//领取小窝宝箱错误码返回
		function  OnTakeNestTreasureBoxErrRes( res:int):void;
		//查询人气宝箱奖励
		function OnQueryNestTreasureBox(rewards:Array ):void;
		//查询团务奖励
		function OnQueryNestTaskReward(rewards:Array ):void;
		//刷新主播信息(星耀、人气、关注数、印象等)
		function  RefreshAnchorData( anchor_data:ClientAnchorData) :void;
		function  OnNotifyNestTaskFinished( nest_tasks:Array) :void;
		function  OnAddNestPopularity(add_value:int,is_free_pop_limit:Boolean):void;
		
		//收到小窝成长信息回调
		function OnGetNestGrowUpRes( credits:int, credits_level:int, rank:int, credits_distance_of_prev_or_1000:int,
			 rank_need_promote:int, credits_need_promote:int, honor_num_need_promote:int, is_get_guard_wage:Boolean,is_guard:Boolean,
			nest_credits_level_info_vec_ui:Array, guard_wage_info:Array) :void;
		//增加小窝人气、小窝积分结果回调
		function OnAddNestPopularityCreditsRes( free_popularity:Boolean, is_need_hint:Boolean, add_popularity:int, add_credits:int):void;
		//守护领取守护工资结果回调
		function OnGetGuardWageRes(credits:int, credits_level:int, rank:int, credits_distance_of_prev_or_1000:int,
								   rank_need_promote:int, credits_need_promote:int, honor_num_need_promote:int, is_get_guard_wage:Boolean,get_guard_wage_credits:int,
								   nest_credits_level_info_vec_ui:Array, guard_wage_info:Array):void;
		
		//更新小窝积分面板
		function OnRefreshNestCreditsPanel(  credits:int,  credits_level:int):void;
		
		function OnPublishNestTask(is_published:Boolean):void;
		
		//更新主播PK榜
		function onRefreshAnchorPKRank(e:CEventRefreshAnchorPKRank):void;
		//更新玩家贡献榜
		function onRefreshPlayerContributePKRank(e:CEventRefreshPlayerContributePKRank):void;
		//刷新火箭buff 主动下发
		function onRefreshRocketBuff(e:CEventRefreshRocketBuff):void;
		//刷新pk赛进度条信息，10s一次
		function onRefreshPkProgressInfo(e:CEventRefreshPkProgressInfo):void;
		//刷新pk比赛信息，包括比赛开始倒计时，开始比赛，比赛结束的结果通知
		function onNotifyPkMatchInfo(e:CEventNotifyPkMatchInfo):void;
		//刷新pk值信息，1s一次
		function onRefreshPkValue(e:CEventRefreshPkValue):void;
		//刷新pk礼物，pk的角标
		function onRefreshPkGift(e:CEventRefreshPkGift):void;
		
		//向客户端发送通用活动开始信息
		function onCommonActivityInfoBegin(e:CEventCommonActivityInfoBegin):void;		 
		//向客户端发送通用活动结束信息
		function onCommonActivityInfoEnd(e:CEventCommonActivityInfoEnd):void;		 
		//向客户端发送通用活动配置更新信息
		function onCommonActivityInfoRefresh(e:CEventCommonActivityInfoRefresh):void;
		//向客户端发送通用活动地板数据信息（包括主播排名，主播收到的礼物数，底板等级）
		function onRefreshCommonActivityData(e:CEventRefreshCommonActivityData):void;
		//向客户端发送的玩家贡献榜信息
		function onCommonActivityPlayerRank(e:CEventCommonActivityPlayerRank):void;
	}	
}