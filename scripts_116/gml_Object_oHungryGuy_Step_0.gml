if (DB_Init)
{
    global.DB_Inst = instance_create_layer(0, 0, "System", oDialogueBox);
    global.DB_Inst.Script = DB_Script;
    DB_Init = false;
    DB_Started = true;
}

if (DB_Started)
{
    if (!instance_exists(global.DB_Inst))
    {
        if (global.DB_ExitCode == 1)
        {
            var _MinFoodValue = 100;
            var _InvSlot = 0;
            
            for (var i = 0; i < Inventory_MaxSlots(); i++)
            {
                var _ItemClass = global.Inventory[i].ItemClass;
                var _ItemIndex = global.Inventory[i].ItemIndex;
                var _FoodValue;
                
                switch (_ItemClass)
                {
                    case UnknownEnum.Value_13:
                        switch (_ItemIndex)
                        {
                            default:
                                _FoodValue = FoodHearts(_ItemIndex);
                                break;
                            
                            case UnknownEnum.Value_51:
                                _FoodValue = 0;
                                break;
                        }
                        
                        break;
                    
                    case UnknownEnum.Value_35:
                        _FoodValue = 3;
                        break;
                    
                    case UnknownEnum.Value_36:
                        switch (_ItemIndex)
                        {
                            case UnknownEnum.Value_4:
                                _FoodValue = 8;
                                break;
                            
                            default:
                                continue;
                        }
                        
                        break;
                    
                    default:
                        continue;
                }
                
                if (_MinFoodValue > _FoodValue)
                {
                    _MinFoodValue = _FoodValue;
                    _InvSlot = i;
                }
            }
            
            if (global.Inventory[_InvSlot].ItemClass == UnknownEnum.Value_13 && global.Inventory[_InvSlot].ItemIndex == UnknownEnum.Value_51)
            {
                var _RupeeInst = ItemSpawn(UnknownEnum.Value_40, oLink.x, oLink.y - 16, UnknownEnum.Value_8, UnknownEnum.Value_9, FloorLevel);
                
                with (_RupeeInst)
                {
                    Setup = false;
                    Rupee_Init(500);
                }
            }
            else
            {
                ItemSpawn(UnknownEnum.Value_40, oLink.x, oLink.y - 16, UnknownEnum.Value_5, UnknownEnum.Value_9, FloorLevel);
            }
            
            audio_play_sound(Sound_ItemGetFanfare, 1, false);
            
            with (oLink)
                UpdateState(UnknownEnum.Value_8);
            
            global.Paused = true;
            Inventory_Add(global.Inventory[_InvSlot].ItemClass, global.Inventory[_InvSlot].ItemIndex, -1, _InvSlot);
            ReceivedFood = true;
        }
        
        DB_Started = false;
    }
}

enum UnknownEnum
{
    Value_4 = 4,
    Value_5,
    Value_8 = 8,
    Value_9,
    Value_13 = 13,
    Value_35 = 35,
    Value_36,
    Value_40 = 40,
    Value_51 = 51
}
