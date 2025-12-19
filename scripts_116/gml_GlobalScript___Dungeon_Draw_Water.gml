function Dungeon_Draw_Water(arg0)
{
    if (global.SpawnedCarpets)
        exit;
    
    if (!variable_struct_exists(global.Level.Rooms[arg0].Template, "Water"))
        exit;
    
    global.Level.Rooms[arg0].Water = false;
    
    if (!global.Gore && global.Level.Index == UnknownEnum.Value_12)
        exit;
    
    var RandomWater = true;
    
    switch (global.Level.Index)
    {
        case UnknownEnum.Value_5:
        case UnknownEnum.Value_9:
        case UnknownEnum.Value_12:
            global.Level.Rooms[arg0].Water = Prob((global.Level.Index == UnknownEnum.Value_12) ? 0.55 : 0.75);
            break;
        
        case UnknownEnum.Value_6:
        case UnknownEnum.Value_10:
            global.Level.Rooms[arg0].Water = true;
            RandomWater = false;
            break;
    }
    
    var _WaterTileS = (global.Level.Index == UnknownEnum.Value_10) ? 92 : ((global.Level.Index == UnknownEnum.Value_12) ? 98 : 86);
    
    if (TemplateCheck(arg0, UnknownEnum.Value_8, UnknownEnum.Value_0))
    {
        global.Level.Rooms[arg0].Water = true;
        RandomWater = false;
        _WaterTileS = 86;
    }
    
    if (!global.Level.Rooms[arg0].Water || ObstacleClassCheck(arg0, UnknownEnum.Value_3))
        exit;
    
    var WaterArray = global.Level.Rooms[arg0].Template.Water;
    var _WaterSectionProb = irandom_range(1, 10) * 0.1;
    
    for (var WaterIndex = 0; WaterIndex < array_length(WaterArray); WaterIndex++)
    {
        if (!RandomWater || (RandomWater && Prob(_WaterSectionProb)))
        {
            var Water = WaterArray[WaterIndex];
            var WaterX = global.Level.Rooms[arg0].x + Water.x;
            var WaterY = global.Level.Rooms[arg0].y + Water.y;
            var WaterW = Water.width;
            var WaterH = Water.height;
            var WaterTileW = WaterW / 8;
            var WaterTileH = WaterH / 8;
            var WaterTMID = GetFloorLevelTMID("Tiles_Water", WaterX, WaterY);
            
            for (var _y = 0; _y < WaterTileH; _y++)
            {
                for (var _x = 0; _x < WaterTileW; _x++)
                {
                    var TileX = WaterX + (_x * 8);
                    var TileY = WaterY + (_y * 8);
                    DrawTileBlock(WaterTMID, TileX, TileY, _WaterTileS + (_x % 2), (TileY / 8) % 2, 1, 1);
                }
            }
        }
    }
    
    Dungeon_Draw_Water_Borders(arg0);
    global.SpawnedWater = true;
}

function Dungeon_Draw_Water_Borders(arg0)
{
    var RoomTilesW = global.Level.Rooms[arg0].width / 8;
    var RoomTilesH = global.Level.Rooms[arg0].height / 8;
    var WaterBorderTiles = ds_grid_create(RoomTilesW, RoomTilesH);
    ds_grid_clear(WaterBorderTiles, 0);
    
    for (var _y = 0; _y < RoomTilesH; _y++)
    {
        for (var _x = 0; _x < RoomTilesW; _x++)
        {
            var TileX = global.Level.Rooms[arg0].x + (_x * 8);
            var TileY = global.Level.Rooms[arg0].y + (_y * 8);
            var WaterTMID = GetFloorLevelTMID("Tiles_Water", TileX, TileY);
            
            if (OnWaterTile(WaterTMID, TileX, TileY))
            {
                var TL = OnWaterTile(WaterTMID, TileX - 8, TileY - 8);
                var T = OnWaterTile(WaterTMID, TileX, TileY - 8);
                var TR = OnWaterTile(WaterTMID, TileX + 8, TileY - 8);
                var L = OnWaterTile(WaterTMID, TileX - 8, TileY);
                var R = OnWaterTile(WaterTMID, TileX + 8, TileY);
                var BL = OnWaterTile(WaterTMID, TileX - 8, TileY + 8);
                var B = OnWaterTile(WaterTMID, TileX, TileY + 8);
                var BR = OnWaterTile(WaterTMID, TileX + 8, TileY + 8);
                
                if (!L && !T)
                    ds_grid_set(WaterBorderTiles, _x, _y, 1);
                
                if (!T && L && R)
                    ds_grid_set(WaterBorderTiles, _x, _y, 2);
                
                if (!T && !R)
                    ds_grid_set(WaterBorderTiles, _x, _y, 3);
                
                if (!L && T && B)
                    ds_grid_set(WaterBorderTiles, _x, _y, 4);
                
                if (!R && T && B)
                    ds_grid_set(WaterBorderTiles, _x, _y, 5);
                
                if (!L && !B)
                    ds_grid_set(WaterBorderTiles, _x, _y, 6);
                
                if (!B && L && R)
                    ds_grid_set(WaterBorderTiles, _x, _y, 7);
                
                if (!R && !B)
                    ds_grid_set(WaterBorderTiles, _x, _y, 8);
                
                if (!TL && T && L)
                    ds_grid_set(WaterBorderTiles, _x, _y, 9);
                
                if (!TR && T && R)
                    ds_grid_set(WaterBorderTiles, _x, _y, 10);
                
                if (!BL && B && L)
                    ds_grid_set(WaterBorderTiles, _x, _y, 11);
                
                if (!BR && B && R)
                    ds_grid_set(WaterBorderTiles, _x, _y, 12);
            }
        }
    }
    
    var _WaterTileS = TemplateCheck(arg0, UnknownEnum.Value_8, UnknownEnum.Value_0) ? 86 : ((global.Level.Index == UnknownEnum.Value_10) ? 92 : ((global.Level.Index == UnknownEnum.Value_12) ? 98 : 86));
    
    for (var _y = 0; _y < RoomTilesH; _y++)
    {
        for (var _x = 0; _x < RoomTilesW; _x++)
        {
            var TileX = global.Level.Rooms[arg0].x + (_x * 8);
            var TileY = global.Level.Rooms[arg0].y + (_y * 8);
            var WaterTMID = GetFloorLevelTMID("Tiles_Water", TileX, TileY);
            
            if (ds_grid_get(WaterBorderTiles, _x, _y) != 0)
                tilemap_set_at_pixel(WaterTMID, 0, TileX, TileY);
            
            switch (ds_grid_get(WaterBorderTiles, _x, _y))
            {
                case 1:
                    DrawTileBlock(WaterTMID, TileX, TileY, _WaterTileS, 2, 1, 1);
                    break;
                
                case 2:
                    DrawTileBlock(WaterTMID, TileX, TileY, _WaterTileS + 2, 2, 1, 1);
                    break;
                
                case 3:
                    DrawTileBlock(WaterTMID, TileX, TileY, _WaterTileS + 1, 2, 1, 1);
                    break;
                
                case 4:
                    DrawTileBlock(WaterTMID, TileX, TileY, _WaterTileS + 2, 3, 1, 1);
                    break;
                
                case 5:
                    DrawTileBlock(WaterTMID, TileX, TileY, _WaterTileS + 3, 2, 1, 1);
                    break;
                
                case 6:
                    DrawTileBlock(WaterTMID, TileX, TileY, _WaterTileS, 3, 1, 1);
                    break;
                
                case 7:
                    DrawTileBlock(WaterTMID, TileX, TileY, _WaterTileS + 3, 3, 1, 1);
                    break;
                
                case 8:
                    DrawTileBlock(WaterTMID, TileX, TileY, _WaterTileS + 1, 3, 1, 1);
                    break;
                
                case 9:
                    DrawTileBlock(WaterTMID, TileX, TileY, _WaterTileS + 4, 2, 1, 1);
                    break;
                
                case 10:
                    DrawTileBlock(WaterTMID, TileX, TileY, _WaterTileS + 5, 2, 1, 1);
                    break;
                
                case 11:
                    DrawTileBlock(WaterTMID, TileX, TileY, _WaterTileS + 4, 3, 1, 1);
                    break;
                
                case 12:
                    DrawTileBlock(WaterTMID, TileX, TileY, _WaterTileS + 5, 3, 1, 1);
                    break;
            }
        }
    }
    
    ds_grid_destroy(WaterBorderTiles);
}

enum UnknownEnum
{
    Value_0,
    Value_3 = 3,
    Value_5 = 5,
    Value_6,
    Value_8 = 8,
    Value_9,
    Value_10,
    Value_12 = 12
}
