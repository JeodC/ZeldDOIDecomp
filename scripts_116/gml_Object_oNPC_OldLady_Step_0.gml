switch (State)
{
    case UnknownEnum.Value_0:
        if (Wake_Init)
        {
            alarm[0] = AniDelay;
            State = UnknownEnum.Value_1;
        }
        
        break;
    
    case UnknownEnum.Value_1:
        break;
    
    case UnknownEnum.Value_2:
        break;
    
    case UnknownEnum.Value_3:
    case UnknownEnum.Value_4:
    case UnknownEnum.Value_5:
}

if (TurningGrey && !global.Paused)
{
    TurningGreyAlpha += 0.0022;
    
    if (TurningGreyAlpha > 1)
        TurningGreyAlpha = 1;
}

if (DB_Init)
{
    global.DB_Inst = instance_create_layer(0, 0, "System", oDialogueBox);
    
    switch (State)
    {
        case UnknownEnum.Value_2:
            global.DB_Inst.Script = DB_Script_Awake;
            break;
        
        case UnknownEnum.Value_3:
            global.DB_Inst.Script = DB_Script_Letter;
            break;
        
        case UnknownEnum.Value_5:
            global.DB_Inst.Script = DB_Script_Farewell;
            break;
    }
    
    DB_Init = false;
    DB_Started = true;
}

if (DB_Started)
{
    if (!instance_exists(global.DB_Inst))
    {
        switch (State)
        {
            case UnknownEnum.Value_2:
                image_index = 1;
                
                if (global.DB_ExitCode == 1)
                {
                    DeliveredLetter = true;
                    Inventory_DeleteItemClass(UnknownEnum.Value_25);
                    var inst = ItemSpawn(UnknownEnum.Value_40, oLink.x, oLink.y, UnknownEnum.Value_3, UnknownEnum.Value_0, 1);
                    HoldUpItem(inst, UnknownEnum.Value_3);
                    alarm[1] = 90;
                    alarm[2] = 200;
                }
                else
                {
                    alarm[2] = 30;
                    Wake_Init = false;
                    Wake_HeadFrame = 0;
                    State = UnknownEnum.Value_0;
                }
                
                break;
            
            case UnknownEnum.Value_3:
                alarm[3] = 60;
                global.Paused = true;
                
                with (oLink)
                {
                    UpdateState(UnknownEnum.Value_0);
                    Facing = 3;
                    UpdateSprites();
                }
                
                break;
            
            case UnknownEnum.Value_5:
                break;
        }
        
        DB_Started = false;
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_25 = 25,
    Value_40 = 40
}
