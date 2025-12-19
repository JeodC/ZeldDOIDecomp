event_inherited();

if (KnockBackDone || StunDone)
{
    Enemy_UpdateState(UnknownEnum.Value_2);
    alarm[0] = 30;
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
    case UnknownEnum.Value_5:
        if (JumpLanded)
        {
            Hops--;
            
            if (Hops <= 0)
                Enemy_UpdateState(UnknownEnum.Value_2);
            else
                vz = 2;
            
            layer = WalkingLayer;
        }
        
        break;
}

enum UnknownEnum
{
    Value_2 = 2,
    Value_5 = 5,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
