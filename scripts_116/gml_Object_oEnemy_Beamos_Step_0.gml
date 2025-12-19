event_inherited();
EyeX = Beamos_EyeX();
EyeY = Beamos_EyeY();

if (Hit_Started && State == UnknownEnum.Value_10)
{
    instance_destroy(WallInst);
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

if (WallInit)
{
    WallInst = WallObj_Create("ObjsHigher_" + FloorLevelStr, x - 8, y - 16, 2, 2);
    WallInst.IsEnemy = true;
    WallInit = false;
}

if (CanShoot && oCamera.InView(EyeX, EyeY) && !oLink.Cape)
{
    ClosestWall = SightDistance;
    
    for (var i = 1; i < (SightDistance / 4); i++)
    {
        ClosestWallPosX = EyeX + lengthdir_x(i * 4, EyeA);
        ClosestWallPosY = EyeY + lengthdir_y(i * 4, EyeA);
        var _WallInst = collision_point(ClosestWallPosX, ClosestWallPosY, oWall, false, true);
        
        if (_WallInst != -4)
        {
            if (_WallInst != WallInst && (_WallInst.BlockProjectiles || _WallInst.IsDoorEntrance))
            {
                ClosestWall = point_distance(EyeX, EyeY, ClosestWallPosX, ClosestWallPosY);
                break;
            }
        }
    }
    
    var DistToLink = point_distance(EyeX, EyeY, oLink.x, oLink.y - 4);
    AngleToLink = point_direction(EyeX, EyeY, oLink.x, oLink.y - 4);
    
    if (DistToLink <= SightDistance && DistToLink < ClosestWall && abs(angle_difference(EyeA, AngleToLink)) <= 4)
    {
        Flashing = true;
        EyeMove = false;
        CanShoot = false;
        audio_play_sound(Sound_Medusa, 1, false);
        alarm[2] = FlashSpeed;
    }
}

if (Shooting)
{
    var NewPointX, NewPointY;
    
    repeat (3)
    {
        NewPointX = LaserPointsX[LaserPoints - 1] + lengthdir_x(LaserPointSpacing, AngleToLink);
        NewPointY = LaserPointsY[LaserPoints - 1] + lengthdir_y(LaserPointSpacing, AngleToLink);
        array_push(LaserPointsX, NewPointX);
        array_push(LaserPointsY, NewPointY);
        array_push(LaserLights, Lighting_CreateLight(RoomIndex, NewPointX, NewPointY, 0.09, [0.9, 0.2, 0.2]));
        LaserPoints++;
    }
    
    for (var i = 0; i < Beamos_Laser_MinPoint(); i++)
        Lighting_UpdateLight_Visible(RoomIndex, LaserLights[i], false);
    
    if (collision_point(NewPointX, NewPointY, oLink, false, true) != -4)
    {
        with (oLink)
        {
            if (!Shield_Hit(other.id, NewPointX, NewPointY))
                LinkHit(other.AngleToLink, 4, 16, other.Attack);
        }
        
        Beamos_Laser_Hit(NewPointX, NewPointY);
        exit;
    }
    
    var _WallInst = collision_point(NewPointX, NewPointY, oWall, false, true);
    
    if (_WallInst != -4)
    {
        if (_WallInst != WallInst && (_WallInst.BlockProjectiles || _WallInst.IsDoorEntrance))
        {
            Beamos_Laser_Hit(NewPointX, NewPointY);
            exit;
        }
    }
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
