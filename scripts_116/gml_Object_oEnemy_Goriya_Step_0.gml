event_inherited();

if (KnockBackDone || StunDone)
{
    var _FaceLinkDir = DirFaceLink();
    
    switch (Type)
    {
        case 0:
            Enemy_UpdateState(UnknownEnum.Value_3);
            Goriya_UpdateDir(OppositeDir(_FaceLinkDir));
            break;
        
        case 1:
            Enemy_UpdateState(UnknownEnum.Value_2);
            Dir = _FaceLinkDir;
            Enemy_UpdateSprite(State);
            OpenMouth = true;
            alarm[0] = -1;
            alarm[1] = 10;
            alarm[3] = -1;
            break;
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

var _LinkActive = !oLink.Cape && oLink.State != UnknownEnum.Value_20;

if (State == UnknownEnum.Value_3)
{
    VX_Extra = 0;
    VY_Extra = 0;
    Enemy_UpdateV(Speed);
    
    if (_LinkActive)
    {
        switch (Type)
        {
            case 0:
                var _DirFromLink = point_direction(oLink.x, oLink.y, x, y);
                VX_Extra = lengthdir_x(0.25, _DirFromLink);
                VY_Extra = lengthdir_y(0.25, _DirFromLink);
                break;
            
            case 1:
                var _DirToLink = point_direction(x, y, oLink.x, oLink.y);
                VX_Extra = lengthdir_x(0.25, _DirToLink);
                VY_Extra = lengthdir_y(0.25, _DirToLink);
                break;
        }
        
        vx += VX_Extra;
        vy += VY_Extra;
    }
    
    if (WallCollide_X && (Dir == 3 || Dir == 4))
        Goriya_UpdateDir(choose(OppositeDir(Dir), Enemy_WallCollisionNewDir(1)));
    
    if (WallCollide_Y && (Dir == 1 || Dir == 2))
        Goriya_UpdateDir(choose(OppositeDir(Dir), Enemy_WallCollisionNewDir(2)));
}

if (Type == 1 && _LinkActive)
{
    var LinkInSight = Enemy_LinkInSight(Dir, SightOffset, SightDist);
    
    if (!OpenMouth && CanShoot && LinkInSight)
    {
        Enemy_UpdateState(UnknownEnum.Value_2);
        OpenMouth = true;
        alarm[0] = 30;
        alarm[1] = 20;
        alarm[3] = -1;
    }
}

enum UnknownEnum
{
    Value_2 = 2,
    Value_3,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17,
    Value_20 = 20
}
