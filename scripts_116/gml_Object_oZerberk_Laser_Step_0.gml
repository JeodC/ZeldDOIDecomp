x += vx;
y += vy;

if (Destroyed)
    exit;

if (!Zerberk_InLevel(x, y))
{
    Destroyed = true;
    alarm[0] = 1;
    exit;
}

if (Zerberk_WallCollisionX(id) || Zerberk_WallCollisionY(id))
{
    instance_destroy(id);
    exit;
}

switch (From)
{
    case 0:
        var inst = instance_place(x, y, oZerberk_Robot);
        
        if (inst != -4)
        {
            global.Arcade_ActiveInst.Score += inst.Points;
            inst.Destroyed = true;
            Destroyed = true;
            alarm[0] = 1;
        }
        
        break;
    
    case 1:
        if (oZerberk_Hero.Dead)
            break;
        
        var inst = instance_place(x, y, oZerberk_Hero);
        
        if (inst != -4)
        {
            Zerberk_Hero_Death();
            Destroyed = true;
            alarm[0] = 1;
        }
        
        break;
}
