function Crab_UpdateDir()
{
    Dir = RandomDir();
    
    switch (Dir)
    {
        case 3:
        case 4:
            vx = choose(-1, 1) * Speed * 3;
            vy = 0;
            ObjSetImageSpeed(1);
            break;
        
        case 1:
        case 2:
            vx = 0;
            vy = choose(-1, 1) * Speed;
            ObjSetImageSpeed(0.5);
    }
    
    alarm[0] = irandom_range(30, 120);
}
