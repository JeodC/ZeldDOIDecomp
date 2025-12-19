MenuWin_Main_MenuIndex = UnknownEnum.Value_0;
MenuWin_Main_Active = true;
MenuWin_Main_X_Default = 144;
MenuWin_Main_X_End = 0;
MenuWin_Main_Shift = false;
MenuWin_Main_Shift_Dir = -1;
MenuWin_Main_Shift_V = 5;
MenuWin_Options_MenuIndex = UnknownEnum.Value_4;
MenuWin_Options_Active = false;
ErrorMsgInst = -4;
var _CreateNewFile = false;

if (file_exists("Users"))
{
    var Buffer = xzip_read("Users", "UserData");
    
    if (Buffer == -1)
    {
        ErrorMsgInst = MsgBox("Error reading User file, creating new file.", undefined, undefined, undefined, 80);
        _CreateNewFile = true;
    }
    else
    {
        var JSONStr = buffer_read(Buffer, buffer_string);
        buffer_delete(Buffer);
        global.Users = json_parse(JSONStr);
    }
}
else
{
    _CreateNewFile = true;
}

if (_CreateNewFile)
{
    global.Users = array_create(0);
    
    repeat (global.MaxUsers)
        array_insert(global.Users, array_length(global.Users), new User_Create());
    
    xzip_create("Users", "UserData");
    HighScores = array_create(8);
    HighScores[UnknownEnum.Value_0] = 5000;
    HighScores[UnknownEnum.Value_1] = 3000;
    HighScores[UnknownEnum.Value_2] = 100;
    var _Buffer = EncodeDataToBuffer(HighScores);
    xzip_write("Users", _Buffer, "AHS");
    buffer_delete(_Buffer);
    User_Save();
}

global.LinkCharacterIndex = 0;
var SprW = 16;
var SprH = 24;
var SprSurface = surface_create(SprW, SprH);
surface_set_target(SprSurface);

for (var _CharacterIndex = 0; _CharacterIndex < 9; _CharacterIndex++)
{
    var SpriteSheet = global.LinkCharacterSpr[_CharacterIndex];
    draw_clear_alpha(c_black, 0);
    draw_sprite_part(SpriteSheet, 0, 48, 16, 16, 16, 0, 8);
    draw_sprite_part(SpriteSheet, 0, 16, 0, 16, 16, 0, 0);
    
    if (_CharacterIndex == 0)
        global.CharacterSprites = sprite_create_from_surface(SprSurface, 0, 0, SprW, SprH, false, false, 0, 0);
    else
        sprite_add_from_surface(global.CharacterSprites, SprSurface, 0, 0, SprW, SprH, false, false);
}

surface_reset_target();
surface_free(SprSurface);
global.Challenges = array_create(7, false);
Selector_Index_Main = 0;
Selector_Index_Options = 0;
Selector_Frame = 0;
alarm[0] = 8;
LetterGridX = 0;
LetterGridY = 0;
NameEntryCross_X = 0;
NameEntryCross_Y = 0;
NameEntryCross_GridX = 0;
NameEntryCross_GridY = 0;
NameEntryCross_Move = false;
NameEntryCross_MoveV = 2;
NameEntryCross_MoveDirX = 0;
NameEntryCross_MoveDirY = 0;
NameEntryCross_MoveEndX = 0;
NameEntryCross_MoveEndY = 0;
NameEntryCross_ReboundX = false;
NameEntryCross_ReboundY = false;
NameEntry_Name = "";
NameEntry_Rename = false;
Bindings_Remap = false;
Bindings_GetIcons(UnknownEnum.Value_0);
Bindings_GetIcons(UnknownEnum.Value_1);
Menu_Create(UnknownEnum.Value_0, "Select User", undefined, undefined, undefined, "1.", "2.", "3.", "4.", "5.", "{s}Exit");
Menu_Create(UnknownEnum.Value_5, "Register Your Name", 24, false, undefined, "");
Menu_Create(UnknownEnum.Value_1, "", undefined, undefined, undefined, "New Game", "{s}Options", "{s}Stats", "{s}Back");
Menu_Create(UnknownEnum.Value_2, "", undefined, undefined, undefined, "Continue", "{s}New Game", "{s}Options", "{s}Stats", "{s}Back");
Menu_Create(UnknownEnum.Value_3, "Start Game", 18, undefined, undefined, "Start", "{s}Character", "{s}Bonus Item", "{s}Challenges", "{s}Back");
Menu_Create(UnknownEnum.Value_9, "Select a Character", 18, false, undefined, "");
Menu_Create(UnknownEnum.Value_10, "Pick a Bonus Item", 18, undefined, 16, "None", "100 Rupees", "+1 Inv Slot", "+1 Health", "Wooden Shield", "Rod of Stone", "10 Fire Orbs", "Antidote");
Menu_Create(UnknownEnum.Value_11, "Enable Challenges", 18, undefined, undefined, "Back", "Low Health", "Tiny Inventory", "Tough Enemies", "No Map", "Pitch Black", "No Shops", "Curses Galore");
Menu_Create(UnknownEnum.Value_4, "Options", undefined, undefined, undefined, "Back", "{s}Controls", "{s}User");
Menu_Create(UnknownEnum.Value_12, "Controls", 30, undefined, undefined, "Back", "{s}Gamepad", "{s}Keyboard");
Menu_Create(UnknownEnum.Value_13, "Gamepad", 25, undefined, undefined, "Back", "Remap", "Default");
Menu_Create(UnknownEnum.Value_14, "Keyboard", 25, undefined, undefined, "Back", "Remap", "Default");
Menu_Create(UnknownEnum.Value_6, "User", undefined, undefined, undefined, "Back", "{s}Rename", "{s}Delete");
Menu_Create(UnknownEnum.Value_7, "Delete?", 10, undefined, undefined, "No", "Yes");
Menu_Create(UnknownEnum.Value_8, "Stats", 22, false, undefined, "");
Win_Main_Activate(MenuWin_Main_MenuIndex);
depth = -100;
var MenuMusic = audio_play_sound(Music_Fairy_Main, 1, true);
audio_sound_gain(MenuMusic, 0.5, 0);

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
