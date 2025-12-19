event_inherited();
Size = UnknownEnum.Value_0;
WalkSpeed = 1.5;
CheckForWater = true;
InWaterSprYOffset = 2;
Dir = RandomDir();
Enemy_UpdateState(choose(UnknownEnum.Value_2, UnknownEnum.Value_3, UnknownEnum.Value_3));

enum UnknownEnum
{
    Value_0,
    Value_2 = 2,
    Value_3
}
