if (global.Paused)
    exit;

if (OutsideDestroyed)
    exit;

if (!WallCollideDelay)
{
    var WallInst = instance_place(x, y_base, oWall);
    
    if (WallInst != -4)
    {
        var _WallCollide = true;
        
        switch (WallInst.GID)
        {
            case UnknownEnum.Value_28:
            case UnknownEnum.Value_32:
                if (y >= (WallInst.y + WallInst.sprite_height) || vy == 0)
                    _WallCollide = false;
                
                break;
            
            case UnknownEnum.Value_25:
            case UnknownEnum.Value_29:
                if (y <= WallInst.y || vy == 0)
                    _WallCollide = false;
                
                break;
            
            case UnknownEnum.Value_26:
            case UnknownEnum.Value_30:
                if (x >= (WallInst.x + WallInst.sprite_width) || vx == 0)
                    _WallCollide = false;
                
                break;
            
            case UnknownEnum.Value_27:
            case UnknownEnum.Value_31:
                if (x <= WallInst.x || vx == 0)
                    _WallCollide = false;
                
                break;
            
            case UnknownEnum.Value_15:
            case UnknownEnum.Value_23:
                if (x >= (WallInst.x + WallInst.sprite_width) || y >= (WallInst.y + WallInst.sprite_height))
                    _WallCollide = false;
                
                break;
            
            case UnknownEnum.Value_16:
            case UnknownEnum.Value_24:
                if (x <= WallInst.x || y >= (WallInst.y + WallInst.sprite_height))
                    _WallCollide = false;
                
                break;
            
            case UnknownEnum.Value_13:
            case UnknownEnum.Value_21:
                if (x >= (WallInst.x + WallInst.sprite_width) || y <= WallInst.y)
                    _WallCollide = false;
                
                break;
            
            case UnknownEnum.Value_14:
            case UnknownEnum.Value_22:
                if (x <= WallInst.x || y <= WallInst.y)
                    _WallCollide = false;
                
                break;
        }
        
        if (_WallCollide && (FloorLevel == WallInst.FloorLevel || WallInst.FloorLevel == 2) && WallInst.BlockProjectiles)
        {
            WallCollideDelay = true;
            
            if ((object_index == oPot && vy > 0) || object_index == oBone)
                alarm[10] = 5;
            else if (object_index == oArrow)
                alarm[10] = 1;
            else
                alarm[10] = 2;
        }
    }
}

if (OutsideRoomDestroy)
{
    if (!point_in_rectangle(x, y, global.CurrentRoom.x + 20, global.CurrentRoom.y + 20, (global.CurrentRoom.x + global.CurrentRoom.width) - 21, (global.CurrentRoom.y + global.CurrentRoom.height) - 21))
    {
        OutsideDestroyed = true;
        instance_destroy(id);
    }
}

if (OutsideCameraDestroy)
{
    if (!point_in_rectangle(x, y, oCamera.X - 16, oCamera.Y - 16, oCamera.X2 + 16, oCamera.Y2 + 16))
    {
        OutsideDestroyed = true;
        instance_destroy(id);
    }
}

enum UnknownEnum
{
    Value_13 = 13,
    Value_14,
    Value_15,
    Value_16,
    Value_21 = 21,
    Value_22,
    Value_23,
    Value_24,
    Value_25,
    Value_26,
    Value_27,
    Value_28,
    Value_29,
    Value_30,
    Value_31,
    Value_32
}
