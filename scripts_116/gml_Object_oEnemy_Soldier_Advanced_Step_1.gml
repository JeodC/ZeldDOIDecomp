if (Setup)
{
    switch (HeadIndex)
    {
        case UnknownEnum.Value_4:
            Weapon = UnknownEnum.Value_2;
            Enemy_SetEnergy(7);
            Attack = 2.5;
            break;
        
        case UnknownEnum.Value_5:
            Weapon = UnknownEnum.Value_1;
            Enemy_SetEnergy(8);
            Attack = 2.75;
            break;
        
        case UnknownEnum.Value_7:
            Weapon = UnknownEnum.Value_0;
            Enemy_SetEnergy(9);
            Attack = 3;
            break;
    }
    
    Soldier_UpdateWeaponSprite();
    Setup = false;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_4 = 4,
    Value_5,
    Value_7 = 7
}
