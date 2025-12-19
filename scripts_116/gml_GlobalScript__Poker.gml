function Poker_KeyCheck_Start()
{
    if (input_check_pressed("item"))
    {
        Bet = (Bet + 1) % 5;
        audio_play_sound(Sound_Poker_Blip, 1, false);
    }
    
    if (input_check_pressed("sword"))
    {
        if (global.Inventory_ItemData[UnknownEnum.Value_40].Amount >= (Bet + 1))
            State = UnknownEnum.Value_3;
        else
            audio_play_sound_stopall(Sound_Error);
    }
}

function Poker_InitDeck()
{
    ds_list_clear(Deck);
    
    for (var i = 0; i < 52; i++)
        ds_list_add(Deck, i);
    
    ds_list_shuffle(Deck);
}

function Poker_PickCard(arg0)
{
    Hand[arg0] = ds_list_find_value(Deck, 0);
    ds_list_delete(Deck, 0);
}

function Poker_ResetHeldCards()
{
    for (var i = 0; i < 5; i++)
        HeldCards[i] = false;
}

function Poker_HandValue()
{
    CardValuesList = ds_list_create();
    CardSuitsList = ds_list_create();
    
    for (var i = 0; i < 5; i++)
    {
        ds_list_add(CardValuesList, Hand[i] % 13);
        ds_list_add(CardSuitsList, Hand[i] div 13);
    }
    
    ds_list_sort(CardValuesList, true);
    ds_list_sort(CardSuitsList, true);
    
    for (var i = 0; i < 5; i++)
    {
        CardValues[i] = ds_list_find_value(CardValuesList, i);
        CardSuits[i] = ds_list_find_value(CardSuitsList, i);
    }
    
    ds_list_destroy(CardValuesList);
    ds_list_destroy(CardSuitsList);
    
    if (((CardValues[0] + 1) == CardValues[1] && (CardValues[1] + 1) == CardValues[2] && (CardValues[2] + 1) == CardValues[3] && (CardValues[3] + 1) == CardValues[4]) || (CardValues[0] == 0 && CardValues[1] == 1 && CardValues[2] == 2 && CardValues[3] == 3 && CardValues[4] == 12))
    {
        if (CardSuits[0] == CardSuits[1] && CardSuits[1] == CardSuits[2] && CardSuits[2] == CardSuits[3] && CardSuits[3] == CardSuits[4])
        {
            if (CardValues[0] == 8 && CardValues[1] == 9 && CardValues[2] == 10 && CardValues[3] == 11 && CardValues[4] == 12)
                return UnknownEnum.Value_9;
            
            return UnknownEnum.Value_8;
        }
        
        return UnknownEnum.Value_4;
    }
    
    if ((CardValues[0] == CardValues[1] && CardValues[1] == CardValues[2] && CardValues[2] == CardValues[3]) || (CardValues[1] == CardValues[2] && CardValues[2] == CardValues[3] && CardValues[3] == CardValues[4]))
        return UnknownEnum.Value_7;
    
    if ((CardValues[0] == CardValues[1] && CardValues[1] == CardValues[2] && CardValues[3] == CardValues[4] && CardValues[3] != CardValues[0] && CardValues[4] != CardValues[0]) || (CardValues[0] == CardValues[1] && CardValues[2] == CardValues[3] && CardValues[3] == CardValues[4] && CardValues[0] != CardValues[2] && CardValues[1] != CardValues[2]))
        return UnknownEnum.Value_6;
    
    if (CardSuits[0] == CardSuits[1] && CardSuits[1] == CardSuits[2] && CardSuits[2] == CardSuits[3] && CardSuits[3] == CardSuits[4])
        return UnknownEnum.Value_5;
    
    if ((CardValues[0] == CardValues[1] && CardValues[1] == CardValues[2] && CardValues[3] != CardValues[0] && CardValues[3] != CardValues[4]) || (CardValues[1] == CardValues[2] && CardValues[2] == CardValues[3] && CardValues[0] != CardValues[1] && CardValues[0] != CardValues[4]) || (CardValues[2] == CardValues[3] && CardValues[3] == CardValues[4] && CardValues[0] != CardValues[2] && CardValues[0] != CardValues[1]))
        return UnknownEnum.Value_3;
    
    if ((CardValues[0] == CardValues[1] && CardValues[2] == CardValues[3] && CardValues[4] != CardValues[0] && CardValues[4] != CardValues[2]) || (CardValues[0] == CardValues[1] && CardValues[3] == CardValues[4] && CardValues[2] != CardValues[0] && CardValues[2] != CardValues[3]) || (CardValues[1] == CardValues[2] && CardValues[3] == CardValues[4] && CardValues[0] != CardValues[1] && CardValues[0] != CardValues[3]))
        return UnknownEnum.Value_2;
    
    if ((CardValues[0] == CardValues[1] && CardValues[0] >= 9) || (CardValues[1] == CardValues[2] && CardValues[1] >= 9) || (CardValues[2] == CardValues[3] && CardValues[2] >= 9) || (CardValues[3] == CardValues[4] && CardValues[3] >= 9))
        return UnknownEnum.Value_1;
}

function Poker_HandString(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_1:
            return "Jacks or Better";
        
        case UnknownEnum.Value_2:
            return "2 Pairs";
        
        case UnknownEnum.Value_3:
            return "3 of a Kind";
        
        case UnknownEnum.Value_4:
            return "Straight";
        
        case UnknownEnum.Value_5:
            return "Flush";
        
        case UnknownEnum.Value_6:
            return "Full House";
        
        case UnknownEnum.Value_7:
            return "Four of a Kind";
        
        case UnknownEnum.Value_8:
            return "Straight Flush";
        
        case UnknownEnum.Value_9:
            return "Royal Flush";
    }
    
    return "";
}

function Poker_GetWinAmount()
{
    return WinMul[CurrentHand] * (Bet + 1);
}

function Poker_CardIndex(arg0, arg1)
{
    return (arg1 * 13) + arg0;
}

function Poker_MoveCardToFront(arg0)
{
    var DeckIndex = ds_list_find_index(Deck, arg0);
    ds_list_delete(Deck, DeckIndex);
    ds_list_insert(Deck, 0, arg0);
}

function Poker_RealValueToIndex(arg0)
{
    return arg0 - 2;
}

enum UnknownEnum
{
    Value_1 = 1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_9,
    Value_40 = 40
}
