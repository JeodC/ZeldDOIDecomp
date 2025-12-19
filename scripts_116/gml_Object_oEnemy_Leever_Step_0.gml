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
        break;
    
    case UnknownEnum.Value_1:
        if (image_index >= 12.8)
            Enemy_UpdateState(UnknownEnum.Value_3);
        
        break;
    
    case UnknownEnum.Value_3:
        if (WallCollide_X || WallCollide_Y)
            Leever_UpdateDir();
        else if (!oLink.Cape)
            Dir = point_direction(x, y, oLink.x, oLink.y);
        
        vx = lengthdir_x(Speed, Dir);
        vy = lengthdir_y(Speed, Dir);
        break;
    
    case UnknownEnum.Value_8:
        if (image_index >= 12.8)
            Enemy_UpdateState(UnknownEnum.Value_0);
        
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
