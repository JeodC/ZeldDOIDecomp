global.StatCount = 8;
global.PrefCount = 8;
global.MaxUsers = 5;
global.UserIndex = 0;
global.StatsToAdd = array_create(global.StatCount);

function User_Create() constructor
{
    Name = "";
    Prefs = User_DefaultPref();
    Stats = array_create(global.StatCount);
    SaveData = -1;
    DungeonSeq = array_create(6);
    DungeonSeqIndex = array_create(6);
    InputProfile_Gamepad = input_profile_export("gamepad", undefined, false);
    InputProfile_Keyboard = input_profile_export("keyboard", undefined, false);
    UsedFortuneTellerReadings = [];
    UsedCatacombGraveHeadings = [];
}

function User_VerifyIntegrity()
{
    var User = global.Users[global.UserIndex];
    
    if (!variable_struct_exists(User, "Name"))
        User.Name = "";
    
    if (variable_struct_exists(User, "Prefs"))
    {
        var _Prefs = array_length(User.Prefs);
        
        if (_Prefs < global.PrefCount)
        {
            for (var i = 0; i < (global.PrefCount - _Prefs); i++)
                array_push(User.Prefs, false);
        }
    }
    else
    {
        User.Prefs = User_DefaultPref();
    }
    
    if (variable_struct_exists(User, "Stats"))
    {
        var _Stats = array_length(User.Stats);
        
        if (_Stats < global.StatCount)
        {
            for (var i = 0; i < (global.StatCount - _Stats); i++)
                array_push(User.Stats, 0);
        }
    }
    else
    {
        User.Stats = array_create(global.StatCount);
    }
    
    if (variable_struct_exists(User, "SaveData"))
    {
        if (is_struct(User.SaveData))
        {
            if (!variable_struct_exists(User.SaveData, "Level"))
                User.SaveData.Level = 0;
            
            if (!variable_struct_exists(User.SaveData, "LinkCharacterIndex"))
                User.SaveData.LinkCharacterIndex = 0;
            
            if (!variable_struct_exists(User.SaveData, "ItemData"))
                User.SaveData.ItemData = 0;
            
            if (!variable_struct_exists(User.SaveData, "Inventory"))
                User.SaveData.Inventory = 0;
            
            if (!variable_struct_exists(User.SaveData, "Inventory_ItemData"))
                User.SaveData.Inventory_ItemData = 0;
            
            if (!variable_struct_exists(User.SaveData, "Inventory_SlotIndexEquiped"))
                User.SaveData.Inventory_SlotIndexEquiped = 0;
            
            if (!variable_struct_exists(User.SaveData, "Challenges"))
                User.SaveData.Challenges = 0;
            
            if (!variable_struct_exists(User.SaveData, "Cursed"))
                User.SaveData.Cursed = false;
            
            if (!variable_struct_exists(User.SaveData, "CurseEffect"))
                User.SaveData.CurseEffect = 0;
            
            if (!variable_struct_exists(User.SaveData, "CurseEffectStr"))
                User.SaveData.CurseEffectStr = "";
            
            if (!variable_struct_exists(User.SaveData, "CurseTask"))
                User.SaveData.CurseTask = 0;
            
            if (!variable_struct_exists(User.SaveData, "CurseTaskStr"))
                User.SaveData.CurseTaskStr = "";
            
            if (!variable_struct_exists(User.SaveData, "CurseTaskItem"))
                User.SaveData.CurseTaskItem = -1;
            
            if (!variable_struct_exists(User.SaveData, "CurseTaskCount"))
                User.SaveData.CurseTaskCount = 0;
            
            if (!variable_struct_exists(User.SaveData, "CurseLastEffect"))
                User.SaveData.CurseLastEffect = 0;
            
            if (!variable_struct_exists(User.SaveData, "CurseLastTask"))
                User.SaveData.CurseLastTask = 0;
            
            if (!variable_struct_exists(User.SaveData, "CurseLastTaskItem"))
                User.SaveData.CurseLastTaskItem = 0;
            
            if (!variable_struct_exists(User.SaveData, "CurseHealthDrainAlarm"))
                User.SaveData.CurseHealthDrainAlarm = -1;
            
            if (!variable_struct_exists(User.SaveData, "BossesDefeated"))
                User.SaveData.BossesDefeated = 0;
            
            if (!variable_struct_exists(User.SaveData, "TimePlayed"))
                User.SaveData.TimePlayed = 0;
            
            if (!variable_struct_exists(User.SaveData, "Swordless"))
                User.SaveData.Swordless = 0;
            
            if (!variable_struct_exists(User.SaveData, "BonusItem"))
                User.SaveData.BonusItem = 0;
            
            if (!variable_struct_exists(User.SaveData, "GameVersion"))
                User.SaveData.GameVersion = "";
        }
    }
    else
    {
        User.SaveData = -1;
    }
    
    if (!variable_struct_exists(User, "DungeonSeq"))
        User.DungeonSeq = array_create(6);
    
    if (!variable_struct_exists(User, "DungeonSeqIndex"))
        User.DungeonSeqIndex = array_create(6);
    
    if (!variable_struct_exists(User, "InputProfile_Gamepad"))
        User.InputProfile_Gamepad = input_profile_export("gamepad", undefined, false);
    
    if (!variable_struct_exists(User, "InputProfile_Keyboard"))
        User.InputProfile_Keyboard = input_profile_export("keyboard", undefined, false);
    
    if (!variable_struct_exists(User, "UsedFortuneTellerReadings"))
        User.UsedFortuneTellerReadings = [];
    
    if (!variable_struct_exists(User, "UsedCatacombGraveHeadings"))
        User.UsedCatacombGraveHeadings = [];
    
    User_Save();
}

function User_SaveDataStruct() constructor
{
    Level = 0;
    LinkCharacterIndex = 0;
    ItemData = 0;
    Inventory = 0;
    Inventory_ItemData = 0;
    Inventory_SlotIndexEquiped = 0;
    Challenges = 0;
    Cursed = false;
    CurseEffect = 0;
    CurseEffectStr = "";
    CurseTask = 0;
    CurseTaskStr = "";
    CurseTaskItem = -1;
    CurseTaskCount = 0;
    CurseLastEffect = -1;
    CurseLastTask = -1;
    CurseLastTaskItem = -1;
    CurseHealthDrainAlarm = -1;
    BossesDefeated = 0;
    TimePlayed = 0;
    Swordless = false;
    BonusItem = UnknownEnum.Value_0;
    GameVersion = "";
}

function User_SaveGame()
{
    if (global.Users[global.UserIndex].SaveData != -1)
        global.Users[global.UserIndex].SaveData = undefined;
    
    global.Users[global.UserIndex].SaveData = new User_SaveDataStruct();
    global.Users[global.UserIndex].SaveData.Level = global.Level.Index;
    global.Users[global.UserIndex].SaveData.LinkCharacterIndex = global.LinkCharacterIndex;
    global.Users[global.UserIndex].SaveData.ItemData = StructCopy(global.ItemData);
    global.Users[global.UserIndex].SaveData.Inventory = StructCopy(global.Inventory);
    global.Users[global.UserIndex].SaveData.Inventory_ItemData = StructCopy(global.Inventory_ItemData);
    global.Users[global.UserIndex].SaveData.Inventory_SlotIndexEquiped = global.Inventory_SlotIndex_Equiped;
    global.Users[global.UserIndex].SaveData.Challenges = StructCopy(global.Challenges);
    global.Users[global.UserIndex].SaveData.Cursed = global.Cursed;
    global.Users[global.UserIndex].SaveData.CurseEffect = global.CurseEffect;
    global.Users[global.UserIndex].SaveData.CurseEffectStr = global.CurseEffectStr;
    global.Users[global.UserIndex].SaveData.CurseTask = global.CurseTask;
    global.Users[global.UserIndex].SaveData.CurseTaskStr = global.CurseTaskStr;
    global.Users[global.UserIndex].SaveData.CurseTaskItem = global.CurseTaskItem;
    global.Users[global.UserIndex].SaveData.CurseTaskCount = global.CurseTaskCount;
    global.Users[global.UserIndex].SaveData.CurseLastEffect = global.CurseLastEffect;
    global.Users[global.UserIndex].SaveData.CurseLastTask = global.CurseLastTask;
    global.Users[global.UserIndex].SaveData.CurseLastTaskItem = global.CurseLastTaskItem;
    global.Users[global.UserIndex].SaveData.CurseHealthDrainAlarm = oLink.alarm[3];
    global.Users[global.UserIndex].SaveData.BossesDefeated = oHUD.BossesDefeated;
    global.Users[global.UserIndex].SaveData.TimePlayed = Time_PlayingTotal();
    global.Users[global.UserIndex].SaveData.Swordless = global.Swordless;
    global.Users[global.UserIndex].SaveData.BonusItem = global.StartingGear;
    global.Users[global.UserIndex].SaveData.GameVersion = "1.1.6 - VM";
    User_UpdateStats();
    User_Save();
}

function User_LoadGame()
{
    global.ContinueLevel = global.Users[global.UserIndex].SaveData.Level;
    global.LinkCharacterIndex = global.Users[global.UserIndex].SaveData.LinkCharacterIndex;
    
    with (oLink)
        Link_LoadCharacterIndex();
    
    global.ItemData = StructCopy(global.Users[global.UserIndex].SaveData.ItemData);
    global.Inventory = StructCopy(global.Users[global.UserIndex].SaveData.Inventory);
    global.Inventory_ItemData = StructCopy(global.Users[global.UserIndex].SaveData.Inventory_ItemData);
    global.StartingGear = global.Users[global.UserIndex].SaveData.BonusItem;
    Inventory_CalculateSlotIndexes();
    global.Inventory_SlotIndex_Equiped = global.Users[global.UserIndex].SaveData.Inventory_SlotIndexEquiped;
    
    if (global.Inventory_ItemData[UnknownEnum.Value_0].Owns[0])
        global.ItemData[UnknownEnum.Value_1].Type = UnknownEnum.Value_0;
    
    global.Challenges = StructCopy(global.Users[global.UserIndex].SaveData.Challenges);
    global.Cursed = global.Users[global.UserIndex].SaveData.Cursed;
    global.CurseEffect = global.Users[global.UserIndex].SaveData.CurseEffect;
    global.CurseEffectStr = global.Users[global.UserIndex].SaveData.CurseEffectStr;
    global.CurseTask = global.Users[global.UserIndex].SaveData.CurseTask;
    global.CurseTaskStr = global.Users[global.UserIndex].SaveData.CurseTaskStr;
    global.CurseTaskItem = global.Users[global.UserIndex].SaveData.CurseTaskItem;
    global.CurseTaskCount = global.Users[global.UserIndex].SaveData.CurseTaskCount;
    global.CurseLastEffect = global.Users[global.UserIndex].SaveData.CurseLastEffect;
    global.CurseLastTask = global.Users[global.UserIndex].SaveData.CurseLastTask;
    global.CurseLastTaskItem = global.Users[global.UserIndex].SaveData.CurseLastTaskItem;
    
    if (Curse_Check(UnknownEnum.Value_5))
        oLink.alarm[3] = global.Users[global.UserIndex].SaveData.CurseHealthDrainAlarm;
    
    oHUD.BossesDefeated = global.Users[global.UserIndex].SaveData.BossesDefeated;
    global.Time_PlayingTotalSaved = global.Users[global.UserIndex].SaveData.TimePlayed;
    global.Swordless = global.Users[global.UserIndex].SaveData.Swordless;
    Link_UpdateAttackDefence();
}

function User_DelSaveData()
{
    global.Users[global.UserIndex].SaveData = undefined;
    global.Users[global.UserIndex].SaveData = -1;
}

function DungeonSeq_Randomize(arg0)
{
    var _SeqArray = global.Users[global.UserIndex].DungeonSeq[arg0];
    var _SeqSize = array_length(_SeqArray);
    var A_Size_L = ceil(_SeqSize / 2);
    var A_Size_R = _SeqSize - A_Size_L;
    var CentreW = floor(_SeqSize / 12) * 2;
    var CentreSideW = ceil(CentreW / 2);
    array_shuffle_ext(_SeqArray, 0, A_Size_L);
    array_shuffle_ext(_SeqArray, A_Size_L, A_Size_R);
    array_shuffle_ext(_SeqArray, A_Size_L - CentreSideW, CentreW);
    User_Save();
}

function DungeonSeq_Init(arg0)
{
    for (var _DungeonClass = 0; _DungeonClass < 6; _DungeonClass++)
    {
        var _Dungeons = array_length(global.Templates_Dungeon[_DungeonClass][0]);
        global.Users[arg0].DungeonSeq[_DungeonClass] = array_create_sequence_shuffled(0, _Dungeons - 1);
        global.Users[arg0].DungeonSeqIndex[_DungeonClass] = 0;
    }
}

function User_DefaultPref()
{
    return [true, true, true, false, true, false, false, false];
}

function User_Save()
{
    var Buffer = EncodeDataToBuffer(global.Users);
    
    if (file_exists("Users_Temp"))
        file_delete("Users_Temp");
    
    if (file_exists("Users"))
    {
        file_copy("Users", "Users_Temp");
        var _FileSaved = xzip_write("Users_Temp", Buffer, "UserData");
        
        if (_FileSaved)
        {
            file_delete("Users");
            file_rename("Users_Temp", "Users");
        }
        else
        {
            file_delete("Users_Temp");
        }
    }
    
    buffer_delete(Buffer);
}

function User_UpdateStats()
{
    var _UserStats = global.Users[global.UserIndex].Stats;
    _UserStats[UnknownEnum.Value_0] += global.StatsToAdd[UnknownEnum.Value_0];
    _UserStats[UnknownEnum.Value_1] += global.StatsToAdd[UnknownEnum.Value_1];
    _UserStats[UnknownEnum.Value_2] += global.StatsToAdd[UnknownEnum.Value_2];
    _UserStats[UnknownEnum.Value_3] += global.StatsToAdd[UnknownEnum.Value_3];
    _UserStats[UnknownEnum.Value_4] += global.StatsToAdd[UnknownEnum.Value_4];
    _UserStats[UnknownEnum.Value_5] += global.StatsToAdd[UnknownEnum.Value_5];
    
    if (global.Time_PlayingTotalEnd != 0)
    {
        if (_UserStats[UnknownEnum.Value_6] == 0 || global.Time_PlayingTotalEnd < _UserStats[UnknownEnum.Value_6])
            _UserStats[UnknownEnum.Value_6] = global.Time_PlayingTotalEnd;
    }
    
    global.StatsToAdd = 0;
    global.StatsToAdd = array_create(global.StatCount);
}

function User_SaveStats()
{
    User_UpdateStats();
    User_Save();
}

function User_SaveControls()
{
    global.Users[global.UserIndex].InputProfile_Gamepad = input_profile_export("gamepad", undefined, false);
    global.Users[global.UserIndex].InputProfile_Keyboard = input_profile_export("keyboard", undefined, false);
    User_Save();
}

function User_Delete()
{
    array_delete(global.Users, global.UserIndex, 1);
    array_insert(global.Users, global.UserIndex, new User_Create());
    User_Save();
}

function User_UpdateMusicSFX()
{
    var _Music = global.Users[global.UserIndex].Prefs[UnknownEnum.Value_1];
    var _SFX = global.Users[global.UserIndex].Prefs[UnknownEnum.Value_0];
    audio_group_set_gain(Music_Boss_Final_Intro, _Music ? global.MusicVol : 0, 0);
    audio_group_set_gain(Music_Boss_Final_Hallway, _SFX ? global.SFXVol : 0, 0);
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
