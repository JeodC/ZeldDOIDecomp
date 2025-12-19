event_inherited();
var i = ds_list_find_index(global.LargeMapItems, id);

if (i != -1)
    ds_list_delete(global.LargeMapItems, i);

if (instance_number(oItem_Fairy) <= 1 && global.Level.Rooms[global.CurrentRoomIndex].RoomSongIndex == UnknownEnum.Value_13)
    global.Level.Rooms[global.CurrentRoomIndex].RoomSongIndex = global.Music_LevelSongIndex[global.Level.Index];

enum UnknownEnum
{
    Value_13 = 13
}
