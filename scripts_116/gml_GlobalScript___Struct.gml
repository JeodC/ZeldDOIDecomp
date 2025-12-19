function StructCopy(arg0)
{
    return new __snap_deep_copy(arg0).copy;
}

function __snap_deep_copy(arg0) constructor
{
    static copy_struct = function(arg0)
    {
        var _copy = {};
        var _names = variable_struct_get_names(arg0);
        var _i = 0;
        
        repeat (array_length(_names))
        {
            var _name = _names[_i];
            var _value = variable_struct_get(arg0, _name);
            
            if (is_struct(_value))
                _value = copy_struct(_value);
            else if (is_array(_value))
                _value = copy_array(_value);
            
            variable_struct_set(_copy, _name, _value);
            _i++;
        }
        
        return _copy;
    };
    
    static copy_array = function(arg0)
    {
        var _length = array_length(arg0);
        var _copy = array_create(_length);
        var _i = 0;
        
        repeat (_length)
        {
            var _value = arg0[_i];
            
            if (is_struct(_value))
                _value = copy_struct(_value);
            else if (is_array(_value))
                _value = copy_array(_value);
            
            _copy[_i] = _value;
            _i++;
        }
        
        return _copy;
    };
    
    source = arg0;
    copy = undefined;
    
    if (is_struct(source))
        copy = copy_struct(source);
    else if (is_array(source))
        copy = copy_array(source);
    else
        copy = source;
}
