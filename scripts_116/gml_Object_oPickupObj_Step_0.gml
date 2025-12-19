if (global.Paused)
    exit;

DrawShadow = false;

switch (State)
{
    case UnknownEnum.Value_0:
        DrawShadow = ShadowAtRest;
        break;
    
    case UnknownEnum.Value_1:
        PickupObj_RevealContents();
        FloorLevel = oLink.FloorLevel;
        FloorLevelStr = GetFloorLevelString(FloorLevel);
        layer = layer_get_id("ObjsHigher_" + FloorLevelStr);
        audio_play_sound(Sound_Pickup, 1, false);
        State = UnknownEnum.Value_2;
        break;
    
    case UnknownEnum.Value_3:
        PickupObj_InitThrow();
        x = oLink.x;
        ObjSetY(oLink.y - 1);
        
        switch (oLink.Facing)
        {
            case 1:
                vy = -Speed;
                break;
            
            case 2:
                vy = Speed;
                break;
            
            case 3:
                vx = -Speed;
                break;
            
            case 4:
                vx = Speed;
                break;
        }
        
        FloorLevel = oLink.FloorLevel;
        FloorLevelStr = GetFloorLevelString(FloorLevel);
        layer = layer_get_id("ObjsHigher_" + FloorLevelStr);
        
        if (object_index == oBomb)
        {
            if (!Red)
                alarm[0] = 40;
        }
        
        audio_play_sound(Sound_Throw, 1, false);
        break;
    
    case UnknownEnum.Value_4:
        if (DestroyedByExitRoom && Dungeon_GetRoomIndex(x, y_base) != RoomIndex)
        {
            State = UnknownEnum.Value_0;
            instance_destroy(id);
            exit;
        }
        
        vz += g;
        z += vz;
        x += vx;
        ObjSetY(y_base + vy);
        DrawShadow = true;
        var CollisionInst = CheckProjectileCollision(FloorLevel);
        
        if (CollisionInst != -4)
        {
            if (DestroyOnContact)
            {
                State = UnknownEnum.Value_5;
                break;
            }
        }
        
        if (Item_OverHole() && z <= 1)
        {
            Item_FallInHole();
            exit;
        }
        
        if (Item_CheckPondWater())
            exit;
        
        Item_CheckFloorLevelSwitch();
        
        if (Bounces > 0 && z <= 0)
        {
            z = 0;
            
            if (DestroyOnContact)
            {
                State = UnknownEnum.Value_5;
                break;
            }
            
            vx /= 3;
            vy /= 3;
            vz = Bounces * 0.5;
            Bounces--;
            
            if (Bounces <= 0)
            {
                Bounces = 0;
                vx = 0;
                vy = 0;
                State = UnknownEnum.Value_6;
                layer = layer_get_id("Objs_" + FloorLevelStr);
                mask_index = sprite_index;
                break;
            }
        }
        
        if (!WallCollided && CheckWallCollide)
        {
            var WallInst = instance_place(x, y_base, oWall);
            
            if (WallInst != -4)
            {
                if (WallInst.BlockItems && (FloorLevel == WallInst.FloorLevel || (FloorLevel == 0 && WallInst.FloorLevel == 1) || WallInst.FloorLevel == 2))
                {
                    var _HitSpeed = sqrt(abs(vx) + abs(vy)) * 0.8;
                    
                    if (WallInst.Position == 3)
                    {
                        vx = _HitSpeed * ((vx < 0) ? WallBounceFactor : 1);
                        vy = 0;
                    }
                    else if (WallInst.Position == 4)
                    {
                        vx = -_HitSpeed * ((vx > 0) ? WallBounceFactor : 1);
                        vy = 0;
                    }
                    else if (WallInst.Position == 1)
                    {
                        vy = _HitSpeed * ((vy < 0) ? WallBounceFactor : 1);
                        vx = 0;
                    }
                    else if (WallInst.Position == 2)
                    {
                        vy = -_HitSpeed * ((vy > 0) ? WallBounceFactor : 1);
                        vx = 0;
                    }
                    else if (WallInst.Position == 6)
                    {
                        vx = _HitSpeed;
                        vy = _HitSpeed;
                    }
                    else if (WallInst.Position == 7)
                    {
                        vx = -_HitSpeed;
                        vy = _HitSpeed;
                    }
                    else if (WallInst.Position == 8)
                    {
                        vx = _HitSpeed;
                        vy = -_HitSpeed;
                    }
                    else if (WallInst.Position == 9)
                    {
                        vx = -_HitSpeed;
                        vy = -_HitSpeed;
                    }
                    else if (WallInst.Position == 0)
                    {
                        vx *= -WallBounceFactor;
                        vy *= -WallBounceFactor;
                    }
                    
                    WallCollided = true;
                    
                    if (DestroyOnContact)
                    {
                        State = UnknownEnum.Value_5;
                        break;
                    }
                }
            }
        }
        
        break;
    
    case UnknownEnum.Value_6:
        DrawShadow = ShadowAtRest;
        break;
}

PickupObj_CheckRoomIndex();

switch (State)
{
    default:
        Item_CheckWater();
        break;
    
    case UnknownEnum.Value_1:
    case UnknownEnum.Value_2:
    case UnknownEnum.Value_3:
        exit;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6
}
