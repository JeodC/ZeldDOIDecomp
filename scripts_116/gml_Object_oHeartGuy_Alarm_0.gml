switch (Type)
{
    case 1:
        var _InvHealth = global.Inventory_ItemData[UnknownEnum.Value_17];
        var RemoveHealth = _InvHealth.Amount * 0.75;
        HealthAdd(-RemoveHealth);
        break;
    
    case 2:
        global.Inventory_ItemData[UnknownEnum.Value_26].Amount = 0;
        break;
}

ItemSpawn(UnknownEnum.Value_40, x, y - 2 - z, UnknownEnum.Value_2, UnknownEnum.Value_9, FloorLevel);
audio_play_sound(Sound_ItemGetFanfare, 1, false);
instance_destroy(id);

enum UnknownEnum
{
    Value_2 = 2,
    Value_9 = 9,
    Value_17 = 17,
    Value_26 = 26,
    Value_40 = 40
}
