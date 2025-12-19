if (StopWatch)
    exit;

Enemy_ShootRedBall(x, y);
ShootCounter++;

if (ShootCounter >= 3)
    Enemy_UpdateState(UnknownEnum.Value_8);
else
    alarm[2] = ShootDelay;

enum UnknownEnum
{
    Value_8 = 8
}
