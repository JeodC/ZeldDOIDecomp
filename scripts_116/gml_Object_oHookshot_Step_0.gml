if (global.Paused)
{
    ObjPause();
    exit;
}
else
{
    image_speed = LastImageSpeed;
}

x += vx;
ObjSetY(y_base + vy);
var SetReturning = false;
DistFromLink = distance_to_object(oLink);

if (!Returning)
{
    event_inherited();
    
    if (WallCollided)
    {
        instance_create_layer(x, y_base, "ObjsHigher_" + GetFloorLevelString(oLink.FloorLevel), oWallHit, 
        {
            PlaySound: true
        });
        SetReturning = true;
    }
    else if (DistFromLink >= DistMax)
    {
        SetReturning = true;
    }
    
    var inst = CheckProjectileCollision(FloorLevel);
    
    if (inst != -4)
    {
        if (inst.object_index == oBush)
            GoingThroughBushes = true;
    }
    
    if (inst != -4 && !GoingThroughBushes)
    {
        SetReturning = true;
    }
    else
    {
        CapturedItem = instance_place(x, y_base, oItem);
        var IgnoreCapture = false;
        
        if (CapturedItem != -4)
        {
            with (CapturedItem)
            {
                if (instance_place(x, y, oLink))
                    IgnoreCapture = true;
            }
            
            if (CapturedItem.ShopItem || CapturedItem.object_index == oItem_Treasure || GoingThroughBushes)
                IgnoreCapture = true;
            
            if (IgnoreCapture)
            {
                CapturedItem = -4;
            }
            else
            {
                CapturedItemCenterX = CapturedItem.sprite_width / 2;
                CapturedItemCenterY = CapturedItem.sprite_height / 2;
                CapturedItem.layer = layer_get_id("ObjsHigher_" + GetFloorLevelString(oLink.FloorLevel));
                CapturedItem.Spawning = false;
                CapturedItem.ShowShadow = false;
                CapturedItem.SpawnAnimation = false;
                SetReturning = true;
            }
        }
    }
}

if (!Returning && SetReturning)
{
    vx *= -1;
    vy *= -1;
    Returning = true;
}

if (CapturedItem != -4 && instance_exists(CapturedItem))
{
    switch (oLink.Facing)
    {
        case 1:
            CapturedItem.x = x;
            CapturedItem.y = (y_base - 6) + CapturedItemCenterY;
            break;
        
        case 2:
            CapturedItem.x = x;
            CapturedItem.y = y_base + 6 + CapturedItemCenterY;
            break;
        
        case 3:
            CapturedItem.x = x - 2 - CapturedItemCenterX;
            CapturedItem.y = (y_base - 2) + CapturedItemCenterY;
            break;
        
        case 4:
            CapturedItem.x = x + 2 + CapturedItemCenterX;
            CapturedItem.y = (y_base - 2) + CapturedItemCenterY;
            break;
    }
}

if (Returning && DistFromLink <= 0)
{
    with (oLink)
        UpdateState(UnknownEnum.Value_1);
    
    instance_destroy(id);
    exit;
}

if (!ds_exists(ChainXList, ds_type_list) || !ds_exists(ChainYList, ds_type_list))
    exit;

ChainAniCounter--;

if (ChainAniCounter <= 0)
{
    ChainAniFrame ^= true;
    ChainAniCounter = 3;
}

Chains = min(round(DistFromLink / 7), 8);
ds_list_clear(ChainXList);
ds_list_clear(ChainYList);

for (var ChainIndex = 1; ChainIndex <= Chains; ChainIndex++)
{
    switch (oLink.Facing)
    {
        case 3:
        case 4:
            ds_list_add(ChainXList, StartPointX + ((x - BBoxEdge) * (ChainIndex / (Chains + 1))));
            ds_list_add(ChainYList, StartPointY);
            break;
        
        case 1:
        case 2:
            ds_list_add(ChainXList, StartPointX);
            ds_list_add(ChainYList, StartPointY + ((y_base - BBoxEdge) * (ChainIndex / (Chains + 1))));
            break;
    }
}

enum UnknownEnum
{
    Value_1 = 1
}
