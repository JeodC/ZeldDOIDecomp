event_inherited();

if (KnockBackDone)
{
    Enemy_UpdateState(UnknownEnum.Value_7);
    
    if (WeaponInst.Spin)
    {
        alarm[2] -= 20;
        
        if (alarm[2] <= 1)
        {
            if (!WeaponInst.SpinExtend && !WeaponInst.SpinContract)
                WeaponInst.SpinExtend = true;
            
            alarm[2] = -1;
        }
    }
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
        if (!oLink.Cape && distance_to_object(oLink) <= LinkNotVisibleDist)
        {
            Enemy_UpdateState(UnknownEnum.Value_3);
            Soldier_UpdateDir(DirFaceLink());
        }
        
        break;
    
    case UnknownEnum.Value_7:
        if (!oLink.Cape)
            Soldier_UpdateDir(DirFaceLink());
        
        break;
    
    case UnknownEnum.Value_3:
        if (oLink.Cape)
        {
            Enemy_UpdateState(UnknownEnum.Value_2);
            break;
        }
        
        if (SpinAllowed && distance_to_object(oLink) <= SpinStartDist)
        {
            Enemy_UpdateState(UnknownEnum.Value_7);
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
                        vx = WalkSpeed;
                    }
                    else
                    {
                        StrafeDir = 3;
                        vx = -WalkSpeed;
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
                        vy = WalkSpeed;
                    }
                    else
                    {
                        StrafeDir = 1;
                        vy = -WalkSpeed;
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
                        Soldier_Advanced_UpdateRunningDir(false);
                        Strafe = false;
                    }
                    else
                    {
                        if (WallCollide_X)
                        {
                            StrafeDir = 4;
                            vx = WalkSpeed;
                        }
                        
                        vy = (Dir == 2) ? WalkSpeed : -WalkSpeed;
                    }
                    
                    break;
                
                case 4:
                    if (!WallCollide_Y)
                    {
                        Soldier_Advanced_UpdateRunningDir(false);
                        Strafe = false;
                    }
                    else
                    {
                        if (WallCollide_X)
                        {
                            StrafeDir = 3;
                            vx = -WalkSpeed;
                        }
                        
                        vy = (Dir == 2) ? WalkSpeed : -WalkSpeed;
                    }
                    
                    break;
                
                case 1:
                    if (!WallCollide_X)
                    {
                        Soldier_Advanced_UpdateRunningDir(false);
                        Strafe = false;
                    }
                    else
                    {
                        if (WallCollide_Y)
                        {
                            StrafeDir = 2;
                            vy = WalkSpeed;
                        }
                        
                        vx = (Dir == 4) ? WalkSpeed : -WalkSpeed;
                    }
                    
                    break;
                
                case 2:
                    if (!WallCollide_X)
                    {
                        Soldier_Advanced_UpdateRunningDir(false);
                        Strafe = false;
                    }
                    else
                    {
                        if (WallCollide_Y)
                        {
                            StrafeDir = 1;
                            vy = -WalkSpeed;
                        }
                        
                        vx = (Dir == 4) ? WalkSpeed : -WalkSpeed;
                    }
                    
                    break;
            }
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
    Value_7 = 7,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
