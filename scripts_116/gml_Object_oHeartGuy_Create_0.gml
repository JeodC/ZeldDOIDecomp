visible = false;
FlyingFrame = 0;
FloorLevel = GetFloorLevelID(x, y);
FloorLevelStr = GetFloorLevelString(FloorLevel);
z = 5;
sprite_index = asset_get_index("sHeartGuy" + string(Type));

if (Type == 2)
    image_speed /= 2;

Disappear = false;
Disappeared = false;
DB_Init = false;
DB_Started = false;

function DBScriptFunction_HeartGuy()
{
    return global.Inventory_ItemData[UnknownEnum.Value_17].Amount >= 3;
}

function DBScriptFunction_MagicGuy()
{
    return global.Inventory_ItemData[UnknownEnum.Value_26].Amount > 33;
}

Dialogue_HeartGuy = "Hi, I'm fealing weak, can you\\spare me 3/4 of your health?\\I'll give you all of my rupees\\in exchange.";
Dialogue_HeartGuy_NotEnough = "Hi, I'm looking to buy health from someone. Looks like you don't have enough to spare. Come back when you have more.";
Dialogue_MagicGuy = "Hi, I'm fealing weak, can you\\spare me all of your magic?\\I'll give you all of my rupees\\in exchange.";
Dialogue_MagicGuy_NotEnough = "Hi, I'm looking to buy magic from someone. Looks like you don't have enough to spare. Come back when you have more.";
Dialogue_ThanksSucker = "Haha, thanks sucker!";
Dialogue_BeatIt = "Fine, beat it kid";
DB_Script = ds_grid_create(5, 7);
var i = 0;
var Addr = 0;
var ScriptFunction = (Type == 1) ? DBScriptFunction_HeartGuy : DBScriptFunction_MagicGuy;
var Dialogue = (Type == 1) ? Dialogue_HeartGuy : Dialogue_MagicGuy;
var NotEnough = (Type == 1) ? Dialogue_HeartGuy_NotEnough : Dialogue_MagicGuy_NotEnough;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_5);
ds_grid_set(DB_Script, ++i, Addr, method(self, ScriptFunction));
ds_grid_set(DB_Script, ++i, Addr, 1);
ds_grid_set(DB_Script, ++i, Addr, 3);
i = 0;
Addr = 1;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_1);
ds_grid_set(DB_Script, ++i, Addr, Dialogue);
ds_grid_set(DB_Script, ++i, Addr, 2);
ds_grid_set(DB_Script, ++i, Addr, 4);
i = 0;
Addr = 2;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_0);
ds_grid_set(DB_Script, ++i, Addr, Dialogue_ThanksSucker);
ds_grid_set(DB_Script, ++i, Addr, 6);
i = 0;
Addr = 3;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_0);
ds_grid_set(DB_Script, ++i, Addr, NotEnough);
ds_grid_set(DB_Script, ++i, Addr, 5);
i = 0;
Addr = 4;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_0);
ds_grid_set(DB_Script, ++i, Addr, Dialogue_BeatIt);
ds_grid_set(DB_Script, ++i, Addr, 5);
i = 0;
Addr = 5;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_7);
ds_grid_set(DB_Script, ++i, Addr, 0);
i = 0;
Addr = 6;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_7);
ds_grid_set(DB_Script, ++i, Addr, 1);
i = 0;

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_5 = 5,
    Value_7 = 7,
    Value_17 = 17,
    Value_26 = 26
}
