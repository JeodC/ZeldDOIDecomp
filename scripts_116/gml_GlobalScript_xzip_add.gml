function xzip_add()
{
    var _arch = argument[0];
    var fsuccess = true;
    var tindex = max(0, xzip_count(_arch));
    ds_list_clear(xzip_get_report());
    
    if (!file_exists(_arch))
    {
        ds_list_add(xzip_get_report(), filename_name(_arch));
        return false;
    }
    
    var flist;
    
    if (is_array(argument[1]))
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
        var dlist;
        
        if (filename_is_dir(flist[findex]))
        {
            dlist = file_list(flist[findex], 0, true);
        }
        else
        {
            dlist = ds_list_create();
            ds_list_set(dlist, 0, filename_name(flist[findex]));
            flist[findex] = filename_dir(flist[findex]);
        }
        
        var dindex = ds_list_size(dlist) - 1;
        
        for (; dindex >= 0; dindex--)
        {
            var fname = filename_name(ds_list_find_value(dlist, dindex));
            
            if (ini_section_exists(fname))
            {
                if (ini_read_string(fname, "readonly", "true") == "true")
                {
                    ds_list_add(xzip_get_report(), fname);
                    fsuccess = false;
                    continue;
                }
            }
            
            var buf_file = buffer_load(flist[findex] + "\\" + ds_list_find_value(dlist, dindex));
            
            if (!buffer_exists(buf_file))
            {
                show_error("ERROR: Path or file not readable!\nClick 'Ignore' to continue adding other files...", false);
                ds_list_add(xzip_get_report(), fname);
                fsuccess = false;
            }
            else
            {
                var buf_file_comp = buffer_compress(buf_file, 0, buffer_get_size(buf_file));
                var buf_str = buffer_base64_encode(buf_file_comp, 0, buffer_get_size(buf_file_comp));
                ini_write_string("?", string(tindex + findex), fname);
                ini_write_string(fname, "data", buf_str);
                ini_write_string(fname, "index", string(tindex + findex));
                ini_write_string(fname, "path", filename_dir(ds_list_find_value(dlist, dindex)));
                ini_write_string(fname, "readonly", "false");
                buffer_delete(buf_file);
                buffer_delete(buf_file_comp);
                
                if (dindex > 0)
                    tindex++;
            }
        }
        
        ds_list_destroy(dlist);
    }
    
    ini_close();
    return fsuccess;
}
