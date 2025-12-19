var _ItemInst = ItemSpawn(PrizeClass, x, y, UnknownEnum.Value_20, UnknownEnum.Value_8, FloorLevel, false);

with (_ItemInst)
{
    switch (global.ItemData[other.PrizeClass].Type)
    {
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_0:
        case UnknownEnum.Value_3:
        case UnknownEnum.Value_5:
        case UnknownEnum.Value_4:
            Amount = other.GemPrize.Amount;
            var _Index = other.PrizeIndex;
            
            if (other.PrizeClass == UnknownEnum.Value_40)
                _Index = Rupee_GetIndex(Amount);
            
            Item_SetIndex(_Index);
            Setup = false;
            break;
    }
    
    layer = layer_get_id("Objs_" + GetFloorLevelString(other.FloorLevel));
}

image_index = 2;
audio_play_sound(Sound_Boss_Hit, 1, false);
alarm[5] = 40;

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_3 = 3,
    Value_4,
    Value_5,
    Value_8 = 8,
    Value_20 = 20,
    Value_40 = 40
}
