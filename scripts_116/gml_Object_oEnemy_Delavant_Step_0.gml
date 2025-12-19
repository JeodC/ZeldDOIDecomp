event_inherited();

if (KnockBackDone || StunDone)
    Enemy_UpdateState(UnknownEnum.Value_7);

if (instance_exists(DirtInst))
    DirtInst.State = State;

if (global.Paused || State == UnknownEnum.Value_10 || State == UnknownEnum.Value_11 || State == UnknownEnum.Value_13 || State == UnknownEnum.Value_15 || State == UnknownEnum.Value_16 || State == UnknownEnum.Value_17)
{
    ObjPause();
    exit;
}
else
{
    image_speed = LastImageSpeed;
}

switch (State)
{
    case UnknownEnum.Value_0:
        if (AllowSpawn && distance_to_object(oLink) <= 48)
        {
            DirtInst = instance_create_layer(x, y, layer, oDelavantDirt);
            DirtInst.depth = depth + 5;
            alarm[0] = 80;
            AllowSpawn = false;
        }
        
        break;
    
    case UnknownEnum.Value_1:
        if (image_index >= (image_number - 0.1))
            Enemy_UpdateState(UnknownEnum.Value_7);
        
        break;
    
    case UnknownEnum.Value_7:
        break;
    
    case UnknownEnum.Value_8:
        if (image_index <= 0.1)
        {
            image_index = 0;
            Visible = false;
        }
        
        if (DirtInst.image_index <= 0.1)
        {
            instance_destroy(DirtInst);
            Enemy_UpdateState(UnknownEnum.Value_0);
        }
        
        break;
    
    case UnknownEnum.Value_15:
    case UnknownEnum.Value_16:
    case UnknownEnum.Value_17:
        DirtInst.image_speed = 0;
        break;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_7 = 7,
    Value_8,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
