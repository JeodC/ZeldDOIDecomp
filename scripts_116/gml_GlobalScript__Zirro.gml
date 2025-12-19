function Zirro_Shoot()
{
    if (oLink.Cape)
        exit;
    
    switch (DirFaceLink())
    {
        case 1:
            var BombInst = instance_create_layer(x, y_base - 12, "ObjsHighest", oEnemy_Zirro_Bomb);
            BombInst.vy = -BombInst.Speed;
            break;
        
        case 2:
            var BombInst = instance_create_layer(x, y_base, "ObjsHighest", oEnemy_Zirro_Bomb);
            BombInst.vy = BombInst.Speed;
            break;
        
        case 3:
            var BombInst = instance_create_layer(x - 6, y_base, "ObjsHighest", oEnemy_Zirro_Bomb);
            BombInst.vx = -BombInst.Speed;
            BombInst.z = 18;
            break;
        
        case 4:
            var BombInst = instance_create_layer(x + 6, y_base, "ObjsHighest", oEnemy_Zirro_Bomb);
            BombInst.vx = BombInst.Speed;
            BombInst.z = 18;
            break;
    }
}
