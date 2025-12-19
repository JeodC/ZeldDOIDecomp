function Beamos_Laser_Reset()
{
    LaserPointsX = 0;
    LaserPointsY = 0;
    LaserPointsX[0] = EyeX;
    LaserPointsY[0] = EyeY;
    LaserPoints = 1;
    Shooting = false;
}

function Beamos_Laser_Draw()
{
    var i = Beamos_Laser_MinPoint();
    
    while (i < LaserPoints)
    {
        draw_sprite(sEnemy_Beamos_Laser, 0, LaserPointsX[i], LaserPointsY[i]);
        i++;
    }
}

function Beamos_EyeX()
{
    return x + (dcos(-EyeA) * EyeR * 2);
}

function Beamos_EyeY()
{
    return (y - 19) + (dsin(-EyeA) * EyeR);
}

function Beamos_Laser_Hit(arg0, arg1)
{
    instance_create_layer(arg0, arg1, "ObjsHigher_" + FloorLevelStr, oBeamosHit);
    Beamos_DestroyLaserLights();
    Beamos_Laser_Reset();
}

function Beamos_Laser_MinPoint()
{
    return max(LaserPoints - LaserLength, 0);
}

function Beamos_DestroyLaserLights()
{
    for (var i = 0; i < array_length(LaserLights); i++)
        Lighting_DestroyLight(RoomIndex, LaserLights[i]);
    
    LaserLights = [];
}
