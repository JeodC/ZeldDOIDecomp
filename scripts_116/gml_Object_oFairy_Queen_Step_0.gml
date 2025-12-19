if (Start && !instance_exists(oDialogueBox))
{
    with (oLink)
        UpdateState(UnknownEnum.Value_0);
    
    global.Paused = true;
    Start = false;
    MoveCamera1 = true;
    oCamera.Override = true;
}

if (MoveCamera1)
{
    oCamera.Y -= 1;
    
    if (oCamera.Y <= (global.CurrentRoomY + 16))
    {
        Music_Fade(0, 80, UnknownEnum.Value_13);
        alarm[1] = 80;
        MoveCamera1 = false;
    }
}

if (Spawning)
{
    image_alpha += 0.01;
    
    if (image_alpha >= 1)
    {
        image_alpha = 1;
        Spawning = false;
        alarm[2] = 45;
    }
    
    var _LightRGB = image_alpha * 0.8;
    Lighting_UpdateLight_RGB(RoomIndex, LightIndex, [_LightRGB, _LightRGB, _LightRGB]);
}

if (MoveCamera2 && !instance_exists(oDialogueBox))
{
    with (oLink)
        UpdateState(UnknownEnum.Value_0);
    
    global.Paused = true;
    oCamera.Y += 1;
    image_alpha -= 0.01;
    
    if (image_alpha <= 0)
        image_alpha = 0;
    
    var _LightRGB = image_alpha * 0.8;
    Lighting_UpdateLight_RGB(RoomIndex, LightIndex, [_LightRGB, _LightRGB, _LightRGB]);
    
    if (oCamera.Y >= (global.CurrentRoomY + 140))
    {
        SpawnItems = true;
        MoveCamera2 = false;
    }
}

if (SpawnItems)
{
    ItemInst1 = ItemSpawn(Probs_RandomItemClass(UnknownEnum.Value_12), x - 40, y + 140, UnknownEnum.Value_12, UnknownEnum.Value_10, 0);
    ItemInst2 = ItemSpawn(Probs_RandomItemClass(UnknownEnum.Value_12), x + 40, y + 140, UnknownEnum.Value_12, UnknownEnum.Value_10, 0);
    audio_play_sound(Sound_Warp, 1, false);
    alarm[3] = 180;
    SpawnItems = false;
}

if (MoveCamera3)
{
    oCamera.Y -= 1;
    
    if (oCamera.Y <= CameraStartY)
    {
        oCamera.Y = CameraStartY;
        ItemInst1.Lighting = true;
        ItemInst2.Lighting = true;
        
        with (oLink)
            UpdateState(UnknownEnum.Value_1);
        
        global.Paused = false;
        oCamera.Override = false;
        MoveCamera3 = false;
        instance_destroy(id);
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_10 = 10,
    Value_12 = 12,
    Value_13
}
