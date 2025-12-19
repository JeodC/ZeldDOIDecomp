function xzip_verify(arg0, arg1, arg2)
{
    var fverify = false;
    
    if (!file_exists(arg0))
        return fverify;
    
    ini_open(arg0);
    var fname;
    
    if (is_real(arg2))
        fname = ini_read_string("?", string(arg2), "7Y30NZ38EPK25FQ.ERR");
    else
        fname = filename_name(arg2);
    
    var fpath = ini_read_string(fname, "path", "");
    
    if (fpath != "")
        fname = fpath + "\\" + fname;
    
    if (file_exists(arg1 + "\\" + fname))
    {
        var buf_file = buffer_load(arg1 + "\\" + fname);
        var buf_file_comp = buffer_compress(buf_file, 0, buffer_get_size(buf_file));
        var buf_str = buffer_base64_encode(buf_file_comp, 0, buffer_get_size(buf_file_comp));
        fverify = ini_read_string(fname, "data", "0") == buf_str;
        buffer_delete(buf_file);
        buffer_delete(buf_file_comp);
    }
    
    ini_close();
    return fverify;
}
