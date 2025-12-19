if (global.Paused)
{
    image_speed = 0;
    exit;
}
else
{
    image_speed = LastImageSpeed;
}

x += vx;
ObjSetY(y_base + vy);
event_inherited();

if (WallCollided)
{
    instance_create_layer(x, y_base, "Objs_" + GetFloorLevelString(FloorLevel), oRock_Explosion);
    instance_destroy(id);
}
