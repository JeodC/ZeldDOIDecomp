FloorLevelStr = GetFloorLevelString(x, y);
FloorLevel = GetFloorLevelID(FloorLevelStr);
var WallInst = WallObj_Create("ObjsHigher_" + FloorLevelStr, x, y, 4, 4);
WallInst.FloorLevel = FloorLevel;
LightIndex = Lighting_CreateLight(RoomIndex, x + 13, y + 20, 0.4, [0.8, 0.8, 0.8]);
DB_Init = false;
DB_Started = false;

function DBScriptFunction_PopMachine_ItemName()
{
    return Item_Name(UnknownEnum.Value_35, 0) + ": " + "15" + " rupees";
}

function DBScriptFunction_PopMachine_ItemInfo()
{
    return Item_Info(UnknownEnum.Value_35, 0);
}

function DBScriptFunction_PopMachine_CheckCost()
{
    return global.Inventory_ItemData[UnknownEnum.Value_40].Amount >= 15;
}

DB_Script = ds_grid_create(5, 6);
var i = 0;
ds_grid_set(DB_Script, 0, 0, UnknownEnum.Value_2);
ds_grid_set(DB_Script, ++i, 0, "Can of Pop: 15 rupees");
ds_grid_set(DB_Script, ++i, 0, 1);
ds_grid_set(DB_Script, ++i, 0, 4);
ds_grid_set(DB_Script, ++i, 0, 3);
i = 0;
ds_grid_set(DB_Script, 0, 1, UnknownEnum.Value_5);
ds_grid_set(DB_Script, ++i, 1, method(self, DBScriptFunction_PopMachine_CheckCost));
ds_grid_set(DB_Script, ++i, 1, 5);
ds_grid_set(DB_Script, ++i, 1, 2);
i = 0;
ds_grid_set(DB_Script, 0, 2, UnknownEnum.Value_4);
ds_grid_set(DB_Script, ++i, 2, "You don't have enough rupees.");
ds_grid_set(DB_Script, ++i, 2, 4);
i = 0;
ds_grid_set(DB_Script, 0, 3, UnknownEnum.Value_0);
ds_grid_set(DB_Script, ++i, 3, method(self, DBScriptFunction_PopMachine_ItemInfo));
ds_grid_set(DB_Script, ++i, 3, 0);
i = 0;
ds_grid_set(DB_Script, 0, 4, UnknownEnum.Value_7);
ds_grid_set(DB_Script, ++i, 4, 0);
i = 0;
ds_grid_set(DB_Script, 0, 5, UnknownEnum.Value_7);
ds_grid_set(DB_Script, ++i, 5, 1);

enum UnknownEnum
{
    Value_0,
    Value_2 = 2,
    Value_4 = 4,
    Value_5,
    Value_7 = 7,
    Value_35 = 35,
    Value_40 = 40
}
