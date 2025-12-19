event_inherited();

if (KnockBackDone || StunDone)
{
    Dir = DirFaceLink();
    Enemy_UpdateState(UnknownEnum.Value_7);
}

if (global.Paused || State == UnknownEnum.Value_10 || State == UnknownEnum.Value_11 || State == UnknownEnum.Value_13 || State == UnknownEnum.Value_15 || State == UnknownEnum.Value_16 || State == UnknownEnum.Value_17)
{
    ObjPause();
    exit;
}
else
{
    image_speed = LastImageSpeed;
}

switch (State)
{
    case UnknownEnum.Value_3:
        if (WallCollide_X)
            Octorok_UpdateDir((Dir == 3) ? 4 : 3);
        
        if (WallCollide_Y)
            Octorok_UpdateDir((Dir == 1) ? 2 : 1);
        
        break;
}

enum UnknownEnum
{
    Value_3 = 3,
    Value_7 = 7,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
