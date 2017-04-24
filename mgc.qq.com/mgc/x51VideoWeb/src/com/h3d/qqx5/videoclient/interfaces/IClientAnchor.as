package com.h3d.qqx5.videoclient.interfaces
{
	import com.h3d.qqx5.common.comdata.VideoAccount;

	public interface IClientAnchor
	{
//		virtual void InitTime( time32 t ) = 0;
//		virtual time32 GetTime() const = 0;
//		virtual void SetStatus( ClientAnchorStatus status ) = 0;
//		virtual ClientAnchorStatus GetStatus() const = 0;
//		virtual void SetServerId( int server_id ) = 0;
//		virtual int GetServerId() const = 0;
//		virtual void SetRoomId( int room_id ) = 0;
//		virtual int GetRoomId() = 0;
//		virtual void HandleServerEvent( IEvent * event ) = 0;
		function GetVideoAccount():VideoAccount;
//		virtual const AnchorData & GetAnchorData() const = 0;
//		virtual bool IsRoomAnchor(int room_id) const = 0;
//		virtual bool IsRoomAdmin(int room_id) const = 0;
//		virtual const std::vector<int>& GetAnchorRoom() const = 0;
//		virtual std::vector<int> GetAdminRoom() const = 0;
//		virtual bool IsRoomOwner(int room_id) const = 0;
//		virtual int GetNestID() const = 0;
//		virtual bool IsNestRoom(int room_id) const = 0;
	}
}