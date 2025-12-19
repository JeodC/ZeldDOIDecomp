event_inherited();

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
        break;
    
    case UnknownEnum.Value_5:
        if (image_index >= (image_number - 0.25))
        {
            Enemy_UpdateState(UnknownEnum.Value_0);
            var MovingInst = instance_create_layer(x, y, layer, oEnemy_Kyameron_Moving, 
            {
                RoomIndex: RoomIndex,
                FloorLevel: FloorLevel,
                ItemHolding: -1
            });
            MovingInst.ParentInst = self;
            MovingInst.alarm[0] = MovingTime;
        }
        
        break;
}

enum UnknownEnum
{
    Value_0,
    Value_5 = 5,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
