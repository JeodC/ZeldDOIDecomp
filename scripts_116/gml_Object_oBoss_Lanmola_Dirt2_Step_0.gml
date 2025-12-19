SoundPaused = ObjPauseSound(Sound, SoundPaused);

if (global.Paused)
{
    ObjPause();
    exit;
}
else
{
    image_speed = LastImageSpeed;
}
