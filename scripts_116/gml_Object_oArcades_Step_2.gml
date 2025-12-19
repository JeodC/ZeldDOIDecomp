switch (State)
{
    case UnknownEnum.Value_0:
        break;
    
    case UnknownEnum.Value_1:
        break;
    
    case UnknownEnum.Value_2:
        break;
    
    case UnknownEnum.Value_3:
        Music_Fade(0.25, 12);
        
        with (oLink)
            UpdateState(UnknownEnum.Value_26);
        
        oLink.actionVideoGame = true;
        State = UnknownEnum.Value_4;
        break;
    
    case UnknownEnum.Value_4:
        break;
    
    case UnknownEnum.Value_5:
        with (oLink)
            UpdateState(UnknownEnum.Value_1);
        
        break;
    
    case UnknownEnum.Value_6:
        if (surface_exists(Sprite_BG))
            surface_free(Sprite_BG);
        
        if (surface_exists(GameSurface))
            surface_free(GameSurface);
        
        global.Arcade_ActiveInst = -4;
        Music_Fade(1, 12);
        oLink.actionVideoGame = false;
        
        with (oLink)
            UpdateState(UnknownEnum.Value_1);
        
        global.ArcadeVP_Show = false;
        GameAllowed = false;
        State = UnknownEnum.Value_0;
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
    Value_26 = 26
}
