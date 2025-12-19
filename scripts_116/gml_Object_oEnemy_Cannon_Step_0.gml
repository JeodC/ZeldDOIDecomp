event_inherited();

if (Hit_Started)
{
    instance_destroy(WallInst);
    exit;
}

if (WallInit)
{
    WallInst = WallObj_Create("Objs_" + FloorLevelStr, x - 8, y - 8, 2, 2);
    WallInst.BlockProjectiles = false;
    WallInst.BlockItems = false;
    WallInst.IsEnemy = true;
    WallInit = false;
}

if (ShootReady && oLink.State == UnknownEnum.Value_12 && !StopWatch)
{
    var Dir = DirFaceLink();
    var ShotX = x;
    var ShotY = y;
    
    switch (Dir)
    {
        case 1:
            ShotY -= 8;
            break;
        
        case 2:
            ShotY += 8;
            break;
        
        case 3:
            ShotX -= 8;
            break;
        
        case 4:
            ShotX += 8;
            break;
    }
    
    var inst = instance_create_layer(ShotX, ShotY, "ObjsHigher_" + FloorLevelStr, oRedBall);
    var Angle = DirAngle(Dir);
    inst.vx = lengthdir_x(2, Angle);
    inst.vy = lengthdir_y(2, Angle);
    
    if (oCamera.InView(ShotX, ShotY))
        audio_play_sound_stopall(Sound_Medusa);
    
    ShootReady = false;
}

if (!ShootReady && oLink.State != UnknownEnum.Value_12)
    ShootReady = true;

enum UnknownEnum
{
    Value_12 = 12
}
