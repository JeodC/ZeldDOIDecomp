function xzip_delete()
{
    var _arch = argument[0];
    var fsuccess = true;
    ds_list_clear(xzip_get_report());
    
    if (!file_exists(_arch))
    {
        ds_list_add(xzip_get_report(), filename_name(_arch));
        return false;
    }
    
    var flist;
    
    if (string(argument[1]) == "-3")
    {
        flist = xzip_list(_arch);
    }
    else if (is_array(argument[1]))
    {
        flist = argument[1];
    }
    else
    {
        for (var findex = 0; findex < (argument_count - 1); findex++)
            flist[findex] = argument[findex + 1];
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
                var tindex = real(ini_read_string(fname, "index", "-999"));
                ini_section_delete(fname);
                
                while (ini_key_exists("?", string(tindex + 1)))
                {
                    fname = ini_read_string("?", string(tindex + 1), "7Y30NZ38EPK25FQ.ERR");
                    ini_write_string(fname, "index", string(tindex));
                    ini_write_string("?", string(tindex), fname);
                    tindex++;
                }
                
                ini_key_delete("?", tindex);
            }
        }
        
        dlist = 0;
    }
    
    ini_close();
    return fsuccess;
}
