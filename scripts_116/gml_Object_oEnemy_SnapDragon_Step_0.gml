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

if (WallCollide_X)
    SnapDragon_UpdateDir((Dir == 3) ? 4 : 3);

if (WallCollide_Y)
    SnapDragon_UpdateDir((Dir == 1) ? 2 : 1);

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
