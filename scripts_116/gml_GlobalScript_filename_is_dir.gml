function filename_is_dir(arg0)
{
    if (filename_ext(arg0) == "")
        return true;
    
    if (string_count("\\", filename_ext(arg0)) > 0)
        return true;
    
    if (string_count("/", filename_ext(arg0)) > 0)
        return true;
    
    return false;
}
