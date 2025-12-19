event_inherited();
NormalLayer = layer;
PickupLayer = (FloorLevel == 1 || FloorLevel == 2) ? global.LayerID_ObjsHigher_Upper : global.LayerID_ObjsHigher_Lower;
Speed = 0.75;
RunSpeed = 1.25;
SpeedThrow = 4;
JumpSpeed = 1.5;
CanHurtLink = false;
Egg = Prob(0.1);
GoldenEgg = Egg ? Prob(0.1) : false;
ObjSetImageSpeed(0.5);
WallCollide_Bounce = true;
ContainInRoom = true;
ContainInRoomBounce = false;
Hit_Sound = Sound_Chicken_Hit;
Hops = 0;
PickedUp = false;
Scared = false;
SaveVariables = ["Egg"];
Enemy_UpdateState(UnknownEnum.Value_3);

enum UnknownEnum
{
    Value_3 = 3
}
