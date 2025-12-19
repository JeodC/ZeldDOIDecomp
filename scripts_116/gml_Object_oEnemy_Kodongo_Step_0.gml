event_inherited();

if (KnockBackDone || StunDone || ShockDone)
{
    alarm[1] = -1;
    ScriptPos = 1;
    Dir = DirFaceLink();
    Enemy_UpdateState(ds_grid_get(Script, 0, ScriptPos));
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
        if (WallCollide_X)
            Kodongo_UpdateDir(Enemy_WallCollisionNewDir(1));
        
        if (WallCollide_Y)
            Kodongo_UpdateDir(Enemy_WallCollisionNewDir(2));
        
        break;
    
    case UnknownEnum.Value_7:
        if (Type == 1 && !oLink.Cape)
        {
            Dir = DirFaceLink();
            Enemy_UpdateSprite(State);
        }
        
        break;
}

switch (Dir)
{
    case 3:
    case 4:
        InWaterSprW = 18;
        InWaterSprYOffset = -2;
        break;
    
    case 1:
    case 2:
        InWaterSprW = 16;
        InWaterSprYOffset = -3;
        break;
}

enum UnknownEnum
{
    Value_3 = 3,
    Value_7 = 7,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
