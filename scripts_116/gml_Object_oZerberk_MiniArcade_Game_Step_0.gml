switch (State)
{
    case UnknownEnum.Value_0:
        if (input_check_pressed("inventory"))
        {
            State = UnknownEnum.Value_1;
            ShowLevel = true;
            ShowScore = true;
            Score = 0;
            Level = 0;
            LevelChange = false;
            alarm[2] = 100;
            instance_create_depth(0, 0, depth, oZerberk_MiniArcade_Ship);
        }
        
        break;
    
    case UnknownEnum.Value_1:
        if (LevelChange && instance_number(oZerberk_MiniArcade_Alien) == 0)
        {
            LevelChange = false;
            alarm[3] = 60;
        }
        
        break;
    
    case UnknownEnum.Value_2:
        if (input_check_pressed("inventory") || input_check_pressed("sword"))
            State = UnknownEnum.Value_0;
        
        break;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2
}
