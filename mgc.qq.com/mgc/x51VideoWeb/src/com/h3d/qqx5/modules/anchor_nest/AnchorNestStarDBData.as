package com.h3d.qqx5
{
public class AnchorNestStarDBData extends ProtoBufSerializable
{
  public override function CLSID() : int
  {
    return CallCenterMessageID.CLSID_AnchorNestStarDBData;
  }

  public function AnchorNestStarDBData()
  {
    registerField("nest_id", "", Descriptor.Int32, 1);
    registerField("player_id", "", Descriptor.Int64, 2);
    registerField("day_seq", "", Descriptor.Int32, 3);
    registerField("day_star", "", Descriptor.Int32, 4);
    registerField("total_star", "", Descriptor.Int64, 5);
    registerField("last_update", "", Descriptor.Int32, 6);
  }

  public var nest_id : int;
  public var player_id : Int64;
  public var day_seq : int;
  public var day_star : int;
  public var total_star : Int64;
  public var last_update : int;
}
}
