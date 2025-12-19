function file_move(arg0, arg1)
{
    file_copy(arg0, arg1 + "\\" + arg0);
    
    if (file_exists(arg1 + "\\" + arg0))
        return file_delete(arg0);
    else
        return false;
}
