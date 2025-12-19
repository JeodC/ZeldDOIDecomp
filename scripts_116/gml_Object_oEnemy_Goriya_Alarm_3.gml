Goriya_UpdateDir(RandomDir());
Enemy_UpdateState((State == UnknownEnum.Value_2) ? UnknownEnum.Value_3 : choose(UnknownEnum.Value_2, UnknownEnum.Value_3, UnknownEnum.Value_3));

enum UnknownEnum
{
    Value_2 = 2,
    Value_3
}
