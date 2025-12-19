GenerateCurse();
Music_Mute(true);
audio_play_sound(Sound_Cursed, 1, false);

with (oLink)
    UpdateState(UnknownEnum.Value_0);

global.Paused = true;
DB_Script = 0;
DB_Init = false;
DB_Started = false;

function DBScriptFunction_Cursed_Info()
{
    if (Pendant_Check(UnknownEnum.Value_6))
        return "Curse blocked by the Pendant of Immunity!";
    else
        return "Oh No! You have been cursed!\\Effect: " + global.CurseEffectStr + "\\Task: " + string_replace(global.CurseTaskStr, ".", "") + " to\\remove the curse.";
}

DB_Script = ds_grid_create(3, 2);
var i = 0;
var Addr = 0;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_0);
ds_grid_set(DB_Script, ++i, Addr, method(self, DBScriptFunction_Cursed_Info));
ds_grid_set(DB_Script, ++i, Addr, 1);
i = 0;
Addr = 1;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_7);
ds_grid_set(DB_Script, ++i, Addr, 0);

enum UnknownEnum
{
    Value_0,
    Value_6 = 6,
    Value_7
}
