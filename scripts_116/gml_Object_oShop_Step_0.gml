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
        switch (global.DB_ExitCode)
        {
            case 1:
                oHUD.AddRupees -= oLink.ShopItemLook.Price_Modified;
                
                if (global.Inventory_SlotIndex_Equiped != -1)
                {
                    if (global.Inventory[global.Inventory_SlotIndex_Equiped].ItemClass == UnknownEnum.Value_48)
                    {
                        if (oLink.ShopItemLook.Price_CouponApplied)
                        {
                            global.Inventory[global.Inventory_SlotIndex_Equiped].Amount--;
                            
                            if (global.Inventory[global.Inventory_SlotIndex_Equiped].Amount <= 0)
                                Inventory_DeleteSlot(global.Inventory_SlotIndex_Equiped);
                            
                            Inventory_CountStackItems();
                        }
                    }
                }
                
                if (oLink.ShopItemLook.object_index == oItem_Treasure)
                {
                    HoldUpItem(oLink.ShopItemLook, oLink.ShopItemLook.From, false);
                    Treasure_Open(oLink.ShopItemLook);
                }
                else
                {
                    HoldUpItem(oLink.ShopItemLook, oLink.ShopItemLook.From);
                }
                
                global.Paused = true;
                ItemsSold++;
                break;
        }
        
        DB_Started = false;
    }
}

enum UnknownEnum
{
    Value_48 = 48
}
