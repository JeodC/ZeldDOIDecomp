function input_combo_params_set_top_down(arg0, arg1, arg2, arg3, arg4)
{
    static _global = __input_global();
    
    with (_global.__combo_params)
    {
        __reset = false;
        __side_on = false;
        __forward_verb = arg0;
        __counterclockwise_verb = arg1;
        __backward_verb = arg2;
        __clockwise_verb = arg3;
        __reference_direction = arg4;
    }
    
    __input_trace("Combo params set for top-down usage (forward=\"", arg0, "\", counter-clockwise=\"", arg1, "\", backward=\"", arg2, "\", clockwise=\"", arg3, "\", reference direction=", arg4, ")");
}
