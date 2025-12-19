if (!Open && Close)
{
    if (!audio_is_playing(Sound_Throw))
        audio_play_sound(Sound_Throw, 1, false);
    
    Alpha -= AlphaSpeed;
    
    if (Alpha <= 0)
        instance_destroy(id);
}

SlotsX = X + 7;
SlotsY = Y + 7;

for (var i = 0; i <= global.Inventory_SlotIndex_RowEnd[UnknownEnum.Value_3]; i++)
{
    SlotPositionsX[i] = SlotsX + ((i % SlotsPerRow) * SlotW);
    SlotPositionsY[i] = SlotsY + ((i div SlotsPerRow) * SlotW);
}

for (var i = 0; i < GemSlots; i++)
{
    SlotPositionsX_Gems[i] = SlotsX_Gems + ((i % 2) * SlotW);
    SlotPositionsY_Gems[i] = SlotsY + ((i div 2) * SlotW);
}

MenuX = X + ((W - MenuStrW) / 2) + 1;

enum UnknownEnum
{
    Value_3 = 3
}
