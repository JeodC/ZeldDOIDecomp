LinkInFront = oLink.x >= (x - 7) && oLink.x <= (x + 7) && (oLink.y - 6) >= (y - 1) && (oLink.y - 6) <= (y + 1) && oLink.Facing == 1;

if (!GameAllowed && !LinkInFront)
    GameAllowed = true;

switch (State)
{
    case UnknownEnum.Value_0:
        if (LinkInFront && GameAllowed)
        {
            global.ArcadeVP_Show = true;
            State = UnknownEnum.Value_1;
        }
        
        break;
    
    case UnknownEnum.Value_2:
    case UnknownEnum.Value_5:
        if (!LinkInFront)
        {
            State = UnknownEnum.Value_6;
            break;
        }
}

switch (State)
{
    case UnknownEnum.Value_1:
        oLink.actionVideoGame = false;
        break;
    
    case UnknownEnum.Value_3:
        break;
    
    case UnknownEnum.Value_6:
        break;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_5 = 5,
    Value_6
}
