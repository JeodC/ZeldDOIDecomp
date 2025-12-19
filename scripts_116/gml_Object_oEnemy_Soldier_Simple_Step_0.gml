event_inherited();

if (KnockBackDone || StunDone)
{
    Soldier_UpdateDir(oLink.Cape ? RandomDir() : DirFaceLink());
    Enemy_UpdateState(UnknownEnum.Value_4);
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
            Enemy_UpdateState(UnknownEnum.Value_9);
    
    case UnknownEnum.Value_4:
        if (WallCollide_X)
            Soldier_UpdateDir(Enemy_WallCollisionNewDir(1));
        
        if (WallCollide_Y)
            Soldier_UpdateDir(Enemy_WallCollisionNewDir(2));
        
        break;
}

enum UnknownEnum
{
    Value_3 = 3,
    Value_4,
    Value_9 = 9,
    Value_10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
