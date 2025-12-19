function DrawFloorTrim(arg0, arg1, arg2, arg3, arg4)
{
    var _FloorLayer, _WaterLayer;
    
    if (arg0 == 0)
    {
        _FloorLayer = global.TMID_Floor_Upper;
        _WaterLayer = global.TMID_Water_Upper;
    }
    else
    {
        _FloorLayer = global.TMID_Floor_Lower;
        _WaterLayer = global.TMID_Water_Lower;
    }
    
    if (tilemap_get_at_pixel(_FloorLayer, arg1, arg2) != 0)
    {
        tilemap_set_at_pixel(_FloorLayer, GetTileID(arg3, arg4), arg1, arg2);
        tilemap_set_at_pixel(_WaterLayer, 0, arg1, arg2);
    }
}

function Dungeon_Draw_Walls(arg0)
{
    var CreateUpperWallObjs = false;
    var _DoorCount = array_length(global.Level.DungeonTemplate.Rooms[arg0].Doors);
    
    for (var _DoorIndex = 0; _DoorIndex < _DoorCount; _DoorIndex++)
    {
        var _Door = global.Level.Rooms[arg0].Doors[_DoorIndex];
        
        if (_Door.Position <= 12)
        {
            CreateUpperWallObjs = true;
            break;
        }
    }
    
    var CreateLowerWallObjs = global.Level.Rooms[arg0].TemplateClass != UnknownEnum.Value_6 && !(global.Level.Rooms[arg0].TemplateClass == UnknownEnum.Value_7 && global.Level.Rooms[arg0].Section_ID < 25);
    
    for (var WallLevel = 0; WallLevel < 2; WallLevel++)
    {
        if (WallLevel == 1 && !variable_struct_exists(global.Level.Rooms[arg0].Template, "WallsLower"))
            break;
        
        var WallArray, TMID_Walls, LevelStr;
        
        switch (WallLevel)
        {
            case 0:
                WallArray = global.Level.Rooms[arg0].Template.WallsUpper;
                LevelStr = "Upper";
                TMID_Walls = global.TMID_Walls_Upper;
                break;
            
            case 1:
                WallArray = global.Level.Rooms[arg0].Template.WallsLower;
                LevelStr = "Lower";
                TMID_Walls = global.TMID_Walls_Lower;
                break;
        }
        
        var Walls = array_length(WallArray);
        var FloorTrimTileX = 42;
        var FloorTrimTileY = 4 + ((global.Level.Index - 1) * 6);
        var TilesThemeX = 0;
        var TilesThemeY = 4 + ((global.Level.Index - 1) * 6);
        
        switch (global.Level.Index)
        {
            case UnknownEnum.Value_0:
                TilesThemeY = 4;
                break;
            
            case UnknownEnum.Value_13:
                FloorTrimTileY = 70;
                TilesThemeX = 118;
                TilesThemeY = 4 + ((global.Level.Index - 1) * 6) + 12;
                break;
        }
        
        if (global.Level.Rooms[arg0].ForcedTheme != -1)
        {
            TilesThemeX = (global.Level.Rooms[arg0].ForcedTheme > 11) ? 101 : 0;
            TilesThemeY = 4 + (global.Level.Rooms[arg0].ForcedTheme * 6);
        }
        
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
                TilesX = 84;
                TilesY = 94;
            }
            else
            {
                TilesX = TilesThemeX;
                TilesY = TilesThemeY;
            }
            
            switch (GID)
            {
                case UnknownEnum.Value_28:
                case UnknownEnum.Value_32:
                    for (var i = 0; i < WallTileW; i++)
                    {
                        var TileX = TLCornerX + (i * 8);
                        DrawTileBlock(TMID_Walls, TileX, TLCornerY, TilesX + 6 + (((TileX % 16) == 0) ? 1 : 0) + (WallLevel * 17), TilesY, 1, 3);
                        DrawFloorTrim(WallLevel, TileX, TLCornerY + 24, FloorTrimTileX + 2 + ((TileX / 8) % 2), FloorTrimTileY + 2 + (WallLevel * 2));
                    }
                    
                    if ((GID == UnknownEnum.Value_28 && CreateLowerWallObjs) || (GID == UnknownEnum.Value_32 && CreateUpperWallObjs))
                        WallObj_Create("Objs_" + LevelStr, TLCornerX, TLCornerY, WallTileW, WallTileH, 1, GID);
                    
                    break;
                
                case UnknownEnum.Value_25:
                case UnknownEnum.Value_29:
                    for (var i = 0; i < WallTileW; i++)
                    {
                        var TileX = TLCornerX + (i * 8);
                        DrawTileBlock(TMID_Walls, TileX, TLCornerY, TilesX + 9 + (((TileX % 16) == 0) ? 1 : 0) + (WallLevel * 17), TilesY + 2, 1, 3);
                        DrawFloorTrim(WallLevel, TileX, TLCornerY - 8, FloorTrimTileX + 2 + ((TileX / 8) % 2), FloorTrimTileY + 3 + (WallLevel * 2));
                    }
                    
                    if ((GID == UnknownEnum.Value_25 && CreateLowerWallObjs) || (GID == UnknownEnum.Value_29 && CreateUpperWallObjs))
                        WallObj_Create("Objs_" + LevelStr, TLCornerX, TLCornerY, WallTileW, WallTileH, 2, GID);
                    
                    break;
                
                case UnknownEnum.Value_26:
                case UnknownEnum.Value_30:
                    for (var i = 0; i < WallTileH; i++)
                    {
                        var TileY = TLCornerY + (i * 8);
                        DrawTileBlock(TMID_Walls, TLCornerX, TileY, TilesX + 6 + (WallLevel * 17), TilesY + 3 + (((TileY % 16) == 0) ? 1 : 0), 3, 1);
                        DrawFloorTrim(WallLevel, TLCornerX + 24, TileY, FloorTrimTileX + 4, FloorTrimTileY + 2 + (WallLevel * 2) + ((TileY / 8) % 2));
                    }
                    
                    if ((GID == UnknownEnum.Value_26 && CreateLowerWallObjs) || (GID == UnknownEnum.Value_30 && CreateUpperWallObjs))
                        WallObj_Create("Objs_" + LevelStr, TLCornerX, TLCornerY, WallTileW, WallTileH, 3, GID);
                    
                    break;
                
                case UnknownEnum.Value_27:
                case UnknownEnum.Value_31:
                    for (var i = 0; i < WallTileH; i++)
                    {
                        var TileY = TLCornerY + (i * 8);
                        DrawTileBlock(TMID_Walls, TLCornerX, TileY, TilesX + 8 + (WallLevel * 17), TilesY + (((TileY % 16) == 0) ? 1 : 0), 3, 1);
                        DrawFloorTrim(WallLevel, TLCornerX - 8, TileY, FloorTrimTileX + 5, FloorTrimTileY + 2 + (WallLevel * 2) + ((TileY / 8) % 2));
                    }
                    
                    if ((GID == UnknownEnum.Value_27 && CreateLowerWallObjs) || (GID == UnknownEnum.Value_31 && CreateUpperWallObjs))
                        WallObj_Create("Objs_" + LevelStr, TLCornerX, TLCornerY, WallTileW, WallTileH, 4, GID);
                    
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
                TilesX = 84;
                TilesY = 94;
            }
            else
            {
                TilesX = TilesThemeX;
                TilesY = TilesThemeY;
            }
            
            switch (GID)
            {
                case UnknownEnum.Value_19:
                case UnknownEnum.Value_11:
                    DrawTileBlock(TMID_Walls, TLCornerX, TLCornerY, TilesX + (WallLevel * 17), TilesY, 3, 3);
                    
                    if ((GID == UnknownEnum.Value_19 && CreateLowerWallObjs) || (GID == UnknownEnum.Value_11 && CreateUpperWallObjs))
                        WallObj_Create("Objs_" + LevelStr, TLCornerX, TLCornerY, 3, 3, 6, GID);
                    
                    break;
                
                case UnknownEnum.Value_20:
                case UnknownEnum.Value_12:
                    DrawTileBlockRotate(TMID_Walls, TLCornerX, TLCornerY, TilesX + (WallLevel * 17), TilesY, 3, 3, 270);
                    
                    if ((GID == UnknownEnum.Value_20 && CreateLowerWallObjs) || (GID == UnknownEnum.Value_12 && CreateUpperWallObjs))
                        WallObj_Create("Objs_" + LevelStr, TLCornerX, TLCornerY, 3, 3, 7, GID);
                    
                    break;
                
                case UnknownEnum.Value_17:
                case UnknownEnum.Value_9:
                    DrawTileBlockRotate(TMID_Walls, TLCornerX, TLCornerY, TilesX + (WallLevel * 17), TilesY, 3, 3, 90);
                    
                    if ((GID == UnknownEnum.Value_17 && CreateLowerWallObjs) || (GID == UnknownEnum.Value_9 && CreateUpperWallObjs))
                        WallObj_Create("Objs_" + LevelStr, TLCornerX, TLCornerY, 3, 3, 8, GID);
                    
                    break;
                
                case UnknownEnum.Value_18:
                case UnknownEnum.Value_10:
                    DrawTileBlockRotate(TMID_Walls, TLCornerX, TLCornerY, TilesX + (WallLevel * 17), TilesY, 3, 3, 180);
                    
                    if ((GID == UnknownEnum.Value_18 && CreateLowerWallObjs) || (GID == UnknownEnum.Value_10 && CreateUpperWallObjs))
                        WallObj_Create("Objs_" + LevelStr, TLCornerX, TLCornerY, 3, 3, 9, GID);
                    
                    break;
                
                case UnknownEnum.Value_15:
                case UnknownEnum.Value_23:
                    DrawTileBlock(TMID_Walls, TLCornerX, TLCornerY, TilesX + 11 + (WallLevel * 17), TilesY, 3, 3);
                    DrawFloorTrim(WallLevel, TLCornerX + 24, TLCornerY + 24, FloorTrimTileX + 6, FloorTrimTileY + 2 + (WallLevel * 2));
                    
                    for (var i = 0; i < 3; i++)
                    {
                        var TileX = TLCornerX + (i * 8);
                        var TileY = TLCornerY + (i * 8);
                        DrawFloorTrim(WallLevel, TileX, TLCornerY + 24, FloorTrimTileX + 2 + ((TileX / 8) % 2), FloorTrimTileY + 2 + (WallLevel * 2));
                        DrawFloorTrim(WallLevel, TLCornerX + 24, TileY, FloorTrimTileX + 4, FloorTrimTileY + 2 + (WallLevel * 2) + ((TileY / 8) % 2));
                    }
                    
                    if ((GID == UnknownEnum.Value_23 && CreateLowerWallObjs) || (GID == UnknownEnum.Value_15 && CreateUpperWallObjs))
                        WallObj_Create("Objs_" + LevelStr, TLCornerX, TLCornerY, 3, 3, 6, GID);
                    
                    break;
                
                case UnknownEnum.Value_16:
                case UnknownEnum.Value_24:
                    DrawTileBlock(TMID_Walls, TLCornerX, TLCornerY, TilesX + 14 + (WallLevel * 17), TilesY, 3, 3);
                    DrawFloorTrim(WallLevel, TLCornerX - 8, TLCornerY + 24, FloorTrimTileX + 7, FloorTrimTileY + 2 + (WallLevel * 2));
                    
                    for (var i = 0; i < 3; i++)
                    {
                        var TileX = TLCornerX + (i * 8);
                        var TileY = TLCornerY + (i * 8);
                        DrawFloorTrim(WallLevel, TileX, TLCornerY + 24, FloorTrimTileX + 2 + ((TileX / 8) % 2), FloorTrimTileY + 2 + (WallLevel * 2));
                        DrawFloorTrim(WallLevel, TLCornerX - 8, TileY, FloorTrimTileX + 5, FloorTrimTileY + 2 + (WallLevel * 2) + ((TileY / 8) % 2));
                    }
                    
                    if ((GID == UnknownEnum.Value_24 && CreateLowerWallObjs) || (GID == UnknownEnum.Value_16 && CreateUpperWallObjs))
                        WallObj_Create("Objs_" + LevelStr, TLCornerX, TLCornerY, 3, 3, 7, GID);
                    
                    break;
                
                case UnknownEnum.Value_13:
                case UnknownEnum.Value_21:
                    DrawTileBlock(TMID_Walls, TLCornerX, TLCornerY, TilesX + 11 + (WallLevel * 17), TilesY + 3, 3, 3);
                    DrawFloorTrim(WallLevel, TLCornerX + 24, TLCornerY - 8, FloorTrimTileX + 6, FloorTrimTileY + 3 + (WallLevel * 2));
                    
                    for (var i = 0; i < 3; i++)
                    {
                        var TileX = TLCornerX + (i * 8);
                        var TileY = TLCornerY + (i * 8);
                        DrawFloorTrim(WallLevel, TileX, TLCornerY - 8, FloorTrimTileX + 2 + ((TileX / 8) % 2), FloorTrimTileY + 3 + (WallLevel * 2));
                        DrawFloorTrim(WallLevel, TLCornerX + 24, TileY, FloorTrimTileX + 4, FloorTrimTileY + 2 + (WallLevel * 2) + ((TileY / 8) % 2));
                    }
                    
                    if ((GID == UnknownEnum.Value_21 && CreateLowerWallObjs) || (GID == UnknownEnum.Value_13 && CreateUpperWallObjs))
                        WallObj_Create("Objs_" + LevelStr, TLCornerX, TLCornerY, 3, 3, 8, GID);
                    
                    break;
                
                case UnknownEnum.Value_14:
                case UnknownEnum.Value_22:
                    DrawTileBlock(TMID_Walls, TLCornerX, TLCornerY, TilesX + 14 + (WallLevel * 17), TilesY + 3, 3, 3);
                    DrawFloorTrim(WallLevel, TLCornerX - 8, TLCornerY - 8, FloorTrimTileX + 7, FloorTrimTileY + 3 + (WallLevel * 2));
                    
                    for (var i = 0; i < 3; i++)
                    {
                        var TileX = TLCornerX + (i * 8);
                        var TileY = TLCornerY + (i * 8);
                        DrawFloorTrim(WallLevel, TileX, TLCornerY - 8, FloorTrimTileX + 2 + ((TileX / 8) % 2), FloorTrimTileY + 3 + (WallLevel * 2));
                        DrawFloorTrim(WallLevel, TLCornerX - 8, TileY, FloorTrimTileX + 5, FloorTrimTileY + 2 + (WallLevel * 2) + ((TileY / 8) % 2));
                    }
                    
                    if ((GID == UnknownEnum.Value_22 && CreateLowerWallObjs) || (GID == UnknownEnum.Value_14 && CreateUpperWallObjs))
                        WallObj_Create("Objs_" + LevelStr, TLCornerX, TLCornerY, 3, 3, 9, GID);
                    
                    break;
            }
        }
        
        for (var WallIndex = 0; WallIndex < Walls; WallIndex++)
        {
            var TLCornerX = global.Level.Rooms[arg0].x + WallArray[WallIndex].x;
            var TLCornerY = global.Level.Rooms[arg0].y + WallArray[WallIndex].y;
            var GID = WallArray[WallIndex].gid;
            
            switch (GID)
            {
                case UnknownEnum.Value_19:
                case UnknownEnum.Value_11:
                    DrawFloorTrim(WallLevel, TLCornerX + 24, TLCornerY + 24, FloorTrimTileX, FloorTrimTileY + 2 + (WallLevel * 2));
                    break;
                
                case UnknownEnum.Value_20:
                case UnknownEnum.Value_12:
                    DrawFloorTrim(WallLevel, TLCornerX - 8, TLCornerY + 24, FloorTrimTileX + 1, FloorTrimTileY + 2 + (WallLevel * 2));
                    break;
                
                case UnknownEnum.Value_17:
                case UnknownEnum.Value_9:
                    DrawFloorTrim(WallLevel, TLCornerX + 24, TLCornerY - 8, FloorTrimTileX, FloorTrimTileY + 3 + (WallLevel * 2));
                    break;
                
                case UnknownEnum.Value_18:
                case UnknownEnum.Value_10:
                    DrawFloorTrim(WallLevel, TLCornerX - 8, TLCornerY - 8, FloorTrimTileX + 1, FloorTrimTileY + 3 + (WallLevel * 2));
                    break;
            }
        }
    }
    
    if (variable_struct_exists(global.Level.Rooms[arg0].Template, "WallsCommon"))
    {
        var WallsCommonArray = global.Level.Rooms[arg0].Template.WallsCommon;
        
        for (var WallsCommonIndex = 0; WallsCommonIndex < array_length(global.Level.Rooms[arg0].Template.WallsCommon); WallsCommonIndex++)
        {
            var Wall = WallsCommonArray[WallsCommonIndex];
            var WallX = global.Level.Rooms[arg0].x + Wall.x;
            var WallY = global.Level.Rooms[arg0].y + Wall.y;
            var WallTileW = Wall.width / 8;
            var WallTileH = Wall.height / 8;
            var Properties = Wall.properties;
            var FloorLevelProperty = GetPropertyValue(Properties, "FloorLevel");
            var FloorLevel = (FloorLevelProperty != -1) ? FloorLevelProperty : GetFloorLevelID(WallX, WallY);
            var FloorLevelStr = GetFloorLevelString(FloorLevel);
            var TMID = (FloorLevel == 1) ? global.TMID_Walls_Upper : global.TMID_Walls_Lower;
            var ObjLayer = "Objs_" + FloorLevelStr;
            
            if (!struct_exists(Wall, "gid"))
            {
                var WallInst = WallObj_Create(ObjLayer, WallX, WallY, WallTileW, WallTileH);
            }
            else
            {
                switch (Wall.gid)
                {
                    case UnknownEnum.Value_33:
                        var _TilesY = (global.Level.Rooms[arg0].ForcedTheme == -1) ? (4 + ((global.Level.Index - 1) * 6)) : (4 + (global.Level.Rooms[arg0].ForcedTheme * 6));
                        var RailEndID = GetTileID(113, _TilesY);
                        var RailVID = GetTileID(113, _TilesY + 1);
                        var RailHID = GetTileID(113, _TilesY + 2);
                        var NoEnd_T = GetPropertyValue(Properties, "NoEnd_T") != -1;
                        var NoEnd_B = GetPropertyValue(Properties, "NoEnd_B") != -1;
                        var NoEnd_L = GetPropertyValue(Properties, "NoEnd_L") != -1;
                        var NoEnd_R = GetPropertyValue(Properties, "NoEnd_R") != -1;
                        tilemap_set_at_pixel(TMID, RailEndID, WallX, WallY);
                        tilemap_set_at_pixel(TMID, RailEndID, (WallX + (WallTileW * 8)) - 8, (WallY + (WallTileH * 8)) - 8);
                        
                        if (WallTileW > 1)
                        {
                            var j = NoEnd_L ? 0 : 1;
                            
                            while (j < (WallTileW - (NoEnd_R ? 0 : 1)))
                            {
                                tilemap_set_at_pixel(TMID, RailHID, WallX + (j * 8), WallY);
                                j++;
                            }
                        }
                        
                        if (WallTileH > 1)
                        {
                            var j = NoEnd_T ? 0 : 1;
                            
                            while (j < (WallTileH - (NoEnd_B ? 0 : 1)))
                            {
                                tilemap_set_at_pixel(TMID, RailVID, WallX, WallY + (j * 8));
                                j++;
                            }
                        }
                        
                        var WallInst = WallObj_Create(ObjLayer, WallX, WallY, WallTileW, WallTileH);
                        WallInst.BlockProjectiles = false;
                        WallInst.BlockItems = false;
                        break;
                    
                    case UnknownEnum.Value_43:
                    case UnknownEnum.Value_44:
                        var SpikeBlocks = ObstacleClassCheck(arg0, UnknownEnum.Value_4) || global.Level.Index == UnknownEnum.Value_13;
                        
                        if (Wall.gid == UnknownEnum.Value_44 && !SpikeBlocks)
                            break;
                        
                        var IsSwitch = GetPropertyValue(Properties, "Switch") != -1;
                        
                        for (var _BlockY = 0; _BlockY < floor(WallTileH / 2); _BlockY++)
                        {
                            for (var _BlockX = 0; _BlockX < floor(WallTileW / 2); _BlockX++)
                            {
                                var _BlockPosX = WallX + (_BlockX * 16);
                                var _BlockPosY = WallY + (_BlockY * 16);
                                
                                if (SpikeBlocks)
                                {
                                    var _BlockInst = instance_create_layer(_BlockPosX, _BlockPosY, ObjLayer, oSpikeBlock);
                                    _BlockInst.BlockProjectiles = false;
                                    _BlockInst.BlockItems = false;
                                }
                                else
                                {
                                    DrawTileBlock(TMID, _BlockPosX, _BlockPosY, 1, 0, 2, 2);
                                    
                                    if (IsSwitch)
                                    {
                                        global.Level.Rooms[arg0].Switch.Inst = instance_create_layer(_BlockPosX, _BlockPosY, ObjLayer, oPushBlock);
                                        global.Level.Rooms[arg0].Switch.Inst.Moved = true;
                                        global.Level.Rooms[arg0].Switch.Inst.TMID = TMID;
                                    }
                                }
                            }
                        }
                        
                        if (!IsSwitch && !SpikeBlocks)
                        {
                            var WallInst = WallObj_Create(ObjLayer, WallX, WallY, WallTileW, WallTileH);
                            WallInst.BlockProjectiles = false;
                            WallInst.BlockItems = false;
                            
                            if (!SpikeBlocks)
                                global.SpawnedBlocks = true;
                        }
                        
                        break;
                }
            }
        }
    }
    
    if (struct_get_from_hash(array_get(global.Level.Rooms, arg0), variable_get_hash("Section_WallType")) != UnknownEnum.Value_0)
        exit;
    
    var SectionID = struct_get_from_hash(array_get(global.Level.Rooms, arg0), variable_get_hash("Section_ID"));
    
    if (SectionID == 0)
        exit;
    
    var SectionWallsArray = struct_get_from_hash(array_get(struct_get_from_hash(global.Level.Rooms[arg0].Template, variable_get_hash("Sections")), SectionID), variable_get_hash("SectionWalls"));
    var SectionWalls = array_length(SectionWallsArray);
    
    if (SectionWalls == 0)
        exit;
    
    var SectionWallGID = SectionWallsArray[0].gid;
    var Passes = (SectionWallGID == UnknownEnum.Value_33) ? 1 : 2;
    
    for (var PassIndex = 0; PassIndex < Passes; PassIndex++)
    {
        for (var SectionWallIndex = 0; SectionWallIndex < SectionWalls; SectionWallIndex++)
        {
            var _Section = SectionWallsArray[SectionWallIndex];
            var TLCornerX = global.Level.Rooms[arg0].x + _Section.x;
            var TLCornerY = global.Level.Rooms[arg0].y + _Section.y;
            var RailW = _Section.width;
            var RailH = _Section.height;
            var RailTileW = RailW / 8;
            var RailTileH = RailH / 8;
            
            switch (SectionWallGID)
            {
                case UnknownEnum.Value_33:
                    var RailEndTileID = GetTileID(113, 4 + ((global.Level.Index - 1) * 6));
                    var RailTileVID = GetTileID(113, 4 + ((global.Level.Index - 1) * 6) + 1);
                    var RailTileHID = GetTileID(113, 4 + ((global.Level.Index - 1) * 6) + 2);
                    
                    if (RailTileW > 1)
                    {
                        tilemap_set_at_pixel(global.TMID_Walls_Upper, RailEndTileID, TLCornerX, TLCornerY);
                        
                        for (var j = 1; j < (RailTileW - 1); j++)
                            tilemap_set_at_pixel(global.TMID_Walls_Upper, RailTileHID, TLCornerX + (j * 8), TLCornerY);
                        
                        tilemap_set_at_pixel(global.TMID_Walls_Upper, RailEndTileID, TLCornerX + ((RailTileW - 1) * 8), TLCornerY);
                    }
                    
                    if (RailTileH > 1)
                    {
                        tilemap_set_at_pixel(global.TMID_Walls_Upper, RailEndTileID, TLCornerX, TLCornerY);
                        
                        for (var j = 1; j < (RailTileH - 1); j++)
                            tilemap_set_at_pixel(global.TMID_Walls_Upper, RailTileVID, TLCornerX, TLCornerY + (j * 8));
                        
                        tilemap_set_at_pixel(global.TMID_Walls_Upper, RailEndTileID, TLCornerX, TLCornerY + ((RailTileH - 1) * 8));
                    }
                    
                    break;
                
                case UnknownEnum.Value_82:
                    var ShiftString = GetPropertyValue(struct_get_from_hash(_Section, variable_get_hash("properties")), "SB");
                    
                    if (RailTileW > 3)
                    {
                        switch (PassIndex)
                        {
                            case 0:
                                DrawTileBlock(global.TMID_Walls_Upper, TLCornerX, TLCornerY, 114, 4 + ((global.Level.Index - 1) * 6) + 3, 2, 3);
                                DrawTileBlock(global.TMID_Walls_Upper, (TLCornerX + RailW) - 16, TLCornerY, 114, 4 + ((global.Level.Index - 1) * 6) + 3, 2, 3);
                                break;
                            
                            case 1:
                                var MidSections = RailTileW - 4;
                                
                                for (var MidSectionIndex = 0; MidSectionIndex < MidSections; MidSectionIndex++)
                                    DrawTileBlock(global.TMID_Walls_Upper, TLCornerX + 16 + (MidSectionIndex * 8), TLCornerY, 113, 4 + ((global.Level.Index - 1) * 6) + 3, 1, 3);
                                
                                break;
                        }
                    }
                    else
                    {
                        RailTileW = 2;
                        
                        if (ShiftString == "R")
                            TLCornerX += 8;
                        
                        switch (PassIndex)
                        {
                            case 0:
                                DrawTileBlock(global.TMID_Walls_Upper, TLCornerX, TLCornerY, 114, 4 + ((global.Level.Index - 1) * 6) + 3, 2, 2);
                                DrawTileBlock(global.TMID_Walls_Upper, TLCornerX, (TLCornerY + RailH) - 24, 114, 4 + ((global.Level.Index - 1) * 6) + 3, 2, 3);
                                break;
                            
                            case 1:
                                var MidSections = RailTileH - 5;
                                
                                for (var MidSectionIndex = 0; MidSectionIndex < MidSections; MidSectionIndex++)
                                    DrawTileBlock(global.TMID_Walls_Upper, TLCornerX, TLCornerY + 16 + (MidSectionIndex * 8), 114, 4 + ((global.Level.Index - 1) * 6) + 2, 2, 1);
                                
                                break;
                        }
                    }
                    
                    break;
            }
            
            if (PassIndex == 0)
            {
                var WallInst = WallObj_Create("Objs_Upper", TLCornerX, TLCornerY, RailTileW, RailTileH);
                
                if (SectionWallGID == UnknownEnum.Value_33)
                {
                    WallInst.BlockProjectiles = false;
                    WallInst.BlockItems = false;
                }
            }
        }
    }
}

enum UnknownEnum
{
    Value_0,
    Value_4 = 4,
    Value_6 = 6,
    Value_7,
    Value_9 = 9,
    Value_10,
    Value_11,
    Value_12,
    Value_13,
    Value_14,
    Value_15,
    Value_16,
    Value_17,
    Value_18,
    Value_19,
    Value_20,
    Value_21,
    Value_22,
    Value_23,
    Value_24,
    Value_25,
    Value_26,
    Value_27,
    Value_28,
    Value_29,
    Value_30,
    Value_31,
    Value_32,
    Value_33,
    Value_43 = 43,
    Value_44,
    Value_82 = 82
}
