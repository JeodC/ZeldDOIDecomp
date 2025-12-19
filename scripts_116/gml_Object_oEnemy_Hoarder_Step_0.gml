event_inherited();

if (KnockBackDone || StunDone)
{
    Enemy_UpdateState(UnknownEnum.Value_3);
    Speed = AngrySpeed;
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
        if (WallCollide_X || WallCollide_Y)
        {
            Angle += (irandom_range(90, 180) * choose(1, -1));
            Angle = AngleCheck(Angle);
            Hoarder_UpdateDir();
        }
        
        var AngleDiff = angle_difference(ChargeAngle, Angle);
        Angle = (Angle + (irandom_range(RotateSpeed - 2, RotateSpeed + 2) * sign(AngleDiff))) % 360;
        Angle = AngleCheck(Angle);
        vx = lengthdir_x(Speed, Angle);
        vy = lengthdir_y(Speed, Angle);
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
