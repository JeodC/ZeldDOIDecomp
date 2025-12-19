image_index = choose(0, 1, 2, 3);
FloorLevel = GetFloorLevelID(x, y);
FloorLevelStr = GetFloorLevelString(FloorLevel);
WallObj = WallObj_Create("Objs_" + FloorLevelStr, x - 8, y - 16, 2, 1);
DB_Init = false;
DB_Started = false;

function DBScriptFunction_DeadGuy_CheckLoot()
{
    return ItemHolding != -1;
}

Dialogue_DeadGuy_Intro = "Looks like a dead explorer! Search his body for loot?";
Dialogue_DeadGuy_NoLoot = "Nothing was found.";
DB_Script = ds_grid_create(5, 5);
var i = 0;
var Addr = 0;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_1);
ds_grid_set(DB_Script, ++i, Addr, Dialogue_DeadGuy_Intro);
ds_grid_set(DB_Script, ++i, Addr, 1);
ds_grid_set(DB_Script, ++i, Addr, 3);
i = 0;
Addr = 1;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_5);
ds_grid_set(DB_Script, ++i, Addr, method(self, DBScriptFunction_DeadGuy_CheckLoot));
ds_grid_set(DB_Script, ++i, Addr, 4);
ds_grid_set(DB_Script, ++i, Addr, 2);
i = 0;
Addr = 2;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_0);
ds_grid_set(DB_Script, ++i, Addr, Dialogue_DeadGuy_NoLoot);
ds_grid_set(DB_Script, ++i, Addr, 3);
i = 0;
Addr = 3;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_7);
ds_grid_set(DB_Script, ++i, Addr, 0);
i = 0;
Addr = 4;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_7);
ds_grid_set(DB_Script, ++i, Addr, 1);
i = 0;

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_5 = 5,
    Value_7 = 7
}
