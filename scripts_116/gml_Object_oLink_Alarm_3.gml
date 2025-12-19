if (Curse_Check(UnknownEnum.Value_5))
{
    if (global.Inventory_ItemData[UnknownEnum.Value_17].Amount > 2)
    {
        HealthAdd(-0.25);
        
        if (global.Inventory_ItemData[UnknownEnum.Value_17].Amount < 2)
            global.Inventory_ItemData[UnknownEnum.Value_17].Amount = 2;
    }
    
    alarm[3] = global.CurseHealthDrainDelay;
}

enum UnknownEnum
{
    Value_5 = 5,
    Value_17 = 17
}
