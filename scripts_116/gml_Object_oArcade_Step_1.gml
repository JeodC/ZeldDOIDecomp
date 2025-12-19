event_inherited();

switch (State)
{
    case UnknownEnum.Value_0:
        break;
    
    case UnknownEnum.Value_2:
        if (input_check_pressed("item") || input_check_pressed("sword"))
        {
            var _Rupees = global.Inventory_ItemData[UnknownEnum.Value_40];
            
            if (_Rupees.Amount > 0)
            {
                Credits++;
                _Rupees.Amount--;
                audio_play_sound(Sound_Arcade_InsertCoin, 1, false);
            }
            else
            {
                audio_play_sound_stopall(Sound_Error);
            }
        }
        
        if (Credits > 0 && input_check_pressed("inventory"))
        {
            Credits--;
            State = UnknownEnum.Value_3;
        }
        
        break;
    
    case UnknownEnum.Value_4:
        if (input_check_pressed("menu_access"))
        {
            input_clear_momentary(true);
            State = UnknownEnum.Value_6;
        }
        
        break;
    
    case UnknownEnum.Value_5:
        if (input_check_pressed("menu_access"))
        {
            input_clear_momentary(true);
            State = UnknownEnum.Value_6;
        }
        
        break;
}

enum UnknownEnum
{
    Value_0,
    Value_2 = 2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_40 = 40
}
