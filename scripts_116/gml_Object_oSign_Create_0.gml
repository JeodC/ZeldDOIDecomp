DB_Init = false;
DB_Started = false;
Dialogue = "";
Active = true;
Hidden = false;
FloorLevel = GetFloorLevelID(x, y);
FloorLevelStr = GetFloorLevelString(FloorLevel);
WallObj = WallObj_Create("Objs_" + FloorLevelStr, x - 8, y - 16, 2, 2);
DB_Script = ds_grid_create(3, 2);
var i = 0;
var Addr = 0;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_0);
ds_grid_set(DB_Script, ++i, Addr, Dialogue);
ds_grid_set(DB_Script, ++i, Addr, 1);
i = 0;
Addr = 1;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_7);
ds_grid_set(DB_Script, ++i, Addr, 0);
i = 0;

enum UnknownEnum
{
    Value_0,
    Value_7 = 7
}
