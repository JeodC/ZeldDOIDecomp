if (Init)
{
    Enemy_SetEnergy(global.EnemyData[object_index].EnergyIndex);
    Init = false;
}

switch (State)
{
    case UnknownEnum.Value_5:
        Armos_MoveToWaypoint(id);
        break;
}

enum UnknownEnum
{
    Value_5 = 5
}
