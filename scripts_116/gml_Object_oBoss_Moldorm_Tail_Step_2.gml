LargeBodyCollision = place_meeting(x, y, oBoss_Moldorm) || place_meeting(x, y, oBoss_Moldorm_BodyL);

if (oLink.State != UnknownEnum.Value_21 && oLink.State != UnknownEnum.Value_20 && oBoss_Moldorm.State == UnknownEnum.Value_3)
{
    if (Hit_Started && !LargeBodyCollision)
    {
        var _Hit = false;
        
        switch (Hit_LinkWeaponClass)
        {
            case UnknownEnum.Value_0:
                oBoss_Moldorm.Energy -= global.LinkSwordDamage[ATTACK()][oBoss_Moldorm.EnergyIndex];
                _Hit = true;
                break;
            
            case UnknownEnum.Value_2:
                oBoss_Moldorm.Energy -= 1.5;
                _Hit = true;
                break;
            
            case UnknownEnum.Value_6:
            case UnknownEnum.Value_7:
            case UnknownEnum.Value_10:
            case UnknownEnum.Value_9:
                oBoss_Moldorm.Energy -= 1;
                _Hit = true;
                break;
        }
        
        if (_Hit)
        {
            if (oBoss_Moldorm.Energy <= 0.05)
            {
                oBoss_Moldorm.Energy = 0;
                oBoss_Moldorm.State = UnknownEnum.Value_19;
                audio_play_sound(Sound_Boss_Destroy, 1, false);
                audio_stop_sound(Sound_MoldormSkitter);
                
                with (oCape)
                    instance_destroy(id);
                
                instance_destroy();
                oBoss_Moldorm.alarm[5] = 120;
            }
            else
            {
                oBoss_Moldorm.State = UnknownEnum.Value_12;
                audio_play_sound(Sound_Boss_Hit, 1, false);
                oBoss_Moldorm.alarm[2] = 30;
            }
        }
    }
}

enum UnknownEnum
{
    Value_0,
    Value_2 = 2,
    Value_3,
    Value_6 = 6,
    Value_7,
    Value_9 = 9,
    Value_10,
    Value_12 = 12,
    Value_19 = 19,
    Value_20,
    Value_21
}
