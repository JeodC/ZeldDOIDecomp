function Collision_CheckFloorLevel(arg0, arg1)
{
    return arg0 == arg1.FloorLevel || arg1.FloorLevel == 2;
}

function ObjCollision(arg0, arg1, arg2, arg3)
{
    var ObjInst = instance_place(arg0, arg1, arg2);
    
    if (ObjInst != -4)
    {
        if (Collision_CheckFloorLevel(arg3, ObjInst))
            return ObjInst;
    }
    
    return -4;
}

function ObjCollision_Position(arg0, arg1, arg2, arg3)
{
    var _ObjInst = instance_position(arg0, arg1, arg2);
    
    if (_ObjInst != -4)
    {
        if (Collision_CheckFloorLevel(arg3, _ObjInst))
            return _ObjInst;
    }
    
    return -4;
}

function ObjCollision_List(arg0, arg1, arg2, arg3, arg4)
{
    ds_list_clear(arg0);
    var ObjList = ds_list_create();
    var ObjInsts = instance_place_list(arg1, arg2, arg3, ObjList, false);
    
    for (var i = 0; i < ObjInsts; i++)
    {
        var ObjInst = ds_list_find_value(ObjList, i);
        
        if (Collision_CheckFloorLevel(arg4, ObjInst))
            ds_list_add(arg0, ObjInst);
    }
    
    ds_list_destroy(ObjList);
}

function ObjCollision_Circle(arg0, arg1, arg2, arg3, arg4)
{
    var ObjInst = collision_circle(arg0, arg1, arg2, arg3, false, true);
    return (ObjInst != -4 && Collision_CheckFloorLevel(arg4, ObjInst)) ? ObjInst : -4;
}

function ObjCollision_Circle_List(arg0, arg1, arg2, arg3, arg4, arg5)
{
    ds_list_clear(arg0);
    var ObjList = ds_list_create();
    var ObjInsts = collision_circle_list(arg1, arg2, arg3, arg4, false, true, ObjList, false);
    
    for (var i = 0; i < ObjInsts; i++)
    {
        var ObjInst = ds_list_find_value(ObjList, i);
        
        if (Collision_CheckFloorLevel(arg5, ObjInst))
            ds_list_add(arg0, ObjInst);
    }
    
    ds_list_destroy(ObjList);
}

function WallCollision(arg0, arg1, arg2, arg3)
{
    Success = true;
    var WallList = ds_list_create();
    ds_list_clear(WallList);
    var Walls;
    
    if (object_index == oLink)
        Walls = instance_place_list(x + arg1, y + arg2, arg3, WallList, false);
    else
        Walls = instance_place_list(x + arg1, y_base + arg2, arg3, WallList, false);
    
    if (object_index == oLink)
    {
        if (Walls > 1)
        {
            for (var i = 0; i < Walls; i++)
            {
                var WallInst = ds_list_find_value(WallList, i);
                
                if (WallInst.BlockLink && WallInst.Move_Start && !WallInst.Moved)
                {
                    ds_list_delete(WallList, i);
                    Walls--;
                }
            }
        }
    }
    
    ds_list_clear(arg0);
    
    for (var i = 0; i < Walls; i++)
    {
        var WallInst = ds_list_find_value(WallList, i);
        
        if (object_index == oLink)
        {
            var Condition = WallInst.BlockLink || (WallInst.BlockLinkCarry && ItemHolding != -4 && !WallInst.IsHiddenObj);
            
            if (Condition && (FloorLevel == WallInst.FloorLevel || WallInst.FloorLevel == 2))
            {
                if (arg1 != 0)
                {
                    if (arg1 > 0)
                        x = (x - bbox_right) + WallInst.bbox_left;
                    else
                        x = (x + WallInst.bbox_right) - bbox_left;
                }
                
                if (arg2 != 0)
                {
                    if (arg2 > 0)
                        y = (y - bbox_bottom) + WallInst.bbox_top;
                    else
                        y = (y + WallInst.bbox_bottom) - bbox_top;
                }
                
                ds_list_add(arg0, WallInst);
            }
        }
        else
        {
            var _ParentObj = object_get_parent(object_index);
            var Condition = (_ParentObj == oEnemy && WallInst.BlockEnemies) || ((_ParentObj == oProjectile && WallInst.BlockProjectiles) || (WallInst.IsHole && object_index == oItem_Key) || ((_ParentObj == oItem || _ParentObj == oPickupObj) && WallInst.BlockItems) || object_index == oBoss_Moldorm);
            
            if (Condition && (FloorLevel == WallInst.FloorLevel || WallInst.FloorLevel == 2))
            {
                var Counter = 0;
                
                if (arg1 != 0)
                {
                    var Inc = sign(arg1) * 0.25;
                    
                    while (!place_meeting(x + Inc, y_base, WallInst))
                    {
                        x += Inc;
                        Counter++;
                        
                        if (Counter > 100)
                        {
                            Success = false;
                            break;
                        }
                    }
                }
                
                if (arg2 != 0)
                {
                    var Inc = sign(arg2) * 0.25;
                    
                    while (!place_meeting(x, y_base + Inc, WallInst))
                    {
                        ObjSetY(y_base + Inc);
                        Counter++;
                        
                        if (Counter > 100)
                        {
                            Success = false;
                            break;
                        }
                    }
                }
                
                ds_list_add(arg0, WallInst);
            }
        }
    }
    
    ds_list_destroy(WallList);
    return Success;
}

function CheckProjectileCollision(arg0)
{
    if (!HitCrystalSwitch)
    {
        inst = ObjCollision(x, y_base, oCrystalSwitch, arg0);
        
        if (inst != -4)
        {
            if (inst.visible && !inst.HitPause)
            {
                inst.Hit = true;
                HitCrystalSwitch = true;
                return inst;
            }
        }
    }
    
    var inst = ObjCollision(x, y_base, oPickupObj, arg0);
    
    if (inst != -4)
    {
        if (inst.Hidden)
        {
            inst.State = UnknownEnum.Value_0;
        }
        else if (inst.DestroyedByProjectile && inst.State != UnknownEnum.Value_5 && inst.visible)
        {
            inst.State = UnknownEnum.Value_5;
            return inst;
        }
    }
    
    switch (object_index)
    {
        case oSwordBeam:
        case oRodBeam:
            if (object_index == oSwordBeam || (object_index == oRodBeam && Index == UnknownEnum.Value_2))
            {
                inst = ObjCollision(x, y, oTorch, arg0);
                
                if (inst != -4)
                    inst.Lighting = true;
            }
        
        case oCaneBeam:
        case oArrow:
        case oBoomerang:
        case oHookshot:
            var CurtainInst = ObjCollision(x, y, oCurtain, arg0);
            
            if (CurtainInst != -4)
                Curtain_Reveal(CurtainInst);
    }
    
    var _EnemyList = ds_list_create();
    ObjCollision_List(_EnemyList, x, y, oEnemy, arg0);
    
    for (var i = 0; i < ds_list_size(_EnemyList); i++)
    {
        inst = ds_list_find_value(_EnemyList, i);
        
        if (inst.State == UnknownEnum.Value_16 || inst.Energy <= 0.05)
        {
            ds_list_destroy(_EnemyList);
            return -4;
        }
        
        var _WeaponClass = GetLinkWeaponClass(object_index, Index);
        
        if (_WeaponClass != -1)
        {
            if (Enemy_LinkWeaponHit(_WeaponClass, Index, inst, x, y, point_direction(x, y, x + vx, y + vy)))
            {
                ds_list_destroy(_EnemyList);
                return inst;
            }
        }
    }
    
    ds_list_destroy(_EnemyList);
    return -4;
}

enum UnknownEnum
{
    Value_0,
    Value_2 = 2,
    Value_5 = 5,
    Value_16 = 16
}
