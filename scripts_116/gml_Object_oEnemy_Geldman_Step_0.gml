event_inherited();

if (KnockBackDone || StunDone)
    Enemy_UpdateState(UnknownEnum.Value_3);

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
    case UnknownEnum.Value_0:
        if (AllowSpawn && distance_to_object(oLink) <= 32 && !oLink.Cape)
            Enemy_UpdateState(UnknownEnum.Value_1);
        
        break;
    
    case UnknownEnum.Value_1:
        break;
    
    case UnknownEnum.Value_5:
        if (image_index >= 0.8)
            Enemy_UpdateState(UnknownEnum.Value_3);
    
    case UnknownEnum.Value_3:
        if (WallCollide_X)
            Enemy_UpdateState(UnknownEnum.Value_8);
        
        if (WallCollide_Y)
            Enemy_UpdateState(UnknownEnum.Value_8);
        
        break;
    
    case UnknownEnum.Value_8:
        if (image_index >= 3.6)
            Enemy_UpdateState(UnknownEnum.Value_0);
        
        break;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_3 = 3,
    Value_5 = 5,
    Value_8 = 8,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
