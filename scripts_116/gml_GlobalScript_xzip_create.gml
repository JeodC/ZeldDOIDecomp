global.sys_xzip_recurse = false;
global.sys_xzip_report = -1;

function xzip_get_report()
{
    if (!ds_exists(global.sys_xzip_report, ds_type_list))
        global.sys_xzip_report = ds_list_create();
    
    return global.sys_xzip_report;
}

function xzip_create()
{
    var _arch = argument[0];
    
    if (file_exists(_arch))
        file_delete(_arch);
    
    ini_open(_arch);
    ini_write_string("?", "?", "Xzip by XGASOFT");
    ini_close();
    var flist;
    
    if (is_array(argument[1]))
    {
        flist = argument[1];
    }
    else
    {
        for (var findex = 0; findex < (argument_count - 1); findex++)
            flist[findex] = argument[findex + 1];
    }
    
    xzip_add(_arch, flist);
    return _arch;
}
