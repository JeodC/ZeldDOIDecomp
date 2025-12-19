function ObjSetY(arg0)
{
    y_base = arg0;
    y = y_base - z;
}

function ObjPause()
{
    image_speed = 0;
    ObjIncAlarms();
}

function ObjIncAlarms()
{
    for (var i = 0; i < 12; i++)
    {
        if (alarm[i] > 0)
            alarm[i] += 1;
    }
}

function ObjSetImageSpeed(arg0)
{
    image_speed = arg0;
    LastImageSpeed = image_speed;
}

function Obj_DrawInWater(arg0 = true)
{
    if (!InWater || z > 3)
        exit;
    
    if (arg0)
        PixelRender_Dim(true, true, false, -4, 0, false, []);
    
    draw_sprite_stretched(global.InWaterSprite, global.InWaterImgIndex, (x - (InWaterSprW / 2)) + InWaterSprXOffset, y_base + InWaterSprYOffset, InWaterSprW, 7);
    
    if (arg0)
        shader_reset();
}

function ObjPauseSound(arg0, arg1)
{
    if (arg0 == -4)
        return false;
    
    if (global.Paused)
    {
        if (!arg1)
        {
            audio_pause_sound(arg0);
            arg1 = true;
        }
    }
    else if (arg1)
    {
        audio_resume_sound(arg0);
        arg1 = false;
    }
    
    return arg1;
}

function DirFaceLink()
{
    var D = point_direction(x, y, oLink.x, oLink.y);
    return DirFaceAngle(D);
}

function DirFaceAngle(arg0)
{
    if (arg0 >= 45 && arg0 < 135)
        return 1;
    else if ((arg0 >= 0 && arg0 < 45) || (arg0 >= 315 && arg0 <= 360))
        return 4;
    else if (arg0 >= 135 && arg0 < 225)
        return 3;
    else if (arg0 >= 225 && arg0 < 315)
        return 2;
}

function DirFacePos(arg0, arg1)
{
    var D = point_direction(x, y, arg0, arg1);
    
    if (D >= 45 && D < 135)
        return 1;
    else if ((D >= 0 && D < 45) || (D >= 315 && D <= 360))
        return 4;
    else if (D >= 135 && D < 225)
        return 3;
    else if (D >= 225 && D < 315)
        return 2;
}

function ObjCenterX()
{
    return bbox_left + ((bbox_right - bbox_left) / 2);
}

function ObjCenterY()
{
    return bbox_top + ((bbox_bottom - bbox_top) / 2);
}

function OppositeDir(arg0)
{
    switch (arg0)
    {
        case 3:
            return 4;
        
        case 4:
            return 3;
        
        case 1:
            return 2;
        
        case 2:
            return 1;
    }
}

function DirAngle(arg0)
{
    switch (arg0)
    {
        case 3:
            return 180;
        
        case 4:
            return 0;
        
        case 1:
            return 90;
        
        case 2:
            return 270;
    }
}

function RandomDir()
{
    return choose(1, 2, 3, 4);
}

function DrawMask(arg0 = false, arg1 = 1, arg2 = 32768)
{
    draw_set_alpha(arg1);
    draw_set_color(arg2);
    draw_rectangle(bbox_left, bbox_top, bbox_right - 1, bbox_bottom - 1, arg0);
    draw_set_alpha(1);
}

function EffectLayer(arg0)
{
    return (arg0 == 0) ? "ObjsHigher_Lower" : "ObjsHighest";
}
