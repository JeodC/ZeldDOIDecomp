function xzip_list_dir()
{
    var _arch = argument[0];
    var _dir = argument[1];
    var findex = 0;
    var flist = 0;
    var frelative = false;
    var tindex = 0;
    
    if (!file_exists(_arch))
        return -1;
    
    if (argument_count > 2)
        frelative = argument[2];
    
    ini_open(_arch);
    
    while (ini_key_exists("?", string(tindex)))
    {
        var fname = ini_read_string("?", string(tindex), "7Y30NZ38EPK25FQ.ERR");
        
        if (fname != "7Y30NZ38EPK25FQ.ERR")
        {
            var fpath = ini_read_string(fname, "path", "");
            var f_in_dir = false;
            
            if (global.sys_xzip_recurse)
            {
                if (string_pos(_dir, fpath) == 1 || _dir == "")
                    f_in_dir = true;
            }
            else if (fpath == _dir)
            {
                f_in_dir = true;
            }
            
            if (f_in_dir)
            {
                flist[findex] = fname;
                
                if (frelative)
                {
                    if (fpath != "")
                        flist[findex] = fpath + "\\" + flist[findex];
                }
                
                findex++;
            }
        }
        
        tindex++;
    }
    
    ini_close();
    return flist;
}
