if (DB_Init)
{
    global.DB_Inst = instance_create_layer(0, 0, "System", oDialogueBox);
    global.DB_Inst.Script = DB_Script;
    DB_Init = false;
    DB_Started = true;
}

if (DB_Started && alarm[0] == -1)
{
    if (!instance_exists(global.DB_Inst))
    {
        switch (global.CurseEffect)
        {
            case UnknownEnum.Value_5:
                oLink.alarm[3] = global.CurseHealthDrainDelay;
                break;
            
            case UnknownEnum.Value_9:
            case UnknownEnum.Value_10:
                Link_UpdateAttackDefence();
                break;
            
            case UnknownEnum.Value_12:
                with (oEnemy)
                {
                    var _Damage = EnergyMax - Energy;
                    Enemy_SetEnergy(EnergyIndex);
                    Energy -= _Damage;
                }
                
                break;
        }
        
        instance_destroy(id);
    }
}

enum UnknownEnum
{
    Value_5 = 5,
    Value_9 = 9,
    Value_10,
    Value_12 = 12
}
