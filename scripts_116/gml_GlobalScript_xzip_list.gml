function xzip_list()
{
    var _arch = argument[0];
    var findex = 0;
    var flist = 0;
    var frelative = false;
    
    if (!file_exists(_arch))
        return -1;
    
    if (argument_count > 1)
        frelative = argument[1];
    
    ini_open(_arch);
    
    while (ini_key_exists("?", string(findex)))
    {
        flist[findex] = ini_read_string("?", string(findex), "7Y30NZ38EPK25FQ.ERR");
        
        if (frelative)
        {
            var fpath = ini_read_string(flist[findex], "path", "");
            
            if (fpath != "")
                flist[findex] = fpath + "\\" + flist[findex];
        }
        
        findex++;
    }
    
    ini_close();
    return flist;
}
