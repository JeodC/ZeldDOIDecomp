function Enemies_InitData()
{
    global.EnemyHitsToKill[0] = array_create(15);
    global.EnemyHitsToKill[1] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 14, 18, 24, 999];
    global.EnemyHitsToKill[2] = [1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 9, 13, 16, 22, 999];
    global.EnemyHitsToKill[3] = [1, 1, 1, 2, 3, 4, 5, 6, 7, 8, 8, 12, 15, 20, 999];
    global.EnemyHitsToKill[4] = [1, 1, 1, 2, 3, 3, 4, 5, 6, 7, 7, 10, 14, 18, 999];
    global.EnemyHitsToKill[5] = [1, 1, 1, 1, 2, 3, 3, 4, 5, 6, 6, 9, 13, 16, 999];
    global.EnemyHitsToKill[6] = [1, 1, 1, 1, 2, 2, 3, 3, 4, 5, 5, 8, 12, 15, 999];
    global.EnemyHitsToKill[7] = [1, 1, 1, 1, 1, 2, 2, 3, 3, 4, 4, 7, 11, 14, 999];
    global.EnemyHitsToKill[8] = [1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 6, 10, 13, 999];
    
    for (var _AttackIndex = 1; _AttackIndex <= 8; _AttackIndex++)
    {
        global.LinkSwordDamage[_AttackIndex] = array_create(15);
        
        for (var _EnergyIndex = 0; _EnergyIndex < 15; _EnergyIndex++)
            global.LinkSwordDamage[_AttackIndex][_EnergyIndex] = global.EnemyHitsToKill[1][_EnergyIndex] / global.EnemyHitsToKill[_AttackIndex][_EnergyIndex];
    }
    
    for (var _EnergyIndex = 0; _EnergyIndex < 15; _EnergyIndex++)
    {
        global.EnemyHitsToKill[0][_EnergyIndex] = global.EnemyHitsToKill[1][_EnergyIndex];
        global.LinkSwordDamage[0][_EnergyIndex] = global.LinkSwordDamage[1][_EnergyIndex];
    }
    
    EnemyDataInit(oBoss_Armos, 10, 1, 0, 0, 0, [[-10, -1], -1, [1.5, -1], -1, -1, [2, 0], [1, -1], [1, -1], -1, [1, -1], [1, -1]], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    EnemyDataInit(oBoss_Lanmola, 11, 2.25, 0, 0, 0, [-10, -1, 1.5, -1, -1, 0, 1, 1, -1, 1, 1], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    EnemyDataInit(oBoss_Moldorm, 12, 0, 0, 0, 0, [0.5, -1, -1, -1, -1, 0, -1, -1, -1, -1, -1], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    EnemyDataInit(oBoss_Moldorm_BodyL, 0, 0, 0, 0, 0, [0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    EnemyDataInit(oBoss_Moldorm_BodyS, 0, 0, 0, 0, 0, [0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    EnemyDataInit(oBoss_Moldorm_Tail, 0, 0, 0, 0, 0, [0.5, -1, 0.5, -1, -1, 0, 0.5, 0.5, -1, 0.5, 0.5], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    EnemyDataInit(oBoss_Aghanim, 12, 1.75, 0, 0, 0, [[-5, 0], -1, -1, -1, -1, [4, 0], -1, -1, -1, -1, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    EnemyDataInit(oEnemy_Bubble, 0, 1, 0, 0, 5, [[-10, 0], 0, 0, 0, 0, 0, 0, 0, [-10, 0], -8, -9], [0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 0, 1, 1]);
    EnemyDataInit(oEnemy_Buzz, 0, 0.75, 1, 1, 1, [-10, 2, 2, 9, 9, 4, -6, -7, -10, -8, -9], [0, 0, 0, 0, 0, 1, 0, 2, 1, 0, 0, 0, 0]);
    EnemyDataInit(oEnemy_Hoarder, 0, 1.25, 1, 1, 1, [-10, 2, 2, 9, 9, 4, -6, -7, -10, -8, -9], [0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 3, 0]);
    EnemyDataInit(oEnemy_Hover, 0, 1, 1, 1, 3, [-10, 2, 2, 9, 9, 4, -6, -7, -10, -8, -9], [0, 0, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0]);
    EnemyDataInit(oEnemy_Keese, 0, 0.25, 0, 0, 3, [-10, 2, 2, 9, 9, 4, -6, -7, -10, -8, -9], [0, 0, 1, 1, 2, 1, 0, 0, 2, 2, 0, 0, 0]);
    EnemyDataInit(oEnemy_Kyameron_Moving, 0, 0.75, 0, 0, 0, [-10, 1, 1, 9, 9, 4, -6, -7, -10, -8, -9], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    EnemyDataInit(oEnemy_Poe, 0, 1, 0, 0, 3, [-10, 2, 2, 9, 9, 4, -6, -7, -10, -8, -9], [0, 0, 0, 0, 2, 0, 0, 0, 2, 1, 0, 0, 2]);
    EnemyDataInit(oEnemy_Rat, 0, 0.25, 1, 1, 2, [-10, 2, 2, 9, 9, 4, -6, -7, -10, -8, -9], [0, 0, 2, 1, 1, 2, 0, 0, 1, 0, 0, 0, 0]);
    EnemyDataInit(oEnemy_Rope, 1, 0.5, 1, 1, 3, [-10, 2, 2, -3, -3, 4, -6, -7, -10, -8, -9], [0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0]);
    EnemyDataInit(oEnemy_Bari, 2, 1.25, 1, 1, 3, [[-10, -5], 2, 2, -3, -3, 4, -6, -7, -10, -8, -9], [0, 0, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 2]);
    EnemyDataInit(oEnemy_Zol, 2, 1.25, 0, 1, 3, [[-10, 0], [2, 0], [2, 0], [-3, 0], [-3, 0], [4, 0], [-6, 0], [-7, 0], [-10, 0], [-8, 0], [-9, 0]], [0, 0, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0]);
    EnemyDataInit(oEnemy_BuzzBlob, 3, 1.25, 0, 1, 3, [[-10, -5], 2, 2, -3, -3, 4, -6, -7, -10, -8, -9], [0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0]);
    EnemyDataInit(oEnemy_Pikit, 3, 1.25, 0, 0, 3, [-10, 2, 2, -3, -3, 4, -6, -7, -10, -8, -9], [0, 0, 0, 0, 0, 2, 0, 1, 0, 0, 0, 0, 0]);
    EnemyDataInit(oEnemy_Popo, 3, 1.25, 1, 1, 3, [-10, 2, 2, -3, -3, 4, -6, -7, -10, -8, -9], [0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0]);
    EnemyDataInit(oEnemy_Skeleton, 3, 1, 1, 1, 4, [-10, 2, 2, -3, -3, 4, -6, -7, -10, -8, -9], [0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0]);
    EnemyDataInit(oEnemy_Crab, 4, 1.25, 1, 1, 3, [-10, 2, 2, -3, -3, 4, -6, -7, -10, -8, -9], [0, 0, 0, 0, 0, 2, 0, 1, 0, 0, 0, 0, 0]);
    EnemyDataInit(oEnemy_Gibdo, 4, 1.25, 1, 1, 4, [-10, 2, 2, -3, -3, 4, -6, -7, -10, -8, -9], [0, 0, 0, 0, 2, 0, 0, 3, 0, 0, 0, 0, 0]);
    EnemyDataInit(oEnemy_Helmasaur, 4, 1.5, 1, 1, 3, [[-10, -2], -1, 2, -3, -3, 4, -6, -7, -10, -8, -9], [0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0]);
    EnemyDataInit(oEnemy_Kodongo, 4, 1.75, 1, 1, 3, [-10, 2, 2, -3, -3, 4, -6, -7, -10, -8, -9], [0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 3, 1]);
    EnemyDataInit(oEnemy_Leever, 4, 1.75, 0, 1, 3, [[-10, 0], [2, -1], [2, 0], [-3, -1], [-3, -1], [4, 0], [-6, -1], [-7, 0], [-10, 0], [-8, 0], [-9, 0]], [0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0]);
    EnemyDataInit(oEnemy_Moldorm, 4, 2, 1, 1, 3, [-10, 2, 2, -3, -3, 4, -6, -7, -10, -8, -9], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0]);
    EnemyDataInit(oEnemy_Octorok, 4, 1.5, 1, 1, 3, [-10, 2, 2, -3, -3, 4, -6, -7, -10, -8, -9], [0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 2, 0]);
    EnemyDataInit(oEnemy_Ropa, 4, 1.75, 1, 1, 3, [-10, 2, 2, -3, -3, 4, -6, -7, -10, -8, -9], [0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 3, 1]);
    EnemyDataInit(oEnemy_Wizzrobe, 4, 2.5, 0, 1, 3, [[-10, 0], [2, 0], [9, 0], [-3, 0], [-3, 0], [4, 0], [-6, 0], [-7, 0], [-10, 0], [-8, 0], [-9, 0]], [0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 2]);
    EnemyDataInit(oEnemy_HardhatBeetle, 5, 2.25, 1, 1, 3, [-10, 2, 2, -3, -3, 4, -6, -7, -10, -8, -9], [0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0]);
    EnemyDataInit(oEnemy_SnapDragon, 5, 2, 1, 1, 4, [-10, 2, 2, -3, -3, 4, -6, -7, -10, -8, -9], [0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 2]);
    EnemyDataInit(oEnemy_Geldman, 6, 2, 0, 1, 5, [[-10, 0], [2, 0], [2, 0], [-3, 0], [-3, 0], [4, 0], [-6, 0], [-7, 0], [-10, 0], [-8, 0], [-9, 0]], [0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0]);
    EnemyDataInit(oEnemy_Goriya, 6, 2.5, 1, 1, 5, [-10, 2, 2, -3, -3, 4, -6, -7, -10, -8, -9], [0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0]);
    EnemyDataInit(oEnemy_Zirro, 6, 2.25, 0, 0, 5, [-10, 2, 9, -3, -3, 4, -6, -7, -10, -8, -9], [0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1]);
    EnemyDataInit(oEnemy_Eyegore, 7, 3, 1, 1, 6, [[-10, -1], [2, -1], [4, -1], [-3, -1], [-3, -1], [4, 0], [-6, -1], [-7, 0], [-10, -1], [-8, 0], [-9, 0]], [0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0]);
    EnemyDataInit(oEnemy_Zazak, 7, 2.75, 1, 1, 5, [-10, 2, 2, -3, -3, 4, -6, -7, -10, -8, -9], [0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0]);
    EnemyDataInit(oEnemy_Tektite, 8, 3, 1, 1, 5, [-10, 2, 9, -3, -3, 4, -6, -7, -10, -8, -9], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2]);
    EnemyDataInit(oEnemy_Armos, 9, 3.5, 1, 1, 6, [[-10, -1], [2, -1], [2, -1], -1, -1, [4, 0], [-6, -1], [-7, 0], [-10, -1], [-8, 0], [-9, 0]], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3]);
    EnemyDataInit(oEnemy_Hinox, 9, 3.75, 1, 1, 6, [-10, -1, -1, -1, -1, 0, -6, -7, -10, -8, -9], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5]);
    EnemyDataInit(oEnemy_Beamos, 0, 2, 0, 0, 0, [0, 0, 0, 0, 0, 0, 0, 0, 0, -8, 0], [0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 0, 0, 4]);
    EnemyDataInit(oEnemy_Cannon, 0, 0, 0, 0, 0, [[-10, 0], 0, 0, 0, 0, 0, 0, 0, [-10, 0], -8, 0], [0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 1]);
    EnemyDataInit(oEnemy_Guru, 0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0, [-6, 0], [-7, 0], 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    EnemyDataInit(oEnemy_Guru_Bar, 0, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 1, 0, 0, 1, 1, 2, 0, 1, 1]);
    EnemyDataInit(oEnemy_Kyameron_Emitter, 0, 0, 0, 0, 3, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0]);
    EnemyDataInit(oEnemy_Medusa, 0, 0, 0, 0, 0, [[-10, 0], 0, 0, 0, 0, 0, 0, 0, [-10, 0], -8, 0], [0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 0, 1, 1]);
    EnemyDataInit(oEnemy_RollingSpike, 0, 2, 0, 0, 0, [0, 0, 0, 0, 0, 0, 0, 0, 0, -8, 0], [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1]);
    EnemyDataInit(oEnemy_MovingSpikeBlock, 0, 2, 0, 0, 0, [[-10, 0], 0, 0, 0, 0, 0, 0, 0, [-10, 0], -8, 0], [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1]);
    EnemyDataInit(oEnemy_Soldier_Advanced, 0, 0, 1, 1, 4, [[-10, -2], 2, 2, -3, -3, 4, -6, -7, -10, -8, -9], [0, 2, 3, 3, 2, 0, 0, 0, 0, 2, 0, 0, 5]);
    EnemyDataInit(oEnemy_Soldier_Simple, 0, 0, 1, 1, 3, [-10, 2, 2, -3, -3, 4, -6, -7, -10, -8, -9], [0, 3, 3, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    EnemyDataInit(oEnemy_Soldier_Mace, 0, 0, 1, 1, 6, [-10, 2, 2, -1, -1, 4, -6, -7, -10, -8, -9], [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 2]);
    EnemyDataInit(oEnemy_Chicken, 14, 0, 0, 0, 0, [-10, 1, 1, 1, 1, 1, -6, -7, -10, -8, -9], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    EnemyDataInit(oEnemy_FootSoldier, 14, 0, 0, 0, 0, [-10, 1, 1, 1, 1, 1, -1, -1, -10, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    global.KnockBackColors = array_create(0);
    array_push(global.KnockBackColors, [1, 0, 0], [1, 0, 0], [0, 1, 0], [0, 1, 0], [-3, -3, -3], [-3, -3, -3], [0, 0, 1], [0, 0, 1], [-1, -1, -1], [-1, -1, -1], [-3, -3, -3], [-3, -3, -3], [1, 0, 0], [1, 0, 0], [0, 1, 0], [0, 1, 0], [-3, -3, -3], [-3, -3, -3], [0, 0, 1], [0, 0, 1], [-1, -1, -1], [-1, -1, -1], [-3, -3, -3], [-3, -3, -3]);
    global.KnockBackColorFrames = array_length(global.KnockBackColors);
}

function EnemyDataInit(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
{
    global.EnemyData[arg0] = {};
    array_get(global.EnemyData, arg0).EnergyIndex = arg1;
    array_get(global.EnemyData, arg0).Attack = arg2;
    array_get(global.EnemyData, arg0).SpecialItem = arg3;
    array_get(global.EnemyData, arg0).Item = arg4;
    array_get(global.EnemyData, arg0).PackPoints = arg5;
    array_get(global.EnemyData, arg0).LinkWeaponEffects = array_create(11);
    
    for (var _WeaponIndex = 0; _WeaponIndex < 11; _WeaponIndex++)
        array_set(struct_get_from_hash(array_get(global.EnemyData, arg0), variable_get_hash("LinkWeaponEffects")), _WeaponIndex, arg6[_WeaponIndex]);
    
    array_get(global.EnemyData, arg0).Levels = array_create(13);
    
    for (var _LevelIndex = 0; _LevelIndex < 13; _LevelIndex++)
        array_set(struct_get_from_hash(array_get(global.EnemyData, arg0), variable_get_hash("Levels")), _LevelIndex, arg7[_LevelIndex]);
}

function Enemy_LinkWeaponHit(arg0, arg1, arg2, arg3, arg4, arg5)
{
    with (arg2)
    {
        if (!is_struct(global.EnemyData[object_index]))
            return false;
        
        Hit_LinkWeaponEffect = global.EnemyData[object_index].LinkWeaponEffects[arg0];
        
        switch (State)
        {
            case UnknownEnum.Value_15:
                switch (arg0)
                {
                    case UnknownEnum.Value_10:
                        Hit_LinkWeaponEffect = UnknownEnum.Value_m9;
                        break;
                    
                    case UnknownEnum.Value_0:
                    case UnknownEnum.Value_8:
                    case UnknownEnum.Value_6:
                    case UnknownEnum.Value_9:
                    case UnknownEnum.Value_5:
                    case UnknownEnum.Value_2:
                    case UnknownEnum.Value_3:
                    case UnknownEnum.Value_4:
                    case UnknownEnum.Value_1:
                        Hit_LinkWeaponEffect = 100;
                        break;
                    
                    default:
                        Hit_LinkWeaponEffect = UnknownEnum.Value_0;
                        break;
                }
                
                break;
            
            case UnknownEnum.Value_13:
                if (is_array(Hit_LinkWeaponEffect))
                    Hit_LinkWeaponEffect = Hit_LinkWeaponEffect[0];
                
                break;
            
            case UnknownEnum.Value_17:
                switch (arg0)
                {
                    case UnknownEnum.Value_9:
                        Hit_LinkWeaponEffect = UnknownEnum.Value_0;
                        break;
                    
                    default:
                        if (is_array(Hit_LinkWeaponEffect))
                            Hit_LinkWeaponEffect = Hit_LinkWeaponEffect[0];
                        
                        break;
                }
                
                break;
        }
        
        if (arg0 == UnknownEnum.Value_0 && oLink.State == UnknownEnum.Value_19)
        {
            Energy = 1;
            Hit_LinkWeaponEffect = 100;
        }
        else if (is_array(Hit_LinkWeaponEffect))
        {
            switch (object_index)
            {
                case oEnemy_Bubble:
                case oEnemy_MovingSpikeBlock:
                case oEnemy_Medusa:
                case oEnemy_Cannon:
                    Hit_LinkWeaponEffect = SwordLevel(UnknownEnum.Value_4) ? Hit_LinkWeaponEffect[0] : Hit_LinkWeaponEffect[1];
                    break;
                
                case oBoss_Armos:
                    if (id == oBoss_Armos_C.LastArmos_Inst)
                        Hit_LinkWeaponEffect = (arg0 == UnknownEnum.Value_2) ? Hit_LinkWeaponEffect[1] : Hit_LinkWeaponEffect[0];
                    else
                        Hit_LinkWeaponEffect = (State == UnknownEnum.Value_5 || State == UnknownEnum.Value_7) ? Hit_LinkWeaponEffect[0] : Hit_LinkWeaponEffect[1];
                    
                    break;
                
                case oEnemy_Bari:
                    Hit_LinkWeaponEffect = (!CanShock || SwordLevel(UnknownEnum.Value_3) || oLink.Cape) ? Hit_LinkWeaponEffect[0] : Hit_LinkWeaponEffect[1];
                    break;
                
                case oEnemy_BuzzBlob:
                    Hit_LinkWeaponEffect = (SwordLevel(UnknownEnum.Value_3) || oLink.Cape) ? Hit_LinkWeaponEffect[0] : Hit_LinkWeaponEffect[1];
                    break;
                
                case oEnemy_Eyegore:
                    Hit_LinkWeaponEffect = (State == UnknownEnum.Value_3) ? Hit_LinkWeaponEffect[0] : Hit_LinkWeaponEffect[1];
                    break;
                
                case oEnemy_Zol:
                    Hit_LinkWeaponEffect = (State != UnknownEnum.Value_0 && State != UnknownEnum.Value_1) ? Hit_LinkWeaponEffect[0] : Hit_LinkWeaponEffect[1];
                    break;
                
                case oEnemy_Armos:
                case oEnemy_Geldman:
                case oEnemy_Leever:
                    Hit_LinkWeaponEffect = (State == UnknownEnum.Value_3) ? Hit_LinkWeaponEffect[0] : Hit_LinkWeaponEffect[1];
                    break;
                
                case oEnemy_Guru:
                    switch (Type)
                    {
                        case 0:
                            Hit_LinkWeaponEffect = (arg0 == UnknownEnum.Value_7) ? Hit_LinkWeaponEffect[0] : Hit_LinkWeaponEffect[1];
                            break;
                        
                        case 1:
                            Hit_LinkWeaponEffect = (arg0 == UnknownEnum.Value_6) ? Hit_LinkWeaponEffect[0] : Hit_LinkWeaponEffect[1];
                            break;
                        
                        case 2:
                            Hit_LinkWeaponEffect = UnknownEnum.Value_0;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Delavant:
                    Hit_LinkWeaponEffect = (State == UnknownEnum.Value_0) ? Hit_LinkWeaponEffect[1] : Hit_LinkWeaponEffect[0];
                    break;
                
                case oEnemy_Helmasaur:
                    if (Dir == OppositeDir(oLink.Facing) && !SwordLevel(UnknownEnum.Value_5))
                    {
                        instance_create_layer(x, y, "ObjsHigher_Upper", oWallHit, 
                        {
                            PlaySound: true
                        });
                        Hit_LinkWeaponEffect = Hit_LinkWeaponEffect[1];
                    }
                    else
                    {
                        Hit_LinkWeaponEffect = Hit_LinkWeaponEffect[0];
                    }
                    
                    break;
                
                case oEnemy_Soldier_Advanced:
                case oEnemy_Soldier_Slasher:
                    Hit_LinkWeaponEffect = Pushback ? Hit_LinkWeaponEffect[1] : Hit_LinkWeaponEffect[0];
                    break;
                
                case oEnemy_Wizzrobe:
                    Hit_LinkWeaponEffect = (State == UnknownEnum.Value_7) ? Hit_LinkWeaponEffect[0] : Hit_LinkWeaponEffect[1];
                    break;
                
                case oBoss_Aghanim:
                    Hit_LinkWeaponEffect = (State == UnknownEnum.Value_2 || State == UnknownEnum.Value_7) ? Hit_LinkWeaponEffect[0] : Hit_LinkWeaponEffect[1];
                    break;
            }
        }
        
        if (Hit_LinkWeaponEffect == UnknownEnum.Value_0)
            return false;
        
        Hit = true;
        Hit_PosX = arg3;
        Hit_PosY = arg4;
        Hit_DirX = lengthdir_x(1, arg5);
        Hit_DirY = lengthdir_y(1, arg5);
        Hit_LinkWeaponClass = arg0;
        Hit_LinkWeaponIndex = arg1;
    }
    
    return true;
}

function Enemy_CheckHit()
{
    if (State == UnknownEnum.Value_10)
    {
        if (Hit && Hit_LinkWeaponClass == UnknownEnum.Value_2 && Energy > 0.05)
            Hit_Allowed = true;
    }
    
    if (!Hit || !Hit_Allowed)
    {
        Hit = false;
        exit;
    }
    
    Hit_Allowed = false;
    Hit_Started = true;
    var _AttackPts = ATTACK();
    var _Damage;
    
    if (Hit_LinkWeaponClass == UnknownEnum.Value_0 && Hit_LinkWeaponEffect == -10)
    {
        Hit_LinkWeaponEffect = UnknownEnum.Value_1;
        _Damage = global.LinkSwordDamage[_AttackPts][EnergyIndex];
    }
    else if (Hit_LinkWeaponClass == UnknownEnum.Value_2 && Hit_LinkWeaponEffect >= 1)
    {
        _Damage = Hit_LinkWeaponEffect + floor(_AttackPts / 2.5);
        Hit_LinkWeaponEffect = UnknownEnum.Value_1;
    }
    else if (Hit_LinkWeaponClass == UnknownEnum.Value_5 && Hit_LinkWeaponEffect >= 1)
    {
        Hit_LinkWeaponEffect = UnknownEnum.Value_1;
        _Damage = 4;
    }
    else if (Hit_LinkWeaponClass == UnknownEnum.Value_8 && Hit_LinkWeaponEffect == -10)
    {
        Hit_LinkWeaponEffect = UnknownEnum.Value_1;
        _Damage = global.LinkSwordDamage[max(_AttackPts - 2, 1)][EnergyIndex];
    }
    else if (Hit_LinkWeaponEffect >= 1)
    {
        _Damage = Hit_LinkWeaponEffect + (max(_AttackPts - 1, 0) * 0.25);
        Hit_LinkWeaponEffect = UnknownEnum.Value_1;
    }
    
    switch (Hit_LinkWeaponEffect)
    {
        case 0.5:
            Hit_AllowedTimer = 30;
            break;
        
        case UnknownEnum.Value_0:
            Hit_Allowed = true;
            break;
        
        case UnknownEnum.Value_m1:
            instance_create_layer(Hit_PosX, Hit_PosY, "ObjsHigher_" + GetFloorLevelString(FloorLevel), oWallHit, 
            {
                PlaySound: true
            });
            Hit_AllowedTimer = 20;
            break;
        
        case UnknownEnum.Value_1:
            Enemy_Hit_KnockBack(false, _Damage);
            break;
        
        case UnknownEnum.Value_m3:
            Enemy_Hit_KnockBack(true, 0);
            break;
        
        case UnknownEnum.Value_m4:
            Enemy_Hit_KnockBack(true, 2);
            break;
        
        case UnknownEnum.Value_m2:
            Enemy_Hit_PushBack(Hit_LinkWeaponClass);
            break;
        
        case UnknownEnum.Value_m5:
            Enemy_Hit_ShockLink();
            break;
        
        case UnknownEnum.Value_m7:
            Enemy_UpdateState(UnknownEnum.Value_15);
            break;
        
        case UnknownEnum.Value_m6:
            Enemy_UpdateState(UnknownEnum.Value_16);
            break;
        
        case UnknownEnum.Value_m8:
            Enemy_UpdateState(UnknownEnum.Value_17);
            instance_create_layer(ObjCenterX(), ObjCenterY(), "ObjsHigher_" + GetFloorLevelString(FloorLevel), oPoof);
            audio_play_sound(Sound_Cane_Magic, 1, false);
            break;
        
        case UnknownEnum.Value_m9:
            Enemy_UpdateState(UnknownEnum.Value_18, Hit_LinkWeaponIndex);
            break;
    }
    
    Hit = false;
}

function Enemy_Attack(arg0)
{
    if (arg0 == 0)
        return 0;
    
    if (global.Challenges[UnknownEnum.Value_2] || Curse_Check(UnknownEnum.Value_12))
        arg0 *= 1.5;
    
    return max(arg0 - (oLink.DefensePoints * 0.25), 0.125);
}

function Enemy_Hit_KnockBack(arg0, arg1)
{
    if (State == UnknownEnum.Value_15)
    {
        var _Layer = "ObjsHigher_" + GetFloorLevelString(FloorLevel);
        
        switch (object_index)
        {
            default:
                var SprW = sprite_get_width(sprite_index);
                var SprH = sprite_get_height(sprite_index);
                var _Shards = ceil((SprW * SprH) / 28);
                
                repeat (_Shards)
                {
                    instance_create_layer(x, y_base, _Layer, oIceShard, 
                    {
                        FloorLevel: FloorLevel,
                        z: z
                    });
                }
                
                var _PoofX = (x - sprite_get_xoffset(sprite_index)) + (SprW / 2);
                var _PoofY = (y - sprite_get_yoffset(sprite_index)) + (SprH / 2);
                instance_create_layer(_PoofX, _PoofY, layer, oPoof_NoSound);
                break;
            
            case oEnemy_RollingSpike:
                switch (Dir)
                {
                    case 2:
                        var _Sections = W / 16;
                        
                        for (var i = 0; i < _Sections; i++)
                        {
                            var _Shards = irandom_range(3, 5);
                            var _x = x + (i * 16);
                            var _y = y_base + 8;
                            
                            repeat (_Shards)
                            {
                                instance_create_layer(_x, _y, _Layer, oIceShard, 
                                {
                                    FloorLevel: FloorLevel,
                                    z: z
                                });
                            }
                            
                            var _PoofX = _x;
                            var _PoofY = _y;
                            instance_create_layer(_PoofX, _PoofY, layer, oPoof_NoSound);
                        }
                        
                        break;
                    
                    case 1:
                        var _Sections = H / 16;
                        
                        for (var i = 0; i < _Sections; i++)
                        {
                            var _Shards = irandom_range(3, 5);
                            var _x = x + 8;
                            var _y = y_base + (i * 16);
                            
                            repeat (_Shards)
                            {
                                instance_create_layer(_x, _y, _Layer, oIceShard, 
                                {
                                    FloorLevel: FloorLevel,
                                    z: z
                                });
                            }
                            
                            var _PoofX = _x;
                            var _PoofY = _y;
                            instance_create_layer(_PoofX, _PoofY, layer, oPoof_NoSound);
                        }
                        
                        break;
                }
                
                break;
        }
        
        audio_play_sound_stopall(Sound_PotShatter);
        Enemy_Destroy();
        
        if (ItemHolding != -1)
            Enemy_DestroySpawnItem(ItemHolding, Size);
        
        exit;
    }
    
    if (UnStunWhenHit)
        UnStunWhenHit = false;
    
    KnockBackColorFrame = 0;
    KnockBackTime = KnockBackTimeLen;
    
    if (KnockBackEnabled)
    {
        vx = Hit_DirX * KnockBackV;
        vy = Hit_DirY * KnockBackV;
        
        if (!KnockBackIgnoreZRule)
            vz = -abs(vz);
    }
    
    Energy -= arg1;
    Hit_Stun = arg0;
    
    if (Hit_PlaySound && !audio_is_playing(Hit_Sound))
        audio_play_sound(Hit_Sound, 1, false);
    
    Enemy_UpdateState(UnknownEnum.Value_10);
}

function Enemy_Hit_PushBack(arg0)
{
    PushbackTime = PushbackTimeLen;
    
    switch (arg0)
    {
        default:
            PushbackTimeLen = 10;
            PushbackV = 3;
            break;
        
        case UnknownEnum.Value_5:
            PushbackTimeLen = 15;
            PushbackV = 4;
    }
    
    vx = Hit_DirX * PushbackV;
    vy = Hit_DirY * PushbackV;
    Enemy_UpdateState(UnknownEnum.Value_11);
}

function Enemy_Hit_ShockLink()
{
    Enemy_UpdateState(UnknownEnum.Value_14);
    ShockLink(other.id, true);
    Hit_AllowedTimer = 20;
}

function Enemy_Destroy()
{
    instance_destroy(id);
    Destroyed = true;
    Curse_CheckTask(UnknownEnum.Value_0);
    global.StatsToAdd[UnknownEnum.Value_3]++;
}

function Enemy_DestroySpawnItem(arg0, arg1, arg2 = UnknownEnum.Value_1, arg3 = true)
{
    if (arg0 == -1 || arg0 == -4)
        exit;
    
    if (arg0 == UnknownEnum.Value_43)
    {
        if (!Enemy_StopWatchItem_Allowed())
            arg0 = Probs_RandomItemClass_Pot(true, true);
    }
    
    if (arg1 == UnknownEnum.Value_0)
    {
        switch (arg0)
        {
            case UnknownEnum.Value_27:
            case UnknownEnum.Value_23:
            case UnknownEnum.Value_33:
            case UnknownEnum.Value_14:
            case UnknownEnum.Value_35:
                arg0 = Probs_RandomItemClass_Pot(true, true);
                break;
        }
    }
    
    var _RupeeAmount = 0;
    var _HeartAmount = 0;
    var _MagicAmount = 0;
    
    if (arg3 && (arg1 == UnknownEnum.Value_3 || arg1 == UnknownEnum.Value_2) && !(global.Level.Rooms[RoomIndex].TemplateClass == UnknownEnum.Value_2 && FloorLevel == 1))
    {
        if (Prob(0.33))
        {
            switch (arg0)
            {
                default:
                    switch (arg1)
                    {
                        case UnknownEnum.Value_3:
                            _RupeeAmount = choose(0, 0, 0, 0, irandom_range(2, 12));
                            _HeartAmount = choose(0, 0, 0, 0, 0, 1, 1, 2);
                            _MagicAmount = choose(0, 0, 0, 0, 0, 1, 1, 2);
                            break;
                        
                        case UnknownEnum.Value_2:
                            _RupeeAmount = choose(0, 0, 0, 0, irandom_range(1, 6));
                            _HeartAmount = choose(0, 0, 0, 0, 0, 1);
                            _MagicAmount = choose(0, 0, 0, 0, 0, 1);
                            break;
                    }
                    
                    break;
                
                case UnknownEnum.Value_40:
                    switch (arg1)
                    {
                        case UnknownEnum.Value_3:
                            _RupeeAmount = irandom_range(5, 25);
                            _HeartAmount = choose(0, 0, 0, 0, 0, 1, 1, 2);
                            _MagicAmount = choose(0, 0, 0, 0, 0, 1, 1, 2);
                            break;
                        
                        case UnknownEnum.Value_2:
                            _RupeeAmount = irandom_range(2, 12);
                            _HeartAmount = choose(0, 0, 0, 0, 0, 1);
                            _MagicAmount = choose(0, 0, 0, 0, 0, 1);
                            break;
                    }
                    
                    break;
                
                case UnknownEnum.Value_17:
                    switch (arg1)
                    {
                        case UnknownEnum.Value_3:
                            _HeartAmount = choose(1, 1, 1, 1, 2, 2, 3);
                            _RupeeAmount = choose(0, 0, 0, 0, irandom_range(2, 12));
                            _MagicAmount = choose(0, 0, 0, 0, 0, 1, 1, 2);
                            break;
                        
                        case UnknownEnum.Value_2:
                            _HeartAmount = choose(1, 1, 1, 1, 2);
                            _RupeeAmount = choose(0, 0, 0, 0, irandom_range(1, 6));
                            _MagicAmount = choose(0, 0, 0, 0, 0, 1);
                            break;
                    }
                    
                    break;
                
                case UnknownEnum.Value_26:
                    switch (arg1)
                    {
                        case UnknownEnum.Value_3:
                            _MagicAmount = choose(1, 1, 1, 2, 2, 3);
                            _RupeeAmount = choose(0, 0, 0, 0, irandom_range(2, 12));
                            _HeartAmount = choose(0, 0, 0, 0, 0, 1, 1, 2);
                            break;
                        
                        case UnknownEnum.Value_2:
                            _MagicAmount = choose(1, 1, 1, 2);
                            _RupeeAmount = choose(0, 0, 0, 0, irandom_range(1, 6));
                            _HeartAmount = choose(0, 0, 0, 0, 0, 1);
                            break;
                    }
                    
                    break;
            }
        }
    }
    
    ItemExplosion(x, y_base, clamp(FloorLevel, 0, 1), ItemFromEnemySize(arg1), _RupeeAmount, _HeartAmount, _MagicAmount, arg0, arg2);
}

function Enemy_StopWatchItem_Allowed()
{
    if (global.Level.DungeonTemplate.Rooms[RoomIndex].Section_ID != 0)
        return false;
    
    if (oLink.StarActive)
        return false;
    
    if (instance_exists(oItem_Stopwatch) || instance_exists(oItem_Star))
        return false;
    
    var EnemiesForStopWatch = 0;
    
    with (oEnemy)
    {
        switch (object_index)
        {
            case oEnemy_Guru_Bar:
                return false;
        }
        
        if (Enemy_GoodForSpecialAttack(id) && State != UnknownEnum.Value_15 && Size > UnknownEnum.Value_0)
            EnemiesForStopWatch++;
    }
    
    return EnemiesForStopWatch >= 2;
}

function Enemy_PixelRender(arg0 = false, arg1 = -4, arg2 = 0, arg3 = true)
{
    switch (State)
    {
        default:
            PixelRender_Dim(arg3, arg3, arg0, arg1, arg2, false, 0);
            break;
        
        case UnknownEnum.Value_10:
            PixelRender_Dim(arg3, arg3, arg0, arg1, arg2, true, global.KnockBackColors[KnockBackColorFrame]);
            break;
        
        case UnknownEnum.Value_15:
            PixelRender_Dim(arg3, arg3, arg0, arg1, arg2, true, [0, 0.6, 1]);
            break;
        
        case UnknownEnum.Value_16:
            PixelRender_Dim(arg3, arg3, arg0, arg1, arg2, true, [0.55, 0, 0]);
            break;
        
        case UnknownEnum.Value_17:
            PixelRender_Dim(arg3, arg3, arg0, arg1, arg2, true, [-2, -2, -2]);
            break;
    }
}

function SpawnBoss(arg0)
{
    if (!global.Level.IsBossLevel || arg0 != global.Level.RoomIndex_Boss)
        exit;
    
    var VarStruct = 
    {
        FloorLevel: 1,
        ItemHolding: -1,
        SectionID: 0,
        RoomIndex: arg0
    };
    
    switch (global.Level.Index)
    {
        case UnknownEnum.Value_3:
            var inst = instance_create_layer(global.Level.Rooms[arg0].x + 20, global.Level.Rooms[arg0].y + 20, "System", oBoss_Armos_C, VarStruct);
            break;
        
        case UnknownEnum.Value_7:
            var inst = instance_create_layer(global.Level.Rooms[arg0].x + 20, global.Level.Rooms[arg0].y + 20, "System", oBoss_Lanmola_C, VarStruct);
            break;
        
        case UnknownEnum.Value_11:
            var inst = instance_create_layer(global.Level.Rooms[arg0].x + 128, global.Level.Rooms[arg0].y + 80, "ObjsHigher_Upper", oBoss_Moldorm, VarStruct);
            break;
    }
}

function Enemy_UpdateState(arg0, arg1 = 0)
{
    if (State == UnknownEnum.Value_15)
    {
        switch (arg0)
        {
            default:
                exit;
                break;
            
            case UnknownEnum.Value_10:
            case UnknownEnum.Value_18:
            case UnknownEnum.Value_12:
            case UnknownEnum.Value_19:
            case UnknownEnum.Value_16:
                break;
        }
    }
    
    State = arg0;
    
    switch (State)
    {
        case UnknownEnum.Value_0:
            switch (object_index)
            {
                case oEnemy_Delavant:
                    alarm[1] = 60;
                    break;
                
                case oEnemy_Kyameron_Emitter:
                    alarm[0] = IdleTime + MovingTime;
                    break;
                
                case oEnemy_Eyegore:
                    image_index = 0;
                    ObjSetImageSpeed(0);
                    IdleDelay = true;
                    alarm[2] = 60;
                    break;
                
                case oEnemy_Geldman:
                    x = StartX;
                    ObjSetY(StartY);
                    AllowSpawn = false;
                    alarm[2] = 60;
                    break;
                
                case oEnemy_Leever:
                    alarm[0] = irandom_range(90, 200);
                    break;
                
                case oEnemy_Soldier_Mace:
                    Speed = 0;
                    image_index = 0;
                    ObjSetImageSpeed(0);
                    break;
                
                case oEnemy_Wizzrobe:
                    Visible = false;
                    alarm[0] = SleepDelay;
                    break;
                
                case oEnemy_Zol:
                    ObjSetImageSpeed(0);
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_1:
            switch (object_index)
            {
                case oEnemy_Armos:
                    alarm[0] = 60;
                    break;
                
                case oEnemy_Delavant:
                    Visible = true;
                    break;
                
                case oEnemy_Eyegore:
                    image_index = 1;
                    ObjSetImageSpeed(1);
                    break;
                
                case oEnemy_Geldman:
                    alarm[0] = 40;
                    break;
                
                case oEnemy_Kyameron_Emitter:
                    alarm[1] = 120;
                    break;
                
                case oEnemy_Leever:
                    image_index = 0;
                    break;
                
                case oEnemy_Wizzrobe:
                    Dir = DirFaceLink();
                    alarm[1] = SpawnDelay;
                    break;
                
                case oEnemy_Zol:
                    ObjSetImageSpeed(1);
                    var ZolInst = instance_place(oLink.x, oLink.y, oEnemy_Zol);
                    
                    if (ZolInst != -4)
                    {
                        var A = point_direction(x, y, oLink.x, oLink.y);
                        var IncX = lengthdir_x(1, A);
                        var IncY = lengthdir_y(1, A);
                        
                        while (!place_meeting(x + IncX, y + IncY, oEnemy_Zol))
                        {
                            x += IncX;
                            ObjSetY(y + IncY);
                        }
                    }
                    else
                    {
                        x = oLink.x;
                        ObjSetY(oLink.y);
                    }
                    
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_2:
            vx = 0;
            vy = 0;
            
            switch (object_index)
            {
                case oEnemy_Buzz:
                    alarm[0] = Prob(0.3) ? 1 : irandom_range(30, 90);
                    break;
                
                case oEnemy_Chicken:
                    alarm[0] = 60;
                    image_index = 0;
                    ObjSetImageSpeed(0);
                    break;
                
                case oEnemy_Goriya:
                    alarm[3] = irandom_range(60, 100);
                    OpenMouth = false;
                    break;
                
                case oEnemy_Hinox:
                    ObjSetImageSpeed(0);
                    alarm[1] = 40;
                    break;
                
                case oEnemy_Hover:
                    alarm[0] = choose(45, 60, 75, 90);
                    break;
                
                case oEnemy_Keese:
                    CanFly = false;
                    alarm[0] = 60;
                    alarm[2] = -1;
                    layer = global.LayerID_ObjsHighest;
                    FloorLevel = 2;
                    var _OnWallInst = collision_point(x, y_base, oWall, false, true);
                    
                    if (_OnWallInst != -4)
                    {
                        if (_OnWallInst.IsHole)
                        {
                            Enemy_UpdateState(UnknownEnum.Value_3);
                            break;
                        }
                    }
                    
                    if (tilemap_get_at_pixel(global.TMID_Tiles_Ceiling, x, y_base) != 0)
                        break;
                    
                    if (tilemap_get_at_pixel(global.TMID_Tiles_Highest, x, y_base) != 0)
                        break;
                    
                    if (tilemap_get_at_pixel(global.TMID_Tiles_Higher, x, y_base) != 0)
                        break;
                    
                    if (tilemap_get_at_pixel(global.TMID_Decor_Upper, x, y_base) != 0)
                        break;
                    
                    if (tilemap_get_at_pixel(global.TMID_Walls_Upper, x, y_base) != 0)
                        break;
                    
                    if (tilemap_get_at_pixel(global.TMID_StairMonumentsDecor, x, y_base) != 0)
                        break;
                    
                    if (tilemap_get_at_pixel(global.TMID_StairMonuments, x, y_base) != 0)
                        break;
                    
                    if (tilemap_get_at_pixel(global.TMID_Decor_Lower, x, y_base) != 0)
                        break;
                    
                    if (tilemap_get_at_pixel(global.TMID_Walls_Lower, x, y_base) != 0)
                        break;
                    
                    if (tilemap_get_at_pixel(global.TMID_Floor_Upper, x, y_base) != 0)
                    {
                        layer = global.LayerID_Objs_Upper;
                        FloorLevel = 1;
                        break;
                    }
                    
                    if (tilemap_get_at_pixel(global.TMID_Floor_Lower, x, y_base) != 0)
                    {
                        layer = global.LayerID_Objs_Lower;
                        FloorLevel = 0;
                        break;
                    }
                    
                    break;
                
                case oEnemy_Kodongo:
                    if (Type == 1 && !oLink.Cape)
                        Dir = DirFaceLink();
                    
                    image_index = 0;
                    ObjSetImageSpeed(0);
                    alarm[0] = ds_grid_get(Script, 1, ScriptPos);
                    ScriptPos = (ScriptPos + 1) % ScriptLen;
                    break;
                
                case oEnemy_Octorok:
                    ObjSetImageSpeed(0);
                    alarm[1] = 30;
                    break;
                
                case oEnemy_Pikit:
                    alarm[0] = StandPause + irandom_range(-10, 10);
                    alarm[1] = CanShootPause;
                    break;
                
                case oEnemy_Popo:
                    alarm[1] = irandom_range(60, 180);
                    break;
                
                case oEnemy_Rat:
                    alarm[0] = irandom_range(30, 160);
                    break;
                
                case oEnemy_Ropa:
                    alarm[0] = JumpDelay;
                    break;
                
                case oEnemy_Skeleton:
                    switch (Dir)
                    {
                        case 1:
                        case 2:
                            NextDir = choose(3, 4);
                            break;
                        
                        case 3:
                        case 4:
                            NextDir = choose(1, 2);
                            break;
                    }
                    
                    HeadDir = NextDir;
                    alarm[1] = 32;
                    ObjSetImageSpeed(0);
                    break;
                
                case oEnemy_SnapDragon:
                    alarm[0] = 60;
                    ObjSetImageSpeed(1);
                    break;
                
                case oEnemy_Soldier_Simple:
                    ObjSetImageSpeed(0);
                    Soldier_UpdateHead(Soldier_Simple_LookSideDir(Dir));
                    alarm[0] = 20;
                    alarm[1] = -1;
                    break;
                
                case oEnemy_Soldier_Advanced:
                    image_index = 0;
                    ObjSetImageSpeed(0);
                    StandingHeadChecks = 6;
                    PlayRunSound = true;
                    alarm[1] = -1;
                    alarm[3] = StandinHeadTurnDelay;
                    alarm[4] = -1;
                    break;
                
                case oEnemy_Soldier_Mace:
                    Speed = 0;
                    Soldier_UpdateDir(Dir);
                    alarm[0] = -1;
                    alarm[1] = -1;
                    alarm[3] = -1;
                    alarm[4] = irandom_range(40, 160);
                    ObjSetImageSpeed(0);
                    
                    if (instance_exists(WeaponInst))
                        WeaponInst.State = State;
                    
                    break;
                
                case oEnemy_Tektite:
                    alarm[0] = irandom_range(30, 90);
                    break;
                
                case oEnemy_Zazak:
                    ObjSetImageSpeed(0);
                    Soldier_UpdateHead(Soldier_Simple_LookSideDir(Dir));
                    alarm[0] = 20;
                    alarm[1] = -1;
                    alarm[2] = -1;
                    alarm[3] = -1;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_3:
            switch (object_index)
            {
                case oEnemy_Armos:
                    image_index = 1;
                    vz = JumpVZ;
                    GravityStatus = true;
                    break;
                
                case oEnemy_Bari:
                    alarm[0] = irandom_range(120, 300);
                    break;
                
                case oEnemy_Buzz:
                    GravityStatus = true;
                    
                    if (choose(0, 1) == 0)
                    {
                        Hops = irandom_range(1, 4);
                        vz = 2;
                        Speed = WalkSpeed;
                    }
                    else
                    {
                        Hops = 1;
                        vz = 3;
                        Speed = JumpSpeed;
                    }
                    
                    Buzz_UpdateDir(RandomDir());
                    break;
                
                case oEnemy_Chicken:
                    ObjSetImageSpeed(0.5);
                    Hops = irandom_range(2, 8);
                    GravityStatus = true;
                    Gravity = -0.2;
                    vz = JumpSpeed;
                    Chicken_PickNewDir();
                    break;
                
                case oEnemy_Crab:
                    Crab_UpdateDir();
                    break;
                
                case oEnemy_Eyegore:
                    image_index = 0;
                    ObjSetImageSpeed(1);
                    Eyegore_UpdateDir(DirFaceLink());
                    break;
                
                case oEnemy_Geldman:
                    var DirToLink = point_direction(x, y, oLink.x, oLink.y);
                    vx = lengthdir_x(Speed, DirToLink);
                    vy = lengthdir_y(Speed, DirToLink);
                    alarm[1] = 120;
                    break;
                
                case oEnemy_Gibdo:
                    Gibdo_UpdateDir(DirFaceLink());
                    alarm[0] = irandom_range(60, 150);
                    break;
                
                case oEnemy_Goriya:
                    Goriya_UpdateDir(RandomDir());
                    OpenMouth = false;
                    break;
                
                case oEnemy_Helmasaur:
                    Helmasaur_UpdateDir();
                    alarm[0] = irandom_range(ChangeDirDelayMin, ChangeDirDelayMax);
                    break;
                
                case oEnemy_Hinox:
                    ObjSetImageSpeed(0.5);
                    var DirList = ds_list_create();
                    var BufferLen = 12;
                    
                    if (!place_meeting(x - BufferLen, y, oWall) && !place_meeting(x, y - BufferLen, oWall) && !place_meeting(x, y + BufferLen, oWall))
                        ds_list_add(DirList, 3);
                    
                    if (!place_meeting(x + BufferLen, y, oWall) && !place_meeting(x, y - BufferLen, oWall) && !place_meeting(x, y + BufferLen, oWall))
                        ds_list_add(DirList, 4);
                    
                    if (!place_meeting(x, y - BufferLen, oWall) && !place_meeting(x - BufferLen, y, oWall) && !place_meeting(x + BufferLen, y, oWall))
                        ds_list_add(DirList, 1);
                    
                    if (!place_meeting(x, y + BufferLen, oWall) && !place_meeting(x - BufferLen, y, oWall) && !place_meeting(x + BufferLen, y, oWall))
                        ds_list_add(DirList, 2);
                    
                    ds_list_shuffle(DirList);
                    Hinox_UpdateDir((ds_list_size(DirList) == 0) ? RandomDir() : ds_list_find_value(DirList, 0), WalkSpeed);
                    ds_list_destroy(DirList);
                    break;
                
                case oEnemy_Hoarder:
                    Hoarder_UpdateDir();
                    break;
                
                case oEnemy_Hover:
                    Dir = oLink.Cape ? irandom(359) : point_direction(x, y, oLink.x, oLink.y);
                    Speed = Speed_Initial;
                    vx = lengthdir_x(Speed, Dir);
                    vy = lengthdir_y(Speed, Dir);
                    FacingDir = (vx < 0) ? -1 : 1;
                    SlowdownSpeed = choose(0.05, 0.1, 0.2);
                    break;
                
                case oEnemy_Keese:
                    Dir = point_direction(x, y, oLink.x, oLink.y) + irandom_range(-30, 30);
                    vx = lengthdir_x(Speed, Dir);
                    vy = lengthdir_y(Speed, Dir);
                    AngleDir = choose(-1, 1);
                    alarm[1] = irandom_range(60, 120);
                    alarm[2] = irandom_range(5, 45);
                    layer = global.LayerID_ObjsHighest;
                    FloorLevel = 2;
                    break;
                
                case oEnemy_Kodongo:
                    ds_grid_set(Script, 1, ScriptPos, irandom_range(90, 200));
                    Dir = RandomDir();
                    Enemy_UpdateV(WalkSpeed);
                    image_index = 0;
                    ObjSetImageSpeed(1);
                    alarm[0] = ds_grid_get(Script, 1, ScriptPos);
                    ScriptPos = (ScriptPos + 1) % ScriptLen;
                    break;
                
                case oEnemy_Leever:
                    alarm[1] = irandom_range(200, 400);
                    Leever_UpdateDir();
                    break;
                
                case oEnemy_Octorok:
                    Octorok_UpdateDir(RandomDir());
                    ObjSetImageSpeed(1);
                    ShotCount = 0;
                    alarm[0] = irandom_range(90, 200);
                    alarm[1] = -1;
                    alarm[2] = -1;
                    alarm[3] = -1;
                    alarm[4] = -1;
                    break;
                
                case oEnemy_Popo:
                    alarm[1] = irandom_range(180, 320);
                    var D = irandom_range(0, 359);
                    vx = lengthdir_x(MaxSpeed, D);
                    vy = lengthdir_y(MaxSpeed, D);
                    alarm[2] = MoveDelay;
                    break;
                
                case oEnemy_Rat:
                    Rat_UpdateDir(RandomDir());
                    break;
                
                case oEnemy_Rope:
                    Rope_UpdateDir(RandomDir());
                    ObjSetImageSpeed(0.5);
                    break;
                
                case oEnemy_Skeleton:
                    Skeleton_UpdateDir(NextDir);
                    alarm[0] = irandom_range(4, 15) * 8;
                    ObjSetImageSpeed(1);
                    break;
                
                case oEnemy_SnapDragon:
                    ObjSetImageSpeed(0);
                    image_index = 0;
                    Hops = irandom_range(2, 8);
                    GravityStatus = true;
                    vz = JumpSpeed;
                    SnapDragon_UpdateDir(RandomDir());
                    break;
                
                case oEnemy_Soldier_Simple:
                    ObjSetImageSpeed(0.5);
                    Speed = WalkSpeed;
                    Soldier_UpdateDir(HeadDir);
                    alarm[1] = irandom_range(60, 200);
                    break;
                
                case oEnemy_Soldier_Advanced:
                    ObjSetImageSpeed(0.5);
                    Speed = WalkSpeed;
                    Soldier_UpdateDir(HeadDir);
                    Soldier_UpdateWeaponSprite();
                    alarm[2] = irandom_range(100, 500);
                    alarm[4] = irandom_range(60, 400);
                    break;
                
                case oEnemy_Soldier_Mace:
                    ObjSetImageSpeed(1);
                    Speed = WalkSpeed;
                    Soldier_Advanced_UpdateRunningDir(false);
                    Strafe = false;
                    SpinAllowed = true;
                    break;
                
                case oEnemy_Zazak:
                    ObjSetImageSpeed(1);
                    Soldier_UpdateDir(HeadDir);
                    alarm[1] = irandom_range(30, 90);
                    break;
                
                case oEnemy_Zirro:
                    Dir = Prob(0.6) ? DirFaceLink() : RandomDir();
                    var AngleOffset = choose(-1, 0, 1);
                    
                    switch (Dir)
                    {
                        case 3:
                            vx = -Speed;
                            vy = Speed * AngleOffset;
                            break;
                        
                        case 4:
                            vx = Speed;
                            vy = Speed * AngleOffset;
                            break;
                        
                        case 1:
                            vx = Speed * AngleOffset;
                            vy = -Speed;
                            break;
                        
                        case 2:
                            vx = Speed * AngleOffset;
                            vy = Speed;
                            break;
                    }
                    
                    alarm[0] = 48;
                    break;
                
                case oEnemy_Zol:
                    vx = 0;
                    vy = 0;
                    image_index = 1;
                    ObjSetImageSpeed(0);
                    Zol_UpdateDir();
                    alarm[0] = 20;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_4:
            switch (object_index)
            {
                case oEnemy_Chicken:
                    WallCollide_Bounce = false;
                    break;
                
                case oEnemy_Hinox:
                    ObjSetImageSpeed(1);
                    Hinox_UpdateDir(DirFaceLink(), RunSpeed);
                    alarm[1] = -1;
                    alarm[2] = -1;
                    break;
                
                case oEnemy_Rope:
                    Rope_UpdateDir(RandomDir());
                    ObjSetImageSpeed(1);
                    break;
                
                case oEnemy_Soldier_Simple:
                    ObjSetImageSpeed(1);
                    Speed = RunSpeed;
                    Soldier_UpdateDir(HeadDir);
                    alarm[1] = irandom_range(60, 120);
                    break;
                
                case oEnemy_Soldier_Advanced:
                    ObjSetImageSpeed(1);
                    Speed = RunSpeed;
                    Soldier_Advanced_UpdateRunningDir();
                    
                    if (PlayRunSound)
                        audio_play_sound_stopall(Sound_Enemy_Chase);
                    
                    PlayRunSound = false;
                    alarm[2] = -1;
                    alarm[3] = -1;
                    alarm[4] = -1;
                    alarm[6] = 200;
                    break;
                
                case oEnemy_Soldier_Slasher:
                    ObjSetImageSpeed(1);
                    Speed = RunSpeed;
                    Soldier_Advanced_UpdateRunningDir();
                    Strafe = false;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_9:
            switch (object_index)
            {
                case oEnemy_Soldier_Simple:
                    ObjSetImageSpeed(0);
                    vx = 0;
                    vy = 0;
                    alarm[0] = -1;
                    alarm[1] = -1;
                    alarm[2] = 30;
                    break;
                
                case oEnemy_Soldier_Advanced:
                    ObjSetImageSpeed(0);
                    vx = 0;
                    vy = 0;
                    alarm[1] = -1;
                    alarm[2] = -1;
                    alarm[3] = -1;
                    alarm[4] = -1;
                    alarm[5] = 30;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_5:
            GravityStatus = true;
            
            switch (object_index)
            {
                case oEnemy_Chicken:
                    layer = layer_get_id("Objs_" + GetFloorLevelString(FloorLevel));
                    PickedUp = false;
                    x = oLink.x;
                    z = 18;
                    Gravity = -0.1;
                    vz = 0.75;
                    ObjSetY(oLink.y - 1);
                    
                    switch (oLink.Facing)
                    {
                        case 1:
                            vy = -SpeedThrow;
                            break;
                        
                        case 2:
                            vy = SpeedThrow;
                            break;
                        
                        case 3:
                            vx = -SpeedThrow;
                            break;
                        
                        case 4:
                            vx = SpeedThrow;
                            break;
                    }
                    
                    Dir = (vx >= 0) ? 1 : -1;
                    WallCollide_Bounce = true;
                    WallCollide_Bounce_NewVFactor = 0.25;
                    mask_index = sEnemy_Chicken;
                    ObjSetImageSpeed(1);
                    audio_play_sound(Sound_Chicken, 1, false);
                    audio_play_sound(Sound_Chicken_Fly, 1, false);
                    break;
                
                case oEnemy_Kyameron_Emitter:
                    image_index = 0;
                    break;
                
                case oEnemy_Pikit:
                    Dir = RandomDir();
                    Enemy_UpdateV(choose(Speed1, Speed2, Speed3));
                    vz = JumpSpeed;
                    break;
                
                case oEnemy_Ropa:
                    var A = oLink.Cape ? irandom(359) : point_direction(x, y_base, oLink.x, oLink.y);
                    vx = lengthdir_x(1, A);
                    vy = lengthdir_y(1, A);
                    vz = choose(1, 2, 3);
                    layer = global.LayerID_ObjsHighest;
                    break;
                
                case oEnemy_Skeleton:
                    Dir = DirFaceLink();
                    HeadDir = Dir;
                    vz = JumpSpeed;
                    alarm[0] = -1;
                    alarm[1] = -1;
                    var D = point_direction(oLink.x, oLink.y, x, y);
                    vx = lengthdir_x(JumpSpeed + 0.25, D);
                    vy = lengthdir_y(JumpSpeed + 0.25, D);
                    layer = global.LayerID_ObjsHighest;
                    break;
                
                case oEnemy_Tektite:
                    Tektite_UpdateDir(RandomDir());
                    layer = global.LayerID_ObjsHighest;
                    vz = JumpZ;
                    Hops = 1;
                    break;
                
                case oEnemy_Zol:
                    var A = point_direction(x, y_base, oLink.x, oLink.y);
                    vx = lengthdir_x(1, A);
                    vy = lengthdir_y(1, A);
                    vz = 2;
                    LookDir = (vx >= 0) ? 1 : -1;
                    image_index = 0;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_7:
            switch (object_index)
            {
                case oBoss_Armos:
                    oBoss_Armos_C.alarm[5] = -1;
                    oBoss_Armos_C.alarm[6] = 8;
                    break;
                
                case oEnemy_Delavant:
                    ShootCounter = 0;
                    Enemy_ShootRedBall(x, y);
                    alarm[2] = ShootDelay;
                    break;
                
                case oEnemy_Hinox:
                    vx = 0;
                    vy = 0;
                    alarm[0] = -1;
                    alarm[1] = -1;
                    alarm[2] = 40;
                    Dir = DirFaceLink();
                    break;
                
                case oEnemy_Kodongo:
                    vx = 0;
                    vy = 0;
                    FireballCount = 0;
                    Kodongo_Shoot();
                    alarm[0] = ds_grid_get(Script, 1, ScriptPos);
                    ScriptPos = (ScriptPos + 1) % ScriptLen;
                    break;
                
                case oEnemy_Octorok:
                    ShotCount = Octorok_Shots();
                    alarm[0] = -1;
                    alarm[1] = -1;
                    alarm[2] = MouthFrameDelay;
                    alarm[3] = -1;
                    alarm[4] = -1;
                    break;
                
                case oEnemy_Pikit:
                    image_index = 0;
                    ObjSetImageSpeed(1);
                    Shoot = false;
                    CanShoot = true;
                    alarm[0] = -1;
                    alarm[1] = -1;
                    break;
                
                case oEnemy_Skeleton:
                    vx = 0;
                    vy = 0;
                    ObjSetImageSpeed(0);
                    Dir = DirFaceLink();
                    HeadDir = Dir;
                    alarm[2] = 30;
                    break;
                
                case oEnemy_Soldier_Mace:
                    image_index = 0;
                    ObjSetImageSpeed(0);
                    Speed = 0;
                    alarm[0] = -1;
                    alarm[1] = -1;
                    
                    if (!WeaponInst.Spin)
                    {
                        WeaponInst.SpinDist = WeaponInst.SpinDistStart;
                        WeaponInst.SpinAngle = 0;
                        alarm[2] = 60;
                        SpinAllowed = false;
                    }
                    else
                    {
                        SpinAllowed = true;
                    }
                    
                    break;
                
                case oEnemy_Wizzrobe:
                    Visible = true;
                    alarm[2] = 8;
                    break;
                
                case oEnemy_Zazak:
                    ObjSetImageSpeed(0);
                    Soldier_UpdateDir(DirFaceLink());
                    
                    switch (Dir)
                    {
                        case 3:
                            HeadSpr = sEnemy_Zazak_ShootHead_Left;
                            break;
                        
                        case 4:
                            HeadSpr = sEnemy_Zazak_ShootHead_Right;
                            break;
                        
                        case 2:
                            HeadSpr = sEnemy_Zazak_ShootHead_Down;
                            break;
                    }
                    
                    vx = 0;
                    vy = 0;
                    alarm[0] = -1;
                    alarm[1] = -1;
                    alarm[2] = 30;
                    break;
                
                case oEnemy_Zirro:
                    vx = 0;
                    vy = 0;
                    alarm[0] = -1;
                    alarm[1] = 24;
                    Zirro_Shoot();
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_8:
            switch (object_index)
            {
                case oEnemy_Delavant:
                    image_index = image_number - 1;
                    ObjSetImageSpeed(-1);
                    DirtInst.image_index = DirtInst.image_number - 1;
                    break;
                
                case oEnemy_Eyegore:
                    vx = 0;
                    vy = 0;
                    Dir = 2;
                    image_index = 2.99;
                    ObjSetImageSpeed(-1);
                    alarm[0] = -1;
                    break;
                
                case oEnemy_Geldman:
                    alarm[1] = 0;
                    image_index = 0;
                    vx = 0;
                    vy = 0;
                    break;
                
                case oEnemy_Leever:
                    image_index = 0;
                    vx = 0;
                    vy = 0;
                    break;
                
                case oEnemy_Wizzrobe:
                    image_index = 0;
                    alarm[1] = SpawnDelay;
                    alarm[2] = -1;
                    alarm[3] = -1;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_10:
            switch (object_index)
            {
                case oEnemy_Zol:
                    image_index = 1;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_13:
            switch (object_index)
            {
                default:
                    StunCounter = StunTime;
                    StunnedShake = false;
                    UnStunWhenHit = true;
                    StunnedShakeIniX = x;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_14:
            switch (object_index)
            {
                case oEnemy_BuzzBlob:
                    vx = 0;
                    vy = 0;
                    ShockCounter = 90;
                    ShockFrame = 0;
                    alarm[0] = -1;
                    Lighting_UpdateLight_Visible(RoomIndex, LightIndex, true);
                    Lighting_UpdateLight_Pos(RoomIndex, LightIndex, x, y - 7);
                    break;
                
                case oEnemy_Bari:
                    vx = 0;
                    vy = 0;
                    ShockCounter = 90;
                    alarm[0] = -1;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_15:
            vx = 0;
            vy = 0;
            StopWatch = true;
            Hit_Allowed = true;
            FrozenSparkleCounter = FrozenSparkleTime;
            Enemy_TransformUpdate();
            var _PoofInst = instance_create_layer(ObjCenterX(), ObjCenterY(), EffectLayer(FloorLevel), instance_exists(oPoof) ? oPoof_NoSound : oPoof);
            _PoofInst.depth = depth - 5;
            audio_play_sound_stopall(Sound_Cane_Magic);
            audio_play_sound_stopall(Sound_Chicken_Hit);
            break;
        
        case UnknownEnum.Value_16:
            vx = 0;
            vy = 0;
            OnFireCounter = OnFireTime;
            OnFireInst = instance_create_layer(x, y - 2, EffectLayer(FloorLevel), oFireEffect, 
            {
                FloorLevel: FloorLevel
            });
            OnFireInst.sprite_index = sFireEffect_Long;
            OnFireInst.depth = depth - 5;
            audio_play_sound_stopall(Sound_Enemy_Kill);
            break;
        
        case UnknownEnum.Value_18:
            Enemy_Destroy();
            Enemy_DestroySpawnItem(ItemHolding, Size, UnknownEnum.Value_4);
            var _FloorLevel = clamp(FloorLevel, 0, 1);
            
            switch (arg1 - 3)
            {
                case UnknownEnum.Value_0:
                    var _BombInst = instance_create_layer(x, y_base - 4, "Objs_" + GetFloorLevelString(_FloorLevel), oBomb, 
                    {
                        FloorLevel: _FloorLevel
                    });
                    _BombInst.z = 8;
                    _BombInst.vz = 1.25;
                    _BombInst.State = UnknownEnum.Value_4;
                    _BombInst.alarm[0] = 30;
                    break;
                
                case UnknownEnum.Value_1:
                    var _HeartPiece = -1;
                    var _Hearts;
                    
                    switch (Size)
                    {
                        case UnknownEnum.Value_0:
                            _Hearts = 1;
                            break;
                        
                        case UnknownEnum.Value_1:
                            _Hearts = choose(1, 1, 1, 2);
                            break;
                        
                        case UnknownEnum.Value_2:
                            _Hearts = choose(1, 1, 1, 2, 2);
                            break;
                        
                        case UnknownEnum.Value_3:
                            _Hearts = choose(1, 1, 2, 2, 3);
                            
                            if (Prob(0.01) && Item_Allowed(UnknownEnum.Value_18))
                                _HeartPiece = UnknownEnum.Value_18;
                            
                            break;
                    }
                    
                    ItemExplosion(x, y_base, _FloorLevel, UnknownEnum.Value_14, 0, _Hearts, 0, _HeartPiece);
                    break;
                
                case UnknownEnum.Value_2:
                    var _Rupees;
                    
                    switch (Size)
                    {
                        case UnknownEnum.Value_0:
                            _Rupees = irandom_range(1, 5);
                            break;
                        
                        case UnknownEnum.Value_1:
                            _Rupees = irandom_range(2, 8);
                            break;
                        
                        case UnknownEnum.Value_2:
                            _Rupees = irandom_range(3, 10);
                            break;
                        
                        case UnknownEnum.Value_3:
                            _Rupees = irandom_range(4, 15);
                            break;
                    }
                    
                    if (object_index == oEnemy_Chicken)
                        _Rupees = irandom_range(3, 10);
                    
                    ItemExplosion(x, y_base, _FloorLevel, UnknownEnum.Value_14, _Rupees);
                    break;
            }
            
            var _PoofInst = instance_create_layer(ObjCenterX(), ObjCenterY(), EffectLayer(_FloorLevel), oPoof);
            _PoofInst.depth = depth - 5;
            audio_play_sound_stopall(Sound_Cane_Magic);
            break;
        
        case UnknownEnum.Value_17:
            Hit_Allowed = true;
            Stoned = true;
            Enemy_TransformUpdate();
            break;
    }
    
    Enemy_UpdateSprite(State);
}

function Enemy_UpdateSprite(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_0:
            switch (object_index)
            {
                case oEnemy_Eyegore:
                    sprite_index = sEnemy_Eyegore_Stand;
                    break;
                
                case oEnemy_Geldman:
                    sprite_index = sEmptyMask;
                    break;
                
                case oEnemy_Kyameron_Emitter:
                    sprite_index = sEmptyMask;
                    break;
                
                case oEnemy_Leever:
                    sprite_index = sEmptyMask;
                    break;
                
                case oEnemy_Zol:
                    sprite_index = sEnemy_Zol_Wake;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_1:
            switch (object_index)
            {
                case oEnemy_Delavant:
                    sprite_index = sEnemy_Delavant_Wake;
                    break;
                
                case oEnemy_Kyameron_Emitter:
                    sprite_index = sEnemy_Kyameron_Emitter;
                    break;
                
                case oEnemy_Eyegore:
                    sprite_index = sEnemy_Eyegore_Stand;
                    break;
                
                case oEnemy_Geldman:
                    sprite_index = sEnemy_Geldman_Wake;
                    break;
                
                case oEnemy_Leever:
                    sprite_index = sEnemy_Leever_Wake;
                    break;
                
                case oEnemy_Wizzrobe:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = (Type == 0) ? sEnemy_Wizzrobe_Left : sEnemy_Wizzrobe2_Left;
                            break;
                        
                        case 4:
                            sprite_index = (Type == 0) ? sEnemy_Wizzrobe_Right : sEnemy_Wizzrobe2_Right;
                            break;
                        
                        case 1:
                            sprite_index = (Type == 0) ? sEnemy_Wizzrobe_Up : sEnemy_Wizzrobe2_Up;
                            break;
                        
                        case 2:
                            sprite_index = (Type == 0) ? sEnemy_Wizzrobe_Down : sEnemy_Wizzrobe2_Down;
                            break;
                    }
                    
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_2:
            switch (object_index)
            {
                case oEnemy_Buzz:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Buzz_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Buzz_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Buzz_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Buzz_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_BuzzBlob:
                    sprite_index = sEnemy_BuzzBlob;
                    break;
                
                case oEnemy_Goriya:
                    sprite_index = sEnemy_Goriya_Stand;
                    
                    switch (Dir)
                    {
                        case 3:
                            image_index = 2;
                            break;
                        
                        case 4:
                            image_index = 3;
                            break;
                        
                        case 1:
                            image_index = 1;
                            break;
                        
                        case 2:
                            image_index = 0;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Hinox:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Hinox_Walk_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Hinox_Walk_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Hinox_Walk_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Hinox_Walk_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Hover:
                    sprite_index = sEnemy_Hover_Standing;
                    break;
                
                case oEnemy_Keese:
                    sprite_index = asset_get_index("sEnemy_" + Keese_GetSpriteStr() + "_Standing");
                    break;
                
                case oEnemy_Kodongo:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Kodongo_Walk_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Kodongo_Walk_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Kodongo_Walk_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Kodongo_Walk_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Octorok:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = Sprite_Left;
                            break;
                        
                        case 4:
                            sprite_index = Sprite_Right;
                            break;
                        
                        case 1:
                            sprite_index = Sprite_Up;
                            break;
                        
                        case 2:
                            sprite_index = Sprite_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Pikit:
                    sprite_index = sEnemy_Pikit;
                    break;
                
                case oEnemy_Rat:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Rat_Stand_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Rat_Stand_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Rat_Stand_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Rat_Stand_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Skeleton:
                    sprite_index = sEnemy_SkeletonBody_Standing;
                    image_index = Dir - 1;
                    break;
                
                case oEnemy_Soldier_Simple:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Soldier_Simple_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Soldier_Simple_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Soldier_Simple_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Soldier_Simple_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Soldier_Mace:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Soldier_Slasher_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Soldier_Slasher_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Soldier_Slasher_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Soldier_Slasher_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Tektite:
                    sprite_index = sEnemy_Tektite_Standing;
                    break;
                
                case oEnemy_Zazak:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Zazak_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Zazak_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Zazak_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Zazak_Down;
                            break;
                    }
                    
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_3:
            switch (object_index)
            {
                case oEnemy_Bari:
                    sprite_index = sEnemy_Bari_Walking;
                    break;
                
                case oBoss_Moldorm:
                    sprite_index = sBoss_Moldorm_Head;
                    break;
                
                case oEnemy_Buzz:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Buzz_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Buzz_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Buzz_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Buzz_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_BuzzBlob:
                    sprite_index = sEnemy_BuzzBlob;
                    break;
                
                case oEnemy_Eyegore:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Eyegore_Walk_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Eyegore_Walk_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Eyegore_Walk_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Eyegore_Walk_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Geldman:
                    sprite_index = sEnemy_Geldman_Walk;
                    break;
                
                case oEnemy_Gibdo:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Gibdo_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Gibdo_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Gibdo_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Gibdo_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Goriya:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Goriya_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Goriya_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Goriya_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Goriya_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Helmasaur:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Helmasaur_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Helmasaur_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Helmasaur_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Helmasaur_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Hinox:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Hinox_Walk_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Hinox_Walk_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Hinox_Walk_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Hinox_Walk_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Hover:
                    sprite_index = sEnemy_Hover_Walking;
                    break;
                
                case oEnemy_Keese:
                    sprite_index = asset_get_index("sEnemy_" + Keese_GetSpriteStr() + "_Flying");
                    break;
                
                case oEnemy_Kodongo:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Kodongo_Walk_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Kodongo_Walk_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Kodongo_Walk_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Kodongo_Walk_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Leever:
                    sprite_index = sEnemy_Leever_Walking;
                    break;
                
                case oEnemy_Moldorm:
                    sprite_index = sEnemy_Moldorm_Head;
                    break;
                
                case oEnemy_Octorok:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = Sprite_Left;
                            break;
                        
                        case 4:
                            sprite_index = Sprite_Right;
                            break;
                        
                        case 1:
                            sprite_index = Sprite_Up;
                            break;
                        
                        case 2:
                            sprite_index = Sprite_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Rat:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Rat_Walk_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Rat_Walk_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Rat_Walk_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Rat_Walk_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Rope:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = (global.Level.Index == UnknownEnum.Value_4) ? sEnemy_Rope2_Left : sEnemy_Rope_Left;
                            break;
                        
                        case 4:
                            sprite_index = (global.Level.Index == UnknownEnum.Value_4) ? sEnemy_Rope2_Right : sEnemy_Rope_Right;
                            break;
                        
                        case 1:
                            sprite_index = (global.Level.Index == UnknownEnum.Value_4) ? sEnemy_Rope2_Up : sEnemy_Rope_Up;
                            break;
                        
                        case 2:
                            sprite_index = (global.Level.Index == UnknownEnum.Value_4) ? sEnemy_Rope2_Down : sEnemy_Rope_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Skeleton:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_SkeletonBody_Walking_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_SkeletonBody_Walking_Right;
                            break;
                        
                        case 1:
                        case 2:
                            sprite_index = sEnemy_SkeletonBody_Walking_UpDown;
                            break;
                    }
                    
                    break;
                
                case oEnemy_SnapDragon:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_SnapDragon_Up;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_SnapDragon_Down;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_SnapDragon_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_SnapDragon_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Soldier_Simple:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Soldier_Simple_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Soldier_Simple_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Soldier_Simple_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Soldier_Simple_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Soldier_Advanced:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Soldier_Advanced_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Soldier_Advanced_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Soldier_Advanced_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Soldier_Advanced_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Soldier_Mace:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Soldier_Slasher_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Soldier_Slasher_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Soldier_Slasher_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Soldier_Slasher_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Zazak:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Zazak_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Zazak_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Zazak_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Zazak_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Zirro:
                    switch (DirFaceLink())
                    {
                        case 3:
                            sprite_index = sEnemy_Zirro_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Zirro_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Zirro_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Zirro_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Zol:
                    sprite_index = sEnemy_Zol;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_4:
            switch (object_index)
            {
                case oEnemy_Hinox:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Hinox_Walk_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Hinox_Walk_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Hinox_Walk_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Hinox_Walk_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Rope:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = (global.Level.Index == UnknownEnum.Value_4) ? sEnemy_Rope2_Left : sEnemy_Rope_Left;
                            break;
                        
                        case 4:
                            sprite_index = (global.Level.Index == UnknownEnum.Value_4) ? sEnemy_Rope2_Right : sEnemy_Rope_Right;
                            break;
                        
                        case 1:
                            sprite_index = (global.Level.Index == UnknownEnum.Value_4) ? sEnemy_Rope2_Up : sEnemy_Rope_Up;
                            break;
                        
                        case 2:
                            sprite_index = (global.Level.Index == UnknownEnum.Value_4) ? sEnemy_Rope2_Down : sEnemy_Rope_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Soldier_Simple:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Soldier_Simple_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Soldier_Simple_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Soldier_Simple_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Soldier_Simple_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Soldier_Advanced:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Soldier_Advanced_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Soldier_Advanced_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Soldier_Advanced_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Soldier_Advanced_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Soldier_Slasher:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Soldier_Slasher_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Soldier_Slasher_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Soldier_Slasher_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Soldier_Slasher_Down;
                            break;
                    }
                    
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_5:
            switch (object_index)
            {
                case oEnemy_Buzz:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Buzz_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Buzz_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Buzz_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Buzz_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Geldman:
                    sprite_index = sEnemy_Geldman_Jump;
                    break;
                
                case oEnemy_Kyameron_Emitter:
                    sprite_index = sEnemy_Kyameron_Jumping;
                    break;
                
                case oEnemy_Pikit:
                    sprite_index = sEnemy_Pikit;
                    break;
                
                case oEnemy_Skeleton:
                    sprite_index = sEnemy_SkeletonBody_Jumping;
                    
                    switch (Dir)
                    {
                        case 1:
                        case 2:
                            image_index = 0;
                            break;
                        
                        case 3:
                            image_index = 1;
                            break;
                        
                        case 4:
                            image_index = 2;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Tektite:
                    sprite_index = sEnemy_Tektite_Jumping;
                    break;
                
                case oEnemy_Zol:
                    sprite_index = sEnemy_Zol;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_7:
            switch (object_index)
            {
                case oEnemy_Delavant:
                    sprite_index = sEnemy_Delavant;
                    break;
                
                case oEnemy_Hinox:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Hinox_Bomb_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Hinox_Bomb_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Hinox_Bomb_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Hinox_Bomb_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Kodongo:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Kodongo_Shoot_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Kodongo_Shoot_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Kodongo_Shoot_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Kodongo_Shoot_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Octorok:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = Sprite_Left;
                            break;
                        
                        case 4:
                            sprite_index = Sprite_Right;
                            break;
                        
                        case 1:
                            sprite_index = Sprite_Up;
                            break;
                        
                        case 2:
                            sprite_index = Sprite_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Pikit:
                    sprite_index = sEnemy_Pikit_Shooting;
                    break;
                
                case oEnemy_Skeleton:
                    sprite_index = sEnemy_SkeletonBody_Standing;
                    image_index = Dir - 1;
                    break;
                
                case oEnemy_Soldier_Mace:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Soldier_Slasher_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Soldier_Slasher_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Soldier_Slasher_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Soldier_Slasher_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Zazak:
                    switch (Dir)
                    {
                        case 3:
                            sprite_index = sEnemy_Zazak_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Zazak_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Zazak_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Zazak_Down;
                            break;
                    }
                    
                    break;
                
                case oEnemy_Zirro:
                    switch (DirFaceLink())
                    {
                        case 3:
                            sprite_index = sEnemy_Zirro_Attack_Left;
                            break;
                        
                        case 4:
                            sprite_index = sEnemy_Zirro_Attack_Right;
                            break;
                        
                        case 1:
                            sprite_index = sEnemy_Zirro_Up;
                            break;
                        
                        case 2:
                            sprite_index = sEnemy_Zirro_Attack_Down;
                            break;
                    }
                    
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_8:
            switch (object_index)
            {
                case oEnemy_Delavant:
                    sprite_index = sEnemy_Delavant_Wake;
                    break;
                
                case oEnemy_Eyegore:
                    sprite_index = sEnemy_Eyegore_Stand;
                    break;
                
                case oEnemy_Geldman:
                    sprite_index = sEnemy_Geldman_Sleep;
                    break;
                
                case oEnemy_Leever:
                    sprite_index = sEnemy_Leever_Sleep;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_14:
            switch (object_index)
            {
                case oEnemy_Bari:
                    sprite_index = sEnemy_Bari_Shock;
                    break;
                
                case oEnemy_BuzzBlob:
                    sprite_index = sEnemy_BuzzBlob_Shock;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_17:
            switch (object_index)
            {
                case oEnemy_Bari:
                    sprite_index = sEnemy_Bari_Walking;
                    break;
                
                case oEnemy_BuzzBlob:
                    sprite_index = sEnemy_BuzzBlob;
                    break;
            }
            
            break;
    }
}

function Enemy_UpdateV(arg0)
{
    vx = 0;
    vy = 0;
    
    switch (Dir)
    {
        case 3:
            vx = -arg0;
            break;
        
        case 4:
            vx = arg0;
            break;
        
        case 1:
            vy = -arg0;
            break;
        
        case 2:
            vy = arg0;
            break;
    }
}

function Enemy_ShootRedBall(arg0, arg1)
{
    var inst = instance_create_layer(arg0, arg1, "ObjsHigher_" + FloorLevelStr, oRedBall);
    var Angle = point_direction(arg0, arg1, oLink.x, oLink.y - 6);
    inst.vx = lengthdir_x(2, Angle);
    inst.vy = lengthdir_y(2, Angle);
    
    if (oCamera.InView(arg0, arg1))
        audio_play_sound(Sound_Medusa, 1, false);
}

function Enemy_WallCollisionNewDir(arg0)
{
    var Dir1, Dir2, Wall1, Wall2, Dir3, Dir4;
    
    switch (arg0)
    {
        case 1:
            Dir1 = 3;
            Dir2 = 4;
            Dir3 = 1;
            Dir4 = 2;
            Wall1 = ObjCollision(x, y - 6, oWall, FloorLevel);
            Wall2 = ObjCollision(x, y + 6, oWall, FloorLevel);
            break;
        
        case 2:
            Dir1 = 1;
            Dir2 = 2;
            Dir3 = 3;
            Dir4 = 4;
            Wall1 = ObjCollision(x - 6, y, oWall, FloorLevel);
            Wall2 = ObjCollision(x + 6, y, oWall, FloorLevel);
            break;
    }
    
    var OppositeDir = (Dir == Dir1) ? Dir2 : Dir1;
    
    if (Wall1 == -4 && Wall2 == -4)
        return choose(Dir3, Dir4, OppositeDir);
    else if (Wall1 == -4 && Wall2 != -4)
        return choose(Dir3, OppositeDir);
    else if (Wall1 != -4 && Wall2 == -4)
        return choose(Dir4, OppositeDir);
    else
        return OppositeDir;
}

function Enemy_LinkInSight(arg0, arg1, arg2)
{
    if (!Sight || FloorLevel != oLink.FloorLevel || oLink.Cape)
        return false;
    
    var SightX1, SightY1, SightX2, SightY2;
    
    switch (arg0)
    {
        case 1:
            SightX1 = x - arg1;
            SightY1 = y - arg2;
            SightX2 = x + arg1;
            SightY2 = y;
            break;
        
        case 2:
            SightX1 = x - arg1;
            SightY1 = y;
            SightX2 = x + arg1;
            SightY2 = y + arg2;
            break;
        
        case 3:
            SightX1 = x - arg2;
            SightY1 = y - 6 - arg1;
            SightX2 = x;
            SightY2 = (y - 6) + arg1;
            break;
        
        case 4:
            SightX1 = x;
            SightY1 = y - 6 - arg1;
            SightX2 = x + arg2;
            SightY2 = (y - 6) + arg1;
            break;
    }
    
    return collision_rectangle(SightX1, SightY1, SightX2, SightY2, oLink, false, true) != -4;
}

function Enemy_Reset(arg0)
{
    with (oEnemy)
    {
        switch (object_index)
        {
            case oBoss_Armos:
            case oBoss_Moldorm:
            case oBoss_Moldorm_BodyL:
            case oBoss_Moldorm_BodyS:
            case oBoss_Moldorm_Tail:
            case oEnemy_Guru:
            case oEnemy_Guru_Bar:
            case oEnemy_Kyameron_Moving:
                continue;
        }
        
        switch (object_index)
        {
            case oEnemy_Chicken:
                if (instance_exists(oLink.ItemHolding))
                {
                    if (id == oLink.ItemHolding.id)
                        continue;
                }
                
                with (id)
                {
                    Enemy_UpdateState(UnknownEnum.Value_3);
                    Scared = false;
                }
                
                continue;
                break;
        }
        
        if (RoomIndex == arg0)
        {
            instance_destroy(id);
            var inst = instance_create_layer(Reset_StartX, Reset_StartY, layer, object_index, 
            {
                FloorLevel: self.FloorLevel,
                ItemHolding: self.ItemHolding,
                SectionID: self.SectionID,
                RoomIndex: self.RoomIndex
            });
            
            for (var i = 0; i < array_length(SaveVariables); i++)
            {
                var VarName = SaveVariables[i];
                variable_instance_set(inst, VarName, variable_instance_get(id, VarName));
            }
        }
    }
    
    with (oEnemy_Guru_Bar)
    {
        if (RoomIndex == arg0)
        {
            var inst = instance_create_layer(Reset_StartX, Reset_StartY, layer, object_index, 
            {
                FloorLevel: self.FloorLevel,
                ItemHolding: self.ItemHolding,
                SectionID: self.SectionID,
                RoomIndex: self.RoomIndex,
                Angle: self.Angle,
                GurusDestroyed: self.GurusDestroyed
            });
            instance_destroy(id);
        }
    }
}

function Enemy_SetEnergy(arg0)
{
    EnergyIndex = Enemy_CheckEnergyIndex(arg0);
    EnergyMax = Enemy_GetMaxEnergy(EnergyIndex);
    Energy = EnergyMax;
}

function Enemy_GetMaxEnergy(arg0)
{
    return global.EnemyHitsToKill[UnknownEnum.Value_0][arg0];
}

function Enemy_CheckEnergyIndex(arg0)
{
    if (arg0 >= 13)
        return arg0;
    
    if (global.Challenges[UnknownEnum.Value_2] || Curse_Check(UnknownEnum.Value_12))
        arg0++;
    
    return arg0;
}

function Enemy_TransformUpdate()
{
    if (variable_instance_exists(id, "LightIndex"))
        LightIndex = Lighting_DestroyLight(RoomIndex, LightIndex);
    
    switch (object_index)
    {
        case oEnemy_Kyameron_Emitter:
            sprite_index = sEnemy_Kyameron_Emitter;
            break;
        
        case oEnemy_Zol:
            sprite_index = sEnemy_Zol;
            break;
        
        case oEnemy_Leever:
            sprite_index = sEnemy_Leever_Walking;
            break;
        
        case oEnemy_Geldman:
            sprite_index = sEnemy_Geldman_Walk;
            break;
        
        case oEnemy_Wizzrobe:
            Visible = true;
            break;
        
        case oEnemy_Chicken:
            StopWatch = false;
            break;
        
        case oEnemy_Beamos:
            Beamos_DestroyLaserLights();
            EyeLight = Lighting_DestroyLight(RoomIndex, EyeLight);
            Beamos_Laser_Reset();
            break;
    }
}

function Enemy_GoodForSpecialAttack(arg0)
{
    return !Enemy_IsWall(arg0) && !Enemy_CanBeHidden(arg0) && !Enemy_IsInvincible(arg0) && !Enemy_IsObstacle(arg0);
}

function Enemy_GoodForTrap(arg0)
{
    switch (arg0)
    {
        case oEnemy_BuzzBlob:
        case oEnemy_Hover:
        case oEnemy_Rat:
        case oEnemy_Rope:
            return false;
    }
    
    return Enemy_GoodForSpecialAttack(arg0) && !Enemy_CanFly(arg0);
}

function Enemy_IsWall(arg0)
{
    switch (arg0)
    {
        case oEnemy_Beamos:
        case oEnemy_Cannon:
        case oEnemy_Medusa:
            return true;
            break;
    }
    
    return false;
}

function Enemy_IsUnderground(arg0)
{
    switch (arg0)
    {
        case oEnemy_Delavant:
        case oEnemy_Geldman:
        case oEnemy_Leever:
            return true;
            break;
    }
    
    return false;
}

function Enemy_CanBeHidden(arg0)
{
    if (Enemy_IsUnderground(arg0))
        return true;
    
    switch (arg0)
    {
        case oEnemy_Wizzrobe:
        case oEnemy_Zol:
            return true;
            break;
    }
    
    return false;
}

function Enemy_IsInvincible(arg0)
{
    switch (arg0)
    {
        case oEnemy_Bubble:
        case oEnemy_Kyameron_Emitter:
            return true;
            break;
    }
    
    return false;
}

function Enemy_IsObstacle(arg0)
{
    switch (arg0)
    {
        case oEnemy_Guru:
        case oEnemy_Guru_Bar:
        case oEnemy_RollingSpike:
        case oEnemy_MovingSpikeBlock:
            return true;
            break;
    }
    
    return false;
}

function Enemy_CanJump(arg0)
{
    switch (arg0)
    {
        case oEnemy_Skeleton:
        case oEnemy_Tektite:
        case oEnemy_Ropa:
            return true;
            break;
    }
    
    return false;
}

function Enemy_CanFly(arg0)
{
    switch (arg0)
    {
        case oEnemy_Keese:
        case oEnemy_Kyune:
        case oEnemy_Poe:
        case oEnemy_Zirro:
            return true;
            break;
    }
    
    return false;
}

function Enemy_DrawShadow(arg0 = sShadow_Large)
{
    PixelRender_Dim(true, false, false, -4, 0, false, []);
    draw_sprite(arg0, 0, x, y_base);
    shader_reset();
}

function ItemFromEnemySize(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_0:
            return UnknownEnum.Value_15;
        
        case UnknownEnum.Value_1:
            return UnknownEnum.Value_16;
        
        case UnknownEnum.Value_2:
            return UnknownEnum.Value_17;
        
        case UnknownEnum.Value_3:
            return UnknownEnum.Value_18;
    }
}

function Enemy_IsBoss(arg0)
{
    switch (arg0)
    {
        case oBoss_Armos:
        case oBoss_Lanmola:
        case oBoss_Lanmola_Tail:
        case oBoss_Lanmola_Body:
        case oBoss_Moldorm:
        case oBoss_Moldorm_Tail:
        case oBoss_Moldorm_BodyS:
        case oBoss_Moldorm_BodyL:
            return true;
    }
    
    return false;
}

enum UnknownEnum
{
    Value_m9 = -9,
    Value_m8,
    Value_m7,
    Value_m6,
    Value_m5,
    Value_m4,
    Value_m3,
    Value_m2,
    Value_m1,
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_9,
    Value_10,
    Value_11,
    Value_12,
    Value_13,
    Value_14,
    Value_15,
    Value_16,
    Value_17,
    Value_18,
    Value_19,
    Value_23 = 23,
    Value_26 = 26,
    Value_27,
    Value_33 = 33,
    Value_35 = 35,
    Value_40 = 40,
    Value_43 = 43
}
