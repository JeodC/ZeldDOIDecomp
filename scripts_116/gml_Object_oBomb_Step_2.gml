switch (State)
{
    case UnknownEnum.Value_2:
        if (!Red)
        {
            alarm[0] = -1;
            alarm[1] = -1;
            ObjSetImageSpeed(0);
            image_index = 0;
        }
        
        break;
    
    case UnknownEnum.Value_5:
        break;
}

if (BlowUp)
{
    var inst = instance_create_layer(ObjCenterX(), ObjCenterY(), "ObjsHigher_" + FloorLevelStr, oBombExplosion, 
    {
        FloorLevel: FloorLevel
    });
    
    if (Red)
        inst.MaxDamage = 4;
    
    if (oLink.ItemHolding == id)
    {
        with (oLink)
        {
            ItemHolding = -4;
            UpdateState(UnknownEnum.Value_1);
        }
    }
    
    instance_destroy(id);
}

enum UnknownEnum
{
    Value_1 = 1,
    Value_2,
    Value_5 = 5
}
