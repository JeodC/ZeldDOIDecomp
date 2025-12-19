switch (State)
{
    case UnknownEnum.Value_5:
        if (!audio_is_playing(global.CrashSoundID) || AllowAnotherCrashSound)
        {
            AllowAnotherCrashSound = false;
            global.CrashSoundID = audio_play_sound(Sound_PotShatter, 1, false);
            alarm[0] = 3;
        }
        
        var inst = instance_create_layer(x, y - 8, "ObjsHigher_" + FloorLevelStr, oPotExplosion);
        inst.PaletteIndex = 1 + Index;
        PickupObj_RevealContents();
        instance_destroy(id);
        break;
}

enum UnknownEnum
{
    Value_5 = 5
}
