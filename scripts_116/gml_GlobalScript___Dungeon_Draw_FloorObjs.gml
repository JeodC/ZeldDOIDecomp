function Dungeon_Draw_FloorObjs(arg0)
{
    if (!variable_struct_exists(global.Level.Rooms[arg0].Template, "FloorObjs"))
        exit;
    
    var FloorObjArray = global.Level.Rooms[arg0].Template.FloorObjs;
    
    for (var FloorObjIndex = 0; FloorObjIndex < array_length(FloorObjArray); FloorObjIndex++)
    {
        var Obj = FloorObjArray[FloorObjIndex];
        var ObjX = global.Level.Rooms[arg0].x + Obj.x;
        var ObjY = global.Level.Rooms[arg0].y + Obj.y;
        var ObjW = Obj.width;
        var ObjH = Obj.height;
        var ObjTileW = ObjW / 8;
        var ObjTileH = ObjH / 8;
        var ObjRot = Obj.rotation;
        var ObjX2 = (ObjX + ObjW) - 8;
        var ObjY2 = (ObjY + ObjH) - 8;
        var ObjGID = Obj.gid;
        var ObjName = struct_get_from_hash(Obj, variable_get_hash("name"));
        var ObjType = struct_get_from_hash(Obj, variable_get_hash("type"));
        var UpperFloorCheck = tilemap_get_at_pixel(global.TMID_Floor_Upper, ObjX, ObjY);
        var FloorLevelStr = UpperFloorCheck ? "Upper" : "Lower";
        var FloorTMID = GetFloorLevelTMID("Tiles_Floor", ObjX, ObjY);
        var DecorTMID = GetFloorLevelTMID("Tiles_Decor", ObjX, ObjY);
        var WaterTMID = GetFloorLevelTMID("Tiles_Water", ObjX, ObjY);
        var WallsTMID = GetFloorLevelTMID("Tiles_Walls", ObjX, ObjY);
        var PropertiesArray = Obj.properties;
        
        switch (ObjGID)
        {
            case UnknownEnum.Value_51:
            case UnknownEnum.Value_48:
            case UnknownEnum.Value_49:
            case UnknownEnum.Value_50:
                if (!ObstacleRoomCheck(arg0, UnknownEnum.Value_3) || global.SpawnedWater)
                    break;
                
                var MovingFloorInst = instance_create_layer(ObjX, ObjY, "ObjsFloor_" + FloorLevelStr, oMovingFloor, 
                {
                    W: ObjW,
                    H: ObjH
                });
                
                switch (ObjGID)
                {
                    case UnknownEnum.Value_49:
                        MovingFloorInst.sprite_index = sMovingFloorLeft;
                        MovingFloorInst.DirX = -1;
                        break;
                    
                    case UnknownEnum.Value_50:
                        MovingFloorInst.sprite_index = sMovingFloorRight;
                        MovingFloorInst.DirX = 1;
                        break;
                    
                    case UnknownEnum.Value_51:
                        MovingFloorInst.sprite_index = sMovingFloorUp;
                        MovingFloorInst.DirY = -1;
                        break;
                    
                    case UnknownEnum.Value_48:
                        MovingFloorInst.sprite_index = sMovingFloorDown;
                        MovingFloorInst.DirY = 1;
                        break;
                }
                
                global.SpawnedMovingFloors = true;
                break;
            
            case UnknownEnum.Value_239:
                if (global.Level.Index == UnknownEnum.Value_4 || global.Level.Index == UnknownEnum.Value_5 || global.Level.Index == UnknownEnum.Value_11)
                    break;
                
                var TileY = (global.Level.Index == UnknownEnum.Value_13) ? 70 : (4 + ((global.Level.Index - 1) * 6));
                
                for (var _y = 0; _y < ObjTileH; _y++)
                {
                    for (var _x = 0; _x < ObjTileW; _x++)
                    {
                        var _TileX = ObjX + (_x * 8);
                        var _TileY = ObjY + (_y * 8);
                        tilemap_set_at_pixel(FloorTMID, GetTileID(111, TileY + 2), _TileX, _TileY);
                        
                        if (_x == 0 || _x == (ObjTileW - 1))
                            tilemap_set_at_pixel(FloorTMID, GetTileID(110, TileY + 4), _TileX, _TileY);
                    }
                }
                
                break;
            
            case UnknownEnum.Value_190:
                if (global.Level.Index == UnknownEnum.Value_4 || global.Level.Index == UnknownEnum.Value_5 || global.Level.Index == UnknownEnum.Value_11)
                    break;
                
                DrawTileBlock(FloorTMID, ObjX, ObjY, 15, 0, 1, 1);
                DrawTileBlock(FloorTMID, ObjX2, ObjY, 17, 0, 1, 1);
                DrawTileBlock(FloorTMID, ObjX, ObjY2, 15, 2, 1, 1);
                DrawTileBlock(FloorTMID, ObjX2, ObjY2, 17, 2, 1, 1);
                
                for (var _x = 0; _x < (ObjTileW - 2); _x++)
                {
                    var FloorX = ObjX + 8 + (_x * 8);
                    DrawTileBlock(FloorTMID, FloorX, ObjY, 16, 0, 1, 1);
                    DrawTileBlock(FloorTMID, FloorX, ObjY2, 16, 2, 1, 1);
                }
                
                for (var _y = 0; _y < (ObjTileH - 2); _y++)
                {
                    var FloorY = ObjY + 8 + (_y * 8);
                    DrawTileBlock(FloorTMID, ObjX, FloorY, 15, 1, 1, 1);
                    DrawTileBlock(FloorTMID, ObjX2, FloorY, 17, 1, 1, 1);
                }
                
                for (var _y = 0; _y < (ObjTileH - 2); _y++)
                {
                    for (var _x = 0; _x < (ObjTileW - 2); _x++)
                    {
                        var FloorX = ObjX + 8 + (_x * 8);
                        var FloorY = ObjY + 8 + (_y * 8);
                        DrawTileBlock(FloorTMID, FloorX, FloorY, 16, 1, 1, 1);
                    }
                }
                
                break;
            
            case UnknownEnum.Value_99:
                for (var _y = 0; _y < ObjTileH; _y++)
                {
                    for (var _x = 0; _x < ObjTileW; _x++)
                    {
                        var _TileX = ObjX + (_x * 8);
                        var _TileY = ObjY + (_y * 8);
                        tilemap_set_at_pixel(FloorTMID, GetTileID(30 + (_x % 2), 80 + (_y % 2)), _TileX, _TileY);
                    }
                }
                
                break;
            
            case UnknownEnum.Value_100:
                for (var _y = 0; _y < ObjTileH; _y++)
                {
                    for (var _x = 0; _x < ObjTileW; _x++)
                    {
                        var _TileX = ObjX + (_x * 8);
                        var _TileY = ObjY + (_y * 8);
                        tilemap_set_at_pixel(DecorTMID, GetTileID(32, 81), _TileX, _TileY);
                    }
                }
                
                break;
            
            case UnknownEnum.Value_109:
                for (var _y = 0; _y < ObjTileH; _y++)
                {
                    for (var _x = 0; _x < ObjTileW; _x++)
                    {
                        var _TileX = ObjX + (_x * 8);
                        var _TileY = ObjY + (_y * 8);
                        tilemap_set_at_pixel(DecorTMID, GetTileID(30 + (_x % 2), 82 + (_y % 2)), _TileX, _TileY);
                    }
                }
                
                break;
            
            case UnknownEnum.Value_110:
                for (var _y = 0; _y < ObjTileH; _y++)
                {
                    for (var _x = 0; _x < ObjTileW; _x++)
                    {
                        var _TileX = ObjX + (_x * 8);
                        var _TileY = ObjY + (_y * 8);
                        tilemap_set_at_pixel(WaterTMID, GetTileID(32, 83), _TileX, _TileY);
                    }
                }
                
                break;
            
            case UnknownEnum.Value_111:
                for (var _y = 0; _y < ObjTileH; _y++)
                {
                    for (var _x = 0; _x < ObjTileW; _x++)
                    {
                        var _TileX = ObjX + (_x * 8);
                        var _TileY = ObjY + (_y * 8);
                        tilemap_set_at_pixel(WaterTMID, GetTileID(33 + (_x % 2), 80 + (_y % 2)), _TileX, _TileY);
                    }
                }
                
                break;
            
            case UnknownEnum.Value_112:
                for (var _y = 0; _y < ObjTileH; _y++)
                {
                    for (var _x = 0; _x < ObjTileW; _x++)
                    {
                        var _TileX = ObjX + (_x * 8);
                        var _TileY = ObjY + (_y * 8);
                        tilemap_set_at_pixel(WaterTMID, GetTileID(32, 82), _TileX, _TileY);
                    }
                }
                
                break;
            
            case UnknownEnum.Value_113:
                for (var _y = 0; _y < ObjTileH; _y++)
                {
                    for (var _x = 0; _x < ObjTileW; _x++)
                    {
                        var _TileX = ObjX + (_x * 8);
                        var _TileY = ObjY + (_y * 8);
                        tilemap_set_at_pixel(WaterTMID, GetTileID(32, 84), _TileX, _TileY);
                    }
                }
                
                break;
            
            case UnknownEnum.Value_114:
                for (var _y = 0; _y < ObjTileH; _y++)
                {
                    for (var _x = 0; _x < ObjTileW; _x++)
                    {
                        var _TileX = ObjX + (_x * 8);
                        var _TileY = ObjY + (_y * 8);
                        tilemap_set_at_pixel(WaterTMID, GetTileID(32, 85), _TileX, _TileY);
                    }
                }
                
                break;
            
            case UnknownEnum.Value_115:
                for (var _y = 0; _y < ObjTileH; _y++)
                {
                    for (var _x = 0; _x < ObjTileW; _x++)
                    {
                        var _TileX = ObjX + (_x * 8);
                        var _TileY = ObjY + (_y * 8);
                        tilemap_set_at_pixel(DecorTMID, GetTileID(30 + (_x % 2), 84), _TileX, _TileY);
                    }
                }
                
                break;
            
            case UnknownEnum.Value_116:
                for (var _y = 0; _y < ObjTileH; _y++)
                {
                    for (var _x = 0; _x < ObjTileW; _x++)
                    {
                        var _TileX = ObjX + (_x * 8);
                        var _TileY = ObjY + (_y * 8);
                        tilemap_set_at_pixel(DecorTMID, GetTileID(15 + (_x % 2), 80), _TileX, _TileY);
                    }
                }
                
                break;
            
            case UnknownEnum.Value_101:
                for (var _y = 0; _y < ObjTileH; _y++)
                {
                    for (var _x = 0; _x < ObjTileW; _x++)
                    {
                        var _TileX = ObjX + (_x * 8);
                        var _TileY = ObjY + (_y * 8);
                        tilemap_set_at_pixel(WaterTMID, GetTileID(32, 80), _TileX, _TileY);
                    }
                }
                
                break;
            
            case UnknownEnum.Value_117:
                for (var _y = 0; _y < ObjTileH; _y++)
                {
                    for (var _x = 0; _x < ObjTileW; _x++)
                    {
                        var _TileX = ObjX + (_x * 8);
                        var _TileY = ObjY + (_y * 8);
                        var Tile;
                        
                        if (Prob(0.3))
                            Tile = GetTileID(37, 78);
                        else if (Prob(0.9))
                            Tile = choose(GetTileID(37, 77), GetTileID(36, 78), GetTileID(38, 78), GetTileID(37, 79));
                        else
                            Tile = choose(GetTileID(35, 76), GetTileID(39, 76), GetTileID(35, 77), GetTileID(39, 77));
                        
                        tilemap_set_at_pixel(WaterTMID, Tile, _TileX, _TileY);
                    }
                }
                
                break;
            
            case UnknownEnum.Value_118:
                var Tx = (global.Level.Index == UnknownEnum.Value_0) ? 89 : 36;
                
                for (var _y = 0; _y < ObjTileH; _y++)
                {
                    for (var _x = 0; _x < ObjTileW; _x++)
                    {
                        var _TileX = ObjX + (_x * 8);
                        var _TileY = ObjY + (_y * 8);
                        var Tile;
                        
                        switch (ObjRot)
                        {
                            case 0:
                                Tile = GetTileID(Tx, 77);
                                break;
                            
                            case 90:
                                Tile = GetTileID(Tx + 2, 77);
                                break;
                            
                            case -90:
                                Tile = GetTileID(Tx, 79);
                                break;
                            
                            case 180:
                                Tile = GetTileID(Tx + 2, 79);
                                break;
                        }
                        
                        tilemap_set_at_pixel(WaterTMID, Tile, _TileX, _TileY);
                    }
                }
                
                break;
            
            case UnknownEnum.Value_119:
                var Tx = (global.Level.Index == UnknownEnum.Value_0) ? 89 : 36;
                
                for (var _y = 0; _y < ObjTileH; _y++)
                {
                    for (var _x = 0; _x < ObjTileW; _x++)
                    {
                        var _TileX = ObjX + (_x * 8);
                        var _TileY = ObjY + (_y * 8);
                        var Tile;
                        
                        switch (ObjRot)
                        {
                            case 0:
                                Tile = GetTileID(Tx, 76);
                                break;
                            
                            case 90:
                                Tile = GetTileID(Tx + 2, 76);
                                break;
                            
                            case -90:
                                Tile = GetTileID(Tx, 80);
                                break;
                            
                            case 180:
                                Tile = GetTileID(Tx + 2, 80);
                                break;
                        }
                        
                        tilemap_set_at_pixel(WaterTMID, Tile, _TileX, _TileY);
                    }
                }
                
                break;
            
            case UnknownEnum.Value_120:
                var Tx = (global.Level.Index == UnknownEnum.Value_0) ? 88 : 35;
                
                for (var _y = 0; _y < ObjTileH; _y++)
                {
                    for (var _x = 0; _x < ObjTileW; _x++)
                    {
                        var _TileX = ObjX + (_x * 8);
                        var _TileY = ObjY + (_y * 8);
                        var Tile;
                        
                        switch (ObjRot)
                        {
                            case 0:
                                Tile = GetTileID(Tx + 2, 76);
                                break;
                            
                            case 90:
                                Tile = GetTileID(Tx + 4, 78);
                                break;
                            
                            case -90:
                                Tile = GetTileID(Tx, 78);
                                break;
                            
                            case 180:
                                Tile = GetTileID(Tx + 2, 80);
                                break;
                        }
                        
                        tilemap_set_at_pixel(WaterTMID, Tile, _TileX, _TileY);
                    }
                }
                
                break;
            
            case UnknownEnum.Value_212:
                for (var _y = 0; _y < ObjTileH; _y++)
                {
                    for (var _x = 0; _x < ObjTileW; _x++)
                    {
                        var TileX = ObjX + (_x * 8);
                        var TileY = ObjY + (_y * 8);
                        DrawTileBlock(FloorTMID, TileX, TileY, 42 + ((TileX / 8) % 2), 40 + ((TileY / 8) % 2), 1, 1);
                    }
                }
                
                break;
            
            case UnknownEnum.Value_157:
                DrawTileBlock(WaterTMID, ObjX, ObjY, 44, 89, 2, 2);
                break;
            
            case UnknownEnum.Value_187:
                DrawTileBlock(FloorTMID, ObjX, ObjY, 50, 86 + (real(ObjType) * 2), 2, 2);
                WallObj_Create("ObjsFloor_" + FloorLevelStr, ObjX, ObjY, 2, 2);
                break;
            
            case UnknownEnum.Value_274:
                for (var _x = 0; _x < ObjTileW; _x++)
                {
                    var _PosX = ObjX + (_x * 8);
                    DrawTileBlock(WaterTMID, _PosX, ObjY, 122, 77, 1, 2);
                }
                
                break;
            
            case UnknownEnum.Value_275:
                for (var _y = 0; _y < ObjTileH; _y++)
                {
                    var _PosY = ObjY + (_y * 8);
                    DrawTileBlock(WaterTMID, ObjX, _PosY, 122, 76, 2, 1);
                }
                
                break;
            
            case UnknownEnum.Value_278:
                DrawTileBlock(WaterTMID, ObjX, ObjY, 124, 76, 2, 2);
                break;
            
            case UnknownEnum.Value_279:
                DrawTileBlock(WaterTMID, ObjX, ObjY, 126, 76, 2, 2);
                break;
            
            case UnknownEnum.Value_276:
                DrawTileBlock(WaterTMID, ObjX, ObjY, 124, 78, 2, 2);
                break;
            
            case UnknownEnum.Value_277:
                DrawTileBlock(WaterTMID, ObjX, ObjY, 126, 78, 2, 2);
                break;
            
            case UnknownEnum.Value_294:
                for (var _y = 0; _y < ObjTileH; _y++)
                {
                    for (var _x = 0; _x < ObjTileW; _x++)
                    {
                        var TileX = ObjX + (_x * 8);
                        var TileY = ObjY + (_y * 8);
                        DrawTileBlock(global.TMID_Lava, TileX, TileY, 126 + ((TileX / 8) % 2), 94 + ((TileY / 8) % 2), 1, 1);
                    }
                }
                
                instance_create_layer(ObjX + (ObjW / 2), ObjY + (ObjH / 2), "Objs_" + FloorLevelStr, oCoalLight, 
                {
                    RoomIndex: arg0,
                    R: 0.7,
                    G: 0.4,
                    B: 0.4,
                    LightStrength: GetPropertyValue(PropertiesArray, "LightStrength")
                });
                global.Level.Rooms[arg0].Heat = true;
                break;
        }
    }
}

enum UnknownEnum
{
    Value_0,
    Value_3 = 3,
    Value_4,
    Value_5,
    Value_11 = 11,
    Value_13 = 13,
    Value_48 = 48,
    Value_49,
    Value_50,
    Value_51,
    Value_99 = 99,
    Value_100,
    Value_101,
    Value_109 = 109,
    Value_110,
    Value_111,
    Value_112,
    Value_113,
    Value_114,
    Value_115,
    Value_116,
    Value_117,
    Value_118,
    Value_119,
    Value_120,
    Value_157 = 157,
    Value_187 = 187,
    Value_190 = 190,
    Value_212 = 212,
    Value_239 = 239,
    Value_274 = 274,
    Value_275,
    Value_276,
    Value_277,
    Value_278,
    Value_279,
    Value_294 = 294
}
