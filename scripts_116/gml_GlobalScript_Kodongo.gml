function Kodongo_UpdateDir(arg0)
{
    Dir = arg0;
    Enemy_UpdateSprite(State);
    Enemy_UpdateV(WalkSpeed);
}

function Kodongo_Shoot()
{
    var VarStruct = 
    {
        FloorLevel: FloorLevel,
        ItemHolding: -4,
        SectionID: 0,
        _RoomIndex: 0
    };
    
    switch (Dir)
    {
        case 3:
            var inst = instance_create_layer(x - 8, y - 5, "ObjsHigher_" + GetFloorLevelString(FloorLevel), oEnemy_Fireball, VarStruct);
            inst.vx = -inst.Speed;
            break;
        
        case 4:
            var inst = instance_create_layer(x + 8, y - 5, "ObjsHigher_" + GetFloorLevelString(FloorLevel), oEnemy_Fireball, VarStruct);
            inst.vx = inst.Speed;
            break;
        
        case 1:
            var inst = instance_create_layer(x, y - 14, "ObjsHigher_" + GetFloorLevelString(FloorLevel), oEnemy_Fireball, VarStruct);
            inst.vy = -inst.Speed;
            break;
        
        case 2:
            var inst = instance_create_layer(x, y + 6, "ObjsHigher_" + GetFloorLevelString(FloorLevel), oEnemy_Fireball, VarStruct);
            inst.vy = inst.Speed;
            break;
    }
    
    FireballCount++;
    
    if (FireballCount >= (3 + Type))
        Enemy_UpdateState(ds_grid_get(Script, 0, ScriptPos));
    else
        alarm[1] = FireballDelay;
}
