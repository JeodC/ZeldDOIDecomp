visible = false;
sprite_index = asset_get_index("sSword" + string(global.Inventory_ItemData[UnknownEnum.Value_44].Index));
image_speed = 0;
FloorLevel = oLink.FloorLevel;
CollidedObjList = ds_list_create();
HitPosX = 0;
HitPosY = 0;
StarCollisionRadius = 12 + global.Inventory_ItemData[UnknownEnum.Value_44].Index;
StarCollisionX = 0;
StarCollisionY = 0;

enum UnknownEnum
{
    Value_44 = 44
}
