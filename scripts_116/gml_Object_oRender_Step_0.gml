if (global.MosaicDo)
{
    Mosaic_SizeIndex += (Mosaic_Speed * Mosaic_SizeDir);
    
    if (Mosaic_SizeDir == 1 && Mosaic_SizeIndex >= Mosaic_SizeCount)
    {
        Mosaic_SizeIndex = Mosaic_SizeCount - 1;
        Mosaic_SizeDir = -1;
    }
    
    if (Mosaic_SizeDir == -1 && Mosaic_SizeIndex <= 0)
    {
        Mosaic_SizeIndex = 0;
        Mosaic_Size = 0;
        Mosaic_SizeDir = 1;
        Mosaic_Warp = false;
        global.MosaicDo = false;
        global.Paused = false;
        oHUD.CheckPendentSecret = true;
    }
    
    Mosaic_Size = Mosaic_Sizes[floor(Mosaic_SizeIndex)];
}

HeatDo = global.TransitionRoomIndex == -1 && global.Level.Rooms[global.CurrentRoomIndex].Heat;

if (HeatDo)
{
    HeatIndex += (HeatIndexDir * 0.08);
    
    if (HeatIndexDir == 1 && HeatIndex > HeatIndexMax)
        HeatIndexDir = -1;
    
    if (HeatIndexDir == -1 && HeatIndex <= HeatIndexMin)
        HeatIndexDir = 1;
}

if (global.FadeIn)
{
    global.FadeRadius += global.FadeRadiusV;
    global.FadeRadiusV += 0.25;
    
    if (global.FadeRadius >= 450)
        global.FadeIn = false;
}

if (global.FadeOut)
{
    global.FadeRadius -= global.FadeRadiusV;
    global.FadeRadiusV -= 0.28;
    
    if (global.FadeRadius <= -5)
    {
        global.FadeOut = false;
        global.RoomFadeBlackOut = true;
    }
}

global.InWaterFrame = (global.InWaterFrame + 1) % 24;
global.InWaterImgIndex = floor(global.InWaterFrame / 8);
