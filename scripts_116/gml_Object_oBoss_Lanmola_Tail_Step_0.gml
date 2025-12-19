event_inherited();

if (oBoss_Lanmola_C.Destroyed[ID])
{
    vx = 0;
    vy = 0;
    vz = 0;
    exit;
}

if (global.Paused)
{
    ObjPause();
    exit;
}

Lanmola_Update();
var VY = vy - vz;

if (VY == 0)
    VY = 0.01 * sign(vy);

Angle = point_direction(0, 0, vx, VY);
