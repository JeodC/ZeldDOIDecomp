function PickupObj_RevealContents()
{
    if (WallObj != -4)
        instance_destroy(WallObj);
    
    if (ContentsObj != -1)
    {
        if (ContentsObj == UnknownEnum.Value_43)
        {
            if (!Enemy_StopWatchItem_Allowed())
                ContentsObj = Probs_RandomItemClass_Pot(true, true);
        }
        
        var _ItemInst = ItemSpawn(ContentsObj, ContentsObjX, ContentsObjY, UnknownEnum.Value_0, UnknownEnum.Value_1, FloorLevel);
        _ItemInst.layer = global.LayerID_ObjsHighest;
        _ItemInst.visible = true;
        ContentsObj = -1;
    }
}

function PickupObj_InitThrow()
{
    WallCollided = false;
    Bounces = 2;
    z = 18;
    vz = vz_Init;
    mask_index = sprite_index;
    State = UnknownEnum.Value_4;
}

function PickupObj_CheckExplosions(arg0, arg1, arg2, arg3, arg4)
{
    ds_list_clear(arg4);
    ObjCollision_Circle_List(arg4, arg0, arg1, arg3, oPickupObj, arg2);
    var PickupObjs = ds_list_size(arg4);
    
    if (PickupObjs > 0)
    {
        for (var PickupObjIndex = 0; PickupObjIndex < PickupObjs; PickupObjIndex++)
        {
            var PickupObjInst = ds_list_find_value(arg4, PickupObjIndex);
            
            if (PickupObjInst.DestroyedByProjectile && PickupObjInst.State == UnknownEnum.Value_0 && !PickupObjInst.Hidden)
                PickupObjInst.State = UnknownEnum.Value_5;
        }
    }
}

function PickupObj_CheckRoomIndex()
{
    if (id == oLink.ItemHolding)
    {
        var _y = y - 5;
        var _RoomIndex = Dungeon_GetRoomIndex(x, _y);
        
        if (RoomIndex != _RoomIndex)
        {
            if (LightIndex != -1)
            {
                Lighting_DestroyLight(RoomIndex, LightIndex);
                LightIndex = Lighting_CreateLight(_RoomIndex, x, _y, LightStrength, [LightR, LightG, LightB]);
            }
            
            RoomIndex = _RoomIndex;
        }
    }
}

function PickupObj_ResetToItem(arg0)
{
    var _ItemInst = instance_create_layer(x, y_base, "Objs_" + FloorLevelStr, arg0, 
    {
        From: From
    });
    
    with (_ItemInst)
    {
        FloorLevel = other.FloorLevel;
        Item_SetIndex(other.Index);
    }
    
    instance_destroy(id);
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_4 = 4,
    Value_5,
    Value_43 = 43
}
