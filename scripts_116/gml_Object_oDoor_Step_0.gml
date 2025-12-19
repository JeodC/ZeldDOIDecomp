if (Open)
{
    if (Status == UnknownEnum.Value_1 && !audio_is_playing(Sound_DoorOpen))
        audio_play_sound(Sound_DoorOpen, 1, false);
    
    if (Status != UnknownEnum.Value_6)
        UpdateStatus = true;
    
    Status = UnknownEnum.Value_6;
    DoorChangeAniFrame++;
    
    if (DoorChangeAniFrame >= 8)
    {
        Open = false;
        Status = Exit ? UnknownEnum.Value_4 : UnknownEnum.Value_0;
        DoorChangeAniFrame = 0;
        UpdateStatus = true;
    }
}

if (Close)
{
    if ((Status == UnknownEnum.Value_0 || Status == UnknownEnum.Value_3) && !audio_is_playing(Sound_DoorClose))
        audio_play_sound(Sound_DoorClose, 1, false);
    
    if (Status != UnknownEnum.Value_6)
        UpdateStatus = true;
    
    Status = UnknownEnum.Value_6;
    DoorChangeAniFrame++;
    
    if (DoorChangeAniFrame >= 8)
    {
        Close = false;
        Status = UnknownEnum.Value_1;
        DoorChangeAniFrame = 0;
        UpdateStatus = true;
        
        if (!(global.Level.Index == UnknownEnum.Value_13 && TemplateCheck(RoomIndex, UnknownEnum.Value_9, UnknownEnum.Value_2, "FinalBoss")))
        {
            with (oLink)
                UpdateState(UnknownEnum.Value_1);
        }
        
        global.Paused = false;
    }
}

if (Unlock)
{
    if (Status != UnknownEnum.Value_7)
        UpdateStatus = true;
    
    Status = UnknownEnum.Value_7;
    DoorChangeAniFrame++;
    
    if (DoorChangeAniFrame >= 8)
    {
        Unlock = false;
        Status = UnknownEnum.Value_0;
        DoorChangeAniFrame = 0;
        UpdateStatus = true;
    }
}

if (UpdateStatus)
{
    Door_DrawTiles(self);
    
    if (WallInst != -4)
    {
        if (Status == UnknownEnum.Value_0 || Status == UnknownEnum.Value_4 || Status == UnknownEnum.Value_9)
        {
            WallInst.BlockLink = false;
            WallInst.BlockLinkCarry = Status == UnknownEnum.Value_4;
            WallInst.BlockProjectiles = false;
        }
        
        if (Status == UnknownEnum.Value_1 || Status == UnknownEnum.Value_2 || Status == UnknownEnum.Value_8 || Status == UnknownEnum.Value_10)
        {
            WallInst.BlockLink = true;
            WallInst.BlockLinkCarry = true;
            WallInst.BlockProjectiles = true;
        }
        
        with (oLink)
        {
            if (House_Inside)
                other.WallInst.BlockLinkCarry = true;
        }
    }
    
    Door_UpdateLights();
    UpdateStatus = false;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_6 = 6,
    Value_7,
    Value_8,
    Value_9,
    Value_10,
    Value_13 = 13
}
