package com.h3d.qqx5.videoclient.interfaces
{
	/**
	 * @author liuchui
	 */
	public interface IUIAnchorPK
	{
//		//活动状态变化后通知UI
//		virtual void NotifyActivityStatusChange(int new_status)=0;
//		//比赛状态变化后通知UI（准备阶段 缓冲阶段 攻击阶段等等）
//		//seconds:新阶段的长度（秒），如果是中途进入房间的玩家，表示new_status还剩多少秒，-1表示这个阶段的时间是不定的
//		//extra_data:附加信息，进入准备阶段时，extra_data表示距离A攻击开始的时间
//		virtual void NotifyMatchStatusChange(int old_status,int new_status,int seconds,int extra_data)=0;
//		//比赛开始
//		virtual void NotifyMatchStart(const SimpleAnchorForUI& anchorA,const SimpleAnchorForUI& anchorB)=0;
//		//攻击开始前N秒要通知UI播特效
//		virtual void NotifyPreAttack(int next_status)=0;
//		//贡献加成buff触发时通知UI
//		virtual void NotifyBuff(VideoInt64 anchor_id, int time_len)=0;
//		//PK过程中主播的攻防值
//		virtual void RefreshAnchorData(AnchorPKADInfo& info)=0;
//		//一次攻防/回合/比赛结束
//		virtual void NotifyOver(AnchorPKOverCode over_code, AnchorPKSimpleScoreInfo& info)=0;
//		//主播分数
//		virtual void RefreshAnchorScore(AnchorPKSimpleScoreInfo& info)=0;
//		//仅首次献礼时调用
//		virtual void RefreshRichestManAvatar(AnchorPKFansAvatars& avatars)=0;
//		//比分详情
//		virtual void RefreshMatchDetail(VideoResultType type, int result, AnchorPKScoreInfo& score_info)=0;
//		//准备阶段的预告(聊天区)
//		//minutes：文字内容中的XX分钟后
//		virtual void ForecastChat(int minutes,const std::string& anchorA,const std::string& anchorB) = 0;
//		//准备阶段的预告（走马灯）
//		virtual void ForecastZouMaDeng(int minutes,int room_id,const std::string& room_name,const std::string& anchorA,const std::string& anchorB)=0;
//		//比赛开始或玩家中途进入时,通知比赛双方主播信息
//		virtual void NotifyAnchorInfo(ClientAnchorData& anchorA_info, ClientAnchorData& anchorB_info)=0;
//		//刷新主播头像
//		virtual void RefreshAnchorImage(VideoInt64 anchor_id)=0;
//		//刷新玩家在本PK阶段的贡献值
//		virtual void RefreshPlayerContributionInCurPK(VideoInt64 contribution)=0;
//		//比赛结束（走马灯）
//		virtual void MatchEndZouMaDeng(const std::string& winner,const std::string& loser,bool is_draw)  = 0;
	}	
}