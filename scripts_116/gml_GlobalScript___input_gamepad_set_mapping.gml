function __input_gamepad_set_mapping()
{
    static _global = __input_global();
    
    __custom_mapping = false;
    
    if (__blacklisted)
    {
        __set_custom_mapping();
        __mapping_gm_to_raw = {};
        __mapping_raw_to_gm = {};
        __mapping_array = [];
        exit;
    }
    
    if (__xinput)
    {
        __set_mapping(32781, 0, UnknownEnum.Value_0, "dpup");
        __set_mapping(32782, 1, UnknownEnum.Value_0, "dpdown");
        __set_mapping(32783, 2, UnknownEnum.Value_0, "dpleft");
        __set_mapping(32784, 3, UnknownEnum.Value_0, "dpright");
        __set_mapping(32778, 4, UnknownEnum.Value_0, "start");
        __set_mapping(32777, 5, UnknownEnum.Value_0, "back");
        __set_mapping(32779, 6, UnknownEnum.Value_0, "leftstick");
        __set_mapping(32780, 7, UnknownEnum.Value_0, "rightstick");
        __set_mapping(32773, 8, UnknownEnum.Value_0, "leftshoulder");
        __set_mapping(32774, 9, UnknownEnum.Value_0, "rightshoulder");
        __set_mapping(32769, 12, UnknownEnum.Value_0, "a");
        __set_mapping(32770, 13, UnknownEnum.Value_0, "b");
        __set_mapping(32771, 14, UnknownEnum.Value_0, "x");
        __set_mapping(32772, 15, UnknownEnum.Value_0, "y");
        __set_mapping(32785, 0, UnknownEnum.Value_1, "leftx");
        __set_mapping(32787, 2, UnknownEnum.Value_1, "rightx");
        var _mapping = __set_mapping(32786, 1, UnknownEnum.Value_1, "lefty");
        _mapping.__reverse = true;
        _mapping = __set_mapping(32788, 3, UnknownEnum.Value_1, "righty");
        _mapping.__reverse = true;
        var _mapping_lt = __set_mapping(32775, 4106, UnknownEnum.Value_1, "lefttrigger");
        var _mapping_rt = __set_mapping(32776, 4107, UnknownEnum.Value_1, "righttrigger");
        
        if (is_numeric(__steam_handle))
            __xinput_trigger_range = 0.99609375;
        else
            __xinput_trigger_range = 0.24609375;
        
        _mapping_lt.__scale = 1 / __xinput_trigger_range;
        _mapping_rt.__scale = 1 / __xinput_trigger_range;
        exit;
    }
    
    var _vendor_and_product = __vendor + __product;
    
    switch (__raw_type)
    {
        case "CommunityStadia":
            __input_trace("Setting default Stadia controller mapping");
            __set_face_button_mapping();
            __set_mapping(32773, 4, UnknownEnum.Value_0, "leftshoulder");
            __set_mapping(32774, 5, UnknownEnum.Value_0, "rightshoulder");
            __set_mapping(32779, 6, UnknownEnum.Value_0, "leftstick");
            __set_mapping(32780, 7, UnknownEnum.Value_0, "rightstick");
            __set_mapping(32777, 8, UnknownEnum.Value_0, "back");
            __set_mapping(32778, 9, UnknownEnum.Value_0, "start");
            __set_mapping(__input_global().__gp_guide, 10, UnknownEnum.Value_0, "guide");
            __set_mapping(__input_global().__gp_misc1, 14, UnknownEnum.Value_0, "misc1");
            __set_dpad_hat_mapping();
            __set_thumbstick_axis_mapping(true);
            __stadia_trigger_test = true;
            __set_mapping(32776, 11, UnknownEnum.Value_0, "righttrigger");
            __set_mapping(32775, 12, UnknownEnum.Value_0, "lefttrigger");
            __set_mapping(32787, 3, UnknownEnum.Value_1, "rightx");
            __set_mapping(32788, 4, UnknownEnum.Value_1, "righty");
            exit;
            break;
        
        case "CommunityGameCube":
            if (_vendor_and_product == "3412adbe" && true)
            {
                __input_trace("Setting GameCube adapter slot to alternate mapping");
                __set_mapping(32769, 0, UnknownEnum.Value_0, "a");
                __set_mapping(32771, 1, UnknownEnum.Value_0, "x");
                __set_mapping(32770, 2, UnknownEnum.Value_0, "b");
                __set_mapping(32772, 3, UnknownEnum.Value_0, "y");
                __set_mapping(32774, 4, UnknownEnum.Value_0, "rightshoulder");
                __set_mapping(32781, 8, UnknownEnum.Value_0, "dpup");
                __set_mapping(32782, 9, UnknownEnum.Value_0, "dpdown");
                __set_mapping(32783, 10, UnknownEnum.Value_0, "dpleft");
                __set_mapping(32784, 11, UnknownEnum.Value_0, "dpright");
                __set_thumbstick_axis_mapping(true);
                __set_mapping(32787, 3, UnknownEnum.Value_1, "rightx");
                __set_mapping(32788, 4, UnknownEnum.Value_1, "righty");
                var _mapping = __set_mapping(32775, 2, UnknownEnum.Value_1, "lefttrigger");
                _mapping.__clamp_positive = true;
                _mapping = __set_mapping(32776, 5, UnknownEnum.Value_1, "righttrigger");
                _mapping.__clamp_positive = true;
                exit;
            }
            
            break;
        
        case "AppleController":
            if (__guessed_type == false && true)
            {
                __input_trace("Setting MFi controller mapping");
                __set_mapping(32783, 0, UnknownEnum.Value_0, "dpleft");
                __set_mapping(32782, 1, UnknownEnum.Value_0, "dpdown");
                __set_mapping(32784, 2, UnknownEnum.Value_0, "dpright");
                __set_mapping(32781, 3, UnknownEnum.Value_0, "dpup");
                __set_mapping(32769, 4, UnknownEnum.Value_0, "a");
                __set_mapping(32770, 5, UnknownEnum.Value_0, "b");
                __set_mapping(32771, 6, UnknownEnum.Value_0, "x");
                __set_mapping(32772, 7, UnknownEnum.Value_0, "y");
                __set_mapping(32773, 8, UnknownEnum.Value_0, "leftshoulder");
                __set_mapping(32774, 9, UnknownEnum.Value_0, "rightshoulder");
                __set_mapping(32780, 10, UnknownEnum.Value_0, "rightstick");
                __set_mapping(32779, 11, UnknownEnum.Value_0, "leftstick");
                __set_mapping(32777, 13, UnknownEnum.Value_0, "back");
                __set_mapping(32778, 14, UnknownEnum.Value_0, "start");
                __set_mapping(32785, 0, UnknownEnum.Value_1, "leftx");
                __set_mapping(32787, 2, UnknownEnum.Value_1, "rightx");
                __set_mapping(32775, 0, undefined, "lefttrigger");
                __set_mapping(32776, 0, undefined, "righttrigger");
                var _mapping = __set_mapping(32786, 1, UnknownEnum.Value_1, "lefty");
                _mapping.__reverse = true;
                _mapping = __set_mapping(32788, 3, UnknownEnum.Value_1, "righty");
                _mapping.__reverse = true;
                __set_mapping(__input_global().__gp_guide, 12, UnknownEnum.Value_0, "guide");
                exit;
            }
            
            break;
        
        case "CommunityN64":
            if (__guessed_type == true)
                break;
            
            switch (_vendor_and_product)
            {
                case "8f0e1330":
                    break;
                
                case "63257505":
                    __input_trace("Overriding mapping to N64");
                    __set_mapping(32769, 1, UnknownEnum.Value_0, "a");
                    __set_mapping(32770, 2, UnknownEnum.Value_0, "b");
                    __set_mapping(32778, 12, UnknownEnum.Value_0, "start");
                    __set_mapping(32773, 4, UnknownEnum.Value_0, "leftshoulder");
                    __set_mapping(32774, 5, UnknownEnum.Value_0, "rightshoulder");
                    __set_mapping(32775, 6, UnknownEnum.Value_0, "lefttrigger");
                    __set_mapping(32776, 7, UnknownEnum.Value_0, "righttrigger");
                    __set_dpad_hat_mapping();
                    __set_thumbstick_axis_mapping(true);
                    var _mapping = __set_mapping(32787, undefined, UnknownEnum.Value_4, "rightx");
                    _mapping.__raw_negative = 3;
                    _mapping.__raw_positive = 8;
                    _mapping = __set_mapping(32788, undefined, UnknownEnum.Value_4, "righty");
                    _mapping.__raw_negative = 9;
                    _mapping.__raw_positive = 0;
                    exit;
                    break;
            }
            
            break;
        
        case "CommunityAnnePro":
            if (__input_global().__on_desktop)
            {
                __input_trace("Overriding mapping to Obins Anne Pro 2");
                var _mapping = __set_mapping(32775, 0, UnknownEnum.Value_1, "lefttrigger");
                _mapping.__extended_range = true;
                _mapping = __set_mapping(32776, 1, UnknownEnum.Value_1, "righttrigger");
                _mapping.__extended_range = true;
                __set_mapping(32785, 3, UnknownEnum.Value_1, "leftx");
                __set_mapping(32773, 0, UnknownEnum.Value_0, "leftshoulder");
                __set_mapping(32777, 1, UnknownEnum.Value_0, "back");
                __set_mapping(32783, 2, UnknownEnum.Value_0, "dpleft");
                __set_mapping(32781, 3, UnknownEnum.Value_0, "dpup");
                __set_mapping(32782, 4, UnknownEnum.Value_0, "dpdown");
                __set_mapping(32784, 5, UnknownEnum.Value_0, "dpright");
                __set_mapping(32774, 6, UnknownEnum.Value_0, "rightshoulder");
                __set_mapping(32778, 7, UnknownEnum.Value_0, "start");
                __set_mapping(32770, 8, UnknownEnum.Value_0, "b");
                __set_mapping(32772, 9, UnknownEnum.Value_0, "y");
                __set_mapping(32769, 10, UnknownEnum.Value_0, "a");
                __set_mapping(32771, 11, UnknownEnum.Value_0, "x");
                exit;
            }
            
            break;
        
        case "CommunityOuya":
            break;
        
        case "CommunityNeoGeoMini":
            if (__guessed_type == false && true)
            {
                __input_trace("Overriding mapping to NeoGeo Mini");
                __set_mapping(32769, 1, UnknownEnum.Value_0, "a");
                __set_mapping(32770, 0, UnknownEnum.Value_0, "b");
                __set_mapping(32771, 2, UnknownEnum.Value_0, "x");
                __set_mapping(32772, 3, UnknownEnum.Value_0, "y");
                __set_mapping(32777, 8, UnknownEnum.Value_0, "back");
                __set_mapping(32778, 9, UnknownEnum.Value_0, "start");
                __set_dpad_hat_mapping();
                exit;
            }
            
            break;
        
        case "CommunitySaturn":
            if (__guessed_type == false && false && _vendor_and_product == "7e051720")
            {
                if (__input_string_contains(__description, "Genesis 3btn"))
                {
                    __input_trace("Overriding mapping to Mega Drive 3b");
                    __set_mapping(32769, 1, UnknownEnum.Value_0, "a");
                    __set_mapping(32770, 0, UnknownEnum.Value_0, "b");
                    __set_mapping(32776, 5, UnknownEnum.Value_0, "righttrigger");
                    __set_mapping(32777, 7, UnknownEnum.Value_0, "back");
                    __set_mapping(32778, 9, UnknownEnum.Value_0, "start");
                    __set_dpad_hat_mapping();
                    __set_mapping(__input_global().__gp_guide, 12, UnknownEnum.Value_0, "guide");
                    exit;
                }
                else if (__input_string_contains(__description, "Genesis 6btn"))
                {
                    __input_trace("Overriding mapping to Mega Drive 6b");
                    __set_mapping(32769, 1, UnknownEnum.Value_0, "a");
                    __set_mapping(32770, 0, UnknownEnum.Value_0, "b");
                    __set_mapping(32771, 6, UnknownEnum.Value_0, "x");
                    __set_mapping(32772, 2, UnknownEnum.Value_0, "y");
                    __set_mapping(32774, 4, UnknownEnum.Value_0, "rightshoulder");
                    __set_mapping(32776, 5, UnknownEnum.Value_0, "righttrigger");
                    __set_mapping(32777, 7, UnknownEnum.Value_0, "back");
                    __set_mapping(32778, 9, UnknownEnum.Value_0, "start");
                    __set_dpad_hat_mapping();
                    __set_mapping(__input_global().__gp_guide, 12, UnknownEnum.Value_0, "guide");
                    exit;
                }
            }
            
            break;
        
        case "HIDJoyConLeft":
            __input_trace("Overriding mapping to Joy-Con Left");
            __set_mapping(32769, 9, UnknownEnum.Value_0, "a");
            __set_mapping(32770, 8, UnknownEnum.Value_0, "b");
            __set_mapping(32771, 7, UnknownEnum.Value_0, "x");
            __set_mapping(32772, 10, UnknownEnum.Value_0, "y");
            __set_mapping(32773, 2, UnknownEnum.Value_0, "leftshoulder");
            __set_mapping(32774, 4, UnknownEnum.Value_0, "rightshoulder");
            __set_mapping(32777, 5, UnknownEnum.Value_0, "back");
            __set_mapping(32778, 0, UnknownEnum.Value_0, "start");
            __set_mapping(32779, 6, UnknownEnum.Value_0, "leftstick");
            var _mapping = __set_mapping(32785, 1, UnknownEnum.Value_1, "leftx");
            _mapping.__limited_range = true;
            _mapping = __set_mapping(32786, 0, UnknownEnum.Value_1, "lefty");
            _mapping.__limited_range = true;
            _mapping.__reverse = true;
            exit;
            break;
        
        case "HIDJoyConRight":
            __input_trace("Overriding mapping to Joy-Con Right");
            __set_mapping(32769, 1, UnknownEnum.Value_0, "a");
            __set_mapping(32770, 2, UnknownEnum.Value_0, "b");
            __set_mapping(32771, 0, UnknownEnum.Value_0, "x");
            __set_mapping(32772, 3, UnknownEnum.Value_0, "y");
            __set_mapping(32777, 9, UnknownEnum.Value_0, "back");
            __set_mapping(32778, 8, UnknownEnum.Value_0, "start");
            __set_mapping(32773, 4, UnknownEnum.Value_0, "leftshoulder");
            __set_mapping(32774, 6, UnknownEnum.Value_0, "rightshoulder");
            __set_mapping(32779, 10, UnknownEnum.Value_0, "leftstick");
            var _mapping = __set_mapping(32785, 1, UnknownEnum.Value_1, "leftx");
            _mapping.__limited_range = true;
            _mapping.__reverse = true;
            _mapping = __set_mapping(32786, 0, UnknownEnum.Value_1, "lefty");
            _mapping.__limited_range = true;
            exit;
            break;
        
        case "HIDAtariVCSClassic":
            __input_trace("Overriding mapping to Atari VCS Classic");
            __set_mapping(32769, 0, UnknownEnum.Value_0, "a");
            __set_mapping(32770, 1, UnknownEnum.Value_0, "b");
            __set_mapping(32777, 2, UnknownEnum.Value_0, "back");
            __set_mapping(32778, 3, UnknownEnum.Value_0, "start");
            __set_dpad_hat_mapping();
            __set_mapping(__input_global().__gp_guide, 4, UnknownEnum.Value_0, "guide");
            exit;
            break;
        
        case "HIDWiiRemote":
            __input_trace("Overriding mapping to Wii Remote");
            __set_mapping(32783, 5, UnknownEnum.Value_0, "dpleft");
            __set_mapping(32782, 6, UnknownEnum.Value_0, "dpdown");
            __set_mapping(32781, 7, UnknownEnum.Value_0, "dpup");
            __set_mapping(32784, 8, UnknownEnum.Value_0, "dpright");
            __set_mapping(32769, 9, UnknownEnum.Value_0, "a");
            __set_mapping(32770, 10, UnknownEnum.Value_0, "b");
            __set_mapping(32773, 0, UnknownEnum.Value_0, "leftshoulder");
            __set_mapping(32775, 1, UnknownEnum.Value_0, "lefttrigger");
            __set_mapping(32777, 4, UnknownEnum.Value_0, "back");
            __set_mapping(32778, 3, UnknownEnum.Value_0, "start");
            __set_mapping(__input_global().__gp_guide, 2, UnknownEnum.Value_0, "guide");
            exit;
            break;
        
        case "HIDWiiClassic":
            __input_trace("Overriding mapping to Wii Classic");
            __set_mapping(32781, 11, UnknownEnum.Value_0, "dpup");
            __set_mapping(32783, 12, UnknownEnum.Value_0, "dpleft");
            __set_mapping(32782, 14, UnknownEnum.Value_0, "dpdown");
            __set_mapping(32784, 13, UnknownEnum.Value_0, "dpright");
            __set_mapping(32769, 1, UnknownEnum.Value_0, "a");
            __set_mapping(32770, 0, UnknownEnum.Value_0, "b");
            __set_mapping(32771, 3, UnknownEnum.Value_0, "x");
            __set_mapping(32772, 2, UnknownEnum.Value_0, "y");
            __set_mapping(32773, 4, UnknownEnum.Value_0, "leftshoulder");
            __set_mapping(32774, 5, UnknownEnum.Value_0, "rightshoulder");
            __set_mapping(32775, 6, UnknownEnum.Value_0, "lefttrigger");
            __set_mapping(32776, 7, UnknownEnum.Value_0, "righttrigger");
            __set_mapping(32777, 10, UnknownEnum.Value_0, "back");
            __set_mapping(32778, 9, UnknownEnum.Value_0, "start");
            __set_mapping(__input_global().__gp_guide, 8, UnknownEnum.Value_0, "guide");
            exit;
            break;
        
        case "CommunityLikeSwitch":
            if (_vendor_and_product == "00000000" && true)
            {
                __input_trace("Setting PowerA Switch controller mapping");
                __set_face_button_mapping();
                __set_dpad_and_thumbstick_mapping();
                __set_mapping(32773, 4, UnknownEnum.Value_0, "leftshoulder");
                __set_mapping(32774, 5, UnknownEnum.Value_0, "rightshoulder");
                __set_mapping(32775, 6, UnknownEnum.Value_0, "lefttrigger");
                __set_mapping(32776, 7, UnknownEnum.Value_0, "righttrigger");
                __set_mapping(32777, 8, UnknownEnum.Value_0, "back");
                __set_mapping(32778, 9, UnknownEnum.Value_0, "start");
                __set_mapping(__input_global().__gp_guide, 12, UnknownEnum.Value_0, "guide");
                __set_mapping(__input_global().__gp_misc1, 13, UnknownEnum.Value_0, "misc1");
                __set_mapping(32779, 10, UnknownEnum.Value_0, "leftstick");
                __set_mapping(32780, 11, UnknownEnum.Value_0, "rightstick");
                exit;
            }
        
        case "SwitchJoyConPair":
            break;
        
        case "SwitchJoyConLeft":
        case "SwitchJoyConRight":
            break;
    }
    
    switch (0)
    {
        case 0:
            if (_vendor_and_product == "5e04e002" || (_vendor_and_product == "5e04fd02" && gamepad_axis_value(__index, 1) == gamepad_axis_value(__index, 2) && gamepad_axis_value(__index, 4) == gamepad_axis_value(__index, 5) && __button_count == 17))
            {
                __input_trace("Setting Xbox One Wireless controller to alternate mapping. Trigger data unavailable.");
                __set_mapping(32769, 0, UnknownEnum.Value_0, "a");
                __set_mapping(32770, 1, UnknownEnum.Value_0, "b");
                __set_mapping(32771, 3, UnknownEnum.Value_0, "x");
                __set_mapping(32772, 4, UnknownEnum.Value_0, "y");
                __set_mapping(32773, 6, UnknownEnum.Value_0, "leftshoulder");
                __set_mapping(32774, 7, UnknownEnum.Value_0, "rightshoulder");
                __set_mapping(32777, 15, UnknownEnum.Value_0, "back");
                __set_mapping(32778, 11, UnknownEnum.Value_0, "start");
                __set_mapping(32779, 13, UnknownEnum.Value_0, "leftstick");
                __set_mapping(32780, 14, UnknownEnum.Value_0, "rightstick");
                __set_thumbstick_axis_mapping(true);
                __set_mapping(32787, 3, UnknownEnum.Value_1, "rightx");
                __set_mapping(32788, 4, UnknownEnum.Value_1, "righty");
                __set_dpad_hat_mapping();
                __set_mapping(32775, 0, undefined, "lefttrigger");
                __set_mapping(32776, 0, undefined, "righttrigger");
                __set_mapping(__input_global().__gp_guide, 16, UnknownEnum.Value_0, "guide");
                exit;
            }
            
            break;
        
        case 1:
            if (__mapping == "no mapping" && __button_count == 22 && __axis_count == 6 && __hat_count == 0)
            {
                __input_trace("Overriding from \"no mapping\" on Mac");
                __set_mapping(32769, 17, UnknownEnum.Value_0, "a");
                __set_mapping(32770, 18, UnknownEnum.Value_0, "b");
                __set_mapping(32771, 20, UnknownEnum.Value_0, "x");
                __set_mapping(32772, 21, UnknownEnum.Value_0, "y");
                __set_mapping(32779, 4, UnknownEnum.Value_0, "leftstick");
                __set_mapping(32780, 5, UnknownEnum.Value_0, "rightstick");
                __set_mapping(32776, 6, UnknownEnum.Value_0, "righttrigger");
                __set_mapping(32775, 7, UnknownEnum.Value_0, "lefttrigger");
                __set_mapping(32777, 8, UnknownEnum.Value_0, "back");
                __set_mapping(32778, 10, UnknownEnum.Value_0, "start");
                __set_mapping(32773, 13, UnknownEnum.Value_0, "leftshoulder");
                __set_mapping(32774, 14, UnknownEnum.Value_0, "rightshoulder");
                __set_thumbstick_axis_mapping();
                __set_mapping(__input_global().__gp_guide, 11, UnknownEnum.Value_0, "guide");
                __set_mapping(__input_global().__gp_misc1, 16, UnknownEnum.Value_0, "misc1");
                exit;
            }
            
            break;
        
        case 6:
            if (__guid == "03000000de2800000512000010010000")
            {
                __input_trace("Overriding mapping for Steam Deck controller");
                __set_mapping(__input_global().__gp_misc1, 2, UnknownEnum.Value_0, "misc1");
                __set_mapping(32769, 3, UnknownEnum.Value_0, "a");
                __set_mapping(32770, 4, UnknownEnum.Value_0, "b");
                __set_mapping(32771, 5, UnknownEnum.Value_0, "x");
                __set_mapping(32772, 6, UnknownEnum.Value_0, "y");
                __set_mapping(32773, 7, UnknownEnum.Value_0, "leftshoulder");
                __set_mapping(32774, 8, UnknownEnum.Value_0, "rightshoulder");
                __set_mapping(32775, 9, UnknownEnum.Value_0, "lefttrigger");
                __set_mapping(32776, 10, UnknownEnum.Value_0, "righttrigger");
                __set_mapping(32777, 11, UnknownEnum.Value_0, "back");
                __set_mapping(32778, 12, UnknownEnum.Value_0, "start");
                __set_mapping(__input_global().__gp_guide, 13, UnknownEnum.Value_0, "guide");
                __set_mapping(32779, 14, UnknownEnum.Value_0, "leftstick");
                __set_mapping(32780, 15, UnknownEnum.Value_0, "rightstick");
                __set_mapping(32781, 16, UnknownEnum.Value_0, "dpup");
                __set_mapping(32782, 17, UnknownEnum.Value_0, "dpdown");
                __set_mapping(32783, 18, UnknownEnum.Value_0, "dpleft");
                __set_mapping(32784, 19, UnknownEnum.Value_0, "dpright");
                __set_mapping(__input_global().__gp_paddle2, 20, UnknownEnum.Value_0, "paddle2");
                __set_mapping(__input_global().__gp_paddle1, 21, UnknownEnum.Value_0, "paddle1");
                __set_mapping(__input_global().__gp_paddle4, 22, UnknownEnum.Value_0, "paddle4");
                __set_mapping(__input_global().__gp_paddle3, 23, UnknownEnum.Value_0, "paddle3");
                __set_thumbstick_axis_mapping();
                exit;
            }
            
            if (__description == "Generic X-Box pad" || __description == "X360 Controller")
            {
                __input_trace("Overriding mapping for Xbox controller");
                __set_face_button_mapping();
                __set_dpad_hat_mapping();
                __set_mapping(32773, 4, UnknownEnum.Value_0, "leftshoulder");
                __set_mapping(32774, 5, UnknownEnum.Value_0, "rightshoulder");
                __set_mapping(gp_back, 6, UnknownEnum.Value_0, "back");
                __set_mapping(32778, 7, UnknownEnum.Value_0, "start");
                __set_mapping(__input_global().__gp_guide, 8, UnknownEnum.Value_0, "guide");
                __set_mapping(32779, 9, UnknownEnum.Value_0, "leftstick");
                __set_mapping(32780, 10, UnknownEnum.Value_0, "rightstick");
                __set_mapping(32775, 2, UnknownEnum.Value_1, "lefttrigger");
                __set_mapping(32776, 5, UnknownEnum.Value_1, "righttrigger");
                __set_mapping(32785, 0, UnknownEnum.Value_1, "leftx");
                __set_mapping(32786, 1, UnknownEnum.Value_1, "lefty");
                __set_mapping(32787, 3, UnknownEnum.Value_1, "rightx");
                __set_mapping(32788, 4, UnknownEnum.Value_1, "righty");
                exit;
            }
            
            break;
        
        case 4:
            switch (__guid)
            {
                case "4e696e74656e646f2053776974636820":
                    if (__description == "Nintendo Switch Pro Controller")
                    {
                        __set_face_button_mapping();
                        __set_dpad_and_thumbstick_mapping();
                        __set_mapping(32773, 9, UnknownEnum.Value_0, "leftshoulder");
                        __set_mapping(32774, 10, UnknownEnum.Value_0, "rightshoulder");
                        __set_mapping(32775, 17, UnknownEnum.Value_0, "lefttrigger");
                        __set_mapping(32776, 18, UnknownEnum.Value_0, "righttrigger");
                        __set_mapping(32779, 7, UnknownEnum.Value_0, "leftstick");
                        __set_mapping(32780, 8, UnknownEnum.Value_0, "rightstick");
                        __set_mapping(32777, 14, UnknownEnum.Value_0, "back");
                        __set_mapping(32778, 6, UnknownEnum.Value_0, "start");
                        __set_mapping(__input_global().__gp_misc1, 5, UnknownEnum.Value_0, "misc1");
                        exit;
                    }
                    
                    if (__description == "Nintendo Switch Right Joy-Con")
                    {
                        __set_mapping(32769, 1, UnknownEnum.Value_0, "a");
                        __set_mapping(32770, 2, UnknownEnum.Value_0, "b");
                        __set_mapping(32771, 0, UnknownEnum.Value_0, "x");
                        __set_mapping(32772, 3, UnknownEnum.Value_0, "y");
                        __set_mapping(32773, 9, UnknownEnum.Value_0, "leftshoulder");
                        __set_mapping(32774, 17, UnknownEnum.Value_0, "rightshoulder");
                        __set_mapping(32777, 5, UnknownEnum.Value_0, "back");
                        __set_mapping(32778, 6, UnknownEnum.Value_0, "start");
                        __set_mapping(32779, 8, UnknownEnum.Value_0, "leftstick");
                        __set_mapping(32786, 0, UnknownEnum.Value_1, "lefty");
                        var _mapping = __set_mapping(32785, 1, UnknownEnum.Value_1, "leftx");
                        _mapping.__reverse = true;
                        exit;
                    }
                    
                    break;
                
                case "484a5a204d6179666c61736820576969":
                    if (__description == "HJZ Mayflash WiiU Pro Game Controller Adapter")
                    {
                        __input_trace("Setting WiiU Pro Adapter mapping");
                        __set_mapping(32771, 21, UnknownEnum.Value_0, "x");
                        __set_mapping(32769, 22, UnknownEnum.Value_0, "a");
                        __set_mapping(32770, 23, UnknownEnum.Value_0, "b");
                        __set_mapping(32772, 24, UnknownEnum.Value_0, "y");
                        __set_mapping(32773, 25, UnknownEnum.Value_0, "leftshoulder");
                        __set_mapping(32774, 26, UnknownEnum.Value_0, "rightshoulder");
                        __set_mapping(32775, 27, UnknownEnum.Value_0, "lefttrigger");
                        __set_mapping(32776, 28, UnknownEnum.Value_0, "righttrigger");
                        __set_mapping(32777, 29, UnknownEnum.Value_0, "back");
                        __set_mapping(32778, 30, UnknownEnum.Value_0, "start");
                        __set_mapping(32779, 31, UnknownEnum.Value_0, "leftstick");
                        __set_mapping(32780, 0, UnknownEnum.Value_0, "rightstick");
                        __set_dpad_and_thumbstick_mapping();
                        exit;
                    }
                    
                    if (__description == "HJZ Mayflash Wiimote PC Adapter")
                    {
                        __input_trace("Setting DolphinBar mapping");
                        __set_mapping(32771, 21, UnknownEnum.Value_0, "x");
                        __set_mapping(32772, 22, UnknownEnum.Value_0, "y");
                        __set_mapping(32769, 23, UnknownEnum.Value_0, "a");
                        __set_mapping(32770, 24, UnknownEnum.Value_0, "b");
                        __set_mapping(32773, 25, UnknownEnum.Value_0, "leftshoulder");
                        __set_mapping(32774, 26, UnknownEnum.Value_0, "rightshoulder");
                        __set_mapping(32775, 27, UnknownEnum.Value_0, "lefttrigger");
                        __set_mapping(32776, 28, UnknownEnum.Value_0, "righttrigger");
                        __set_mapping(32777, 29, UnknownEnum.Value_0, "back");
                        __set_mapping(32778, 30, UnknownEnum.Value_0, "start");
                        __set_dpad_and_thumbstick_mapping();
                        __set_mapping(__input_global().__gp_guide, 0, UnknownEnum.Value_0, "guide");
                        exit;
                    }
                    
                    break;
                
                case "64633735616665613536653363336132":
                    if (__description == "Retroid Pocket Controller")
                    {
                        __input_trace("Setting Retroid Pocket \"Retro mode\" mapping");
                        __set_mapping(32770, 0, UnknownEnum.Value_0, "b");
                        __set_mapping(32769, 1, UnknownEnum.Value_0, "a");
                        __set_mapping(32772, 2, UnknownEnum.Value_0, "y");
                        __set_mapping(32771, 3, UnknownEnum.Value_0, "x");
                    }
                    else
                    {
                        __input_trace("Setting Retroid Pocket \"Xbox mode\" mapping");
                        __set_face_button_mapping();
                    }
                    
                    __set_mapping(32778, 6, UnknownEnum.Value_0, "start");
                    __set_mapping(32779, 7, UnknownEnum.Value_0, "leftstick");
                    __set_mapping(32780, 8, UnknownEnum.Value_0, "rightstick");
                    __set_mapping(32773, 9, UnknownEnum.Value_0, "leftshoulder");
                    __set_mapping(32774, 10, UnknownEnum.Value_0, "rightshoulder");
                    __set_mapping(32777, 15, UnknownEnum.Value_0, "back");
                    __set_dpad_and_thumbstick_mapping();
                    var _mapping = __set_mapping(32775, 4, UnknownEnum.Value_1, "lefttrigger");
                    _mapping.__extended_range = true;
                    _mapping = __set_mapping(32776, 5, UnknownEnum.Value_1, "righttrigger");
                    _mapping.__extended_range = true;
                    __set_mapping(__input_global().__gp_paddle1, 19, UnknownEnum.Value_0, "paddle1");
                    __set_mapping(__input_global().__gp_paddle2, 20, UnknownEnum.Value_0, "paddle2");
                    exit;
                    break;
                
                case "4a4a0000000000006d61743300000000":
                case "4a4a0000000000000000000000000000":
                    __input_trace("Setting NeoGeo gamepad mapping");
                    __set_face_button_mapping();
                    __set_dpad_hat_mapping();
                    __set_mapping(32773, 9, UnknownEnum.Value_0, "leftshoulder");
                    __set_mapping(32774, 10, UnknownEnum.Value_0, "rightshoulder");
                    __set_mapping(32777, 15, UnknownEnum.Value_0, "back");
                    __set_mapping(32778, 6, UnknownEnum.Value_0, "start");
                    exit;
                    break;
            }
            
            break;
    }
    
    if ((1 && (__input_global().__on_desktop || false)) && true)
    {
        if (is_array(__sdl2_definition))
        {
            var _i = 2;
            
            repeat (array_length(__sdl2_definition) - 2)
            {
                var _entry = __sdl2_definition[_i];
                var _pos = string_pos(":", _entry);
                var _entry_name = string_copy(_entry, 1, _pos - 1);
                var _entry_1 = string_delete(_entry, 1, _pos);
                var _output_negative = false;
                var _output_positive = false;
                
                if (string_char_at(_entry_name, 1) == "-")
                {
                    _output_negative = true;
                    _entry_name = string_delete(_entry_name, 1, 1);
                }
                else if (string_char_at(_entry_name, 1) == "+")
                {
                    _output_positive = true;
                    _entry_name = string_delete(_entry_name, 1, 1);
                }
                
                var _gm_constant = variable_struct_get(_global.__sdl2_look_up_table, _entry_name);
                
                if (_gm_constant == undefined)
                {
                    if (_entry_name != "platform")
                        __input_trace("Warning! Entry name \"", _entry_name, "\" not recognised (full string was \"", _entry, "\")");
                }
                else
                {
                    var _input_invert = false;
                    var _input_reverse = false;
                    var _input_negative = false;
                    var _input_positive = false;
                    
                    if (string_char_at(_entry_1, string_length(_entry_1)) == "~")
                    {
                        _entry_1 = string_delete(_entry_1, string_length(_entry_1), 1);
                        
                        if (_gm_constant == 32785 || _gm_constant == 32786 || _gm_constant == 32787 || _gm_constant == 32788)
                            _input_reverse = true;
                        else
                            _input_invert = true;
                    }
                    
                    var _raw_type = undefined;
                    
                    do
                    {
                        var _char = string_char_at(_entry_1, 1);
                        _entry_1 = string_delete(_entry_1, 1, 1);
                        
                        switch (_char)
                        {
                            case "-":
                                _input_negative = true;
                                break;
                            
                            case "+":
                                _input_positive = true;
                                break;
                            
                            case "b":
                                if (_output_negative || _output_positive)
                                    _raw_type = UnknownEnum.Value_4;
                                else
                                    _raw_type = UnknownEnum.Value_0;
                                
                                break;
                            
                            case "a":
                                if (_output_negative || _output_positive)
                                    _raw_type = UnknownEnum.Value_5;
                                else
                                    _raw_type = UnknownEnum.Value_1;
                                
                                break;
                            
                            case "h":
                                if (_output_negative || _output_positive)
                                    _raw_type = UnknownEnum.Value_3;
                                else
                                    _raw_type = UnknownEnum.Value_2;
                                
                                break;
                            
                            default:
                                __input_trace("Warning! Mapping entry could not be parsed (full string was \"", _entry, "\")");
                                break;
                        }
                    }
                    until (_raw_type != undefined);
                    
                    var _input_slot = floor(real(_entry_1));
                    var _mapping = variable_struct_get(__mapping_gm_to_raw, _gm_constant);
                    
                    if (_raw_type == UnknownEnum.Value_3)
                    {
                        if (_mapping == undefined)
                            _mapping = __set_mapping(_gm_constant, undefined, _raw_type, _entry_name);
                        
                        if (_output_negative)
                            _mapping.__raw_negative = _input_slot;
                        else if (_output_positive)
                            _mapping.__raw_positive = _input_slot;
                    }
                    else if (_raw_type == UnknownEnum.Value_5)
                    {
                        if (_mapping == undefined)
                            _mapping = __set_mapping(_gm_constant, undefined, _raw_type, _entry_name);
                        
                        if (_output_negative)
                        {
                            _mapping.__raw_negative = _input_slot;
                            
                            if (_input_negative)
                                _mapping.__negative_clamp_negative = true;
                            
                            if (_input_positive)
                                _mapping.__negative_clamp_positive = true;
                        }
                        else if (_output_positive)
                        {
                            _mapping.__raw_positive = _input_slot;
                            
                            if (_input_negative)
                                _mapping.__positive_clamp_negative = true;
                            
                            if (_input_positive)
                                _mapping.__positive_clamp_positive = true;
                        }
                    }
                    else if (_raw_type == UnknownEnum.Value_4)
                    {
                        if (_mapping == undefined)
                            _mapping = __set_mapping(_gm_constant, undefined, _raw_type, _entry_name);
                        
                        if (_output_negative)
                            _mapping.__raw_negative = _input_slot;
                        else if (_output_positive)
                            _mapping.__raw_positive = _input_slot;
                    }
                    else
                    {
                        if (_mapping == undefined)
                            _mapping = __set_mapping(_gm_constant, _input_slot, _raw_type, _entry_name);
                        else
                            __input_trace("Warning! Mapping for \"", _entry, "\" is a redefinition of entry name \"", _entry_name, "\"");
                        
                        if (_input_invert)
                            _mapping.__invert = true;
                        
                        if (_input_reverse)
                            _mapping.__reverse = true;
                        
                        if (_input_negative)
                            _mapping.__clamp_negative = true;
                        
                        if (_input_positive)
                            _mapping.__clamp_positive = true;
                    }
                    
                    if (_raw_type == UnknownEnum.Value_2 || _raw_type == UnknownEnum.Value_3)
                    {
                        var _hat_mask = floor(10 * abs(real(_entry_1) % 1));
                        
                        if (_raw_type == UnknownEnum.Value_2)
                        {
                            _mapping.__hat_mask = _hat_mask;
                        }
                        else if (_raw_type == UnknownEnum.Value_3)
                        {
                            if (_output_negative)
                                _mapping.__hat_mask_negative = _hat_mask;
                            else if (_output_positive)
                                _mapping.__hat_mask_positive = _hat_mask;
                        }
                    }
                    
                    if (_raw_type == UnknownEnum.Value_1 || _raw_type == UnknownEnum.Value_5)
                    {
                        var _is_directional = __input_axis_is_directional(_gm_constant);
                        
                        if (false && _is_directional)
                            _mapping.__limited_range = true;
                        else if (1 && !_is_directional && gamepad_axis_count(__index) >= _input_slot)
                            _mapping.__extended_range = true;
                    }
                }
                
                _i++;
            }
            
            if (false && __hat_count > 0 && _vendor_and_product == "")
            {
                var _mapping = undefined;
                var _dpad_array = [32781, 32782, 32783, 32784];
                var _matched = 0;
                
                repeat (array_length(_dpad_array))
                {
                    _mapping = variable_struct_get(__mapping_gm_to_raw, array_get(_dpad_array, _matched));
                    
                    if (!is_struct(_mapping) || struct_get_from_hash(_mapping, variable_get_hash("__raw")) != (11 + _matched))
                        break;
                    
                    _matched++;
                }
                
                if (_matched == 4)
                    __set_dpad_hat_mapping();
            }
            
            if (__raw_type == "CommunityOuya" && true)
                __set_mapping(__input_global().__gp_guide, 15, UnknownEnum.Value_0, "guide");
            
            if (__simple_type == "xbox one" && __input_string_contains(__description, "Elite") && is_struct(variable_struct_get(__mapping_gm_to_raw, string(__input_global().__gp_paddle2))) && is_struct(variable_struct_get(__mapping_gm_to_raw, string(__input_global().__gp_paddle3))))
            {
                var _p2_mapping = variable_struct_get(__mapping_gm_to_raw, string(__input_global().__gp_paddle2)).__raw;
                __set_mapping(__input_global().__gp_paddle2, variable_struct_get(__mapping_gm_to_raw, string(__input_global().__gp_paddle3)).__raw, UnknownEnum.Value_0, "paddle2");
                __set_mapping(__input_global().__gp_paddle3, _p2_mapping, UnknownEnum.Value_0, "paddle3");
            }
            
            exit;
        }
        else
        {
            __input_trace("No SDL2 remapping available, falling back to GameMaker's mapping (", __mapping, ")");
        }
    }
    
    __set_mapping(32769, 32769, UnknownEnum.Value_0, "a", false);
    __set_mapping(32770, 32770, UnknownEnum.Value_0, "b", false);
    __set_mapping(32771, 32771, UnknownEnum.Value_0, "x", false);
    __set_mapping(32772, 32772, UnknownEnum.Value_0, "y", false);
    __set_mapping(32773, 32773, UnknownEnum.Value_0, "leftshoulder", false);
    __set_mapping(32774, 32774, UnknownEnum.Value_0, "rightshoulder", false);
    __set_mapping(32778, 32778, UnknownEnum.Value_0, "start", false);
    __set_mapping(32781, 32781, UnknownEnum.Value_0, "dpup", false);
    __set_mapping(32782, 32782, UnknownEnum.Value_0, "dpdown", false);
    __set_mapping(32783, 32783, UnknownEnum.Value_0, "dpleft", false);
    __set_mapping(32784, 32784, UnknownEnum.Value_0, "dpright", false);
    __set_mapping(32785, 32785, UnknownEnum.Value_1, "leftx", false);
    __set_mapping(32786, 32786, UnknownEnum.Value_1, "lefty", false);
    __set_mapping(32779, 32779, UnknownEnum.Value_0, "leftstick", false);
    __set_mapping(32787, 32787, UnknownEnum.Value_1, "rightx", false);
    __set_mapping(32788, 32788, UnknownEnum.Value_1, "righty", false);
    __set_mapping(32780, 32780, UnknownEnum.Value_0, "rightstick", false);
    __set_mapping(32775, 32775, UnknownEnum.Value_1, "lefttrigger", false);
    __set_mapping(32776, 32776, UnknownEnum.Value_1, "righttrigger", false);
    __set_mapping(32777, 32777, UnknownEnum.Value_0, "back", false);
    exit;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5
}
