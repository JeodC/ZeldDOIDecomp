if (global.Paused)
    exit;

if (State == UnknownEnum.Value_19)
    exit;

UpdateState(UnknownEnum.Value_11);
var Walls = ds_list_size(CollidedWallList);
var WallsTouchingList = ds_list_create();
var WallInst;

if (Walls > 1)
{
    var W = 10;
    var WallsTouching;
    
    switch (Facing)
    {
        case 3:
            WallsTouching = collision_rectangle_list(bbox_left - 4, bbox_top + W, bbox_left, bbox_bottom - W, oPushBlock, false, true, WallsTouchingList, false);
            break;
        
        case 4:
            WallsTouching = collision_rectangle_list(bbox_right, bbox_top + W, bbox_right + 4, bbox_bottom - W, oPushBlock, false, true, WallsTouchingList, false);
            break;
        
        case 1:
            WallsTouching = collision_rectangle_list(bbox_left + W, bbox_top - 4, bbox_right - W, bbox_top, oPushBlock, false, true, WallsTouchingList, false);
            break;
        
        case 2:
            WallsTouching = collision_rectangle_list(bbox_left + W, bbox_bottom, bbox_right - W, bbox_bottom + 4, oPushBlock, false, true, WallsTouchingList, false);
            break;
    }
    
    if (WallsTouching != 1)
    {
        ds_list_destroy(WallsTouchingList);
        exit;
    }
    else
    {
        WallInst = ds_list_find_value(WallsTouchingList, 0);
    }
}
else
{
    WallInst = ds_list_find_value(CollidedWallList, 0);
}

ds_list_destroy(WallsTouchingList);

if (!instance_exists(WallInst))
    exit;

if (WallInst.object_index == oPushBlock)
{
    var Allowed = Facing == WallInst.AllowedDir || WallInst.AllowedDir == 5;
    
    if (Allowed && !WallInst.Moved && !WallInst.Move_Start)
    {
        var WallCheckDistX = PushingDirX * 16;
        var WallCheckDistY = PushingDirY * 16;
        
        if (!collision_rectangle(WallInst.x + WallCheckDistX, WallInst.y + WallCheckDistY, WallInst.x + 15 + WallCheckDistX, WallInst.y + 15 + WallCheckDistY, oWall, false, true))
        {
            WallInst.Move_Start = true;
            WallInst.MoveX = PushingDirX * 0.75;
            WallInst.MoveY = PushingDirY * 0.75;
            ClearTileBlock(WallInst.TMID, WallInst.x, WallInst.y, 2, 2);
        }
    }
}

enum UnknownEnum
{
    Value_11 = 11,
    Value_19 = 19
}
