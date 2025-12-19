event_inherited();

if (KnockBackDone || PushbackDone || StunDone)
{
    Enemy_UpdateState(UnknownEnum.Value_4);
    Soldier_UpdateDir(DirFaceLink());
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
    case UnknownEnum.Value_4:
        if (!Strafe)
        {
            if (Dir == 1 || Dir == 2)
            {
                if (WallCollide_Y)
                {
                    if (x <= oLink.x)
                    {
                        StrafeDir = 4;
                        vx = RunSpeed;
                    }
                    else
                    {
                        StrafeDir = 3;
                        vx = -RunSpeed;
                    }
                    
                    Strafe = true;
                }
            }
            else if (Dir == 3 || Dir == 4)
            {
                if (WallCollide_X)
                {
                    if (y <= oLink.y)
                    {
                        StrafeDir = 2;
                        vy = RunSpeed;
                    }
                    else
                    {
                        StrafeDir = 1;
                        vy = -RunSpeed;
                    }
                    
                    Strafe = true;
                }
            }
            
            if (Strafe)
            {
                alarm[1] = StrafeTime;
                alarm[0] = -1;
            }
        }
        
        if (Strafe)
        {
            switch (StrafeDir)
            {
                case 3:
                    if (!WallCollide_Y)
                    {
                        Soldier_Advanced_UpdateRunningDir();
                        Strafe = false;
                    }
                    else
                    {
                        if (WallCollide_X)
                        {
                            StrafeDir = 4;
                            vx = RunSpeed;
                        }
                        
                        vy = (Dir == 2) ? RunSpeed : -RunSpeed;
                    }
                    
                    break;
                
                case 4:
                    if (!WallCollide_Y)
                    {
                        Soldier_Advanced_UpdateRunningDir();
                        Strafe = false;
                    }
                    else
                    {
                        if (WallCollide_X)
                        {
                            StrafeDir = 3;
                            vx = -RunSpeed;
                        }
                        
                        vy = (Dir == 2) ? RunSpeed : -RunSpeed;
                    }
                    
                    break;
                
                case 1:
                    if (!WallCollide_X)
                    {
                        Soldier_Advanced_UpdateRunningDir();
                        Strafe = false;
                    }
                    else
                    {
                        if (WallCollide_Y)
                        {
                            StrafeDir = 2;
                            vy = RunSpeed;
                        }
                        
                        vx = (Dir == 4) ? RunSpeed : -RunSpeed;
                    }
                    
                    break;
                
                case 2:
                    if (!WallCollide_X)
                    {
                        Soldier_Advanced_UpdateRunningDir();
                        Strafe = false;
                    }
                    else
                    {
                        if (WallCollide_Y)
                        {
                            StrafeDir = 1;
                            vy = -RunSpeed;
                        }
                        
                        vx = (Dir == 4) ? RunSpeed : -RunSpeed;
                    }
                    
                    break;
            }
        }
        
        break;
}

enum UnknownEnum
{
    Value_4 = 4,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
