TileW = ShopW / 8;
TileH = ShopH / 8;
ShopKeeperInst = -4;
Slots = 0;
Inventory = 0;
ItemsSold = 0;
FloorLevel = GetFloorLevelID(x, y);
FloorLevelStr = GetFloorLevelString(FloorLevel);
Slots = global.Challenges[UnknownEnum.Value_5] ? 0 : Shop_GetSlotCount();
Inventory = array_create(Slots, -4);

if (ShopType == UnknownEnum.Value_0)
{
    ShopKeeperInst = instance_create_layer(x + (ShopW / 2), y + 21, "Objs_" + FloorLevelStr, oShopKeeper, 
    {
        ShopType: ShopType
    });
    
    if (global.Level.Index == UnknownEnum.Value_10)
    {
        ShopKeeperInst.sprite_index = sShopKeeper_Mines;
    }
    else if (global.Level.Index == UnknownEnum.Value_12 && !global.ShopkeeperJustin)
    {
        ShopKeeperInst.sprite_index = sShopKeeper_Justin;
        global.ShopkeeperJustin = true;
    }
    else
    {
        var ShopKeeperIndex;
        
        if (ds_list_size(global.UnusedShopKeepers) > 0)
        {
            ShopKeeperIndex = ds_list_find_value(global.UnusedShopKeepers, 0);
            ds_list_delete(global.UnusedShopKeepers, 0);
        }
        else
        {
            ShopKeeperIndex = irandom_range(0, 21);
        }
        
        ShopKeeperInst.sprite_index = asset_get_index("sShopKeeper" + string(ShopKeeperIndex));
    }
    
    ShopKeeperInst.ShopInst = id;
    
    if (global.Level.Rooms[RoomIndex].Lighting && !global.Challenges[UnknownEnum.Value_4])
    {
        var Torch1 = instance_create_layer(x, y, "Objs_" + FloorLevelStr, oTorch, 
        {
            RoomIndex: RoomIndex,
            Lit: true
        });
        var Torch2 = instance_create_layer((x + ShopW) - 16, y, "Objs_" + FloorLevelStr, oTorch, 
        {
            RoomIndex: RoomIndex,
            Lit: true
        });
        
        if (Slots == 2)
        {
            var NewRGB = Torch1.LightMaxRGB - 0.075;
            Lighting_UpdateLight_RGB(RoomIndex, Torch1.LightIndex, [NewRGB, NewRGB, NewRGB]);
            Lighting_UpdateLight_RGB(RoomIndex, Torch2.LightIndex, [NewRGB, NewRGB, NewRGB]);
        }
        
        if (Slots > 3)
        {
            var NewRGB = Torch1.LightMaxRGB + 0.1;
            Lighting_UpdateLight_RGB(RoomIndex, Torch1.LightIndex, [NewRGB, NewRGB, NewRGB]);
            Lighting_UpdateLight_RGB(RoomIndex, Torch2.LightIndex, [NewRGB, NewRGB, NewRGB]);
        }
    }
}

var _ItemList = ds_list_create();

for (var SlotIndex = 0; SlotIndex < Slots; SlotIndex++)
    var ItemInst = Shop_CreateItem(SlotIndex);

ds_list_destroy(_ItemList);
Shop_SpaceItems();
DB_Init = false;
DB_Started = false;
Dialogue_Shop_NotEnoughRupees = "Sorry kid, you don't have enough rupees. Come back when you have more.";
Dialogue_Shop_AlreadyOwn = "You already own that item.";
Dialogue_Shop_Downgrade = "You can't downgrade your item.";
Dialogue_Shop_Cursed = "Beat it kid!";
Dialogue_Shop_MaxKeys = "You can't hold any more keys.";
Dialogue_Shop_MaxHearts = "You already have maximum heart containers.";

function DBScriptFunction_Shop_ItemName()
{
    return Item_Name(oLink.ShopItemLook.Class, oLink.ShopItemLook.Index, oLink.ShopItemLook.Amount) + ": " + string(oLink.ShopItemLook.Price_Modified) + " rupees";
}

function DBScriptFunction_Shop_ItemInfo()
{
    return Item_Info(oLink.ShopItemLook.Class, oLink.ShopItemLook.Index);
}

function DBScriptFunction_Shop_CheckCost()
{
    return global.Inventory_ItemData[UnknownEnum.Value_40].Amount < oLink.ShopItemLook.Price_Modified;
}

function DBScriptFunction_Shop_CheckHearts()
{
    if (oLink.ShopItemLook.Class == UnknownEnum.Value_18)
        return global.Inventory_ItemData[UnknownEnum.Value_18].Amount >= (global.Challenges[UnknownEnum.Value_0] ? 5 : 16);
    else
        return false;
}

function DBScriptFunction_Shop_CheckCursed()
{
    return Curse_Check(UnknownEnum.Value_6);
}

function DBScriptFunction_Shop_CheckAlreadyOwn()
{
    var _ItemClass = oLink.ShopItemLook.Class;
    var _ItemIndex = oLink.ShopItemLook.Index;
    
    switch (global.ItemData[_ItemClass].Type)
    {
        case UnknownEnum.Value_2:
            if (_ItemIndex == global.Inventory_ItemData[_ItemClass].Index)
                return true;
            
            break;
        
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_4:
            if (global.Inventory_ItemData[_ItemClass].Owns[_ItemIndex])
                return true;
            
            break;
    }
    
    return false;
}

function DBScriptFunction_Shop_CheckDowngrade()
{
    var _ItemClass = oLink.ShopItemLook.Class;
    var _ItemIndex = oLink.ShopItemLook.Index;
    return global.ItemData[_ItemClass].Type == UnknownEnum.Value_2 && _ItemIndex < global.Inventory_ItemData[_ItemClass].Index;
}

var H = 19;
DB_Script = ds_grid_create(5, H);
var i = 0;
var A = 0;
ds_grid_set(DB_Script, 0, A, UnknownEnum.Value_5);
ds_grid_set(DB_Script, ++i, A, method(self, DBScriptFunction_Shop_CheckCursed));
ds_grid_set(DB_Script, ++i, A, 6);
ds_grid_set(DB_Script, ++i, A, A + 1);
i = 0;
A++;
ds_grid_set(DB_Script, 0, A, UnknownEnum.Value_2);
ds_grid_set(DB_Script, ++i, A, method(self, DBScriptFunction_Shop_ItemName));
ds_grid_set(DB_Script, ++i, A, A + 1);
ds_grid_set(DB_Script, ++i, A, H - 2);
ds_grid_set(DB_Script, ++i, A, H - 3);
i = 0;
A++;
ds_grid_set(DB_Script, 0, A, UnknownEnum.Value_5);
ds_grid_set(DB_Script, ++i, A, method(self, DBScriptFunction_Shop_CheckAlreadyOwn));
ds_grid_set(DB_Script, ++i, A, 8);
ds_grid_set(DB_Script, ++i, A, A + 1);
i = 0;
A++;
ds_grid_set(DB_Script, 0, A, UnknownEnum.Value_5);
ds_grid_set(DB_Script, ++i, A, method(self, DBScriptFunction_Shop_CheckDowngrade));
ds_grid_set(DB_Script, ++i, A, 10);
ds_grid_set(DB_Script, ++i, A, A + 1);
i = 0;
A++;
ds_grid_set(DB_Script, 0, A, UnknownEnum.Value_5);
ds_grid_set(DB_Script, ++i, A, method(self, DBScriptFunction_Shop_CheckHearts));
ds_grid_set(DB_Script, ++i, A, 12);
ds_grid_set(DB_Script, ++i, A, A + 1);
i = 0;
A++;
ds_grid_set(DB_Script, 0, A, UnknownEnum.Value_5);
ds_grid_set(DB_Script, ++i, A, method(self, DBScriptFunction_Shop_CheckCost));
ds_grid_set(DB_Script, ++i, A, 14);
ds_grid_set(DB_Script, ++i, A, H - 1);
i = 0;
A++;
ds_grid_set(DB_Script, 0, A, UnknownEnum.Value_6);
ds_grid_set(DB_Script, ++i, A, A + 1);
i = 0;
A++;
ds_grid_set(DB_Script, 0, A, UnknownEnum.Value_4);
ds_grid_set(DB_Script, ++i, A, Dialogue_Shop_Cursed);
ds_grid_set(DB_Script, ++i, A, H - 2);
i = 0;
A++;
ds_grid_set(DB_Script, 0, A, UnknownEnum.Value_6);
ds_grid_set(DB_Script, ++i, A, A + 1);
i = 0;
A++;
ds_grid_set(DB_Script, 0, A, UnknownEnum.Value_4);
ds_grid_set(DB_Script, ++i, A, Dialogue_Shop_AlreadyOwn);
ds_grid_set(DB_Script, ++i, A, H - 2);
i = 0;
A++;
ds_grid_set(DB_Script, 0, A, UnknownEnum.Value_6);
ds_grid_set(DB_Script, ++i, A, A + 1);
i = 0;
A++;
ds_grid_set(DB_Script, 0, A, UnknownEnum.Value_4);
ds_grid_set(DB_Script, ++i, A, Dialogue_Shop_Downgrade);
ds_grid_set(DB_Script, ++i, A, H - 2);
i = 0;
A++;
ds_grid_set(DB_Script, 0, A, UnknownEnum.Value_6);
ds_grid_set(DB_Script, ++i, A, A + 1);
i = 0;
A++;
ds_grid_set(DB_Script, 0, A, UnknownEnum.Value_4);
ds_grid_set(DB_Script, ++i, A, Dialogue_Shop_MaxHearts);
ds_grid_set(DB_Script, ++i, A, H - 2);
i = 0;
A++;
ds_grid_set(DB_Script, 0, A, UnknownEnum.Value_6);
ds_grid_set(DB_Script, ++i, A, A + 1);
i = 0;
A++;
ds_grid_set(DB_Script, 0, A, UnknownEnum.Value_4);
ds_grid_set(DB_Script, ++i, A, Dialogue_Shop_NotEnoughRupees);
ds_grid_set(DB_Script, ++i, A, H - 2);
i = 0;
A++;
ds_grid_set(DB_Script, 0, A, UnknownEnum.Value_0);
ds_grid_set(DB_Script, ++i, A, method(self, DBScriptFunction_Shop_ItemInfo));
ds_grid_set(DB_Script, ++i, A, 1);
i = 0;
A++;
ds_grid_set(DB_Script, 0, A, UnknownEnum.Value_7);
ds_grid_set(DB_Script, ++i, A, 0);
i = 0;
A++;
ds_grid_set(DB_Script, 0, A, UnknownEnum.Value_7);
ds_grid_set(DB_Script, ++i, A, 1);

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_4 = 4,
    Value_5,
    Value_6,
    Value_7,
    Value_10 = 10,
    Value_12 = 12,
    Value_18 = 18,
    Value_40 = 40
}
