visible = false;

if (!variable_instance_exists(id, "FloorLevel"))
    FloorLevel = GetFloorLevelID(x, y);

FloorLevelStr = GetFloorLevelString(FloorLevel);
RoomIndex = Dungeon_GetRoomIndex(x, y);
Name = "";
Info = "No Info Available";
Index = 0;
y_base = y;
vx = 0;
vy = 0;
vz = 0;
z = 0;
z_end = 1000;
g = 0;
Class = ItemClassFromObjIndex(object_index);
Spawning = false;
SpawnAnimationInit = false;
SpawnAnimation = false;
SpawnAnimationFinish = false;
SpawnType = UnknownEnum.Value_0;
SpawnBounces = 0;
SpawnPause = 0;
SpawnPauseCount = 0;
Alpha = 1;
Amount = 1;
ShowAmount = true;
AmountOffsetX = Item_AmountOffsetX(Class);
Price = 0;
Price_Max = 0;
Price_Modified = Price;
Price_CouponApplied = false;
Price_Color = 16777215;
ShowPrice = false;
ShopItem = false;
ShadowSpr = sShadow_Large;
ShadowOffsetX = 0;
ShadowOffsetY = 0;
ShowShadow = true;
Lighting = true;
Palette = false;
PaletteSpr = -4;
PaletteIndex = 0;
Get_WhenLinkCollides = true;
Get_Allowed = false;
Get_Sound = Sound_KeyGet;
Get_ShowDialogue = true;
InventorySpr = sprite_index;
CollidedWallList = ds_list_create();
WallCollide_X = false;
WallCollide_Y = false;
CanPickup = false;
InWater = false;
InWaterSprW = 18;
InWaterSprXOffset = 0;
InWaterSprYOffset = -4;
Setup = false;

enum UnknownEnum
{
    Value_0
}
