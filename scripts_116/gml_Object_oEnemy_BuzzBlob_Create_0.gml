event_inherited();
Size = UnknownEnum.Value_1;
Enemy_UpdateState(UnknownEnum.Value_3);
Speed = 0.15;
BuzzBlob_UpdateDir();
CheckForWater = true;
InWaterSprW = sprite_width + 2;
WallCollide_Bounce = true;
ShockPal = 0;
LightIndex = Lighting_CreateLight(RoomIndex, x, y, 0.8, [0.5, 0.5, 0.5], false);

enum UnknownEnum
{
    Value_1 = 1,
    Value_3 = 3
}
