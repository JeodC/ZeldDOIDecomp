function xzip_count(arg0)
{
    var findex = 0;
    
    if (!file_exists(arg0))
        return -1;
    
    ini_open(arg0);
    
    while (ini_key_exists("?", string(findex)))
        findex++;
    
    ini_close();
    return findex;
}
