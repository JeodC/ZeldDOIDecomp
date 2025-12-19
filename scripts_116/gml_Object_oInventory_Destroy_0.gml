ds_grid_destroy(DBScript_Info);
global.InventoryInst = -4;
global.Paused = false;

if (OpenGems)
    global.Inventory_ShowGems = true;

if (CloseGems)
    global.Inventory_ShowGems = false;

with (oLink)
{
    if (State != UnknownEnum.Value_6)
        UpdateState(UnknownEnum.Value_1);
}

enum UnknownEnum
{
    Value_1 = 1,
    Value_6 = 6
}
