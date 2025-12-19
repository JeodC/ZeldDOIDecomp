if (InitWaterSpr)
{
    switch (Index)
    {
        default:
            InWaterSprW = 18;
            break;
        
        case UnknownEnum.Value_4:
        case UnknownEnum.Value_11:
            InWaterSprW = 16;
            InWaterSprXOffset = -2;
            break;
        
        case UnknownEnum.Value_14:
        case UnknownEnum.Value_5:
        case UnknownEnum.Value_25:
        case UnknownEnum.Value_28:
        case UnknownEnum.Value_29:
            InWaterSprW = 14;
            InWaterSprXOffset = -2;
            break;
        
        case UnknownEnum.Value_30:
        case UnknownEnum.Value_31:
            InWaterSprW = 16;
            InWaterSprXOffset = -1;
            break;
        
        case UnknownEnum.Value_6:
            InWaterSprW = 16;
            break;
        
        case UnknownEnum.Value_46:
            InWaterSprW = 20;
            break;
        
        case UnknownEnum.Value_12:
        case UnknownEnum.Value_50:
        case UnknownEnum.Value_37:
        case UnknownEnum.Value_44:
            InWaterSprXOffset = -1;
            break;
        
        case UnknownEnum.Value_49:
        case UnknownEnum.Value_48:
            InWaterSprW = 20;
            InWaterSprYOffset = -5;
            break;
        
        case UnknownEnum.Value_32:
        case UnknownEnum.Value_33:
            InWaterSprYOffset = -5;
            InWaterSprXOffset = 2;
            break;
    }
    
    InitWaterSpr = false;
}

enum UnknownEnum
{
    Value_4 = 4,
    Value_5,
    Value_6,
    Value_11 = 11,
    Value_12,
    Value_14 = 14,
    Value_25 = 25,
    Value_28 = 28,
    Value_29,
    Value_30,
    Value_31,
    Value_32,
    Value_33,
    Value_37 = 37,
    Value_44 = 44,
    Value_46 = 46,
    Value_48 = 48,
    Value_49,
    Value_50
}
