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
    case UnknownEnum.Value_2:
        if (CanFly && distance_to_object(oLink) <= 32 && !oLink.Cape)
            Enemy_UpdateState(UnknownEnum.Value_3);
        
        break;
    
    case UnknownEnum.Value_3:
        if (WallCollide_X || WallCollide_Y)
            Dir = (Dir + 180) % 360;
        
        Dir = (Dir + (AngleDir * 3)) % 360;
        vx = lengthdir_x(Speed, Dir);
        vy = lengthdir_y(Speed, Dir);
        
        if (Land)
        {
            z -= 0.5;
            
            if (z <= 0)
            {
                z = 0;
                Land = false;
                Enemy_UpdateState(UnknownEnum.Value_2);
            }
        }
        else if (z < MaxZ)
        {
            z += 0.5;
        }
        
        break;
}

enum UnknownEnum
{
    Value_2 = 2,
    Value_3,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
