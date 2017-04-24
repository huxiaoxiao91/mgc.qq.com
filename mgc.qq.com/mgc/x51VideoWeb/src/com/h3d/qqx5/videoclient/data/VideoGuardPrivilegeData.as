package com.h3d.qqx5.videoclient.data
{
	public class VideoGuardPrivilegeData
	{
		public function VideoGuardPrivilegeData()
		{
			chatFace =false;
			wordnum=0;
			joinBroadcast=false;
			chatCDTime=false;
			permanentRank=false;
			privilegeChatBoard=false;
			joinFullRoom=false;
			maxNumCount=0;
			requireAffinity=0;
			requireFollower=0;
			banChat=false;
			ingore_public_chat_on_enter= false ;
			showInSuperGuardList=false;
		}
		
		public var guardName:String;		//守护名字
		public var chatFont:String;		//聊天字体
		public var chatFace:Boolean;		//聊天表情
		public var wordnum:int;			//聊天字数上限
		public var joinBroadcast:Boolean;	//进入房间广播
		public var chatCDTime:Boolean;		//聊天cd时间
		public var permanentRank:Boolean;	//常驻显示
		public var playerListFont:String;	//玩家列表特殊字体
		public var guardIcon:String;		//守护标签
		public var privilegeChatBoard:Boolean;	//专属聊天区显示聊天内容
		public var maxNumCount:int;
		public var banChat:Boolean;				//临时禁言特权
		public var ingore_public_chat_on_enter:Boolean;       //刚进入房间时，公屏聊天CD时间。（防黑粉）
		
		public var joinFullRoom:Boolean;			//进入人满房间
		public var disableJoinFullRoom:Array =new Array;
		
		public var requireAffinity:int;
		public var requireFollower:int;
		public var showInSuperGuardList:Boolean;	//是否显示在守护榜
		public var requireMonthlyAffinity:int = 0; //对于天尊和超凡来说需要的月亲密度
	}
}