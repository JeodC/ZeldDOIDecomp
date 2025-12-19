event_inherited();
Size = UnknownEnum.Value_2;
WalkSpeed = 1;
JumpSpeed = 2.5;
KnockBackV = JumpSpeed + 0.25;
Gravity = -0.175;
KnockBackTimeLen = 24;
KnockBackIgnoreZRule = true;
Type = FlipCoin_Bin();
Dir = RandomDir();
NextDir = Dir;
HeadDir = Dir;
Shoot = false;
WalkingLayer = layer;
SaveVariables = ["Type"];
Enemy_UpdateState(choose(UnknownEnum.Value_2, UnknownEnum.Value_3));

enum UnknownEnum
{
    Value_2 = 2,
    Value_3
}
