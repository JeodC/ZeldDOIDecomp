event_inherited();
IgnoreWalls = true;
KnockBackEnabled = false;
KnockBackIgnoreZRule = true;
KnockBackIgnoreDestroy = true;
StartX = x;
StartY = y;
Path = choose(LanmolaPath1, LanmolaPath2, LanmolaPath3);
var AngleList = ds_list_create();
var AngleMultiples = 5;
var AngleDivs = floor(360 / AngleMultiples);

for (var i = 0; i < AngleDivs; i++)
{
    var A = i * AngleMultiples;
    
    if (A >= 240 && A <= 300)
        continue;
    
    var MaxDistance;
    
    switch (Path)
    {
        case LanmolaPath1:
            MaxDistance = 107;
            break;
        
        case LanmolaPath2:
            MaxDistance = 122;
            break;
        
        case LanmolaPath3:
            MaxDistance = 52;
            break;
    }
    
    MaxDistance += 24;
    
    if (collision_line(StartX, StartY, StartX + lengthdir_x(MaxDistance, A), StartY + lengthdir_y(MaxDistance, A), oWall, false, true) == -4)
        ds_list_add(AngleList, A);
}

if (ds_list_empty(AngleList))
{
    Path = LanmolaPath3;
    
    for (var i = 0; i < AngleDivs; i++)
    {
        var A = i * AngleMultiples;
        
        if (A >= 240 && A <= 300)
            continue;
        
        ds_list_add(AngleList, A);
    }
}

var RandomAngle = irandom(ds_list_size(AngleList) - 1);
StartAngle = ds_list_find_value(AngleList, RandomAngle);
ds_list_destroy(AngleList);
Angle = StartAngle;
Speed = 0.75;
StartVX = lengthdir_x(Speed, Angle);
StartVY = lengthdir_y(Speed, Angle);
vx = StartVX;
vy = StartVY;
Time = 0;
SectionCount = 0;
SectionSpawnTime = 8;
DestroySelf = false;
alarm[0] = SectionSpawnTime;
Enemy_UpdateState(UnknownEnum.Value_5);

enum UnknownEnum
{
    Value_5 = 5
}
