event_inherited();

if (KnockBackDone || StunDone || PushbackDone)
{
    Enemy_UpdateState(UnknownEnum.Value_7);
    
    if (State == UnknownEnum.Value_7)
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
    case UnknownEnum.Value_4:
        if (WallCollide_X)
            Hinox_UpdateDir(Enemy_WallCollisionNewDir(1), Speed);
        
        if (WallCollide_Y)
            Hinox_UpdateDir(Enemy_WallCollisionNewDir(2), Speed);
        
        break;
    
    case UnknownEnum.Value_7:
        Dir = DirFaceLink();
        Enemy_UpdateSprite(State);
        break;
}

enum UnknownEnum
{
    Value_3 = 3,
    Value_4,
    Value_7 = 7,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
