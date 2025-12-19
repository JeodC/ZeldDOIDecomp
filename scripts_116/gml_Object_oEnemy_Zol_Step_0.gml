event_inherited();

if (KnockBackDone || StunDone)
    Enemy_UpdateState(UnknownEnum.Value_3);

if (global.Paused || State == UnknownEnum.Value_10 || State == UnknownEnum.Value_11 || State == UnknownEnum.Value_13 || State == UnknownEnum.Value_15 || State == UnknownEnum.Value_16 || State == UnknownEnum.Value_17)
{
    ObjPause();
    exit;
}
else
{
    image_speed = LastImageSpeed;
}

if (WallCollide_X)
{
    DirX *= -1;
    LookDir *= -1;
}

if (WallCollide_Y)
    DirY *= -1;

switch (State)
{
    case UnknownEnum.Value_0:
        var InEnemyArea = false;
        
        for (var i = 0; i < EnemyAreasInTemplate; i++)
        {
            if (point_in_rectangle(oLink.x, oLink.y, ds_grid_get(SpawnAreas, 0, i), ds_grid_get(SpawnAreas, 1, i), ds_grid_get(SpawnAreas, 2, i), ds_grid_get(SpawnAreas, 3, i)))
            {
                InEnemyArea = true;
                break;
            }
        }
        
        if (!oLink.InDoor && InEnemyArea && !oLink.Cape && point_distance(x, y_base, oLink.x, oLink.y) <= 24 && FloorLevel == oLink.FloorLevel)
            Enemy_UpdateState(UnknownEnum.Value_1);
        
        break;
    
    case UnknownEnum.Value_1:
        if (image_index >= (image_number - 0.1))
            Enemy_UpdateState(UnknownEnum.Value_5);
        
        break;
    
    case UnknownEnum.Value_5:
        if (JumpLanded)
            Enemy_UpdateState(UnknownEnum.Value_3);
        
        break;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_3 = 3,
    Value_5 = 5,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
