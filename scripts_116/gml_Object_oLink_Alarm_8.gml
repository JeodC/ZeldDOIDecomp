StopStar();

with (oLink)
    UpdateState(UnknownEnum.Value_1);

if (UncurseAfterStar)
{
    UncurseAfterStar = false;
    MsgBox("Task completed!\\You are now uncursed.", undefined, undefined, Curse_Done);
}

enum UnknownEnum
{
    Value_1 = 1
}
