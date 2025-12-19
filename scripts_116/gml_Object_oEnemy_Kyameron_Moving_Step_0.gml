event_inherited();

if (!OnWaterTile(TMID, x + vx, y))
{
    if (Timeout)
        WallCollide_X = true;
    else
        vx *= -1;
}

if (!OnWaterTile(TMID, x, y + vy))
{
    if (Timeout)
        WallCollide_Y = true;
    else
        vy *= -1;
}

if (State == UnknownEnum.Value_10 || (Timeout && (WallCollide_X || WallCollide_Y)))
{
    instance_destroy(id);
    instance_create_layer(x, y, layer, oEnemy_Kyameron_Exploding);
    
    if (State == UnknownEnum.Value_10)
    {
        with (ParentInst)
            alarm[0] = IdleTime;
    }
    
    exit;
}

if (global.Paused || State == UnknownEnum.Value_10 || State == UnknownEnum.Value_11 || State == UnknownEnum.Value_13 || State == UnknownEnum.Value_15 || State == UnknownEnum.Value_16 || State == UnknownEnum.Value_17)
{
    ObjPause();
    exit;
}
else
{
    image_speed = LastImageSpeed;
}

enum UnknownEnum
{
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
