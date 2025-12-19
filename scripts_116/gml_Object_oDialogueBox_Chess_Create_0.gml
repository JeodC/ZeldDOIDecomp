DB_Script = ds_grid_create(5, 4);
var i = 0;
var Addr = 0;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_3);
ds_grid_set(DB_Script, ++i, Addr, Msg);
ds_grid_set(DB_Script, ++i, Addr, 1);
ds_grid_set(DB_Script, ++i, Addr, 2);
ds_grid_set(DB_Script, ++i, Addr, 3);
i = 0;
Addr = 1;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_7);
ds_grid_set(DB_Script, ++i, Addr, 0);
i = 0;
Addr = 2;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_7);
ds_grid_set(DB_Script, ++i, Addr, 1);
i = 0;
Addr = 3;
ds_grid_set(DB_Script, 0, Addr, UnknownEnum.Value_7);
ds_grid_set(DB_Script, ++i, Addr, 2);
i = 0;
global.DB_Inst = instance_create_layer(0, 0, "System", oDialogueBox);
global.DB_Inst.Script = DB_Script;

enum UnknownEnum
{
    Value_3 = 3,
    Value_7 = 7
}
