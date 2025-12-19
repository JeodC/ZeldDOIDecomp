function Dungeon_Draw_ExtraCeilings(arg0)
{
    if (!variable_struct_exists(global.Level.Rooms[arg0].Template, "ExtraCeilings"))
        exit;
    
    var _TilesY = (global.Level.Index == UnknownEnum.Value_13) ? 70 : (4 + ((global.Level.Index - 1) * 6));
    
    for (var ExtraCeilingIndex = 0; ExtraCeilingIndex < array_length(global.Level.Rooms[arg0].Template.ExtraCeilings); ExtraCeilingIndex++)
    {
        var _Obj = global.Level.Rooms[arg0].Template.ExtraCeilings[ExtraCeilingIndex];
        var TLCornerX = global.Level.Rooms[arg0].x + _Obj.x;
        var TLCornerY = global.Level.Rooms[arg0].y + _Obj.y;
        var TileW = _Obj.width / 8;
        var TileH = _Obj.height / 8;
        var PropertiesArray = _Obj.properties;
        var _TMID;
        
        if (GetPropertyValue(PropertiesArray, "Boss") != -1)
        {
            ClearTileBlock(global.TMID_Tiles_Ceiling, TLCornerX, TLCornerY, TileW, TileH);
            _TMID = global.TMID_Decor_Upper;
        }
        else if (GetPropertyValue(PropertiesArray, "Higher") != -1)
        {
            _TMID = global.TMID_Tiles_Higher;
        }
        else
        {
            _TMID = global.TMID_Tiles_Ceiling;
        }
        
        for (var _y = 0; _y < TileH; _y++)
        {
            for (var _x = 0; _x < TileW; _x++)
                DrawTileBlock(_TMID, TLCornerX + (_x * 8), TLCornerY + (_y * 8), 8, _TilesY + 2, 1, 1);
        }
    }
}

enum UnknownEnum
{
    Value_13 = 13
}
