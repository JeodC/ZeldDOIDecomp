event_inherited();

if (KnockBackDone || StunDone || ShockDone)
{
    Enemy_UpdateState(UnknownEnum.Value_3);
    Lighting_UpdateLight_Visible(RoomIndex, LightIndex, false);
    BuzzBlob_UpdateDir();
}

if (global.Paused || State == UnknownEnum.Value_10 || State == UnknownEnum.Value_11 || State == UnknownEnum.Value_13 || State == UnknownEnum.Value_15 || State == UnknownEnum.Value_16 || State == UnknownEnum.Value_17)
{
    ObjPause();
    exit;
}
else
{
    image_speed = LastImageSpeed;
}

switch (State)
{
    case UnknownEnum.Value_2:
    case UnknownEnum.Value_3:
        break;
    
    case UnknownEnum.Value_14:
        ShockFrame += 0.15;
        ShockPal = floor(ShockFrame) % 3;
        Lighting_UpdateLight_Radius(RoomIndex, LightIndex, random_range(0.6, 0.7));
        Lighting_UpdateLight_RGB(RoomIndex, LightIndex, [(ShockPal == 1) ? 0.6 : 0.3, (ShockPal > 0) ? 0.6 : 0.3, (ShockPal == 0) ? 0.6 : 0.3]);
        break;
}

enum UnknownEnum
{
    Value_2 = 2,
    Value_3,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_14,
    Value_15,
    Value_16,
    Value_17
}
