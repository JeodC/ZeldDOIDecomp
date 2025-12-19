event_inherited();
Size = UnknownEnum.Value_3;
Type = FlipCoin_Bin();
Speed = 1;
Enemy_UpdateState(choose(UnknownEnum.Value_2, UnknownEnum.Value_3, UnknownEnum.Value_3));
VX_Extra = 0;
VY_Extra = 0;
OpenMouth = false;
CanShoot = true;
SightDist = 196;
SightOffset = 2;
SaveVariables = ["Type"];

enum UnknownEnum
{
    Value_2 = 2,
    Value_3
}
