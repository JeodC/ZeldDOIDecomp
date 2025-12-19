FloorLevel = GetFloorLevelID(x, y);
Speed = 0.25;
Dir = choose(-1, 1);
ChangeDirAlarmMin = 60;
ChangeDirAlarmMax = 160;
GaveLetter = false;
GaveRupees = false;
GotFortune = false;
sprite_index = asset_get_index("sPrisoner" + string(Index));
State = Prisoner_GetMainStateForIndex();
alarm[0] = irandom_range(ChangeDirAlarmMin, ChangeDirAlarmMax);
DB_Init = false;
DB_Started = false;
Dialogue = global.Dialogue_Prisoner[Index];
DialogueSentence = 0;

function ScriptFunction_Letter()
{
    return Index == UnknownEnum.Value_0 && !GaveLetter;
}

function ScriptFunction_GaveRupees()
{
    return Index == UnknownEnum.Value_1 && GaveRupees;
}

function ScriptFunction_Dialogue_Prisoner()
{
    if (GaveLetter)
    {
        return global.Dialogue_Prisoner_GaveLetter;
    }
    else if (GotFortune)
    {
        return global.Dialogue_Prisoner_GotFortune;
    }
    else
    {
        switch (Index)
        {
            case UnknownEnum.Value_9:
                var _FortuneIndex = DialogueCycle(global.Dialogue_Prisoner[UnknownEnum.Value_9], global.Users[global.UserIndex].UsedFortuneTellerReadings);
                GotFortune = true;
                return "Here is your fortune: " + global.Dialogue_Prisoner[UnknownEnum.Value_9][_FortuneIndex];
                break;
            
            default:
                if (DialogueSentence >= (array_length(Dialogue) - (ScriptFunction_GaveRupees() ? 1 : 0)))
                    DialogueSentence = 0;
                
                return Dialogue[DialogueSentence++];
                break;
        }
    }
}

DB_Script = ds_grid_create(5, 8);
var i = 0;
var Addr = 0;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_5);
ds_grid_set(DB_Script, ++i, Addr, method(self, ScriptFunction_Letter));
ds_grid_set(DB_Script, ++i, Addr, 2);
ds_grid_set(DB_Script, ++i, Addr, 1);
i = 0;
Addr = 1;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_0);
ds_grid_set(DB_Script, ++i, Addr, method(self, ScriptFunction_Dialogue_Prisoner));
ds_grid_set(DB_Script, ++i, Addr, 6);
i = 0;
Addr = 2;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_1);
ds_grid_set(DB_Script, ++i, Addr, global.Dialogue_Prisoner_LetterIntro);
ds_grid_set(DB_Script, ++i, Addr, 3);
ds_grid_set(DB_Script, ++i, Addr, 5);
i = 0;
Addr = 3;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_1);
ds_grid_set(DB_Script, ++i, Addr, global.Dialogue_Prisoner_LetterYes1);
ds_grid_set(DB_Script, ++i, Addr, 4);
ds_grid_set(DB_Script, ++i, Addr, 5);
i = 0;
Addr = 4;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_0);
ds_grid_set(DB_Script, ++i, Addr, global.Dialogue_Prisoner_LetterYes2);
ds_grid_set(DB_Script, ++i, Addr, 7);
i = 0;
Addr = 5;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_0);
ds_grid_set(DB_Script, ++i, Addr, global.Dialogue_Prisoner_LetterNo);
ds_grid_set(DB_Script, ++i, Addr, 6);
i = 0;
Addr = 6;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_7);
ds_grid_set(DB_Script, ++i, Addr, 0);
i = 0;
Addr = 7;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_7);
ds_grid_set(DB_Script, ++i, Addr, 1);
i = 0;

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_5 = 5,
    Value_7 = 7,
    Value_9 = 9
}
