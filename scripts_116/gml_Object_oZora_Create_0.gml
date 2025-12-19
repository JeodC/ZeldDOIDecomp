RoomIndex = Dungeon_GetRoomIndex(x, y);
LightIndex = -1;

if (global.Challenges[UnknownEnum.Value_4])
{
    LightIndex = Lighting_CreateLight(RoomIndex, x, y - 8, 1, [0.5, 0.5, 0.5]);
    Lighting_UpdateLight_Visible(RoomIndex, LightIndex, false);
}

visible = false;
sprite_index = sZora_Waking1;
alarm[0] = 60;
Started = false;
Emerged = false;
Talking = false;
Done = false;
FloorLevel = GetFloorLevelID(x, y);
FloorLevelStr = GetFloorLevelString(FloorLevel);
y_base = y;
GemPrize = 0;
PrizeClass = 0;
PrizeIndex = 0;

with (oLink)
{
    Facing = 1;
    UpdateState(UnknownEnum.Value_0);
}

global.Paused = true;

enum UnknownEnum
{
    Value_0,
    Value_4 = 4
}
