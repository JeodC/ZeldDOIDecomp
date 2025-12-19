event_inherited();

if (KnockBackDone || StunDone)
    Enemy_UpdateState(UnknownEnum.Value_2);

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
    Buzz_UpdateDir((Dir == 3) ? choose(4, 1, 2) : choose(3, 1, 2));
else if (WallCollide_Y)
    Buzz_UpdateDir((Dir == 1) ? choose(2, 3, 4) : choose(1, 3, 4));

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
                vz = 2;
            }
        }
        
        break;
}

switch (Dir)
{
    case 3:
    case 4:
        InWaterSprW = 20;
        InWaterSprYOffset = 1;
        break;
    
    case 1:
        InWaterSprW = 16;
        InWaterSprYOffset = 1;
        break;
    
    case 2:
        InWaterSprW = 16;
        InWaterSprYOffset = 2;
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
