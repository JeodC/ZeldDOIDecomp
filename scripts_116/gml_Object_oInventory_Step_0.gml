Link_PauseHitFlashingTimer();

if (Open)
{
    Alpha += AlphaSpeed;
    
    if (Alpha >= 1)
    {
        Alpha = 1;
        Open = false;
    }
    
    exit;
}

if (OpenGems)
{
    X -= OpenGemSpeed;
    
    if (X <= X_WithGems)
    {
        X = X_WithGems;
        OpenGems = false;
        global.Inventory_ShowGems = true;
    }
}

if (CloseGems)
{
    X += OpenGemSpeed;
    
    if (X >= X_NoGems)
    {
        X = X_NoGems;
        CloseGems = false;
    }
}

if (!DB_Started && !instance_exists(global.DB_Inst))
{
    if (MenuEnable)
    {
        if (input_check_pressed("left"))
        {
            MenuSelectionIndex--;
            
            if (MenuSelectionIndex < 0)
                MenuSelectionIndex = MenuItems - 1;
            
            while (!ds_grid_get(MenuItemGrid, 1, MenuSelectionIndex))
            {
                MenuSelectionIndex--;
                
                if (MenuSelectionIndex < 0)
                    MenuSelectionIndex = MenuItems - 1;
            }
            
            audio_play_sound(Sound_Text, 1, false);
        }
        else if (input_check_pressed("right"))
        {
            MenuSelectionIndex = (MenuSelectionIndex + 1) % MenuItems;
            
            while (!ds_grid_get(MenuItemGrid, 1, MenuSelectionIndex))
                MenuSelectionIndex = (MenuSelectionIndex + 1) % MenuItems;
            
            audio_play_sound(Sound_Text, 1, false);
        }
        else if (input_check_pressed("sword"))
        {
            var _ItemUsed, _ItemClass;
            
            if (ds_grid_get(MenuItemGrid, 1, MenuSelectionIndex))
            {
                var _Slot = global.Inventory_SlotIndex_Selected;
                _ItemClass = global.Inventory[_Slot].ItemClass;
                var _ItemIndex = global.Inventory[_Slot].ItemIndex;
                
                switch (MenuSelectionIndex)
                {
                    case 0:
                        global.Inventory_SlotIndex_Equiped = global.Inventory_SlotIndex_Selected;
                        audio_play_sound(Sound_TextDone, 1, false);
                        break;
                    
                    case 1:
                        if (Item_CanUse(_ItemClass, _ItemIndex))
                        {
                            _ItemUsed = Inventory_UseItem(global.Inventory_SlotIndex_Selected, true);
                            audio_play_sound(Sound_TextDone, 1, false);
                        }
                        else
                        {
                            _ItemUsed = false;
                            audio_play_sound_stopall(Sound_Error);
                        }
                        
                        break;
                    
                    case 2:
                        var _DropPos = Item_DropPos();
                        var _DoppedItemInst = ItemDrop(_DropPos[0], _DropPos[1], _ItemClass, _ItemIndex, global.Inventory[_Slot].Amount, UnknownEnum.Value_19);
                        _DoppedItemInst.Get_ShowDialogue = false;
                        Inventory_DeleteSlot(_Slot);
                        Inventory_CountStackItems();
                        
                        if (_ItemClass == UnknownEnum.Value_14 || _ItemClass == UnknownEnum.Value_23)
                        {
                            Inventory_TransferGems();
                            GemBagCount = Inventory_CountGemBag();
                        }
                        
                        audio_play_sound(Sound_TextDone, 1, false);
                        break;
                    
                    case 3:
                        DB_Init = true;
                        DB_Script = DBScript_Info;
                        break;
                }
            }
            
            if (MenuSelectionIndex == 1)
            {
                if (_ItemUsed)
                {
                    switch (_ItemClass)
                    {
                        default:
                            MenuEnable = false;
                            break;
                        
                        case UnknownEnum.Value_38:
                            break;
                    }
                    
                    switch (_ItemClass)
                    {
                        case UnknownEnum.Value_9:
                            global.Inventory_SlotIndex_Equiped = global.Inventory_SlotIndex_Selected;
                            break;
                    }
                }
            }
            else
            {
                MenuEnable = false;
            }
        }
        else if (input_check_pressed("action"))
        {
            MenuEnable = false;
        }
    }
    else
    {
        var ItemClassSelected = global.Inventory[global.Inventory_SlotIndex_Selected].ItemClass;
        var ItemIndexSelected = global.Inventory[global.Inventory_SlotIndex_Selected].ItemIndex;
        var _PlaySound = false;
        
        if (input_check_pressed("left"))
        {
            do
            {
                var _ExitGemBag = true;
                
                switch (global.Inventory_SlotIndex_Selected)
                {
                    case global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_4]:
                        global.Inventory_SlotIndex_Selected = global.Inventory_SlotIndex_GemBag;
                        break;
                    
                    case global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_5]:
                        global.Inventory_SlotIndex_Selected = global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_1];
                        break;
                    
                    case global.Inventory_SlotIndex_RowStart[UnknownEnum.Value_6]:
                        if (global.Inventory_ItemData[UnknownEnum.Value_2].Index > 0)
                            global.Inventory_SlotIndex_Selected = global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_2];
                        else
                            global.Inventory_SlotIndex_Selected = global.Inventory_SlotIndex_GemBag;
                        
                        break;
                    
                    default:
                        _ExitGemBag = false;
                }
                
                if (_ExitGemBag)
                    break;
                
                var _IndexRow;
                
                if (global.Inventory_SlotIndex_Selected >= global.Inventory_SlotIndex_Gems)
                    _IndexRow = UnknownEnum.Value_4 + floor((global.Inventory_SlotIndex_Selected - global.Inventory_SlotIndex_Gems) / 2);
                else
                    _IndexRow = floor(global.Inventory_SlotIndex_Selected / SlotsPerRow);
                
                global.Inventory_SlotIndex_Selected--;
                
                if (global.Inventory_SlotIndex_Selected < global.Inventory_SlotIndex_RowStart[_IndexRow])
                    global.Inventory_SlotIndex_Selected = global.Inventory_SlotIndex_RowEnd[_IndexRow];
            }
            until (global.Inventory[global.Inventory_SlotIndex_Selected].Enabled);
            
            _PlaySound = true;
        }
        else if (input_check_pressed("right"))
        {
            do
            {
                if (global.Inventory_SlotIndex_Selected == global.Inventory_SlotIndex_GemBag && global.Inventory_ItemData[UnknownEnum.Value_15].Owns[0])
                {
                    global.Inventory_SlotIndex_Selected = global.Inventory_SlotIndex_Gems;
                    break;
                }
                
                var _IndexRow;
                
                if (global.Inventory_SlotIndex_Selected >= global.Inventory_SlotIndex_Gems)
                    _IndexRow = UnknownEnum.Value_4 + floor((global.Inventory_SlotIndex_Selected - global.Inventory_SlotIndex_Gems) / 2);
                else
                    _IndexRow = floor(global.Inventory_SlotIndex_Selected / SlotsPerRow);
                
                global.Inventory_SlotIndex_Selected++;
                
                if (global.Inventory_SlotIndex_Selected > global.Inventory_SlotIndex_RowEnd[_IndexRow])
                    global.Inventory_SlotIndex_Selected = global.Inventory_SlotIndex_RowStart[_IndexRow];
            }
            until (global.Inventory[global.Inventory_SlotIndex_Selected].Enabled);
            
            _PlaySound = true;
        }
        else if (input_check_pressed("up"))
        {
            do
            {
                if (global.Inventory_SlotIndex_Selected >= global.Inventory_SlotIndex_Gems)
                {
                    global.Inventory_SlotIndex_Selected -= 2;
                    
                    if (global.Inventory_SlotIndex_Selected < global.Inventory_SlotIndex_Gems)
                        global.Inventory_SlotIndex_Selected += GemSlots;
                }
                else
                {
                    global.Inventory_SlotIndex_Selected -= SlotsPerRow;
                    
                    if (global.Inventory_SlotIndex_Selected < 0)
                        global.Inventory_SlotIndex_Selected += Slots;
                }
            }
            until (global.Inventory[global.Inventory_SlotIndex_Selected].Enabled);
            
            _PlaySound = true;
        }
        else if (input_check_pressed("down"))
        {
            do
            {
                if (global.Inventory_SlotIndex_Selected >= global.Inventory_SlotIndex_Gems)
                {
                    global.Inventory_SlotIndex_Selected += 2;
                    
                    if (global.Inventory_SlotIndex_Selected > global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_6])
                        global.Inventory_SlotIndex_Selected -= GemSlots;
                }
                else
                {
                    global.Inventory_SlotIndex_Selected += SlotsPerRow;
                    
                    if (global.Inventory_SlotIndex_Selected >= Slots)
                        global.Inventory_SlotIndex_Selected -= Slots;
                }
            }
            until (global.Inventory[global.Inventory_SlotIndex_Selected].Enabled);
            
            _PlaySound = true;
        }
        else if (ItemClassSelected != -1)
        {
            if (input_check_pressed("item") && global.ItemData[ItemClassSelected].CanEquip)
            {
                switch (ItemClassSelected)
                {
                    case UnknownEnum.Value_4:
                        if (global.Inventory_ItemData[UnknownEnum.Value_5].Amount[0] == 0)
                            break;
                    
                    default:
                        global.Inventory_SlotIndex_Equiped = global.Inventory_SlotIndex_Selected;
                        audio_play_sound(Sound_TextDone, 1, false);
                        break;
                }
            }
            else if (input_check_pressed("sword"))
            {
                switch (ItemClassSelected)
                {
                    case UnknownEnum.Value_4:
                        ds_grid_set(MenuItemGrid, 1, 0, global.ItemData[ItemClassSelected].CanEquip && global.Inventory_ItemData[UnknownEnum.Value_5].Amount[0] != 0);
                        break;
                    
                    default:
                        ds_grid_set(MenuItemGrid, 1, 0, global.ItemData[ItemClassSelected].CanEquip);
                        break;
                }
                
                ds_grid_set(MenuItemGrid, 1, 1, global.ItemData[ItemClassSelected].CanUse && Item_CanUse(ItemClassSelected, ItemIndexSelected));
                ds_grid_set(MenuItemGrid, 1, 2, global.Inventory_SlotIndex_Selected >= SlotsPerRow && !oLink.InDoor_Facing);
                MenuSelectionIndex = 0;
                
                while (!ds_grid_get(MenuItemGrid, 1, MenuSelectionIndex))
                    MenuSelectionIndex = (MenuSelectionIndex + 1) % MenuItems;
                
                MenuEnable = true;
                audio_play_sound(Sound_TextDone, 1, false);
            }
        }
        
        if (_PlaySound)
            audio_play_sound_stopall(Sound_Text);
    }
}

if (!global.Inventory_ShowGems && !OpenGems && !CloseGems && global.Inventory_SlotIndex_Selected == global.Inventory_SlotIndex_GemBag)
    OpenGems = true;

if (global.Inventory_ShowGems && !CloseGems && global.Inventory_SlotIndex_Selected != global.Inventory_SlotIndex_GemBag && global.Inventory_SlotIndex_Selected < global.Inventory_SlotIndex_Gems)
{
    CloseGems = true;
    global.Inventory_ShowGems = false;
}

if (DB_Init)
{
    global.DB_Inst = instance_create_layer(0, 0, "System", oDialogueBox);
    global.DB_Inst.depth = depth - 1;
    global.DB_Inst.Y = Y_DialogueBox - oCamera.Y;
    global.DB_Inst.Script = DB_Script;
    DB_Init = false;
    DB_Started = true;
}

if (DB_Started)
{
    if (!instance_exists(global.DB_Inst))
        DB_Started = false;
}

enum UnknownEnum
{
    Value_1 = 1,
    Value_2,
    Value_4 = 4,
    Value_5,
    Value_6,
    Value_9 = 9,
    Value_14 = 14,
    Value_15,
    Value_19 = 19,
    Value_23 = 23,
    Value_38 = 38
}
