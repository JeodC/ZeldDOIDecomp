function Armos_Waypoints_Set()
{
    for (var i = 0; i < ArmosCount; i++)
    {
        if (instance_exists(ArmosInst[i]))
        {
            if (ArmosInst[i].Energy > 0)
            {
                ArmosInst[i].CircleAngle = CircleAngleStart[i];
                ArmosInst[i].WaypointX = Armos_ClampWaypointX(WaypointsX[WaypointScriptIndex][i]);
                ArmosInst[i].WaypointY = Armos_ClampWaypointY(WaypointsY[WaypointScriptIndex][i]);
                Armos_Waypoints_Calculate(ArmosInst[i]);
            }
        }
    }
    
    CircleRotate = false;
    CircleExpand = false;
    alarm[0] = ds_grid_get(WaypointScript, 1, WaypointScriptIndex);
    
    if (WaypointScriptIndex == UnknownEnum.Value_0)
        alarm[3] = 220;
}

function Armos_Waypoints_Calculate(arg0)
{
    var D = point_direction(arg0.x, arg0.y_base, arg0.WaypointX, arg0.WaypointY);
    arg0.vx = lengthdir_x(oBoss_Armos_C.MoveSpeed, D);
    arg0.vy = lengthdir_y(oBoss_Armos_C.MoveSpeed, D);
}

function Armos_MoveToWaypoint(arg0)
{
    with (arg0)
    {
        if (x != WaypointX || y_base != WaypointY)
        {
            if (vx != 0)
            {
                if ((vx > 0 && (x + vx) >= WaypointX) || (vx < 0 && (x + vx) <= WaypointX))
                {
                    x = WaypointX;
                    vx = 0;
                }
            }
            
            if (vy != 0)
            {
                if ((vy > 0 && (y_base + vy) >= WaypointY) || (vy < 0 && (y_base + vy) <= WaypointY))
                {
                    ObjSetY(WaypointY);
                    vy = 0;
                }
            }
        }
        
        return x == WaypointX && y_base == WaypointY;
    }
}

function Armos_Last_JumpInit(arg0)
{
    with (arg0)
    {
        WaypointX = Armos_ClampWaypointX(oLink.x);
        WaypointY = Armos_ClampWaypointY(oLink.y);
        var Dir = point_direction(x, y_base, WaypointX, WaypointY);
        var Dist = point_distance(x, y_base, WaypointX, WaypointY);
        vx = lengthdir_x(Dist, Dir) / oBoss_Armos_C.LastArmos_JumpTime;
        vy = lengthdir_y(Dist, Dir) / oBoss_Armos_C.LastArmos_JumpTime;
        oBoss_Armos_C.vz = oBoss_Armos_C.LastArmos_VZ_Jump;
        oBoss_Armos_C.LastArmos_Jump = true;
    }
}

function Armos_ClampWaypointX(arg0)
{
    return clamp(arg0, RoomX + 56, RoomX + 200);
}

function Armos_ClampWaypointY(arg0)
{
    return clamp(arg0, RoomY + 64, RoomY + 208);
}

enum UnknownEnum
{
    Value_0
}
