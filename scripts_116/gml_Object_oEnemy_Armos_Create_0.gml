event_inherited();
Size = UnknownEnum.Value_3;
Speed = 0.75;
JumpVZ = 2;
Gravity = -0.2;
GravityStatus = true;
WakeColors = array_create(0);
array_insert(WakeColors, 0, [1, 0, 0], [0, 1, 0], [0, 0, 1]);
WakeColorFrame = 0;
CheckForWater = true;
InWaterSprW = sprite_width + 4;
Enemy_UpdateState(UnknownEnum.Value_0);

enum UnknownEnum
{
    Value_0,
    Value_3 = 3
}
