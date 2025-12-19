with (ExplosionLightInst)
{
    if (global.Paused)
        ObjPause();
}

if (global.Paused)
{
    ObjPause();
    exit;
}
else
{
    image_speed = LastImageSpeed;
}

if (image_index > 5)
    exit;

ds_list_clear(CollisionList);
ObjCollision_Circle_List(CollisionList, x, y, BlastRadius_Enemies, oEnemy, FloorLevel);
var Enemies = ds_list_size(CollisionList);

if (Enemies > 0)
{
    for (var EnemyIndex = 0; EnemyIndex < Enemies; EnemyIndex++)
    {
        var EnemyInst = ds_list_find_value(CollisionList, EnemyIndex);
        Enemy_LinkWeaponHit(UnknownEnum.Value_5, 0, EnemyInst, x, y, point_direction(x, y, EnemyInst.x, EnemyInst.y));
    }
}

Bomb_CheckLinkDamage(FloorLevel, undefined, MaxDamage);

if (oLink.State == UnknownEnum.Value_4)
    exit;

PickupObj_CheckExplosions(x, y, FloorLevel, BlastRadius_PickupObjs, CollisionList);

if (image_index > 3 && !Exploded_Curtains)
{
    ObjCollision_Circle_List(CollisionList, x, y, BlastRadius_Doors, oCurtain, FloorLevel);
    var Curtains = ds_list_size(CollisionList);
    
    if (Curtains > 0)
    {
        for (var CurtainIndex = 0; CurtainIndex < Curtains; CurtainIndex++)
        {
            var CurtainInst = ds_list_find_value(CollisionList, CurtainIndex);
            
            if (CurtainInst != -4)
                Curtain_Reveal(CurtainInst);
        }
    }
    
    Exploded_Curtains = true;
}

if (image_index > 4 && !Exploded_Doors)
{
    if (global.Level.Index == UnknownEnum.Value_0)
    {
        var CastleDoor = collision_circle(x, y, BlastRadius_Doors, oCastleWallDoor, false, true);
        
        if (CastleDoor != -4)
            CastleDoor.Opened = true;
    }
    else
    {
        ObjCollision_Circle_List(CollisionList, x, y, BlastRadius_Doors, oDoor, FloorLevel);
        var Doors = ds_list_size(CollisionList);
        var _SecretDoor = false;
        
        if (Doors > 0)
        {
            for (var DoorIndex = 0; DoorIndex < Doors; DoorIndex++)
            {
                var DoorInst = ds_list_find_value(CollisionList, DoorIndex);
                
                if (DoorInst.Status == UnknownEnum.Value_8 && (DoorInst.SecretType == UnknownEnum.Value_0 || DoorInst.SecretType == UnknownEnum.Value_1))
                {
                    Door_OpenSecretDoor(DoorInst);
                    
                    with (DoorInst)
                    {
                        var LightInst = instance_place(x, y, oWallLight);
                        
                        if (LightInst != -4)
                            instance_destroy(LightInst);
                    }
                    
                    _SecretDoor = true;
                }
            }
            
            if (_SecretDoor)
                audio_play_sound_stopall(Sound_Secret);
        }
    }
    
    Exploded_Doors = true;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_4 = 4,
    Value_5,
    Value_8 = 8
}
