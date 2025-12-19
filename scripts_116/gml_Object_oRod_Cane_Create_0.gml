switch (Index)
{
    case UnknownEnum.Value_0:
        sprite_index = asset_get_index("sRod_Stone_" + global.DirStr[Facing]);
        break;
    
    case UnknownEnum.Value_1:
        sprite_index = asset_get_index("sRod_Ice_" + global.DirStr[Facing]);
        break;
    
    case UnknownEnum.Value_2:
        sprite_index = asset_get_index("sRod_Fire_" + global.DirStr[Facing]);
        break;
    
    case UnknownEnum.Value_3:
        sprite_index = asset_get_index("sRod_Bomb_" + global.DirStr[Facing]);
        break;
    
    case UnknownEnum.Value_4:
        sprite_index = asset_get_index("sRod_Heart_" + global.DirStr[Facing]);
        break;
    
    case UnknownEnum.Value_5:
        sprite_index = asset_get_index("sRod_Wealth_" + global.DirStr[Facing]);
        break;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5
}
