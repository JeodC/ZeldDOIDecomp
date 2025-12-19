if (!instance_exists(ParentInst))
{
    instance_destroy(id);
    exit;
}

if (global.Paused)
{
    ObjPause();
    exit;
}
else
{
    image_speed = LastImageSpeed;
}

if (ParentInst.State != UnknownEnum.Value_7)
{
    if (alarm[0] > -1)
        alarm[0]++;
    
    if (alarm[1] > -1)
        alarm[1]++;
    
    exit;
}

with (ItemInst)
{
    x = other.x;
    y = other.y + 8;
}

if (!ItemGrabbed && !oLink.Invincible && !oLink.Cape && Dist >= GrabDist)
{
    if (!place_meeting(x, y, oLink))
        exit;
    
    var ItemChoices_Class = -1;
    var ItemChoices_Index = 0;
    var ItemChoices_Amount = 1;
    var _RupeesAllowed = global.Inventory_ItemData[UnknownEnum.Value_40].Amount > 0;
    var _BombsAllowed = global.Inventory_ItemData[UnknownEnum.Value_5].Amount[0] > 0;
    var _ArrowsAllowed = global.Inventory_ItemData[UnknownEnum.Value_1].Amount[0] > 0;
    var TookInventoryItem = false;
    var _InventorySlotsWithItems = ds_list_create();
    
    for (var i = global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_1]; i <= global.Inventory_SlotIndex_Last; i++)
    {
        if (global.Inventory[i].ItemClass == -1 || global.Inventory[i].ItemClass == UnknownEnum.Value_44)
            continue;
        
        ds_list_add(_InventorySlotsWithItems, i);
    }
    
    if (ds_list_size(_InventorySlotsWithItems) > 0 && (Prob(0.4) || (!_RupeesAllowed && !_BombsAllowed && !_ArrowsAllowed)))
    {
        ds_list_shuffle(_InventorySlotsWithItems);
        var _InventorySlot = ds_list_find_value(_InventorySlotsWithItems, 0);
        ItemChoices_Class = global.Inventory[_InventorySlot].ItemClass;
        ItemChoices_Index = global.Inventory[_InventorySlot].ItemIndex;
        
        switch (global.ItemData[ItemChoices_Class].Type)
        {
            case UnknownEnum.Value_4:
                ItemChoices_Amount = global.Inventory[_InventorySlot].Amount;
                break;
            
            default:
                ItemChoices_Amount = 1;
                break;
        }
        
        TookInventoryItem = true;
    }
    
    ds_list_destroy(_InventorySlotsWithItems);
    
    if (!TookInventoryItem)
    {
        var _ItemList = ds_list_create();
        
        if (_RupeesAllowed)
            ds_list_add(_ItemList, UnknownEnum.Value_40, UnknownEnum.Value_40, UnknownEnum.Value_40);
        
        if (_BombsAllowed)
            ds_list_add(_ItemList, UnknownEnum.Value_5);
        
        if (_ArrowsAllowed)
            ds_list_add(_ItemList, UnknownEnum.Value_1);
        
        if (ds_list_size(_ItemList) == 0)
        {
            ds_list_destroy(_ItemList);
            exit;
        }
        
        ds_list_shuffle(_ItemList);
        ItemChoices_Class = ds_list_find_value(_ItemList, 0);
        ItemChoices_Index = 0;
        
        switch (ItemChoices_Class)
        {
            case UnknownEnum.Value_40:
                ItemChoices_Amount = choose(1, 1, 5, 5, 10, 20, 40);
                
                if (ItemChoices_Amount > global.Inventory_ItemData[UnknownEnum.Value_40].Amount)
                    ItemChoices_Amount = 1;
                
                break;
            
            case UnknownEnum.Value_5:
                ItemChoices_Amount = choose(1, 2, 3);
                
                if (ItemChoices_Amount > global.Inventory_ItemData[UnknownEnum.Value_5].Amount[0])
                    ItemChoices_Amount = 1;
                
                break;
            
            case UnknownEnum.Value_1:
                ItemChoices_Amount = choose(1, 1, 2, 2, 3, 5, 8, 10);
                
                if (ItemChoices_Amount > global.Inventory_ItemData[UnknownEnum.Value_1].Amount[0])
                    ItemChoices_Amount = 1;
                
                break;
        }
        
        ds_list_destroy(_ItemList);
    }
    
    if (ItemChoices_Class == -1)
        exit;
    
    ItemInst = ItemSpawn(ItemChoices_Class, x, y + 8, UnknownEnum.Value_14, UnknownEnum.Value_0, oLink.FloorLevel, false);
    ItemInst.Amount = ItemChoices_Amount;
    
    switch (global.ItemData[ItemChoices_Class].Type)
    {
        case UnknownEnum.Value_0:
            switch (ItemChoices_Class)
            {
                case UnknownEnum.Value_40:
                    with (ItemInst)
                    {
                        Setup = false;
                        Rupee_Init(Amount);
                        global.Inventory_ItemData[UnknownEnum.Value_40].Amount -= Amount;
                    }
                    
                    break;
                
                case UnknownEnum.Value_1:
                case UnknownEnum.Value_5:
                    ItemInst.Setup = false;
                    Item_Consume(ItemChoices_Class, 0, -ItemChoices_Amount);
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_3:
            switch (ItemChoices_Class)
            {
                case UnknownEnum.Value_5:
                case UnknownEnum.Value_1:
                    ItemInst.Setup = false;
                    Inventory_Add(ItemChoices_Class, 0, -ItemChoices_Amount, Inventory_ItemClassExists(ItemChoices_Class));
                    break;
                
                default:
                    Inventory_Add(ItemChoices_Class, ItemChoices_Index, -1, Inventory_ItemIndexExists(ItemChoices_Class, ItemChoices_Index));
                    
                    with (ItemInst)
                        Item_SetIndex(ItemChoices_Index);
                    
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_4:
            with (ItemInst)
                Item_SetIndex(ItemChoices_Index);
            
            Inventory_DeleteItemIndex(ItemChoices_Class, ItemChoices_Index);
            break;
        
        case UnknownEnum.Value_2:
            with (ItemInst)
                Item_SetIndex(ItemChoices_Index);
            
            Inventory_DeleteItemClass(ItemChoices_Class);
            break;
    }
    
    ItemInst.ShowShadow = false;
    ItemInst.Get_WhenLinkCollides = false;
    ItemGrabbed = true;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_7 = 7,
    Value_14 = 14,
    Value_40 = 40,
    Value_44 = 44
}
