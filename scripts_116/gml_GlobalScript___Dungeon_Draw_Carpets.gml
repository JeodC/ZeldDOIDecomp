function Dungeon_Draw_Carpets(arg0)
{
    global.SpawnedCarpets = false;
    global.SpawnedCarpetStyle = UnknownEnum.Value_0;
    
    if (!variable_struct_exists(global.Level.Rooms[arg0].Template, "Carpets"))
        exit;
    
    switch (global.Level.Index)
    {
        default:
            exit;
        
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_9:
        case UnknownEnum.Value_12:
            break;
    }
    
    if (global.Level.Rooms[arg0].Section_ID != 0)
        exit;
    
    if (ObstacleClassCheck(arg0, UnknownEnum.Value_3))
        exit;
    
    if (!Prob(0.8) && !(global.Level.Index == UnknownEnum.Value_1 && arg0 == global.Level.RoomIndex_Entrance))
        exit;
    
    var CarpetArray = struct_get_from_hash(global.Level.Rooms[arg0].Template, variable_get_hash("Carpets"));
    var CarpetCount = array_length(CarpetArray);
    var DoorArray = global.Level.Rooms[arg0].Doors;
    var DoorCount = array_length(DoorArray);
    
    if (CarpetCount > 0 && DoorCount >= 2 && arg0 != global.Level.RoomIndex_Entrance)
    {
        var _Matches = 0;
        
        for (var i = 0; i < DoorCount; i++)
        {
            var Door = DoorArray[i];
            
            if (Door.Status == UnknownEnum.Value_11 || Door.Status == UnknownEnum.Value_8 || Door.Status == UnknownEnum.Value_9 || Door.Status == UnknownEnum.Value_10)
                continue;
            
            for (var CarpetIndex = 0; CarpetIndex < CarpetCount; CarpetIndex++)
            {
                var Carpet = CarpetArray[CarpetIndex];
                
                if (Carpet.gid != UnknownEnum.Value_238 && Carpet.gid != UnknownEnum.Value_239)
                    continue;
                
                var _FromDoorList = CSVToList(GetPropertyValue(Carpet.properties, "DoorsFrom"));
                
                if (ds_list_find_index(_FromDoorList, Door.Position) != -1)
                {
                    _Matches++;
                    break;
                }
                
                ds_list_destroy(_FromDoorList);
            }
            
            if (_Matches >= 2)
                break;
        }
        
        if (_Matches >= 2)
        {
            var DoorPositionList = ds_list_create();
            
            for (var i = 0; i < DoorCount; i++)
            {
                var Door = DoorArray[i];
                
                if (Door.Status == UnknownEnum.Value_11 || Door.Status == UnknownEnum.Value_8 || Door.Status == UnknownEnum.Value_9 || Door.Status == UnknownEnum.Value_10)
                    continue;
                
                ds_list_add(DoorPositionList, Door.Position);
            }
            
            for (var Pass = 0; Pass < 2; Pass++)
            {
                for (var CarpetIndex = 0; CarpetIndex < CarpetCount; CarpetIndex++)
                {
                    var Carpet = CarpetArray[CarpetIndex];
                    var CarpetGID = Carpet.gid;
                    var CarpetX = global.Level.Rooms[arg0].x + Carpet.x;
                    var CarpetY = global.Level.Rooms[arg0].y + Carpet.y;
                    var CarpetX2 = (CarpetX + Carpet.width) - 1;
                    var CarpetY2 = (CarpetY + Carpet.height) - 1;
                    var CarpetTileW = Carpet.width / 8;
                    var CarpetTileH = Carpet.height / 8;
                    var TMID = GetFloorLevelTMID("Tiles_Floor", CarpetX, CarpetY);
                    DoorList[1] = CSVToList(GetPropertyValue(Carpet.properties, "DoorsFrom"));
                    DoorList[2] = CSVToList(GetPropertyValue(Carpet.properties, "DoorsTo"));
                    Doors[1] = ds_list_size(DoorList[1]);
                    Doors[2] = ds_list_size(DoorList[2]);
                    
                    switch (CarpetGID)
                    {
                        case UnknownEnum.Value_238:
                        case UnknownEnum.Value_239:
                            if (Pass != 0)
                                break;
                            
                            DoorMatch[1] = false;
                            DoorMatch[2] = false;
                            
                            for (var DoorSetIndex = 1; DoorSetIndex <= 2; DoorSetIndex++)
                            {
                                for (var i = 0; i < Doors[DoorSetIndex]; i++)
                                {
                                    var DoorPositionStr = ds_list_find_value(array_get(DoorList, DoorSetIndex), i);
                                    
                                    if (DoorPositionStr == "")
                                        continue;
                                    
                                    var DoorPosition = real(DoorPositionStr);
                                    var InvalidDoor = false;
                                    var RoomDoors = array_length(global.Level.Rooms[arg0].Doors);
                                    
                                    for (var _RoomDoorIndex = 0; _RoomDoorIndex < RoomDoors; _RoomDoorIndex++)
                                    {
                                        var _RoomDoorPosition = global.Level.DungeonTemplate.Rooms[arg0].Doors[_RoomDoorIndex].Position;
                                        var _RoomDoorStatus = global.Level.Rooms[arg0].Doors[_RoomDoorIndex].Status;
                                        
                                        if (_RoomDoorPosition == DoorPosition && Carpet_InvalidDoor(_RoomDoorStatus))
                                        {
                                            InvalidDoor = true;
                                            break;
                                        }
                                    }
                                    
                                    if (InvalidDoor)
                                        continue;
                                    
                                    if (ds_list_find_index(DoorPositionList, DoorPosition) != -1)
                                    {
                                        DoorMatch[DoorSetIndex] = true;
                                        break;
                                    }
                                }
                            }
                            
                            if (DoorMatch[1] && DoorMatch[2])
                            {
                                if (CarpetGID == UnknownEnum.Value_238)
                                    Carpet_Draw_H(CarpetX, CarpetY, CarpetTileW, CarpetTileH, TMID);
                                else
                                    Carpet_Draw_V(CarpetX, CarpetY, CarpetTileW, CarpetTileH, TMID);
                                
                                global.SpawnedCarpets = true;
                                global.SpawnedCarpetStyle = UnknownEnum.Value_1;
                            }
                            
                            break;
                        
                        default:
                            if (Pass != 1)
                                break;
                            
                            var Top = false;
                            var Bottom = false;
                            var Left = false;
                            var Right = false;
                            
                            switch (CarpetGID)
                            {
                                case UnknownEnum.Value_240:
                                case UnknownEnum.Value_241:
                                case UnknownEnum.Value_244:
                                case UnknownEnum.Value_246:
                                case UnknownEnum.Value_247:
                                case UnknownEnum.Value_248:
                                    var DoorInstAbove = collision_rectangle(CarpetX, CarpetY - 24, CarpetX2, CarpetY, oDoor, false, true);
                                    
                                    if (DoorInstAbove != -4)
                                    {
                                        if (Carpet_InvalidDoor(DoorInstAbove.Status))
                                            break;
                                    }
                                    
                                    var TileAbove = tilemap_get_at_pixel(TMID, CarpetX, CarpetY - 4);
                                    
                                    if (TileAbove == global.CarpetTileTrim || DoorInstAbove != -4)
                                        Top = true;
                                    
                                    break;
                            }
                            
                            switch (CarpetGID)
                            {
                                case UnknownEnum.Value_242:
                                case UnknownEnum.Value_243:
                                case UnknownEnum.Value_245:
                                case UnknownEnum.Value_246:
                                case UnknownEnum.Value_247:
                                case UnknownEnum.Value_248:
                                    var DoorInstBelow = collision_rectangle(CarpetX, CarpetY2, CarpetX2, CarpetY2 + 24, oDoor, false, true);
                                    
                                    if (DoorInstBelow != -4)
                                    {
                                        if (Carpet_InvalidDoor(DoorInstBelow.Status))
                                            break;
                                    }
                                    
                                    var TileBelow = tilemap_get_at_pixel(TMID, CarpetX, CarpetY2 + 4);
                                    
                                    if (TileBelow == global.CarpetTileTrim || DoorInstBelow != -4)
                                        Bottom = true;
                                    
                                    break;
                            }
                            
                            switch (CarpetGID)
                            {
                                case UnknownEnum.Value_240:
                                case UnknownEnum.Value_242:
                                case UnknownEnum.Value_244:
                                case UnknownEnum.Value_245:
                                case UnknownEnum.Value_246:
                                case UnknownEnum.Value_248:
                                    var DoorInstLeft = collision_rectangle(CarpetX - 24, CarpetY, CarpetX, CarpetY2, oDoor, false, true);
                                    
                                    if (DoorInstLeft != -4)
                                    {
                                        if (Carpet_InvalidDoor(DoorInstLeft.Status))
                                            break;
                                    }
                                    
                                    var TileLeft = tilemap_get_at_pixel(TMID, CarpetX - 4, CarpetY);
                                    
                                    if (TileLeft == global.CarpetTileTrim || DoorInstLeft != -4)
                                        Left = true;
                                    
                                    break;
                            }
                            
                            switch (CarpetGID)
                            {
                                case UnknownEnum.Value_241:
                                case UnknownEnum.Value_243:
                                case UnknownEnum.Value_244:
                                case UnknownEnum.Value_245:
                                case UnknownEnum.Value_247:
                                case UnknownEnum.Value_248:
                                    var DoorInstRight = collision_rectangle(CarpetX2, CarpetY, CarpetX2 + 24, CarpetY2, oDoor, false, true);
                                    
                                    if (DoorInstRight != -4)
                                    {
                                        if (Carpet_InvalidDoor(DoorInstRight.Status))
                                            break;
                                    }
                                    
                                    var TileRight = tilemap_get_at_pixel(TMID, CarpetX2 + 4, CarpetY);
                                    
                                    if (TileRight == global.CarpetTileTrim || DoorInstRight != -4)
                                        Right = true;
                                    
                                    break;
                            }
                            
                            if (Top || Bottom || Left || Right)
                            {
                                Carpet_Draw_Corner(CarpetX, CarpetY, TMID, Top, Bottom, Left, Right);
                                global.SpawnedCarpets = true;
                                global.SpawnedCarpetStyle = UnknownEnum.Value_1;
                            }
                            
                            break;
                            break;
                            continue;
                    }
                    
                    ds_list_destroy(DoorList[1]);
                    ds_list_destroy(DoorList[2]);
                }
            }
            
            ds_list_destroy(DoorPositionList);
        }
        
        if (global.SpawnedCarpets)
            exit;
    }
}

function Dungeon_Draw_CarpetsFull(arg0)
{
    if (global.SpawnedCarpets || !variable_struct_exists(global.Level.Rooms[arg0].Template, "CarpetsFull"))
        exit;
    
    if (global.Level.Rooms[arg0].Section_ID != 0)
        exit;
    
    if (global.Level.Index != UnknownEnum.Value_1 && global.Level.Index != UnknownEnum.Value_9)
        exit;
    
    var FullCarpets = Prob(0.4) || global.Level.Rooms[arg0].GridW == 2 || global.Level.Rooms[arg0].GridH == 2;
    
    if (FullCarpets)
    {
        var CarpetArray = struct_get_from_hash(global.Level.Rooms[arg0].Template, variable_get_hash("CarpetsFull"));
        var CarpetCount = array_length(CarpetArray);
        
        if (CarpetCount == 0)
            exit;
        
        var FullCarpetList = ds_list_create_sequence_shuffled(0, CarpetCount - 1);
        var Carpet = array_get(CarpetArray, ds_list_find_value(FullCarpetList, 0));
        var CarpetX = global.Level.Rooms[arg0].x + Carpet.x;
        var CarpetY = global.Level.Rooms[arg0].y + Carpet.y;
        var CarpetTileW = Carpet.width / 8;
        var CarpetTileH = Carpet.height / 8;
        var TMID = GetFloorLevelTMID("Tiles_Floor", CarpetX, CarpetY);
        var _X1 = CarpetX;
        var _Y1 = CarpetY;
        var _X2 = (_X1 + Carpet.width) - 1;
        var _Y2 = (_Y1 + Carpet.height) - 1;
        
        while (1)
        {
            if (collision_rectangle(_X1, _Y1, _X2, _Y2, oWall, false, true) != -4)
            {
                _X1 += 16;
                break;
            }
            else
            {
                _X1 -= 8;
            }
        }
        
        while (1)
        {
            if (collision_rectangle(_X1, _Y1, _X2, _Y2, oWall, false, true) != -4)
            {
                _X2 -= 16;
                break;
            }
            else
            {
                _X2 += 8;
            }
        }
        
        while (1)
        {
            if (collision_rectangle(_X1, _Y1, _X2, _Y2, oWall, false, true) != -4)
            {
                _Y1 += 16;
                break;
            }
            else
            {
                _Y1 -= 8;
            }
        }
        
        while (1)
        {
            if (collision_rectangle(_X1, _Y1, _X2, _Y2, oWall, false, true) != -4)
            {
                _Y2 -= 16;
                break;
            }
            else
            {
                _Y2 += 8;
            }
        }
        
        CarpetX = _X1;
        CarpetY = _Y1;
        CarpetTileW = ((_X2 - _X1) + 1) / 8;
        CarpetTileH = ((_Y2 - _Y1) + 1) / 8;
        
        if (CarpetTileW >= 10 && CarpetTileH >= 10)
        {
            Carpet_Draw_Full(CarpetX, CarpetY, CarpetTileW, CarpetTileH, TMID);
            global.SpawnedCarpets = true;
            global.SpawnedCarpetStyle = UnknownEnum.Value_2;
        }
        
        ds_list_destroy(FullCarpetList);
    }
}

function Carpet_InvalidDoor(arg0)
{
    return arg0 == UnknownEnum.Value_8 || arg0 == UnknownEnum.Value_9 || (global.Level.Index == UnknownEnum.Value_1 && arg0 == UnknownEnum.Value_3);
}

function Carpet_Draw_H(arg0, arg1, arg2, arg3, arg4)
{
    for (var _y = 0; _y < arg3; _y++)
    {
        for (var _x = 0; _x < arg2; _x++)
        {
            var _TileX = arg0 + (_x * 8);
            var _TileY = arg1 + (_y * 8);
            tilemap_set_at_pixel(arg4, global.CarpetTileBase, _TileX, _TileY);
            
            if (_y == 0 || _y == (arg3 - 1))
                tilemap_set_at_pixel(arg4, global.CarpetTileTrim, _TileX, _TileY);
        }
    }
}

function Carpet_Draw_V(arg0, arg1, arg2, arg3, arg4)
{
    for (var _y = 0; _y < arg3; _y++)
    {
        for (var _x = 0; _x < arg2; _x++)
        {
            var _TileX = arg0 + (_x * 8);
            var _TileY = arg1 + (_y * 8);
            tilemap_set_at_pixel(arg4, global.CarpetTileBase, _TileX, _TileY);
            
            if (_x == 0 || _x == (arg2 - 1))
                tilemap_set_at_pixel(arg4, global.CarpetTileTrim, _TileX, _TileY);
        }
    }
}

function Carpet_Draw_Full(arg0, arg1, arg2, arg3, arg4)
{
    for (var _y = 0; _y < arg3; _y++)
    {
        for (var _x = 0; _x < arg2; _x++)
        {
            var _TileX = arg0 + (_x * 8);
            var _TileY = arg1 + (_y * 8);
            tilemap_set_at_pixel(arg4, global.CarpetTileBase, _TileX, _TileY);
            
            if (_x == 0 || _x == (arg2 - 1) || _y == 0 || _y == (arg3 - 1))
                tilemap_set_at_pixel(arg4, global.CarpetTileTrim, _TileX, _TileY);
        }
    }
}

function Carpet_Draw_Corner(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
{
    for (var _y = 0; _y < 6; _y++)
    {
        for (var _x = 0; _x < 6; _x++)
        {
            var _TileX = arg0 + (_x * 8);
            var _TileY = arg1 + (_y * 8);
            tilemap_set_at_pixel(arg2, global.CarpetTileBase, _TileX, _TileY);
            
            if ((_x == 0 && _y == 0) || (_x == 5 && _y == 0) || (_x == 0 && _y == 5) || (_x == 5 && _y == 5))
                tilemap_set_at_pixel(arg2, global.CarpetTileTrim, _TileX, _TileY);
            
            if (!arg3 && _x > 0 && _x < 5 && _y == 0)
                tilemap_set_at_pixel(arg2, global.CarpetTileTrim, _TileX, _TileY);
            
            if (!arg4 && _x > 0 && _x < 5 && _y == 5)
                tilemap_set_at_pixel(arg2, global.CarpetTileTrim, _TileX, _TileY);
            
            if (!arg5 && _x == 0 && _y > 0 && _y < 5)
                tilemap_set_at_pixel(arg2, global.CarpetTileTrim, _TileX, _TileY);
            
            if (!arg6 && _x == 5 && _y > 0 && _y < 5)
                tilemap_set_at_pixel(arg2, global.CarpetTileTrim, _TileX, _TileY);
        }
    }
}

function CornersOnCarpet(arg0, arg1, arg2, arg3, arg4)
{
    var Corners = 0;
    var TileTL = tilemap_get_at_pixel(arg0, arg1, arg2);
    var TileTR = tilemap_get_at_pixel(arg0, arg3, arg2);
    var TileBL = tilemap_get_at_pixel(arg0, arg1, arg4);
    var TileBR = tilemap_get_at_pixel(arg0, arg3, arg4);
    var TileMid = tilemap_get_at_pixel(arg0, arg1 + round((arg3 - arg1) / 2), arg2 + round((arg4 - arg2) / 2));
    
    if (TileTL == global.CarpetTileBase || TileTL == global.CarpetTileTrim)
        Corners++;
    
    if (TileTR == global.CarpetTileBase || TileTR == global.CarpetTileTrim)
        Corners++;
    
    if (TileBL == global.CarpetTileBase || TileBL == global.CarpetTileTrim)
        Corners++;
    
    if (TileBR == global.CarpetTileBase || TileBR == global.CarpetTileTrim)
        Corners++;
    
    if (TileMid == global.CarpetTileBase || TileMid == global.CarpetTileTrim)
        Corners++;
    
    return Corners;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_8 = 8,
    Value_9,
    Value_10,
    Value_11,
    Value_12,
    Value_238 = 238,
    Value_239,
    Value_240,
    Value_241,
    Value_242,
    Value_243,
    Value_244,
    Value_245,
    Value_246,
    Value_247,
    Value_248
}
