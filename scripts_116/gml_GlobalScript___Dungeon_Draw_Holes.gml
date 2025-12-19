function Dungeon_Draw_Holes(arg0)
{
    if (!variable_struct_exists(global.Level.Rooms[arg0].Template, "Holes"))
        exit;
    
    if (global.Level.Index != UnknownEnum.Value_13 && global.Level.Index != UnknownEnum.Value_6 && global.Level.Index != UnknownEnum.Value_10 && arg0 == global.Level.RoomIndex_BossAdjacent)
        exit;
    
    if (global.Level.Rooms[arg0].TemplateClass == UnknownEnum.Value_6 && global.Level.Rooms[arg0].Obstacle != UnknownEnum.Value_1 && global.Level.Rooms[arg0].Obstacle != UnknownEnum.Value_3)
        exit;
    
    var HoleArray = global.Level.Rooms[arg0].Template.Holes;
    var RoomTilesW = global.Level.Rooms[arg0].width / 8;
    var RoomTilesH = global.Level.Rooms[arg0].height / 8;
    var HoleGrid = ds_grid_create(RoomTilesW, RoomTilesH);
    ds_grid_clear(HoleGrid, -1);
    var FloorLevel;
    
    for (var HoleIndex = 0; HoleIndex < array_length(HoleArray); HoleIndex++)
    {
        var Hole = HoleArray[HoleIndex];
        var HoleX = global.Level.Rooms[arg0].x + Hole.x;
        var HoleY = global.Level.Rooms[arg0].y + Hole.y;
        var HoleW = Hole.width;
        var HoleH = Hole.height;
        var HoleTileW = HoleW / 8;
        var HoleTileH = HoleH / 8;
        var HoleGridX = (HoleX - global.Level.Rooms[arg0].x) / 8;
        var HoleGridY = (HoleY - global.Level.Rooms[arg0].y) / 8;
        
        for (var _y = 0; _y < HoleTileH; _y++)
        {
            var GridY = clamp(HoleGridY + _y, 0, RoomTilesH - 1);
            
            for (var _x = 0; _x < HoleTileW; _x++)
            {
                var GridX = clamp(HoleGridX + _x, 0, RoomTilesW - 1);
                ds_grid_set(HoleGrid, GridX, GridY, UnknownEnum.Value_0);
            }
        }
        
        FloorLevel = GetFloorLevelID(HoleX + (HoleW / 2), HoleY + (HoleH / 2));
        var FloorLevelStr = GetFloorLevelString(FloorLevel);
        var inst = WallObj_Create("Objs_" + FloorLevelStr, HoleX, HoleY, HoleTileW, HoleTileH);
        inst.FloorLevel = FloorLevel;
        inst.BlockLink = false;
        inst.BlockLinkCarry = false;
        inst.BlockProjectiles = false;
        inst.BlockItems = false;
        inst.IsHole = true;
    }
    
    for (var _y = 0; _y < RoomTilesH; _y++)
    {
        for (var _x = 0; _x < RoomTilesW; _x++)
        {
            var TileX = global.Level.Rooms[arg0].x + (_x * 8);
            var TileY = global.Level.Rooms[arg0].y + (_y * 8);
            var TileID = ds_grid_get(HoleGrid, _x, _y);
            
            if (TileID == 0)
            {
                tilemap_set_at_pixel(global.TMID_Water_Upper, 0, TileX, TileY);
                tilemap_set_at_pixel(global.TMID_Water_Lower, 0, TileX, TileY);
                tilemap_set_at_pixel(global.TMID_Floor_Upper, 0, TileX, TileY);
                tilemap_set_at_pixel(global.TMID_Floor_Lower, 0, TileX, TileY);
                var FloorTileTL = ((_x - 1) < 0 || (_y - 1) < 0) ? 0 : ds_grid_get(HoleGrid, _x - 1, _y - 1);
                var FloorTileTM = ((_y - 1) < 0) ? 0 : ds_grid_get(HoleGrid, _x, _y - 1);
                var FloorTileTR = ((_x + 1) >= RoomTilesW || (_y - 1) < 0) ? 0 : ds_grid_get(HoleGrid, _x + 1, _y - 1);
                var FloorTileML = ((_x - 1) < 0) ? 0 : ds_grid_get(HoleGrid, _x - 1, _y);
                var FloorTileMR = ((_x + 1) >= RoomTilesW) ? 0 : ds_grid_get(HoleGrid, _x + 1, _y);
                var FloorTileBL = ((_x - 1) < 0 || (_y + 1) >= RoomTilesH) ? 0 : ds_grid_get(HoleGrid, _x - 1, _y + 1);
                var FloorTileBM = ((_y + 1) >= RoomTilesH) ? 0 : ds_grid_get(HoleGrid, _x, _y + 1);
                var FloorTileBR = ((_x + 1) >= RoomTilesW || (_y + 1) >= RoomTilesH) ? 0 : ds_grid_get(HoleGrid, _x + 1, _y + 1);
                var ID = -1;
                
                if (FloorTileTL == -1 && FloorTileTM == -1 && FloorTileML == -1)
                    ID = UnknownEnum.Value_1;
                else if (FloorTileTR == -1 && FloorTileTM == -1 && FloorTileMR == -1)
                    ID = UnknownEnum.Value_3;
                else if (FloorTileBL == -1 && FloorTileBM == -1 && FloorTileML == -1)
                    ID = UnknownEnum.Value_6;
                else if (FloorTileBR == -1 && FloorTileBM == -1 && FloorTileMR == -1)
                    ID = UnknownEnum.Value_8;
                else if (FloorTileTM == -1)
                    ID = UnknownEnum.Value_2;
                else if (FloorTileML == -1)
                    ID = UnknownEnum.Value_4;
                else if (FloorTileMR == -1)
                    ID = UnknownEnum.Value_5;
                else if (FloorTileBM == -1)
                    ID = UnknownEnum.Value_7;
                else if (FloorTileTL == -1)
                    ID = UnknownEnum.Value_9;
                else if (FloorTileTR == -1)
                    ID = UnknownEnum.Value_10;
                else if (FloorTileBL == -1)
                    ID = UnknownEnum.Value_11;
                else if (FloorTileBR == -1)
                    ID = UnknownEnum.Value_12;
                
                if (ID > 0)
                    ds_grid_set(HoleGrid, _x, _y, ID);
            }
        }
    }
    
    var HoleTileY = ((global.Level.Index == UnknownEnum.Value_13) ? 70 : (4 + ((global.Level.Index - 1) * 6))) + 4;
    
    for (var _y = 0; _y < RoomTilesH; _y++)
    {
        for (var _x = 0; _x < RoomTilesW; _x++)
        {
            var TileX = global.Level.Rooms[arg0].x + (_x * 8);
            var TileY = global.Level.Rooms[arg0].y + (_y * 8);
            var TileID = ds_grid_get(HoleGrid, _x, _y);
            var Tile = -1;
            
            switch (TileID)
            {
                case UnknownEnum.Value_1:
                    Tile = GetTileID(102, HoleTileY);
                    break;
                
                case UnknownEnum.Value_2:
                    Tile = GetTileID(104, HoleTileY);
                    break;
                
                case UnknownEnum.Value_3:
                    Tile = GetTileID(103, HoleTileY);
                    break;
                
                case UnknownEnum.Value_4:
                    Tile = GetTileID(104, HoleTileY + 1);
                    break;
                
                case UnknownEnum.Value_5:
                    Tile = GetTileID(105, HoleTileY);
                    break;
                
                case UnknownEnum.Value_6:
                    Tile = GetTileID(102, HoleTileY + 1);
                    break;
                
                case UnknownEnum.Value_7:
                    Tile = GetTileID(105, HoleTileY + 1);
                    break;
                
                case UnknownEnum.Value_8:
                    Tile = GetTileID(103, HoleTileY + 1);
                    break;
                
                case UnknownEnum.Value_9:
                    Tile = GetTileID(106, HoleTileY);
                    break;
                
                case UnknownEnum.Value_10:
                    Tile = GetTileID(107, HoleTileY);
                    break;
                
                case UnknownEnum.Value_11:
                    Tile = GetTileID(106, HoleTileY + 1);
                    break;
                
                case UnknownEnum.Value_12:
                    Tile = GetTileID(107, HoleTileY + 1);
                    break;
            }
            
            if (Tile > 0)
            {
                tilemap_set_at_pixel(global.TMID_Water_Upper, 0, TileX, TileY);
                tilemap_set_at_pixel(global.TMID_Water_Lower, 0, TileX, TileY);
                tilemap_set_at_pixel((FloorLevel == 1) ? global.TMID_Floor_Upper : global.TMID_Floor_Lower, Tile, TileX, TileY);
            }
        }
    }
    
    ds_grid_destroy(HoleGrid);
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
    Value_12,
    Value_13
}
