function Tektite_UpdateDir(arg0)
{
    Dir = arg0;
    
    switch (Dir)
    {
        case 3:
            vx = -Speed;
            vy = -Speed;
            break;
        
        case 4:
            vx = Speed;
            vy = Speed;
            break;
        
        case 1:
            vx = Speed;
            vy = -Speed;
            break;
        
        case 2:
            vx = -Speed;
            vy = Speed;
            break;
    }
}
