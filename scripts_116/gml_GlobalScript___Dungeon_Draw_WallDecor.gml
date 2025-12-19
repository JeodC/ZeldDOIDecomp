function Dungeon_Draw_WallDecor(arg0)
{
    switch (global.Level.Index)
    {
        case UnknownEnum.Value_0:
        case UnknownEnum.Value_6:
        case UnknownEnum.Value_10:
        case UnknownEnum.Value_13:
            exit;
        
        case UnknownEnum.Value_5:
            if (TemplateCheck(arg0, UnknownEnum.Value_9, UnknownEnum.Value_2, "TMNT"))
                exit;
            
            break;
        
        case UnknownEnum.Value_11:
            if (TemplateCheck(arg0, UnknownEnum.Value_9, UnknownEnum.Value_0, "Moldorm"))
                exit;
            
            break;
    }
    
    WallArray[0] = struct_exists(global.Level.Rooms[arg0].Template, "WallsLower") ? global.Level.Rooms[arg0].Template.WallsLower : array_create(0);
    WallArray[1] = global.Level.Rooms[arg0].Template.WallsUpper;
    Walls[0] = array_length(WallArray[0]);
    Walls[1] = array_length(WallArray[1]);
    WallData[0] = array_create(0);
    WallData[1] = array_create(0);
    
    for (var _FloorLevel = 0; _FloorLevel < 2; _FloorLevel++)
    {
        if (Walls[_FloorLevel] == 0)
            continue;
        
        for (var WallIndex = 0; WallIndex < Walls[_FloorLevel]; WallIndex++)
        {
            if (GetPropertyValue(WallArray[_FloorLevel][WallIndex].properties, "NoDecor") != -1)
                continue;
            
            var Wall = WallArray[_FloorLevel][WallIndex];
            var WallX = global.Level.Rooms[arg0].x + Wall.x;
            var WallY = global.Level.Rooms[arg0].y + Wall.y;
            var GID = Wall.gid;
            var WallTileW = Wall.width / 8;
            var WallTileH = Wall.height / 8;
            var GID_T = GID == UnknownEnum.Value_32 || GID == UnknownEnum.Value_28;
            var GID_B = GID == UnknownEnum.Value_29 || GID == UnknownEnum.Value_25;
            var GID_L = GID == UnknownEnum.Value_30 || GID == UnknownEnum.Value_26;
            var GID_R = GID == UnknownEnum.Value_31 || GID == UnknownEnum.Value_27;
            var GID_TB = GID_T || GID_B;
            var GID_LR = GID_L || GID_R;
            
            if (GID_TB || GID_LR)
            {
                if (GID_TB && WallTileW < 4)
                {
                }
                else if (GID_LR && WallTileH < 4)
                {
                }
                else
                {
                    var WallDataIndex = array_length(WallData[_FloorLevel]);
                    array_insert(WallData[_FloorLevel], WallDataIndex, StructCopy(WallArray[_FloorLevel][WallIndex]));
                    Wall = WallData[_FloorLevel][WallDataIndex];
                    Wall.x = WallX;
                    Wall.y = WallY;
                    Wall.TileW = WallTileW;
                    Wall.TileH = WallTileH;
                    Wall.Doors = array_create(0);
                    Wall.WallSegments = array_create(GID_TB ? WallTileW : WallTileH, UnknownEnum.Value_1);
                }
            }
        }
    }
    
    WallDataCount[0] = array_length(WallData[0]);
    WallDataCount[1] = array_length(WallData[1]);
    var _CurtainType = LevelCurtainType(global.Level.Index);
    
    with (oDoor)
    {
        if (!point_in_rectangle(x, y, global.Level.Rooms[arg0].x, global.Level.Rooms[arg0].y, (global.Level.Rooms[arg0].x + global.Level.Rooms[arg0].width) - 1, (global.Level.Rooms[arg0].y + global.Level.Rooms[arg0].height) - 1))
            continue;
        
        for (var WallDataIndex = 0; WallDataIndex < other.WallDataCount[FloorLevel]; WallDataIndex++)
        {
            var Wall = other.WallData[FloorLevel][WallDataIndex];
            var WallTileW = array_length(Wall.WallSegments);
            var GID_T = Wall.gid == UnknownEnum.Value_32 || Wall.gid == UnknownEnum.Value_28;
            var GID_B = Wall.gid == UnknownEnum.Value_29 || Wall.gid == UnknownEnum.Value_25;
            
            if (point_in_rectangle(x, y, Wall.x, Wall.y, (Wall.x + Wall.width) - 1, (Wall.y + Wall.height) - 1))
            {
                array_push(Wall.Doors, id);
                break;
            }
        }
        
        if (FloorLevel == 0 || Status != UnknownEnum.Value_0 || Entrance)
            continue;
        
        if (_CurtainType == UnknownEnum.Value_1)
        {
            var ToSpecialRoom = false;
            
            if (ConnectedRoomIndex != -1)
                ToSpecialRoom = global.Level.DungeonTemplate.Rooms[ConnectedRoomIndex].SpecialObj == UnknownEnum.Value_5;
            
            if (Prob(0.2) || (ToSpecialRoom && Prob(0.75)))
            {
                var PosX = x;
                var PosY = y;
                var DoorLocation = Location;
                
                switch (Location)
                {
                    case "Bottom":
                        PosY -= 8;
                        break;
                    
                    case "Right":
                        PosX -= 8;
                        break;
                }
                
                var _CurtainInst = instance_create_layer(PosX, PosY, "Objs_Upper", oCurtain, 
                {
                    Location: DoorLocation,
                    DoorInst: id
                });
            }
        }
    }
    
    for (var _FloorLevel = 0; _FloorLevel < 2; _FloorLevel++)
    {
        var _TMID = (_FloorLevel == 0) ? global.TMID_Floor_Lower : global.TMID_Floor_Upper;
        
        for (var WallDataIndex = 0; WallDataIndex < WallDataCount[_FloorLevel]; WallDataIndex++)
        {
            var Wall = WallData[_FloorLevel][WallDataIndex];
            var WallX = Wall.x;
            var WallY = Wall.y;
            var WallW = Wall.width;
            var WallH = Wall.height;
            var WallTileW = array_length(Wall.WallSegments);
            var WallGID = Wall.gid;
            
            for (var SegIndex = 0; SegIndex < WallTileW; SegIndex++)
            {
                switch (Wall.gid)
                {
                    case UnknownEnum.Value_32:
                        var SegPosX = WallX + (SegIndex * 8);
                        
                        if (collision_rectangle(SegPosX, WallY, SegPosX + 7, WallY + 24, oWallLight, false, true) != -4 || collision_rectangle(SegPosX, WallY, SegPosX + 7, WallY + 24, oCurtain, false, true) != -4 || collision_rectangle(SegPosX, WallY, SegPosX + 7, WallY + 24, oDoor, false, true) != -4)
                        {
                            Decor_Wall_SetSegmentStatus(Wall, SegIndex, 1, UnknownEnum.Value_0);
                            break;
                        }
                        
                        if (tilemap_get_at_pixel(_TMID, SegPosX, WallY + 24) == GetTileID(28, 0))
                        {
                            Decor_Wall_SetSegmentStatus(Wall, SegIndex, 1, UnknownEnum.Value_3);
                            break;
                        }
                        
                        if (collision_rectangle(SegPosX, WallY + 24, SegPosX + 7, WallY + 32, oWall, false, true) != -4 || tilemap_get_at_pixel(_TMID, SegPosX, WallY + 24) == 0)
                        {
                            Decor_Wall_SetSegmentStatus(Wall, SegIndex, 1, UnknownEnum.Value_2);
                            break;
                        }
                        
                        break;
                    
                    case UnknownEnum.Value_29:
                        var SegPosX = WallX + (SegIndex * 8);
                        
                        if (collision_rectangle(SegPosX, WallY, SegPosX + 7, WallY + 24, oWallLight, false, true) != -4 || collision_rectangle(SegPosX, WallY, SegPosX + 7, WallY + 24, oCurtain, false, true) != -4 || collision_rectangle(SegPosX, WallY, SegPosX + 7, WallY + 24, oDoor, false, true) != -4)
                        {
                            Decor_Wall_SetSegmentStatus(Wall, SegIndex, 1, UnknownEnum.Value_0);
                            break;
                        }
                        
                        if (collision_rectangle(SegPosX, WallY - 8, SegPosX + 7, WallY - 1, oWall, false, true) != -4 || tilemap_get_at_pixel(_TMID, SegPosX, WallY - 1) == 0)
                        {
                            Decor_Wall_SetSegmentStatus(Wall, SegIndex, 1, UnknownEnum.Value_2);
                            break;
                        }
                        
                        break;
                    
                    case UnknownEnum.Value_30:
                        var SegPosY = WallY + (SegIndex * 8);
                        
                        if (collision_rectangle(WallX, SegPosY, WallX + 24, SegPosY + 7, oWallLight, false, true) != -4 || collision_rectangle(WallX, SegPosY, WallX + 24, SegPosY + 7, oCurtain, false, true) != -4 || collision_rectangle(WallX, SegPosY, WallX + 24, SegPosY + 7, oDoor, false, true) != -4)
                        {
                            Decor_Wall_SetSegmentStatus(Wall, SegIndex, 1, UnknownEnum.Value_0);
                            break;
                        }
                        
                        if (tilemap_get_at_pixel(_TMID, WallX + 24, SegPosY) == GetTileID(27, 1))
                        {
                            Decor_Wall_SetSegmentStatus(Wall, SegIndex, 1, UnknownEnum.Value_3);
                            break;
                        }
                        
                        if (collision_rectangle(WallX + 24, SegPosY, WallX + 32, SegPosY + 7, oWall, false, true) != -4 || tilemap_get_at_pixel(_TMID, WallX + 24, SegPosY) == 0)
                        {
                            Decor_Wall_SetSegmentStatus(Wall, SegIndex, 1, UnknownEnum.Value_2);
                            break;
                        }
                        
                        break;
                    
                    case UnknownEnum.Value_31:
                        var SegPosY = WallY + (SegIndex * 8);
                        
                        if (collision_rectangle(WallX, SegPosY, WallX + 24, SegPosY + 7, oWallLight, false, true) != -4 || collision_rectangle(WallX, SegPosY, WallX + 24, SegPosY + 7, oCurtain, false, true) != -4 || collision_rectangle(WallX, SegPosY, WallX + 24, SegPosY + 7, oDoor, false, true) != -4)
                        {
                            Decor_Wall_SetSegmentStatus(Wall, SegIndex, 1, UnknownEnum.Value_0);
                            break;
                        }
                        
                        if (tilemap_get_at_pixel(_TMID, WallX - 1, SegPosY) == GetTileID(29, 1))
                        {
                            Decor_Wall_SetSegmentStatus(Wall, SegIndex, 1, UnknownEnum.Value_3);
                            break;
                        }
                        
                        if (collision_rectangle(WallX - 8, SegPosY, WallX - 1, SegPosY + 7, oWall, false, true) != -4 || tilemap_get_at_pixel(_TMID, WallX - 1, SegPosY) == 0)
                        {
                            Decor_Wall_SetSegmentStatus(Wall, SegIndex, 1, UnknownEnum.Value_2);
                            break;
                        }
                        
                        break;
                }
            }
        }
    }
    
    for (var _FloorLevel = 0; _FloorLevel < 2; _FloorLevel++)
    {
        var _TMID = (_FloorLevel == 0) ? global.TMID_Decor_Lower : global.TMID_Decor_Upper;
        
        for (var WallDataIndex = 0; WallDataIndex < WallDataCount[_FloorLevel]; WallDataIndex++)
        {
            var Wall = WallData[_FloorLevel][WallDataIndex];
            var WallTileW = array_length(Wall.WallSegments);
            var _MaxCracks = min(floor(WallTileW / 2), Cracks_MaxAmount());
            var _Cracks = irandom(_MaxCracks);
            
            for (var i = 0; i < _Cracks; i++)
            {
                var Segment = irandom(WallTileW - 2);
                var _Mirror = FlipCoin_Bool();
                var _Flip = false;
                var _Rotate = false;
                
                if (Decor_Wall_GetSegmentStatus(Wall, UnknownEnum.Value_5, Segment, 2))
                {
                    var PosX, PosY;
                    
                    switch (Wall.gid)
                    {
                        case UnknownEnum.Value_32:
                        case UnknownEnum.Value_28:
                            PosX = Wall.x + (Segment * 8);
                            PosY = Wall.y + 8;
                            break;
                        
                        case UnknownEnum.Value_29:
                        case UnknownEnum.Value_25:
                            PosX = Wall.x + (Segment * 8);
                            PosY = Wall.y;
                            _Flip = true;
                            break;
                        
                        case UnknownEnum.Value_30:
                        case UnknownEnum.Value_26:
                            PosX = Wall.x + 8;
                            PosY = Wall.y + (Segment * 8);
                            _Flip = true;
                            _Rotate = true;
                            break;
                        
                        case UnknownEnum.Value_31:
                        case UnknownEnum.Value_27:
                            PosX = Wall.x;
                            PosY = Wall.y + (Segment * 8);
                            _Rotate = true;
                            break;
                    }
                    
                    DrawTileBlock(_TMID, PosX, PosY, 94, 4 + ((global.Level.Index - 1) * 6) + 4, 2, 2, _Mirror, _Flip, _Rotate);
                }
            }
        }
    }
    
    global.RoomLightsOn = 0;
    global.RoomLightsOn_Max = min(3 * global.Level.Rooms[arg0].GridW * global.Level.Rooms[arg0].GridH, 8);
    global.ReplacedMuralWithLight = false;
    
    for (var WallDataIndex = 0; WallDataIndex < WallDataCount[1]; WallDataIndex++)
    {
        var Wall = WallData[1][WallDataIndex];
        var WallX = Wall.x;
        var WallY = Wall.y;
        var WallW = Wall.width;
        var WallH = Wall.height;
        var WallTileW = array_length(Wall.WallSegments);
        var WallGID = Wall.gid;
        var PropertiesArray = Wall.properties;
        var Light = GetPropertyValue(PropertiesArray, "Light");
        var Doors = array_length(Wall.Doors);
        var ColumnCount = floor(WallTileW / 4);
        
        if (Doors == 0)
        {
            var _Column = (ColumnCount > 2) ? UnknownEnum.Value_2 : UnknownEnum.Value_0;
            var _DecorType;
            
            switch (global.Level.Index)
            {
                default:
                    _DecorType = choose(UnknownEnum.Value_0, _Column, UnknownEnum.Value_4, UnknownEnum.Value_4, UnknownEnum.Value_4);
                    break;
                
                case UnknownEnum.Value_4:
                    _DecorType = choose(UnknownEnum.Value_0, UnknownEnum.Value_0, _Column, UnknownEnum.Value_4);
                    break;
                
                case UnknownEnum.Value_12:
                    if (WallGID == UnknownEnum.Value_32 && (WallTileW % 2) == 0)
                        _DecorType = choose(UnknownEnum.Value_0, _Column, UnknownEnum.Value_1, UnknownEnum.Value_4, UnknownEnum.Value_4, UnknownEnum.Value_4);
                    else
                        _DecorType = choose(UnknownEnum.Value_0, _Column, UnknownEnum.Value_4, UnknownEnum.Value_4, UnknownEnum.Value_4);
                    
                    break;
            }
            
            if (Light != -1 && !global.Challenges[UnknownEnum.Value_4])
                _DecorType = UnknownEnum.Value_4;
            
            switch (_DecorType)
            {
                case UnknownEnum.Value_0:
                    var MuralStyle = FlipCoin_Bin();
                    
                    switch (global.Level.Index)
                    {
                        case UnknownEnum.Value_4:
                            Decor_Draw_FillWall(arg0, Wall, _DecorType, floor(WallTileW / 5), MuralStyle);
                            break;
                        
                        default:
                            Decor_Draw_FillWall(arg0, Wall, _DecorType, choose(0, irandom(floor(WallTileW / 7))), MuralStyle);
                            break;
                    }
                    
                    break;
                
                case UnknownEnum.Value_1:
                    var MuralStyle = FlipCoin_Bin();
                    Decor_Draw_FillWall(arg0, Wall, _DecorType, irandom_range(1, floor(WallTileW / 11)), MuralStyle);
                    break;
                
                case UnknownEnum.Value_2:
                    Decor_Draw_FillWall(arg0, Wall, _DecorType, ColumnCount);
                    break;
                
                case UnknownEnum.Value_4:
                    Decor_Draw_FillWall(arg0, Wall, _DecorType, floor(WallTileW / 22), 1);
                    break;
            }
        }
        else if (Doors == 1 && WallTileW >= 18)
        {
            var DecorStyle = 0;
            var _DecorType;
            
            if (ColumnCount > 2)
                _DecorType = choose(UnknownEnum.Value_0, UnknownEnum.Value_2);
            else
                _DecorType = UnknownEnum.Value_0;
            
            if (_DecorType == UnknownEnum.Value_0)
                DecorStyle = FlipCoin_Bin();
            
            var _DecorTileW = global.DecorTileW[_DecorType];
            var _Door = Wall.Doors[0];
            var DoorPosX = _Door.x;
            var DoorPosY = _Door.y;
            var SegmentIndex;
            
            if (WallGID == UnknownEnum.Value_32 || WallGID == UnknownEnum.Value_29)
                SegmentIndex = (DoorPosX - WallX) / 8;
            else
                SegmentIndex = (DoorPosY - WallY) / 8;
            
            Decor_FillWallFromSegment(arg0, Wall, _DecorType, SegmentIndex + 6, 4, 1, DecorStyle);
            Decor_FillWallFromSegment(arg0, Wall, _DecorType, SegmentIndex - _DecorTileW - 2, 4, -1, DecorStyle);
        }
    }
    
    var _LevelCurtainType = LevelCurtainType(global.Level.Index);
    
    for (var WallDataIndex = 0; WallDataIndex < WallDataCount[1]; WallDataIndex++)
    {
        var Wall = WallData[1][WallDataIndex];
        
        if (_LevelCurtainType != UnknownEnum.Value_1 || Wall.gid == UnknownEnum.Value_29)
            continue;
        
        var WallTileW = array_length(Wall.WallSegments);
        
        repeat (irandom(6 * min(global.Level.Rooms[arg0].GridW * global.Level.Rooms[arg0].GridH, 2)))
        {
            var _CurtainInst = -4;
            var WallPosX = Wall.x;
            var WallPosY = Wall.y;
            var Segment = irandom(WallTileW - 4);
            
            switch (Wall.gid)
            {
                case UnknownEnum.Value_32:
                    if (Decor_Wall_GetSegmentStatus(Wall, UnknownEnum.Value_3, Segment, 4))
                    {
                        Decor_Wall_SetSegmentStatus(Wall, Segment, 4, UnknownEnum.Value_0);
                        _CurtainInst = instance_create_layer(WallPosX + (Segment * 8), WallPosY, "Objs_Upper", oCurtain, 
                        {
                            Location: (Wall.gid == UnknownEnum.Value_32) ? "Top" : "Bottom",
                            DoorInst: -4
                        });
                    }
                    
                    break;
                
                case UnknownEnum.Value_31:
                    WallPosX -= 8;
                
                case UnknownEnum.Value_30:
                    if (Decor_Wall_GetSegmentStatus(Wall, UnknownEnum.Value_3, Segment, 4))
                    {
                        Decor_Wall_SetSegmentStatus(Wall, Segment, 4, UnknownEnum.Value_0);
                        _CurtainInst = instance_create_layer(WallPosX, WallPosY + (Segment * 8), "Objs_Upper", oCurtain, 
                        {
                            Location: (Wall.gid == UnknownEnum.Value_30) ? "Left" : "Right",
                            DoorInst: -4
                        });
                    }
                    
                    break;
            }
            
            if (_CurtainInst != -4)
            {
                with (_CurtainInst)
                {
                    if (instance_place(x, y, oPot) != -4)
                    {
                        instance_destroy(self);
                        _CurtainInst = -4;
                        break;
                    }
                    
                    if (instance_place(x, y, oCrystalSwitch) != -4)
                    {
                        instance_destroy(self);
                        _CurtainInst = -4;
                        break;
                    }
                    
                    if (instance_place(x, y, oItem) != -4)
                    {
                        instance_destroy(self);
                        _CurtainInst = -4;
                        break;
                    }
                    
                    if (instance_place(x, y, oCurtain) != -4)
                    {
                        instance_destroy(self);
                        _CurtainInst = -4;
                        break;
                    }
                    
                    if (instance_place(x, y, oWallLight) != -4)
                    {
                        instance_destroy(self);
                        _CurtainInst = -4;
                        break;
                    }
                }
            }
        }
    }
    
    WallArray = 0;
    Walls = 0;
    WallData = 0;
    WallDataCount = 0;
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
    Value_9 = 9,
    Value_10,
    Value_11,
    Value_12,
    Value_13,
    Value_25 = 25,
    Value_26,
    Value_27,
    Value_28,
    Value_29,
    Value_30,
    Value_31,
    Value_32
}
