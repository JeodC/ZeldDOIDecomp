function input_combo_create(arg0, arg1 = 20, arg2 = true)
{
    static _global = __input_global();
    
    __input_ensure_unique_verb_name(arg0);
    var _combo_definition = new __input_class_combo_definition(arg0, arg1, arg2);
    variable_struct_set(_global.__all_verb_dict, arg0, true);
    array_push(_global.__all_verb_array, arg0);
    variable_struct_set(_global.__combo_verb_dict, arg0, _combo_definition);
    array_push(_global.__combo_verb_array, arg0);
    var _p = 0;
    
    repeat (1)
    {
        with (_global.__players[_p])
        {
            __add_combo_state(arg0, _combo_definition);
            __add_complex_verb(arg0, UnknownEnum.Value_1);
        }
        
        _p++;
    }
    
    return _combo_definition;
}

enum UnknownEnum
{
    Value_1 = 1
}
