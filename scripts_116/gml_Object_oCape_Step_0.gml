x = oLink.x;
y = oLink.y;

if (global.Paused || oCamera.RoomTransition != 0 || oLink.State == UnknownEnum.Value_5 || oLink.State == UnknownEnum.Value_0 || oLink.State == UnknownEnum.Value_20 || oLink.State == UnknownEnum.Value_23)
    ObjIncAlarms();

if (oLink.House_Entering || oLink.House_Leaving)
    instance_destroy(id);

if (global.Inventory_SlotIndex_Equiped == -1)
    instance_destroy(id);
else if (global.Inventory[global.Inventory_SlotIndex_Equiped].ItemClass != UnknownEnum.Value_9)
    instance_destroy(id);

enum UnknownEnum
{
    Value_0,
    Value_5 = 5,
    Value_9 = 9,
    Value_20 = 20,
    Value_23 = 23
}
