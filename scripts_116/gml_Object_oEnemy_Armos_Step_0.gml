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
        if (!oLink.Cape && distance_to_object(oLink) <= 24)
            Enemy_UpdateState(UnknownEnum.Value_1);
        
        break;
    
    case UnknownEnum.Value_1:
        WakeColorFrame = (WakeColorFrame + 1) % 3;
        break;
    
    case UnknownEnum.Value_3:
        var _Speed = oLink.Cape ? 0 : Speed;
        var LinkDir = point_direction(x, y, oLink.x, oLink.y);
        vx = lengthdir_x(_Speed, LinkDir);
        vy = lengthdir_y(_Speed, LinkDir);
        
        if (JumpLanded)
        {
            vz = JumpVZ;
            GravityStatus = true;
        }
        
        break;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_3 = 3,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
