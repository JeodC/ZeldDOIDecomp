function xzip_write(arg0, arg1, arg2)
{
    if (!file_exists(arg0))
        return false;
    
    var tindex = xzip_count(arg0);
    var fname = filename_name(arg2);
    ini_open(arg0);
    var buf_file_comp = buffer_compress(arg1, 0, buffer_get_size(arg1));
    var buf_str = buffer_base64_encode(buf_file_comp, 0, buffer_get_size(buf_file_comp));
    
    if (!ini_section_exists(fname))
    {
        ini_write_string("?", string(tindex), fname);
        ini_write_string(fname, "index", string(tindex));
    }
    else if (ini_read_string(fname, "readonly", "true") == "true")
    {
        return false;
    }
    
    ini_write_string(fname, "data", buf_str);
    ini_write_string(fname, "path", "");
    ini_write_string(fname, "readonly", "false");
    buffer_delete(buf_file_comp);
    ini_close();
    return true;
}
