function Rope_UpdateDir(arg0)
{
    Dir = arg0;
    Enemy_UpdateSprite(State);
    Enemy_UpdateV((State == UnknownEnum.Value_3) ? WalkSpeed : RunSpeed);
    alarm[0] = irandom_range(30, 120);
}

enum UnknownEnum
{
    Value_3 = 3
}
