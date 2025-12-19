function Skeleton_UpdateDir(arg0)
{
    Dir = arg0;
    HeadDir = Dir;
    Enemy_UpdateSprite(State);
    Enemy_UpdateV(WalkSpeed);
}
