event_inherited();
var _KnockBackOrStun = KnockBackDone || StunDone;

if (_KnockBackOrStun || ShockDone)
{
    CanShock = false;
    Enemy_UpdateState(UnknownEnum.Value_3);
    
    if (_KnockBackOrStun)
        alarm[0] = 25;
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

if (!CanShock)
{
    CircleA = (CircleA + (CircleDir * CircleV)) % 360;
    vx = lengthdir_x(Speed, (CircleA + 90) % 360);
    vy = lengthdir_y(Speed, (CircleA + 90) % 360);
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
