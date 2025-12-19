event_inherited();
var _DropItem = false;

if (Destroyed)
{
    if (SwallowedItem_Class != -1)
    {
        var DroppedItem = ItemSpawn(SwallowedItem_Class, x, y, UnknownEnum.Value_14, UnknownEnum.Value_1, FloorLevel, false);
        
        with (DroppedItem)
        {
            Setup = false;
            Get_ShowDialogue = false;
            Amount = other.SwallowedItem_Amount;
            
            if (Class == UnknownEnum.Value_40)
                ShowAmount = Amount > 5;
            
            Item_SetIndex(other.SwallowedItem_Index);
        }
    }
    
    _DropItem = true;
}

if (State == UnknownEnum.Value_10 || State == UnknownEnum.Value_15 || State == UnknownEnum.Value_16 || State == UnknownEnum.Value_17)
    _DropItem = true;

if (_DropItem)
{
    with (TongueInst)
    {
        if (ItemGrabbed && instance_exists(ItemInst))
        {
            var DroppedItem = ItemSpawn(ItemInst.Class, ItemInst.x, ItemInst.y, ItemInst.From, UnknownEnum.Value_1, other.FloorLevel, false);
            DroppedItem.Setup = false;
            DroppedItem.Get_ShowDialogue = false;
            DroppedItem.layer = other.layer;
            DroppedItem.Amount = ItemInst.Amount;
            
            with (DroppedItem)
            {
                if (Class == UnknownEnum.Value_40)
                    ShowAmount = Amount > 5;
                
                Item_SetIndex(other.ItemInst.Index);
            }
            
            instance_destroy(ItemInst);
        }
        
        instance_destroy(self);
    }
}

if (Destroyed)
    exit;

if (KnockBackDone || StunDone)
{
    if (instance_exists(TongueInst))
    {
        sprite_index = sEnemy_Pikit_Shooting;
        State = UnknownEnum.Value_7;
        Shoot = true;
        
        if (TongueInst.ItemGrabbed)
            TongueInst.ItemRelease = true;
    }
    else
    {
        Enemy_UpdateState(UnknownEnum.Value_7);
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

switch (State)
{
    case UnknownEnum.Value_2:
        if (FloorLevel == oLink.FloorLevel && CanShoot)
        {
            if (!oLink.Cape && distance_to_object(oLink) <= 32)
                Enemy_UpdateState(UnknownEnum.Value_7);
        }
        
        break;
    
    case UnknownEnum.Value_5:
        if (JumpLanded)
            Enemy_UpdateState(UnknownEnum.Value_2);
        
        break;
    
    case UnknownEnum.Value_7:
        if (!Shoot && image_index >= 1.5)
        {
            ObjSetImageSpeed(0);
            image_index = 1;
            TongueInst = instance_create_layer(x, y - 5, "Objs_" + GetFloorLevelString(x, y), oEnemy_Pikit_Tongue);
            TongueInst.depth = depth - 5;
            TongueInst.Angle = (floor((point_direction(TongueInst.x, TongueInst.y, oLink.x, oLink.y - 6) + 22.5) / 45) * 45) % 360;
            TongueInst.ParentInst = id;
            TongueInst.FloorLevel = FloorLevel;
            
            switch (TongueInst.Angle)
            {
                case 0:
                    TongueInst.OffsetX = 4;
                    break;
                
                case 45:
                    TongueInst.OffsetX = 4;
                    TongueInst.OffsetY = -4;
                    break;
                
                case 90:
                    TongueInst.OffsetY = -4;
                    break;
                
                case 135:
                    TongueInst.OffsetX = -4;
                    TongueInst.OffsetY = -4;
                    break;
                
                case 180:
                    TongueInst.OffsetX = -4;
                    break;
                
                case 225:
                    TongueInst.OffsetX = -4;
                    TongueInst.OffsetY = 4;
                    break;
                
                case 270:
                    TongueInst.OffsetY = 4;
                    break;
                
                case 315:
                    TongueInst.OffsetX = 4;
                    TongueInst.OffsetY = 4;
                    break;
            }
            
            Shoot = true;
        }
        else if (Shoot && !instance_exists(TongueInst))
        {
            ObjSetImageSpeed(1);
            
            if (image_index >= 2.75)
            {
                Enemy_UpdateState(UnknownEnum.Value_2);
                Shoot = false;
                CanShoot = false;
                alarm[1] = CanShootPause;
            }
        }
        
        break;
}

enum UnknownEnum
{
    Value_1 = 1,
    Value_2,
    Value_5 = 5,
    Value_7 = 7,
    Value_10 = 10,
    Value_11,
    Value_13 = 13,
    Value_14,
    Value_15,
    Value_16,
    Value_17,
    Value_40 = 40
}
