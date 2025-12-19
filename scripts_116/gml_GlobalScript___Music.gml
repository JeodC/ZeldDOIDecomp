function Music_InitData()
{
    global.Music_SongAsset[UnknownEnum.Value_0] = 
    {
        Intro: -4,
        Main: -4
    };
    global.Music_SongAsset[UnknownEnum.Value_1] = 
    {
        Intro: Music_Start_Intro,
        Main: Music_Start_Main
    };
    global.Music_SongAsset[UnknownEnum.Value_2] = 
    {
        Intro: Music_Castle_Intro,
        Main: Music_Castle_Main
    };
    global.Music_SongAsset[UnknownEnum.Value_3] = 
    {
        Intro: Music_Dungeon1_Intro,
        Main: Music_Dungeon1_Main
    };
    global.Music_SongAsset[UnknownEnum.Value_4] = 
    {
        Intro: Music_Dungeon2_Intro,
        Main: Music_Dungeon2_Main
    };
    global.Music_SongAsset[UnknownEnum.Value_5] = 
    {
        Intro: Music_Dungeon3_Intro,
        Main: Music_Dungeon3_Main
    };
    global.Music_SongAsset[UnknownEnum.Value_6] = 
    {
        Intro: Music_Village_Intro,
        Main: Music_Village_Main
    };
    global.Music_SongAsset[UnknownEnum.Value_7] = 
    {
        Intro: Music_Cave_Intro,
        Main: Music_Cave_Main
    };
    global.Music_SongAsset[UnknownEnum.Value_8] = 
    {
        Intro: -4,
        Main: Music_Village_Store
    };
    global.Music_SongAsset[UnknownEnum.Value_9] = 
    {
        Intro: -4,
        Main: Music_Village_Pub
    };
    global.Music_SongAsset[UnknownEnum.Value_10] = 
    {
        Intro: -4,
        Main: Music_Village_Arcade
    };
    global.Music_SongAsset[UnknownEnum.Value_11] = 
    {
        Intro: -4,
        Main: Music_Village_Letter
    };
    global.Music_SongAsset[UnknownEnum.Value_12] = 
    {
        Intro: -4,
        Main: Music_Mines
    };
    global.Music_SongAsset[UnknownEnum.Value_13] = 
    {
        Intro: Music_Fairy_Intro,
        Main: Music_Fairy_Main
    };
    global.Music_SongAsset[UnknownEnum.Value_14] = 
    {
        Intro: -4,
        Main: Music_GemPond
    };
    global.Music_SongAsset[UnknownEnum.Value_15] = 
    {
        Intro: Music_WishRoom_Intro,
        Main: Music_WishRoom_Main
    };
    global.Music_SongAsset[UnknownEnum.Value_16] = 
    {
        Intro: -4,
        Main: Music_Star
    };
    global.Music_SongAsset[UnknownEnum.Value_17] = 
    {
        Intro: -4,
        Main: Music_Village_Letter
    };
    global.Music_SongAsset[UnknownEnum.Value_18] = 
    {
        Intro: Music_TMNT_Intro,
        Main: Music_TMNT_Main
    };
    global.Music_SongAsset[UnknownEnum.Value_19] = 
    {
        Intro: Music_Boss_Intro,
        Main: Music_Boss_Main
    };
    global.Music_SongAsset[UnknownEnum.Value_20] = 
    {
        Intro: -4,
        Main: Music_Boss_Final_Hallway
    };
    global.Music_SongAsset[UnknownEnum.Value_21] = 
    {
        Intro: Music_Boss_Final_Intro,
        Main: Music_Boss_Final_Main
    };
    global.Music_LevelSongIndex = [UnknownEnum.Value_1, UnknownEnum.Value_2, UnknownEnum.Value_2, UnknownEnum.Value_2, UnknownEnum.Value_3, UnknownEnum.Value_3, UnknownEnum.Value_7, UnknownEnum.Value_4, UnknownEnum.Value_3, UnknownEnum.Value_3, UnknownEnum.Value_12, UnknownEnum.Value_4, UnknownEnum.Value_5, UnknownEnum.Value_20];
}

function Music_Play(arg0, arg1 = 1)
{
    if (oMusic.SongPlaying_Index == arg0)
        exit;
    
    oMusic.SongIndexAssets = global.Music_SongAsset[arg0];
    
    if (oMusic.SongIndexAssets.Intro != -4)
    {
        oMusic.SongPlaying_Asset = oMusic.SongIndexAssets.Intro;
        oMusic.SongPlaying_Intro = true;
    }
    else
    {
        oMusic.SongPlaying_Asset = oMusic.SongIndexAssets.Main;
        oMusic.SongPlaying_Intro = false;
    }
    
    oMusic.SongPlaying_Index = arg0;
    oMusic.alarm[0] = arg1;
    oMusic.State = UnknownEnum.Value_2;
}

function Music_Stop()
{
    audio_stop_sound(oMusic.SongPlaying_Inst);
    oMusic.SongPlaying_Inst = -4;
    oMusic.Fade = false;
    oMusic.State = UnknownEnum.Value_0;
}

function Music_Fade(arg0 = 0, arg1 = 70, arg2 = -1)
{
    if (oMusic.Fade)
        exit;
    
    oMusic.Fade_Frames = max(arg1, 1);
    oMusic.Fade_ToGain = arg0;
    var _GainDiff = arg0 - oMusic.SongPlaying_Gain;
    oMusic.Fade_GainPerFrame = _GainDiff / arg1;
    oMusic.Fade_NextSongIndex = arg2;
    oMusic.Fade = true;
}

function _Music_SetGain(arg0, arg1 = 0)
{
    oMusic.SongPlaying_Gain = clamp(arg0, 0, 1);
    audio_sound_gain(oMusic.SongPlaying_Inst, oMusic.SongPlaying_Gain, arg1);
}

function Music_Mute(arg0)
{
    oMusic.Mute = arg0;
    oMusic.MuteEnable = true;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_9,
    Value_10,
    Value_11,
    Value_12,
    Value_13,
    Value_14,
    Value_15,
    Value_16,
    Value_17,
    Value_18,
    Value_19,
    Value_20,
    Value_21
}
