event_inherited();
audio_stop_sound(Sound_Hookshot);

if (CapturedItem == -4)
    exit;

if (!instance_exists(CapturedItem))
    exit;

with (CapturedItem)
{
    z = 0;
    
    switch (oLink.Facing)
    {
        case 1:
            ObjSetY(oLink.y - 10);
            break;
        
        case 2:
            ObjSetY(oLink.y + 10);
            break;
        
        case 3:
            x = oLink.x - 10;
            ObjSetY(oLink.y);
            break;
        
        case 4:
            x = oLink.x + 10;
            ObjSetY(oLink.y);
            break;
    }
    
    layer = layer_get_id("Objs_" + GetFloorLevelString(oLink.FloorLevel));
    ShowShadow = true;
}
