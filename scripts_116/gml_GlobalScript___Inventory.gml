global.StartingGear = UnknownEnum.Value_0;

function Inventory_InitData()
{
    global.InventoryInst = -4;
    global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_4] = 32;
    global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_4] = (global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_4] + 2) - 1;
    global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_5] = global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_4] + 1;
    global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_5] = (global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_5] + 2) - 1;
    global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_6] = global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_5] + 1;
    global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_6] = (global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_6] + 2) - 1;
    global.Inventory_SlotIndex_Gems = global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_4];
    global.Inventory_SlotIndex_Last = global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_6];
    
    for (var i = 0; i <= global.Inventory_SlotIndex_Last; i++)
    {
        global.Inventory[i] = 
        {
            ItemClass: -1,
            ItemIndex: -1,
            Amount: 0,
            Enabled: true
        };
    }
    
    for (var _ItemClass = 0; _ItemClass < 49; _ItemClass++)
    {
        var _ItemType = global.ItemData[_ItemClass].Type;
        var _ObjIndex = ObjIndexFromItemClass(_ItemClass);
        var _Indexes = sprite_get_number(object_get_sprite(_ObjIndex));
        
        switch (_ItemType)
        {
            case UnknownEnum.Value_0:
                global.Inventory_ItemData[_ItemClass] = 
                {
                    Amount: 0
                };
                break;
            
            case UnknownEnum.Value_1:
                global.Inventory_ItemData[_ItemClass] = 
                {
                    Owns: array_create(_Indexes)
                };
                break;
            
            case UnknownEnum.Value_2:
                global.Inventory_ItemData[_ItemClass] = 
                {
                    Owns: false,
                    Index: -1,
                    Index_Min: -1,
                    Index_Max: _Indexes - 1
                };
                
                switch (_ItemClass)
                {
                    case UnknownEnum.Value_2:
                    case UnknownEnum.Value_46:
                        global.Inventory_ItemData[_ItemClass].Owns = true;
                        global.Inventory_ItemData[_ItemClass].Index = 0;
                        global.Inventory_ItemData[_ItemClass].Index_Min = 0;
                }
                
                break;
            
            case UnknownEnum.Value_3:
                global.Inventory_ItemData[_ItemClass] = 
                {
                    Amount: array_create(_Indexes)
                };
                break;
            
            case UnknownEnum.Value_4:
                global.Inventory_ItemData[_ItemClass] = 
                {
                    Owns: array_create(_Indexes)
                };
                break;
        }
    }
    
    Inventory_CalculateSlotIndexes();
}

function Inventory_CalculateSlotIndexes(arg0 = global.Inventory_ItemData[UnknownEnum.Value_2].Index, arg1 = true)
{
    arg0 = clamp(arg0, 0, 2);
    var _SlotsPerRow = Inventory_SlotsPerRow(arg0);
    global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_0] = 0;
    global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_0] = _SlotsPerRow - 1;
    global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_1] = global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_0] + 1;
    global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_1] = (global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_1] + _SlotsPerRow) - 1;
    global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_2] = global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_1] + 1;
    global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_2] = (global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_2] + _SlotsPerRow) - 1;
    global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_3] = global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_2] + 1;
    global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_3] = (global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_3] + _SlotsPerRow) - 1;
    global.Inventory_SlotIndex_ArrowQuiver = global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_0] - 2;
    global.Inventory_SlotIndex_BombBag = global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_0] - 1;
    global.Inventory_SlotIndex_GemBag = global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_0];
    
    if (arg1)
    {
        global.Inventory_SlotIndex_Selected = global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_1];
        global.Inventory_SlotIndex_Equiped = -1;
        global.Inventory_ShowGems = false;
    }
}

function Inventory_Add(arg0, arg1, arg2 = 1, arg3 = -1)
{
    if (arg0 == UnknownEnum.Value_2)
    {
        var _OwnsBombBag = global.Inventory_ItemData[UnknownEnum.Value_4].Owns[0];
        var _OwnsArrowQuiver = global.Inventory_ItemData[UnknownEnum.Value_0].Owns[0];
        var _OwnsGemBag = global.Inventory_ItemData[UnknownEnum.Value_15].Owns[0];
        Inventory_ClearSlot(global.Inventory_SlotIndex_BombBag);
        Inventory_ClearSlot(global.Inventory_SlotIndex_ArrowQuiver);
        Inventory_ClearSlot(global.Inventory_SlotIndex_GemBag);
        
        if (global.Inventory_SlotIndex_Selected < global.Inventory_SlotIndex_Gems)
        {
            var _OldSlotsPerRow = Inventory_SlotsPerRow();
            var _NewSlotsPerRow = Inventory_SlotsPerRow(global.Inventory_ItemData[UnknownEnum.Value_2].Index + 1);
            var _Diff = _NewSlotsPerRow - _OldSlotsPerRow;
            global.Inventory_SlotIndex_Selected += _Diff;
            
            if (global.Inventory_SlotIndex_Equiped == global.Inventory_SlotIndex_BombBag)
                global.Inventory_SlotIndex_Equiped += _Diff;
        }
        
        Inventory_CalculateSlotIndexes(global.Inventory_ItemData[UnknownEnum.Value_2].Index + 1, false);
        
        if (_OwnsBombBag)
        {
            global.Inventory[global.Inventory_SlotIndex_BombBag].ItemClass = UnknownEnum.Value_4;
            global.Inventory[global.Inventory_SlotIndex_BombBag].ItemIndex = 0;
        }
        
        if (_OwnsArrowQuiver)
        {
            global.Inventory[global.Inventory_SlotIndex_ArrowQuiver].ItemClass = UnknownEnum.Value_0;
            global.Inventory[global.Inventory_SlotIndex_ArrowQuiver].ItemIndex = 0;
        }
        
        if (_OwnsGemBag)
        {
            global.Inventory[global.Inventory_SlotIndex_GemBag].ItemClass = UnknownEnum.Value_15;
            global.Inventory[global.Inventory_SlotIndex_GemBag].ItemIndex = 0;
        }
    }
    
    switch (arg0)
    {
        case UnknownEnum.Value_0:
            arg3 = global.Inventory_SlotIndex_ArrowQuiver;
            break;
        
        case UnknownEnum.Value_4:
            arg3 = global.Inventory_SlotIndex_BombBag;
            break;
        
        case UnknownEnum.Value_15:
            arg3 = global.Inventory_SlotIndex_GemBag;
            break;
        
        default:
            if (global.ItemData[arg0].Type == UnknownEnum.Value_4 || arg2 > 0)
                arg3 = Inventory_CanAdd(arg0, arg1, arg2);
            
            break;
    }
    
    if (arg3 == -1)
        return false;
    
    var _InvItem = global.Inventory_ItemData[arg0];
    
    if (arg3 >= 0)
    {
        if (global.Inventory[arg3].Amount < 0)
            global.Inventory[arg3].Amount = 0;
    }
    
    var _MaxAmount = Inventory_MaxAmount(arg0);
    
    switch (global.ItemData[arg0].Type)
    {
        case UnknownEnum.Value_1:
            _InvItem.Index = arg1;
            _InvItem.Owns[arg1] = true;
            break;
        
        case UnknownEnum.Value_2:
            if (arg1 < _InvItem.Index)
            {
                Item_NonDuplicatableList_Remove(arg0, arg1);
                arg1 = _InvItem.Index;
            }
            
            _InvItem.Index = arg1;
            _InvItem.Owns = true;
            break;
        
        case UnknownEnum.Value_3:
        case UnknownEnum.Value_5:
            if (arg2 > 0 && global.Inventory[arg3].Amount >= _MaxAmount)
                return false;
            
            global.Inventory[arg3].Amount = clamp(global.Inventory[arg3].Amount + arg2, 0, _MaxAmount);
            
            if (global.Inventory[arg3].Amount == 0)
            {
                Inventory_DeleteSlot(arg3);
                arg0 = -1;
                arg1 = 0;
            }
            
            break;
        
        case UnknownEnum.Value_4:
            _InvItem.Index = arg1;
            _InvItem.Owns[arg1] = true;
            global.Inventory[arg3].Amount = clamp(global.Inventory[arg3].Amount + arg2, 0, _MaxAmount);
            break;
    }
    
    switch (arg0)
    {
        case UnknownEnum.Value_2:
            break;
        
        default:
            global.Inventory[arg3].ItemClass = arg0;
            global.Inventory[arg3].ItemIndex = arg1;
            break;
    }
    
    switch (arg0)
    {
        case UnknownEnum.Value_0:
            var ArrowCount = global.Inventory_ItemData[UnknownEnum.Value_1].Amount[0];
            global.ItemData[UnknownEnum.Value_1].Type = UnknownEnum.Value_0;
            
            if (ArrowCount > 0)
            {
                Inventory_DeleteItemClass(UnknownEnum.Value_1);
                global.Inventory_ItemData[UnknownEnum.Value_1].Amount[0] = ArrowCount;
            }
            
            global.Inventory[arg3].ItemClass = arg0;
            global.Inventory[arg3].ItemIndex = arg1;
            break;
        
        case UnknownEnum.Value_4:
            var BombCount = global.Inventory_ItemData[UnknownEnum.Value_5].Amount[0];
            global.ItemData[UnknownEnum.Value_5].Type = UnknownEnum.Value_0;
            
            if (BombCount > 0)
            {
                var _ResetSlotIndex = false;
                
                if (global.Inventory_SlotIndex_Equiped != -1)
                    _ResetSlotIndex = global.Inventory[global.Inventory_SlotIndex_Equiped].ItemClass == UnknownEnum.Value_5;
                
                Inventory_DeleteItemClass(UnknownEnum.Value_5);
                
                if (_ResetSlotIndex)
                    global.Inventory_SlotIndex_Equiped = global.Inventory_SlotIndex_BombBag;
                
                global.Inventory_ItemData[UnknownEnum.Value_5].Amount[0] = BombCount;
            }
            
            break;
        
        case UnknownEnum.Value_15:
            Inventory_TransferGems();
            break;
    }
    
    if (arg0 == UnknownEnum.Value_34 && arg1 == UnknownEnum.Value_5)
        oHUD.CheckPendentSecret = true;
    
    Item_NonDuplicatableList_Remove(arg0, arg1);
    Inventory_CountStackItems();
    Link_UpdateAttackDefence();
    return true;
}

function Inventory_CanAdd(arg0, arg1, arg2 = 1)
{
    var _SlotIndex;
    
    switch (arg0)
    {
        case UnknownEnum.Value_2:
            return -2;
        
        case UnknownEnum.Value_14:
        case UnknownEnum.Value_23:
            if (global.Inventory_ItemData[UnknownEnum.Value_15].Owns[0])
            {
                _SlotIndex = Inventory_FindEmptySlot_Gems();
                
                if (_SlotIndex != -1)
                    break;
            }
        
        default:
            _SlotIndex = Inventory_FindEmptySlot();
            break;
    }
    
    var _ItemClassExists = Inventory_ItemClassExists(arg0);
    var _ItemIndexExists = Inventory_ItemIndexExists(arg0, arg1);
    
    switch (global.ItemData[arg0].Type)
    {
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_4:
            if (_ItemIndexExists == -1 && _SlotIndex == -1)
                return -1;
            
            if (_ItemIndexExists != -1)
                return _ItemIndexExists;
            
            break;
        
        case UnknownEnum.Value_2:
            if (_ItemClassExists == -1 && _SlotIndex == -1)
                return -1;
            
            if (_ItemClassExists != -1)
                return _ItemClassExists;
            
            break;
        
        case UnknownEnum.Value_3:
            if (_ItemIndexExists == -1 && _SlotIndex == -1)
                return -1;
            
            if (_ItemIndexExists != -1)
                return _ItemIndexExists;
            
            break;
        
        case UnknownEnum.Value_5:
            break;
    }
    
    return _SlotIndex;
}

function Inventory_UseItem(arg0, arg1)
{
    if (arg0 == -1)
        exit;
    
    var _ItemClass = global.Inventory[arg0].ItemClass;
    var _ItemIndex = global.Inventory[arg0].ItemIndex;
    var _Error = false;
    
    switch (_ItemClass)
    {
        case UnknownEnum.Value_7:
            if (global.Inventory_ItemData[UnknownEnum.Value_1].Amount[0] > 0)
            {
                with (oLink)
                    UpdateState(UnknownEnum.Value_13);
            }
            else
            {
                _Error = true;
            }
            
            break;
        
        case UnknownEnum.Value_6:
            if (!instance_exists(oBoomerang))
            {
                with (oLink)
                    UpdateState(UnknownEnum.Value_14);
            }
            
            break;
        
        case UnknownEnum.Value_19:
            if (!instance_exists(oHookshot))
            {
                with (oLink)
                    UpdateState(UnknownEnum.Value_15);
            }
            
            break;
        
        case UnknownEnum.Value_39:
            with (oRodCharger)
            {
                if (RodInserted)
                    exit;
            }
            
            if (global.Inventory[arg0].Amount > 0)
            {
                with (oLink)
                    UpdateState(UnknownEnum.Value_16);
                
                Inventory_Add(_ItemClass, _ItemIndex, -1, arg0);
            }
            else
            {
                _Error = true;
            }
            
            break;
        
        case UnknownEnum.Value_38:
            var _MagicUsed = MagicUse(8);
            
            if (_MagicUsed == 0)
            {
                _Error = true;
            }
            else
            {
                switch (_ItemIndex)
                {
                    case UnknownEnum.Value_0:
                        if (HealthAdd(1) == 0)
                        {
                            _Error = true;
                            break;
                        }
                        
                        audio_play_sound(Sound_HealthRefill, 1, false);
                        break;
                    
                    case UnknownEnum.Value_1:
                        if (!Item_Consume(UnknownEnum.Value_40, 0, 10))
                        {
                            _Error = true;
                            break;
                        }
                        
                        audio_play_sound(Sound_RupeeGet, 1, false);
                        break;
                    
                    case UnknownEnum.Value_2:
                        var _Added;
                        
                        if (global.Inventory_ItemData[UnknownEnum.Value_4].Owns[0])
                            _Added = Item_Consume(UnknownEnum.Value_5, 0, 1);
                        else
                            _Added = Inventory_Add(UnknownEnum.Value_5, 0, 1);
                        
                        if (!_Added)
                        {
                            var _DropPos = Item_DropPos();
                            ItemDrop(_DropPos[0], _DropPos[1], UnknownEnum.Value_5, 0, 1, UnknownEnum.Value_19);
                        }
                        
                        break;
                    
                    case UnknownEnum.Value_3:
                        var _Added;
                        
                        if (global.Inventory_ItemData[UnknownEnum.Value_0].Owns[0])
                            _Added = Item_Consume(UnknownEnum.Value_1, 0, 5);
                        else
                            _Added = Inventory_Add(UnknownEnum.Value_1, 0, 5);
                        
                        if (!_Added)
                        {
                            var _DropPos = Item_DropPos();
                            ItemDrop(_DropPos[0], _DropPos[1], UnknownEnum.Value_1, 0, 5, UnknownEnum.Value_19);
                        }
                        
                        break;
                }
                
                if (_Error)
                    global.Inventory_ItemData[UnknownEnum.Value_26].Amount += _MagicUsed;
            }
            
            if (!_Error)
            {
                if (_MagicUsed > 0)
                {
                    audio_play_sound(Sound_Cane_Magic, 1, false);
                    audio_play_sound(Sound_TextDone, 1, false);
                    audio_play_sound(Sound_Throw, 1, false);
                }
                else
                {
                    _Error = true;
                }
            }
            
            break;
        
        case UnknownEnum.Value_37:
            if (MagicUse(3) > 0)
            {
                with (oLink)
                    UpdateState(UnknownEnum.Value_17);
            }
            else
            {
                _Error = true;
            }
            
            break;
        
        case UnknownEnum.Value_4:
            if (global.Inventory_ItemData[UnknownEnum.Value_5].Amount[0] == 0)
            {
                _Error = true;
                break;
            }
            
            _ItemClass = UnknownEnum.Value_5;
        
        case UnknownEnum.Value_5:
        case UnknownEnum.Value_14:
        case UnknownEnum.Value_33:
        case UnknownEnum.Value_47:
            if (oLink.InDoor_BlockItem || oLink.InDoor_House || !oLink.InDoor_Aligned)
                break;
            
            var _ObjIndex;
            
            switch (_ItemClass)
            {
                case UnknownEnum.Value_5:
                    _ObjIndex = oBomb;
                    break;
                
                case UnknownEnum.Value_14:
                    _ObjIndex = oGem;
                    break;
                
                case UnknownEnum.Value_33:
                    _ObjIndex = oOrb;
                    break;
                
                case UnknownEnum.Value_47:
                    _ObjIndex = oWishStone;
                    break;
            }
            
            if (instance_exists(global.InventoryInst))
                global.InventoryInst.Close = true;
            
            var Inst;
            
            switch (oLink.Facing)
            {
                case 3:
                    Inst = instance_create_layer(oLink.x - 14, oLink.y, oLink.layer, _ObjIndex, 
                    {
                        From: UnknownEnum.Value_19,
                        FloorLevel: oLink.FloorLevel
                    });
                    break;
                
                case 4:
                    Inst = instance_create_layer(oLink.x + 14, oLink.y, oLink.layer, _ObjIndex, 
                    {
                        From: UnknownEnum.Value_19,
                        FloorLevel: oLink.FloorLevel
                    });
                    break;
                
                case 1:
                    Inst = instance_create_layer(oLink.x, oLink.y - 12, oLink.layer, _ObjIndex, 
                    {
                        From: UnknownEnum.Value_19,
                        FloorLevel: oLink.FloorLevel
                    });
                    break;
                
                case 2:
                    Inst = instance_create_layer(oLink.x, oLink.y + 12, oLink.layer, _ObjIndex, 
                    {
                        From: UnknownEnum.Value_19,
                        FloorLevel: oLink.FloorLevel
                    });
                    break;
            }
            
            Inst.Index = _ItemIndex;
            
            with (oLink)
            {
                if (_ItemClass == UnknownEnum.Value_5)
                {
                    if (!arg1)
                    {
                        Inst.alarm[0] = 50;
                        break;
                    }
                }
                
                UpdateState(UnknownEnum.Value_6, Inst);
            }
            
            switch (_ItemClass)
            {
                case UnknownEnum.Value_5:
                    if (global.Inventory_ItemData[UnknownEnum.Value_4].Owns[0])
                    {
                        Item_Consume(UnknownEnum.Value_5, 0, -1);
                        
                        if (global.Inventory_ItemData[UnknownEnum.Value_5].Amount[0] == 0)
                            global.Inventory_SlotIndex_Equiped = -1;
                        
                        break;
                    }
                
                default:
                    Inventory_Add(_ItemClass, _ItemIndex, -1, arg0);
                    break;
            }
            
            if (oLink.State == UnknownEnum.Value_6)
                break;
            
            break;
        
        case UnknownEnum.Value_29:
            if (MagicUse(16) > 0)
            {
                if (instance_exists(global.InventoryInst))
                    global.InventoryInst.Close = true;
                
                with (oLink)
                    instance_create_layer(x, y, "ObjsHigher_" + GetFloorLevelString(FloorLevel), oMedallion);
            }
            else
            {
                _Error = true;
            }
            
            break;
        
        case UnknownEnum.Value_9:
            if (MagicUse(1) > 0)
            {
                MagicUse(-1);
                
                if (instance_exists(global.InventoryInst))
                    global.InventoryInst.Close = true;
                
                with (oLink)
                {
                    if (instance_exists(oCape))
                        instance_destroy(oCape);
                    else if (!StarActive)
                        instance_create_layer(x, y, "ObjsHigher_Upper", oCape);
                }
            }
            else
            {
                _Error = true;
            }
            
            break;
        
        default:
            if (_ItemClass == -1)
                break;
            
            if (Item_CanUse(_ItemClass, _ItemIndex))
            {
                Item_Consume(_ItemClass, _ItemIndex);
                
                if (global.ItemData[_ItemClass].Type == UnknownEnum.Value_3 || global.ItemData[_ItemClass].Type == UnknownEnum.Value_5)
                {
                    global.Inventory[arg0].Amount--;
                    
                    if (global.Inventory[arg0].Amount <= 0)
                        Inventory_DeleteSlot(arg0);
                    
                    Inventory_CountStackItems();
                }
            }
            else
            {
                _Error = true;
            }
            
            break;
    }
    
    if (_Error)
        audio_play_sound_stopall(Sound_Error);
    
    return !_Error;
}

function Inventory_DeleteSlot(arg0)
{
    var _ItemClass = global.Inventory[arg0].ItemClass;
    
    if (_ItemClass == -1)
        exit;
    
    var _ItemIndex = global.Inventory[arg0].ItemIndex;
    var _InvItem = global.Inventory_ItemData[_ItemClass];
    
    switch (global.ItemData[_ItemClass].Type)
    {
        case UnknownEnum.Value_1:
            _InvItem.Owns[_ItemIndex] = false;
            break;
        
        case UnknownEnum.Value_4:
            _InvItem.Owns[_ItemIndex] = false;
            _InvItem.Amount[_ItemIndex] = 0;
            break;
        
        case UnknownEnum.Value_2:
            _InvItem.Owns = false;
            _InvItem.Index = _InvItem.Index_Min;
            break;
        
        case UnknownEnum.Value_3:
            _InvItem.Owns[_ItemIndex] = _InvItem.Amount[_ItemIndex] > 0;
            break;
    }
    
    Inventory_ClearSlot(arg0);
    Link_UpdateAttackDefence();
    
    if (global.Inventory_SlotIndex_Equiped == arg0)
        global.Inventory_SlotIndex_Equiped = -1;
}

function Inventory_DeleteItemClass(arg0)
{
    var _SlotIndex = Inventory_ItemClassExists(arg0);
    
    if (_SlotIndex != -1)
        Inventory_DeleteSlot(_SlotIndex);
}

function Inventory_DeleteItemIndex(arg0, arg1)
{
    var _SlotIndex = Inventory_ItemIndexExists(arg0, arg1);
    
    if (_SlotIndex != -1)
        Inventory_DeleteSlot(_SlotIndex);
}

function Inventory_CountStackItems()
{
    for (var _ItemClass = 0; _ItemClass < 49; _ItemClass++)
    {
        var _ObjIndex = ObjIndexFromItemClass(_ItemClass);
        var _Indexes = sprite_get_number(object_get_sprite(_ObjIndex));
        var _InvItemData = global.Inventory_ItemData[_ItemClass];
        
        switch (global.ItemData[_ItemClass].Type)
        {
            case UnknownEnum.Value_3:
                for (var j = 0; j < _Indexes; j++)
                    _InvItemData.Amount[j] = 0;
                
                break;
        }
    }
    
    for (var i = 0; i < Inventory_MaxSlots(); i++)
    {
        var _ItemClass = global.Inventory[i].ItemClass;
        
        if (_ItemClass == -1)
            continue;
        
        var _ItemIndex = global.Inventory[i].ItemIndex;
        var _InvItemData = global.Inventory_ItemData[_ItemClass];
        
        switch (global.ItemData[_ItemClass].Type)
        {
            case UnknownEnum.Value_3:
                _InvItemData.Amount[_ItemIndex] = min(_InvItemData.Amount[_ItemIndex] + global.Inventory[i].Amount, Inventory_MaxAmount(_ItemClass));
                break;
        }
    }
}

function Inventory_Defrag()
{
    Inventory_TransferGems();
    
    for (var i = global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_1]; i < global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_3]; i++)
    {
        if (global.Inventory[i].ItemClass != -1)
            continue;
        
        var j = i + 1;
        
        while (j <= global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_3])
        {
            if (global.Inventory[j].ItemClass == -1)
            {
            }
            else
            {
                Inventory_MoveSlot(j, i);
                break;
            }
            
            j++;
        }
    }
    
    if (!global.Inventory_ItemData[UnknownEnum.Value_15].Owns[0])
        exit;
    
    for (var i = global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_4]; i < global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_6]; i++)
    {
        if (global.Inventory[i].ItemClass != -1)
            continue;
        
        var j = i + 1;
        
        while (j <= global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_6])
        {
            if (global.Inventory[j].ItemClass == -1)
            {
            }
            else
            {
                Inventory_MoveSlot(j, i);
                break;
            }
            
            j++;
        }
    }
}

function Inventory_MoveSlot(arg0, arg1)
{
    if (global.Inventory_SlotIndex_Equiped == arg0)
        global.Inventory_SlotIndex_Equiped = arg1;
    
    global.Inventory[arg1].ItemClass = global.Inventory[arg0].ItemClass;
    global.Inventory[arg1].ItemIndex = global.Inventory[arg0].ItemIndex;
    global.Inventory[arg1].Amount = global.Inventory[arg0].Amount;
    Inventory_ClearSlot(arg0);
}

function Inventory_TransferGems()
{
    if (!global.Inventory_ItemData[UnknownEnum.Value_15].Owns[0])
        exit;
    
    var _MainSlotIndexStart = global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_1];
    var _MainSlotIndexEnd = global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_3];
    
    for (var i = _MainSlotIndexEnd; i >= _MainSlotIndexStart; i--)
    {
        if (global.Inventory[i].ItemClass == UnknownEnum.Value_14 || global.Inventory[i].ItemClass == UnknownEnum.Value_23)
        {
            var _EmptyGemSlot = Inventory_FindEmptySlot_Gems();
            
            if (_EmptyGemSlot == -1)
                break;
            
            Inventory_MoveSlot(i, _EmptyGemSlot);
        }
    }
}

function Inventory_ClearSlot(arg0)
{
    global.Inventory[arg0].ItemClass = -1;
    global.Inventory[arg0].ItemIndex = -1;
    global.Inventory[arg0].Amount = 0;
    global.Inventory[arg0].Enabled = true;
}

function Inventory_ClearAll()
{
    global.Inventory_ItemData[UnknownEnum.Value_20].Amount = 0;
    global.Inventory_ItemData[UnknownEnum.Value_2].Index = 0;
    global.Inventory_ItemData[UnknownEnum.Value_40].Amount = 0;
    global.Inventory_ItemData[UnknownEnum.Value_26].Amount = 0;
    global.Inventory_ItemData[UnknownEnum.Value_1].Amount[0] = 0;
    global.Inventory_ItemData[UnknownEnum.Value_5].Amount[0] = 0;
    global.ItemData[UnknownEnum.Value_1].Type = UnknownEnum.Value_3;
    global.ItemData[UnknownEnum.Value_5].Type = UnknownEnum.Value_3;
    
    for (var i = 0; i <= global.Inventory_SlotIndex_Last; i++)
        Inventory_DeleteSlot(i);
    
    global.Inventory_SlotIndex_Selected = global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_1];
    global.Inventory_SlotIndex_Equiped = -1;
    global.Inventory_ShowGems = false;
}

function Inventory_FindEmptySlot()
{
    var _MaxSlots = Inventory_MaxSlots();
    
    for (var i = global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_1]; i < _MaxSlots; i++)
    {
        if (global.Inventory[i].ItemClass == -1)
            return i;
    }
    
    return -1;
}

function Inventory_FindEmptySlot_Gems()
{
    for (var i = global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_4]; i <= global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_6]; i++)
    {
        if (global.Inventory[i].ItemClass == -1)
            return i;
    }
    
    return -1;
}

function Inventory_ItemClassExists(arg0)
{
    for (var i = 0; i <= global.Inventory_SlotIndex_Last; i++)
    {
        if (global.Inventory[i].ItemClass == arg0)
            return i;
    }
    
    return -1;
}

function Inventory_ItemIndexExists(arg0, arg1)
{
    for (var i = 0; i <= global.Inventory_SlotIndex_Last; i++)
    {
        if (global.Inventory[i].ItemClass == arg0 && global.Inventory[i].ItemIndex == arg1)
            return i;
    }
    
    return -1;
}

function Inventory_MaxSlots(arg0 = global.Inventory_ItemData[UnknownEnum.Value_2].Index)
{
    switch (arg0)
    {
        case 0:
            return (global.StartingGear == UnknownEnum.Value_2) ? 16 : 14;
        
        case 1:
            return 18;
        
        case 2:
            return 24;
    }
}

function Inventory_MaxSlots_Useable(arg0 = global.Inventory_ItemData[UnknownEnum.Value_2].Index)
{
    return Inventory_MaxSlots(arg0) - Inventory_SlotsPerRow(arg0);
}

function Inventory_SlotsPerRow(arg0 = global.Inventory_ItemData[UnknownEnum.Value_2].Index)
{
    switch (arg0)
    {
        case 0:
            return (global.StartingGear == UnknownEnum.Value_2) ? 8 : 7;
    }
    
    return 6;
}

function Inventory_MaxAmount(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_1:
            return global.Inventory_ItemData[UnknownEnum.Value_0].Owns[0] ? 80 : 40;
        
        case UnknownEnum.Value_5:
            return global.Inventory_ItemData[UnknownEnum.Value_4].Owns[0] ? 16 : 8;
        
        case UnknownEnum.Value_39:
            return 16;
    }
    
    return 99;
}

function Inventory_CountGemBag()
{
    var _Count = 0;
    
    for (var i = global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_4]; i <= global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_6]; i++)
    {
        if (global.Inventory[i].ItemClass == UnknownEnum.Value_14 || global.Inventory[i].ItemClass == UnknownEnum.Value_23)
            _Count += global.Inventory[i].Amount;
    }
    
    return _Count;
}

function Inventory_GetPosOffset(arg0, arg1)
{
    Offset[0] = sprite_get_xoffset(arg0);
    Offset[1] = sprite_get_yoffset(arg0);
    
    switch (arg0)
    {
        case sItem_Boomerang:
        case sItem_Coupon:
        case sItem_Letter:
            Offset[0] += 1;
            Offset[1] += 3;
            break;
        
        case sItem_Mirror:
        case sItem_Book:
            Offset[0] += 1;
            Offset[1] += 1;
            break;
        
        case sItem_ArrowQuiver:
        case sItem_Arrows:
        case sItem_BombBag:
        case sItem_GemBag:
        case sItem_Bow:
        case sItem_Map:
        case sItem_Compass:
        case sItem_Cane:
        case sItem_Cape:
        case sItem_Magic_Large:
        case sItem_Rod:
        case sItem_Medallion:
        case sItem_Hookshot:
        case sItem_Gloves:
        case sItem_Lamp:
        case sItem_Sword_Inventory:
        case sItem_Pendant:
        case sItem_Pop:
        case sItem_Potion:
        case sItem_Ring:
        case sItem_Kinstone:
        case sItem_Key_Master:
        case sItem_Key_Special:
        case sItem_MoonPearl:
        case sItem_Mushroom:
        case sItem_Treasure:
            Offset[1] += 1;
            break;
        
        case sItem_Tunic:
        case sItem_Powder:
        case sItem_WishStone:
            Offset[1] += 2;
            break;
    }
    
    return Offset;
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
    Value_13 = 13,
    Value_14,
    Value_15,
    Value_16,
    Value_17,
    Value_19 = 19,
    Value_20,
    Value_23 = 23,
    Value_26 = 26,
    Value_29 = 29,
    Value_33 = 33,
    Value_34,
    Value_37 = 37,
    Value_38,
    Value_39,
    Value_40,
    Value_46 = 46,
    Value_47
}
