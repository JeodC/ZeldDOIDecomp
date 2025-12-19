event_inherited();

if (KnockBackDone || StunDone)
{
    Enemy_UpdateState(UnknownEnum.Value_3);
    Eyegore_UpdateDir(DirFaceLink());
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
    case UnknownEnum.Value_0:
        if (!IdleDelay && distance_to_object(oLink) <= 30 && !oLink.Cape)
            Enemy_UpdateState(UnknownEnum.Value_1);
        
        break;
    
    case UnknownEnum.Value_1:
        if (image_index >= 2.9)
        {
            Enemy_UpdateState(UnknownEnum.Value_3);
            alarm[1] = 200;
        }
        
        break;
    
    case UnknownEnum.Value_3:
        if (WallCollide_X)
            Eyegore_UpdateDir(Enemy_WallCollisionNewDir(1));
        
        if (WallCollide_Y)
            Eyegore_UpdateDir(Enemy_WallCollisionNewDir(2));
        
        break;
    
    case UnknownEnum.Value_8:
        if (image_index <= 1)
            Enemy_UpdateState(UnknownEnum.Value_0);
        
        break;
}

switch (Dir)
{
    case 3:
    case 4:
        InWaterSprW = 18;
        break;
    
    case 1:
    case 2:
        InWaterSprW = 22;
        break;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_3 = 3,
    Value_8 = 8,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
