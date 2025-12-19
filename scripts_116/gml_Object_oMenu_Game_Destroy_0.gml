global.MenuInst = -4;
global.Paused = false;

if (!global.LinkDead)
{
    with (oLink)
        UpdateState(UnknownEnum.Value_1);
}

if (audio_is_playing(oLink.LowHealthSound))
    audio_resume_sound(oLink.LowHealthSound);

Time_PauseEnd();

enum UnknownEnum
{
    Value_1 = 1
}
