function NPC_UpdateState(arg0)
{
    State = arg0;
    
    switch (State)
    {
        case UnknownEnum.Value_0:
            image_index = 0;
            ObjSetImageSpeed(0);
            vx = 0;
            vy = 0;
            alarm[0] = -1;
            break;
        
        case UnknownEnum.Value_1:
            ObjSetImageSpeed(1);
            image_index ^= true;
            vx = sign(PathX[Path[PathIndex_To]] - PathX[Path[PathIndex_From]]) * PathSpeed;
            vy = sign(PathY[Path[PathIndex_To]] - PathY[Path[PathIndex_From]]) * PathSpeed;
            NPC_UpdateDir();
    }
}

function NPC_SetNextPathIndex()
{
    PathIndex_From = PathIndex_To;
    PathIndex_To = (PathIndex_To + 1) % PathNodes;
}

function NPC_UpdateDir()
{
    if (vx > 0)
        Dir = 4;
    else if (vx < 0)
        Dir = 3;
    else if (vy > 0)
        Dir = 2;
    else if (vy < 0)
        Dir = 1;
    
    switch (Dir)
    {
        case 1:
            if (SprUp > -1)
                sprite_index = SprUp;
            
            break;
        
        case 2:
            if (SprDown > -1)
                sprite_index = SprDown;
            
            break;
        
        case 3:
            if (SprLeft > -1)
                sprite_index = SprLeft;
            
            break;
        
        case 4:
            if (SprRight > -1)
                sprite_index = SprRight;
            
            break;
    }
}

function NPC_SetResponse(arg0)
{
    ResponseIndex = arg0;
    DB_Init = true;
    DB_Delay = true;
    alarm[0] = DB_Delay_Len;
    global.Paused = true;
    
    with (oLink)
        UpdateState(UnknownEnum.Value_0);
}

enum UnknownEnum
{
    Value_0,
    Value_1
}
