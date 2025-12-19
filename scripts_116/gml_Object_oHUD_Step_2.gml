HealthCheckSound();

if (HealthLowPulseDir != 0)
{
    HealthLowPulse += (HealthLowPulseDir * 0.075);
    
    if (HealthLowPulse >= 1)
    {
        HealthLowPulse = 1;
        HealthLowPulseDir = -1;
    }
    
    if (HealthLowPulse <= 0)
    {
        HealthLowPulse = 0;
        HealthLowPulseDir = 0;
    }
    
    var _GB = (1 - HealthLowPulse) * 255;
    HealthLowPulseColor = make_color_rgb(255, _GB, _GB);
}

if (CheckPendentSecret)
{
    if (!instance_exists(oDialogueBox))
    {
        if (Pendant_Check(UnknownEnum.Value_5))
        {
            if (global.Level.Rooms[global.CurrentRoomIndex].Secret == -1)
            {
                with (oDoor)
                {
                    if (RoomIndex == global.CurrentRoomIndex && (Status == UnknownEnum.Value_8 || SecretType == UnknownEnum.Value_2))
                    {
                        var inst = instance_create_layer(oCamera.X + 100, oCamera.Y + 64, "System", oPendantAlert);
                        inst.image_index = UnknownEnum.Value_5;
                        break;
                    }
                }
            }
        }
        
        CheckPendentSecret = false;
    }
}

if (AddHealth > 0)
{
    if (alarm[1] <= 0)
    {
        if (AddHealthSoundCounter == 0)
            audio_play_sound(Sound_HealthRefill, 1, false);
        
        AddHealthSoundCounter = (AddHealthSoundCounter + 1) % 4;
        AddHealth -= 0.25;
        
        if (AddHealth <= 0)
        {
            AddHealth = 0;
            AddHealthSoundCounter = 0;
        }
        else
        {
            alarm[1] = 2;
        }
    }
}

if (AddMagic > 0)
{
    if ((global.Inventory_ItemData[UnknownEnum.Value_26].Amount - AddMagic) == 64)
    {
        AddMagic = 0;
        AddMagicSoundCounter = 0;
    }
    else if (alarm[2] <= 0)
    {
        if (AddMagicSoundCounter == 0)
        {
            audio_stop_sound(Sound_MagicMeter);
            audio_play_sound(Sound_MagicMeter, 1, false);
        }
        
        AddMagicSoundCounter = (AddMagicSoundCounter + 1) % 4;
        AddMagic -= 1;
        
        if (AddMagic == 0)
            AddMagicSoundCounter = 0;
        else
            alarm[2] = 2;
    }
}

if (AddRupees != 0)
{
    var Sign = sign(AddRupees);
    var AbsValue = abs(AddRupees);
    var Increment = Sign * ((AbsValue >= 500) ? 20 : ((AbsValue >= 100) ? 5 : 1));
    AddRupees -= Increment;
    
    if (!audio_is_playing(Sound_RupeeGetRegister))
    {
        audio_play_sound(Sound_RupeeGetRegister, 1, false);
    }
    else
    {
        AddRupeesCount++;
        
        if (AddRupeesCount >= 10)
        {
            audio_play_sound(Sound_RupeeGetRegister, 1, false);
            AddRupeesCount = 0;
        }
    }
    
    var _InvRupees = global.Inventory_ItemData[UnknownEnum.Value_40];
    _InvRupees.Amount = max(_InvRupees.Amount + Increment, 0);
    
    if (_InvRupees.Amount == 0)
    {
        oHUD.AddRupees = 0;
        oHUD.AddRupeesCount = 0;
    }
}

if (ShowLevelName)
{
    ShowLevelName_Alpha += (0.05 * ShowLevelName_FadeDir);
    
    if (ShowLevelName_FadeDir == 1 && ShowLevelName_Alpha >= 1)
    {
        ShowLevelName_Alpha = 1;
        
        if (!ShowLevelName_Pause)
        {
            alarm[0] = 120;
            ShowLevelName_Pause = true;
        }
    }
    
    if (ShowLevelName_FadeDir == -1 && ShowLevelName_Alpha <= 0)
    {
        ShowLevelName_Alpha = -3;
        ShowLevelName_FadeDir = 1;
        ShowLevelName = false;
    }
}

MagicW = global.Inventory_ItemData[UnknownEnum.Value_26].Amount - AddMagic;
RupeesStr = ScoreText(global.Inventory_ItemData[UnknownEnum.Value_40].Amount, 4);
AttackColor = (oLink.AttackPoints == 8) ? 51448 : 16777215;
DefenseColor = (oLink.DefensePoints == 8) ? 51448 : 16777215;
ArrowsColor = (global.Inventory_ItemData[UnknownEnum.Value_1].Amount[0] == Inventory_MaxAmount(UnknownEnum.Value_1)) ? 192 : 16777215;
BombsColor = (global.Inventory_ItemData[UnknownEnum.Value_5].Amount[0] == Inventory_MaxAmount(UnknownEnum.Value_5)) ? 192 : 16777215;
global.MapHidden = Curse_Check(UnknownEnum.Value_11) || global.Challenges[UnknownEnum.Value_3];
MapOwned = global.Inventory_ItemData[UnknownEnum.Value_28].Owns[0] || oLink.StandingOnMap;
CompassOwned = global.Inventory_ItemData[UnknownEnum.Value_10].Owns[0] || oLink.StandingOnCompass;
DirectionPendant = Pendant_Check(UnknownEnum.Value_4);
DrawMap = MapOwned || DirectionPendant;
DrawCompass = CompassOwned || DirectionPendant;

enum UnknownEnum
{
    Value_1 = 1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_8 = 8,
    Value_10 = 10,
    Value_11,
    Value_26 = 26,
    Value_28 = 28,
    Value_40 = 40
}
