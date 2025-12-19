global.ChallengeTitles = array_create(7);
global.ChallengeTitles[UnknownEnum.Value_0] = "5 heart containers max";
global.ChallengeTitles[UnknownEnum.Value_1] = "Level 1 inventory max";
global.ChallengeTitles[UnknownEnum.Value_2] = "Enemies are tougher";
global.ChallengeTitles[UnknownEnum.Value_3] = "Map isn't visible";
global.ChallengeTitles[UnknownEnum.Value_4] = "No lights, no lamps";
global.ChallengeTitles[UnknownEnum.Value_5] = "No shops anywhere";
global.ChallengeTitles[UnknownEnum.Value_6] = "Higher risk of curses";
global.GearSprites = [sEmptyMask, 0, 0, 0, sItem_Rupee, 0, -1, -3, sItem_Bag, 0, 0, -1, sItem_HeartPiece, 0, 0, -2, sItem_Shield, 0, 0, -2, sItem_Rod, 0, 0, -1, sItem_Orb, UnknownEnum.Value_0, 0, -2, sItem_Potion, UnknownEnum.Value_3, 0, 0];
global.NewUserChrMap = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-", ".", ",", "!", "@", "#", "$", " ", " ", " ", " ", " ", " ", " ", " ", " "];
global.LetterGridSpacingW = 13;
global.LetterGridSpacingH = 18;
global.LetterGridColumns = 13;
global.LetterGridRows = 6;
global.MenuFont = font_add_sprite(sFont_Menu, 32, true, 0);
global.MenuFont_Innactive = font_add_sprite(sFont_Menu_Innactive, 32, true, 0);
global.MenuFont_Innactive2 = font_add_sprite(sFont_Menu_Innactive2, 32, true, 0);

function Menu_StartGame()
{
    audio_stop_all();
    audio_play_sound(Sound_TextDone, 1, false);
    room_goto(Room_Dungeon);
}

function Menu_ContinueGame()
{
    audio_stop_all();
    audio_play_sound(Sound_TextDone, 1, false);
    global.SaveLevel = true;
    global.Continue = true;
    room_goto(Room_Dungeon);
}

function Win_Main_Activate(arg0, arg1 = true)
{
    MenuWin_Main_Active = true;
    MenuWin_Main_MenuIndex = arg0;
    MenuWin_Main_X_End = MenuWin_Main_X_Default;
    MenuWin_Main_Shift = true;
    MenuWin_Main_Shift_Dir = 1;
    MenuWin_Options_Active = false;
    Menu_Active = false;
    Menu_ActiveIndex = arg0;
    inst_100004.sprite_index = sMenuWin;
    inst_100002.sprite_index = sMenuWin;
    inst_100005.visible = false;
    inst_100003.visible = false;
    
    if (arg1)
        Selector_Index_Main = 0;
}

function Win_Main_SetX(arg0)
{
    inst_100004.x = arg0;
    inst_100002.x = arg0;
}

function Win_Options_Activate(arg0)
{
    Menu_ActiveIndex = arg0;
    MenuWin_Options_MenuIndex = arg0;
    MenuWin_Options_Active = true;
    var ScrW = camera_get_view_width(view_camera[0]);
    inst_100005.W = Menu_TileW[arg0] * 8;
    MenuWin_Main_X_End = (ScrW - (inst_100004.W + inst_100005.W + 8)) / 2;
    inst_100005.x = MenuWin_Main_X_End + inst_100004.W + 8;
    inst_100003.W = inst_100005.W;
    inst_100003.x = inst_100005.x;
    inst_100004.sprite_index = sMenuWin_Innactive;
    inst_100002.sprite_index = sMenuWin_Innactive;
    inst_100005.visible = false;
    inst_100003.visible = false;
    MenuWin_Main_Active = false;
    MenuWin_Main_Shift = true;
    MenuWin_Main_Shift_Dir = (MenuWin_Main_X_End >= inst_100004.x) ? 1 : -1;
    Menu_Active = false;
    Selector_Index_Options = 0;
}

function Menu_Create(arg0, arg1, arg2 = 20, arg3 = true, arg4 = 16)
{
    Menu_Title[arg0] = arg1;
    Menu_TileW[arg0] = arg2;
    Menu_Selector[arg0] = arg3;
    
    for (var i = 0; i < (argument_count - 5); i++)
        Menu[arg0][i] = argument[5 + i];
    
    Menu_Count[arg0] = array_length(Menu[arg0]);
    Menu_Y[arg0][0] = 70;
    
    for (var i = 1; i < Menu_Count[arg0]; i++)
    {
        var YSpace = arg4;
        var Str = Menu[arg0][i];
        
        if (string_pos("{s}", Str) != 0)
        {
            Menu[arg0][i] = string_copy(Str, 4, string_length(Str) - 3);
            YSpace += 8;
        }
        
        Menu_Y[arg0][i] = Menu_Y[arg0][i - 1] + YSpace;
    }
}

function LetterGrid_Init()
{
    LetterGridX = inst_100005.x + 14;
    LetterGridY = inst_100005.y + 20;
    NameEntryCross_GridX = 0;
    NameEntryCross_GridY = 0;
    NameEntryCross_X = LetterGrid_GetX(NameEntryCross_GridX);
    NameEntryCross_Y = LetterGrid_GetY(NameEntryCross_GridY);
    NameEntryCross_MoveEndX = NameEntryCross_X;
    NameEntryCross_MoveEndY = NameEntryCross_Y;
    NameEntry_Name = "";
}

function LetterGrid_GetX(arg0)
{
    return LetterGridX + (arg0 * global.LetterGridSpacingW);
}

function LetterGrid_GetY(arg0)
{
    return LetterGridY + (arg0 * global.LetterGridSpacingH);
}

function LetterGrid_GetGridX(arg0)
{
    return floor((arg0 - LetterGridX) / global.LetterGridSpacingW);
}

function LetterGrid_GetGridY(arg0)
{
    return floor((arg0 - LetterGridY) / global.LetterGridSpacingH);
}

function LetterGrid_DrawCrossHair_H()
{
    draw_set_alpha(0.5);
    var _x = inst_100005.x + 6;
    
    while (_x < ((inst_100005.x + inst_100005.W) - 6))
    {
        draw_sprite(sPixel, 0, _x, NameEntryCross_Y + 8);
        _x++;
    }
    
    draw_set_alpha(1);
}

function LetterGrid_DrawCrossHair_V()
{
    draw_set_alpha(0.5);
    var _y = inst_100005.y + 6;
    
    while (_y < ((inst_100005.y + inst_100005.H) - 6))
    {
        draw_sprite(sPixel, 0, NameEntryCross_X + 3, _y);
        _y++;
    }
    
    draw_set_alpha(1);
}

function LetterGrid_GetLetter()
{
    return global.NewUserChrMap[(NameEntryCross_GridY * global.LetterGridColumns) + NameEntryCross_GridX];
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6
}
