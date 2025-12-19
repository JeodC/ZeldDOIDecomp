if (oCamera.RoomTransition != 0)
    exit;

ds_list_clear(EnemyList);
var EnemiesInRoom = collision_rectangle_list(x, y, X2, Y2, oEnemy, false, true, EnemyList, false);
var EnemyDestroysInRoom = collision_rectangle(x, y, X2, Y2, oEnemy_Destroy, false, true);
var IceShardsInRoom = collision_rectangle(x, y, X2, Y2, oIceShard, false, true);
var PoofsInRoom = collision_rectangle(x, y, X2, Y2, oPoof, false, true);
var NoMoreEnemies = true;

for (var i = 0; i < EnemiesInRoom; i++)
{
    var _Inst = ds_list_find_value(EnemyList, i);
    
    if (_Inst != -4)
    {
        var _ObjIndex = _Inst.object_index;
        
        if (Enemy_GoodForSpecialAttack(_ObjIndex))
        {
            NoMoreEnemies = false;
            break;
        }
    }
}

if (NoMoreEnemies && EnemyDestroysInRoom == -4 && IceShardsInRoom == -4 && PoofsInRoom == -4)
{
    with (oDoor)
    {
        if (RoomIndex == global.CurrentRoomIndex && Status == UnknownEnum.Value_1)
            Open = true;
    }
    
    instance_destroy(id);
}

enum UnknownEnum
{
    Value_1 = 1
}
