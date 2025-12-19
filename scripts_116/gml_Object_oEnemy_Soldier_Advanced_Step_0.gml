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
    case UnknownEnum.Value_2:
        if (Enemy_LinkInSight(HeadDir, SightOffset, SightDist))
            Enemy_UpdateState(UnknownEnum.Value_9);
        
        break;
    
    case UnknownEnum.Value_3:
        if (WallCollide_X)
        {
            Soldier_UpdateDir(Enemy_WallCollisionNewDir(1));
            Soldier_UpdateWeaponSprite();
        }
        
        if (WallCollide_Y)
        {
            Soldier_UpdateDir(Enemy_WallCollisionNewDir(2));
            Soldier_UpdateWeaponSprite();
        }
        
        if (Enemy_LinkInSight(HeadDir, SightOffset, SightDist))
            Enemy_UpdateState(UnknownEnum.Value_9);
        
        break;
    
    case UnknownEnum.Value_4:
        if (oLink.Cape)
        {
            Enemy_UpdateState(UnknownEnum.Value_2);
            break;
        }
        
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
                alarm[1] = StrafeTime;
        }
        
        var _UpdateDir = false;
        
        if (Strafe)
        {
            switch (StrafeDir)
            {
                case 3:
                    if (WallCollide_Y)
                    {
                        if (WallCollide_X)
                        {
                            StrafeDir = 4;
                            vx = RunSpeed;
                        }
                        
                        vy = (Dir == 2) ? RunSpeed : -RunSpeed;
                    }
                    else
                    {
                        _UpdateDir = true;
                    }
                    
                    break;
                
                case 4:
                    if (WallCollide_Y)
                    {
                        if (WallCollide_X)
                        {
                            StrafeDir = 3;
                            vx = -RunSpeed;
                        }
                        
                        vy = (Dir == 2) ? RunSpeed : -RunSpeed;
                    }
                    else
                    {
                        _UpdateDir = true;
                    }
                    
                    break;
                
                case 1:
                    if (WallCollide_X)
                    {
                        if (WallCollide_Y)
                        {
                            StrafeDir = 2;
                            vy = RunSpeed;
                        }
                        
                        vx = (Dir == 4) ? RunSpeed : -RunSpeed;
                    }
                    else
                    {
                        _UpdateDir = true;
                    }
                    
                    break;
                
                case 2:
                    if (WallCollide_X)
                    {
                        if (WallCollide_Y)
                        {
                            StrafeDir = 1;
                            vy = -RunSpeed;
                        }
                        
                        vx = (Dir == 4) ? RunSpeed : -RunSpeed;
                    }
                    else
                    {
                        _UpdateDir = true;
                    }
                    
                    break;
            }
            
            switch (Dir)
            {
                case 1:
                    if (y < oLink.y)
                        _UpdateDir = true;
                    
                    break;
                
                case 2:
                    if (y > oLink.y)
                        _UpdateDir = true;
                    
                    break;
                
                case 3:
                    if (x < oLink.x)
                        _UpdateDir = true;
                    
                    break;
                
                case 4:
                    if (x > oLink.x)
                        _UpdateDir = true;
                    
                    break;
            }
            
            if (_UpdateDir)
                Soldier_Advanced_UpdateRunningDir();
        }
        
        break;
}

switch (Dir)
{
    case 3:
    case 4:
        InWaterSprW = 20;
        break;
    
    case 1:
    case 2:
        InWaterSprW = 22;
        break;
}

enum UnknownEnum
{
    Value_2 = 2,
    Value_3,
    Value_4,
    Value_9 = 9,
    Value_10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
