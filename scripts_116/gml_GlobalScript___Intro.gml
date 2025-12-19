global.RainSound = -4;

function Intro_ShowLink()
{
    with (oLink)
    {
        y += 40;
        Link_SetAutoMove(0, -1, WalkSpeed, 40);
    }
    
    oHUD.ShowLevelName = true;
    Music_Play(global.Music_LevelSongIndex[UnknownEnum.Value_0], 10);
    audio_sound_gain(global.RainSound, 0.7, 200);
    State = UnknownEnum.Value_2;
}

enum UnknownEnum
{
    Value_0,
    Value_2 = 2
}
