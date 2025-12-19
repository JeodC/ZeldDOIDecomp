Soldier_UpdateDir(HeadDir);
Enemy_UpdateState((Enemy_LinkInSight(Dir, SightOffset, SightDist) && CanShoot) ? UnknownEnum.Value_7 : UnknownEnum.Value_3);

enum UnknownEnum
{
    Value_3 = 3,
    Value_7 = 7
}
