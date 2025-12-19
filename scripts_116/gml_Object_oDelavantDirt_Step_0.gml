switch (State)
{
    case UnknownEnum.Value_1:
        sprite_index = sDelavantDirt_Reveal;
        image_speed = 1;
        break;
    
    case UnknownEnum.Value_7:
        sprite_index = sDelavantDirt;
        image_speed = 1;
        break;
    
    case UnknownEnum.Value_8:
        sprite_index = sDelavantDirt_Reveal;
        image_speed = -1;
        break;
    
    case UnknownEnum.Value_15:
    case UnknownEnum.Value_16:
    case UnknownEnum.Value_17:
        image_speed = 0;
        break;
}

enum UnknownEnum
{
    Value_1 = 1,
    Value_7 = 7,
    Value_8,
    Value_15 = 15,
    Value_16,
    Value_17
}
