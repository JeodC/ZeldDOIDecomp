function input_combo_params_get()
{
    static _global = __input_global();
    static _result = {};
    
    with (_global.__combo_params)
    {
        _result.__reset = __reset;
        _result.__side_on = __side_on;
        _result.__forward_verb = __forward_verb;
        _result.__counterclockwise_verb = __counterclockwise_verb;
        _result.__backward_verb = __backward_verb;
        _result.__clockwise_verb = __clockwise_verb;
        _result.__reference_direction = __reference_direction;
    }
    
    return _result;
}
