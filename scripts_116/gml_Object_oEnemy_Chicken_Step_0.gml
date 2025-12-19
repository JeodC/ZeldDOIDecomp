event_inherited();

if (Hit_Started)
{
    audio_stop_sound(Sound_Chicken);
    audio_play_sound(Sound_Chicken, 1, false);
}

if (KnockBackDone || StunDone)
{
    Enemy_UpdateState(UnknownEnum.Value_4);
    Chicken_SetScared();
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

if (PickedUp)
{
    if (oLink.Facing == 3)
        Dir = -1;
    
    if (oLink.Facing == 4)
        Dir = 1;
    
    layer = PickupLayer;
    exit;
}
else
{
    layer = NormalLayer;
}

if (State == UnknownEnum.Value_4)
    Dir = Chicken_GetDir();
else if (WallCollide_X)
    Dir *= -1;

switch (State)
{
    case UnknownEnum.Value_3:
        if (JumpLanded)
        {
            Hops--;
            
            if (Hops <= 0)
            {
                Enemy_UpdateState(UnknownEnum.Value_2);
            }
            else
            {
                GravityStatus = true;
                vz = JumpSpeed;
            }
        }
        
        break;
    
    case UnknownEnum.Value_5:
        if (JumpLanded)
        {
            vx = 0;
            vy = 0;
            Enemy_UpdateState(UnknownEnum.Value_4);
        }
        
        break;
    
    case UnknownEnum.Value_4:
        var _Dir = point_direction(oLink.x, oLink.y, x, y);
        vx = lengthdir_x(RunSpeed, _Dir);
        vy = lengthdir_y(RunSpeed, _Dir);
        break;
}

enum UnknownEnum
{
    Value_2 = 2,
    Value_3,
    Value_4,
    Value_5,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
