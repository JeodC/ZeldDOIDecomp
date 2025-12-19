Enemy = false;
RoomIndex = Dungeon_GetRoomIndex(x, y);
WallCollideDelay = false;
WallCollided = false;
Level = 0;
Index = 0;
Damage = 1;
HitV = 1.25;
HitTime = 12;

if (!variable_instance_exists(id, "FloorLevel"))
    FloorLevel = GetFloorLevelID(x, y);

FloorLevelStr = GetFloorLevelString(FloorLevel);
OutsideRoomDestroy = true;
OutsideCameraDestroy = false;
OutsideDestroyed = false;
HitCrystalSwitch = false;
LinkTouchDestroy = true;
LightIndex = -1;
LastImageSpeed = 1;
vx = 0;
vy = 0;
z = 0;
ObjSetY(y);
