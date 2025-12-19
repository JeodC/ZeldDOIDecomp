if (DB_Started)
{
    State = UnknownEnum.Value_2;
    
    if (!instance_exists(global.DB_Inst))
    {
        alarm[0] = 60;
        
        switch (Index)
        {
            case UnknownEnum.Value_1:
                if (DialogueSentence == 3)
                {
                    global.Paused = true;
                    var inst = instance_create_layer(x, y, "ObjsHigher_Upper", oItem_Rupee);
                    HoldUpItem(inst, UnknownEnum.Value_5);
                    GaveRupees = true;
                }
                
                break;
            
            case UnknownEnum.Value_0:
                if (global.DB_ExitCode == 1)
                {
                    global.Paused = true;
                    var inst = instance_create_layer(x, y, "ObjsHigher_Upper", oItem_Letter);
                    HoldUpItem(inst);
                    GaveLetter = true;
                }
                
                break;
            
            case UnknownEnum.Value_10:
                State = UnknownEnum.Value_0;
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
    Value_5 = 5,
    Value_10 = 10
}
