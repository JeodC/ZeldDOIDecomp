event_inherited();
Size = UnknownEnum.Value_1;
ObjSetImageSpeed(choose(1, 0.5));
alarm[0] = irandom_range(90, 180);
MaxSpeed = 0.4;
MoveDelay = 10;
CheckForWater = true;
InWaterSprW = sprite_width + 2;
InWaterSprYOffset = -4;
Enemy_UpdateState(choose(UnknownEnum.Value_2, UnknownEnum.Value_3));
WallCollide_Bounce = true;
ShadowOffsetY = -1;
vxold = vx;
vyold = vy;

enum UnknownEnum
{
    Value_1 = 1,
    Value_2,
    Value_3
}
