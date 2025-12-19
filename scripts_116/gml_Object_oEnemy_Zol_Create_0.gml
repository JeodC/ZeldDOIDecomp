event_inherited();
Size = UnknownEnum.Value_1;
Gravity = -0.125;
DirX = 0;
DirY = 0;
MoveCount = 0;
LookDir = 1;
WallCollide_Bounce = true;
CheckForWater = true;
InWaterSprW = sprite_width + 4;
InWaterSprYOffset = -2;
var _Room = global.Level.Rooms[RoomIndex];
var EnemyAreaArray = struct_get_from_hash(array_get(struct_get_from_hash(array_get(array_get(array_get(global.Templates_Room, _Room.TemplateClass), _Room.TemplateSubClass), _Room.TemplateIndex), variable_get_hash("Sections")), SectionID), variable_get_hash("Enemies"));
EnemyAreasInTemplate = array_length(EnemyAreaArray);
SpawnAreas = ds_grid_create(4, EnemyAreasInTemplate);

for (var i = 0; i < EnemyAreasInTemplate; i++)
{
    var _x1 = _Room.x + EnemyAreaArray[i].x;
    var _y1 = _Room.y + EnemyAreaArray[i].y;
    var _x2 = (_x1 + EnemyAreaArray[i].width) - 1;
    var _y2 = (_y1 + EnemyAreaArray[i].height) - 1;
    ds_grid_add(SpawnAreas, 0, i, _x1);
    ds_grid_add(SpawnAreas, 1, i, _y1);
    ds_grid_add(SpawnAreas, 2, i, _x2);
    ds_grid_add(SpawnAreas, 3, i, _y2);
}

Enemy_UpdateState(UnknownEnum.Value_0);

enum UnknownEnum
{
    Value_0,
    Value_1
}
