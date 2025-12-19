event_inherited();
Size = UnknownEnum.Value_3;
Gravity = -0.075;
JumpZ = 2;
Speed = 1.2;
WallCollide_Bounce = true;
Hops = 0;
WalkingLayer = layer;
CheckForWater = true;
Enemy_UpdateState(choose(UnknownEnum.Value_2, UnknownEnum.Value_5));

enum UnknownEnum
{
    Value_2 = 2,
    Value_3,
    Value_5 = 5
}
