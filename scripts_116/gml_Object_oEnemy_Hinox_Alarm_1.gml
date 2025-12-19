if (FloorLevel != oLink.FloorLevel || distance_to_object(oWall) <= 8 || distance_to_object(oLink) >= 128)
{
    Enemy_UpdateState(UnknownEnum.Value_3);
}
else
{
    var _NextState;
    
    if (oLink.Cape || instance_number(oBomb) >= 5)
        _NextState = choose(UnknownEnum.Value_3, UnknownEnum.Value_4);
    else
        _NextState = choose(UnknownEnum.Value_3, UnknownEnum.Value_4, UnknownEnum.Value_7, UnknownEnum.Value_7, UnknownEnum.Value_7, UnknownEnum.Value_7);
    
    Enemy_UpdateState(_NextState);
}

enum UnknownEnum
{
    Value_3 = 3,
    Value_4,
    Value_7 = 7
}
