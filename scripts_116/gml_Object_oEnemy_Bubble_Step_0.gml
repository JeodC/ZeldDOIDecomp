event_inherited();
Lighting_UpdateLight_Visible(RoomIndex, LightIndex, State == UnknownEnum.Value_3);

if (global.Paused || State == UnknownEnum.Value_10 || State == UnknownEnum.Value_11 || State == UnknownEnum.Value_13 || State == UnknownEnum.Value_15 || State == UnknownEnum.Value_16 || State == UnknownEnum.Value_17)
{
    ObjPause();
    exit;
}
else
{
    image_speed = LastImageSpeed;
}

Lighting_UpdateLight_Pos(RoomIndex, LightIndex, x, y);

for (var i = 0; i < 4; i++)
    BubbleAngle[i] = (BubbleAngle[i] + 4) % 360;

enum UnknownEnum
{
    Value_3 = 3,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
