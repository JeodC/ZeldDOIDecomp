function xzip_exists(arg0, arg1)
{
    var fexists = false;
    
    if (!file_exists(arg0))
        return fexists;
    
    ini_open(arg0);
    var fname;
    
    if (is_real(arg1))
        fname = ini_read_string("?", string(arg1), "7Y30NZ38EPK25FQ.ERR");
    else
        fname = filename_name(arg1);
    
    fexists = ini_section_exists(fname);
    ini_close();
    
    if (!fexists)
        fexists = is_array(xzip_list_dir(arg0, arg1));
    
    return fexists;
}
