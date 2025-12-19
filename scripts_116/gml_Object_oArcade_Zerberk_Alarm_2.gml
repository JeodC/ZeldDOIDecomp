if (Lives == 0)
{
    State = UnknownEnum.Value_5;
    Arcade_Hiscore_Check(UnknownEnum.Value_1);
}
else
{
    Lives--;
    Zerberk_Level_Reset();
}

enum UnknownEnum
{
    Value_1 = 1,
    Value_5 = 5
}
