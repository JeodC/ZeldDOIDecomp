function Arrows_PickAmount(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_0:
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_16:
            return choose(1, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 8, 10);
            break;
        
        case UnknownEnum.Value_15:
            return choose(1, 1, 1, 2, 2, 3, 3, 4, 5);
            break;
        
        case UnknownEnum.Value_17:
            return choose(3, 4, 4, 5, 5, 5, 5, 8, 8, 10, 10, 10);
            break;
        
        case UnknownEnum.Value_18:
            return choose(5, 5, 8, 8, 10, 10, 10, 10, 20);
            break;
        
        case UnknownEnum.Value_2:
        case UnknownEnum.Value_5:
            return choose(15, 20, 20, 25, 25, 30, 30, 40);
            break;
        
        case UnknownEnum.Value_4:
        case UnknownEnum.Value_9:
            return choose(20, 25, 30, 40, 50);
            break;
    }
    
    return 10;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_4 = 4,
    Value_5,
    Value_9 = 9,
    Value_15 = 15,
    Value_16,
    Value_17,
    Value_18
}
