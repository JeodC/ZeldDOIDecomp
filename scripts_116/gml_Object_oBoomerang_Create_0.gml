event_inherited();
Speed = 5;
v = 0;
FloorLevel = oLink.FloorLevel;
FloorLevelStr = GetFloorLevelString(FloorLevel);
Thrown = false;
HitEnemy = false;
Rot = 0;
SoundPaused = false;
SoundInst = -4;
ObjSetImageSpeed(0);
Flip = false;

switch (oLink.Facing)
{
    case 1:
        x = oLink.x - 9;
        ObjSetY(oLink.y - 16);
        Flip = true;
        break;
    
    case 2:
        x = oLink.x + 10;
        ObjSetY(oLink.y - 14);
        break;
    
    case 3:
        x = oLink.x + 7;
        ObjSetY(oLink.y - 15);
        break;
    
    case 4:
        x = oLink.x - 7;
        ObjSetY(oLink.y - 15);
        Flip = true;
        break;
}

x = floor(x);
ObjSetY(floor(y_base));
var keyUp = input_check("up");
var keyDown = input_check("down");
var keyLeft = input_check("left");
var keyRight = input_check("right");

if (!keyLeft && !keyRight && !keyUp && !keyDown)
{
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
}
else
{
    var x_dir = keyRight - keyLeft;
    var y_dir = keyDown - keyUp;
    var Dir = point_direction(x, y_base, x + x_dir, y_base + y_dir);
    var AdjustedSpeed = Speed + ((x_dir != 0 && y_dir != 0) ? 1.5 : 0);
    vx = lengthdir_x(AdjustedSpeed, Dir);
    vy = lengthdir_y(AdjustedSpeed, Dir);
}

a = -0.125;
ax = sign(vx) * a;
ay = sign(vy) * a;
starting_vx_sign = sign(vx);
starting_vy_sign = sign(vy);
ObjCollideDelay = false;
Returning = false;
OutsideRoomDestroy = false;
