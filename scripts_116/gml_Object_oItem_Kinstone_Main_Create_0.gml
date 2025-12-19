vx = 0;
vy = 0;
vx_Other = 0;
vy_Other = 0;
t = 0;
BaseX = x;
BaseY = y;
BaseX_Other = x;
BaseY_Other = y;
SpriteY = y;
SpriteY_Other = y;
WaypointX = 0;
WaypointY = 0;
WaypointX_Other = 0;
WaypointY_Other = 0;
Merge = false;
MergeConnected = false;
ConnectSound = false;
PoofInst = -4;
TreasureLightDim = false;
TreasureLightColor = 0.6;
LightStr = 2;
LightY = y;
LightY_Treasure = y + 24;
LightIndex = Lighting_CreateLight(RoomIndex, x, y, LightStr, [1, 1, 1]);
KinstoneMain_SetIndex(Index);
State = UnknownEnum.Value_0;
DB_Init = false;
FuseInit = false;

function DBScriptFunction_KinstoneMatch()
{
    return Inventory_ItemIndexExists(UnknownEnum.Value_23, Index) != -1;
}

Dialogue_Match = "Match found! Fuse kinstone?";
Dialogue_NoMatch = "No matching kinstones found.";
DB_Script = ds_grid_create(4, 5);
var i = 0;
var Addr = 0;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_5);
ds_grid_set(DB_Script, ++i, Addr, method(self, DBScriptFunction_KinstoneMatch));
ds_grid_set(DB_Script, ++i, Addr, 1);
ds_grid_set(DB_Script, ++i, Addr, 2);
i = 0;
Addr = 1;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_1);
ds_grid_set(DB_Script, ++i, Addr, Dialogue_Match);
ds_grid_set(DB_Script, ++i, Addr, 4);
ds_grid_set(DB_Script, ++i, Addr, 3);
i = 0;
Addr = 2;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_0);
ds_grid_set(DB_Script, ++i, Addr, Dialogue_NoMatch);
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
    Value_7 = 7,
    Value_23 = 23
}
