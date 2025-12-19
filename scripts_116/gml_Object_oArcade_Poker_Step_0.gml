event_inherited();

if (GameReady && (State == UnknownEnum.Value_2 || State == UnknownEnum.Value_5))
    Poker_KeyCheck_Start();

switch (State)
{
    case UnknownEnum.Value_0:
        break;
    
    case UnknownEnum.Value_1:
        global.Arcade_ActiveInst = self;
        Arcade_SetCam(CamW, CamH);
        GameSurface = surface_create(RoomW, RoomH);
        State = UnknownEnum.Value_2;
        break;
    
    case UnknownEnum.Value_3:
        audio_stop_sound(WinSound);
        global.Inventory_ItemData[UnknownEnum.Value_40].Amount -= Bet + 1;
        Poker_InitDeck();
        
        for (var i = 0; i < 5; i++)
        {
            Hand[i] = -1;
            HeldCards[i] = false;
            HoldPos = 0;
            CurrentHand = UnknownEnum.Value_0;
            CurrentHandStr = "";
            WinAmount = 0;
        }
        
        GameState = UnknownEnum.Value_1;
        alarm[11] = DealDelay;
        break;
    
    case UnknownEnum.Value_4:
        switch (GameState)
        {
            case UnknownEnum.Value_0:
                break;
            
            case UnknownEnum.Value_1:
                break;
            
            case UnknownEnum.Value_2:
                if (input_check_pressed("right"))
                {
                    GameReady = true;
                    alarm[1] = -1;
                    HoldPos = (HoldPos + 1) % 5;
                }
                
                if (input_check_pressed("left"))
                {
                    GameReady = true;
                    alarm[1] = -1;
                    HoldPos--;
                    
                    if (HoldPos < 0)
                        HoldPos = 4;
                }
                
                if (input_check_pressed("action"))
                    HeldCards[HoldPos] = !HeldCards[HoldPos];
                
                if (GameReady && input_check_pressed("sword"))
                {
                    for (var i = 0; i < 5; i++)
                        Hand[i] = HeldCards[i] ? Hand[i] : -1;
                    
                    CurrentHand = UnknownEnum.Value_0;
                    CurrentHandStr = "";
                    GameState = UnknownEnum.Value_3;
                    alarm[11] = DealDelay;
                }
                
                break;
            
            case UnknownEnum.Value_3:
                break;
        }
        
        break;
    
    case UnknownEnum.Value_5:
        break;
    
    case UnknownEnum.Value_6:
        CurrentHand = UnknownEnum.Value_0;
        CurrentHandStr = "";
        break;
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
    Value_40 = 40
}
