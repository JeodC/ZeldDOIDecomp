if (oLink.State == UnknownEnum.Value_19)
{
    StarColorIndex = (StarColorIndex + 1) % array_length(StarColors);
    StarLightIndex = (StarLightIndex + 0.5) % array_length(StarLightColors);
    
    repeat (4)
        instance_create_layer(x + irandom_range(-StarSparkleDist, StarSparkleDist), y + irandom_range(-StarSparkleDist, StarSparkleDist), "Objs_" + GetFloorLevelString(FloorLevel), oSparkle);
    
    alarm[7] = StarColorDelay;
}

if (alarm[8] <= 90)
{
    var RoomSongIndex = global.Level.Rooms[global.CurrentRoomIndex].RoomSongIndex;
    Music_Fade(0, 90, RoomSongIndex);
}

enum UnknownEnum
{
    Value_19 = 19
}
