function file_list()
{
    var _dname = argument[0];
    var _attr = argument[1];
    var dlist = ds_list_create();
    var drec = 0;
    var dxindex = 0;
    var dyindex = 1;
    var plength = string_length(_dname) + 1;
    
    if (argument_count > 2)
    {
        if (argument[2] == true)
            drec = 16;
    }
    
    ds_list_set(dlist, 0, _dname);
    
    while (ds_list_find_value(dlist, dxindex) != "")
    {
        if (filename_is_dir(ds_list_find_value(dlist, dxindex)))
        {
            ds_list_set(dlist, dxindex, ds_list_find_value(dlist, dxindex) + "\\");
        }
        else
        {
            if (filename_dir(ds_list_find_value(dlist, dxindex)) == _dname)
                ds_list_set(dlist, dxindex, filename_path(ds_list_find_value(dlist, dxindex)) + "?" + filename_name(ds_list_find_value(dlist, dxindex)));
            
            dxindex++;
            continue;
        }
        
        ds_list_set(dlist, dyindex, file_find_first(ds_list_find_value(dlist, dxindex) + "*", drec));
        
        while (ds_list_find_value(dlist, dyindex) != "")
        {
            ds_list_set(dlist, dyindex, ds_list_find_value(dlist, dxindex) + ds_list_find_value(dlist, dyindex));
            dyindex++;
            ds_list_set(dlist, dyindex, file_find_next());
        }
        
        file_find_close();
        dxindex++;
    }
    
    ds_list_sort(dlist, true);
    dyindex = ds_list_size(dlist) - 1;
    
    while (dyindex >= 0)
    {
        if ((_attr == 16) ^^ filename_is_dir(ds_list_find_value(dlist, dyindex)))
        {
            ds_list_delete(dlist, dyindex);
        }
        else
        {
            var del_count = plength;
            
            if (string_char_at(ds_list_find_value(dlist, dyindex), plength + 1) == "?")
                del_count++;
            
            ds_list_set(dlist, dyindex, string_delete(ds_list_find_value(dlist, dyindex), 1, del_count));
            
            if (ds_list_find_value(dlist, dyindex) == "")
                ds_list_delete(dlist, dyindex);
        }
        
        dyindex--;
    }
    
    return dlist;
}
