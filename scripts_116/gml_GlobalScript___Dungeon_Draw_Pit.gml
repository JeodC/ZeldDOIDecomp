function Dungeon_Draw_Pit(arg0)
{
    if (!variable_struct_exists(global.Level.Rooms[arg0].Template, "Pit"))
        exit;
    
    var WallArray = global.Level.Rooms[arg0].Template.Pit;
    var Walls = array_length(WallArray);
    
    for (var WallIndex = 0; WallIndex < Walls; WallIndex++)
    {
        var WallObj = WallArray[WallIndex];
        var TLCornerX = global.Level.Rooms[arg0].x + WallObj.x;
        var TLCornerY = global.Level.Rooms[arg0].y + WallObj.y;
        var GID = WallObj.gid;
        var WallTileW = WallObj.width / 8;
        var WallTileH = WallObj.height / 8;
        var PropertiesArray = WallObj.properties;
        var TilesX, TilesY;
        
        if (GetPropertyValue(PropertiesArray, "LavaPit") != -1)
        {
            TilesX = 122;
            TilesY = 94;
        }
        else
        {
            TilesX = 38;
            TilesY = 4 + ((global.Level.Index - 1) * 6);
        }
        
        switch (GID)
        {
            case UnknownEnum.Value_305:
                for (var i = 0; i < WallTileW; i++)
                {
                    var TileX = TLCornerX + (i * 8);
                    DrawTileBlock(global.TMID_Pit, TileX, TLCornerY, TilesX + (i % 2), TilesY, 1, 2);
                }
                
                break;
            
            case UnknownEnum.Value_302:
                for (var i = 0; i < WallTileW; i++)
                {
                    var TileX = TLCornerX + (i * 8);
                    DrawTileBlock(global.TMID_Pit, TileX, TLCornerY, TilesX + 2 + (i % 2), TilesY + 2, 1, 2);
                }
                
                break;
            
            case UnknownEnum.Value_303:
                for (var i = 0; i < WallTileH; i++)
                {
                    var TileY = TLCornerY + (i * 8);
                    DrawTileBlock(global.TMID_Pit, TLCornerX, TileY, TilesX, TilesY + 2 + (i % 2), 2, 1);
                }
                
                break;
            
            case UnknownEnum.Value_304:
                for (var i = 0; i < WallTileH; i++)
                {
                    var TileY = TLCornerY + (i * 8);
                    DrawTileBlock(global.TMID_Pit, TLCornerX, TileY, TilesX + 2, TilesY + (i % 2), 2, 1);
                }
                
                break;
        }
    }
    
    for (var WallIndex = 0; WallIndex < Walls; WallIndex++)
    {
        var WallObj = WallArray[WallIndex];
        var TLCornerX = global.Level.Rooms[arg0].x + WallObj.x;
        var TLCornerY = global.Level.Rooms[arg0].y + WallObj.y;
        var GID = WallObj.gid;
        var PropertiesArray = WallObj.properties;
        var TilesX, TilesY;
        
        if (GetPropertyValue(PropertiesArray, "LavaPit") != -1)
        {
            TilesX = 118;
            TilesY = 94;
        }
        else
        {
            TilesX = 34;
            TilesY = 4 + ((global.Level.Index - 1) * 6);
        }
        
        switch (GID)
        {
            case UnknownEnum.Value_308:
                DrawTileBlock(global.TMID_Pit, TLCornerX, TLCornerY, TilesX, TilesY, 2, 2);
                break;
            
            case UnknownEnum.Value_309:
                DrawTileBlock(global.TMID_Pit, TLCornerX, TLCornerY, TilesX + 2, TilesY, 2, 2);
                break;
            
            case UnknownEnum.Value_306:
                DrawTileBlock(global.TMID_Pit, TLCornerX, TLCornerY, TilesX, TilesY + 2, 2, 2);
                break;
            
            case UnknownEnum.Value_307:
                DrawTileBlock(global.TMID_Pit, TLCornerX, TLCornerY, TilesX + 2, TilesY + 2, 2, 2);
                break;
            
            case UnknownEnum.Value_312:
                DrawTileBlock(global.TMID_Pit, TLCornerX, TLCornerY, TilesX, TilesY + 4, 2, 2);
                break;
            
            case UnknownEnum.Value_313:
                DrawTileBlock(global.TMID_Pit, TLCornerX, TLCornerY, TilesX + 2, TilesY + 4, 2, 2);
                break;
            
            case UnknownEnum.Value_310:
                DrawTileBlock(global.TMID_Pit, TLCornerX, TLCornerY, TilesX + 4, TilesY + 4, 2, 2);
                break;
            
            case UnknownEnum.Value_311:
                DrawTileBlock(global.TMID_Pit, TLCornerX, TLCornerY, TilesX + 6, TilesY + 4, 2, 2);
                break;
        }
    }
}

enum UnknownEnum
{
    Value_302 = 302,
    Value_303,
    Value_304,
    Value_305,
    Value_306,
    Value_307,
    Value_308,
    Value_309,
    Value_310,
    Value_311,
    Value_312,
    Value_313
}
