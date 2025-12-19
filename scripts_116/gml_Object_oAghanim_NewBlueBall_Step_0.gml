if (global.Paused)
{
    ObjPause();
    exit;
}
else
{
    image_speed = LastImageSpeed;
}

x += vx;
y += vy;
ObjSetY(y);
event_inherited();

if (WallCollided)
    instance_destroy(id);
