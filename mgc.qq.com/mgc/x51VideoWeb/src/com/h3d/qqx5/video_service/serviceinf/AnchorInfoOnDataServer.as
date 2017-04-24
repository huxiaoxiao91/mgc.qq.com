package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class AnchorInfoOnDataServer extends ProtoBufSerializable
	{	
	  public function AnchorInfoOnDataServer()
	  {
	    registerField("anchor_qq", "", Descriptor.Int64, 1);
		registerField("anchor_status", "", Descriptor.Int32, 2);
	    registerField("room_id", "", Descriptor.Int32, 3);
	    registerField("anchor_nick", "", Descriptor.TypeString, 4);
	    registerField("starlight", "", Descriptor.Int64, 5);
	    registerField("anchor_score", "", Descriptor.Int32, 6);
	    registerField("anchor_score_last_update", "", Descriptor.Int32, 7);
	    registerField("anchor_type", "", Descriptor.Int32, 8);
	    registerField("twoweek_starlight", "", Descriptor.Int32, 9);
	    registerField("twoweek_starlight_last_update", "", Descriptor.Int32, 10);
	    registerField("nest_id", "", Descriptor.Int32, 11);
	  }
	
	  public var anchor_qq : Int64;
	  public var anchor_status:int;
	  public var room_id : int;
	  public var anchor_nick : String ="";
	  public var starlight : Int64;
	  public var anchor_score : int;
	  public var anchor_score_last_update : int;
	  public var anchor_type : int;
	  public var twoweek_starlight : int;
	  public var twoweek_starlight_last_update : int;
	  public var nest_id : int;
	}
}
