function xzip_count_dir(arg0, arg1)
{
    var findex = 0;
    var tindex = 0;
    
    if (!file_exists(arg0))
        return -1;
    
    ini_open(arg0);
    
    while (ini_key_exists("?", string(tindex)))
    {
        var fname = ini_read_string("?", string(tindex), "7Y30NZ38EPK25FQ.ERR");
        
        if (fname != "7Y30NZ38EPK25FQ.ERR")
        {
            var fpath = ini_read_string(fname, "path", "");
            var f_in_dir = false;
            
            if (global.sys_xzip_recurse)
            {
                if (string_pos(arg1, fpath) == 1 || arg1 == "")
                    f_in_dir = true;
            }
            else if (fpath == arg1)
            {
                f_in_dir = true;
            }
            
            if (f_in_dir)
                findex++;
        }
        
        tindex++;
    }
    
    ini_close();
    return findex;
}
