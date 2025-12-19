event_inherited();
Size = UnknownEnum.Value_1;
Color = FlipCoin_Bin();
Speed = 0.5 + (Color * 0.25);
InitialWakeDone = false;
Enemy_UpdateState(UnknownEnum.Value_0);
alarm[0] = irandom_range(45, 180);

enum UnknownEnum
{
    Value_0,
    Value_1
}
