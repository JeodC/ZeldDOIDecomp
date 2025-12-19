global.CurseEffectStrArray = ["Collected rupees are\\worth nothing.", "Items that replenish\\magic won't work.", "Items that replenish\\health won't work.", "Picking up hearts reduce\\your health.", "Items that use magic use\\twice as much.", "Your health keeps draining\\down to 2 hearts.", "Shops refuse to sell you\\anything.", "Shops will only sell at\\the highest prices.", "Pendants no longer\\work.", "Attack points are\\reduced by 3.", "Defense points are\\reduced by 3.", "The map is hidden.", "Enemies are tougher."];
global.Cursed = false;
global.CurseEffect = 0;
global.CurseEffectStr = "";
global.CurseTask = 0;
global.CurseTaskStr = "";
global.CurseTaskItem = -1;
global.CurseTaskCount = 0;
global.CurseHealthDrainDelay = 420;
global.CurseLastEffect = -1;
global.CurseLastTask = -1;
global.CurseLastTaskItem = -1;
global.CurseTreasure_HeartPiece = false;
global.CurseTreasure_Rupees = false;
global.CurseLimiter = 0;

function GenerateCurse()
{
    var _CurseEffectList = ds_list_create_sequence(0, 12);
    var _CurseTaskList = ds_list_create_sequence(0, 3);
    
    if (global.Challenges[UnknownEnum.Value_5])
    {
        ds_list_finddelete(_CurseEffectList, UnknownEnum.Value_6);
        ds_list_finddelete(_CurseEffectList, UnknownEnum.Value_7);
        ds_list_finddelete(_CurseEffectList, UnknownEnum.Value_0);
        ds_list_finddelete(_CurseTaskList, UnknownEnum.Value_2);
    }
    
    if (global.Challenges[UnknownEnum.Value_3])
        ds_list_finddelete(_CurseEffectList, UnknownEnum.Value_11);
    
    if (global.Challenges[UnknownEnum.Value_2])
        ds_list_finddelete(_CurseEffectList, UnknownEnum.Value_12);
    
    if (!Inventory_ItemClassExists(UnknownEnum.Value_34))
        ds_list_finddelete(_CurseEffectList, UnknownEnum.Value_8);
    
    if (!Inventory_ItemClassExists(UnknownEnum.Value_9) && !Inventory_ItemClassExists(UnknownEnum.Value_29) && !Inventory_ItemClassExists(UnknownEnum.Value_39) && !Inventory_ItemClassExists(UnknownEnum.Value_38) && !Inventory_ItemClassExists(UnknownEnum.Value_8))
    {
        ds_list_finddelete(_CurseEffectList, UnknownEnum.Value_4);
        ds_list_finddelete(_CurseEffectList, UnknownEnum.Value_1);
    }
    
    if (oLink.AttackPoints <= 3)
        ds_list_finddelete(_CurseEffectList, UnknownEnum.Value_9);
    
    if (oLink.DefensePoints < 3)
        ds_list_finddelete(_CurseEffectList, UnknownEnum.Value_10);
    
    if (ds_list_size(_CurseEffectList) > 1 && global.CurseLastEffect != -1)
        ds_list_finddelete(_CurseEffectList, global.CurseLastEffect);
    
    ds_list_shuffle(_CurseEffectList);
    global.CurseEffect = ds_list_find_value(_CurseEffectList, 0);
    global.CurseEffectStr = global.CurseEffectStrArray[global.CurseEffect];
    global.CurseLastEffect = global.CurseEffect;
    
    switch (global.CurseEffect)
    {
        case UnknownEnum.Value_7:
        case UnknownEnum.Value_6:
        case UnknownEnum.Value_0:
            ds_list_finddelete(_CurseTaskList, UnknownEnum.Value_2);
            break;
    }
    
    if (instance_number(oItem_Treasure) > 1)
        ds_list_finddelete(_CurseTaskList, UnknownEnum.Value_1);
    
    if (ds_list_size(_CurseTaskList) > 1 && global.CurseLastTask != -1)
        ds_list_finddelete(_CurseTaskList, global.CurseLastTask);
    
    ds_list_shuffle(_CurseTaskList);
    global.CurseTask = ds_list_find_value(_CurseTaskList, 0);
    global.CurseLastTask = global.CurseTask;
    ds_list_destroy(_CurseEffectList);
    ds_list_destroy(_CurseTaskList);
    
    switch (global.CurseTask)
    {
        case UnknownEnum.Value_0:
            global.CurseTaskCount = choose(15, 20, 25, 30, 35, 40, 45, 50);
            global.CurseTaskStr = "Kill " + string(global.CurseTaskCount) + " enemies.";
            break;
        
        case UnknownEnum.Value_1:
            global.CurseTaskCount = choose(2, 3, 3, 3, 4, 4, 5);
            global.CurseTaskStr = "Open " + string(global.CurseTaskCount) + " treasures.";
            break;
        
        case UnknownEnum.Value_2:
            global.CurseTaskCount = choose(1, 1, 1, 1, 2, 2, 3);
            global.CurseTaskStr = "Buy " + string(global.CurseTaskCount) + " shop" + ((global.CurseTaskCount == 1) ? " item." : " items.");
            break;
        
        case UnknownEnum.Value_3:
            var ItemList = ds_list_create();
            ds_list_add(ItemList, UnknownEnum.Value_40, UnknownEnum.Value_40, UnknownEnum.Value_40, UnknownEnum.Value_17, UnknownEnum.Value_17, UnknownEnum.Value_17, UnknownEnum.Value_18);
            
            switch (global.CurseEffect)
            {
                case UnknownEnum.Value_0:
                    ds_list_finddelete_all(ItemList, UnknownEnum.Value_40);
                    ds_list_finddelete_all(ItemList, UnknownEnum.Value_18);
                    break;
                
                case UnknownEnum.Value_3:
                    ds_list_finddelete_all(ItemList, UnknownEnum.Value_17);
                    break;
            }
            
            if (!Item_Allowed(UnknownEnum.Value_18, 0, UnknownEnum.Value_22))
                ds_list_finddelete_all(ItemList, UnknownEnum.Value_18);
            
            if (ds_list_size(ItemList) > 1 && global.CurseLastTaskItem != -1)
                ds_list_finddelete(ItemList, global.CurseLastTaskItem);
            
            ds_list_shuffle(ItemList);
            global.CurseTaskItem = ds_list_find_value(ItemList, 0);
            global.CurseLastTaskItem = global.CurseTaskItem;
            ds_list_destroy(ItemList);
            var ItemStr;
            
            switch (global.CurseTaskItem)
            {
                case UnknownEnum.Value_40:
                    global.CurseTaskCount = irandom_range(2, 5) * 20;
                    ItemStr = " rupees.";
                    break;
                
                case UnknownEnum.Value_17:
                    global.CurseTaskCount = irandom_range(5, 10);
                    ItemStr = " hearts.";
                    break;
                
                case UnknownEnum.Value_18:
                    global.CurseTaskCount = 1;
                    ItemStr = " heart container.";
                    break;
            }
            
            global.CurseTaskStr = "Collect " + string(global.CurseTaskCount) + ItemStr;
            break;
    }
    
    Link_UpdateAttackDefence();
}

function Curse_Check(arg0)
{
    return global.Cursed && global.CurseEffect == arg0;
}

function Curse_CheckTask(arg0, arg1 = -1, arg2 = 1)
{
    if (global.Cursed)
    {
        if (global.CurseTask == arg0 && (arg1 == -1 || arg1 == global.CurseTaskItem))
        {
            global.CurseTaskCount -= arg2;
            
            if (global.CurseTaskCount <= 0)
            {
                global.CurseTaskCount = 0;
                
                if (oLink.State == UnknownEnum.Value_19)
                {
                    oLink.UncurseAfterStar = true;
                    return false;
                }
                else
                {
                    MsgBox("Task completed!\\You are now uncursed.", undefined, undefined, Curse_Done);
                }
                
                return true;
            }
        }
    }
    
    return false;
}

function Curse_Done()
{
    global.Cursed = false;
    Link_UpdateAttackDefence();
    
    if (global.CurseEffect == UnknownEnum.Value_12)
    {
        with (oEnemy)
        {
            var _OldEnergy = Energy;
            var _NewEnergyIndex = max(EnergyIndex - 1, 0);
            Enemy_SetEnergy(_NewEnergyIndex);
            Energy = min(_OldEnergy, Energy);
        }
        
        with (oBoss_Lanmola_C)
        {
            EnergyIndex--;
            EnergyMax = Enemy_GetMaxEnergy(EnergyIndex);
            Energy[0] = min(Energy[0], EnergyMax);
            Energy[1] = min(Energy[1], EnergyMax);
            Energy[2] = min(Energy[2], EnergyMax);
        }
    }
}

function Curse_GetItemUncurseMsg(arg0, arg1)
{
    if (global.Cursed)
    {
        if (arg0 == UnknownEnum.Value_34 && arg1 == UnknownEnum.Value_6 && global.CurseEffect != UnknownEnum.Value_8)
        {
            MsgBox("You are now uncursed!", undefined, Sound_Antidote, method(self, Curse_Done));
            global.Cursed = false;
        }
    }
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
    Value_8,
    Value_9,
    Value_10,
    Value_11,
    Value_12,
    Value_17 = 17,
    Value_18,
    Value_19,
    Value_22 = 22,
    Value_29 = 29,
    Value_34 = 34,
    Value_38 = 38,
    Value_39,
    Value_40
}
