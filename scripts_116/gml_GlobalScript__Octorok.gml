function Octorok_UpdateDir(arg0)
{
    Dir = arg0;
    Enemy_UpdateSprite(State);
    Enemy_UpdateV(Speed);
}

function Octorok_Shoot()
{
    switch (Dir)
    {
        case 3:
            var inst = instance_create_layer(x - 11, y + 2, "ObjsHigher_" + GetFloorLevelString(FloorLevel), oRock);
            inst.vx = -inst.Speed;
            break;
        
        case 4:
            var inst = instance_create_layer(x + 11, y + 2, "ObjsHigher_" + GetFloorLevelString(FloorLevel), oRock);
            inst.vx = inst.Speed;
            break;
        
        case 1:
            var inst = instance_create_layer(x, y - 8, "ObjsHigher_" + GetFloorLevelString(FloorLevel), oRock);
            inst.vy = -inst.Speed;
            break;
        
        case 2:
            var inst = instance_create_layer(x, y + 6, "ObjsHigher_" + GetFloorLevelString(FloorLevel), oRock);
            inst.vy = inst.Speed;
            break;
    }
    
    ShotCount--;
    alarm[3] = ShotDelay;
}

function Octorok_Shots()
{
    switch (Type)
    {
        case 0:
            return choose(1, 4);
        
        case 1:
            return choose(4, 8);
    }
}
