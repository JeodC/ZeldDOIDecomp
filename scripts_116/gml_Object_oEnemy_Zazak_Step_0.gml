event_inherited();

if (KnockBackDone || StunDone)
{
    Soldier_UpdateDir(DirFaceLink());
    Enemy_UpdateState(UnknownEnum.Value_7);
    alarm[2] = 15;
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
    case UnknownEnum.Value_3:
        if (Enemy_LinkInSight(HeadDir, SightOffset, SightDist))
            Enemy_UpdateState(UnknownEnum.Value_7);
        else if (WallCollide_X || WallCollide_Y)
            Enemy_UpdateState(UnknownEnum.Value_2);
        
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
    Value_2 = 2,
    Value_3,
    Value_7 = 7,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
