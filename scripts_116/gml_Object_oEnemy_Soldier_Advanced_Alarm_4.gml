switch (Dir)
{
    case 3:
    case 4:
        Soldier_UpdateDir(choose(1, 2));
        break;
    
    case 1:
    case 2:
        Soldier_UpdateDir(choose(3, 4));
        break;
}

Soldier_UpdateWeaponSprite();
alarm[4] = irandom_range(60, 400);
