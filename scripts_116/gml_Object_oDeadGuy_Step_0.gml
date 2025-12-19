if (DB_Init)
{
    global.DB_Inst = instance_create_layer(0, 0, "System", oDialogueBox);
    global.DB_Inst.Script = DB_Script;
    DB_Init = false;
    DB_Started = true;
}

if (DB_Started)
{
    if (!instance_exists(global.DB_Inst))
    {
        if (global.DB_ExitCode == 1)
        {
            global.Paused = true;
            
            if (!global.Cursed && Prob(global.Challenges[UnknownEnum.Value_6] ? (0.4 + (global.Level.Index * 0.005)) : (0.2 + (global.Level.Index * 0.005))) && ItemHolding != UnknownEnum.Value_20)
            {
                var CursedInst = instance_create_layer(x, y - 18, "ObjsHighest", oCursed);
            }
            else
            {
                var inst = instance_create_layer(x, y, "ObjsHigher_Upper", ObjIndexFromItemClass(ItemHolding), 
                {
                    From: UnknownEnum.Value_2
                });
                
                if (Item_Valid(inst.Class, inst.Index))
                {
                    if (inst.object_index == oItem_Pendant && inst.Index == UnknownEnum.Value_3)
                    {
                        instance_destroy(inst);
                        inst = instance_create_layer(x, y, "ObjsHigher_Upper", oItem_Magic_Large);
                    }
                    
                    HoldUpItem(inst);
                }
                else
                {
                    instance_destroy(inst);
                    MsgBox("Nothing was found.");
                }
            }
            
            ItemHolding = -1;
        }
        
        DB_Started = false;
    }
}

enum UnknownEnum
{
    Value_2 = 2,
    Value_3,
    Value_6 = 6,
    Value_20 = 20
}
