if (!OnWaterTile(TMID, x + vx, y))
    vx = 0;

if (!OnWaterTile(TMID, x, y + vy))
    vy = 0;

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
    case UnknownEnum.Value_3:
        Speed -= SlowdownSpeed;
        
        if (Speed <= 0)
        {
            Speed = 0;
            Enemy_UpdateState(UnknownEnum.Value_2);
        }
        else
        {
            vx = lengthdir_x(Speed, Dir);
            vy = lengthdir_y(Speed, Dir);
        }
        
        break;
}

enum UnknownEnum
{
    Value_2 = 2,
    Value_3,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
