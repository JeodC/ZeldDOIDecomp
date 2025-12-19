if (SpawnAnimationInit)
{
    switch (SpawnType)
    {
        case UnknownEnum.Value_1:
            z = 2;
            vz = 1.75;
            g = -0.14;
            SpawnBounces = 1;
            break;
        
        case UnknownEnum.Value_2:
            z = 16;
            g = -0.14;
            SpawnBounces = 2;
            break;
        
        case UnknownEnum.Value_3:
            z = 32;
            g = -0.14;
            SpawnBounces = 2;
            break;
        
        case UnknownEnum.Value_4:
            vz = 2.75;
            g = -0.2;
            SpawnBounces = 2;
            var Angle = irandom(359);
            var Speed = random_range(0.2, 0.6);
            vx = lengthdir_x(Speed, Angle);
            vy = lengthdir_y(Speed, Angle);
            break;
        
        case UnknownEnum.Value_5:
            x = global.CurrentRoom.x + 128;
            ObjSetY(global.CurrentRoom.y + 128);
            z = 128;
            vz = -2;
            break;
        
        case UnknownEnum.Value_8:
            vz = 3.4;
            g = -0.2;
            SpawnBounces = 2;
            vx = random_range(-0.1, 0.1);
            vy = random_range(0.9, 1.1);
            break;
        
        case UnknownEnum.Value_9:
            vz = 0.25;
            z_end = 8;
            Lighting = false;
            ShadowSpr = sEmptyMask;
            Get_Sound = -4;
            global.Paused = true;
            break;
    }
    
    SpawnAnimation = true;
    SpawnAnimationInit = false;
}

if (SpawnAnimation)
{
    if (SpawnType == UnknownEnum.Value_5 && global.Paused)
        exit;
    
    WallCollision(CollidedWallList, vx, 0, oWall);
    WallCollide_X = ds_list_size(CollidedWallList) > 0;
    
    if (WallCollide_X)
        vx *= -1;
    
    WallCollision(CollidedWallList, 0, vy, oWall);
    WallCollide_Y = ds_list_size(CollidedWallList) > 0;
    
    if (WallCollide_Y)
        vy *= -1;
    
    x += vx;
    vz += g;
    z += vz;
    
    switch (SpawnType)
    {
        case UnknownEnum.Value_5:
            if (z <= 8)
                Get_Allowed = true;
            
            break;
        
        case UnknownEnum.Value_10:
            Alpha += 0.005;
            
            if (Alpha >= 1)
            {
                Alpha = 1;
                SpawnAnimationFinish = true;
            }
            else
            {
                exit;
            }
            
            break;
    }
    
    switch (SpawnType)
    {
        case UnknownEnum.Value_9:
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_8:
        case UnknownEnum.Value_5:
            break;
        
        default:
            if (Item_OverHole() && z <= 1)
            {
                Item_FallInHole();
                exit;
            }
            
            if (Item_CheckPondWater())
                exit;
            
            Item_CheckFloorLevelSwitch();
            break;
    }
    
    if (z <= 0)
    {
        z = 0;
        
        if (SpawnBounces == 0)
        {
            SpawnAnimation = false;
            SpawnAnimationFinish = true;
        }
        else
        {
            SpawnBounces--;
            Get_Allowed = true;
            vz = -vz * 0.6;
        }
    }
    
    if (z >= z_end)
    {
        z = z_end;
        vz = 0;
        alarm[0] = 60;
        SpawnAnimation = false;
    }
    
    ObjSetY(y_base + vy);
}

if (SpawnAnimationFinish)
{
    switch (SpawnType)
    {
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_2:
        case UnknownEnum.Value_4:
        case UnknownEnum.Value_5:
            layer = layer_get_id("Objs_" + GetFloorLevelString(FloorLevel));
            break;
        
        case UnknownEnum.Value_9:
            var _FromAnyTreasure = FromAnyTreasure(From);
            
            if (_FromAnyTreasure && Class != UnknownEnum.Value_20)
            {
                TreasureLimiter_Update(Class);
                Item_GetDialogue(Class, Index, Amount);
            }
            
            var ItemGot = Item_Get(Class, Index, Amount);
            
            if (ItemGot)
                Curse_GetItemUncurseMsg(Class, Index);
            
            instance_destroy(id);
            
            if (_FromAnyTreasure && !ItemGot)
            {
                var _DropPos = Item_DropPos();
                var _ItemInst = ItemDrop(_DropPos[0], _DropPos[1], Class, Index, Amount, UnknownEnum.Value_2);
                _ItemInst.Get_ShowDialogue = false;
            }
            
            if (FromAnyTreasureChest(From))
                Curse_CheckTask(UnknownEnum.Value_1);
            
            if (!instance_exists(oDialogueBox))
            {
                with (oLink)
                    UpdateState(UnknownEnum.Value_1);
                
                global.Paused = false;
            }
            
            break;
    }
    
    SpawnAnimationFinish = false;
    Spawning = false;
}

if (Spawning)
{
    switch (SpawnType)
    {
        case UnknownEnum.Value_9:
            exit;
    }
}

if (Class != UnknownEnum.Value_45)
    Item_CheckWater();

if (ShopItem)
{
    Price_Modified = Curse_Check(UnknownEnum.Value_7) ? Price_Max : Price;
    
    if (Price_Modified != Price)
        Price_Color = 255;
    
    Price_CouponApplied = false;
    Price_Modified = Coupon_NewPrice(Price_Modified, Class, Index);
    
    if (Price_Modified != Price)
    {
        Price_CouponApplied = true;
        Price_Color = 32768;
    }
}

enum UnknownEnum
{
    Value_1 = 1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_7 = 7,
    Value_8,
    Value_9,
    Value_10,
    Value_20 = 20,
    Value_45 = 45
}
