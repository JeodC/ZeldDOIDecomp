CanShock = !CanShock;

if (CanShock)
{
    vx = 0;
    vy = 0;
    Enemy_UpdateSprite(UnknownEnum.Value_14);
}
else
{
    Enemy_UpdateSprite(UnknownEnum.Value_3);
}

alarm[0] = irandom_range(120, 200);

enum UnknownEnum
{
    Value_3 = 3,
    Value_14 = 14
}
