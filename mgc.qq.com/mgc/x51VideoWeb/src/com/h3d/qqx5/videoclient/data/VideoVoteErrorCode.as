package com.h3d.qqx5.videoclient.data
{
	public class VideoVoteErrorCode
	{
	  public static const VideoVoteErr_Success:int = 0;
	  public static const VideoVoteErr_VoteEnd:int = 1;
	  public static const VideoVoteErr_VoteRepeate:int = 2;
	  public static const VideoVoteErr_VoteHasStarted:int = 3;
	  public static const VideoVoteErr_NoPermission:int = 4;
	  public static const VideoVoteErr_VoteNotStart:int = 5;
	  public static const VideoVoteErr_NoLiveShow:int = 6;
	  public static const VideoVoteErr_DBFailed:int = 7;
	  public static const VideoVoteErr_WaitDBLoadLastVote:int = 8;
	  public static const VideoVoteErr_AllocIDFailed:int = 9;
	  public static const VideoVoteErr_LastStartInfo:int = 10;
	  public static const VideoVoteErr_ParamError:int = 11;
	  public static const VideoVoteErr_Broadcast:int = 12;
	  public static const VideoVoteErr_HistroyEmpty:int = 13;
	  public static const VideoVoteErr_NetError:int = 14;
	}
}
