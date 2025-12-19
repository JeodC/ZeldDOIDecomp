image_index = choose(0, 1, 2, 3);
FloorLevel = GetFloorLevelID(x, y);
FloorLevelStr = GetFloorLevelString(FloorLevel);
WallObj = WallObj_Create("Objs_" + FloorLevelStr, x - 8, y - 16, 2, 1);
ReceivedFood = false;
DB_Init = false;
DB_Started = false;

function DBScriptFunction_HungryGuy_ReceivedFood()
{
    return ReceivedFood;
}

function DBScriptFunction_HungryGuy()
{
    return Inventory_ItemClassExists(UnknownEnum.Value_13) || Inventory_ItemClassExists(UnknownEnum.Value_35) || Inventory_ItemIndexExists(UnknownEnum.Value_36, UnknownEnum.Value_4);
}

Dialogue_HungryGuy = "I'm very hungry and weak, will you spare me some of your food?";
Dialogue_HungryGuy_NotEnough = "I'm very hungry and weak. Please bring me some food if you find any.";
Dialogue_Thanks = "Thank you kind traveller! Here is some money.";
Dialogue_BeatIt = "Very well, hopefully I will survive the night.";
Dialogue_ReceivedFood = "I am full now, thank you for your generosity.";
DB_Script = ds_grid_create(5, 9);
var i = 0;
var Addr = 0;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_5);
ds_grid_set(DB_Script, ++i, Addr, method(self, DBScriptFunction_HungryGuy_ReceivedFood));
ds_grid_set(DB_Script, ++i, Addr, 3);
ds_grid_set(DB_Script, ++i, Addr, 1);
i = 0;
Addr = 1;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_5);
ds_grid_set(DB_Script, ++i, Addr, method(self, DBScriptFunction_HungryGuy));
ds_grid_set(DB_Script, ++i, Addr, 2);
ds_grid_set(DB_Script, ++i, Addr, 5);
i = 0;
Addr = 2;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_1);
ds_grid_set(DB_Script, ++i, Addr, Dialogue_HungryGuy);
ds_grid_set(DB_Script, ++i, Addr, 4);
ds_grid_set(DB_Script, ++i, Addr, 6);
i = 0;
Addr = 3;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_0);
ds_grid_set(DB_Script, ++i, Addr, Dialogue_ReceivedFood);
ds_grid_set(DB_Script, ++i, Addr, 7);
i = 0;
Addr = 4;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_0);
ds_grid_set(DB_Script, ++i, Addr, Dialogue_Thanks);
ds_grid_set(DB_Script, ++i, Addr, 8);
i = 0;
Addr = 5;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_0);
ds_grid_set(DB_Script, ++i, Addr, Dialogue_HungryGuy_NotEnough);
ds_grid_set(DB_Script, ++i, Addr, 7);
i = 0;
Addr = 6;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_0);
ds_grid_set(DB_Script, ++i, Addr, Dialogue_BeatIt);
ds_grid_set(DB_Script, ++i, Addr, 7);
i = 0;
Addr = 7;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_7);
ds_grid_set(DB_Script, ++i, Addr, 0);
i = 0;
Addr = 8;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_7);
ds_grid_set(DB_Script, ++i, Addr, 1);
i = 0;

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_4 = 4,
    Value_5,
    Value_7 = 7,
    Value_13 = 13,
    Value_35 = 35,
    Value_36
}
