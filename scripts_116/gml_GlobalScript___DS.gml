function ds_grid_delete_row(arg0, arg1)
{
    var w = ds_grid_width(arg0);
    var h = ds_grid_height(arg0);
    
    if (h <= 1)
    {
        ds_grid_resize(arg0, w, 0);
    }
    else
    {
        ds_grid_set_grid_region(arg0, arg0, 0, arg1 + 1, w - 1, h - 1, 0, arg1);
        ds_grid_resize(arg0, w, h - 1);
    }
}

function ds_list_finddelete(arg0, arg1)
{
    ds_list_delete(arg0, ds_list_find_index(arg0, arg1));
}

function ds_list_finddelete_all(arg0, arg1)
{
    while (1)
    {
        var Pos = ds_list_find_index(arg0, arg1);
        
        if (Pos == -1)
            break;
        else
            ds_list_delete(arg0, Pos);
    }
}

function ds_list_create_sequence_shuffled(arg0, arg1)
{
    var _List = ds_list_create_sequence(arg0, arg1);
    ds_list_shuffle(_List);
    return _List;
}

function ds_list_create_sequence(arg0, arg1)
{
    var _List = ds_list_create();
    
    for (var i = arg0; i <= arg1; i++)
        ds_list_add(_List, i);
    
    return _List;
}

function array_create_sequence(arg0, arg1)
{
    A = array_create((arg1 - arg0) + 1);
    
    for (var i = arg0; i <= arg1; i++)
        A[i] = i;
    
    return A;
}

function array_create_sequence_shuffled(arg0, arg1)
{
    A = array_create_sequence(arg0, arg1);
    array_shuffle_ext(A);
    return A;
}
