Wake_HeadFrame++;
image_index = Wake_HeadFrames[Wake_HeadFrame];

if (Wake_HeadFrame < (array_length(Wake_HeadFrames) - 1))
{
    alarm[0] = AniDelay;
}
else
{
    State = UnknownEnum.Value_2;
    DB_Init = true;
}

enum UnknownEnum
{
    Value_2 = 2
}
