function xzip_move()
{
    var _arch = argument[0];
    var _dir = argument[1];
    var fsuccess = true;
    ds_list_clear(xzip_get_report());
    
    if (!file_exists(_arch))
    {
        ds_list_add(xzip_get_report(), filename_name(_arch));
        return false;
    }
    
    var flist;
    
    if (string(argument[2]) == "-3")
    {
        flist = xzip_list(_arch);
    }
    else if (is_array(argument[2]))
    {
        flist = argument[2];
    }
    else
    {
        for (var findex = 0; findex < (argument_count - 2); findex++)
            flist[findex] = argument[findex + 2];
    }
    
    ini_open(_arch);
    
    for (var findex = 0; findex < array_length(flist); findex++)
    {
        var fname;
        
        if (is_real(flist[findex]))
            fname = ini_read_string("?", string(flist[findex]), "7Y30NZ38EPK25FQ.ERR");
        else
            fname = filename_name(flist[findex]);
        
        var dlist;
        
        if (!ini_section_exists(fname))
        {
            ini_close();
            dlist = xzip_list_dir(_arch, flist[findex]);
            
            if (!is_array(dlist))
            {
                ds_list_add(xzip_get_report(), fname);
                fsuccess = false;
                continue;
            }
            
            ini_open(_arch);
        }
        else
        {
            dlist[0] = fname;
        }
        
        for (var dindex = 0; dindex < array_length(dlist); dindex++)
        {
            fname = dlist[dindex];
            
            if (ini_read_string(fname, "readonly", "true") == "true")
            {
                ds_list_add(xzip_get_report(), fname);
                fsuccess = false;
            }
            else
            {
                ini_write_string(fname, "path", _dir);
            }
        }
        
        dlist = 0;
    }
    
    ini_close();
    return fsuccess;
}
