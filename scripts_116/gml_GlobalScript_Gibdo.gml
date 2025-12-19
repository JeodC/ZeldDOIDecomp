function Gibdo_UpdateDir(arg0)
{
    Dir = arg0;
    Enemy_UpdateSprite(State);
    Enemy_UpdateV(WalkSpeed);
}
