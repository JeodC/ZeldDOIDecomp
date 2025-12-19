event_inherited();

if (KnockBackDone)
{
    Enemy_UpdateState(oBoss_Armos_C.State);
    
    switch (oBoss_Armos_C.State)
    {
        case UnknownEnum.Value_5:
            Armos_Waypoints_Calculate(id);
            break;
        
        case UnknownEnum.Value_7:
            vx = 0;
            vy = 0;
            Hit_Allowed = false;
            CanHurtLink = false;
            break;
    }
}

if (PreDestroyed)
{
    oBoss_Armos_C.ArmosStatus[ID] = false;
    oBoss_Armos_C.ArmosLeft--;
    oBoss_Armos_C.LastArmos_X = x;
    oBoss_Armos_C.LastArmos_Y = y_base;
    
    if (oBoss_Armos_C.ArmosLeft == 1)
    {
        with (oBoss_Armos)
        {
            if (oBoss_Armos_C.ArmosStatus[ID])
            {
                Enemy_SetEnergy(global.EnemyData[object_index].EnergyIndex);
                oBoss_Armos_C.LastArmos_Inst = id;
                image_index = 1;
                break;
            }
        }
    }
    
    if (oBoss_Armos_C.ArmosLeft <= 0)
    {
        with (oCape)
            instance_destroy(id);
    }
    
    PreDestroyed = false;
}

if (global.Paused || State == UnknownEnum.Value_10 || State == UnknownEnum.Value_11 || State == UnknownEnum.Value_13 || State == UnknownEnum.Value_15 || State == UnknownEnum.Value_16 || State == UnknownEnum.Value_17)
{
    ObjPause();
    exit;
}
else
{
    image_speed = LastImageSpeed;
}

enum UnknownEnum
{
    Value_5 = 5,
    Value_7 = 7,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
