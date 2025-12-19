function Curtain_Reveal(arg0)
{
    if (!arg0.Revealed)
    {
        arg0.Revealed = true;
        audio_play_sound_stopall(Sound_Curtain);
        
        if (arg0.DoorInst != -4)
            audio_play_sound_stopall(Sound_Secret);
    }
}
