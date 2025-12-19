event_inherited();

switch (State)
{
    case UnknownEnum.Value_0:
        break;
    
    case UnknownEnum.Value_1:
        global.Arcade_ActiveInst = self;
        Arcade_SetCam(CamW, CamH);
        GameSurface = surface_create(RoomW, RoomH);
        Level = 0;
        Lives = 2;
        Score = 0;
        SpawnedArcade = false;
        State = UnknownEnum.Value_2;
        Zerberk_Level_Reset();
        break;
    
    case UnknownEnum.Value_2:
        break;
    
    case UnknownEnum.Value_3:
        Zerberk_Level_Reset();
        break;
    
    case UnknownEnum.Value_4:
        if (!Zerberk_InLevel(Hero.x, Hero.y))
            Zerberk_Level_Reset();
        
        break;
    
    case UnknownEnum.Value_5:
        if (input_check_pressed("inventory") || input_check_pressed("sword"))
            State = UnknownEnum.Value_1;
        
        break;
    
    case UnknownEnum.Value_6:
        Zerberk_Level_Destroy();
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
    Value_6
}
