depth = -1000;
Alpha = 0;
AlphaSpeed = 0.18;
Slots = Inventory_MaxSlots();
SlotsPerRow = Inventory_SlotsPerRow();
SlotW = 22;
Rows = Slots / SlotsPerRow;
W = 12 + (SlotW * SlotsPerRow);
W_Gems = 12 + (SlotW * 2);
H = 22 + (Rows * SlotW);
H_Gems = 12 + (SlotW * 3);
X_NoGems = oCamera.X + round((oCamera.W - W) / 2);
X_WithGems = oCamera.X + round((oCamera.W - W - W_Gems) / 2);
X = global.Inventory_ShowGems ? X_WithGems : X_NoGems;
X_Gems = X_WithGems + W;
X_Cursed = oCamera.X + round((oCamera.W - 232) / 2);
DialogueBoxBuffer = 16;
Y = oCamera.Y + round((oCamera.H - H - 62 - DialogueBoxBuffer) / 2) + (24 / Rows);
Y_DialogueBox = Y + H + ((H >= H_Gems) ? (DialogueBoxBuffer - 8) : DialogueBoxBuffer);
Y_Curse = Y_DialogueBox + 5;
SlotsX_Gems = X_Gems + 7;
GemSlots = 6;
Open = true;
Close = false;
OpenGems = false;
CloseGems = false;
OpenGemSpeed = 6;
GemBagCount = Inventory_CountGemBag();

if (global.Inventory_SlotIndex_Selected >= global.Inventory_SlotIndex_Gems)
{
    if (GemBagCount == 0)
        global.Inventory_SlotIndex_Selected = global.Inventory_SlotIndex_GemBag;
}

Inventory_Defrag();

for (i = 0; i < global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_1]; i++)
{
    if (i <= global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_0])
    {
        global.Inventory[i].Enabled = false;
        
        if (i == global.Inventory_SlotIndex_ArrowQuiver && global.Inventory_ItemData[UnknownEnum.Value_0].Owns[0])
            global.Inventory[i].Enabled = true;
        
        if (i == global.Inventory_SlotIndex_BombBag && global.Inventory_ItemData[UnknownEnum.Value_4].Owns[0])
            global.Inventory[i].Enabled = true;
        
        if (i == global.Inventory_SlotIndex_GemBag && global.Inventory_ItemData[UnknownEnum.Value_15].Owns[0])
            global.Inventory[i].Enabled = true;
    }
    else
    {
        global.Inventory[i].Enabled = true;
    }
}

MenuEnable = false;
MenuItems = 4;
MenuItemGrid = ds_grid_create(2, MenuItems);
var i = 0;
ds_grid_set(MenuItemGrid, 0, i, "EQUIP");
ds_grid_set(MenuItemGrid, 1, i, true);
ds_grid_set(MenuItemGrid, 0, ++i, "USE");
ds_grid_set(MenuItemGrid, 1, i, true);
ds_grid_set(MenuItemGrid, 0, ++i, "DROP");
ds_grid_set(MenuItemGrid, 1, i, true);
ds_grid_set(MenuItemGrid, 0, ++i, "INFO");
ds_grid_set(MenuItemGrid, 1, i, true);
MenuSeperator = string_repeat(" ", 3);
MenuStr = "";
MenuItemPos[0] = 0;
draw_set_font(global.HUDFont2);

for (i = 0; i < MenuItems; i++)
{
    MenuItemW[i] = string_width(ds_grid_get(MenuItemGrid, 0, i));
    MenuStr += (ds_grid_get(MenuItemGrid, 0, i) + ((i < (MenuItems - 1)) ? MenuSeperator : ""));
    MenuItemPos[i + 1] = string_width(MenuStr);
}

MenuStrW = string_width(MenuStr);
MenuX = X + ((W - MenuStrW) / 2) + 1;
MenuY = (Y + H) - 13;
MenuSelectionIndex = 0;
audio_play_sound(Sound_Pickup, 1, false);
DB_Script = 0;
DB_Init = false;
DB_Started = false;

function DBScriptFunction_Inventory_ItemInfo()
{
    var _Slot = global.Inventory_SlotIndex_Selected;
    var _ItemClass = global.Inventory[_Slot].ItemClass;
    var _ItemIndex = global.Inventory[_Slot].ItemIndex;
    var _ItemAmount = global.Inventory[_Slot].Amount;
    return Item_Name(_ItemClass, _ItemIndex, _ItemAmount) + ":^" + Item_Info(_ItemClass, _ItemIndex);
}

DBScript_Info = ds_grid_create(3, 2);
i = 0;
var Addr = 0;
ds_grid_set(DBScript_Info, 0, Addr, UnknownEnum.Value_0);
ds_grid_set(DBScript_Info, ++i, Addr, method(self, DBScriptFunction_Inventory_ItemInfo));
ds_grid_set(DBScript_Info, ++i, Addr, 1);
i = 0;
Addr = 1;
ds_grid_set(DBScript_Info, 0, Addr, UnknownEnum.Value_7);
ds_grid_set(DBScript_Info, ++i, Addr, 0);
i = 0;
global.Paused = true;

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_4 = 4,
    Value_7 = 7,
    Value_15 = 15
}
