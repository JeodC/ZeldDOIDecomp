if (DB_Init_Child)
{
    NPC_UpdateState(UnknownEnum.Value_0);
    image_index = 0;
    Dir = DirFaceLink();
    NPC_UpdateDir();
    DB_Init_Child = false;
    DB_Started_Child = true;
    DB_InitDone = true;
    exit;
}

if (DB_Started_Child)
{
    if (!instance_exists(global.DB_Inst))
    {
        DB_Started_Child = false;
        NPC_UpdateState(UnknownEnum.Value_0);
        alarm[0] = irandom_range(45, 75);
    }
}

if (CanPauseObj)
{
    if (global.Paused)
    {
        ObjPause();
        exit;
    }
    else
    {
        image_speed = LastImageSpeed;
    }
}

switch (State)
{
    case UnknownEnum.Value_1:
        x += vx;
        y += vy;
        var DestX = PathX[Path[PathIndex_To]];
        var DestY = PathY[Path[PathIndex_To]];
        
        if ((vx > 0 && x >= DestX) || (vx < 0 && x <= DestX) || (vy > 0 && y >= DestY) || (vy < 0 && y <= DestY))
        {
            x = DestX;
            y = DestY;
            NPC_SetNextPathIndex();
            NPC_UpdateState(UnknownEnum.Value_0);
            alarm[0] = irandom_range(45, 75);
        }
        
        break;
}

enum UnknownEnum
{
    Value_0,
    Value_1
}
