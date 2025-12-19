function input_binding_scan_abort(arg0 = 0)
{
    static _global = __input_global();
    
    if (arg0 == -3)
    {
        var _p = 0;
        
        repeat (1)
        {
            input_binding_scan_abort(_p);
            _p++;
        }
        
        exit;
    }
    
    if (arg0 < 0)
    {
        __input_error("Invalid player index provided (", arg0, ")");
        return undefined;
    }
    
    if (arg0 >= 1)
    {
        __input_error("Player index too large (", arg0, " must be less than ", 1, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    with (_global.__players[arg0])
    {
        if (__rebind_state > 0)
            __binding_scan_failure(UnknownEnum.Value_m30);
    }
}

enum UnknownEnum
{
    Value_m30 = -30
}
