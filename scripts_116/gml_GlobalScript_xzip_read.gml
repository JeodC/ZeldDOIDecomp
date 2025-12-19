function xzip_read(arg0, arg1)
{
    var buf_file = -1;
    
    if (!file_exists(arg0))
        return buf_file;
    
    ini_open(arg0);
    var fname;
    
    if (is_real(arg1))
        fname = ini_read_string("?", string(arg1), "7Y30NZ38EPK25FQ.ERR");
    else
        fname = filename_name(arg1);
    
    if (ini_section_exists(fname))
    {
        var buf_file_comp = ini_read_string(fname, "data", "0");
        buf_file_comp = buffer_base64_decode(buf_file_comp);
        buf_file = buffer_decompress(buf_file_comp);
        buffer_delete(buf_file_comp);
    }
    
    ini_close();
    return buf_file;
}
