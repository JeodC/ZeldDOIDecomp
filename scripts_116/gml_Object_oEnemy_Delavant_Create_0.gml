event_inherited();
FloorLevelStr = GetFloorLevelString(FloorLevel);
Size = UnknownEnum.Value_3;
Index = choose(0, 1);
AllowSpawn = false;
KnockBackEnabled = false;
DirtInst = -4;
ShootDelay = 60;
ShootCounter = 0;
Visible = false;
SaveVariables = ["Index"];
Enemy_UpdateState(UnknownEnum.Value_0);

enum UnknownEnum
{
    Value_0,
    Value_3 = 3
}
