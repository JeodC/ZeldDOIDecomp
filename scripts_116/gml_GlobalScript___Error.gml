function Error(arg0, arg1)
{
    show_message(arg0);
    show_debug_message(arg0);
    
    if (arg1)
        game_end();
    
    var file = file_text_open_append("Errors.txt");
    file_text_write_string(file, arg0);
    file_text_writeln(file);
    file_text_close(file);
}

function Error_Spawn(arg0, arg1, arg2 = false)
{
    Error("Can't spawn " + arg1 + " dungeon level " + string(global.Level.Index) + " for dungeon index " + string(global.Level.DungeonTemplate_Index) + ", Room index " + string(arg0) + ", template id " + string(struct_get_from_hash(global.Level.Rooms[arg0].Template, variable_get_hash("id"))), arg2);
}
