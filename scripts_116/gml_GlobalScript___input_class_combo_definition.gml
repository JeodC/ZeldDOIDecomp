function __input_class_combo_definition(arg0, arg1, arg2) constructor
{
    static __global = __input_global();
    
    static ignore = function(arg0)
    {
        if (arg0 == -3)
            arg0 = __global.__basic_verb_array;
        
        var _i = 0;
        
        repeat (array_length(arg0))
        {
            var _verb = arg0[_i];
            
            if (!variable_struct_exists(__used_dict, _verb))
                variable_struct_set(__ignore_dict, _verb, true);
            
            _i++;
        }
        
        return self;
    };
    
    static __remove_ignored = function(arg0)
    {
        variable_struct_remove(__ignore_dict, arg0);
        variable_struct_set(__used_dict, arg0, true);
    };
    
    static press = function(arg0)
    {
        __remove_ignored(arg0);
        array_push(__phase_array, 
        {
            __type: UnknownEnum.Value_0,
            __verb: arg0
        });
        return self;
    };
    
    static release = function(arg0)
    {
        __remove_ignored(arg0);
        array_push(__phase_array, 
        {
            __type: UnknownEnum.Value_1,
            __verb: arg0
        });
        return self;
    };
    
    static press_or_release = function(arg0)
    {
        __remove_ignored(arg0);
        array_push(__phase_array, 
        {
            __type: UnknownEnum.Value_2,
            __verb: arg0
        });
        return self;
    };
    
    static hold = function(arg0)
    {
        __remove_ignored(arg0);
        array_push(__phase_array, 
        {
            __type: UnknownEnum.Value_3,
            __verb: arg0
        });
        return self;
    };
    
    static charge = function(arg0, arg1 = 60)
    {
        __remove_ignored(arg0);
        array_push(__phase_array, 
        {
            __type: UnknownEnum.Value_4,
            __verb: arg0,
            __min_time: arg1
        });
        return self;
    };
    
    __name = arg0;
    __phase_timeout = arg1;
    __directional = arg2;
    __ignore_dict = {};
    __used_dict = {};
    __phase_array = [];
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4
}
