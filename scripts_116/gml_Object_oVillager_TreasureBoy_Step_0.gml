event_inherited();

if (DoorInst == -4)
{
    DoorInst = collision_rectangle(x - 64, y - 48, x, y, oDoor, false, true);
    exit;
}

if (DoorInst.Status == UnknownEnum.Value_2 && Inventory_ItemClassExists(UnknownEnum.Value_22))
    ResponseIndex = 0;

if (DoorInst.Status == UnknownEnum.Value_0)
    ResponseIndex = 1;

enum UnknownEnum
{
    Value_0,
    Value_2 = 2,
    Value_22 = 22
}
