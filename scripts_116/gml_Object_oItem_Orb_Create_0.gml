event_inherited();
CanPickup = true;
ShadowOffsetY = -2;

switch (From)
{
    default:
        Item_SetIndex(choose(UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_2));
        break;
    
    case UnknownEnum.Value_11:
        Item_SetIndex(choose(UnknownEnum.Value_0, UnknownEnum.Value_1));
        break;
    
    case UnknownEnum.Value_10:
        Item_SetIndex(UnknownEnum.Value_2);
        break;
}

if (Index == UnknownEnum.Value_2)
    exit;

switch (From)
{
    default:
        Amount = choose(1, 1, 1, 1, 1, 2);
        break;
    
    case UnknownEnum.Value_2:
    case UnknownEnum.Value_4:
    case UnknownEnum.Value_5:
    case UnknownEnum.Value_11:
        Amount = choose(3, 3, 3, 4, 4, 5);
        break;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_4 = 4,
    Value_5,
    Value_10 = 10,
    Value_11
}
