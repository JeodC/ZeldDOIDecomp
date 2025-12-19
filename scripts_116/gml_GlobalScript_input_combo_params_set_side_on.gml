function input_combo_params_set_side_on(arg0, arg1, arg2)
{
    static _global = __input_global();
    
    with (_global.__combo_params)
    {
        __reset = false;
        __side_on = true;
        __forward_verb = arg0;
        __counterclockwise_verb = undefined;
        __backward_verb = arg1;
        __clockwise_verb = undefined;
        __reference_direction = arg2;
    }
    
    __input_trace("Combo params set for side-on usage (forward=\"", arg0, "\", backward=\"", arg1, "\", reference direction=", arg2, ")");
}
