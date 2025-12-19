event_inherited();

if (Hit_Started)
    Dir = point_direction(0, 0, vx, vy);

if (point_distance(BodyX, BodyY, x, y) > 9)
{
    var Angle = point_direction(x, y, BodyX, BodyY);
    BodyX = x + lengthdir_x(9, Angle);
    BodyY = y + lengthdir_y(9, Angle);
}

if (point_distance(TailX, TailY, BodyX, BodyY) > 7)
{
    var Angle = point_direction(BodyX, BodyY, TailX, TailY);
    TailX = BodyX + lengthdir_x(7, Angle);
    TailY = BodyY + lengthdir_y(7, Angle);
}

if (Destroyed)
    exit;

if (KnockBackDone || StunDone)
    Enemy_UpdateState(UnknownEnum.Value_3);

if (global.Paused || State == UnknownEnum.Value_10 || State == UnknownEnum.Value_11 || State == UnknownEnum.Value_13 || State == UnknownEnum.Value_15 || State == UnknownEnum.Value_16 || State == UnknownEnum.Value_17)
{
    ObjPause();
    exit;
}
else
{
    image_speed = LastImageSpeed;
}

if (WallCollide_X || WallCollide_Y)
    Dir = point_direction(0, 0, vx, vy);

switch (State)
{
    case UnknownEnum.Value_3:
        vx = lengthdir_x(Speed, Dir);
        vy = lengthdir_y(Speed, Dir);
        Dir = (Dir + (DirV * 5)) % 360;
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
