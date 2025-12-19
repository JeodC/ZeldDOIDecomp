event_inherited();

if (KnockBackDone || StunDone)
    Enemy_UpdateState(UnknownEnum.Value_8);

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
    case UnknownEnum.Value_1:
        Visible = !Visible;
        break;
    
    case UnknownEnum.Value_8:
        Visible = !Visible;
        break;
}

enum UnknownEnum
{
    Value_1 = 1,
    Value_8 = 8,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
