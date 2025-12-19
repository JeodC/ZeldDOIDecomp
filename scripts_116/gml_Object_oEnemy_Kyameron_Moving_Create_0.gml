event_inherited();
Speed = 1.5;
vx = choose(-1, 1) * Speed;
vy = choose(-1, 1) * Speed;
WallCollide_Bounce = true;
TMID = (FloorLevel == 1) ? global.TMID_Water_Upper : global.TMID_Water_Lower;
Timeout = false;
ParentInst = -4;
SparkleDelay = 8;
Hit_PlaySound = false;
alarm[1] = SparkleDelay;
Enemy_UpdateState(UnknownEnum.Value_3);

enum UnknownEnum
{
    Value_3 = 3
}
