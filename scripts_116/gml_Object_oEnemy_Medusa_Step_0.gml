event_inherited();

if (Hit_Started)
{
    instance_destroy(WallInst);
    exit;
}

if (global.Paused)
{
    ObjPause();
    exit;
}
else
{
    image_speed = LastImageSpeed;
}

if (WallInit)
{
    WallInst = WallObj_Create("Objs_" + FloorLevelStr, x - 8, y - 8, 2, 2);
    WallInst.BlockProjectiles = false;
    WallInst.BlockItems = false;
    WallInst.IsEnemy = true;
    WallInit = false;
}
