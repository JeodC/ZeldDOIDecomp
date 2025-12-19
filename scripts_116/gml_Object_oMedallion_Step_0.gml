if (!global.Paused)
    global.Paused = true;

if (oLink.State != UnknownEnum.Value_0)
{
    with (oLink)
        UpdateState(UnknownEnum.Value_0);
}

enum UnknownEnum
{
    Value_0
}
