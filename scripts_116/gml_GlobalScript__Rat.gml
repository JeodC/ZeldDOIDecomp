function Rat_UpdateDir(arg0)
{
    Dir = arg0;
    Enemy_UpdateSprite(State);
    Enemy_UpdateV(WalkSpeed);
    alarm[0] = irandom_range(30, 120);
}
