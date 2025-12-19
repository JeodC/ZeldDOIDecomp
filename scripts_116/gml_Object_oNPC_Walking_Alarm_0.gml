if (Prob(0.5))
{
    Dir = RandomDir();
    NPC_UpdateDir();
    alarm[0] = irandom_range(45, 75);
}
else
{
    NPC_UpdateState(UnknownEnum.Value_1);
}

enum UnknownEnum
{
    Value_1 = 1
}
