event_inherited();

if (KnockBackDone || StunDone)
{
    switch (Type)
    {
        case 0:
            NextDir = DirFaceLink();
            Enemy_UpdateState(UnknownEnum.Value_3);
            break;
        
        case 1:
            Enemy_UpdateState(UnknownEnum.Value_7);
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

if (State != UnknownEnum.Value_5 && oLink.Action[UnknownEnum.Value_4] && FloorLevel == oLink.FloorLevel && !oLink.Cape)
{
    if (distance_to_object(oSword) <= 9)
        Enemy_UpdateState(UnknownEnum.Value_5);
}

switch (State)
{
    case UnknownEnum.Value_3:
        if (WallCollide_X)
            Skeleton_UpdateDir(Enemy_WallCollisionNewDir(1));
        
        if (WallCollide_Y)
            Skeleton_UpdateDir(Enemy_WallCollisionNewDir(2));
        
        break;
    
    case UnknownEnum.Value_5:
        if (JumpLanded)
        {
            switch (Type)
            {
                case 0:
                    Enemy_UpdateState(UnknownEnum.Value_2);
                    break;
                
                case 1:
                    Enemy_UpdateState(oLink.Cape ? UnknownEnum.Value_2 : UnknownEnum.Value_7);
                    break;
            }
            
            layer = WalkingLayer;
        }
        
        break;
    
    case UnknownEnum.Value_7:
        if (Shoot)
        {
            ObjSetImageSpeed(0);
            
            switch (image_index)
            {
                case 0:
                    image_index = 1;
                    break;
                
                case 1:
                    image_index = 0;
                    break;
                
                case 2:
                    sprite_index = sEnemy_SkeletonBody_Walking_Left;
                    image_index = 1;
                    break;
                
                case 3:
                    sprite_index = sEnemy_SkeletonBody_Walking_Right;
                    image_index = 1;
                    break;
            }
            
            instance_create_layer(x, y - 4, "ObjsHigher_" + GetFloorLevelString(x, y), oBone, 
            {
                FloorLevel: FloorLevel,
                ColorIndex: Type
            });
            alarm[1] = 30;
            Shoot = false;
        }
        
        break;
}

enum UnknownEnum
{
    Value_2 = 2,
    Value_3,
    Value_4,
    Value_5,
    Value_7 = 7,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_15 = 15,
    Value_16,
    Value_17
}
