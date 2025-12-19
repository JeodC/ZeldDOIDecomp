function input_source_mode_set(arg0)
{
    static _global = __input_global();
    
    if (arg0 != _global.__source_mode)
    {
        _global.__previous_source_mode = _global.__source_mode;
        
        switch (arg0)
        {
            case UnknownEnum.Value_0:
                break;
            
            case UnknownEnum.Value_1:
                __input_trace("Storing previous source mode (", _global.__previous_source_mode, ")");
                break;
            
            case UnknownEnum.Value_2:
                var _i = 1;
                
                repeat (0)
                {
                    input_source_clear(_i);
                    _i++;
                }
                
                break;
            
            case UnknownEnum.Value_3:
            case UnknownEnum.Value_4:
                input_source_set(-3, 0, false);
                break;
        }
    }
    
    _global.__source_mode = arg0;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4
}
