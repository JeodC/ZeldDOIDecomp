event_inherited();

switch (State)
{
    case UnknownEnum.Value_0:
        break;
    
    case UnknownEnum.Value_1:
        break;
    
    case UnknownEnum.Value_2:
        break;
    
    case UnknownEnum.Value_3:
        break;
    
    case UnknownEnum.Value_4:
        CamX = Harry.x - CamW_3;
        CamXMin = max(CamXMin, CamX);
        
        if (CamX < CamXMin)
            CamX = CamXMin;
        
        if (CamX >= CamXMax)
        {
            CamX = 0;
            CamXMin = 0;
            Harry.x = CamW_3;
            NextEnemySpawnX = CamX + 30 + irandom(CamW_2 + 40);
            
            with (oPitfall_Enemy)
                x -= other.CamXMax;
            
            with (oPitfall_Treasure)
                instance_destroy(id);
            
            if (Prob(0.4))
                instance_create_layer(CamXMax - CamW, HarryStartY, "System", choose(oPitfall_Gold, oPitfall_Gold, oPitfall_Ring));
        }
        
        if (CamX >= NextEnemySpawnX)
        {
            var CurrentEnemy = NextEnemy;
            var Y;
            
            switch (CurrentEnemy)
            {
                case oPitfall_Scorpion:
                    Y = HarryStartY;
                    break;
                
                case oPitfall_Bat:
                    Y = HarryStartY - 34;
                    break;
                
                case oPitfall_Eagle:
                    Y = HarryStartY - 38;
                    break;
                
                case oPitfall_Frog:
                    Y = HarryStartY;
                    break;
            }
            
            instance_create_layer(CamX + CamW + 8, Y, "System", CurrentEnemy);
            
            if (CurrentEnemy == oPitfall_Scorpion && choose(1, 2, 3, 4) == 1)
            {
                NextEnemy = oPitfall_Scorpion;
                NextEnemySpawnX = CamX + irandom_range(32, 36);
            }
            else if (CurrentEnemy == oPitfall_Bat && choose(1, 2, 3, 4) == 1)
            {
                NextEnemy = oPitfall_Bat;
                NextEnemySpawnX = CamX + irandom_range(34, 50);
            }
            else
            {
                switch (choose(1, 1, 1, 2, 2, 2, 3, 3, 4))
                {
                    case 1:
                        NextEnemy = oPitfall_Scorpion;
                        NextEnemySpawnX = CamX + 32 + irandom(CamW_2 + 20);
                        break;
                    
                    case 2:
                        NextEnemy = oPitfall_Bat;
                        NextEnemySpawnX = CamX + 45 + irandom(CamW_2 + 20);
                        break;
                    
                    case 3:
                        NextEnemy = oPitfall_Eagle;
                        NextEnemySpawnX = CamX + 55 + irandom(CamW_2 + 20);
                        break;
                    
                    case 4:
                        NextEnemy = oPitfall_Frog;
                        NextEnemySpawnX = CamX + 30 + irandom(CamW_2 + 20);
                        break;
                }
            }
        }
        
        break;
    
    case UnknownEnum.Value_5:
        break;
    
    case UnknownEnum.Value_6:
        break;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6
}
