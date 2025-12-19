if (instance_exists(WeaponInst))
{
    switch (Dir)
    {
        case 1:
            WeaponInst.x = x - 9;
            WeaponInst.y = y - 14;
            break;
        
        case 2:
            WeaponInst.x = x + 7;
            WeaponInst.y = y - 14;
            break;
        
        case 3:
            WeaponInst.x = x;
            WeaponInst.y = y - 11;
            break;
        
        case 4:
            WeaponInst.x = x;
            WeaponInst.y = y - 11;
            break;
    }
}
