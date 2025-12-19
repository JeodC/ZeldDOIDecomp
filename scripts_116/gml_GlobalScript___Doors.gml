function Dungeon_CreateDoors(arg0)
{
    if (global.Level.Index == UnknownEnum.Value_0)
        exit;
    
    var DoorsSprSurface = surface_create(global.Level.Rooms[arg0].width / 8, global.Level.Rooms[arg0].height / 8);
    surface_set_target(DoorsSprSurface);
    draw_clear_alpha(c_black, 0);
    
    for (var DoorIndex = 0; DoorIndex < global.Level.Rooms[arg0].DoorCount; DoorIndex++)
    {
        var _Door = global.Level.Rooms[arg0].Doors[DoorIndex];
        
        if (_Door.Status == UnknownEnum.Value_11)
            continue;
        
        var TLCornerX = global.Level.Rooms[arg0].x + _Door.x;
        var TLCornerY = global.Level.Rooms[arg0].y + _Door.y;
        var FloorLevelStr = GetFloorLevelString(_Door.Level);
        var _DoorInst = instance_create_layer(TLCornerX, TLCornerY, "ObjsDoors_" + FloorLevelStr, oDoor);
        _DoorInst.RoomIndex = arg0;
        _DoorInst.FloorLevel = _Door.Level;
        _DoorInst.Location = _Door.Location;
        _DoorInst.Position = _Door.Position;
        _DoorInst.Status = _Door.Status;
        
        if (_DoorInst.Status == UnknownEnum.Value_3)
            _DoorInst.Entrance = true;
        
        _DoorInst.ConnectedRoomIndex = _Door.ConnectedRoomIndex;
        
        if (_DoorInst.Status == UnknownEnum.Value_8)
        {
            _DoorInst.SecretType = -1;
            
            switch (global.Level.Index)
            {
                case UnknownEnum.Value_1:
                    _DoorInst.SecretType = UnknownEnum.Value_0;
                    break;
                
                case UnknownEnum.Value_5:
                    if (TemplateCheck(_DoorInst.ConnectedRoomIndex, UnknownEnum.Value_9, UnknownEnum.Value_2, "TMNT") || TemplateCheck(arg0, UnknownEnum.Value_9, UnknownEnum.Value_2, "TMNT"))
                        _DoorInst.SecretType = UnknownEnum.Value_0;
                    
                    break;
                
                case UnknownEnum.Value_6:
                case UnknownEnum.Value_10:
                    _DoorInst.SecretType = UnknownEnum.Value_1;
                    break;
            }
            
            if (_DoorInst.SecretType == -1)
            {
                if (TemplateCheck(_DoorInst.ConnectedRoomIndex, UnknownEnum.Value_8, UnknownEnum.Value_4) || TemplateCheck(arg0, UnknownEnum.Value_8, UnknownEnum.Value_4))
                    _DoorInst.SecretType = choose(UnknownEnum.Value_1, UnknownEnum.Value_2);
                else
                    _DoorInst.SecretType = Prob(0.5) ? UnknownEnum.Value_0 : choose(UnknownEnum.Value_1, UnknownEnum.Value_2);
            }
        }
        
        if (global.Level.Index == UnknownEnum.Value_10)
        {
            if (global.MainTemplates_Mine[global.Level.Rooms[arg0].GridY][global.Level.Rooms[arg0].GridX] == 1 || global.MainTemplates_Mine[global.Level.Rooms[arg0].GridY][global.Level.Rooms[arg0].GridX] >= 7)
            {
                _DoorInst.Status = UnknownEnum.Value_8;
                _DoorInst.SecretType = UnknownEnum.Value_1;
            }
        }
        
        if (global.Level.IsBossLevel && arg0 == global.Level.RoomIndex_Boss)
            _DoorInst.Status = UnknownEnum.Value_1;
        
        if (_DoorInst.Status == UnknownEnum.Value_2 || _DoorInst.Status == UnknownEnum.Value_4)
            ds_list_add(global.LargeMapItems, _DoorInst);
        
        var TMID_Walls;
        
        if (_DoorInst.FloorLevel == 1)
        {
            TMID_Walls = global.TMID_Walls_Upper;
            var TMID_Decor = global.TMID_Decor_Upper;
        }
        else
        {
            TMID_Walls = global.TMID_Walls_Lower;
            var TMID_Decor = global.TMID_Decor_Lower;
        }
        
        switch (_DoorInst.Location)
        {
            case "Top":
                if (global.Level.Index == UnknownEnum.Value_13)
                    ClearTileBlock(TMID_Walls, TLCornerX, TLCornerY - 16, 4, 5);
                else
                    ClearTileBlock(TMID_Walls, TLCornerX + 8, TLCornerY + 8, 2, 2);
                
                var WallObjInst = collision_point(TLCornerX + 4, TLCornerY + 4, oWall, false, true);
                
                if (WallObjInst != -4)
                    WallObj_Cutout_H(WallObjInst, TLCornerX + 8, TLCornerX + 23);
                
                break;
            
            case "Bottom":
                ClearTileBlock(TMID_Walls, TLCornerX + 8, TLCornerY, 2, 2);
                var WallObjInst = collision_point(TLCornerX + 4, TLCornerY + 4, oWall, false, true);
                
                if (WallObjInst != -4)
                    WallObj_Cutout_H(WallObjInst, TLCornerX + 8, TLCornerX + 23);
                
                break;
            
            case "Left":
            case "Right":
                ClearTileBlock(TMID_Walls, TLCornerX + ((_DoorInst.Location == "Left") ? 8 : 0), TLCornerY + 8, 2, 2);
                var WallObjInst = collision_point(TLCornerX + 4, TLCornerY + 4, oWall, false, true);
                
                if (WallObjInst != -4)
                    WallObj_Cutout_V(WallObjInst, TLCornerY + 8, TLCornerY + 23);
                
                break;
        }
        
        Door_SetPassageArea(_DoorInst);
        var WallX, WallY, ScaleX, ScaleY, WallGID, Position;
        
        switch (_DoorInst.Location)
        {
            case "Top":
                WallX = TLCornerX + 8;
                WallY = TLCornerY;
                WallGID = (_DoorInst.FloorLevel == 1) ? UnknownEnum.Value_32 : UnknownEnum.Value_28;
                ScaleX = 2;
                ScaleY = 3;
                Position = 1;
                break;
            
            case "Left":
                WallX = TLCornerX;
                WallY = TLCornerY + 8;
                WallGID = (_DoorInst.FloorLevel == 1) ? UnknownEnum.Value_30 : UnknownEnum.Value_26;
                ScaleX = 3;
                ScaleY = 2;
                Position = 3;
                break;
            
            case "Bottom":
                WallX = TLCornerX + 8;
                WallY = TLCornerY;
                WallGID = (_DoorInst.FloorLevel == 1) ? UnknownEnum.Value_29 : UnknownEnum.Value_25;
                ScaleX = 2;
                ScaleY = 3;
                Position = 2;
                break;
            
            case "Right":
                WallX = TLCornerX;
                WallY = TLCornerY + 8;
                WallGID = (_DoorInst.FloorLevel == 1) ? UnknownEnum.Value_31 : UnknownEnum.Value_27;
                ScaleX = 3;
                ScaleY = 2;
                Position = 4;
                break;
        }
        
        var inst = WallObj_Create("Objs_" + FloorLevelStr, WallX, WallY, ScaleX, ScaleY, _DoorInst.Location, WallGID);
        inst.FloorLevel = _DoorInst.FloorLevel;
        inst.BlockLink = false;
        inst.BlockLinkCarry = _DoorInst.Status == UnknownEnum.Value_4;
        inst.BlockItems = true;
        inst.IsDoorEntrance = true;
        inst.Position = Position;
        _DoorInst.WallInst = inst;
        
        if (_DoorInst.SecretType != -1)
            continue;
        
        if (global.Level.Index == UnknownEnum.Value_10)
        {
            if (global.Level.Rooms[arg0].GridX == 4 && global.Level.Rooms[arg0].GridY == 4 && _DoorInst.Location != "Top" && _DoorInst.Location != "Right")
                continue;
            
            if (global.Level.Rooms[arg0].GridX == 6 && global.Level.Rooms[arg0].GridY == 0 && _DoorInst.Location == "Left")
                continue;
        }
        
        var MapDoorX = (TLCornerX - global.Level.Rooms[arg0].x) / 8;
        var MapDoorY = (TLCornerY - global.Level.Rooms[arg0].y) / 8;
        var Dx, Dy, Dw, Dh;
        
        switch (_DoorInst.Location)
        {
            case "Top":
                Dx = MapDoorX;
                Dy = MapDoorY - 5;
                Dw = 4;
                Dh = 8;
                break;
            
            case "Bottom":
                Dx = MapDoorX;
                Dy = MapDoorY;
                Dw = 4;
                Dh = 8;
                break;
            
            case "Left":
                Dx = MapDoorX - 5;
                Dy = MapDoorY;
                Dw = 8;
                Dh = 4;
                break;
            
            case "Right":
                Dx = MapDoorX;
                Dy = MapDoorY;
                Dw = 8;
                Dh = 4;
                break;
        }
        
        draw_sprite_ext(sPixel, 0, Dx, Dy, Dw, Dh, 0, #6E6E6E, 1);
    }
    
    surface_reset_target();
    global.Level.Rooms[arg0].MapSpr_Doors = sprite_create_from_surface(DoorsSprSurface, 0, 0, global.Level.Rooms[arg0].MapW, global.Level.Rooms[arg0].MapH, false, false, 0, 0);
    surface_free(DoorsSprSurface);
}

function Door_DrawTiles(arg0)
{
    with (arg0)
    {
        var TMID_Decor = (FloorLevel == 1) ? global.TMID_Decor_Upper : global.TMID_Decor_Lower;
        var TMID_Walls = (FloorLevel == 1) ? global.TMID_Walls_Upper : global.TMID_Walls_Lower;
        var TMID_Floor = (FloorLevel == 1) ? global.TMID_Floor_Upper : global.TMID_Floor_Lower;
        var WallLevel = (FloorLevel == 1) ? 0 : 1;
        var TilesY = (global.Level.Rooms[RoomIndex].ForcedTheme != -1 && global.Level.Rooms[RoomIndex].ForcedTheme <= 11) ? (4 + (global.Level.Rooms[RoomIndex].ForcedTheme * 6)) : ((global.Level.Index == UnknownEnum.Value_13) ? 70 : (4 + ((global.Level.Index - 1) * 6)));
        var TMID_Beam = (FloorLevel == 1) ? global.TMID_Tiles_Highest : global.TMID_Walls_Upper;
        
        switch (Location)
        {
            case "Top":
                if (!global.SaveLevel && (global.Level.IsBossLevel && global.Level.Index != UnknownEnum.Value_13) && ConnectedRoomIndex == global.Level.RoomIndex_Boss)
                {
                    DrawTileBlock(TMID_Floor, x, y + 32, 52, 2, 2, 2);
                    DrawTileBlock(TMID_Floor, x + 16, y + 32, 52, 2, 2, 2);
                    DrawTileBlock(TMID_Floor, x, y + 48, 52, 2, 2, 2);
                    DrawTileBlock(TMID_Floor, x + 16, y + 48, 52, 2, 2, 2);
                    DrawTileBlock(TMID_Floor, x - 16, y + 32, 52, 2, 2, 2);
                    DrawTileBlock(TMID_Floor, x - 16, y + 48, 52, 2, 2, 2);
                    DrawTileBlock(TMID_Floor, x + 32, y + 32, 52, 2, 2, 2);
                    DrawTileBlock(TMID_Floor, x + 32, y + 48, 52, 2, 2, 2);
                    DrawTileBlock(TMID_Decor, x, y + 40, 52, 0, 4, 2);
                    var TileX = (global.Level.Index == UnknownEnum.Value_3) ? 40 : ((global.Level.Index == UnknownEnum.Value_7) ? 44 : 48);
                    DrawTileBlock(TMID_Decor, x - 16, y, TileX, 0, 2, 4);
                    DrawTileBlock(TMID_Decor, x + 32, y, TileX + 2, 0, 2, 4);
                }
                
                if (Status != UnknownEnum.Value_8 && Status != UnknownEnum.Value_9)
                {
                    DrawTileBlock(TMID_Decor, x, y + 8, 70, TilesY, 1, 2);
                    DrawTileBlock(TMID_Decor, x + 24, y + 8, 71, TilesY, 1, 2);
                    
                    switch (Status)
                    {
                        case UnknownEnum.Value_4:
                            DrawTileBlock(TMID_Beam, x, y, 58, TilesY, 4, 1);
                            break;
                        
                        default:
                            if (RoomIndex == global.Level.RoomIndex_Boss)
                            {
                                DrawTileBlock(TMID_Decor, x, y, 50 + ((FloorLevel == 0) ? 4 : 0), TilesY, 4, 1);
                                break;
                            }
                            
                            DrawTileBlock(TMID_Beam, x, y, 50 + ((FloorLevel == 0) ? 4 : 0), TilesY, 4, 1);
                    }
                }
                
                switch (Status)
                {
                    case UnknownEnum.Value_0:
                    case UnknownEnum.Value_10:
                        if (AddTracks)
                        {
                            DrawTileBlock(TMID_Decor, x + 8, y + 8, 128, 76, 2, 2);
                            break;
                        }
                        else
                        {
                            switch (LightingFrame)
                            {
                                case UnknownEnum.Value_0:
                                case UnknownEnum.Value_2:
                                    DrawTileBlock(TMID_Decor, x + 8, y + 8, 72, 2, 2, 2);
                                    break;
                                
                                case UnknownEnum.Value_1:
                                    DrawTileBlock(TMID_Decor, x + 8, y + 8, 70, 0, 2, 2);
                                    break;
                                
                                case UnknownEnum.Value_3:
                                    DrawTileBlock(TMID_Decor, x + 8, y + 8, 74, TilesY, 2, 2);
                                    break;
                            }
                        }
                        
                        break;
                    
                    case UnknownEnum.Value_1:
                        DrawTileBlock(TMID_Decor, x, y + 8, 70, TilesY + 4, 4, 2);
                        break;
                    
                    case UnknownEnum.Value_6:
                        DrawTileBlock(TMID_Decor, x, y + 8, 74, TilesY + 4, 4, 2);
                        break;
                    
                    case UnknownEnum.Value_2:
                        DrawTileBlock(TMID_Decor, x, y + 8, 86, TilesY, 4, 2);
                        break;
                    
                    case UnknownEnum.Value_7:
                        DrawTileBlock(TMID_Decor, x, y + 8, 86, TilesY + 2, 4, 2);
                        break;
                    
                    case UnknownEnum.Value_8:
                        switch (arg0.SecretType)
                        {
                            case UnknownEnum.Value_0:
                                DrawTileBlock(TMID_Walls, x + 8, y, 6 + (WallLevel * 17), TilesY, 2, 3);
                                DrawTileBlock(TMID_Decor, x + 8, y + 8, 94, TilesY + 4, 2, 2);
                                break;
                            
                            case UnknownEnum.Value_1:
                                DrawTileBlock(TMID_Walls, x + 8, y, 6 + (WallLevel * 17), TilesY, 2, 3);
                                break;
                        }
                        
                        break;
                    
                    case UnknownEnum.Value_9:
                        switch (arg0.SecretType)
                        {
                            case UnknownEnum.Value_1:
                            case UnknownEnum.Value_0:
                                ClearTileBlock(TMID_Walls, x + 8, y + 8, 2, 2);
                                ClearTileBlock(TMID_Decor, x + 8, y + 8, 2, 2);
                                
                                switch (arg0.FloorLevel)
                                {
                                    case 1:
                                        DrawTileBlock(TMID_Decor, x, y + 8, 98, TilesY, 1, 2);
                                        DrawTileBlock(TMID_Decor, x + 24, y + 8, 99, TilesY, 1, 2);
                                        DrawTileBlock(TMID_Beam, x, y, 62, TilesY + 4, 4, 1);
                                        break;
                                    
                                    case 0:
                                        DrawTileBlock(TMID_Decor, x, y + 8, 102, TilesY, 1, 2);
                                        DrawTileBlock(TMID_Decor, x + 24, y + 8, 103, TilesY, 1, 2);
                                        DrawTileBlock(TMID_Beam, x, y, 66, TilesY + 4, 4, 1);
                                        break;
                                }
                                
                                switch (LightingFrame)
                                {
                                    case UnknownEnum.Value_0:
                                    case UnknownEnum.Value_2:
                                        DrawTileBlock(TMID_Decor, x + 8, y + 8, 72, 2, 2, 2);
                                        break;
                                    
                                    case UnknownEnum.Value_1:
                                        DrawTileBlock(TMID_Decor, x + 8, y + 8, 70, 0, 2, 2);
                                        break;
                                    
                                    case UnknownEnum.Value_3:
                                        DrawTileBlock(TMID_Decor, x + 8, y + 8, 106, TilesY, 2, 2);
                                        break;
                                }
                                
                                break;
                            
                            case UnknownEnum.Value_2:
                                for (var i = 0; i < 4; i++)
                                {
                                    var _x = x + (i * 8);
                                    var _TileX = 6 + (((_x % 16) == 0) ? 1 : 0) + (WallLevel * 17);
                                    DrawTileBlock(TMID_Beam, _x, y, _TileX, TilesY, 1, 1);
                                    DrawTileBlock(TMID_Walls, _x, y + 8, _TileX, TilesY + 1, 1, 2);
                                }
                                
                                break;
                        }
                        
                        break;
                    
                    case UnknownEnum.Value_4:
                        DrawTileBlock(TMID_Decor, x + 8, y + 8, 60, TilesY + 2, 2, 2);
                        break;
                }
                
                break;
            
            case "Bottom":
                if (Status == UnknownEnum.Value_3 && global.Level.Index == UnknownEnum.Value_1)
                {
                    DrawTileBlock(TMID_Floor, x + 8, y, 63, 1, 2, 2);
                    DrawTileBlock(TMID_Decor, x, y, 62, 1, 1, 2);
                    DrawTileBlock(TMID_Decor, x + 24, y, 65, 1, 1, 2);
                    DrawTileBlock(TMID_Beam, x + 8, y + 16, 9, 8, 2, 1);
                    oLink.Castle_EntranceWallInst = WallObj_Create("Objs_Upper", x, y + 24, 4, 2);
                    oLink.Castle_EntranceWallInst.IsDoorEntrance = true;
                }
                else
                {
                    if (Status != UnknownEnum.Value_8 && Status != UnknownEnum.Value_9)
                    {
                        switch (Status)
                        {
                            case UnknownEnum.Value_4:
                                DrawTileBlock(TMID_Beam, x, y + 16, 58, TilesY, 4, 1);
                                break;
                            
                            default:
                                DrawTileBlock(TMID_Beam, x, y + 16, 50 + ((FloorLevel == 0) ? 4 : 0), TilesY + 1, 4, 1);
                        }
                        
                        DrawTileBlock(TMID_Decor, x, y, 72, TilesY + 2, 1, 2);
                        DrawTileBlock(TMID_Decor, x + 24, y, 73, TilesY + 2, 1, 2);
                    }
                    
                    switch (Status)
                    {
                        case UnknownEnum.Value_0:
                        case UnknownEnum.Value_10:
                            if (AddTracks)
                            {
                                DrawTileBlock(TMID_Decor, x + 8, y, 130, 78, 2, 2);
                                break;
                            }
                            else
                            {
                                switch (LightingFrame)
                                {
                                    case UnknownEnum.Value_0:
                                    case UnknownEnum.Value_2:
                                        DrawTileBlock(TMID_Decor, x + 8, y, 70, 0, 2, 2);
                                        break;
                                    
                                    case UnknownEnum.Value_1:
                                        DrawTileBlock(TMID_Decor, x + 8, y, 72, 2, 2, 2);
                                        break;
                                    
                                    case UnknownEnum.Value_3:
                                        DrawTileBlock(TMID_Decor, x + 8, y, 76, TilesY + 2, 2, 2);
                                        break;
                                }
                            }
                            
                            break;
                        
                        case UnknownEnum.Value_1:
                            DrawTileBlock(TMID_Decor, x, y, 78, TilesY + 4, 4, 2);
                            break;
                        
                        case UnknownEnum.Value_6:
                            DrawTileBlock(TMID_Decor, x, y, 82, TilesY + 4, 4, 2);
                            break;
                        
                        case UnknownEnum.Value_2:
                            DrawTileBlock(TMID_Decor, x, y, 86, TilesY + 4, 4, 2);
                            break;
                        
                        case UnknownEnum.Value_7:
                            DrawTileBlock(TMID_Decor, x, y, 90, TilesY + 4, 4, 2);
                            break;
                        
                        case UnknownEnum.Value_8:
                            switch (arg0.SecretType)
                            {
                                case UnknownEnum.Value_0:
                                    DrawTileBlock(TMID_Walls, x + 8, y, 9 + (WallLevel * 17), TilesY + 2, 2, 3);
                                    DrawTileBlock(TMID_Decor, x + 8, y, 96, TilesY + 4, 2, 2);
                                    break;
                                
                                case UnknownEnum.Value_1:
                                    DrawTileBlock(TMID_Walls, x + 8, y, 9 + (WallLevel * 17), TilesY + 2, 2, 3);
                                    break;
                            }
                            
                            break;
                        
                        case UnknownEnum.Value_9:
                            switch (arg0.SecretType)
                            {
                                case UnknownEnum.Value_1:
                                case UnknownEnum.Value_0:
                                    ClearTileBlock(TMID_Walls, x + 8, y, 2, 2);
                                    ClearTileBlock(TMID_Decor, x + 8, y, 2, 2);
                                    
                                    switch (arg0.FloorLevel)
                                    {
                                        case 1:
                                            DrawTileBlock(TMID_Decor, x, y, 100, TilesY + 2, 1, 2);
                                            DrawTileBlock(TMID_Decor, x + 24, y, 101, TilesY + 2, 1, 2);
                                            DrawTileBlock(TMID_Beam, x, y + 16, 62, TilesY + 5, 4, 1);
                                            break;
                                        
                                        case 0:
                                            DrawTileBlock(TMID_Decor, x, y, 104, TilesY + 2, 1, 2);
                                            DrawTileBlock(TMID_Decor, x + 24, y, 105, TilesY + 2, 1, 2);
                                            DrawTileBlock(TMID_Beam, x, y + 16, 66, TilesY + 5, 4, 1);
                                            break;
                                    }
                                    
                                    switch (LightingFrame)
                                    {
                                        case UnknownEnum.Value_0:
                                        case UnknownEnum.Value_2:
                                            DrawTileBlock(TMID_Decor, x + 8, y, 70, 0, 2, 2);
                                            break;
                                        
                                        case UnknownEnum.Value_1:
                                            DrawTileBlock(TMID_Decor, x + 8, y, 72, 2, 2, 2);
                                            break;
                                        
                                        case UnknownEnum.Value_3:
                                            DrawTileBlock(TMID_Decor, x + 8, y, 108, TilesY + 2, 2, 2);
                                            break;
                                    }
                                    
                                    break;
                                
                                case UnknownEnum.Value_2:
                                    for (var i = 0; i < 4; i++)
                                    {
                                        var _x = x + (i * 8);
                                        var _TileX = 9 + (((_x % 16) == 0) ? 1 : 0) + (WallLevel * 17);
                                        DrawTileBlock(TMID_Walls, _x, y, _TileX, TilesY + 2, 1, 2);
                                        DrawTileBlock(TMID_Beam, _x, y + 16, _TileX, TilesY + 4, 1, 1);
                                    }
                                    
                                    break;
                            }
                            
                            break;
                        
                        case UnknownEnum.Value_4:
                            DrawTileBlock(TMID_Decor, x + 8, y, 58, TilesY + 4, 2, 2);
                            break;
                    }
                }
                
                break;
            
            case "Left":
                if (Status != UnknownEnum.Value_8 && Status != UnknownEnum.Value_9)
                {
                    DrawTileBlock(TMID_Beam, x, y, 62 + ((FloorLevel == 0) ? 2 : 0), TilesY, 1, 4);
                    DrawTileBlock(TMID_Decor, x + 8, y, 70, TilesY + 2, 2, 1);
                    DrawTileBlock(TMID_Decor, x + 8, y + 24, 70, TilesY + 3, 2, 1);
                }
                
                switch (Status)
                {
                    case UnknownEnum.Value_0:
                    case UnknownEnum.Value_10:
                        if (AddTracks)
                        {
                            DrawTileBlock(TMID_Decor, x + 8, y + 8, 128, 78, 2, 2);
                            break;
                        }
                        else
                        {
                            switch (LightingFrame)
                            {
                                case UnknownEnum.Value_0:
                                case UnknownEnum.Value_2:
                                    DrawTileBlock(TMID_Decor, x + 8, y + 8, 72, 0, 2, 2);
                                    break;
                                
                                case UnknownEnum.Value_1:
                                    DrawTileBlock(TMID_Decor, x + 8, y + 8, 70, 2, 2, 2);
                                    break;
                                
                                case UnknownEnum.Value_3:
                                    DrawTileBlock(TMID_Decor, x + 8, y + 8, 74, TilesY + 2, 2, 2);
                                    break;
                            }
                        }
                        
                        break;
                    
                    case UnknownEnum.Value_1:
                        DrawTileBlock(TMID_Decor, x + 8, y, 78, TilesY, 2, 4);
                        break;
                    
                    case UnknownEnum.Value_6:
                        DrawTileBlock(TMID_Decor, x + 8, y, 80, TilesY, 2, 4);
                        break;
                    
                    case UnknownEnum.Value_2:
                        DrawTileBlock(TMID_Decor, x + 8, y, 90, TilesY, 2, 4);
                        break;
                    
                    case UnknownEnum.Value_7:
                        DrawTileBlock(TMID_Decor, x + 8, y, 92, TilesY, 2, 4);
                        break;
                    
                    case UnknownEnum.Value_8:
                        switch (arg0.SecretType)
                        {
                            case UnknownEnum.Value_0:
                                DrawTileBlock(TMID_Walls, x, y + 8, 6 + (WallLevel * 17), TilesY + 3, 3, 2);
                                DrawTileBlock(TMID_Decor, x + 8, y + 8, 98, TilesY + 4, 2, 2);
                                break;
                            
                            case UnknownEnum.Value_1:
                                DrawTileBlock(TMID_Walls, x, y + 8, 6 + (WallLevel * 17), TilesY + 3, 3, 2);
                                break;
                        }
                        
                        break;
                    
                    case UnknownEnum.Value_9:
                        switch (arg0.SecretType)
                        {
                            case UnknownEnum.Value_1:
                            case UnknownEnum.Value_0:
                                ClearTileBlock(TMID_Walls, x + 8, y + 8, 2, 2);
                                ClearTileBlock(TMID_Decor, x + 8, y + 8, 2, 2);
                                
                                switch (arg0.FloorLevel)
                                {
                                    case 1:
                                        DrawTileBlock(TMID_Decor, x + 8, y, 98, TilesY + 2, 2, 1);
                                        DrawTileBlock(TMID_Decor, x + 8, y + 24, 98, TilesY + 3, 2, 1);
                                        DrawTileBlock(TMID_Beam, x, y, 66, TilesY, 1, 4);
                                        break;
                                    
                                    case 0:
                                        DrawTileBlock(TMID_Decor, x + 8, y, 102, TilesY + 2, 2, 1);
                                        DrawTileBlock(TMID_Decor, x + 8, y + 24, 102, TilesY + 3, 2, 1);
                                        DrawTileBlock(TMID_Beam, x, y, 68, TilesY, 1, 4);
                                        break;
                                }
                                
                                switch (LightingFrame)
                                {
                                    case UnknownEnum.Value_0:
                                    case UnknownEnum.Value_2:
                                        DrawTileBlock(TMID_Decor, x + 8, y + 8, 72, 0, 2, 2);
                                        break;
                                    
                                    case UnknownEnum.Value_1:
                                        DrawTileBlock(TMID_Decor, x + 8, y + 8, 70, 2, 2, 2);
                                        break;
                                    
                                    case UnknownEnum.Value_3:
                                        DrawTileBlock(TMID_Decor, x + 8, y + 8, 106, TilesY + 2, 2, 2);
                                        break;
                                }
                                
                                break;
                            
                            case UnknownEnum.Value_2:
                                for (var i = 0; i < 4; i++)
                                {
                                    var _y = y + (i * 8);
                                    var _TileY = TilesY + 3 + (((_y % 16) == 0) ? 1 : 0);
                                    DrawTileBlock(TMID_Beam, x, _y, 6 + (WallLevel * 17), _TileY, 1, 1);
                                }
                                
                                for (var i = 0; i < 2; i++)
                                {
                                    var _y = y + 8 + (i * 8);
                                    var _TileY = TilesY + 3 + (((_y % 16) == 0) ? 1 : 0);
                                    DrawTileBlock(TMID_Walls, x + 8, _y, 7 + (WallLevel * 17), _TileY, 2, 1);
                                }
                                
                                break;
                        }
                        
                        break;
                }
                
                for (var i = 0; i < 2; i++)
                {
                    var _TileY = (y - 16) + (i * 8);
                    DrawTileBlock(TMID_Beam, x, _TileY, 6 + (WallLevel * 17), TilesY + 3 + (((_TileY % 16) == 0) ? 1 : 0), 1, 1);
                }
                
                break;
            
            case "Right":
                if (Status != UnknownEnum.Value_8 && Status != UnknownEnum.Value_9)
                {
                    DrawTileBlock(TMID_Beam, x + 16, y, 63 + ((FloorLevel == 0) ? 2 : 0), TilesY, 1, 4);
                    DrawTileBlock(TMID_Decor, x, y, 72, TilesY, 2, 1);
                    DrawTileBlock(TMID_Decor, x, y + 24, 72, TilesY + 1, 2, 1);
                }
                
                switch (Status)
                {
                    case UnknownEnum.Value_0:
                    case UnknownEnum.Value_10:
                        if (AddTracks)
                        {
                            DrawTileBlock(TMID_Decor, x, y + 8, 130, 76, 2, 2);
                            break;
                        }
                        else
                        {
                            switch (LightingFrame)
                            {
                                case UnknownEnum.Value_0:
                                case UnknownEnum.Value_2:
                                    DrawTileBlock(TMID_Decor, x, y + 8, 70, 2, 2, 2);
                                    break;
                                
                                case UnknownEnum.Value_1:
                                    DrawTileBlock(TMID_Decor, x, y + 8, 72, 0, 2, 2);
                                    break;
                                
                                case UnknownEnum.Value_3:
                                    DrawTileBlock(TMID_Decor, x, y + 8, 76, TilesY, 2, 2);
                                    break;
                            }
                        }
                        
                        break;
                    
                    case UnknownEnum.Value_1:
                        DrawTileBlock(TMID_Decor, x, y, 82, TilesY, 2, 4);
                        break;
                    
                    case UnknownEnum.Value_6:
                        DrawTileBlock(TMID_Decor, x, y, 84, TilesY, 2, 4);
                        break;
                    
                    case UnknownEnum.Value_2:
                        DrawTileBlock(TMID_Decor, x, y, 94, TilesY, 2, 4);
                        break;
                    
                    case UnknownEnum.Value_7:
                        DrawTileBlock(TMID_Decor, x, y, 96, TilesY, 2, 4);
                        break;
                    
                    case UnknownEnum.Value_8:
                        switch (arg0.SecretType)
                        {
                            case UnknownEnum.Value_0:
                                DrawTileBlock(TMID_Walls, x, y + 8, 8 + (WallLevel * 17), TilesY, 3, 2);
                                DrawTileBlock(TMID_Decor, x, y + 8, 100, TilesY + 4, 2, 2);
                                break;
                            
                            case UnknownEnum.Value_1:
                                DrawTileBlock(TMID_Walls, x, y + 8, 8 + (WallLevel * 17), TilesY, 3, 2);
                                break;
                        }
                        
                        break;
                    
                    case UnknownEnum.Value_9:
                        switch (arg0.SecretType)
                        {
                            case UnknownEnum.Value_1:
                            case UnknownEnum.Value_0:
                                ClearTileBlock(TMID_Walls, x, y + 8, 2, 2);
                                ClearTileBlock(TMID_Decor, x, y + 8, 2, 2);
                                
                                switch (arg0.FloorLevel)
                                {
                                    case 1:
                                        DrawTileBlock(TMID_Decor, x, y, 100, TilesY, 2, 1);
                                        DrawTileBlock(TMID_Decor, x, y + 24, 100, TilesY + 1, 2, 1);
                                        DrawTileBlock(TMID_Beam, x + 16, y, 67, TilesY, 1, 4);
                                        break;
                                    
                                    case 0:
                                        DrawTileBlock(TMID_Decor, x, y, 104, TilesY, 2, 1);
                                        DrawTileBlock(TMID_Decor, x, y + 24, 104, TilesY + 1, 2, 1);
                                        DrawTileBlock(TMID_Beam, x + 16, y, 69, TilesY, 1, 4);
                                        break;
                                }
                                
                                switch (LightingFrame)
                                {
                                    case UnknownEnum.Value_0:
                                    case UnknownEnum.Value_2:
                                        DrawTileBlock(TMID_Decor, x, y + 8, 70, 2, 2, 2);
                                        break;
                                    
                                    case UnknownEnum.Value_1:
                                        DrawTileBlock(TMID_Decor, x, y + 8, 72, 0, 2, 2);
                                        break;
                                    
                                    case UnknownEnum.Value_3:
                                        DrawTileBlock(TMID_Decor, x, y + 8, 108, TilesY, 2, 2);
                                        break;
                                }
                                
                                break;
                            
                            case UnknownEnum.Value_2:
                                for (var i = 0; i < 2; i++)
                                {
                                    var _y = y + 8 + (i * 8);
                                    var _TileY = TilesY + (((_y % 16) == 0) ? 1 : 0);
                                    DrawTileBlock(TMID_Walls, x, _y, 8 + (WallLevel * 17), _TileY, 2, 1);
                                }
                                
                                for (var i = 0; i < 4; i++)
                                {
                                    var _y = y + (i * 8);
                                    var _TileY = TilesY + (((_y % 16) == 0) ? 1 : 0);
                                    DrawTileBlock(TMID_Beam, x + 16, _y, 10 + (WallLevel * 17), _TileY, 1, 1);
                                }
                                
                                break;
                        }
                        
                        break;
                }
                
                for (var i = 0; i < 2; i++)
                {
                    var _TileY = (y - 16) + (i * 8);
                    DrawTileBlock(TMID_Beam, x + 16, _TileY, 10 + (WallLevel * 17), TilesY + (((_TileY % 16) == 0) ? 1 : 0), 1, 1);
                }
                
                break;
        }
    }
}

function Dungeon_InitDoors()
{
    with (oDoor)
    {
        var RoomGridX = floor(x / 256);
        var RoomGridY = floor(y / 256);
        var DoorDist = (FloorLevel == 1) ? 56 : 104;
        var DirX = 0;
        var DirY = 0;
        
        switch (Location)
        {
            case "Top":
                DirY = -1;
                break;
            
            case "Bottom":
                DirY = 1;
                break;
            
            case "Left":
                DirX = -1;
                break;
            
            case "Right":
                DirX = 1;
                break;
        }
        
        LinkedDoor = instance_place(x + (DirX * DoorDist), y + (DirY * DoorDist), oDoor);
        var ConnectedRoomGridX = RoomGridX + DirX;
        var ConnectedRoomGridY = RoomGridY + DirY;
        
        if (SecretType != -1 && LinkedDoor.SecretType != SecretType)
        {
            LinkedDoor.Status = UnknownEnum.Value_8;
            LinkedDoor.SecretType = SecretType;
        }
        
        if (global.Level.Rooms[RoomIndex].TemplateName == "Arcade")
            continue;
        
        if (ConnectedRoomGridX >= 0 && ConnectedRoomGridX <= 7 && ConnectedRoomGridY >= 0 && ConnectedRoomGridY <= 7)
        {
            var ConnectedRoomIndex = global.Level.Map_RoomIndex[ConnectedRoomGridY][ConnectedRoomGridX];
            
            if (ConnectedRoomIndex != -1 && ConnectedRoomIndex != undefined && !Entrance && Status != UnknownEnum.Value_3 && Status != UnknownEnum.Value_4)
            {
                var ConnectedLightingStatus = global.Level.Rooms[ConnectedRoomIndex].Lighting;
                
                if (global.Level.Rooms[RoomIndex].Lighting == 0)
                {
                    if (ConnectedLightingStatus == 0)
                        LightingFrame = UnknownEnum.Value_0;
                    else
                        LightingFrame = UnknownEnum.Value_1;
                }
                else if (ConnectedLightingStatus == 0)
                {
                    LightingFrame = UnknownEnum.Value_2;
                    var C = 0.6;
                    var E = 0.47;
                    var S = 0.7;
                    
                    switch (Location)
                    {
                        case "Top":
                            EntranceLight = Lighting_CreateLight(RoomIndex, x + 16, y + 16, E, [C, C, C]);
                            FloorLight = Lighting_CreateLight(RoomIndex, x + 16, y + 16, S, [C, C, C]);
                            break;
                        
                        case "Bottom":
                            EntranceLight = Lighting_CreateLight(RoomIndex, x + 16, y + 11, E, [C, C, C]);
                            FloorLight = Lighting_CreateLight(RoomIndex, x + 16, y + 10, S, [C, C, C]);
                            break;
                        
                        case "Left":
                            EntranceLight = Lighting_CreateLight(RoomIndex, x + 16, y + 16, E, [C, C, C]);
                            FloorLight = Lighting_CreateLight(RoomIndex, x + 16, y + 16, S, [C, C, C]);
                            break;
                        
                        case "Right":
                            EntranceLight = Lighting_CreateLight(RoomIndex, x + 9, y + 16, E, [C, C, C]);
                            FloorLight = Lighting_CreateLight(RoomIndex, x + 8, y + 16, S, [C, C, C]);
                            break;
                    }
                }
                else
                {
                    LightingFrame = UnknownEnum.Value_3;
                }
            }
        }
        
        Door_UpdateLights();
    }
    
    with (oDoor)
    {
        Door_DrawTiles(id);
        
        if (SecretType == UnknownEnum.Value_2)
        {
            if (global.Level.Rooms[LinkedDoor.RoomIndex].Secret == 1)
                global.Level.Rooms[LinkedDoor.RoomIndex].Secret = 2;
            
            Status = UnknownEnum.Value_9;
            EntranceLight = Lighting_DestroyLight(RoomIndex, EntranceLight);
            FloorLight = Lighting_DestroyLight(RoomIndex, FloorLight);
        }
    }
}

function Door_OpenSecretDoor(arg0)
{
    with (arg0)
    {
        Status = UnknownEnum.Value_9;
        UpdateStatus = true;
        LinkedDoor.Status = UnknownEnum.Value_9;
        LinkedDoor.SecretType = SecretType;
        LinkedDoor.UpdateStatus = true;
    }
}

function Door_SetPassageArea(arg0)
{
    with (arg0)
    {
        switch (Location)
        {
            case "Top":
                sprite_index = sDoorMaskH;
                PassageArea[0] = x - 4;
                PassageArea[1] = y - 48 - ((FloorLevel == 0) ? 48 : 0);
                PassageArea[2] = x + 35;
                PassageArea[3] = y + 7;
                break;
            
            case "Bottom":
                sprite_index = sDoorMaskH;
                PassageArea[0] = x - 4;
                PassageArea[1] = y + 15;
                PassageArea[2] = x + 35;
                PassageArea[3] = y + 63 + ((FloorLevel == 0) ? 48 : 0);
                break;
            
            case "Left":
                sprite_index = sDoorMaskV;
                PassageArea[0] = x - 48 - ((FloorLevel == 0) ? 48 : 0);
                PassageArea[1] = y - 12;
                PassageArea[2] = x + 8;
                PassageArea[3] = y + 35;
                break;
            
            case "Right":
                sprite_index = sDoorMaskV;
                PassageArea[0] = x + 16;
                PassageArea[1] = y - 12;
                PassageArea[2] = x + 63 + ((FloorLevel == 0) ? 48 : 0);
                PassageArea[3] = y + 35;
                break;
        }
    }
}

function Door_GetConnectedPos(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
{
    var A = (arg6 > 12) ? 12 : 0;
    
    switch (arg2)
    {
        case UnknownEnum.Value_0:
            switch (arg5)
            {
                case UnknownEnum.Value_0:
                    switch (arg6)
                    {
                        case 1:
                        case 13:
                            return 5 + A;
                        
                        case 2:
                        case 14:
                            return 10 + A;
                        
                        case 3:
                        case 15:
                            return 9 + A;
                        
                        case 4:
                        case 16:
                            return 8 + A;
                        
                        case 5:
                        case 17:
                            return 1 + A;
                        
                        case 6:
                        case 18:
                            return 12 + A;
                        
                        case 7:
                        case 19:
                            return 11 + A;
                        
                        case 8:
                        case 20:
                            return 4 + A;
                        
                        case 9:
                        case 21:
                            return 3 + A;
                        
                        case 10:
                        case 22:
                            return 2 + A;
                        
                        case 11:
                        case 23:
                            return 7 + A;
                        
                        case 12:
                        case 24:
                            return 6 + A;
                        
                        default:
                            return -1;
                    }
                    
                    break;
                
                case UnknownEnum.Value_1:
                    switch (arg6)
                    {
                        case 1:
                        case 13:
                            return 5 + A;
                        
                        case 3:
                        case 15:
                            if (arg1 == arg4)
                                return 10 + A;
                            else
                                return 8 + A;
                        
                        case 5:
                        case 17:
                            return 1 + A;
                        
                        case 6:
                        case 18:
                            return 12 + A;
                        
                        case 7:
                        case 19:
                            return 11 + A;
                        
                        case 9:
                        case 21:
                            if (arg1 == arg4)
                                return 2 + A;
                            else
                                return 4 + A;
                        
                        case 11:
                        case 23:
                            return 7 + A;
                        
                        case 12:
                        case 24:
                            return 6 + A;
                        
                        default:
                            return -1;
                    }
                    
                    break;
                
                case UnknownEnum.Value_2:
                    switch (arg6)
                    {
                        case 2:
                        case 14:
                            return 10 + A;
                        
                        case 3:
                        case 15:
                            return 9 + A;
                        
                        case 4:
                        case 16:
                            return 8 + A;
                        
                        case 6:
                        case 18:
                            if (arg0 == arg3)
                                return 11 + A;
                            else
                                return 1 + A;
                        
                        case 8:
                        case 20:
                            return 4 + A;
                        
                        case 9:
                        case 21:
                            return 3 + A;
                        
                        case 10:
                        case 22:
                            return 2 + A;
                        
                        case 12:
                        case 24:
                            if (arg0 == arg3)
                                return 7 + A;
                            else
                                return 5 + A;
                        
                        default:
                            return -1;
                    }
                    
                    break;
                
                case UnknownEnum.Value_3:
                    switch (arg6)
                    {
                        case 3:
                        case 15:
                            if (arg1 == arg4)
                                return 10 + A;
                            else
                                return 8 + A;
                        
                        case 6:
                        case 18:
                            if (arg0 == arg3)
                                return 11 + A;
                            else
                                return 1 + A;
                        
                        case 9:
                        case 21:
                            if (arg1 == arg4)
                                return 2 + A;
                            else
                                return 4 + A;
                        
                        case 12:
                        case 24:
                            if (arg0 == arg3)
                                return 7 + A;
                            else
                                return 5 + A;
                        
                        default:
                            return -1;
                    }
                    
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_1:
            switch (arg5)
            {
                case UnknownEnum.Value_0:
                    switch (arg6)
                    {
                        case 1:
                        case 13:
                            return 5 + A;
                        
                        case 2:
                        case 14:
                            return 9 + A;
                        
                        case 4:
                        case 16:
                            return 9 + A;
                        
                        case 5:
                        case 17:
                            return 1 + A;
                        
                        case 6:
                        case 18:
                            return 12 + A;
                        
                        case 7:
                        case 19:
                            return 11 + A;
                        
                        case 8:
                        case 20:
                            return 3 + A;
                        
                        case 10:
                        case 22:
                            return 3 + A;
                        
                        case 11:
                        case 23:
                            return 7 + A;
                        
                        case 12:
                        case 24:
                            return 6 + A;
                        
                        default:
                            return -1;
                    }
                    
                    break;
                
                case UnknownEnum.Value_1:
                    switch (arg6)
                    {
                        case 1:
                        case 13:
                            return 5 + A;
                        
                        case 2:
                        case 14:
                            if (arg1 == arg4)
                                return 10 + A;
                            else
                                return 8 + A;
                        
                        case 3:
                        case 15:
                            if (arg1 == arg4)
                                return 9 + A;
                            else
                                return -1;
                        
                        case 4:
                        case 16:
                            if (arg1 == arg4)
                                return 8 + A;
                            else
                                return 10 + A;
                        
                        case 5:
                        case 17:
                            return 1 + A;
                        
                        case 6:
                        case 18:
                            return 12 + A;
                        
                        case 7:
                        case 19:
                            return 11 + A;
                        
                        case 8:
                        case 20:
                            if (arg1 == arg4)
                                return 4 + A;
                            else
                                return 2 + A;
                        
                        case 9:
                        case 21:
                            if (arg1 == arg4)
                                return 3 + A;
                            else
                                return -1;
                        
                        case 10:
                        case 22:
                            if (arg1 == arg4)
                                return 2 + A;
                            else
                                return 4 + A;
                        
                        case 11:
                        case 23:
                            return 7 + A;
                        
                        case 12:
                        case 24:
                            return 6 + A;
                        
                        default:
                            return -1;
                    }
                    
                    break;
                
                case UnknownEnum.Value_2:
                    switch (arg6)
                    {
                        case 2:
                        case 14:
                            return 9 + A;
                        
                        case 4:
                        case 16:
                            return 9 + A;
                        
                        case 6:
                        case 18:
                            if (arg0 == arg3)
                                return 11 + A;
                            else
                                return 1 + A;
                        
                        case 8:
                        case 20:
                            return 3 + A;
                        
                        case 10:
                        case 22:
                            return 3 + A;
                        
                        case 12:
                        case 24:
                            if (arg0 == arg3)
                                return 7 + A;
                            else
                                return 5 + A;
                        
                        default:
                            return -1;
                    }
                    
                    break;
                
                case UnknownEnum.Value_3:
                    switch (arg6)
                    {
                        case 2:
                        case 14:
                            if (arg1 == arg4)
                                return 10 + A;
                            else
                                return 8 + A;
                        
                        case 3:
                        case 15:
                            if (arg1 == arg4)
                                return 9 + A;
                            else
                                return -1;
                        
                        case 4:
                        case 16:
                            if (arg1 == arg4)
                                return 8 + A;
                            else
                                return 10 + A;
                        
                        case 6:
                        case 18:
                            if (arg0 == arg3)
                                return 11 + A;
                            else
                                return 1 + A;
                        
                        case 8:
                        case 20:
                            if (arg1 == arg4)
                                return 4 + A;
                            else
                                return 2 + A;
                        
                        case 9:
                        case 21:
                            if (arg1 == arg4)
                                return 3 + A;
                            else
                                return -1;
                        
                        case 10:
                        case 22:
                            if (arg1 == arg4)
                                return 2 + A;
                            else
                                return 4 + A;
                        
                        case 12:
                        case 24:
                            if (arg0 == arg3)
                                return 7 + A;
                            else
                                return 5 + A;
                        
                        default:
                            return -1;
                    }
                    
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_2:
            switch (arg5)
            {
                case UnknownEnum.Value_0:
                    switch (arg6)
                    {
                        case 1:
                        case 13:
                            return 6 + A;
                        
                        case 2:
                        case 14:
                            return 10 + A;
                        
                        case 3:
                        case 15:
                            return 9 + A;
                        
                        case 4:
                        case 16:
                            return 8 + A;
                        
                        case 5:
                        case 17:
                            return 12 + A;
                        
                        case 7:
                        case 19:
                            return 12 + A;
                        
                        case 8:
                        case 20:
                            return 4 + A;
                        
                        case 9:
                        case 21:
                            return 3 + A;
                        
                        case 10:
                        case 22:
                            return 2 + A;
                        
                        case 11:
                        case 23:
                            return 6 + A;
                        
                        default:
                            return -1;
                    }
                    
                    break;
                
                case UnknownEnum.Value_1:
                    switch (arg6)
                    {
                        case 1:
                        case 13:
                            return 6 + A;
                        
                        case 3:
                        case 15:
                            if (arg1 == arg4)
                                return 10 + A;
                            else
                                return 8 + A;
                        
                        case 5:
                        case 17:
                            return 12 + A;
                        
                        case 7:
                        case 19:
                            return 12 + A;
                        
                        case 9:
                        case 21:
                            if (arg1 == arg4)
                                return 2 + A;
                            else
                                return 4 + A;
                        
                        case 11:
                        case 23:
                            return 6 + A;
                        
                        default:
                            return -1;
                    }
                    
                    break;
                
                case UnknownEnum.Value_2:
                    switch (arg6)
                    {
                        case 1:
                        case 13:
                            if (arg0 == arg3)
                                return 5 + A;
                            else
                                return 7 + A;
                        
                        case 2:
                        case 14:
                            return 10 + A;
                        
                        case 3:
                        case 15:
                            return 9 + A;
                        
                        case 4:
                        case 16:
                            return 8 + A;
                        
                        case 5:
                        case 17:
                            if (arg0 == arg3)
                                return 1 + A;
                            else
                                return 11 + A;
                        
                        case 6:
                        case 18:
                            return 12 + A;
                        
                        case 7:
                        case 19:
                            if (arg0 == arg3)
                                return 11 + A;
                            else
                                return 1 + A;
                        
                        case 8:
                        case 20:
                            return 4 + A;
                        
                        case 9:
                        case 21:
                            return 3 + A;
                        
                        case 10:
                        case 22:
                            return 2 + A;
                        
                        case 11:
                        case 23:
                            if (arg0 == arg3)
                                return 7 + A;
                            else
                                return 5 + A;
                        
                        case 12:
                        case 24:
                            return 6 + A;
                        
                        default:
                            return -1;
                    }
                    
                    break;
                
                case UnknownEnum.Value_3:
                    switch (arg6)
                    {
                        case 1:
                        case 13:
                            if (arg0 == arg3)
                                return 5 + A;
                            else
                                return 7 + A;
                        
                        case 3:
                        case 15:
                            if (arg1 == arg4)
                                return 10 + A;
                            else
                                return 8 + A;
                        
                        case 5:
                        case 17:
                            if (arg0 == arg3)
                                return 1 + A;
                            else
                                return 11 + A;
                        
                        case 6:
                        case 18:
                            if (arg0 == arg3)
                                return 12 + A;
                            else
                                return -1;
                        
                        case 7:
                        case 19:
                            if (arg0 == arg3)
                                return 11 + A;
                            else
                                return 1 + A;
                        
                        case 9:
                        case 21:
                            if (arg1 == arg4)
                                return 2 + A;
                            else
                                return 4 + A;
                        
                        case 11:
                        case 23:
                            if (arg0 == arg3)
                                return 7 + A;
                            else
                                return 5 + A;
                        
                        case 12:
                        case 24:
                            if (arg0 == arg3)
                                return 6 + A;
                            else
                                return -1;
                        
                        default:
                            return -1;
                    }
                    
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_3:
            switch (arg5)
            {
                case UnknownEnum.Value_0:
                    switch (arg6)
                    {
                        case 1:
                        case 13:
                            return 6 + A;
                        
                        case 2:
                        case 14:
                            return 9 + A;
                        
                        case 4:
                        case 16:
                            return 9 + A;
                        
                        case 5:
                        case 17:
                            return 12 + A;
                        
                        case 7:
                        case 19:
                            return 12 + A;
                        
                        case 8:
                        case 20:
                            return 3 + A;
                        
                        case 10:
                        case 22:
                            return 3 + A;
                        
                        case 11:
                        case 23:
                            return 6 + A;
                        
                        default:
                            return -1;
                    }
                    
                    break;
                
                case UnknownEnum.Value_1:
                    switch (arg6)
                    {
                        case 1:
                        case 13:
                            return 6 + A;
                        
                        case 2:
                        case 14:
                            if (arg1 == arg4)
                                return 10 + A;
                            else
                                return 8 + A;
                        
                        case 3:
                        case 15:
                            if (arg1 == arg4)
                                return 9 + A;
                            else
                                return -1;
                        
                        case 4:
                        case 16:
                            if (arg1 == arg4)
                                return 8 + A;
                            else
                                return 10 + A;
                        
                        case 5:
                        case 17:
                            return 12 + A;
                        
                        case 7:
                        case 19:
                            return 12 + A;
                        
                        case 8:
                        case 20:
                            if (arg1 == arg4)
                                return 4 + A;
                            else
                                return 2 + A;
                        
                        case 9:
                        case 21:
                            if (arg1 == arg4)
                                return 3 + A;
                            else
                                return -1;
                        
                        case 10:
                        case 22:
                            if (arg1 == arg4)
                                return 2 + A;
                            else
                                return 4 + A;
                        
                        case 11:
                        case 23:
                            return 6 + A;
                        
                        default:
                            return -1;
                    }
                    
                    break;
                
                case UnknownEnum.Value_2:
                    switch (arg6)
                    {
                        case 1:
                        case 13:
                            if (arg0 == arg3)
                                return 5 + A;
                            else
                                return 7 + A;
                        
                        case 2:
                        case 14:
                            return 9 + A;
                        
                        case 4:
                        case 16:
                            return 9 + A;
                        
                        case 5:
                        case 17:
                            if (arg0 == arg3)
                                return 1 + A;
                            else
                                return 11 + A;
                        
                        case 6:
                        case 18:
                            if (arg0 == arg3)
                                return 12 + A;
                            else
                                return -1;
                        
                        case 7:
                        case 19:
                            if (arg0 == arg3)
                                return 11 + A;
                            else
                                return 1 + A;
                        
                        case 8:
                        case 20:
                            return 3 + A;
                        
                        case 10:
                        case 22:
                            return 3 + A;
                        
                        case 11:
                        case 23:
                            if (arg0 == arg3)
                                return 7 + A;
                            else
                                return 5 + A;
                        
                        case 12:
                        case 24:
                            if (arg0 == arg3)
                                return 6 + A;
                            else
                                return -1;
                        
                        default:
                            return -1;
                    }
                    
                    break;
                
                case UnknownEnum.Value_3:
                    switch (arg6)
                    {
                        case 1:
                        case 13:
                            if (arg0 == arg3)
                                return 5 + A;
                            else
                                return 7 + A;
                        
                        case 2:
                        case 14:
                            if (arg1 == arg4)
                                return 10 + A;
                            else
                                return 8 + A;
                        
                        case 3:
                        case 15:
                            if (arg1 == arg4)
                                return 9 + A;
                            else
                                return -1;
                        
                        case 4:
                        case 16:
                            if (arg1 == arg4)
                                return 8 + A;
                            else
                                return 10 + A;
                        
                        case 5:
                        case 17:
                            if (arg0 == arg3)
                                return 1 + A;
                            else
                                return 11 + A;
                        
                        case 6:
                        case 18:
                            if (arg0 == arg3)
                                return 12 + A;
                            else
                                return -1;
                        
                        case 7:
                        case 19:
                            if (arg0 == arg3)
                                return 11 + A;
                            else
                                return 1 + A;
                        
                        case 8:
                        case 20:
                            if (arg1 == arg4)
                                return 4 + A;
                            else
                                return 2 + A;
                        
                        case 9:
                        case 21:
                            if (arg1 == arg4)
                                return 3 + A;
                            else
                                return -1;
                        
                        case 10:
                        case 22:
                            if (arg1 == arg4)
                                return 2 + A;
                            else
                                return 4 + A;
                        
                        case 11:
                        case 23:
                            if (arg0 == arg3)
                                return 7 + A;
                            else
                                return 5 + A;
                        
                        case 12:
                        case 24:
                            if (arg0 == arg3)
                                return 6 + A;
                            else
                                return -1;
                        
                        default:
                            return -1;
                    }
                    
                    break;
            }
            
            break;
    }
}

function Door_UpdateLights()
{
    var LightStatus = Status != UnknownEnum.Value_1 && Status != UnknownEnum.Value_2 && Status != UnknownEnum.Value_8 && Status != UnknownEnum.Value_10;
    Lighting_UpdateLight_Visible(RoomIndex, FloorLight, LightStatus);
    Lighting_UpdateLight_Visible(RoomIndex, EntranceLight, LightStatus);
}

function Door_LocationToDir(arg0)
{
    switch (arg0)
    {
        case "Top":
            return 1;
        
        case "Bottom":
            return 2;
        
        case "Left":
            return 3;
        
        case "Right":
            return 4;
    }
    
    return -1;
}

function Door_LocationToOppositeDir(arg0)
{
    switch (arg0)
    {
        case "Top":
            return 2;
        
        case "Bottom":
            return 1;
        
        case "Left":
            return 4;
        
        case "Right":
            return 3;
    }
    
    return -1;
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
    Value_9,
    Value_10,
    Value_11,
    Value_13 = 13,
    Value_25 = 25,
    Value_26,
    Value_27,
    Value_28,
    Value_29,
    Value_30,
    Value_31,
    Value_32
}
