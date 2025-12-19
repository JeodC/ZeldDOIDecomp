global.Font_ItemValues = font_add_sprite_ext(sFont_ItemValues, "0123456789O-+", true, 0);
global.NonDuplicatableItemsThatExist = ds_grid_create(2, 0);
global.ItemDropPosTable = [[-20, 0], [20, 0], [0, -20], [-20, 20], [20, 20], [-20, -20], [20, -20], [0, 20]];

function ItemDataInit(arg0, arg1, arg2, arg3, arg4, arg5)
{
    global.ItemData[arg0] = {};
    array_get(global.ItemData, arg0).Type = arg1;
    array_get(global.ItemData, arg0).CanEquip = (arg2 == 0) ? false : true;
    array_get(global.ItemData, arg0).CanUse = (arg3 == 0) ? false : true;
    array_get(global.ItemData, arg0).LimitMin = arg4;
    array_get(global.ItemData, arg0).LimitStart = arg5;
    array_get(global.ItemData, arg0).LimitCount = TreasureLimiter_NewLimitCount(arg5);
}

function Items_InitData()
{
    ItemDataInit(UnknownEnum.Value_2, UnknownEnum.Value_2, 0, 0, 10, 7);
    ItemDataInit(UnknownEnum.Value_0, UnknownEnum.Value_1, 0, 0, 0, 7);
    ItemDataInit(UnknownEnum.Value_4, UnknownEnum.Value_1, 1, 1, 0, 7);
    ItemDataInit(UnknownEnum.Value_15, UnknownEnum.Value_1, 0, 0, 0, 7);
    ItemDataInit(UnknownEnum.Value_1, UnknownEnum.Value_3, 0, 0, 5, 0);
    ItemDataInit(UnknownEnum.Value_5, UnknownEnum.Value_3, 1, 1, 5, 0);
    ItemDataInit(UnknownEnum.Value_6, UnknownEnum.Value_1, 1, 0, 0, 0);
    ItemDataInit(UnknownEnum.Value_7, UnknownEnum.Value_2, 1, 0, 8, 5);
    ItemDataInit(UnknownEnum.Value_8, UnknownEnum.Value_4, 1, 0, 8, 6);
    ItemDataInit(UnknownEnum.Value_9, UnknownEnum.Value_1, 1, 1, 0, 8);
    ItemDataInit(UnknownEnum.Value_10, UnknownEnum.Value_1, 0, 0, 4, 0);
    ItemDataInit(UnknownEnum.Value_48, UnknownEnum.Value_3, 1, 0, 7, 4);
    ItemDataInit(UnknownEnum.Value_11, UnknownEnum.Value_1, 0, 0, 0, 0);
    ItemDataInit(UnknownEnum.Value_12, UnknownEnum.Value_0, 0, 0, 0, 0);
    ItemDataInit(UnknownEnum.Value_13, UnknownEnum.Value_3, 1, 1, 4, 0);
    ItemDataInit(UnknownEnum.Value_14, UnknownEnum.Value_3, 1, 1, 4, 0);
    ItemDataInit(UnknownEnum.Value_16, UnknownEnum.Value_2, 0, 0, 7, 5);
    ItemDataInit(UnknownEnum.Value_17, UnknownEnum.Value_0, 0, 0, 0, 0);
    ItemDataInit(UnknownEnum.Value_18, UnknownEnum.Value_0, 0, 0, 6, 3);
    ItemDataInit(UnknownEnum.Value_19, UnknownEnum.Value_1, 1, 0, 0, 0);
    ItemDataInit(UnknownEnum.Value_20, UnknownEnum.Value_0, 0, 0, 0, 0);
    ItemDataInit(UnknownEnum.Value_21, UnknownEnum.Value_1, 0, 0, 0, 0);
    ItemDataInit(UnknownEnum.Value_23, UnknownEnum.Value_3, 0, 0, 4, 0);
    ItemDataInit(UnknownEnum.Value_24, UnknownEnum.Value_1, 0, 0, 8, 8);
    ItemDataInit(UnknownEnum.Value_26, UnknownEnum.Value_0, 0, 0, 0, 0);
    ItemDataInit(UnknownEnum.Value_27, UnknownEnum.Value_3, 1, 1, 6, 0);
    ItemDataInit(UnknownEnum.Value_28, UnknownEnum.Value_1, 0, 0, 4, 0);
    ItemDataInit(UnknownEnum.Value_31, UnknownEnum.Value_1, 0, 0, 0, 0);
    ItemDataInit(UnknownEnum.Value_33, UnknownEnum.Value_3, 1, 1, 5, 0);
    ItemDataInit(UnknownEnum.Value_34, UnknownEnum.Value_1, 0, 0, 7, 6);
    ItemDataInit(UnknownEnum.Value_36, UnknownEnum.Value_5, 1, 1, 6, 2);
    ItemDataInit(UnknownEnum.Value_35, UnknownEnum.Value_3, 1, 1, 6, 0);
    ItemDataInit(UnknownEnum.Value_38, UnknownEnum.Value_1, 1, 1, 7, 6);
    ItemDataInit(UnknownEnum.Value_39, UnknownEnum.Value_4, 1, 0, 7, 6);
    ItemDataInit(UnknownEnum.Value_40, UnknownEnum.Value_0, 0, 0, 1, 0);
    ItemDataInit(UnknownEnum.Value_41, UnknownEnum.Value_2, 0, 0, 7, 4);
    ItemDataInit(UnknownEnum.Value_43, UnknownEnum.Value_0, 0, 0, 0, 0);
    ItemDataInit(UnknownEnum.Value_42, UnknownEnum.Value_0, 0, 0, 0, 0);
    ItemDataInit(UnknownEnum.Value_44, UnknownEnum.Value_2, 0, 0, 7, 4);
    ItemDataInit(UnknownEnum.Value_45, UnknownEnum.Value_5, 0, 0, 0, 0);
    ItemDataInit(UnknownEnum.Value_46, UnknownEnum.Value_2, 0, 0, 7, 4);
    ItemDataInit(UnknownEnum.Value_3, UnknownEnum.Value_1, 0, 0, 0, 0);
    ItemDataInit(UnknownEnum.Value_22, UnknownEnum.Value_1, 0, 0, 0, 0);
    ItemDataInit(UnknownEnum.Value_25, UnknownEnum.Value_1, 0, 0, 0, 0);
    ItemDataInit(UnknownEnum.Value_29, UnknownEnum.Value_1, 1, 1, 0, 0);
    ItemDataInit(UnknownEnum.Value_30, UnknownEnum.Value_1, 0, 0, 0, 0);
    ItemDataInit(UnknownEnum.Value_32, UnknownEnum.Value_1, 0, 0, 0, 0);
    ItemDataInit(UnknownEnum.Value_37, UnknownEnum.Value_1, 1, 0, 0, 0);
    ItemDataInit(UnknownEnum.Value_47, UnknownEnum.Value_3, 1, 1, 0, 0);
    global.PossibleItemLists = [];
    global.PossibleItemLists[UnknownEnum.Value_0] = ds_list_create();
    
    repeat (49)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_0], UnknownEnum.Value_40);
    
    repeat (29)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_0], UnknownEnum.Value_17);
    
    repeat (26)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_0], UnknownEnum.Value_26);
    
    repeat (5)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_0], UnknownEnum.Value_5);
    
    repeat (5)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_0], UnknownEnum.Value_1);
    
    repeat (4)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_0], UnknownEnum.Value_14);
    
    repeat (4)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_0], UnknownEnum.Value_43);
    
    repeat (3)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_0], UnknownEnum.Value_13);
    
    repeat (3)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_0], UnknownEnum.Value_12);
    
    repeat (3)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_0], UnknownEnum.Value_33);
    
    repeat (2)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_0], UnknownEnum.Value_23);
    
    repeat (2)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_0], UnknownEnum.Value_35);
    
    repeat (1)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_0], UnknownEnum.Value_48);
    
    repeat (1)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_0], UnknownEnum.Value_27);
    
    global.PossibleItemLists[UnknownEnum.Value_1] = ds_list_create();
    
    repeat (10)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_1], UnknownEnum.Value_40);
    
    repeat (5)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_1], UnknownEnum.Value_17);
    
    repeat (4)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_1], UnknownEnum.Value_26);
    
    repeat (2)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_1], UnknownEnum.Value_5);
    
    repeat (2)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_1], UnknownEnum.Value_1);
    
    global.PossibleItemLists[UnknownEnum.Value_2] = ds_list_create();
    
    repeat (39)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_40);
    
    repeat (4)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_28);
    
    repeat (4)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_10);
    
    repeat (3)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_14);
    
    repeat (3)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_23);
    
    repeat (3)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_27);
    
    repeat (3)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_13);
    
    repeat (3)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_35);
    
    repeat (3)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_33);
    
    repeat (3)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_36);
    
    repeat (3)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_1);
    
    repeat (3)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_5);
    
    repeat (2)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_18);
    
    repeat (2)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_48);
    
    repeat (1)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_7);
    
    repeat (1)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_38);
    
    repeat (1)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_39);
    
    repeat (1)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_41);
    
    repeat (1)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_44);
    
    repeat (1)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_46);
    
    repeat (1)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_16);
    
    repeat (1)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_2);
    
    repeat (1)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_0);
    
    repeat (1)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_4);
    
    repeat (1)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_15);
    
    repeat (1)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_24);
    
    repeat (1)
        ds_list_add(global.PossibleItemLists[UnknownEnum.Value_2], UnknownEnum.Value_9);
    
    global.PossibleItemLists[UnknownEnum.Value_3] = ds_list_create();
    ds_list_add(global.PossibleItemLists[UnknownEnum.Value_3], UnknownEnum.Value_2, UnknownEnum.Value_0, UnknownEnum.Value_4, UnknownEnum.Value_15, UnknownEnum.Value_7, UnknownEnum.Value_9, UnknownEnum.Value_16, UnknownEnum.Value_24, UnknownEnum.Value_34, UnknownEnum.Value_38, UnknownEnum.Value_39, UnknownEnum.Value_41, UnknownEnum.Value_44, UnknownEnum.Value_46);
    global.PossibleItemLists[UnknownEnum.Value_4] = ds_list_create();
    ds_list_add(global.PossibleItemLists[UnknownEnum.Value_4], UnknownEnum.Value_2, UnknownEnum.Value_2, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_4, UnknownEnum.Value_4, UnknownEnum.Value_15, UnknownEnum.Value_15, UnknownEnum.Value_1, UnknownEnum.Value_5, UnknownEnum.Value_7, UnknownEnum.Value_7, UnknownEnum.Value_7, UnknownEnum.Value_9, UnknownEnum.Value_13, UnknownEnum.Value_13, UnknownEnum.Value_13, UnknownEnum.Value_16, UnknownEnum.Value_16, UnknownEnum.Value_16, UnknownEnum.Value_18, UnknownEnum.Value_18, UnknownEnum.Value_18, UnknownEnum.Value_20, UnknownEnum.Value_24, UnknownEnum.Value_24, UnknownEnum.Value_27, UnknownEnum.Value_27, UnknownEnum.Value_33, UnknownEnum.Value_33, UnknownEnum.Value_34, UnknownEnum.Value_34, UnknownEnum.Value_34, UnknownEnum.Value_36, UnknownEnum.Value_36, UnknownEnum.Value_36, UnknownEnum.Value_35, UnknownEnum.Value_35, UnknownEnum.Value_38, UnknownEnum.Value_38, UnknownEnum.Value_38, UnknownEnum.Value_39, UnknownEnum.Value_39, UnknownEnum.Value_39, UnknownEnum.Value_41, UnknownEnum.Value_41, UnknownEnum.Value_41, UnknownEnum.Value_44, UnknownEnum.Value_44, UnknownEnum.Value_44, UnknownEnum.Value_45, UnknownEnum.Value_45, UnknownEnum.Value_45, UnknownEnum.Value_46, UnknownEnum.Value_46, UnknownEnum.Value_46);
    global.PossibleItemLists[UnknownEnum.Value_5] = ds_list_create();
    ds_list_add(global.PossibleItemLists[UnknownEnum.Value_5], UnknownEnum.Value_1, UnknownEnum.Value_5, UnknownEnum.Value_13, UnknownEnum.Value_14, UnknownEnum.Value_27, UnknownEnum.Value_33, UnknownEnum.Value_35, UnknownEnum.Value_40, UnknownEnum.Value_40);
    global.PossibleItemLists[UnknownEnum.Value_6] = ds_list_create();
    ds_list_add(global.PossibleItemLists[UnknownEnum.Value_6], UnknownEnum.Value_13, UnknownEnum.Value_18, UnknownEnum.Value_36, UnknownEnum.Value_40, UnknownEnum.Value_40);
    global.PossibleItemLists[UnknownEnum.Value_7] = ds_list_create();
    ds_list_add(global.PossibleItemLists[UnknownEnum.Value_7], UnknownEnum.Value_0, UnknownEnum.Value_4, UnknownEnum.Value_7, UnknownEnum.Value_24, UnknownEnum.Value_38, UnknownEnum.Value_39, UnknownEnum.Value_40, UnknownEnum.Value_40);
    global.PossibleItemLists[UnknownEnum.Value_8] = ds_list_create();
    ds_list_add(global.PossibleItemLists[UnknownEnum.Value_8], UnknownEnum.Value_2, UnknownEnum.Value_9, UnknownEnum.Value_15, UnknownEnum.Value_16, UnknownEnum.Value_34, UnknownEnum.Value_40, UnknownEnum.Value_40, UnknownEnum.Value_41, UnknownEnum.Value_44, UnknownEnum.Value_46);
    global.PossibleItemLists[UnknownEnum.Value_9] = ds_list_create();
    ds_list_add(global.PossibleItemLists[UnknownEnum.Value_9], UnknownEnum.Value_1, UnknownEnum.Value_0, UnknownEnum.Value_4, UnknownEnum.Value_5, UnknownEnum.Value_6, UnknownEnum.Value_7, UnknownEnum.Value_7, UnknownEnum.Value_7, UnknownEnum.Value_7, UnknownEnum.Value_16, UnknownEnum.Value_16, UnknownEnum.Value_16, UnknownEnum.Value_19, UnknownEnum.Value_41, UnknownEnum.Value_41, UnknownEnum.Value_41, UnknownEnum.Value_44, UnknownEnum.Value_44, UnknownEnum.Value_44, UnknownEnum.Value_44, UnknownEnum.Value_46, UnknownEnum.Value_46, UnknownEnum.Value_46);
    global.PossibleItemLists[UnknownEnum.Value_10] = ds_list_create();
    ds_list_add(global.PossibleItemLists[UnknownEnum.Value_10], UnknownEnum.Value_2, UnknownEnum.Value_2, UnknownEnum.Value_2, UnknownEnum.Value_2, UnknownEnum.Value_2, UnknownEnum.Value_15, UnknownEnum.Value_15, UnknownEnum.Value_15, UnknownEnum.Value_18, UnknownEnum.Value_18, UnknownEnum.Value_21, UnknownEnum.Value_31, UnknownEnum.Value_24, UnknownEnum.Value_24, UnknownEnum.Value_24, UnknownEnum.Value_24, UnknownEnum.Value_33, UnknownEnum.Value_23, UnknownEnum.Value_23, UnknownEnum.Value_45, UnknownEnum.Value_45, UnknownEnum.Value_45);
    global.PossibleItemLists[UnknownEnum.Value_11] = ds_list_create();
    ds_list_add(global.PossibleItemLists[UnknownEnum.Value_11], UnknownEnum.Value_9, UnknownEnum.Value_9, UnknownEnum.Value_33, UnknownEnum.Value_34, UnknownEnum.Value_34, UnknownEnum.Value_34, UnknownEnum.Value_34, UnknownEnum.Value_38, UnknownEnum.Value_38, UnknownEnum.Value_38, UnknownEnum.Value_39, UnknownEnum.Value_39, UnknownEnum.Value_39, UnknownEnum.Value_39);
    global.PossibleItemLists[UnknownEnum.Value_12] = ds_list_create();
    ds_list_add(global.PossibleItemLists[UnknownEnum.Value_12], UnknownEnum.Value_0, UnknownEnum.Value_2, UnknownEnum.Value_4, UnknownEnum.Value_15, UnknownEnum.Value_7, UnknownEnum.Value_9, UnknownEnum.Value_16, UnknownEnum.Value_24, UnknownEnum.Value_34, UnknownEnum.Value_38, UnknownEnum.Value_39, UnknownEnum.Value_41, UnknownEnum.Value_44, UnknownEnum.Value_46);
}

function Item_Name(arg0, arg1, arg2 = 1)
{
    switch (arg0)
    {
        case UnknownEnum.Value_0:
            return "Arrow Quiver";
        
        case UnknownEnum.Value_1:
            return "Arrows";
        
        case UnknownEnum.Value_2:
            return (arg1 == -1) ? "Invalid name" : ("Level " + string(arg1 + 1) + " Inventory Bag");
        
        case UnknownEnum.Value_4:
            return "Bomb Bag";
        
        case UnknownEnum.Value_15:
            return "Treasure Bag";
        
        case UnknownEnum.Value_5:
            return "Bombs";
        
        case UnknownEnum.Value_6:
            return "Boomerang";
        
        case UnknownEnum.Value_7:
            switch (arg1)
            {
                case UnknownEnum.Value_0:
                    return "Bow";
                
                case UnknownEnum.Value_1:
                    return "Spread Bow";
            }
            
            break;
        
        case UnknownEnum.Value_9:
            return "Magic Cape";
        
        case UnknownEnum.Value_10:
            return "Compass";
        
        case UnknownEnum.Value_48:
            return "Coupon";
        
        case UnknownEnum.Value_13:
            return (arg1 == -1) ? "Invalid name" : ((arg2 > 1) ? global.FoodNames_Plural[arg1] : global.FoodNames[arg1]);
        
        case UnknownEnum.Value_14:
            return (arg1 == -1) ? "Invalid name" : (global.GemNames[arg1] + " Gemstone");
        
        case UnknownEnum.Value_16:
            switch (arg1)
            {
                case 0:
                    return "Leather Gloves";
                
                case 1:
                    return "Power Gloves";
                
                case 2:
                    return "Super-Duper Gloves";
            }
            
            break;
        
        case UnknownEnum.Value_18:
            return "Heart Container";
        
        case UnknownEnum.Value_19:
            return "Hookshot";
        
        case UnknownEnum.Value_20:
            return "Spare Key";
        
        case UnknownEnum.Value_21:
            return "Master Key";
        
        case UnknownEnum.Value_23:
            switch (arg1)
            {
                case 0:
                    return "Green Kinstone Piece";
                
                case 1:
                    return "Blue Kinstone Piece";
                
                case 2:
                    return "Red Kinstone Piece";
                
                case 3:
                    return "Gold Kinstone Piece";
            }
            
            break;
        
        case UnknownEnum.Value_24:
            return "Oil Lamp";
            break;
        
        case UnknownEnum.Value_26:
            return "Small Magic Refill";
        
        case UnknownEnum.Value_27:
            return "Large Magic Refill";
        
        case UnknownEnum.Value_28:
            return "Map";
        
        case UnknownEnum.Value_31:
            return "Moon Pearl";
        
        case UnknownEnum.Value_33:
            return (arg1 == -1) ? "Invalid name" : (global.OrbNames[arg1] + " Orb" + ((arg2 > 1) ? "s" : ""));
        
        case UnknownEnum.Value_34:
            return (arg1 == -1) ? "Invalid name" : ("Pendant of " + global.PendantNames[arg1]);
        
        case UnknownEnum.Value_35:
            return (arg1 == -1) ? "Invalid name" : ("Can" + ((arg2 > 1) ? "s" : "") + " of " + global.PopNames[arg1]);
        
        case UnknownEnum.Value_36:
            return (arg1 == -1) ? "Invalid name" : global.PotionNames[arg1];
        
        case UnknownEnum.Value_38:
            return (arg1 == -1) ? "Invalid name" : ("Ring of " + global.RingNames[arg1]);
        
        case UnknownEnum.Value_39:
            return (arg1 == -1) ? "Invalid name" : ("Rod of " + global.RodNames[arg1]);
        
        case UnknownEnum.Value_41:
            return (arg1 == -1) ? "Invalid name" : (global.ShieldNames[arg1] + " Shield");
        
        case UnknownEnum.Value_44:
            return (arg1 == -1) ? "Invalid name" : (global.SwordName[arg1] + " Sword");
        
        case UnknownEnum.Value_45:
            return "Treasure Chest";
        
        case UnknownEnum.Value_46:
            return (arg1 == -1) ? "Invalid name" : ("Level " + string(arg1 + 1) + " Tunic");
        
        case UnknownEnum.Value_3:
            return "The All-Donut Diet Book";
        
        case UnknownEnum.Value_30:
            return "Mirror";
        
        case UnknownEnum.Value_32:
            return "Mushroom";
        
        case UnknownEnum.Value_37:
            return "Magic Powder";
        
        case UnknownEnum.Value_29:
            return "Bombos Medallion";
        
        case UnknownEnum.Value_22:
            return "Treasure Room Key";
        
        case UnknownEnum.Value_25:
            return "Pezo's Letter";
        
        case UnknownEnum.Value_47:
            return "Wishing Stone";
    }
    
    return "Item Name Unavailable";
}

function Item_Info(arg0, arg1)
{
    switch (arg0)
    {
        case UnknownEnum.Value_1:
            return "Use with a bow to shoot enemies.";
        
        case UnknownEnum.Value_0:
            return "Increases your arrow capacity to 80. Arrows no longer take up an inventory slot.";
        
        case UnknownEnum.Value_4:
            return "Increases your bomb capacity to 16. Bombs no longer take up an inventory slot.";
        
        case UnknownEnum.Value_15:
            return "A seperate bag to hold your gems and kinstones.";
        
        case UnknownEnum.Value_2:
            return "Holds up to " + string(Inventory_MaxSlots_Useable(arg1)) + " items.";
        
        case UnknownEnum.Value_6:
            return "Stuns enemies, kills small ones, shoots in 8 directions.";
        
        case UnknownEnum.Value_5:
            return "Blow stuff up!";
        
        case UnknownEnum.Value_7:
            switch (arg1)
            {
                case UnknownEnum.Value_0:
                    return "Shoots arrows.";
                
                case UnknownEnum.Value_1:
                    return "Shoots 3 arrows at the cost of 1 arrow.";
            }
            
            break;
        
        case UnknownEnum.Value_19:
            return "Stuns enemies, kills small ones, can pick up items.";
        
        case UnknownEnum.Value_28:
            return "Reveals all unexplored rooms on the dungeon map.";
        
        case UnknownEnum.Value_10:
            return "Reveals doors and important locations on the dungeon map.";
        
        case UnknownEnum.Value_48:
            switch (arg1)
            {
                case UnknownEnum.Value_0:
                    return "15% off any shop item. Equip to apply.";
                
                case UnknownEnum.Value_1:
                    return "30% off any shop item. Equip to apply.";
                
                case UnknownEnum.Value_2:
                    return "50% off any shop item. Equip to apply.";
                
                case UnknownEnum.Value_3:
                    return "Good for 1 free magic refill item at any shop. Equip to apply.";
                
                case UnknownEnum.Value_4:
                    return "Good for 1 free health item at any shop. Equip to apply.";
                
                case UnknownEnum.Value_5:
                    return "Good for 1 free treasure chest at any shop. Equip to apply.";
            }
            
            break;
        
        case UnknownEnum.Value_38:
            switch (arg1)
            {
                case UnknownEnum.Value_0:
                    return "Converts magic from your magic meter into hearts.";
                
                case UnknownEnum.Value_1:
                    return "Converts magic from your magic meter into rupees.";
                
                case UnknownEnum.Value_2:
                    return "Converts magic from your magic meter into bombs.";
                
                case UnknownEnum.Value_3:
                    return "Converts magic from your magic meter into arrows.";
            }
            
            break;
        
        case UnknownEnum.Value_39:
            switch (arg1)
            {
                case UnknownEnum.Value_0:
                    return "Shoot a beam that turns enemies into stone. Needs to be charged.";
                
                case UnknownEnum.Value_1:
                    return "Shoot a beam that turns enemies into ice. Needs to be charged.";
                
                case UnknownEnum.Value_2:
                    return "Shoot a beam that ignites enemies on fire. Needs to be charged.";
                
                case UnknownEnum.Value_3:
                    return "Shoot a beam that turns enemies into ignited bombs. Needs to be charged.";
                
                case UnknownEnum.Value_4:
                    return "Shoot a beam that turns enemies into hearts. Needs to be charged.";
                
                case UnknownEnum.Value_5:
                    return "Shoot a beam that turns enemies into rupees. Needs to be charged.";
            }
            
            break;
        
        case UnknownEnum.Value_9:
            return "You are invisible when you wear it. Uses magic.";
        
        case UnknownEnum.Value_14:
            return "Find one of Zora's ponds to trade gems for items.";
        
        case UnknownEnum.Value_13:
            switch (arg1)
            {
                default:
                    var _FoodHearts = FoodHearts(arg1);
                    return "Replenishes " + string(_FoodHearts) + " hearts.";
                
                case UnknownEnum.Value_51:
                    return "Replenishes all of your health and gives you 200 rupees.";
            }
        
        case UnknownEnum.Value_35:
            return "Replenishes 3 hearts.";
        
        case UnknownEnum.Value_27:
            return "Fills up 50% of your magic meter.";
        
        case UnknownEnum.Value_18:
            return "Increases your max health by 1.";
        
        case UnknownEnum.Value_45:
            return "Contains a random item inside. Could be good, could be bad. Take a risk and find out.";
        
        case UnknownEnum.Value_20:
            return "Spare key to unlock a door.";
        
        case UnknownEnum.Value_21:
            return "Unlocks all regular locked doors.";
        
        case UnknownEnum.Value_31:
            return "Colored gates will automatically lower when you walk up to them. No need to activate the crystal switches.";
        
        case UnknownEnum.Value_44:
            var _Str = "+" + string(arg1 + 1) + " Attack";
            
            switch (arg1)
            {
                case UnknownEnum.Value_2:
                    _Str += ". Break pots with your sword.";
                    break;
                
                case UnknownEnum.Value_3:
                    _Str += ". Shock resistant.";
                    break;
                
                case UnknownEnum.Value_4:
                    _Str += ". Destroy more enemy types.";
                    break;
                
                case UnknownEnum.Value_5:
                    _Str += ". Shoot a beam when at max health.";
                    break;
            }
            
            return _Str;
        
        case UnknownEnum.Value_46:
            return "+" + string(arg1) + " Defense";
        
        case UnknownEnum.Value_41:
            switch (arg1)
            {
                case 0:
                    return "+" + string(arg1 + 1) + " Defense. Blocks small projectiles.";
                    break;
                
                case 1:
                    return "+" + string(arg1 + 1) + " Defense. Blocks larger projectiles and small fireballs.";
                    break;
                
                case 2:
                    return "+" + string(arg1 + 1) + " Defense. Blocks larger projectiles, large fireballs, and magic beams.";
                    break;
                
                case 3:
                    return "+" + string(arg1 + 1) + " Defense. Blocks all projectiles, magic beams, and lasers.";
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_16:
            switch (arg1)
            {
                case 0:
                    return "+1 Defense";
                
                case 1:
                    return "+1 Attack, +1 Defense";
                
                case 2:
                    return "+2 Attack, +1 Defense";
            }
            
            break;
        
        case UnknownEnum.Value_23:
            return "Find the other half of this kinstone and fuse them together.";
        
        case UnknownEnum.Value_25:
            return "Deliver this to his friend who lives in the rebel village.";
        
        case UnknownEnum.Value_47:
            return "Throw this stone into a wishing pond and make a wish.";
        
        case UnknownEnum.Value_24:
            return "Shines brighter than the candle.";
            break;
        
        case UnknownEnum.Value_33:
            switch (arg1)
            {
                case UnknownEnum.Value_0:
                    return "Break to unleash a fire storm.";
                
                case UnknownEnum.Value_1:
                    return "Break to unleash an ice storm.";
                
                case UnknownEnum.Value_2:
                    return "Break to reveal 2 fairies inside.";
            }
            
            break;
        
        case UnknownEnum.Value_34:
            switch (arg1)
            {
                case UnknownEnum.Value_0:
                    return "+25% bonus for items that replenish your health.";
                
                case UnknownEnum.Value_1:
                    return "Items that use magic will use 25% less.";
                
                case UnknownEnum.Value_2:
                    return "Protects you against floor spikes and explosion blasts.";
                
                case UnknownEnum.Value_5:
                    return "You will be alerted when a hidden door is in the room.";
                
                case UnknownEnum.Value_4:
                    return "Gives you a permanent map and compass, revealing all dungeon rooms and special locations.";
                
                case UnknownEnum.Value_6:
                    return "Blocks all curses.";
                
                case UnknownEnum.Value_7:
                    return "+20% bonus added to all collected rupees.";
                
                case UnknownEnum.Value_3:
                    return "You will be revived if you die. You will lose this pendant afterwards.";
            }
            
            break;
        
        case UnknownEnum.Value_36:
            switch (arg1)
            {
                case UnknownEnum.Value_0:
                    return "Restores all your health.";
                
                case UnknownEnum.Value_1:
                    return "Restores all your magic.";
                
                case UnknownEnum.Value_2:
                    return "Restores all your health and magic.";
                
                case UnknownEnum.Value_3:
                    return "Cancels the effect of curses.";
                
                case UnknownEnum.Value_4:
                    return "Restores 8 hearts.";
            }
            
            break;
        
        case UnknownEnum.Value_3:
            return "Probably belongs to the library.";
        
        case UnknownEnum.Value_30:
            return "Someone is probably looking for this.";
        
        case UnknownEnum.Value_32:
            return "Sweet and magical smelling.";
        
        case UnknownEnum.Value_37:
            return "Sprinkle it on things, who knows what might happen. Uses magic.";
        
        case UnknownEnum.Value_29:
            return "Wreak havoc! Uses magic.";
        
        case UnknownEnum.Value_22:
            return "Key to the King's treasure room!";
    }
    
    return "No Info Available";
}

function Item_Price(arg0, arg1, arg2)
{
    var Price = 20;
    
    switch (arg0)
    {
        case UnknownEnum.Value_1:
            Price = arg2 / 2;
            break;
        
        case UnknownEnum.Value_5:
            Price = arg2 * 3;
            break;
        
        case UnknownEnum.Value_35:
            Price = arg2 * 8;
            break;
        
        case UnknownEnum.Value_33:
            switch (arg1)
            {
                case UnknownEnum.Value_0:
                case UnknownEnum.Value_1:
                    Price = arg2 * 6;
                    break;
                
                case UnknownEnum.Value_2:
                    Price = 25;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_10:
        case UnknownEnum.Value_28:
        case UnknownEnum.Value_20:
            Price = irandom_range(10, 20);
            break;
        
        case UnknownEnum.Value_13:
            var _FoodHearts = FoodHearts(arg1);
            Price = 5 + ((_FoodHearts - 1) * 5);
            break;
        
        case UnknownEnum.Value_14:
            Price = 10 + (arg1 * 3);
            break;
        
        case UnknownEnum.Value_27:
            Price = 25;
            break;
        
        case UnknownEnum.Value_45:
            Price = 30;
            break;
        
        case UnknownEnum.Value_23:
            Price = 10 + (arg1 * 10);
            break;
        
        case UnknownEnum.Value_36:
            switch (arg1)
            {
                case UnknownEnum.Value_4:
                    Price = 40;
                    break;
                
                case UnknownEnum.Value_1:
                case UnknownEnum.Value_0:
                case UnknownEnum.Value_3:
                    Price = 50;
                    break;
                
                case UnknownEnum.Value_2:
                    Price = 60;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_39:
            switch (arg1)
            {
                case UnknownEnum.Value_0:
                    Price = irandom_range(40, 60);
                    break;
                
                case UnknownEnum.Value_3:
                case UnknownEnum.Value_1:
                case UnknownEnum.Value_2:
                    Price = irandom_range(60, 80);
                    break;
                
                case UnknownEnum.Value_4:
                case UnknownEnum.Value_5:
                    Price = irandom_range(80, 100);
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_44:
        case UnknownEnum.Value_46:
        case UnknownEnum.Value_41:
            Price = irandom_range(30, 50) + (arg1 * 20);
            break;
        
        case UnknownEnum.Value_16:
        case UnknownEnum.Value_8:
            Price = 50 + (arg1 * 25);
            break;
        
        case UnknownEnum.Value_18:
            Price = 50;
            break;
        
        case UnknownEnum.Value_24:
            Price = 60;
            break;
        
        case UnknownEnum.Value_38:
            switch (arg1)
            {
                case UnknownEnum.Value_3:
                case UnknownEnum.Value_2:
                    Price = irandom_range(70, 90);
                    break;
                
                case UnknownEnum.Value_0:
                case UnknownEnum.Value_1:
                    Price = irandom_range(90, 120);
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_34:
            switch (arg1)
            {
                case UnknownEnum.Value_1:
                case UnknownEnum.Value_0:
                case UnknownEnum.Value_2:
                    Price = irandom_range(65, 85);
                    break;
                
                case UnknownEnum.Value_6:
                case UnknownEnum.Value_3:
                case UnknownEnum.Value_4:
                    Price = irandom_range(80, 100);
                    break;
                
                case UnknownEnum.Value_7:
                    Price = irandom_range(100, 125);
                    break;
                
                case UnknownEnum.Value_5:
                    Price = irandom_range(125, 150);
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_2:
            Price = irandom_range(60, 85) + (arg1 * 30);
            break;
        
        case UnknownEnum.Value_0:
        case UnknownEnum.Value_4:
            Price = irandom_range(60, 85);
            break;
        
        case UnknownEnum.Value_7:
            switch (arg1)
            {
                default:
                    Price = irandom_range(60, 85);
                    break;
                
                case UnknownEnum.Value_1:
                    Price = irandom_range(125, 175);
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_9:
        case UnknownEnum.Value_15:
            Price = irandom_range(90, 125);
            break;
        
        case UnknownEnum.Value_6:
        case UnknownEnum.Value_19:
            Price = irandom_range(125, 175);
            break;
        
        case UnknownEnum.Value_31:
        case UnknownEnum.Value_21:
            Price = irandom_range(175, 250);
            break;
    }
    
    return Price;
}

function Item_Price_RoundToNearest(arg0, arg1)
{
    return min(round(arg0 / arg1) * arg1, 999);
}

function Item_Allowed(arg0, arg1 = -1, arg2 = UnknownEnum.Value_22)
{
    if (FromAnySmallTreasure(arg2) && global.ItemData[arg0].LimitCount > 0 && !FromAnyKinstone(arg2))
        return false;
    
    switch (global.ItemData[arg0].Type)
    {
        default:
            switch (arg0)
            {
                case UnknownEnum.Value_18:
                    if (global.Inventory_ItemData[UnknownEnum.Value_18].Amount >= (global.Challenges[UnknownEnum.Value_0] ? 5 : 16))
                        return false;
                    
                    if (FromAnyStore(arg2) && global.Level.ShopHeartPiecesCreated > 0)
                        return false;
                    
                    break;
                
                case UnknownEnum.Value_20:
                    if (global.Inventory_ItemData[UnknownEnum.Value_20].Amount >= 9)
                        return false;
                    
                    if (arg2 == UnknownEnum.Value_4 && global.Level.ShopKeysCreated > 0)
                        return false;
                    
                    break;
                
                case UnknownEnum.Value_27:
                    if (arg2 == UnknownEnum.Value_4 && global.Level.ShopLargeMagicCreated > 0)
                        return false;
                    
                    break;
                
                case UnknownEnum.Value_1:
                    if (arg2 == UnknownEnum.Value_4 && global.Level.ShopArrowsCreated > 0)
                        return false;
                    
                    break;
                
                case UnknownEnum.Value_5:
                    if (arg2 == UnknownEnum.Value_4 && global.Level.ShopBombsCreated > 0)
                        return false;
                    
                    break;
                
                case UnknownEnum.Value_33:
                    if (arg2 == UnknownEnum.Value_4 && global.Level.ShopOrbsCreated > 0)
                        return false;
                    
                    break;
                
                case UnknownEnum.Value_35:
                    if (arg2 == UnknownEnum.Value_4 && global.Level.ShopPopsCreated > 0)
                        return false;
                    
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_4:
            switch (arg0)
            {
                case UnknownEnum.Value_28:
                case UnknownEnum.Value_10:
                    if (global.Level.RoomsVistedPercent > 0.6 || global.Inventory_ItemData[UnknownEnum.Value_34].Owns[UnknownEnum.Value_4] || global.Challenges[UnknownEnum.Value_3] || global.Level.Index == UnknownEnum.Value_6 || global.Level.Index == UnknownEnum.Value_10)
                        return false;
                    
                    break;
                
                case UnknownEnum.Value_24:
                    if (global.Challenges[UnknownEnum.Value_4] || !global.GlobalLighting)
                        return false;
                    
                    break;
            }
            
            var _IndexesToCheckList;
            
            if (arg1 == -1)
            {
                _IndexesToCheckList = ds_list_create_sequence(0, array_length(global.Inventory_ItemData[arg0].Owns) - 1);
            }
            else
            {
                _IndexesToCheckList = ds_list_create();
                ds_list_add(_IndexesToCheckList, arg1);
            }
            
            var ItemIsAvailable = false;
            var Indexes = ds_list_size(_IndexesToCheckList);
            
            for (var _ListIndex = 0; _ListIndex < Indexes; _ListIndex++)
            {
                var _Index = ds_list_find_value(_IndexesToCheckList, _ListIndex);
                
                switch (arg0)
                {
                    case UnknownEnum.Value_34:
                        switch (_Index)
                        {
                            case UnknownEnum.Value_4:
                                if (global.Challenges[UnknownEnum.Value_3])
                                    continue;
                                
                                break;
                            
                            case UnknownEnum.Value_5:
                                if (!FromAnyStore(arg2) || global.Level.Index < UnknownEnum.Value_6)
                                    continue;
                                
                                break;
                        }
                        
                        break;
                }
                
                if (global.Inventory_ItemData[arg0].Owns[_Index])
                    continue;
                
                if (Item_NonDuplicatableList_Find(arg0, _Index) != -1)
                    continue;
                
                ItemIsAvailable = true;
                break;
            }
            
            ds_list_destroy(_IndexesToCheckList);
            return ItemIsAvailable;
            break;
        
        case UnknownEnum.Value_2:
            if (global.Inventory_ItemData[arg0].Index == global.Inventory_ItemData[arg0].Index_Max)
                return false;
            
            var _ItemClassExists = Item_NonDuplicatableList_Find(arg0);
            
            if (_ItemClassExists != -1 && global.Inventory_ItemData[arg0].Index <= ds_grid_get(global.NonDuplicatableItemsThatExist, 1, _ItemClassExists))
                return false;
            
            switch (arg0)
            {
                case UnknownEnum.Value_2:
                    if (global.Challenges[UnknownEnum.Value_1])
                        return false;
                    
                    break;
                
                case UnknownEnum.Value_44:
                    if (global.Swordless)
                        return false;
                    
                    if (AttackOrDefenseTooHigh(MaxAttackPointsThatExist()))
                        return false;
                    
                    break;
                
                case UnknownEnum.Value_41:
                case UnknownEnum.Value_46:
                    if (AttackOrDefenseTooHigh(MaxDefensePointsThatExist()))
                        return false;
                    
                    break;
                
                case UnknownEnum.Value_16:
                    var _AttkOrDef = (global.Inventory_ItemData[UnknownEnum.Value_16].Index == -1) ? MaxDefensePointsThatExist() : MaxAttackPointsThatExist();
                    
                    if (AttackOrDefenseTooHigh(_AttkOrDef))
                        return false;
                    
                    break;
                
                case UnknownEnum.Value_7:
                    if (global.Inventory_ItemData[UnknownEnum.Value_7].Index >= 0)
                    {
                        if (FromAnySmallTreasure(arg2) || FromAnyLargeTreasure(arg2))
                            return false;
                    }
                    
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_3:
            switch (arg0)
            {
                case UnknownEnum.Value_48:
                    if (global.Challenges[UnknownEnum.Value_5])
                        return false;
                    
                    break;
            }
            
            break;
    }
    
    return true;
}

function Item_Get(arg0, arg1 = 0, arg2 = 1)
{
    var AddToInventory = global.ItemData[arg0].Type != UnknownEnum.Value_0;
    var _GotItem = AddToInventory ? Inventory_Add(arg0, arg1, arg2) : Item_Consume(arg0, arg1, arg2);
    return _GotItem;
}

function Item_GetDialogue(arg0, arg1 = 0, arg2 = 1)
{
    if (!Item_GetDialogueClass(arg0) || !global.Users[global.UserIndex].Prefs[UnknownEnum.Value_4])
        exit;
    
    var _Suffix = "a ";
    
    switch (arg0)
    {
        case UnknownEnum.Value_0:
        case UnknownEnum.Value_24:
            _Suffix = "an ";
            break;
        
        case UnknownEnum.Value_33:
            if (arg2 == 1)
            {
                switch (arg1)
                {
                    case UnknownEnum.Value_1:
                        _Suffix = "an ";
                        break;
                }
            }
            else
            {
                _Suffix = "some ";
            }
            
            break;
        
        case UnknownEnum.Value_35:
            if (arg2 != 1)
                _Suffix = "";
            
            break;
        
        case UnknownEnum.Value_13:
            if (arg2 == 1)
            {
                switch (arg1)
                {
                    case UnknownEnum.Value_7:
                    case UnknownEnum.Value_13:
                    case UnknownEnum.Value_18:
                    case UnknownEnum.Value_30:
                    case UnknownEnum.Value_29:
                    case UnknownEnum.Value_8:
                        _Suffix = "an ";
                        break;
                    
                    case UnknownEnum.Value_34:
                    case UnknownEnum.Value_16:
                    case UnknownEnum.Value_1:
                    case UnknownEnum.Value_38:
                    case UnknownEnum.Value_4:
                    case UnknownEnum.Value_24:
                    case UnknownEnum.Value_0:
                    case UnknownEnum.Value_42:
                    case UnknownEnum.Value_21:
                    case UnknownEnum.Value_14:
                    case UnknownEnum.Value_20:
                    case UnknownEnum.Value_17:
                    case UnknownEnum.Value_41:
                    case UnknownEnum.Value_39:
                    case UnknownEnum.Value_46:
                    case UnknownEnum.Value_35:
                        _Suffix = "some ";
                        break;
                }
            }
            else
            {
                _Suffix = "some ";
            }
            
            break;
        
        case UnknownEnum.Value_14:
            switch (arg1)
            {
                case UnknownEnum.Value_1:
                case UnknownEnum.Value_8:
                    _Suffix = "an ";
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_36:
            switch (arg1)
            {
                case UnknownEnum.Value_4:
                    _Suffix = "some ";
                    break;
                
                case UnknownEnum.Value_3:
                    _Suffix = "an ";
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_16:
        case UnknownEnum.Value_3:
            _Suffix = "";
            break;
        
        case UnknownEnum.Value_44:
            switch (arg1)
            {
                case UnknownEnum.Value_5:
                    _Suffix = "the ";
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_21:
        case UnknownEnum.Value_31:
            _Suffix = "the ";
            break;
    }
    
    MsgBox("You got " + _Suffix + Item_Name(arg0, arg1, arg2) + "!^" + Item_Info(arg0, arg1));
}

function Item_GetDialogueClass(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_5:
        case UnknownEnum.Value_11:
        case UnknownEnum.Value_12:
        case UnknownEnum.Value_17:
        case UnknownEnum.Value_18:
        case UnknownEnum.Value_20:
        case UnknownEnum.Value_25:
        case UnknownEnum.Value_26:
        case UnknownEnum.Value_30:
        case UnknownEnum.Value_32:
        case UnknownEnum.Value_37:
        case UnknownEnum.Value_40:
        case UnknownEnum.Value_29:
        case UnknownEnum.Value_22:
        case UnknownEnum.Value_42:
        case UnknownEnum.Value_43:
        case UnknownEnum.Value_45:
        case UnknownEnum.Value_47:
            return false;
    }
    
    return true;
}

function Item_Consume(arg0, arg1 = 0, arg2 = 1)
{
    var ItemConsumed = true;
    
    switch (arg0)
    {
        case UnknownEnum.Value_40:
            var RupeeMultiplier = Pendant_Check(UnknownEnum.Value_7) ? 1.2 : 1;
            var RupeeAmount = ceil(arg2 * RupeeMultiplier);
            Curse_CheckTask(UnknownEnum.Value_3, UnknownEnum.Value_40, RupeeAmount);
            
            if (Curse_Check(UnknownEnum.Value_0) && !global.CurseTreasure_Rupees)
                RupeeAmount = 0;
            
            global.CurseTreasure_Rupees = false;
            oHUD.AddRupees += RupeeAmount;
            global.StatsToAdd[UnknownEnum.Value_4] += RupeeAmount;
            break;
        
        case UnknownEnum.Value_17:
            Curse_CheckTask(UnknownEnum.Value_3, UnknownEnum.Value_17);
            var _CurseHeartsHurt = Curse_Check(UnknownEnum.Value_3);
            
            if (_CurseHeartsHurt && (oLink.Invincible || oLink.State == UnknownEnum.Value_19))
                break;
            
            if (_CurseHeartsHurt)
            {
                HealthAdd(-0.5);
                
                if (oLink.State == UnknownEnum.Value_4)
                    break;
                
                UpdateState(UnknownEnum.Value_3);
                LinkBounceBack(0, 0, 10, 0, false);
            }
            else
            {
                HealthAdd(1);
            }
            
            break;
        
        case UnknownEnum.Value_18:
            Curse_CheckTask(UnknownEnum.Value_3, UnknownEnum.Value_18);
            HeartPieceAdd();
            break;
        
        case UnknownEnum.Value_12:
            HealthAdd(8);
            audio_play_sound_stopall(Sound_FairyGet);
            break;
        
        case UnknownEnum.Value_1:
            var _Arrows = global.Inventory_ItemData[arg0];
            var _MaxAmount = Inventory_MaxAmount(arg0);
            
            if (arg2 > 0 && _Arrows.Amount[0] == _MaxAmount)
                return false;
            
            _Arrows.Amount[0] = min(_Arrows.Amount[0] + arg2, _MaxAmount);
            break;
        
        case UnknownEnum.Value_5:
            var _Bombs = global.Inventory_ItemData[arg0];
            var _MaxAmount = Inventory_MaxAmount(arg0);
            
            if (arg2 > 0 && _Bombs.Amount[0] == _MaxAmount)
                return false;
            
            _Bombs.Amount[0] = min(_Bombs.Amount[0] + arg2, _MaxAmount);
            break;
        
        case UnknownEnum.Value_20:
            var _Keys = global.Inventory_ItemData[UnknownEnum.Value_20];
            _Keys.Amount += arg2;
            
            if (_Keys.Amount > 9)
                _Keys.Amount = 9;
            
            if (_Keys.Amount <= 0)
                _Keys.Amount = 0;
            
            break;
        
        case UnknownEnum.Value_22:
            Inventory_DeleteItemClass(UnknownEnum.Value_22);
            break;
        
        case UnknownEnum.Value_26:
            MagicAdd(4);
            break;
        
        case UnknownEnum.Value_27:
            MagicAdd(32);
            break;
        
        case UnknownEnum.Value_13:
            HealthAdd(FoodHearts(arg1));
            
            if (arg1 == UnknownEnum.Value_51)
                Item_Consume(UnknownEnum.Value_40, 0, 200);
            
            break;
        
        case UnknownEnum.Value_35:
            HealthAdd(3);
            break;
        
        case UnknownEnum.Value_36:
            switch (arg1)
            {
                case UnknownEnum.Value_0:
                    HealthAdd(global.Challenges[UnknownEnum.Value_0] ? 5 : 16);
                    break;
                
                case UnknownEnum.Value_1:
                    MagicAdd(64);
                    break;
                
                case UnknownEnum.Value_2:
                    HealthAdd(global.Challenges[UnknownEnum.Value_0] ? 5 : 16);
                    MagicAdd(64);
                    break;
                
                case UnknownEnum.Value_4:
                    HealthAdd(8);
                    break;
                
                case UnknownEnum.Value_3:
                    MsgBox("Oof, tastes awful! You are now uncursed!", undefined, Sound_Antidote, Curse_Done);
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_43:
            with (oEnemy)
            {
                if (State == UnknownEnum.Value_15 || State == UnknownEnum.Value_16)
                    continue;
                
                Enemy_UpdateState(UnknownEnum.Value_15);
            }
            
            with (oEnemy_Guru_Bar)
                Enemy_UpdateState(UnknownEnum.Value_15);
            
            with (oEnemy_Beamos)
                Beamos_DestroyLaserLights();
            
            break;
        
        case UnknownEnum.Value_42:
            with (oLink)
                UpdateState(UnknownEnum.Value_19);
            
            break;
        
        default:
            ItemConsumed = false;
            break;
    }
    
    return ItemConsumed;
}

function Item_CanConsume(arg0, arg1)
{
    if (arg0 == -1)
        return false;
    
    var CanConsume = false;
    var _HealthItem = false;
    var _MagicItem = false;
    
    switch (arg0)
    {
        case UnknownEnum.Value_13:
            if (arg1 == UnknownEnum.Value_51)
                return true;
        
        case UnknownEnum.Value_35:
            _HealthItem = true;
            break;
        
        case UnknownEnum.Value_27:
            _MagicItem = true;
            break;
        
        case UnknownEnum.Value_36:
            switch (arg1)
            {
                case UnknownEnum.Value_0:
                case UnknownEnum.Value_4:
                    _HealthItem = true;
                    break;
                
                case UnknownEnum.Value_1:
                    _MagicItem = true;
                    break;
                
                case UnknownEnum.Value_2:
                    _HealthItem = true;
                    _MagicItem = true;
                    break;
                
                case UnknownEnum.Value_3:
                    CanConsume = global.Cursed;
                    break;
            }
            
            break;
    }
    
    var _InvHealth = global.Inventory_ItemData[UnknownEnum.Value_17];
    var _InvHealthMax = global.Inventory_ItemData[UnknownEnum.Value_18];
    var _InvMagic = global.Inventory_ItemData[UnknownEnum.Value_26];
    
    if (_HealthItem)
    {
        if (_InvHealth.Amount < _InvHealthMax.Amount && !Curse_Check(UnknownEnum.Value_2))
            CanConsume = true;
    }
    
    if (_MagicItem)
    {
        if (_InvMagic.Amount < 64)
            CanConsume = true;
    }
    
    return CanConsume;
}

function Item_CanUse(arg0, arg1)
{
    var _InvHealth = global.Inventory_ItemData[UnknownEnum.Value_17];
    var _InvHealthMax = global.Inventory_ItemData[UnknownEnum.Value_18];
    var _InvMagic = global.Inventory_ItemData[UnknownEnum.Value_26];
    var _CantAddHealth = _InvHealth.Amount == _InvHealthMax.Amount || Curse_Check(UnknownEnum.Value_2);
    var _CantAddMagic = _InvMagic.Amount == 64;
    
    switch (arg0)
    {
        case UnknownEnum.Value_48:
            return false;
        
        case UnknownEnum.Value_13:
        case UnknownEnum.Value_35:
            if (_CantAddHealth && !(arg0 == UnknownEnum.Value_13 && arg1 == UnknownEnum.Value_51))
                return false;
            
            break;
        
        case UnknownEnum.Value_27:
            if (_CantAddMagic)
                return false;
            
            break;
        
        case UnknownEnum.Value_36:
            switch (arg1)
            {
                case UnknownEnum.Value_0:
                case UnknownEnum.Value_4:
                    if (_CantAddHealth)
                        return false;
                    
                    break;
                
                case UnknownEnum.Value_1:
                    if (_CantAddMagic)
                        return false;
                    
                    break;
                
                case UnknownEnum.Value_2:
                    if (_CantAddHealth && _CantAddMagic)
                        return false;
                    
                    break;
                
                case UnknownEnum.Value_3:
                    if (!global.Cursed)
                        return false;
                    
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_38:
            switch (arg1)
            {
                case UnknownEnum.Value_0:
                    if (_CantAddHealth)
                        return false;
                    
                    break;
                
                case UnknownEnum.Value_2:
                    if (global.Inventory_ItemData[UnknownEnum.Value_5].Amount[0] >= Inventory_MaxAmount(UnknownEnum.Value_5))
                        return false;
                    
                    break;
                
                case UnknownEnum.Value_3:
                    if (global.Inventory_ItemData[UnknownEnum.Value_1].Amount[0] >= Inventory_MaxAmount(UnknownEnum.Value_1))
                        return false;
                    
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_4:
            if (global.Inventory_ItemData[UnknownEnum.Value_5].Amount[0] == 0)
                return false;
        
        case UnknownEnum.Value_5:
        case UnknownEnum.Value_33:
        case UnknownEnum.Value_14:
        case UnknownEnum.Value_47:
            if (oLink.InDoor_Facing || oLink.InDoor_BlockItem || oLink.InDoor_House || !oLink.InDoor_Aligned)
                return false;
            
            if (oLink.ItemHolding != -4)
                return false;
            
            break;
    }
    
    return true;
}

function ItemSpawn(arg0, arg1, arg2, arg3, arg4, arg5, arg6 = true)
{
    var _FloorLevelStr = GetFloorLevelString(arg5);
    var Layer;
    
    switch (arg4)
    {
        default:
            Layer = "ObjsHigher_" + _FloorLevelStr;
            break;
        
        case UnknownEnum.Value_5:
        case UnknownEnum.Value_9:
            Layer = "ObjsHighest";
            break;
            break;
        
        case UnknownEnum.Value_6:
        case UnknownEnum.Value_4:
        case UnknownEnum.Value_10:
            Layer = "Objs_" + _FloorLevelStr;
            break;
    }
    
    var _ObjIndex = ObjIndexFromItemClass(arg0);
    var Inst = instance_create_layer(arg1, arg2, Layer, _ObjIndex, 
    {
        From: arg3,
        FloorLevel: arg5
    });
    
    if (arg6)
    {
        if (!Item_Valid(Inst.Class, Inst.Index))
        {
            instance_destroy(Inst);
            return -4;
        }
    }
    
    Inst.SpawnType = arg4;
    
    if (arg4 != UnknownEnum.Value_0)
    {
        Inst.Spawning = true;
        Inst.SpawnAnimationInit = true;
    }
    
    switch (arg4)
    {
        case UnknownEnum.Value_9:
            Inst.visible = true;
            break;
        
        case UnknownEnum.Value_10:
            Inst.Alpha = 0;
            Inst.Lighting = false;
            break;
    }
    
    if (FromAnyTreasure(arg3))
    {
        if (Item_IsNonDuplicatableClassType(arg0))
            Item_NonDuplicatableList_Add(arg0, Inst.Index);
    }
    
    return Inst;
}

function ItemExplosion(arg0, arg1, arg2, arg3, arg4 = 0, arg5 = 0, arg6 = 0, arg7 = -1, arg8 = UnknownEnum.Value_1)
{
    if (arg7 != -1)
    {
        var _ItemInst = ItemSpawn(arg7, arg0, arg1, arg3, arg8, arg2);
        ItemExplosionInst_CheckWalls(_ItemInst);
    }
    
    var _RupeeCount = 0;
    
    if (arg7 == UnknownEnum.Value_40)
        _RupeeCount++;
    
    if (arg4 > 0)
    {
        while (arg4 > 0)
        {
            var _ItemInst = ItemSpawn(UnknownEnum.Value_40, arg0, arg1, arg3, UnknownEnum.Value_4, arg2);
            ItemExplosionInst_CheckWalls(_ItemInst);
            
            if (arg4 >= 20 && Prob(0.4))
                _ItemInst.Amount = 20;
            else if (arg4 >= 10 && Prob(0.4))
                _ItemInst.Amount = 10;
            else if (arg4 >= 5 && Prob(0.4))
                _ItemInst.Amount = 5;
            else
                _ItemInst.Amount = 1;
            
            with (_ItemInst)
            {
                Setup = false;
                Rupee_Init(Amount);
            }
            
            arg4 -= _ItemInst.Amount;
            _RupeeCount++;
        }
    }
    
    if (_RupeeCount > 1)
        audio_play_sound(Sound_RupeeGetRegister, 1, false);
    
    if (arg5 > 0)
    {
        while (arg5 > 0)
        {
            var _ItemInst = ItemSpawn(UnknownEnum.Value_17, arg0, arg1, arg3, UnknownEnum.Value_4, arg2);
            ItemExplosionInst_CheckWalls(_ItemInst);
            arg5--;
        }
    }
    
    if (arg6 > 0)
    {
        while (arg6 > 0)
        {
            var _ItemInst = ItemSpawn(UnknownEnum.Value_26, arg0, arg1, arg3, UnknownEnum.Value_4, arg2);
            ItemExplosionInst_CheckWalls(_ItemInst);
            arg6--;
        }
    }
}

function ItemExplosionInst_CheckWalls(arg0)
{
    with (arg0)
    {
        var _Buffer = 5;
        var _WallInst = instance_place(x - _Buffer, y_base, oWall);
        
        if (_WallInst != -4)
        {
            if (_WallInst.BlockItems)
                x += _Buffer;
        }
        
        _WallInst = instance_place(x + _Buffer, y_base, oWall);
        
        if (_WallInst != -4)
        {
            if (_WallInst.BlockItems)
                x -= _Buffer;
        }
        
        _WallInst = instance_place(x, y_base - _Buffer, oWall);
        
        if (_WallInst != -4)
        {
            if (_WallInst.BlockItems)
                ObjSetY(y_base + _Buffer);
        }
        
        _WallInst = instance_place(x, y_base + _Buffer, oWall);
        
        if (_WallInst != -4)
        {
            if (_WallInst.BlockItems)
                ObjSetY(y_base - _Buffer);
        }
    }
}

function ItemDrop(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var DroppedInst = ItemSpawn(arg2, arg0, arg1, arg5, UnknownEnum.Value_1, oLink.FloorLevel, false);
    
    switch (arg2)
    {
        case UnknownEnum.Value_41:
            DroppedInst.ShadowSpr = (DroppedInst.Index == 0) ? sShadow_Medium : sShadow_Large;
            break;
    }
    
    with (DroppedInst)
    {
        Item_SetIndex(arg3);
        layer = layer_get_id("Objs_" + GetFloorLevelString(oLink.FloorLevel));
        Amount = arg4;
        Setup = false;
    }
    
    if (Item_IsNonDuplicatableClassType(arg2))
        Item_NonDuplicatableList_Add(arg2, arg3);
    
    return DroppedInst;
}

function Item_DropPos()
{
    for (var i = 0; i < array_length(global.ItemDropPosTable); i++)
    {
        var _x = oLink.x + global.ItemDropPosTable[i][0];
        var _y = oLink.y + global.ItemDropPosTable[i][1];
        var _Hole = false;
        
        if (oLink.FloorLevel == 1)
            _Hole = tilemap_get_at_pixel(global.TMID_Floor_Upper, _x, _y) == 0;
        else
            _Hole = tilemap_get_at_pixel(global.TMID_Floor_Lower, _x, _y) == 0;
        
        if (_Hole)
            continue;
        
        if (instance_position(_x, _y - 6, oWall) == -4 && instance_position(_x, _y - 6, oItem) == -4)
            return [_x, _y];
    }
    
    return [oLink.x, oLink.y];
}

function Item_OverHole()
{
    return tilemap_get_at_pixel(global.TMID_Floor_Lower, ObjCenterX(), ObjCenterY()) == 0;
}

function Item_FallInHole()
{
    instance_create_layer(ObjCenterX(), ObjCenterY(), "ObjsHigher_Upper", oSparkle);
    audio_play_sound_stopall(Sound_Fall);
    instance_destroy(id);
}

function Item_CheckPondWater()
{
    if (z >= 1)
        return false;
    
    var PondInst = -4;
    
    with (oGemPondWater)
    {
        if (point_in_rectangle(other.x, other.y, x, y, X2, Y2))
        {
            PondInst = instance_position(x, y, id);
            break;
        }
    }
    
    if (PondInst != -4)
    {
        instance_create_layer(x, y, "Objs_" + FloorLevelStr, oWaterSplash, 
        {
            PalIndex: (PondInst.GID == UnknownEnum.Value_314) ? 1 : 0
        });
        
        switch (object_index)
        {
            case oGem:
                PondInst.GemCount[Index]++;
                
                if (PondInst.GID == UnknownEnum.Value_262 && GemsInPond(PondInst) >= 2)
                {
                    instance_create_layer(PondInst.x + (PondInst.W / 2), PondInst.y + (PondInst.H / 2), "Objs_" + FloorLevelStr, oZora, 
                    {
                        GemCombo: GetGemCombo(PondInst)
                    });
                }
                
                break;
            
            case oWishStone:
                if (PondInst.GID == UnknownEnum.Value_314 && !PondInst.WishStone)
                {
                    instance_create_layer(PondInst.x + (PondInst.W / 2), PondInst.y + (PondInst.H / 2), "System", oFairy_Queen, 
                    {
                        RoomIndex: RoomIndex
                    });
                    
                    with (oLink)
                        UpdateState(UnknownEnum.Value_0);
                    
                    global.Paused = true;
                    PondInst.WishStone = true;
                }
                
                break;
        }
        
        instance_destroy(id);
        return true;
    }
    
    return false;
}

function Item_CheckWater()
{
    if (z > 2)
    {
        InWater = false;
        exit;
    }
    
    var _InWater = OnWaterTile((FloorLevel == 1) ? global.TMID_Water_Upper : global.TMID_Water_Lower, x, y_base);
    
    if (InWater && !_InWater)
    {
        InWater = false;
    }
    else if (!InWater && _InWater)
    {
        InWater = true;
        
        if (oCamera.InView(x, y_base) && !instance_exists(oInventory))
            audio_play_sound_stopall(Sound_Water_Walk);
    }
}

function Item_CheckFloorLevelSwitch()
{
    if (z <= 13 && FloorLevel == 1)
    {
        var _FloorLevelBase = GetFloorLevelID(x, y_base);
        var _FloorLevelCentre = GetFloorLevelID(ObjCenterX(), ObjCenterY());
        
        if (_FloorLevelBase == _FloorLevelCentre)
        {
            FloorLevel = GetFloorLevelID(x, y_base);
            FloorLevelStr = GetFloorLevelString(FloorLevel);
            layer = layer_get_id("Objs_" + FloorLevelStr);
        }
    }
}

function HealthAdd(arg0, arg1 = true)
{
    if (arg1 && arg0 > 0 && !global.CurseTreasure_HeartPiece)
    {
        if (Curse_Check(UnknownEnum.Value_2))
            return 0;
        
        if (Pendant_Check(UnknownEnum.Value_0))
            arg0 *= 1.25;
        
        if (Curse_Check(UnknownEnum.Value_5))
            oLink.alarm[3] = global.CurseHealthDrainDelay;
    }
    
    global.CurseTreasure_HeartPiece = false;
    var OriginalAmount = arg0;
    var _Health = global.Inventory_ItemData[UnknownEnum.Value_17];
    var _HealthMax = global.Inventory_ItemData[UnknownEnum.Value_18];
    
    if ((_Health.Amount + arg0) > _HealthMax.Amount)
        arg0 = _HealthMax.Amount - _Health.Amount;
    
    _Health.Amount = max(0, _Health.Amount + arg0);
    
    if (OriginalAmount > 1)
        oHUD.AddHealth = arg0;
    
    if (global.Inventory_ItemData[UnknownEnum.Value_17].Amount <= 0)
    {
        with (oLink)
            UpdateState(UnknownEnum.Value_4);
    }
    
    return arg0;
}

function HealthCheckSound()
{
    if (global.FadeIn)
        exit;
    
    if (instance_exists(oMenu_Game))
        exit;
    
    if (global.Paused)
        exit;
    
    if (global.GameBeaten)
        exit;
    
    if (global.Inventory_ItemData[UnknownEnum.Value_17].Amount < 2)
    {
        if (oLink.State != UnknownEnum.Value_4 && global.Inventory_ItemData[UnknownEnum.Value_17].Amount > 0 && oLink.State != UnknownEnum.Value_0)
        {
            if (!audio_is_playing(oLink.LowHealthSound))
            {
                oLink.LowHealthSound = audio_play_sound(Sound_LowHealth, 1, false);
                oHUD.HealthLowPulseDir = 1;
            }
        }
    }
}

function MagicAdd(arg0)
{
    if (Curse_Check(UnknownEnum.Value_1))
        exit;
    
    var _Magic = global.Inventory_ItemData[UnknownEnum.Value_26];
    
    if ((_Magic.Amount + arg0) > 64)
        arg0 = 64 - _Magic.Amount;
    
    _Magic.Amount += arg0;
    oHUD.AddMagic += arg0;
}

function MagicUse(arg0)
{
    if (Pendant_Check(UnknownEnum.Value_1))
        arg0 *= 0.75;
    
    if (Curse_Check(UnknownEnum.Value_4))
        arg0 *= 2;
    
    var _Magic = global.Inventory_ItemData[UnknownEnum.Value_26];
    
    if (arg0 > _Magic.Amount)
        return 0;
    
    _Magic.Amount -= arg0;
    return arg0;
}

function HeartPieceAdd()
{
    var _HealthMax = global.Inventory_ItemData[UnknownEnum.Value_18];
    _HealthMax.Amount++;
    
    if (_HealthMax.Amount >= (global.Challenges[UnknownEnum.Value_0] ? 5 : 16))
        _HealthMax.Amount = global.Challenges[UnknownEnum.Value_0] ? 5 : 16;
    
    HealthAdd(_HealthMax.Amount);
}

function Item_PickAvailableIndex(arg0, arg1 = UnknownEnum.Value_22)
{
    var AvailableItems = ds_list_create();
    var ItemCount = array_length(global.Inventory_ItemData[arg0].Owns);
    var _Index = -1;
    
    for (var _ItemIndex = 0; _ItemIndex < ItemCount; _ItemIndex++)
    {
        if (!Item_Allowed(arg0, _ItemIndex, arg1))
            continue;
        
        ds_list_add(AvailableItems, _ItemIndex);
    }
    
    if (ds_list_size(AvailableItems) > 0)
    {
        ds_list_shuffle(AvailableItems);
        _Index = ds_list_find_value(AvailableItems, 0);
    }
    
    ds_list_destroy(AvailableItems);
    return _Index;
}

function Probs_RandomItemClass(arg0)
{
    var _ChosenItem = UnknownEnum.Value_13;
    var _ItemList = ds_list_create();
    ds_list_copy(_ItemList, global.PossibleItemLists[arg0]);
    ds_list_shuffle(_ItemList);
    
    while (ds_list_size(_ItemList) > 0)
    {
        var _ListItem = ds_list_find_value(_ItemList, 0);
        
        if (Item_Allowed(_ListItem, -1, arg0))
        {
            _ChosenItem = _ListItem;
            break;
        }
        else
        {
            ds_list_finddelete_all(_ItemList, _ListItem);
        }
    }
    
    ds_list_destroy(_ItemList);
    return _ChosenItem;
}

function Probs_RandomItemClass_Pot(arg0, arg1 = true)
{
    var _ItemClass = -1;
    
    if (arg0 || Prob(0.22))
        _ItemClass = Probs_RandomItemClass((arg1 || global.Level.Index == UnknownEnum.Value_6) ? UnknownEnum.Value_1 : UnknownEnum.Value_0);
    
    if (global.Cursed)
    {
        if (global.CurseTask == UnknownEnum.Value_3 && global.CurseTaskItem == UnknownEnum.Value_17)
        {
            if (_ItemClass != UnknownEnum.Value_17)
            {
                if (Prob(0.12))
                    _ItemClass = UnknownEnum.Value_17;
            }
        }
    }
    
    return _ItemClass;
}

function Item_IsNonDuplicatableClassType(arg0)
{
    return global.ItemData[arg0].Type == UnknownEnum.Value_1 || global.ItemData[arg0].Type == UnknownEnum.Value_2 || global.ItemData[arg0].Type == UnknownEnum.Value_4;
}

function Item_NonDuplicatableList_Add(arg0, arg1)
{
    var GridH = ds_grid_height(global.NonDuplicatableItemsThatExist);
    ds_grid_resize(global.NonDuplicatableItemsThatExist, 2, GridH + 1);
    ds_grid_add(global.NonDuplicatableItemsThatExist, 0, GridH, arg0);
    ds_grid_add(global.NonDuplicatableItemsThatExist, 1, GridH, arg1);
}

function Item_NonDuplicatableList_Remove(arg0, arg1)
{
    var ItemRow = Item_NonDuplicatableList_Find(arg0, arg1);
    
    if (ItemRow != -1)
        ds_grid_delete_row(global.NonDuplicatableItemsThatExist, ItemRow);
}

function Item_NonDuplicatableList_Find(arg0, arg1 = -1)
{
    var GridH = ds_grid_height(global.NonDuplicatableItemsThatExist);
    
    for (var i = 0; i < GridH; i++)
    {
        if (arg1 == -1)
        {
            if (arg0 == ds_grid_get(global.NonDuplicatableItemsThatExist, 0, i))
                return i;
        }
        else if (arg0 == ds_grid_get(global.NonDuplicatableItemsThatExist, 0, i) && arg1 == ds_grid_get(global.NonDuplicatableItemsThatExist, 1, i))
        {
            return i;
        }
    }
    
    return -1;
}

function Item_SetIndex(arg0)
{
    Index = arg0;
    image_index = Index;
}

function TreasureLimiter_Reset()
{
    for (var _ItemClass = 0; _ItemClass < 49; _ItemClass++)
        global.ItemData[_ItemClass].LimitCount = TreasureLimiter_NewLimitCount(global.ItemData[_ItemClass].LimitStart);
}

function TreasureLimiter_Update(arg0, arg1 = true)
{
    if (arg1)
    {
        for (var i = 0; i < 49; i++)
            global.ItemData[i].LimitCount = max(--global.ItemData[i].LimitCount, 0);
    }
    
    if (global.ItemData[arg0].LimitMin > 0)
        global.ItemData[arg0].LimitCount = TreasureLimiter_NewLimitCount(global.ItemData[arg0].LimitMin);
}

function TreasureLimiter_NewLimitCount(arg0)
{
    return floor(arg0 * random_range(1, 2.5));
}

function FromAnyTreasure(arg0)
{
    return FromAnyTreasureChest(arg0) || arg0 == UnknownEnum.Value_12 || arg0 == UnknownEnum.Value_20;
}

function FromAnySmallTreasure(arg0)
{
    return arg0 == UnknownEnum.Value_2 || arg0 == UnknownEnum.Value_5 || arg0 == UnknownEnum.Value_6 || arg0 == UnknownEnum.Value_7;
}

function FromAnyLargeTreasure(arg0)
{
    return arg0 == UnknownEnum.Value_3 || arg0 == UnknownEnum.Value_8;
}

function FromAnyTreasureChest(arg0)
{
    return FromAnySmallTreasure(arg0) || FromAnyLargeTreasure(arg0);
}

function FromAnyStore(arg0)
{
    return arg0 == UnknownEnum.Value_4 || arg0 == UnknownEnum.Value_10 || arg0 == UnknownEnum.Value_9 || arg0 == UnknownEnum.Value_11;
}

function FromAnyKinstone(arg0)
{
    return arg0 == UnknownEnum.Value_5 || arg0 == UnknownEnum.Value_6 || arg0 == UnknownEnum.Value_7 || arg0 == UnknownEnum.Value_8;
}

function Item_HealthBonusStr(arg0)
{
    var BonusAmount = arg0 * 0.25;
    return Pendant_Check(UnknownEnum.Value_0) ? (" (+" + string_format(BonusAmount, 1, (frac(BonusAmount) != 0) ? 1 : 0) + " bonus)") : "";
}

function ItemClassFromObjIndex(arg0)
{
    switch (arg0)
    {
        case oItem_ArrowQuiver:
            return UnknownEnum.Value_0;
        
        case oItem_Arrows:
            return UnknownEnum.Value_1;
        
        case oItem_Bag:
            return UnknownEnum.Value_2;
        
        case oItem_BombBag:
            return UnknownEnum.Value_4;
        
        case oItem_GemBag:
            return UnknownEnum.Value_15;
        
        case oItem_Bombs:
            return UnknownEnum.Value_5;
        
        case oItem_Boomerang:
            return UnknownEnum.Value_6;
        
        case oItem_Bow:
            return UnknownEnum.Value_7;
        
        case oItem_Cane:
            return UnknownEnum.Value_8;
        
        case oItem_Cape:
            return UnknownEnum.Value_9;
        
        case oItem_Compass:
            return UnknownEnum.Value_10;
        
        case oItem_Coupon:
            return UnknownEnum.Value_48;
        
        case oItem_Crystal:
            return UnknownEnum.Value_11;
        
        case oItem_Fairy:
            return UnknownEnum.Value_12;
        
        case oItem_Food:
            return UnknownEnum.Value_13;
        
        case oItem_Gem:
            return UnknownEnum.Value_14;
        
        case oItem_Gloves:
            return UnknownEnum.Value_16;
        
        case oItem_Heart:
            return UnknownEnum.Value_17;
        
        case oItem_HeartPiece:
            return UnknownEnum.Value_18;
        
        case oItem_Hookshot:
            return UnknownEnum.Value_19;
        
        case oItem_Key:
            return UnknownEnum.Value_20;
        
        case oItem_Key_Master:
            return UnknownEnum.Value_21;
        
        case oItem_Kinstone:
            return UnknownEnum.Value_23;
        
        case oItem_Lamp:
            return UnknownEnum.Value_24;
        
        case oItem_Magic:
            return UnknownEnum.Value_26;
        
        case oItem_Magic_Large:
            return UnknownEnum.Value_27;
        
        case oItem_Map:
            return UnknownEnum.Value_28;
        
        case oItem_MoonPearl:
            return UnknownEnum.Value_31;
        
        case oItem_Orb:
            return UnknownEnum.Value_33;
        
        case oItem_Pendant:
            return UnknownEnum.Value_34;
        
        case oItem_Pop:
            return UnknownEnum.Value_35;
        
        case oItem_Potion:
            return UnknownEnum.Value_36;
        
        case oItem_Ring:
            return UnknownEnum.Value_38;
        
        case oItem_Rod:
            return UnknownEnum.Value_39;
        
        case oItem_Rupee:
            return UnknownEnum.Value_40;
        
        case oItem_Shield:
            return UnknownEnum.Value_41;
        
        case oItem_Star:
            return UnknownEnum.Value_42;
        
        case oItem_Stopwatch:
            return UnknownEnum.Value_43;
        
        case oItem_Sword:
            return UnknownEnum.Value_44;
        
        case oItem_Treasure:
            return UnknownEnum.Value_45;
        
        case oItem_Tunic:
            return UnknownEnum.Value_46;
        
        case oItem_Book:
            return UnknownEnum.Value_3;
        
        case oItem_Mirror:
            return UnknownEnum.Value_30;
        
        case oItem_Mushroom:
            return UnknownEnum.Value_32;
        
        case oItem_Powder:
            return UnknownEnum.Value_37;
        
        case oItem_Medallion:
            return UnknownEnum.Value_29;
        
        case oItem_Key_Special:
            return UnknownEnum.Value_22;
        
        case oItem_Letter:
            return UnknownEnum.Value_25;
        
        case oItem_WishStone:
            return UnknownEnum.Value_47;
    }
    
    return -1;
}

function ObjIndexFromItemClass(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_0:
            return oItem_ArrowQuiver;
        
        case UnknownEnum.Value_1:
            return oItem_Arrows;
        
        case UnknownEnum.Value_2:
            return oItem_Bag;
        
        case UnknownEnum.Value_4:
            return oItem_BombBag;
        
        case UnknownEnum.Value_15:
            return oItem_GemBag;
        
        case UnknownEnum.Value_5:
            return oItem_Bombs;
        
        case UnknownEnum.Value_6:
            return oItem_Boomerang;
        
        case UnknownEnum.Value_7:
            return oItem_Bow;
        
        case UnknownEnum.Value_8:
            return oItem_Cane;
        
        case UnknownEnum.Value_9:
            return oItem_Cape;
        
        case UnknownEnum.Value_10:
            return oItem_Compass;
        
        case UnknownEnum.Value_48:
            return oItem_Coupon;
        
        case UnknownEnum.Value_11:
            return oItem_Crystal;
        
        case UnknownEnum.Value_12:
            return oItem_Fairy;
        
        case UnknownEnum.Value_13:
            return oItem_Food;
        
        case UnknownEnum.Value_14:
            return oItem_Gem;
        
        case UnknownEnum.Value_16:
            return oItem_Gloves;
        
        case UnknownEnum.Value_17:
            return oItem_Heart;
        
        case UnknownEnum.Value_18:
            return oItem_HeartPiece;
        
        case UnknownEnum.Value_19:
            return oItem_Hookshot;
        
        case UnknownEnum.Value_20:
            return oItem_Key;
        
        case UnknownEnum.Value_21:
            return oItem_Key_Master;
        
        case UnknownEnum.Value_23:
            return oItem_Kinstone;
        
        case UnknownEnum.Value_24:
            return oItem_Lamp;
        
        case UnknownEnum.Value_26:
            return oItem_Magic;
        
        case UnknownEnum.Value_27:
            return oItem_Magic_Large;
        
        case UnknownEnum.Value_28:
            return oItem_Map;
        
        case UnknownEnum.Value_31:
            return oItem_MoonPearl;
        
        case UnknownEnum.Value_33:
            return oItem_Orb;
        
        case UnknownEnum.Value_34:
            return oItem_Pendant;
        
        case UnknownEnum.Value_35:
            return oItem_Pop;
        
        case UnknownEnum.Value_36:
            return oItem_Potion;
        
        case UnknownEnum.Value_38:
            return oItem_Ring;
        
        case UnknownEnum.Value_39:
            return oItem_Rod;
        
        case UnknownEnum.Value_40:
            return oItem_Rupee;
        
        case UnknownEnum.Value_41:
            return oItem_Shield;
        
        case UnknownEnum.Value_42:
            return oItem_Star;
        
        case UnknownEnum.Value_43:
            return oItem_Stopwatch;
        
        case UnknownEnum.Value_44:
            return oItem_Sword;
        
        case UnknownEnum.Value_45:
            return oItem_Treasure;
        
        case UnknownEnum.Value_46:
            return oItem_Tunic;
        
        case UnknownEnum.Value_3:
            return oItem_Book;
        
        case UnknownEnum.Value_30:
            return oItem_Mirror;
        
        case UnknownEnum.Value_32:
            return oItem_Mushroom;
        
        case UnknownEnum.Value_37:
            return oItem_Powder;
        
        case UnknownEnum.Value_29:
            return oItem_Medallion;
        
        case UnknownEnum.Value_22:
            return oItem_Key_Special;
        
        case UnknownEnum.Value_25:
            return oItem_Letter;
        
        case UnknownEnum.Value_47:
            return oItem_WishStone;
    }
    
    return -1;
}

function ObjFromItem(arg0)
{
    switch (arg0)
    {
        case oItem_Orb:
            return oOrb;
        
        case oItem_Gem:
            return oGem;
        
        case oItem_Bombs:
            return oBomb;
        
        case oItem_WishStone:
            return oWishStone;
    }
    
    return -4;
}

function ItemFromObj(arg0)
{
    switch (arg0)
    {
        case oOrb:
            return oItem_Orb;
        
        case oGem:
            return oItem_Gem;
        
        case oBomb:
            return oItem_Bombs;
        
        case oWishStone:
            return oItem_WishStone;
    }
    
    return -4;
}

function Item_AmountOffsetX(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_40:
            return 0;
        
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_35:
        case UnknownEnum.Value_27:
        case UnknownEnum.Value_33:
            return 1;
        
        default:
            return 2;
    }
}

function Item_Valid(arg0, arg1)
{
    switch (arg0)
    {
        case UnknownEnum.Value_2:
        case UnknownEnum.Value_13:
        case UnknownEnum.Value_14:
        case UnknownEnum.Value_16:
        case UnknownEnum.Value_23:
        case UnknownEnum.Value_33:
        case UnknownEnum.Value_34:
        case UnknownEnum.Value_35:
        case UnknownEnum.Value_36:
        case UnknownEnum.Value_38:
        case UnknownEnum.Value_39:
        case UnknownEnum.Value_41:
        case UnknownEnum.Value_44:
        case UnknownEnum.Value_46:
            if (arg1 == -1)
                return false;
    }
    
    return true;
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
    Value_13,
    Value_14,
    Value_15,
    Value_16,
    Value_17,
    Value_18,
    Value_19,
    Value_20,
    Value_21,
    Value_22,
    Value_23,
    Value_24,
    Value_25,
    Value_26,
    Value_27,
    Value_28,
    Value_29,
    Value_30,
    Value_31,
    Value_32,
    Value_33,
    Value_34,
    Value_35,
    Value_36,
    Value_37,
    Value_38,
    Value_39,
    Value_40,
    Value_41,
    Value_42,
    Value_43,
    Value_44,
    Value_45,
    Value_46,
    Value_47,
    Value_48,
    Value_51 = 51,
    Value_262 = 262,
    Value_314 = 314
}
