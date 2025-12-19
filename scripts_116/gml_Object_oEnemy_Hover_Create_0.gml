event_inherited();
Size = UnknownEnum.Value_0;
Speed_Initial = 2;
FacingDir = choose(-1, 1);
SlowdownSpeed = 0;
TMID = (FloorLevel == 1) ? global.TMID_Water_Upper : global.TMID_Water_Lower;
Enemy_UpdateState(UnknownEnum.Value_2);

enum UnknownEnum
{
    Value_0,
    Value_2 = 2
}
