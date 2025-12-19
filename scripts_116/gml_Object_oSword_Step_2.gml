var img_index = floor(oLink.image_index);
var Lx = oLink.x;
var Ly = oLink.y - 1;
image_xscale = 1;
image_yscale = 1;
image_angle = 0;
var CheckCollision = false;

switch (oLink.State)
{
    case UnknownEnum.Value_12:
        switch (oLink.Facing)
        {
            case 3:
                if (img_index == 0)
                {
                    image_index = 0;
                    x = Lx - 1;
                    y = Ly - 8;
                    image_xscale = -1;
                }
                
                if (img_index == 1)
                {
                    image_index = 1;
                    x = Lx - 6;
                    y = Ly - 7;
                    image_xscale = -1;
                }
                
                if (img_index == 2)
                {
                    image_index = 2;
                    x = Lx - 8;
                    y = Ly - 6;
                    image_xscale = -1;
                }
                
                if (img_index == 3)
                {
                    image_index = 3;
                    x = Lx - 13;
                    y = Ly - 6;
                    image_xscale = -1;
                }
                
                if (img_index == 4)
                {
                    image_index = 1;
                    x = Lx - 9;
                    y = Ly - 8;
                    image_angle = 90;
                }
                
                if (img_index >= 5 && img_index <= 8)
                {
                    image_index = 0;
                    x = Lx - 14;
                    y = Ly - 4;
                    image_angle = 90;
                }
                
                if (img_index == 9)
                {
                    image_index = 1;
                    x = Lx - 9;
                    y = Ly;
                    image_xscale = -1;
                    image_angle = 90;
                }
                
                if (img_index == 10)
                {
                    image_index = 2;
                    x = Lx - 6;
                    y = Ly + 4;
                    image_xscale = -1;
                    image_angle = 90;
                }
                
                if (img_index >= 11)
                {
                    image_index = 3;
                    x = Lx - 1;
                    y = Ly + 7;
                    image_xscale = -1;
                    image_angle = 90;
                }
                
                HitPosX = Lx - 22;
                HitPosY = Ly - 5;
                break;
            
            case 4:
                if (img_index == 0)
                {
                    image_index = 0;
                    x = Lx + 1;
                    y = Ly - 8;
                }
                
                if (img_index == 1)
                {
                    image_index = 1;
                    x = Lx + 6;
                    y = Ly - 7;
                }
                
                if (img_index == 2)
                {
                    image_index = 2;
                    x = Lx + 8;
                    y = Ly - 6;
                }
                
                if (img_index == 3)
                {
                    image_index = 3;
                    x = Lx + 13;
                    y = Ly - 6;
                }
                
                if (img_index == 4)
                {
                    image_index = 1;
                    x = Lx + 10;
                    y = Ly - 7;
                    image_yscale = -1;
                    image_angle = 90;
                }
                
                if (img_index >= 5 && img_index <= 8)
                {
                    image_index = 0;
                    x = Lx + 14;
                    y = Ly - 4;
                    image_yscale = -1;
                    image_angle = 90;
                }
                
                if (img_index == 9)
                {
                    image_index = 1;
                    x = Lx + 9;
                    y = Ly;
                    image_angle = -90;
                }
                
                if (img_index == 10)
                {
                    image_index = 2;
                    x = Lx + 6;
                    y = Ly + 4;
                    image_angle = -90;
                }
                
                if (img_index >= 11)
                {
                    image_index = 3;
                    x = Lx + 1;
                    y = Ly + 7;
                    image_angle = -90;
                }
                
                HitPosX = Lx + 22;
                HitPosY = Ly - 5;
                break;
            
            case 1:
                if (img_index == 0)
                {
                    image_index = 0;
                    x = Lx + 5;
                    y = Ly - 7;
                    image_xscale = -1;
                    image_angle = -90;
                }
                
                if (img_index == 1)
                {
                    image_index = 1;
                    x = Lx + 3;
                    y = Ly - 11;
                    image_xscale = -1;
                    image_angle = -90;
                }
                
                if (img_index == 2)
                {
                    image_index = 2;
                    x = Lx + 1;
                    y = Ly - 15;
                    image_xscale = -1;
                    image_angle = -90;
                }
                
                if (img_index == 3)
                {
                    image_index = 3;
                    x = Lx;
                    y = Ly - 21;
                    image_xscale = -1;
                    image_angle = -90;
                }
                
                if (img_index == 4)
                {
                    image_index = 1;
                    x = Lx - 1;
                    y = Ly - 17;
                }
                
                if (img_index >= 5 && img_index <= 8)
                {
                    image_index = 0;
                    x = Lx - 5;
                    y = Ly - 21;
                }
                
                if (img_index == 9)
                {
                    image_index = 1;
                    x = Lx - 9;
                    y = Ly - 15;
                    image_xscale = -1;
                }
                
                if (img_index == 10)
                {
                    image_index = 2;
                    x = Lx - 11;
                    y = Ly - 10;
                    image_xscale = -1;
                }
                
                if (img_index >= 11)
                {
                    image_index = 3;
                    x = Lx - 14;
                    y = Ly - 6;
                    image_xscale = -1;
                }
                
                HitPosX = Lx - 4;
                HitPosY = Ly - 28;
                break;
            
            case 2:
                if (img_index == 0)
                {
                    image_index = 0;
                    x = Lx - 2;
                    y = Ly - 5;
                    image_xscale = -1;
                    image_angle = 90;
                }
                
                if (img_index == 1)
                {
                    image_index = 1;
                    x = Lx - 1;
                    y = Ly - 2;
                    image_xscale = -1;
                    image_angle = 90;
                }
                
                if (img_index == 2)
                {
                    image_index = 2;
                    x = Lx;
                    y = Ly + 1;
                    image_xscale = -1;
                    image_angle = 90;
                }
                
                if (img_index == 3)
                {
                    image_index = 3;
                    x = Lx + 1;
                    y = Ly + 5;
                    image_xscale = -1;
                    image_angle = 90;
                }
                
                if (img_index == 4)
                {
                    image_index = 1;
                    x = Lx + 1;
                    y = Ly + 1;
                    image_angle = 180;
                }
                
                if (img_index >= 5 && img_index <= 8)
                {
                    image_index = 0;
                    x = Lx + 4;
                    y = Ly + 5;
                    image_angle = 180;
                }
                
                if (img_index == 9)
                {
                    image_index = 1;
                    x = Lx + 8;
                    y = Ly - 1;
                    image_xscale = -1;
                    image_angle = 180;
                }
                
                if (img_index == 10)
                {
                    image_index = 2;
                    x = Lx + 10;
                    y = Ly - 3;
                    image_xscale = -1;
                    image_angle = 180;
                }
                
                if (img_index >= 11)
                {
                    image_index = 3;
                    x = Lx + 14;
                    y = Ly - 5;
                    image_xscale = -1;
                    image_angle = 180;
                }
                
                HitPosX = Lx + 4;
                HitPosY = Ly + 12;
                break;
        }
        
        CheckCollision = img_index >= 2 && img_index <= 9;
        break;
    
    case UnknownEnum.Value_19:
        image_index = 1;
        CheckCollision = true;
        
        switch (img_index)
        {
            case 0:
                x = Lx + 8;
                y = Ly - 7;
                image_xscale = -1;
                image_angle = -90;
                break;
            
            case 1:
                x = Lx + 8;
                y = Ly - 2;
                image_angle = -90;
                break;
            
            case 2:
                x = Lx + 3;
                y = Ly + 1;
                image_xscale = -1;
                image_angle = 180;
                break;
            
            case 3:
                x = Lx - 4;
                y = Ly + 1;
                image_angle = 180;
                break;
            
            case 4:
                x = Lx - 8;
                y = Ly - 2;
                image_xscale = -1;
                image_angle = 90;
                break;
            
            case 5:
                x = Lx - 8;
                y = Ly - 9;
                image_angle = 90;
                break;
            
            case 6:
                x = Lx - 5;
                y = Ly - 12;
                image_xscale = -1;
                break;
            
            case 7:
                x = Lx + 3;
                y = Ly - 12;
                break;
        }
        
        break;
}

if (CheckCollision)
{
    StarCollisionX = oLink.x - 1;
    StarCollisionY = oLink.y - 8;
    var CrystalInst = SwordCollision(oCrystalSwitch);
    
    if (CrystalInst != -4)
    {
        if (!CrystalInst.HitPause)
        {
            with (oSwordBeam)
                instance_destroy(id);
            
            CrystalInst.Hit = true;
        }
    }
    
    var CurtainInst = SwordCollision(oCurtain);
    
    if (CurtainInst != -4)
        Curtain_Reveal(CurtainInst);
    
    if (oLink.State == UnknownEnum.Value_12)
    {
        var SoldierWeaponInst = ObjCollision(x, y, oSoldierWeapon, FloorLevel);
        
        if (SoldierWeaponInst != -4)
        {
            if (SoldierWeaponInst.object_index != oSoldierWeapon_Mace)
            {
                if (EnemyCanHurtLink(SoldierWeaponInst.SoldierInst))
                {
                    instance_create_layer(SoldierWeaponInst.x, SoldierWeaponInst.y, "ObjsHigher_Upper", oWallHit, 
                    {
                        PlaySound: true
                    });
                    
                    with (SoldierWeaponInst.SoldierInst)
                    {
                        Pushback = true;
                        
                        if (InFrontOfLink(x, y))
                        {
                            var _Hit = Enemy_LinkWeaponHit(UnknownEnum.Value_0, 0, self, other.HitPosX, other.HitPosY, point_direction(oLink.x, oLink.y, x, y));
                            
                            if (_Hit)
                                exit;
                        }
                    }
                }
            }
        }
    }
    
    SwordCollision(oEnemy, global.SwordCollisionList);
    
    for (var i = 0; i < ds_list_size(global.SwordCollisionList); i++)
    {
        var EnemyInst = ds_list_find_value(global.SwordCollisionList, i);
        var _Hit = false;
        
        with (EnemyInst)
        {
            if (State != UnknownEnum.Value_10 && State != UnknownEnum.Value_11)
            {
                switch (oLink.State)
                {
                    case UnknownEnum.Value_12:
                        if (InFrontOfLink(x, y))
                            _Hit = Enemy_LinkWeaponHit(UnknownEnum.Value_0, 0, self, other.HitPosX, other.HitPosY, point_direction(oLink.x, oLink.y, x, y));
                        
                        break;
                    
                    case UnknownEnum.Value_19:
                        _Hit = Enemy_LinkWeaponHit(UnknownEnum.Value_0, 0, self, oLink.x, oLink.y, point_direction(oLink.x, oLink.y, x, y));
                        break;
                }
                
                if (_Hit)
                {
                    if (instance_exists(oSwordBeam))
                        instance_destroy(oSwordBeam);
                }
            }
        }
        
        if (_Hit)
            break;
    }
    
    var PickupObjInst = SwordCollision(oPickupObj);
    
    if (PickupObjInst != -4)
    {
        var DestroyObj = PickupObjInst.DestroyedBySword;
        var IgnoreObj = false;
        
        switch (PickupObjInst.object_index)
        {
            case oPot:
                if (!SwordLevel(UnknownEnum.Value_2) && oLink.State != UnknownEnum.Value_19)
                    DestroyObj = false;
                
                break;
            
            case oSign:
                if (PickupObjInst.Hidden)
                    IgnoreObj = true;
                
                break;
        }
        
        if (DestroyObj)
        {
            PickupObjInst.State = UnknownEnum.Value_5;
        }
        else if (!IgnoreObj)
        {
            if (!instance_exists(oWallHit))
            {
                instance_create_layer(PickupObjInst.x, PickupObjInst.y - 4, "ObjsHigher_" + PickupObjInst.FloorLevelStr, oWallHit, 
                {
                    PlaySound: true
                });
            }
        }
    }
    
    var BoneInst = SwordCollision(oBone);
    
    if (BoneInst != -4)
        BoneInst.Destroyed = true;
}

enum UnknownEnum
{
    Value_0,
    Value_2 = 2,
    Value_5 = 5,
    Value_10 = 10,
    Value_11,
    Value_12,
    Value_19 = 19
}
