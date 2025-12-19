function input_combo_get_new_phase(arg0, arg1 = 0)
{
    static _global = __input_global();
    
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
    
    return _combo_state.__new_phase;
}
