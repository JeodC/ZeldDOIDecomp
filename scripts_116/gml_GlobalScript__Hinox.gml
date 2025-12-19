function Hinox_UpdateDir(arg0, arg1)
{
    Dir = arg0;
    Speed = arg1;
    Enemy_UpdateSprite(State);
    Enemy_UpdateV(Speed);
    alarm[0] = irandom_range(40, 100);
}

function Hinox_Shoot()
{
    var Layer = "ObjsHigher_" + GetFloorLevelString(x, y);
    var BombInst;
    
    switch (Dir)
    {
        case 3:
            BombInst = instance_create_layer(x - 7, y, Layer, oBomb);
            break;
        
        case 4:
            BombInst = instance_create_layer(x + 7, y, Layer, oBomb);
            break;
        
        case 1:
            BombInst = instance_create_layer(x + 13, y, Layer, oBomb);
            break;
        
        case 2:
            BombInst = instance_create_layer(x - 13, y, Layer, oBomb);
            break;
    }
    
    var LinkPosX = oLink.x + irandom_range(-12, 12) + (oLink.vx * 40);
    var LinkPosY = oLink.y + irandom_range(-12, 12) + (oLink.vy * 40);
    var BombDir = point_direction(BombInst.x, BombInst.y, LinkPosX, LinkPosY);
    var BombSpeed = clamp(point_distance(BombInst.x, BombInst.y, LinkPosX, LinkPosY) / 40, 0.5, 5);
    
    with (BombInst)
    {
        vx = lengthdir_x(BombSpeed, BombDir);
        vy = lengthdir_y(BombSpeed, BombDir);
        FloorLevel = other.FloorLevel;
        PickupObj_InitThrow();
        ObjSetImageSpeed(0);
        alarm[0] = 30;
        Red = true;
    }
    
    Dir = DirFacePos(LinkPosX, LinkPosY);
}
