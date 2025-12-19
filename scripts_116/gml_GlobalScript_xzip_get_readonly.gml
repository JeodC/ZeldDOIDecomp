function xzip_get_readonly(arg0, arg1)
{
    var fread = false;
    
    if (!file_exists(arg0))
        return fread;
    
    ini_open(arg0);
    var fname;
    
    if (is_real(arg1))
        fname = ini_read_string("?", string(arg1), "7Y30NZ38EPK25FQ.ERR");
    else
        fname = filename_name(arg1);
    
    if (ini_section_exists(fname))
        fread = ini_read_string(fname, "readonly", "true") == "true";
    
    ini_close();
    return fread;
}
