AltTabCheck();

if (instance_exists(ErrorMsgInst))
    exit;

if (MenuWin_Main_Shift)
{
    var NewX = inst_100004.x + (MenuWin_Main_Shift_Dir * MenuWin_Main_Shift_V);
    
    if ((MenuWin_Main_Shift_Dir == 1 && NewX >= MenuWin_Main_X_End) || (MenuWin_Main_Shift_Dir == -1 && NewX <= MenuWin_Main_X_End))
    {
        NewX = MenuWin_Main_X_End;
        Menu_Active = true;
        MenuWin_Main_Shift = false;
    }
    
    Win_Main_SetX(NewX);
    
    if (MenuWin_Main_Shift)
        exit;
    
    if (MenuWin_Options_Active)
    {
        inst_100005.visible = true;
        inst_100003.visible = true;
    }
}

if (Menu_Active)
{
    switch (Menu_ActiveIndex)
    {
        default:
            if (MenuWin_Main_Active || (MenuWin_Options_Active && Menu_Selector[MenuWin_Options_MenuIndex]))
            {
                if (input_check_pressed("down"))
                {
                    if (MenuWin_Main_Active)
                        Selector_Index_Main = (Selector_Index_Main + 1) % Menu_Count[MenuWin_Main_MenuIndex];
                    
                    if (MenuWin_Options_Active)
                        Selector_Index_Options = (Selector_Index_Options + 1) % Menu_Count[MenuWin_Options_MenuIndex];
                    
                    audio_play_sound(Sound_Text, 1, false);
                }
                
                if (input_check_pressed("up"))
                {
                    if (MenuWin_Main_Active)
                    {
                        Selector_Index_Main--;
                        
                        if (Selector_Index_Main < 0)
                            Selector_Index_Main = Menu_Count[MenuWin_Main_MenuIndex] - 1;
                    }
                    
                    if (MenuWin_Options_Active)
                    {
                        Selector_Index_Options--;
                        
                        if (Selector_Index_Options < 0)
                            Selector_Index_Options = Menu_Count[MenuWin_Options_MenuIndex] - 1;
                    }
                    
                    audio_play_sound(Sound_Text, 1, false);
                }
            }
            
            break;
        
        case UnknownEnum.Value_9:
            if (input_check_pressed("up"))
            {
                global.LinkCharacterIndex -= 3;
                
                if (global.LinkCharacterIndex < 0)
                    global.LinkCharacterIndex += 9;
                
                audio_play_sound(Sound_Text, 1, false);
            }
            
            if (input_check_pressed("down"))
            {
                global.LinkCharacterIndex += 3;
                
                if (global.LinkCharacterIndex >= 9)
                    global.LinkCharacterIndex -= 9;
                
                audio_play_sound(Sound_Text, 1, false);
            }
            
            if (input_check_pressed("left"))
            {
                global.LinkCharacterIndex -= 1;
                
                if (global.LinkCharacterIndex < 0)
                    global.LinkCharacterIndex += 9;
                
                audio_play_sound(Sound_Text, 1, false);
            }
            
            if (input_check_pressed("right"))
            {
                global.LinkCharacterIndex = (global.LinkCharacterIndex + 1) % 9;
                
                if (global.LinkCharacterIndex >= 9)
                    global.LinkCharacterIndex -= 9;
                
                audio_play_sound(Sound_Text, 1, false);
            }
            
            break;
        
        case UnknownEnum.Value_5:
            var KeyUp = input_check("up");
            var KeyDown = input_check("down");
            var KeyLeft = input_check("left");
            var KeyRight = input_check("right");
            
            if (NameEntryCross_X != NameEntryCross_MoveEndX)
            {
                NameEntryCross_X += (NameEntryCross_MoveV * NameEntryCross_MoveDirX);
                
                switch (NameEntryCross_MoveDirX)
                {
                    case 1:
                        if (NameEntryCross_X >= NameEntryCross_MoveEndX)
                        {
                            if (KeyRight && LetterGrid_GetGridX(NameEntryCross_MoveEndX) < (global.LetterGridColumns - 1))
                            {
                                NameEntryCross_MoveEndX += global.LetterGridSpacingW;
                            }
                            else
                            {
                                NameEntryCross_X = NameEntryCross_MoveEndX;
                                NameEntryCross_ReboundX = false;
                            }
                        }
                        else if (!KeyRight && !NameEntryCross_ReboundX && NameEntryCross_X <= (NameEntryCross_MoveEndX - 8))
                        {
                            NameEntryCross_MoveEndX -= global.LetterGridSpacingW;
                            NameEntryCross_MoveDirX = -1;
                            NameEntryCross_ReboundX = true;
                        }
                        
                        break;
                    
                    case -1:
                        if (NameEntryCross_X <= NameEntryCross_MoveEndX)
                        {
                            if (KeyLeft && NameEntryCross_GridX > 0)
                            {
                                NameEntryCross_MoveEndX -= global.LetterGridSpacingW;
                            }
                            else
                            {
                                NameEntryCross_X = NameEntryCross_MoveEndX;
                                NameEntryCross_ReboundX = false;
                            }
                        }
                        else if (!KeyLeft && !NameEntryCross_ReboundX && NameEntryCross_X >= (NameEntryCross_MoveEndX + 8))
                        {
                            NameEntryCross_MoveEndX += global.LetterGridSpacingW;
                            NameEntryCross_MoveDirX = 1;
                            NameEntryCross_ReboundX = true;
                        }
                        
                        break;
                }
            }
            else
            {
                if (KeyRight && NameEntryCross_GridX < (global.LetterGridColumns - 1))
                {
                    NameEntryCross_MoveDirX = 1;
                    NameEntryCross_MoveEndX += global.LetterGridSpacingW;
                }
                
                if (KeyLeft && NameEntryCross_GridX > 0)
                {
                    NameEntryCross_MoveDirX = -1;
                    NameEntryCross_MoveEndX -= global.LetterGridSpacingW;
                }
            }
            
            if (NameEntryCross_Y != NameEntryCross_MoveEndY)
            {
                NameEntryCross_Y += (NameEntryCross_MoveV * NameEntryCross_MoveDirY);
                
                switch (NameEntryCross_MoveDirY)
                {
                    case 1:
                        if (NameEntryCross_Y >= NameEntryCross_MoveEndY)
                        {
                            if (KeyDown && LetterGrid_GetGridY(NameEntryCross_MoveEndY) < (global.LetterGridRows - 1))
                            {
                                NameEntryCross_MoveEndY += global.LetterGridSpacingH;
                            }
                            else
                            {
                                NameEntryCross_Y = NameEntryCross_MoveEndY;
                                NameEntryCross_ReboundY = false;
                            }
                        }
                        else if (!KeyDown && !NameEntryCross_ReboundY && NameEntryCross_Y <= (NameEntryCross_MoveEndY - 13))
                        {
                            NameEntryCross_MoveEndY -= global.LetterGridSpacingH;
                            NameEntryCross_MoveDirY = -1;
                            NameEntryCross_ReboundY = true;
                        }
                        
                        break;
                    
                    case -1:
                        if (NameEntryCross_Y <= NameEntryCross_MoveEndY)
                        {
                            if (KeyUp && NameEntryCross_GridY > 0)
                            {
                                NameEntryCross_MoveEndY -= global.LetterGridSpacingH;
                            }
                            else
                            {
                                NameEntryCross_Y = NameEntryCross_MoveEndY;
                                NameEntryCross_ReboundY = false;
                            }
                        }
                        else if (!KeyUp && !NameEntryCross_ReboundY && NameEntryCross_Y >= (NameEntryCross_MoveEndY + 13))
                        {
                            NameEntryCross_MoveEndY += global.LetterGridSpacingH;
                            NameEntryCross_MoveDirY = 1;
                            NameEntryCross_ReboundY = true;
                        }
                        
                        break;
                }
            }
            else
            {
                if (KeyDown && NameEntryCross_GridY < (global.LetterGridRows - 1))
                {
                    NameEntryCross_MoveDirY = 1;
                    NameEntryCross_MoveEndY += global.LetterGridSpacingH;
                }
                
                if (KeyUp && NameEntryCross_GridY > 0)
                {
                    NameEntryCross_MoveDirY = -1;
                    NameEntryCross_MoveEndY -= global.LetterGridSpacingH;
                }
            }
            
            NameEntryCross_GridX = LetterGrid_GetGridX(NameEntryCross_X);
            NameEntryCross_GridY = LetterGrid_GetGridY(NameEntryCross_Y);
            
            if (NameEntry_Name == "")
                Menu_Title[MenuWin_Options_MenuIndex] = "Register Your Name";
            else
                Menu_Title[MenuWin_Options_MenuIndex] = NameEntry_Name;
            
            if (input_check_pressed("menu_input"))
            {
                var Letter = LetterGrid_GetLetter();
                
                switch (Letter)
                {
                    default:
                        if (string_length(NameEntry_Name) < 8)
                        {
                            NameEntry_Name += Letter;
                            audio_play_sound(Sound_Text, 1, false);
                        }
                        
                        break;
                    
                    case "!":
                    case "@":
                        if (NameEntry_Name == "")
                        {
                            audio_play_sound(Sound_Error, 1, false);
                            break;
                        }
                        
                        if (NameEntry_Rename)
                        {
                            global.Users[global.UserIndex].Name = NameEntry_Name;
                        }
                        else
                        {
                            global.Users[global.UserIndex] = new User_Create();
                            global.Users[global.UserIndex].Name = NameEntry_Name;
                            DungeonSeq_Init(global.UserIndex);
                        }
                        
                        User_Save();
                        Win_Main_Activate(UnknownEnum.Value_0);
                        audio_play_sound(Sound_KinstoneConnect, 1, false);
                        Selector_Index_Main = global.UserIndex;
                        NameEntry_Rename = false;
                        break;
                    
                    case "#":
                    case "$":
                        Win_Main_Activate(UnknownEnum.Value_0);
                        audio_play_sound(Sound_Throw, 1, false);
                        break;
                }
                
                input_clear_momentary(true);
            }
            
            if (NameEntry_Name != "" && input_check_pressed("action"))
            {
                NameEntry_Name = string_copy(NameEntry_Name, 1, string_length(NameEntry_Name) - 1);
                audio_play_sound(Sound_Throw, 1, false);
            }
            
            break;
    }
    
    if (keyboard_check(vk_alt))
        exit;
    
    if (input_check_pressed("menu_input"))
    {
        switch (Menu_ActiveIndex)
        {
            case UnknownEnum.Value_0:
                if (Selector_Index_Main == (Menu_Count[UnknownEnum.Value_0] - 1))
                {
                    game_end();
                }
                else
                {
                    global.UserIndex = Selector_Index_Main;
                    
                    if (global.Users[global.UserIndex].Name == "")
                    {
                        Win_Options_Activate(UnknownEnum.Value_5);
                        audio_play_sound(Sound_TextDone, 1, false);
                        LetterGrid_Init();
                    }
                    else
                    {
                        User_VerifyIntegrity();
                        Win_Main_Activate((global.Users[global.UserIndex].SaveData == -1) ? UnknownEnum.Value_1 : UnknownEnum.Value_2);
                        Menu_Title[UnknownEnum.Value_2] = global.Users[global.UserIndex].Name;
                        Menu_Title[UnknownEnum.Value_1] = global.Users[global.UserIndex].Name;
                        input_profile_import(global.Users[global.UserIndex].InputProfile_Gamepad, "gamepad");
                        input_profile_import(global.Users[global.UserIndex].InputProfile_Keyboard, "keyboard");
                        Bindings_GetIcons(UnknownEnum.Value_0);
                        Bindings_GetIcons(UnknownEnum.Value_1);
                        audio_play_sound(Sound_TextDone, 1, false);
                    }
                }
                
                break;
            
            case UnknownEnum.Value_1:
                switch (Selector_Index_Main)
                {
                    case UnknownEnum.Value_0:
                        Win_Options_Activate(UnknownEnum.Value_3);
                        audio_play_sound(Sound_TextDone, 1, false);
                        break;
                    
                    case UnknownEnum.Value_1:
                        Win_Main_Activate(UnknownEnum.Value_4);
                        audio_play_sound(Sound_TextDone, 1, false);
                        break;
                    
                    case UnknownEnum.Value_2:
                        Win_Options_Activate(UnknownEnum.Value_8);
                        audio_play_sound(Sound_TextDone, 1, false);
                        break;
                    
                    case UnknownEnum.Value_3:
                        Win_Main_Activate(UnknownEnum.Value_0);
                        Selector_Index_Main = global.UserIndex;
                        audio_play_sound(Sound_Throw, 1, false);
                        break;
                }
                
                break;
            
            case UnknownEnum.Value_2:
                switch (Selector_Index_Main)
                {
                    case UnknownEnum.Value_0:
                        if ((global.SaveVersionCheck && global.Users[global.UserIndex].SaveData.GameVersion == "1.1.6 - VM") || !global.SaveVersionCheck)
                            Menu_ContinueGame();
                        else
                            ErrorMsgInst = MsgBox("Save file version error!\\Use the game version the save\\was created with.", undefined, Sound_Error, undefined, 80);
                        
                        break;
                    
                    case UnknownEnum.Value_1:
                        Win_Options_Activate(UnknownEnum.Value_3);
                        audio_play_sound(Sound_TextDone, 1, false);
                        break;
                    
                    case UnknownEnum.Value_2:
                        Win_Main_Activate(UnknownEnum.Value_4);
                        audio_play_sound(Sound_TextDone, 1, false);
                        break;
                    
                    case UnknownEnum.Value_3:
                        Win_Options_Activate(UnknownEnum.Value_8);
                        audio_play_sound(Sound_TextDone, 1, false);
                        break;
                    
                    case UnknownEnum.Value_4:
                        Win_Main_Activate(UnknownEnum.Value_0);
                        Selector_Index_Main = global.UserIndex;
                        audio_play_sound(Sound_Throw, 1, false);
                        break;
                }
                
                break;
            
            case UnknownEnum.Value_3:
                switch (Selector_Index_Options)
                {
                    case UnknownEnum.Value_0:
                        Menu_StartGame();
                        break;
                    
                    case UnknownEnum.Value_1:
                        Menu_ActiveIndex = UnknownEnum.Value_9;
                        MenuWin_Options_MenuIndex = UnknownEnum.Value_9;
                        Selector_Index_Options = 0;
                        audio_play_sound(Sound_TextDone, 1, false);
                        break;
                    
                    case UnknownEnum.Value_2:
                        Menu_ActiveIndex = UnknownEnum.Value_10;
                        MenuWin_Options_MenuIndex = UnknownEnum.Value_10;
                        Selector_Index_Options = 0;
                        audio_play_sound(Sound_TextDone, 1, false);
                        break;
                    
                    case UnknownEnum.Value_3:
                        Menu_ActiveIndex = UnknownEnum.Value_11;
                        MenuWin_Options_MenuIndex = UnknownEnum.Value_11;
                        Selector_Index_Options = 0;
                        audio_play_sound(Sound_TextDone, 1, false);
                        break;
                    
                    case UnknownEnum.Value_4:
                        Win_Main_Activate((global.Users[global.UserIndex].SaveData == -1) ? UnknownEnum.Value_1 : UnknownEnum.Value_2);
                        audio_play_sound(Sound_Throw, 1, false);
                        break;
                }
                
                break;
            
            case UnknownEnum.Value_8:
                Win_Main_Activate((global.Users[global.UserIndex].SaveData == -1) ? UnknownEnum.Value_1 : UnknownEnum.Value_2);
                audio_play_sound(Sound_Throw, 1, false);
                break;
            
            case UnknownEnum.Value_9:
                Menu_ActiveIndex = UnknownEnum.Value_3;
                MenuWin_Options_MenuIndex = UnknownEnum.Value_3;
                Selector_Index_Options = 0;
                audio_play_sound(Sound_TextDone, 1, false);
                break;
            
            case UnknownEnum.Value_10:
                Menu_ActiveIndex = UnknownEnum.Value_3;
                MenuWin_Options_MenuIndex = UnknownEnum.Value_3;
                global.StartingGear = Selector_Index_Options;
                Selector_Index_Options = 0;
                audio_play_sound(Sound_TextDone, 1, false);
                break;
            
            case UnknownEnum.Value_11:
                switch (Selector_Index_Options)
                {
                    case 0:
                        Menu_ActiveIndex = UnknownEnum.Value_3;
                        MenuWin_Options_MenuIndex = UnknownEnum.Value_3;
                        Selector_Index_Options = 0;
                        audio_play_sound(Sound_Throw, 1, false);
                        break;
                    
                    default:
                        global.Challenges[Selector_Index_Options - 1] = !global.Challenges[Selector_Index_Options - 1];
                        audio_play_sound(Sound_TextDone, 1, false);
                        break;
                }
                
                break;
            
            case UnknownEnum.Value_4:
                switch (Selector_Index_Main)
                {
                    case UnknownEnum.Value_0:
                        Win_Main_Activate((global.Users[global.UserIndex].SaveData == -1) ? UnknownEnum.Value_1 : UnknownEnum.Value_2);
                        audio_play_sound(Sound_Throw, 1, false);
                        break;
                    
                    case UnknownEnum.Value_1:
                        Win_Main_Activate(UnknownEnum.Value_12);
                        audio_play_sound(Sound_TextDone, 1, false);
                        break;
                    
                    case UnknownEnum.Value_2:
                        Win_Main_Activate(UnknownEnum.Value_6);
                        audio_play_sound(Sound_TextDone, 1, false);
                        break;
                }
                
                break;
            
            case UnknownEnum.Value_12:
                switch (Selector_Index_Main)
                {
                    case UnknownEnum.Value_0:
                        Win_Main_Activate(UnknownEnum.Value_4, false);
                        audio_play_sound(Sound_Throw, 1, false);
                        break;
                    
                    case UnknownEnum.Value_1:
                        Win_Options_Activate(UnknownEnum.Value_13);
                        audio_play_sound(Sound_TextDone, 1, false);
                        break;
                    
                    case UnknownEnum.Value_2:
                        Win_Options_Activate(UnknownEnum.Value_14);
                        audio_play_sound(Sound_TextDone, 1, false);
                        break;
                }
                
                break;
            
            case UnknownEnum.Value_13:
                switch (Selector_Index_Options)
                {
                    case UnknownEnum.Value_0:
                        Win_Main_Activate(UnknownEnum.Value_12, false);
                        audio_play_sound(Sound_Throw, 1, false);
                        break;
                    
                    case UnknownEnum.Value_1:
                        instance_create_layer(-100, -100, "Menu", oInputRemap, 
                        {
                            InputIndex: UnknownEnum.Value_0
                        });
                        break;
                    
                    case UnknownEnum.Value_2:
                        input_profile_reset_bindings("gamepad");
                        User_SaveControls();
                        Bindings_GetIcons(UnknownEnum.Value_0);
                        audio_play_sound(Sound_Throw, 1, false);
                        break;
                }
                
                break;
            
            case UnknownEnum.Value_14:
                switch (Selector_Index_Options)
                {
                    case UnknownEnum.Value_0:
                        Win_Main_Activate(UnknownEnum.Value_12, false);
                        audio_play_sound(Sound_Throw, 1, false);
                        break;
                    
                    case UnknownEnum.Value_1:
                        instance_create_layer(-100, -100, "Menu", oInputRemap, 
                        {
                            InputIndex: UnknownEnum.Value_1
                        });
                        break;
                    
                    case UnknownEnum.Value_2:
                        input_profile_reset_bindings("keyboard");
                        User_SaveControls();
                        Bindings_GetIcons(UnknownEnum.Value_1);
                        audio_play_sound(Sound_Throw, 1, false);
                }
                
                break;
            
            case UnknownEnum.Value_6:
                switch (Selector_Index_Main)
                {
                    case UnknownEnum.Value_0:
                        Win_Main_Activate(UnknownEnum.Value_4, false);
                        audio_play_sound(Sound_Throw, 1, false);
                        break;
                    
                    case UnknownEnum.Value_1:
                        NameEntry_Rename = true;
                        Win_Options_Activate(UnknownEnum.Value_5);
                        audio_play_sound(Sound_Throw, 1, false);
                        LetterGrid_Init();
                        break;
                    
                    case UnknownEnum.Value_2:
                        Win_Options_Activate(UnknownEnum.Value_7);
                        audio_play_sound(Sound_Throw, 1, false);
                        break;
                }
                
                break;
            
            case UnknownEnum.Value_7:
                switch (Selector_Index_Options)
                {
                    case UnknownEnum.Value_0:
                        Win_Main_Activate(UnknownEnum.Value_6, false);
                        audio_play_sound(Sound_Throw, 1, false);
                        break;
                    
                    case UnknownEnum.Value_1:
                        User_Delete();
                        Win_Main_Activate(UnknownEnum.Value_0, true);
                        audio_play_sound(Sound_KinstoneConnect, 1, false);
                }
                
                break;
        }
    }
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
    Value_8,
    Value_9,
    Value_10,
    Value_11,
    Value_12,
    Value_13,
    Value_14
}
