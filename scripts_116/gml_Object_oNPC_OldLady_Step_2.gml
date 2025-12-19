if (!DB_Started && State == UnknownEnum.Value_3 && oLink.State != UnknownEnum.Value_0 && !global.Paused)
{
    global.Paused = true;
    
    with (oLink)
    {
        UpdateState(UnknownEnum.Value_0);
        Facing = 3;
        UpdateSprites();
    }
}

enum UnknownEnum
{
    Value_0,
    Value_3 = 3
}
