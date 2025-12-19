function Bomb_CheckLinkDamage(arg0, arg1 = 24, arg2 = 2)
{
    if (Pendant_Check(UnknownEnum.Value_2))
        exit;
    
    var _LinkInst = ObjCollision_Circle(x, y, arg1, oLink, arg0);
    
    if (_LinkInst == -4)
        exit;
    
    var _DistToLink = point_distance(x, y, oLink.x, oLink.y - 6);
    var _DamageFactor = floor(_DistToLink / 3) * 0.25;
    var _Damage = clamp((arg2 + 1) - _DamageFactor, 0.5, arg2);
    
    if (_Damage > 0)
    {
        with (_LinkInst)
            LinkHit(point_direction(other.x, other.y, x, y - 6), 0.5 + _Damage, 8 + floor(_Damage * 3), _Damage);
    }
}

function Bombs_PickAmount(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_15:
        case UnknownEnum.Value_16:
        case UnknownEnum.Value_0:
            return choose(1, 1, 1, 1, 1, 2);
            break;
        
        case UnknownEnum.Value_17:
            return choose(1, 1, 1, 2);
            break;
        
        case UnknownEnum.Value_18:
            return choose(1, 1, 2, 3);
            break;
        
        case UnknownEnum.Value_2:
        case UnknownEnum.Value_5:
            return choose(3, 3, 4, 5, 6, 8);
            break;
        
        case UnknownEnum.Value_4:
        case UnknownEnum.Value_9:
            return choose(3, 4, 5, 6, 8, 10);
            break;
    }
    
    return 1;
}

enum UnknownEnum
{
    Value_0,
    Value_2 = 2,
    Value_4 = 4,
    Value_5,
    Value_9 = 9,
    Value_15 = 15,
    Value_16,
    Value_17,
    Value_18
}
