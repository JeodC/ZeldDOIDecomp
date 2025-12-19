event_inherited();
Size = UnknownEnum.Value_2;
WallCollide_Bounce = true;
Dir = irandom(360);
DirV = 0;
Speed = 1.5;
OldX = x;
OldY = y;
BodyX = x;
BodyY = y;
TailX = x;
TailY = y;
Enemy_UpdateState(UnknownEnum.Value_3);
alarm[0] = irandom_range(20, 40);

enum UnknownEnum
{
    Value_2 = 2,
    Value_3
}
