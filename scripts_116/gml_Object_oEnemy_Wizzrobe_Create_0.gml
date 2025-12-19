event_inherited();
Size = UnknownEnum.Value_2;
Visible = false;
SpawnDelay = 40;
SleepDelay = 60;
CheckForWater = true;
InWaterSprYOffset = -2;

switch (global.Level.Index)
{
    case UnknownEnum.Value_9:
    default:
        Type = 1;
        Enemy_SetEnergy(4);
        Attack = 2.5;
        break;
    
    case UnknownEnum.Value_12:
        Type = 0;
        Enemy_SetEnergy(5);
        Attack = 3;
        break;
}

Enemy_UpdateState(UnknownEnum.Value_0);

enum UnknownEnum
{
    Value_0,
    Value_2 = 2,
    Value_9 = 9,
    Value_12 = 12
}
