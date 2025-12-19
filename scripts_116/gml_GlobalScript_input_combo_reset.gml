function input_combo_reset(arg0, arg1 = 0)
{
    static _global = __input_global();
    
    if (arg0 == -3)
    {
        var _i = 0;
        
        repeat (array_length(_global.__combo_verb_array))
        {
            input_combo_reset(_global.__combo_verb_array[_i], arg1);
            _i++;
        }
        
        exit;
    }
    
    if (arg1 < 0)
    {
        __input_error("Invalid player index provided (", arg1, ")");
        return undefined;
    }
    
    if (arg1 >= 1)
    {
        __input_error("Player index too large (", arg1, " must be less than ", 1, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    var _combo_state = variable_struct_get(_global.__players[arg1].__combo_state_dict, arg0);
    
    if (!is_struct(_combo_state))
        __input_error("Combo with name \"", arg0, "\" doesn't exist");
    
    _combo_state.__reset();
}
