function Shop_CreateItem(arg0)
{
    var _ItemIndex = -1;
    var _ItemFrom = UnknownEnum.Value_4;
    var _ItemClass;
    
    switch (ShopType)
    {
        case UnknownEnum.Value_0:
            _ItemClass = Probs_RandomItemClass(UnknownEnum.Value_4);
            
            if (global.Swordless)
            {
                if (_ItemClass != UnknownEnum.Value_7 && Item_Allowed(UnknownEnum.Value_7))
                {
                    if (Prob(0.12))
                        _ItemClass = UnknownEnum.Value_7;
                }
            }
            else if (_ItemClass != UnknownEnum.Value_44 && Item_Allowed(UnknownEnum.Value_44))
            {
                if (Prob(0.04))
                    _ItemClass = UnknownEnum.Value_44;
            }
            
            break;
        
        case UnknownEnum.Value_1:
            _ItemFrom = UnknownEnum.Value_9;
            _ItemClass = Probs_RandomItemClass(UnknownEnum.Value_9);
            break;
        
        case UnknownEnum.Value_2:
            _ItemClass = Prob(0.95) ? UnknownEnum.Value_13 : UnknownEnum.Value_36;
            
            if (_ItemClass == UnknownEnum.Value_36)
                _ItemIndex = UnknownEnum.Value_4;
            
            break;
        
        case UnknownEnum.Value_3:
            _ItemClass = Prob(0.85) ? UnknownEnum.Value_36 : UnknownEnum.Value_27;
            
            if (_ItemClass == UnknownEnum.Value_36)
                _ItemIndex = choose(UnknownEnum.Value_0, UnknownEnum.Value_2, UnknownEnum.Value_1, UnknownEnum.Value_3);
            
            break;
        
        case UnknownEnum.Value_4:
            _ItemFrom = UnknownEnum.Value_10;
            _ItemClass = Probs_RandomItemClass(_ItemFrom);
            
            if (_ItemClass != UnknownEnum.Value_2 && Item_Allowed(UnknownEnum.Value_2))
                _ItemClass = UnknownEnum.Value_2;
            
            break;
        
        case UnknownEnum.Value_5:
            _ItemFrom = UnknownEnum.Value_11;
            _ItemClass = Probs_RandomItemClass(_ItemFrom);
            break;
        
        case UnknownEnum.Value_6:
            _ItemClass = UnknownEnum.Value_5;
            
            if (Prob(0.2) && Item_Allowed(UnknownEnum.Value_4, 0, _ItemFrom))
            {
                _ItemClass = UnknownEnum.Value_4;
            }
            else if (Prob(0.2) && Item_Allowed(UnknownEnum.Value_38, UnknownEnum.Value_2, _ItemFrom))
            {
                _ItemClass = UnknownEnum.Value_38;
                _ItemIndex = UnknownEnum.Value_2;
            }
            
            break;
    }
    
    var ItemInst;
    
    switch (_ItemClass)
    {
        case UnknownEnum.Value_45:
            ItemInst = Treasure_Create(RoomIndex, x, y, -99, false, ShopType == UnknownEnum.Value_0, undefined, _ItemFrom);
            break;
        
        default:
            ItemInst = instance_create_layer(x, y, "Objs_" + FloorLevelStr, ObjIndexFromItemClass(_ItemClass), 
            {
                From: _ItemFrom
            });
    }
    
    switch (_ItemClass)
    {
        case UnknownEnum.Value_18:
            global.Level.ShopHeartPiecesCreated++;
            break;
        
        case UnknownEnum.Value_27:
            global.Level.ShopLargeMagicCreated++;
            break;
        
        case UnknownEnum.Value_20:
            global.Level.ShopKeysCreated++;
            break;
        
        case UnknownEnum.Value_1:
            global.Level.ShopArrowsCreated++;
            ItemInst.Setup = false;
            ItemInst.Amount = Arrows_PickAmount(_ItemFrom);
            break;
        
        case UnknownEnum.Value_5:
            global.Level.ShopBombsCreated++;
            ItemInst.Setup = false;
            ItemInst.Amount = Bombs_PickAmount(_ItemFrom);
            
            if (ItemInst.Amount == 3)
                ItemInst.image_index = 1;
            
            break;
        
        case UnknownEnum.Value_33:
            global.Level.ShopOrbsCreated++;
            break;
        
        case UnknownEnum.Value_35:
            global.Level.ShopPopsCreated++;
            break;
    }
    
    if (_ItemIndex != -1)
    {
        with (ItemInst)
            Item_SetIndex(_ItemIndex);
    }
    
    ItemInst.Name = Item_Name(ItemInst.Class, ItemInst.Index, ItemInst.Amount);
    var _ItemPriceBase = Item_Price(ItemInst.Class, ItemInst.Index, ItemInst.Amount);
    ItemInst.Price = Item_Price_RoundToNearest(_ItemPriceBase * global.Level.Rooms[RoomIndex].ShopPriceMultiplier, 5);
    ItemInst.Price_Max = Item_Price_RoundToNearest(_ItemPriceBase * 2, 5);
    ItemInst.ShopItem = true;
    ItemInst.ShowValue = true;
    ItemInst.ShowPrice = true;
    ItemInst.FloorLevel = FloorLevel;
    Inventory[arg0] = ItemInst;
    
    if (Item_IsNonDuplicatableClassType(_ItemClass))
        Item_NonDuplicatableList_Add(_ItemClass, ItemInst.Index);
    
    return ItemInst;
}

function Shop_DestroyItem(arg0)
{
    instance_destroy(Inventory[arg0]);
    Inventory[arg0] = -1;
}

function Shop_GetSlotCount()
{
    return min(floor(TileW / 3.25), 6);
}

function Shop_SpaceItems()
{
    var ItemsW = 0;
    var ItemSpacing = 11;
    
    for (var SlotIndex = 0; SlotIndex < Slots; SlotIndex++)
    {
        var ItemInst = Inventory[SlotIndex];
        var ItemSprW = 16;
        ItemsW += (ItemSprW + ItemSpacing);
    }
    
    ItemsW -= ItemSpacing;
    var ItemsX = x + ((ShopW - ItemsW) / 2);
    var ItemX = ItemsX;
    
    for (var SlotIndex = 0; SlotIndex < Slots; SlotIndex++)
    {
        var ItemInst = Inventory[SlotIndex];
        var ItemSprW = 16;
        var _x = ItemX + (ItemSprW / 2);
        var _y = (ShopType == UnknownEnum.Value_0) ? (y + 42) : (y + 10);
        
        if (ItemInst != -4)
        {
            if (ItemInst.object_index == oItem_Sword)
                _x += 0.5;
            
            ItemInst.x = _x;
            
            with (ItemInst)
                ObjSetY(_y);
        }
        
        ItemX += (ItemSprW + ItemSpacing);
    }
}

function ResetUnusedShopKeeperList()
{
    ds_list_clear(global.UnusedShopKeepers);
    
    for (var i = 0; i < 23; i++)
        ds_list_add(global.UnusedShopKeepers, i);
    
    ds_list_shuffle(global.UnusedShopKeepers);
}

function GetShopType(arg0)
{
    switch (arg0)
    {
        case "Various":
            return UnknownEnum.Value_0;
        
        case "Weapons":
            return UnknownEnum.Value_1;
        
        case "Potions":
            return UnknownEnum.Value_3;
        
        case "Foods":
            return UnknownEnum.Value_2;
        
        case "Treasures":
            return UnknownEnum.Value_4;
        
        case "Magic":
            return UnknownEnum.Value_5;
        
        case "Bombs":
            return UnknownEnum.Value_6;
    }
    
    return UnknownEnum.Value_0;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_9 = 9,
    Value_10,
    Value_11,
    Value_13 = 13,
    Value_18 = 18,
    Value_20 = 20,
    Value_27 = 27,
    Value_33 = 33,
    Value_35 = 35,
    Value_36,
    Value_38 = 38,
    Value_44 = 44,
    Value_45
}
