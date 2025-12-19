event_inherited();
Size = UnknownEnum.Value_0;
Gravity = -0.2;
WalkSpeed = 1.5;
JumpSpeed = 2.25;
Speed = 0;
CheckForWater = true;
InWaterSprYOffset = 1;
WallCollide_Bounce = true;
Hops = 0;
Dir = RandomDir();
Enemy_UpdateState(choose(UnknownEnum.Value_2, UnknownEnum.Value_2, UnknownEnum.Value_3));

enum UnknownEnum
{
    Value_0,
    Value_2 = 2,
    Value_3
}
