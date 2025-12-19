switch (State)
{
    case UnknownEnum.Value_21:
    case UnknownEnum.Value_20:
    case UnknownEnum.Value_4:
    case UnknownEnum.Value_24:
    case UnknownEnum.Value_19:
        exit;
}

if (State == UnknownEnum.Value_18)
{
    LinkHit(point_direction(ShockEnemyInst.x, ShockEnemyInst.y, x, y), 1.25, 12, ShockEnemyInst.Attack);
    ShockEnemyInst = -4;
}
else
{
    BounceBack = false;
    
    with (oWall)
    {
        if (IsStairs)
            BlockLink = false;
    }
    
    UpdateState(UnknownEnum.Value_1);
}

enum UnknownEnum
{
    Value_1 = 1,
    Value_4 = 4,
    Value_18 = 18,
    Value_19,
    Value_20,
    Value_21,
    Value_24 = 24
}
