if (global.Paused)
{
    ObjPause();
    exit;
}
else
{
    image_speed = LastImageSpeed;
}

Index = floor(image_index);
event_inherited();

if (Red && image_index < 1)
    image_index = 1;
