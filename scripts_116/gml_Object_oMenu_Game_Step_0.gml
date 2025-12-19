Link_PauseHitFlashingTimer();

if (Quitting)
    exit;

if (Open)
{
    Alpha += AlphaSpeed;
    
    if (Alpha >= 1)
    {
        Alpha = 1;
        Open = false;
    }
    
    exit;
}

if (Close)
{
    Alpha -= AlphaSpeed;
    
    if (Alpha <= 0)
        instance_destroy(id);
    
    exit;
}

if (keyboard_check(vk_alt))
    exit;

if (input_check_pressed("menu_access"))
{
    Close = true;
    Music_Fade(1, 6);
    exit;
}

if (input_check_pressed("up"))
{
    SelectorPos--;
    
    if (SelectorPos < 0)
        SelectorPos = MenuItems[Index] - 1;
    
    audio_play_sound(Sound_Text, 1, false);
}

if (input_check_pressed("down"))
{
    SelectorPos++;
    
    if (SelectorPos >= MenuItems[Index])
        SelectorPos = 0;
    
    audio_play_sound(Sound_Text, 1, false);
}

if (input_check_pressed("menu_input"))
{
    switch (Index)
    {
        case UnknownEnum.Value_0:
            switch (SelectorPos)
            {
                case UnknownEnum.Value_0:
                    audio_play_sound(Sound_Throw, 1, false);
                    Close = true;
                    Music_Fade(1, 6);
                    break;
                
                case UnknownEnum.Value_1:
                    QuitTo = 0;
                    Index = UnknownEnum.Value_2;
                    SelectorPos = 0;
                    audio_play_sound(Sound_TextDone, 1, false);
                    break;
                
                case UnknownEnum.Value_2:
                    Index = UnknownEnum.Value_1;
                    SelectorPos = 0;
                    audio_play_sound(Sound_TextDone, 1, false);
                    break;
                
                case UnknownEnum.Value_3:
                    QuitTo = 1;
                    Index = UnknownEnum.Value_2;
                    SelectorPos = 0;
                    audio_play_sound(Sound_TextDone, 1, false);
                    break;
                
                case UnknownEnum.Value_4:
                    QuitTo = 2;
                    Index = UnknownEnum.Value_2;
                    SelectorPos = 0;
                    audio_play_sound(Sound_TextDone, 1, false);
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_1:
            switch (SelectorPos)
            {
                case UnknownEnum.Value_0:
                    Index = UnknownEnum.Value_0;
                    SelectorPos = 0;
                    audio_play_sound(Sound_Throw, 1, false);
                    User_Save();
                    break;
                
                case UnknownEnum.Value_1:
                    global.Users[global.UserIndex].Prefs[UnknownEnum.Value_0] = !global.Users[global.UserIndex].Prefs[UnknownEnum.Value_0];
                    User_UpdateMusicSFX();
                    audio_play_sound(Sound_TextDone, 1, false);
                    break;
                
                case UnknownEnum.Value_2:
                    global.Users[global.UserIndex].Prefs[UnknownEnum.Value_1] = !global.Users[global.UserIndex].Prefs[UnknownEnum.Value_1];
                    User_UpdateMusicSFX();
                    audio_play_sound(Sound_TextDone, 1, false);
                    break;
                
                case UnknownEnum.Value_3:
                    global.Users[global.UserIndex].Prefs[UnknownEnum.Value_2] = !global.Users[global.UserIndex].Prefs[UnknownEnum.Value_2];
                    audio_play_sound(Sound_TextDone, 1, false);
                    break;
                
                case UnknownEnum.Value_4:
                    global.Users[global.UserIndex].Prefs[UnknownEnum.Value_3] = !global.Users[global.UserIndex].Prefs[UnknownEnum.Value_3];
                    audio_play_sound(Sound_TextDone, 1, false);
                    break;
                
                case UnknownEnum.Value_5:
                    global.Users[global.UserIndex].Prefs[UnknownEnum.Value_4] = !global.Users[global.UserIndex].Prefs[UnknownEnum.Value_4];
                    audio_play_sound(Sound_TextDone, 1, false);
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_2:
            switch (SelectorPos)
            {
                case UnknownEnum.Value_0:
                    Index = UnknownEnum.Value_0;
                    SelectorPos = 0;
                    audio_play_sound(Sound_Throw, 1, false);
                    break;
                
                case UnknownEnum.Value_1:
                    Music_Stop();
                    audio_stop_all();
                    audio_play_sound(Sound_TextDone, 1, false);
                    Quitting = true;
                    alarm[0] = QuitDelay;
                    break;
            }
            
            break;
    }
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
