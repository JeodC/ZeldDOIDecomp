event_inherited();
Item_SetIndex(irandom(global.PopFlavors - 1));
ShadowOffsetY = -2;

if (variable_instance_exists(id, "From"))
{
    switch (From)
    {
        case UnknownEnum.Value_2:
            Amount = choose(1, 1, 1, 1, 2, 2, 2, 3);
            break;
        
        case UnknownEnum.Value_4:
            Amount = choose(1, 2, 2, 3, 3, 4);
            break;
        
        case UnknownEnum.Value_5:
            Amount = choose(2, 3);
            break;
    }
}

enum UnknownEnum
{
    Value_2 = 2,
    Value_4 = 4,
    Value_5
}
