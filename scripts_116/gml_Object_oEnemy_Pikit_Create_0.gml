event_inherited();
Size = UnknownEnum.Value_1;
Gravity = -0.1;
CheckForWater = true;
InWaterSprW = sprite_width + 2;
Speed1 = 0.75;
Speed2 = 1;
Speed3 = 1.25;
JumpSpeed = 1.5;
StandPause = 30;
Shoot = false;
CanShoot = true;
CanShootPause = 45;
TongueInst = -4;
SwallowedItem_Class = -1;
SwallowedItem_Index = -1;
SwallowedItem_Amount = 0;
SaveVariables = ["SwallowedItem_Class", "SwallowedItem_Index", "SwallowedItem_Amount"];
WallCollide_Bounce = true;
Enemy_UpdateState(choose(UnknownEnum.Value_2, UnknownEnum.Value_5));

enum UnknownEnum
{
    Value_1 = 1,
    Value_2,
    Value_5 = 5
}
