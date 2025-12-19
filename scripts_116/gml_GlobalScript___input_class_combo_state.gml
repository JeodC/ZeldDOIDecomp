function __input_class_combo_state(arg0, arg1) constructor
{
    static __global = __input_global();
    static __combo_params = __global.__combo_params;
    
    static __reset = function()
    {
        __success = false;
        __direction = undefined;
        __new_phase = __phase != 0;
        __phase = 0;
        __start_time = __input_get_time();
        __charge_trigger = true;
        __charge_measure = false;
        __charge_start_time = undefined;
        __charge_end_time = undefined;
        __allow_hold_dict = {};
        __require_hold_array = [];
        __direction = undefined;
        __direction_mapping = {};
    };
    
    static __evaluate = function(arg0)
    {
        static _all_verb_array = __global.__all_verb_array;
        
        __new_phase = false;
        
        if (__success)
            __reset();
        
        var _phase_array = __combo.__phase_array;
        var _combo_length = array_length(_phase_array);
        
        if (_combo_length <= 0)
            return false;
        
        var _phase_data = _phase_array[__phase];
        var _phase_type = _phase_data.__type;
        var _phase_verb = _phase_data.__verb;
        
        if (__direction == undefined && __combo.__directional)
            __determine_direction(arg0, _phase_verb);
        
        _phase_verb = variable_struct_get(__direction_mapping, _phase_verb) ?? _phase_verb;
        
        if (__charge_measure)
        {
            __charge_end_time = __input_get_time();
        }
        else if (__phase > 0 && (__input_get_time() - __start_time) > __combo.__phase_timeout)
        {
            __input_trace("Combo \"", __name, "\" timeout failed (phase=", __phase, ")");
            __reset();
            return false;
        }
        
        var _verb_state = variable_struct_get(arg0, _phase_verb);
        
        if (!_verb_state.__inactive)
        {
            switch (_phase_type)
            {
                case UnknownEnum.Value_0:
                    if (_verb_state.__press)
                    {
                        __input_trace("Combo \"", __name, "\" phase ", __phase, " passed (press \"", _phase_verb, "\")");
                        __add_to_allow_hold_dict(_phase_verb);
                        __next_phase(_phase_array, true);
                    }
                    
                    break;
                
                case UnknownEnum.Value_1:
                    if (!_verb_state.__held)
                    {
                        __input_trace("Combo \"", __name, "\" phase ", __phase, " passed (release \"", _phase_verb, "\")");
                        __remove_from_allow_hold_dict(_phase_verb);
                        __remove_from_require_hold_array(_phase_verb);
                        __next_phase(_phase_array, true);
                    }
                    
                    break;
                
                case UnknownEnum.Value_2:
                    if (_verb_state.__press)
                    {
                        __input_trace("Combo \"", __name, "\" phase ", __phase, " passed (PRESS or release \"", _phase_verb, "\")");
                        __add_to_allow_hold_dict(_phase_verb);
                        __next_phase(_phase_array, true);
                    }
                    else if (_verb_state.__release)
                    {
                        __input_trace("Combo \"", __name, "\" phase ", __phase, " passed (press or RELEASE \"", _phase_verb, "\")");
                        __remove_from_allow_hold_dict(_phase_verb);
                        __remove_from_require_hold_array(_phase_verb);
                        __next_phase(_phase_array, true);
                    }
                    
                    break;
                
                case UnknownEnum.Value_3:
                    if (_verb_state.__held)
                    {
                        __input_trace("Combo \"", __name, "\" phase ", __phase, " passed (hold \"", _phase_verb, "\")");
                        __add_to_allow_hold_dict(_phase_verb);
                        __add_to_require_hold_array(_phase_verb);
                        __next_phase(_phase_array, true);
                    }
                    
                    break;
                
                case UnknownEnum.Value_4:
                    if (_verb_state.__held)
                    {
                        if (__charge_trigger)
                        {
                            __charge_trigger = false;
                            __charge_measure = true;
                            __input_trace("Combo \"", __name, "\" phase ", __phase, " charge started (verb \"", _phase_verb, "\")");
                            __add_to_allow_hold_dict(_phase_verb);
                            __add_to_require_hold_array(_phase_verb);
                            __charge_start_time = __input_get_time();
                            __charge_end_time = __input_get_time();
                        }
                        else if ((__input_get_time() - __charge_start_time) > _phase_data.__min_time)
                        {
                            __input_trace("Combo \"", __name, "\" phase ", __phase, " passed (charge \"", _phase_verb, "\" for over ", _phase_data.__min_time, " frames", ")");
                            __next_phase(_phase_array, false);
                        }
                    }
                    
                    break;
            }
        }
        
        if (__check_valid(arg0))
        {
            if (__phase >= _combo_length)
            {
                __input_trace("Combo \"", __name, "\" success");
                __success = true;
                return true;
            }
        }
        else
        {
            __reset();
        }
        
        return false;
    };
    
    static __next_phase = function(arg0, arg1)
    {
        if (__charge_measure)
        {
            if (arg1)
            {
                __charge_measure = false;
            }
            else
            {
                var _verb = arg0[__phase].__verb;
                _verb = variable_struct_get(__direction_mapping, _verb) ?? _verb;
                __remove_from_require_hold_array(_verb);
            }
        }
        
        if (__phase < array_length(arg0) && arg0[__phase].__type == UnknownEnum.Value_4)
            __charge_trigger = true;
        
        __phase++;
        __new_phase = true;
        __start_time = __input_get_time();
    };
    
    static __check_valid = function(arg0)
    {
        static _all_verb_array = __global.__all_verb_array;
        
        var _ignore_dict = __combo.__ignore_dict;
        var _i = 0;
        
        repeat (array_length(__require_hold_array))
        {
            var _verb = __require_hold_array[_i];
            
            if (!variable_struct_get(arg0, _verb).__held)
            {
                __input_trace("Combo \"", __name, "\" failed, verb \"", _verb, "\" not held (phase=", __phase, ")");
                return false;
            }
            
            _i++;
        }
        
        _i = 0;
        
        repeat (array_length(_all_verb_array))
        {
            var _verb = _all_verb_array[_i];
            var _state = variable_struct_get(arg0, _verb);
            
            if (!_state.__inactive)
            {
                if (variable_struct_exists(__allow_hold_dict, _verb))
                {
                    if (!_state.__held)
                        variable_struct_remove(__allow_hold_dict, _verb);
                }
                else if (!variable_struct_exists(_ignore_dict, variable_struct_get(__direction_mapping, _verb) ?? _verb))
                {
                    if (_state.__held)
                    {
                        if (true && __phase != 0)
                            __input_trace("Combo \"", __name, "\" failed, verb \"", _verb, "\" pressed erroneously (phase=", __phase, ")");
                        
                        return false;
                    }
                }
            }
            
            _i++;
        }
        
        return true;
    };
    
    static __add_to_allow_hold_dict = function(arg0)
    {
        variable_struct_set(__allow_hold_dict, arg0, true);
    };
    
    static __remove_from_allow_hold_dict = function(arg0)
    {
        variable_struct_remove(__allow_hold_dict, arg0);
    };
    
    static __add_to_require_hold_array = function(arg0)
    {
        var _i = 0;
        
        repeat (array_length(__require_hold_array))
        {
            if (__require_hold_array[_i] == arg0)
                exit;
            
            _i++;
        }
        
        array_push(__require_hold_array, arg0);
    };
    
    static __remove_from_require_hold_array = function(arg0)
    {
        var _i = 0;
        
        repeat (array_length(__require_hold_array))
        {
            if (__require_hold_array[_i] == arg0)
            {
                array_delete(__require_hold_array, _i, 1);
                exit;
            }
            
            _i++;
        }
    };
    
    static __determine_direction = function(arg0, arg1)
    {
        if (!__combo_params.__reset)
        {
            var _forward_verb = __combo_params.__forward_verb;
            var _counterclockwise_verb = __combo_params.__counterclockwise_verb;
            var _backward_verb = __combo_params.__backward_verb;
            var _clockwise_verb = __combo_params.__clockwise_verb;
            var _forward_struct = (_forward_verb == undefined) ? undefined : variable_struct_get(arg0, _forward_verb);
            var _counterclockwise_struct = (_counterclockwise_verb == undefined) ? undefined : variable_struct_get(arg0, _counterclockwise_verb);
            var _backward_struct = (_backward_verb == undefined) ? undefined : variable_struct_get(arg0, _backward_verb);
            var _clockwise_struct = (_clockwise_verb == undefined) ? undefined : variable_struct_get(arg0, _clockwise_verb);
            var _forward_state = is_struct(_forward_struct) && !_forward_struct.__inactive && _forward_struct.__held;
            var _counterclockwise_state = is_struct(_counterclockwise_struct) && !_counterclockwise_struct.__inactive && _counterclockwise_struct.__held;
            var _backward_state = is_struct(_backward_struct) && !_backward_struct.__inactive && _backward_struct.__held;
            var _clockwise_state = is_struct(_clockwise_struct) && !_clockwise_struct.__inactive && _clockwise_struct.__held;
            
            if (arg1 == _forward_verb)
            {
                if (_forward_state)
                {
                    __set_direction(0);
                    __input_trace("Combo \"", __name, "\" direction determined from verb \"", _forward_verb, "\" used as forward verb \"", arg1, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_counterclockwise_state)
                {
                    __set_direction(90);
                    __input_trace("Combo \"", __name, "\" direction determined from verb \"", _counterclockwise_verb, "\" used as forward verb \"", arg1, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_backward_state)
                {
                    __set_direction(180);
                    __input_trace("Combo \"", __name, "\" direction determined from verb \"", _backward_verb, "\" used as forward verb \"", arg1, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_clockwise_state)
                {
                    __set_direction(270);
                    __input_trace("Combo \"", __name, "\" direction determined from verb \"", _clockwise_verb, "\" used as forward verb \"", arg1, "\", direction=", __direction, " (phase=", __phase, ")");
                }
            }
            else if (arg1 == _counterclockwise_verb)
            {
                if (_counterclockwise_state)
                {
                    __set_direction(0);
                    __input_trace("Combo \"", __name, "\" direction determined from verb \"", _counterclockwise_verb, "\" used as counter-clockwise verb \"", arg1, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_backward_state)
                {
                    __set_direction(90);
                    __input_trace("Combo \"", __name, "\" direction determined from verb \"", _backward_verb, "\" used as counter-clockwise verb \"", arg1, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_clockwise_state)
                {
                    __set_direction(180);
                    __input_trace("Combo \"", __name, "\" direction determined from verb \"", _clockwise_verb, "\" used as counter-clockwise verb \"", arg1, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_forward_state)
                {
                    __set_direction(270);
                    __input_trace("Combo \"", __name, "\" direction determined from verb \"", _forward_verb, "\" used as counter-clockwise verb \"", arg1, "\", direction=", __direction, " (phase=", __phase, ")");
                }
            }
            else if (arg1 == _backward_verb)
            {
                if (_backward_state)
                {
                    __set_direction(0);
                    __input_trace("Combo \"", __name, "\" direction determined from verb \"", _backward_verb, "\" used as backward verb \"", arg1, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_clockwise_state)
                {
                    __set_direction(90);
                    __input_trace("Combo \"", __name, "\" direction determined from verb \"", _clockwise_verb, "\" used as backward verb \"", arg1, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_forward_state)
                {
                    __set_direction(180);
                    __input_trace("Combo \"", __name, "\" direction determined from verb \"", _forward_verb, "\" used as backward verb \"", arg1, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_counterclockwise_state)
                {
                    __set_direction(270);
                    __input_trace("Combo \"", __name, "\" direction determined from verb \"", _counterclockwise_verb, "\" used as backward verb \"", arg1, "\", direction=", __direction, " (phase=", __phase, ")");
                }
            }
            else if (arg1 == _clockwise_verb)
            {
                if (_clockwise_state)
                {
                    __set_direction(0);
                    __input_trace("Combo \"", __name, "\" direction determined from verb \"", _clockwise_verb, "\" used as clockwise verb \"", arg1, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_forward_state)
                {
                    __set_direction(90);
                    __input_trace("Combo \"", __name, "\" direction determined from verb \"", _forward_verb, "\" used as clockwise verb \"", arg1, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_counterclockwise_state)
                {
                    __set_direction(180);
                    __input_trace("Combo \"", __name, "\" direction determined from verb \"", _counterclockwise_verb, "\" used as clockwise verb \"", arg1, "\", direction=", __direction, " (phase=", __phase, ")");
                }
                else if (_backward_state)
                {
                    __set_direction(270);
                    __input_trace("Combo \"", __name, "\" direction determined from verb \"", _backward_verb, "\" used as clockwise verb \"", arg1, "\", direction=", __direction, " (phase=", __phase, ")");
                }
            }
        }
    };
    
    static __set_direction = function(arg0)
    {
        var _forward_verb = __combo_params.__forward_verb;
        var _counterclockwise_verb = __combo_params.__counterclockwise_verb;
        var _backward_verb = __combo_params.__backward_verb;
        var _clockwise_verb = __combo_params.__clockwise_verb;
        
        switch (arg0)
        {
            case 0:
                break;
            
            case 90:
                if (_forward_verb != undefined)
                    variable_struct_set(__direction_mapping, _forward_verb, _counterclockwise_verb);
                
                if (_counterclockwise_verb != undefined)
                    variable_struct_set(__direction_mapping, _counterclockwise_verb, _backward_verb);
                
                if (_backward_verb != undefined)
                    variable_struct_set(__direction_mapping, _backward_verb, _clockwise_verb);
                
                if (_clockwise_verb != undefined)
                    variable_struct_set(__direction_mapping, _clockwise_verb, _forward_verb);
                
                break;
            
            case 180:
                if (_forward_verb != undefined)
                    variable_struct_set(__direction_mapping, _forward_verb, _backward_verb);
                
                if (_counterclockwise_verb != undefined)
                    variable_struct_set(__direction_mapping, _counterclockwise_verb, _clockwise_verb);
                
                if (_backward_verb != undefined)
                    variable_struct_set(__direction_mapping, _backward_verb, _forward_verb);
                
                if (_clockwise_verb != undefined)
                    variable_struct_set(__direction_mapping, _clockwise_verb, _counterclockwise_verb);
                
                break;
            
            case 270:
                if (_forward_verb != undefined)
                    variable_struct_set(__direction_mapping, _forward_verb, _clockwise_verb);
                
                if (_counterclockwise_verb != undefined)
                    variable_struct_set(__direction_mapping, _counterclockwise_verb, _forward_verb);
                
                if (_backward_verb != undefined)
                    variable_struct_set(__direction_mapping, _backward_verb, _counterclockwise_verb);
                
                if (_clockwise_verb != undefined)
                    variable_struct_set(__direction_mapping, _clockwise_verb, _backward_verb);
                
                break;
            
            default:
                __input_error("Unhandled direction ", arg0);
                break;
        }
        
        __direction = (arg0 + __combo_params.__reference_direction + 3600) % 360;
    };
    
    __name = arg0;
    __combo = arg1;
    __phase = 0;
    __reset();
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4
}
