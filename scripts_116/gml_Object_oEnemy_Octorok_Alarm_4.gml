if (ShotCount <= 0)
{
    ShotCount = 0;
    exit;
}

switch (Dir)
{
    case 3:
        Dir = 1;
        break;
    
    case 4:
        Dir = 2;
        break;
    
    case 1:
        Dir = 4;
        break;
    
    case 2:
        Dir = 3;
        break;
}

Enemy_UpdateSprite(State);
alarm[4] = ShotDelay;
