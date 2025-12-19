event_inherited();

switch (State)
{
    case UnknownEnum.Value_0:
        break;
    
    case UnknownEnum.Value_1:
        global.Arcade_ActiveInst = self;
        CamX = 0;
        CamXMin = CamX;
        Arcade_SetCam(CamW, CamH);
        GameSurface = surface_create(RoomW, RoomH);
        Score = 0;
        ShowNewHiscore = false;
        
        with (oPitfall_Harry)
            instance_destroy(id);
        
        with (oPitfall_Enemy)
            instance_destroy(id);
        
        with (oPitfall_Treasure)
            instance_destroy(id);
        
        Harry = instance_create_layer(HarryStartX, HarryStartY, "System", oPitfall_Harry);
        Harry.Lives = 3;
        Harry.visible = true;
        Harry.Killed = false;
        Harry.KilledDone = false;
        Harry.vx = 0;
        Harry.vy = 0;
        Harry.Dir = 1;
        Harry.actionJumping = false;
        NextEnemySpawnX = CamX + CamW_2;
        State = UnknownEnum.Value_2;
        break;
    
    case UnknownEnum.Value_2:
        break;
    
    case UnknownEnum.Value_3:
        Music = audio_play_sound(Pitfall_Music1, 1, false);
        audio_sound_gain(Music, 0.8, 0);
        instance_create_layer(CamXMax - irandom_range(500, 1000), HarryStartY, "System", oPitfall_Gold);
        break;
    
    case UnknownEnum.Value_4:
        if (!Harry.Killed)
        {
            if (!audio_is_playing(Music))
                Music = audio_play_sound(Pitfall_Music2, 1, true);
        }
        
        if (Harry.KilledDone)
        {
            Harry.Lives--;
            
            if (Harry.Lives == 0)
            {
                global.Arcade_ActiveInst.State = UnknownEnum.Value_5;
                Harry.visible = false;
                ShowNewHiscore = Arcade_Hiscore_Check(UnknownEnum.Value_0);
                exit;
            }
            
            Harry.Killed = false;
            Harry.KilledDone = false;
            Harry.y = HarryStartY;
            Harry.vx = 0;
            Harry.vy = 0;
            Harry.Dir = 1;
            Harry.actionJumping = false;
            Music = audio_play_sound(Pitfall_Music1, 1, false);
            
            with (oPitfall_Enemy)
                instance_destroy(id);
        }
        
        break;
    
    case UnknownEnum.Value_5:
        break;
    
    case UnknownEnum.Value_6:
        audio_stop_sound(Music);
        
        with (oPitfall_Harry)
            instance_destroy(id);
        
        with (oPitfall_Enemy)
            instance_destroy(id);
        
        with (oPitfall_Treasure)
            instance_destroy(id);
        
        break;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6
}
