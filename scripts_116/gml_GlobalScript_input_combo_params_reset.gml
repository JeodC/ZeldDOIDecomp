function input_combo_params_reset()
{
    static _global = __input_global();
    
    with (_global.__combo_params)
    {
        __reset = true;
        __side_on = undefined;
        __forward_verb = undefined;
        __counterclockwise_verb = undefined;
        __backward_verb = undefined;
        __clockwise_verb = undefined;
        __reference_direction = undefined;
    }
    
    __input_trace("Combo params reset");
}
