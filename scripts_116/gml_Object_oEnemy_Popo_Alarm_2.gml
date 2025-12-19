if (State == UnknownEnum.Value_3)
{
    if (vx != 0 || vy != 0)
    {
        vxold = vx;
        vyold = vy;
        vx = 0;
        vy = 0;
    }
    else
    {
        vx = vxold;
        vy = vyold;
    }
}

alarm[2] = MoveDelay;

enum UnknownEnum
{
    Value_3 = 3
}
