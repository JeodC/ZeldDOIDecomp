event_inherited();

switch (State)
{
    case UnknownEnum.Value_0:
        break;
    
    case UnknownEnum.Value_1:
        global.Arcade_ActiveInst = self;
        Arcade_SetCam(CamW, CamH);
        GameSurface = surface_create(RoomW, RoomH);
        State = UnknownEnum.Value_2;
        break;
    
    case UnknownEnum.Value_3:
        break;
    
    case UnknownEnum.Value_4:
        break;
    
    case UnknownEnum.Value_5:
        break;
    
    case UnknownEnum.Value_6:
        break;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6
}
