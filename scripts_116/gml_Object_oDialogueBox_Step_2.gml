if (CameraExists)
{
    if (oCamera.RoomTransition != 0 || oLink.State == UnknownEnum.Value_5)
        exit;
    
    if (oLink.State != UnknownEnum.Value_25 || !global.Paused)
    {
        with (oLink)
            UpdateState(UnknownEnum.Value_25);
        
        global.Paused = true;
    }
}

if (ScriptNext)
{
    ScriptNext = false;
    
    do
    {
        GotoFlag = false;
        ScriptCode = ds_grid_get(Script, 0, ScriptPos);
        
        switch (ScriptCode)
        {
            case UnknownEnum.Value_1:
            case UnknownEnum.Value_2:
            case UnknownEnum.Value_3:
            case UnknownEnum.Value_4:
            case UnknownEnum.Value_0:
                var DialogueStr = is_method(ds_grid_get(Script, 1, ScriptPos)) ? ds_grid_get(Script, 1, ScriptPos)() : ds_grid_get(Script, 1, ScriptPos);
                
                if (string_count("\\", DialogueStr) > 0)
                {
                    DialogueArray = SplitStrToArray(DialogueStr, "\\");
                }
                else if (string_count("^", DialogueStr) > 0)
                {
                    Title = SplitStrToArray(DialogueStr, "^");
                    DialogueArray = SplitSentenceToArray(Title[1], global.HUDFont, SurfaceW);
                    array_insert(DialogueArray, 0, Title[0]);
                }
                else
                {
                    DialogueArray = SplitSentenceToArray(DialogueStr, global.HUDFont, SurfaceW);
                }
                
                LinesLeft = array_length(DialogueArray);
                SurfaceH = 0;
                SurfaceY = 0;
                SurfaceShiftDelay = 4;
                InputChoice = 0;
                Status = UnknownEnum.Value_0;
                break;
            
            case UnknownEnum.Value_5:
                var Condition = ds_grid_get(Script, 1, ScriptPos)();
                ScriptPos = Condition ? ds_grid_get(Script, 2, ScriptPos) : ds_grid_get(Script, 3, ScriptPos);
                GotoFlag = true;
                break;
            
            case UnknownEnum.Value_6:
                audio_play_sound_stopall(Sound_Error);
                ScriptPos = ds_grid_get(Script, 1, ScriptPos);
                GotoFlag = true;
                break;
            
            case UnknownEnum.Value_7:
                global.DB_ExitCode = ds_grid_get(Script, 1, ScriptPos);
                Status = UnknownEnum.Value_5;
                break;
        }
    }
    until (!GotoFlag);
}

switch (Status)
{
    case UnknownEnum.Value_0:
        if (SurfaceH < SurfaceMaxH)
        {
            SurfaceH += 16;
            
            if (ScriptCode != UnknownEnum.Value_4)
                audio_play_sound(Sound_Text, 1, false);
            
            if (SurfaceH >= SurfaceMaxH)
            {
                SurfaceH = SurfaceMaxH;
                Status = UnknownEnum.Value_1;
                
                if (ScriptCode != UnknownEnum.Value_4)
                    audio_play_sound(Sound_TextDone, 1, false);
            }
            else
            {
                SurfaceShiftDelay = 4;
                Status = UnknownEnum.Value_3;
                SurfaceShiftDelayLastState = UnknownEnum.Value_0;
            }
            
            if (!surface_exists(Surface))
                Surface = surface_create(SurfaceW, floor(SurfaceH));
            else
                surface_resize(Surface, SurfaceW, floor(SurfaceH));
        }
        
        break;
    
    case UnknownEnum.Value_1:
        var Key = input_check_pressed("sword") || input_check_pressed("action");
        
        if (LinesLeft <= 3)
        {
            switch (ScriptCode)
            {
                case UnknownEnum.Value_0:
                case UnknownEnum.Value_4:
                    if (Key)
                    {
                        ScriptPos = ds_grid_get(Script, 2, ScriptPos);
                        ScriptNext = true;
                        exit;
                    }
                    
                    break;
                
                case UnknownEnum.Value_1:
                    Status = UnknownEnum.Value_4;
                    InputChoices = 2;
                    break;
                
                case UnknownEnum.Value_2:
                case UnknownEnum.Value_3:
                    Status = UnknownEnum.Value_4;
                    InputChoices = 3;
                    break;
            }
        }
        else if (Key)
        {
            Status = UnknownEnum.Value_2;
        }
        
        break;
    
    case UnknownEnum.Value_2:
        SurfaceY -= 8;
        
        if (ScriptCode != UnknownEnum.Value_4)
            audio_play_sound(Sound_Text, 1, false);
        
        if ((SurfaceY % (clamp(LinesLeft, 1, 3) * 16)) == 0)
        {
            LinesLeft -= 3;
            
            if (LinesLeft < 0)
                LinesLeft = 0;
            
            Status = UnknownEnum.Value_1;
            
            if (ScriptCode != UnknownEnum.Value_4)
                audio_play_sound(Sound_TextDone, 1, false);
        }
        else
        {
            SurfaceShiftDelay = 4;
            Status = UnknownEnum.Value_3;
            SurfaceShiftDelayLastState = UnknownEnum.Value_2;
        }
        
        break;
    
    case UnknownEnum.Value_3:
        SurfaceShiftDelay--;
        
        if (SurfaceShiftDelay == 0)
            Status = SurfaceShiftDelayLastState;
        
        break;
    
    case UnknownEnum.Value_4:
        if (input_check_pressed("left"))
        {
            InputChoice -= 1;
            
            if (InputChoice < 0)
                InputChoice = InputChoices - 1;
        }
        
        if (input_check_pressed("right"))
            InputChoice = (InputChoice + 1) % InputChoices;
        
        if (input_check_pressed("sword") || input_check_pressed("action"))
        {
            ScriptPos = ds_grid_get(Script, 2 + InputChoice, ScriptPos);
            ScriptNext = true;
            exit;
        }
        
        break;
    
    case UnknownEnum.Value_5:
        if (!instance_exists(oInventory))
        {
            global.Paused = false;
            
            with (oLink)
                UpdateState(UnknownEnum.Value_1);
        }
        else
        {
            with (oLink)
                UpdateState(UnknownEnum.Value_24);
        }
        
        instance_destroy(id);
        exit;
        break;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_24 = 24,
    Value_25
}
