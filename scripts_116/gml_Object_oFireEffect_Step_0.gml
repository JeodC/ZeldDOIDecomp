if (!CanPause)
    exit;

if (global.Paused)
{
    ObjPause();
    exit;
}
else
{
    image_speed = LastImageSpeed;
}
