State = Prisoner_GetMainStateForIndex();

switch (State)
{
    case UnknownEnum.Value_1:
        Dir *= -1;
        image_index = 1;
        break;
    
    case UnknownEnum.Value_0:
        switch (Index)
        {
            default:
                image_index = 0;
                break;
            
            case UnknownEnum.Value_5:
            case UnknownEnum.Value_3:
            case UnknownEnum.Value_7:
                if (image_index == 0)
                    image_index = choose(1, 2);
                else
                    image_index = 0;
                
                break;
        }
        
        break;
}

alarm[0] = irandom_range(ChangeDirAlarmMin, ChangeDirAlarmMax);

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_3 = 3,
    Value_5 = 5,
    Value_7 = 7
}
