function xzip_rename(arg0, arg1, arg2)
{
    var f_is_dir = false;
    var fsuccess = true;
    
    if (!file_exists(arg0))
        return false;
    
    ini_open(arg0);
    var fname;
    
    if (is_real(arg1))
        fname = ini_read_string("?", string(arg1), "7Y30NZ38EPK25FQ.ERR");
    else
        fname = filename_name(arg1);
    
    var dlist;
    
    if (!ini_section_exists(fname))
    {
        ini_close();
        dlist = xzip_list_dir(arg0, arg1);
        f_is_dir = is_array(dlist);
        
        if (!f_is_dir)
            fname = "7Y30NZ38EPK25FQ.ERR";
        
        ini_open(arg0);
    }
    
    if (f_is_dir)
    {
        var fpath = string_copy(arg1, 1, string_length(arg1) - string_length(fname)) + arg2;
        
        for (var dindex = 0; dindex < array_length(dlist); dindex++)
        {
            fname = dlist[dindex];
            
            if (ini_read_string(fname, "readonly", "true") == "true")
            {
                fsuccess = false;
            }
            else
            {
                var fpath_orig = ini_read_string(fname, "path", "");
                ini_write_string(fname, "path", string_replace(fpath_orig, arg1, fpath));
            }
        }
    }
    else if (ini_read_string(fname, "readonly", "true") == "true")
    {
        fsuccess = false;
    }
    else
    {
        var tindex = ini_read_string(fname, "index", "-1");
        ini_write_string("?", tindex, arg2);
        ini_write_string(arg2, "data", ini_read_string(fname, "data", "0"));
        ini_write_string(arg2, "index", tindex);
        ini_write_string(arg2, "path", ini_read_string(fname, "path", ""));
        ini_write_string(arg2, "readonly", ini_read_string(fname, "readonly", "false"));
        ini_section_delete(fname);
    }
    
    ini_close();
    return fsuccess;
}
