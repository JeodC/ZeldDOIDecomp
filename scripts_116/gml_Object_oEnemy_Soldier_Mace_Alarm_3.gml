if (oLink.Cape)
{
    Enemy_UpdateState(UnknownEnum.Value_2);
    exit;
}

Enemy_UpdateState((distance_to_object(oLink) <= SpinStartDist) ? UnknownEnum.Value_7 : UnknownEnum.Value_3);

enum UnknownEnum
{
    Value_2 = 2,
    Value_3,
    Value_7 = 7
}
