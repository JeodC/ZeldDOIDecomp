if (global.Paused)
    exit;

if (State == UnknownEnum.Value_3)
    Angle = (Angle + RotSpeed) % 360;

Gurus_Update();

enum UnknownEnum
{
    Value_3 = 3
}
