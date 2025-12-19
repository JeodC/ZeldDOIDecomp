if (DB_Init)
{
    global.DB_Inst = instance_create_layer(0, 0, "System", oDialogueBox);
    global.DB_Inst.Script = DB_Script;
    DB_Init = false;
    State = UnknownEnum.Value_1;
}

switch (State)
{
    case UnknownEnum.Value_0:
        Kinstone_Update();
        break;
    
    case UnknownEnum.Value_1:
        Kinstone_Update();
        
        if (!instance_exists(global.DB_Inst))
        {
            if (global.DB_ExitCode == 1)
            {
                FuseInit = true;
                
                with (oLink)
                    UpdateState(UnknownEnum.Value_0);
                
                global.Paused = true;
            }
            else
            {
                State = UnknownEnum.Value_0;
            }
        }
        
        break;
    
    case UnknownEnum.Value_2:
        BaseX += vx;
        SpriteY += vy;
        
        if (BaseX >= WaypointX)
            BaseX = WaypointX;
        
        if (SpriteY <= WaypointY)
            SpriteY = WaypointY;
        
        BaseX_Other += vx_Other;
        SpriteY_Other += vy_Other;
        
        if (BaseX_Other <= WaypointX_Other)
            BaseX_Other = WaypointX_Other;
        
        if (SpriteY_Other <= WaypointY_Other)
            SpriteY_Other = WaypointY_Other;
        
        Lighting_UpdateLight_Radius(RoomIndex, LightIndex, 1 + ((BaseY - SpriteY) / 30));
        
        if (BaseX == WaypointX && SpriteY == WaypointY && BaseX_Other == WaypointX_Other && SpriteY_Other == WaypointY_Other)
        {
            State = UnknownEnum.Value_3;
            vx = 0;
            vx_Other = 0;
            alarm[0] = 80;
        }
        
        break;
    
    case UnknownEnum.Value_3:
        if (Merge && !MergeConnected)
        {
            vx += -0.025;
            
            if (vx <= -0.5)
                vx = -0.5;
            
            vx_Other += 0.025;
            
            if (vx_Other >= 0.5)
                vx_Other = 0.5;
            
            BaseX += vx;
            BaseX_Other += vx_Other;
            
            if (!ConnectSound && BaseX <= (x + 6))
            {
                audio_play_sound(Sound_KinstoneConnect, 1, false);
                ConnectSound = true;
            }
            
            if (BaseX <= (x + 3) && BaseX_Other >= (x - 3))
            {
                MergeConnected = true;
                alarm[1] = 80;
                alarm[2] = 1;
            }
        }
        
        break;
    
    case UnknownEnum.Value_4:
        SpriteY += 0.4;
        SpriteY_Other += 0.4;
        LightY += 0.3;
        
        if (LightY >= LightY_Treasure)
            LightY = LightY_Treasure;
        
        Lighting_UpdateLight_Pos(RoomIndex, LightIndex, BaseX - 3, LightY);
        Lighting_UpdateLight_Radius(RoomIndex, LightIndex, 0.6 + ((BaseY - SpriteY) / 50));
        
        if (SpriteY >= BaseY)
        {
            PoofInst = instance_create_layer(BaseX - 3, SpriteY - 6, "ObjsHigher_Upper", oPoof);
            State = UnknownEnum.Value_5;
        }
        
        break;
    
    case UnknownEnum.Value_5:
        if (!instance_exists(PoofInst))
        {
            audio_play_sound(Sound_ChestAppear, 1, false);
            State = UnknownEnum.Value_6;
        }
        
        break;
    
    case UnknownEnum.Value_6:
        var ContentsFrom;
        
        switch (Index)
        {
            case UnknownEnum.Value_0:
                ContentsFrom = UnknownEnum.Value_5;
                break;
            
            case UnknownEnum.Value_1:
                ContentsFrom = UnknownEnum.Value_6;
                break;
            
            case UnknownEnum.Value_2:
                ContentsFrom = UnknownEnum.Value_7;
                break;
            
            case UnknownEnum.Value_3:
                ContentsFrom = UnknownEnum.Value_8;
                break;
        }
        
        var TreasureInst = Treasure_Create(RoomIndex, x - 16, y + 18, -99, true, undefined, undefined, ContentsFrom, ContentsFrom);
        TreasureInst = Treasure_Create(RoomIndex, x, y + 18, -99, true, undefined, undefined, ContentsFrom, ContentsFrom);
        Lighting_UpdateLight_RGB(RoomIndex, LightIndex, [TreasureLightColor, TreasureLightColor, TreasureLightColor]);
        var _SlotIndex = Inventory_ItemIndexExists(UnknownEnum.Value_23, Index);
        Inventory_Add(UnknownEnum.Value_23, Index, -1, _SlotIndex);
        var i = ds_list_find_index(global.LargeMapItems, id);
        
        if (i != -1)
            ds_list_delete(global.LargeMapItems, i);
        
        global.Paused = false;
        State = UnknownEnum.Value_7;
        
        with (oLink)
            UpdateState(UnknownEnum.Value_1);
        
        alarm[3] = 90;
        break;
    
    case UnknownEnum.Value_7:
        if (TreasureLightDim)
        {
            TreasureLightColor -= 0.1;
            Lighting_UpdateLight_RGB(RoomIndex, LightIndex, [TreasureLightColor, TreasureLightColor, TreasureLightColor]);
            
            if (TreasureLightColor <= 0)
            {
                instance_destroy(id);
                exit;
            }
        }
        
        break;
}

if (FuseInit)
{
    WaypointX_Other = BaseX_Other - 8;
    WaypointY_Other = BaseY_Other - 12;
    var Dir = point_direction(BaseX_Other, SpriteY_Other, WaypointX_Other, WaypointY_Other);
    var Dist_Other = point_distance(BaseX_Other, SpriteY_Other, WaypointX_Other, WaypointY_Other);
    vx_Other = lengthdir_x(0.25, Dir);
    vy_Other = lengthdir_y(0.25, Dir);
    WaypointX = BaseX + 8;
    WaypointY = BaseY - 12;
    Dir = point_direction(BaseX, SpriteY, WaypointX, WaypointY);
    var Dist = point_distance(BaseX, SpriteY, WaypointX, WaypointY);
    var VFactor = Dist / Dist_Other;
    vx = lengthdir_x(0.25 * VFactor, Dir);
    vy = lengthdir_y(0.25 * VFactor, Dir);
    State = UnknownEnum.Value_2;
    audio_play_sound(Sound_KinstoneFuse2, 1, false);
    FuseInit = false;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_23 = 23
}
