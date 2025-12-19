event_inherited();
Size = UnknownEnum.Value_1;
Type = (global.Level.Index <= UnknownEnum.Value_8) ? 0 : 1;

switch (Type)
{
    case 0:
        WalkSpeed = 1;
        Enemy_SetEnergy(4);
        Attack = 1.75;
        break;
    
    case 1:
        WalkSpeed = 1.25;
        Enemy_SetEnergy(6);
        Attack = 2.5;
        break;
}

CheckForWater = true;
InWaterSprW = sprite_width + 2;
FireballCount = 0;
FireballDelay = 16;
ScriptLen = 4;
Script = ds_grid_create(2, ScriptLen);
ds_grid_set(Script, 0, 0, UnknownEnum.Value_3);
ds_grid_set(Script, 1, 0, -1);
ds_grid_set(Script, 0, 1, UnknownEnum.Value_2);
ds_grid_set(Script, 1, 1, 30);
ds_grid_set(Script, 0, 2, UnknownEnum.Value_7);
ds_grid_set(Script, 1, 2, -1);
ds_grid_set(Script, 0, 3, UnknownEnum.Value_2);
ds_grid_set(Script, 1, 3, 30);
ScriptPos = 0;
Enemy_UpdateState(ds_grid_get(Script, 0, ScriptPos));

enum UnknownEnum
{
    Value_1 = 1,
    Value_2,
    Value_3,
    Value_7 = 7,
    Value_8
}
