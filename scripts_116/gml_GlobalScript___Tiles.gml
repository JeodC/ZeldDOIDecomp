function GetTileID(arg0, arg1)
{
    return (arg1 * 156) + arg0;
}

function DrawTileBlock(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7 = false, arg8 = false, arg9 = false)
{
    for (var _y = 0; _y < arg6; _y++)
    {
        for (var _x = 0; _x < arg5; _x++)
        {
            var _OffsetX = _x;
            var _OffsetY = _y;
            var Tile = GetTileID(arg3, arg4) + (_y * 156) + _x;
            Tile = tile_set_mirror(Tile, arg7);
            Tile = tile_set_flip(Tile, arg8);
            Tile = tile_set_rotate(Tile, arg9);
            
            if (arg7)
                _OffsetX = arg5 - _x - 1;
            
            if (arg8)
                _OffsetY = arg6 - _y - 1;
            
            if (arg9)
            {
                if (arg7 && !arg8)
                {
                    _OffsetX = arg6 - _y - 1;
                    _OffsetY = arg5 - _x - 1;
                }
                else if (arg8 && !arg7)
                {
                    _OffsetX = _y;
                    _OffsetY = _x;
                }
                else if (arg8 && arg7)
                {
                    _OffsetX = _y;
                    _OffsetY = arg5 - _x - 1;
                }
                else
                {
                    _OffsetX = arg6 - _y - 1;
                    _OffsetY = _x;
                }
            }
            
            tilemap_set_at_pixel(arg0, Tile, arg1 + (_OffsetX * 8), arg2 + (_OffsetY * 8));
        }
    }
}

function DrawTileBlockRotate(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7 = 0)
{
    var _Mirror = false;
    var _Flip = false;
    var _RotateCW = false;
    
    switch (arg7)
    {
        case 90:
            _Flip = true;
            break;
        
        case 180:
            _Mirror = true;
            _Flip = true;
            break;
        
        case 270:
            _RotateCW = true;
            break;
    }
    
    return DrawTileBlock(arg0, arg1, arg2, arg3, arg4, arg5, arg6, _Mirror, _Flip, _RotateCW);
}

function ClearTileBlock(arg0, arg1, arg2, arg3, arg4, arg5 = 0)
{
    for (var _y = 0; _y < arg4; _y++)
    {
        for (var _x = 0; _x < arg3; _x++)
            tilemap_set_at_pixel(arg0, arg5, arg1 + (_x * 8), arg2 + (_y * 8));
    }
}

function CollideTileBlock(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
{
    var _TLTile = GetTileID(arg3, arg4);
    
    for (var _y = 0; _y < arg6; _y++)
    {
        for (var _x = 0; _x < arg5; _x++)
        {
            if (tilemap_get_at_pixel(arg0, arg1, arg2) == (_TLTile + (_y * 156) + _x))
                return true;
        }
    }
    
    return false;
}

function OnSpikeTile(arg0, arg1, arg2)
{
    var TileIndex = tilemap_get_at_pixel(arg0, arg1, arg2);
    return (TileIndex >= global.SpikeTileID[0] && TileIndex <= (global.SpikeTileID[0] + 4)) || (TileIndex >= global.SpikeTileID[1] && TileIndex <= (global.SpikeTileID[1] + 4));
}

function OnWaterTile(arg0, arg1, arg2)
{
    var TileIndex = tilemap_get_at_pixel(arg0, arg1, arg2);
    return (TileIndex >= global.WaterTileStart1 && TileIndex <= (global.WaterTileStart1 + 5)) || (TileIndex >= global.WaterTileStart2 && TileIndex <= (global.WaterTileStart2 + 5)) || (TileIndex >= global.WaterTileStart3 && TileIndex <= (global.WaterTileStart3 + 5)) || (TileIndex >= global.WaterTileStart4 && TileIndex <= (global.WaterTileStart4 + 5)) || (TileIndex >= global.WaterTileStart5 && TileIndex <= (global.WaterTileStart5 + 5)) || (TileIndex >= global.WaterTileStart6 && TileIndex <= (global.WaterTileStart6 + 5));
}

function OnSandTile(arg0, arg1, arg2)
{
    var TileIndex = tilemap_get_at_pixel(arg0, arg1, arg2);
    
    for (var i = 0; i < 8; i++)
    {
        if (TileIndex == global.SandTile[i])
            return true;
    }
    
    return false;
}

function GetFloorLevelString()
{
    if (argument_count == 1)
    {
        var FloorLevel = argument[0];
        return (FloorLevel == 0) ? "Lower" : "Upper";
    }
    else if (argument_count == 2)
    {
        var _x = argument[0];
        var _y = argument[1];
        
        if (tilemap_get_at_pixel(global.TMID_Floor_Upper, _x, _y) != 0)
            return "Upper";
        else
            return "Lower";
    }
}

function GetFloorLevelID()
{
    if (argument_count == 1)
    {
        var FloorLevel = argument[0];
        return (FloorLevel == "Upper") ? 1 : 0;
    }
    else if (argument_count == 2)
    {
        var _x = argument[0];
        var _y = argument[1];
        
        if (tilemap_get_at_pixel(global.TMID_Floor_Upper, _x, _y) != 0)
            return 1;
        else
            return 0;
    }
}

function GetFloorLevelTMID(arg0, arg1, arg2)
{
    var FloorLevelStr = GetFloorLevelString(arg1, arg2);
    return layer_tilemap_get_id(layer_get_id(arg0 + "_" + FloorLevelStr));
}
