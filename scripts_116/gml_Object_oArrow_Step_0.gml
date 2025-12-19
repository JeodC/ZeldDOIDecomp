event_inherited();

if (global.Paused)
{
    ObjPause();
    exit;
}
else
{
    image_speed = LastImageSpeed;
}

if (vx == 0 && vy < 0)
{
    var ArrowSwitchInst = instance_position(x, y - 2, oArrowSwitch);
    
    if (ArrowSwitchInst != -4 && ArrowSwitchInst.FloorLevel == FloorLevel)
    {
        ArrowSwitchInst.Activated = true;
        vy = 0;
        ObjSetY(ArrowSwitchInst.y + 6);
    }
}

if (WallCollided)
{
    vx = 0;
    vy = 0;
    image_index = 2;
    ObjSetImageSpeed(1);
    audio_play_sound_stopall(Sound_Arrow_Hit);
    WallCollided = false;
}

if (image_index >= (image_number - 1) && !DestroyTimer)
{
    alarm[0] = 60;
    image_index = 3;
    ObjSetImageSpeed(0);
    DestroyTimer = true;
}

x += vx;
ObjSetY(y_base + vy);
