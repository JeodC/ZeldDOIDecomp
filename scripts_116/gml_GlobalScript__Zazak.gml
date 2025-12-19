function Zazak_Shoot()
{
    var FloorLevelStr = GetFloorLevelString(x, y);
    var Layer = "ObjsHigher_" + FloorLevelStr;
    
    switch (Dir)
    {
        case 3:
            var inst = instance_create_layer(x - 8, y - 10, Layer, oEnemy_Fireball2);
            inst.vx = -inst.Speed;
            inst.Rot = 180;
            break;
        
        case 4:
            var inst = instance_create_layer(x + 8, y - 10, Layer, oEnemy_Fireball2);
            inst.vx = inst.Speed;
            inst.Rot = 0;
            break;
        
        case 1:
            var inst = instance_create_layer(x, y - 18, Layer, oEnemy_Fireball2);
            inst.vy = -inst.Speed;
            inst.Rot = 90;
            inst.layer = layer_get_id("ObjsDoors_" + FloorLevelStr);
            Hit_AllowedTimer = 3;
            break;
        
        case 2:
            var inst = instance_create_layer(x, y - 6, Layer, oEnemy_Fireball2);
            inst.vy = inst.Speed;
            inst.Rot = 270;
            break;
    }
}
