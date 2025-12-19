event_inherited();

if (KnockBackDone || PushbackDone || StunDone)
{
    Enemy_UpdateState(UnknownEnum.Value_3);
    alarm[1] = 1;
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

switch (State)
{
    case UnknownEnum.Value_3:
        var _Speed = oLink.Cape ? 0 : Speed;
        var _RotateSpeed = oLink.Cape ? 0 : RotateSpeed;
        var AngleDiff = angle_difference(ChargeAngle, Angle);
        Angle = (Angle + (_RotateSpeed * sign(AngleDiff))) % 360;
        
        if (Angle < 0)
            Angle += 360;
        
        vx = lengthdir_x(_Speed, Angle);
        vy = lengthdir_y(_Speed, Angle);
        break;
}

enum UnknownEnum
{
    Value_3 = 3,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
