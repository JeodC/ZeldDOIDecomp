for (var i = 0; i < 5; i++)
{
    if (Hand[i] == -1)
    {
        Poker_PickCard(i);
        audio_play_sound(Sound_Poker_CardDeal, 1, false);
        break;
    }
}

for (var i = 0; i < 5; i++)
{
    if (Hand[i] == -1)
    {
        alarm[11] = DealDelay;
        exit;
    }
}

CurrentHand = Poker_HandValue();
CurrentHandStr = Poker_HandString(CurrentHand);
DealCardIndex = 0;
GameState++;

switch (GameState)
{
    case UnknownEnum.Value_2:
        if (CurrentHand > UnknownEnum.Value_0)
            audio_play_sound(Sound_Poker_Blip, 1, false);
        
        GameReady = false;
        alarm[1] = GameReadyDelay;
        break;
    
    case UnknownEnum.Value_4:
        if (CurrentHand > UnknownEnum.Value_0)
        {
            if (CurrentHand > 0 && CurrentHand <= 2)
                WinSound = Sound_Poker_Win1;
            
            if (CurrentHand > 2 && CurrentHand <= 3)
                WinSound = Sound_Poker_Win2;
            
            if (CurrentHand > 3 && CurrentHand <= 4)
                WinSound = Sound_Poker_Win3;
            
            if (CurrentHand > 4 && CurrentHand <= 8)
                WinSound = Sound_Poker_Win4;
            
            if (CurrentHand > 8)
                WinSound = Sound_Poker_Win5;
            
            audio_play_sound(WinSound, 1, false);
            WinAmount = Poker_GetWinAmount();
            global.Inventory_ItemData[UnknownEnum.Value_40].Amount += WinAmount;
        }
        
        State = UnknownEnum.Value_5;
        GameReady = false;
        alarm[1] = GameReadyDelay;
        break;
}

enum UnknownEnum
{
    Value_0,
    Value_2 = 2,
    Value_4 = 4,
    Value_5,
    Value_40 = 40
}
