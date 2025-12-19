if (StartFade)
{
    FadeToBlack_Alpha += 0.035;
    
    if (FadeToBlack_Alpha >= 1)
    {
        FadeToBlack_Alpha = 0;
        StartFade = false;
        ShowRed = true;
        alarm[1] = 1;
        audio_play_sound(Sound_LinkDying, 1, false);
    }
}

if (Falling)
{
    if (oLink.image_index >= 1.75)
    {
        oLink.image_index = 2;
        oLink.image_speed = 0;
        Falling = false;
        alarm[2] = 60;
    }
}

if (FadeToGameOver)
{
    FadeToBlack_Alpha += 0.035;
    
    if (FadeToBlack_Alpha >= 1)
    {
        FadeToBlack_Alpha = 1;
        FadeToGameOver = false;
        ShowRed = false;
        
        if (Inventory_ItemIndexExists(UnknownEnum.Value_34, UnknownEnum.Value_3) && !Curse_Check(UnknownEnum.Value_8))
        {
            alarm[5] = 40;
        }
        else
        {
            GameOver = true;
            GameOverSeq = layer_sequence_create("System", oCamera.X, oCamera.Y, seqGameOver);
            layer_sequence_play(GameOverSeq);
            alarm[11] = 98;
            global.StatsToAdd[UnknownEnum.Value_2]++;
        }
    }
}

if (GameOver)
{
    if (layer_sequence_is_finished(GameOverSeq))
    {
        layer_sequence_pause(GameOverSeq);
        GameOver = false;
        ShowMenu = true;
        alarm[3] = 8;
        audio_play_sound(Music_Fairy_Main, 1, true, 0.5);
    }
}

if (ShowMenu && !Quit)
{
    if (input_check_pressed("down"))
    {
        Selector_Index = (Selector_Index + 1) % 3;
        audio_play_sound(Sound_Text, 1, false);
    }
    
    if (input_check_pressed("up"))
    {
        Selector_Index--;
        
        if (Selector_Index < 0)
            Selector_Index = 2;
        
        audio_play_sound(Sound_Text, 1, false);
    }
    
    if (input_check_pressed("menu_input") && alarm[4] == -1)
    {
        audio_stop_all();
        audio_play_sound(Sound_TextDone, 1, false);
        alarm[3] = -1;
        alarm[4] = 45;
        Quit = true;
    }
}

if (PendantAni && PendantAni_V != 0)
{
    PendantAni_Y += PendantAni_V;
    
    if (PendantAni_Y <= PendantAni_YEnd)
    {
        PendantAni_Y = PendantAni_YEnd;
        PendantAni_V = 0;
        alarm[6] = 60;
    }
}

if (ReviveLink)
{
    oLink.StarColorIndex = (oLink.StarColorIndex + 1) % array_length(oLink.StarColors);
    oLink.StarLightIndex = (oLink.StarLightIndex + 0.5) % array_length(oLink.StarLightColors);
}

if (FadeToWhite)
{
    FadeToWhite_Alpha += 0.008;
    
    if (FadeToWhite_Alpha >= 1)
    {
        FadeToWhite_Alpha = 1;
        FadeToWhite = false;
        
        with (oLink)
        {
            UpdateState(UnknownEnum.Value_0);
            Invincible = true;
            global.Inventory_ItemData[UnknownEnum.Value_17].Amount = global.Inventory_ItemData[UnknownEnum.Value_18].Amount;
        }
        
        FadeToGame = true;
    }
}

if (FadeToGame)
{
    FadeToWhite_Alpha -= 0.008;
    
    if (FadeToWhite_Alpha <= 0)
    {
        FadeToWhite_Alpha = 0;
        
        with (oLink)
        {
            UpdateState(UnknownEnum.Value_1);
            LinkEnableFlashing();
            oLink.image_speed = 1;
        }
        
        Music_Play(LastSongIndex, 10);
        global.Paused = false;
        instance_destroy(self);
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_8 = 8,
    Value_17 = 17,
    Value_18,
    Value_34 = 34
}
