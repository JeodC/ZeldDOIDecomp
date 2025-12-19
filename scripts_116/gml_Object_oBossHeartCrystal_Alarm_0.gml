var _RoomIndex = Dungeon_GetRoomIndex(x, y);
var _HeartX = clamp(x, global.Level.Rooms[_RoomIndex].x + 48, global.Level.Rooms[_RoomIndex].x + 208);
var _HeartY = clamp(y, global.Level.Rooms[_RoomIndex].y + 50, global.Level.Rooms[_RoomIndex].y + 208);
ItemSpawn(UnknownEnum.Value_18, _HeartX, _HeartY, UnknownEnum.Value_14, UnknownEnum.Value_3, 1);
SpawnedHeart = true;

enum UnknownEnum
{
    Value_3 = 3,
    Value_14 = 14,
    Value_18 = 18
}
