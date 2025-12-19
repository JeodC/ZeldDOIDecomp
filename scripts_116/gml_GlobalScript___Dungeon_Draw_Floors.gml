function Dungeon_Draw_Floors(arg0)
{
    var MainFloorType = Prob(0.85);
    var FloorTileX_Upper = MainFloorType ? 42 : 46;
    var FloorTileX_Lower = MainFloorType ? 44 : 48;
    var FloorTileY = 4 + ((global.Level.Index - 1) * 6);
    
    if (global.Level.Rooms[arg0].ForcedTheme_Floor_Upper != -1)
    {
        FloorTileX_Upper = 42 + (global.Level.Rooms[arg0].ForcedTheme_Floor_Upper * 2);
        FloorTileY = 4 + (global.Level.Rooms[arg0].ForcedTheme_Floor * 6);
    }
    
    if (global.Level.Rooms[arg0].ForcedTheme_Floor_Lower != -1)
    {
        FloorTileX_Lower = 42 + (global.Level.Rooms[arg0].ForcedTheme_Floor_Lower * 2);
        FloorTileY = 4 + (global.Level.Rooms[arg0].ForcedTheme_Floor * 6);
    }
    
    var BossRoom = TemplateCheck(arg0, UnknownEnum.Value_9, UnknownEnum.Value_0);
    var IncreaseFloorDecor = BossRoom ? 5 : (Prob(0.1) ? choose(1.5, 2, 2.5) : 1);
    var _FloorDecor = false;
    
    switch (global.Level.Index)
    {
        case UnknownEnum.Value_0:
            _FloorDecor = true;
            break;
        
        case UnknownEnum.Value_3:
            _FloorDecor = Prob(0.4);
            break;
        
        case UnknownEnum.Value_5:
            _FloorDecor = Prob(0.3);
            break;
        
        case UnknownEnum.Value_7:
            if (BossRoom)
                FloorTileX_Upper = 42;
            
            if (FloorTileX_Upper < 46)
                global.Level.Rooms[arg0].Sand = true;
            
            break;
        
        case UnknownEnum.Value_4:
        case UnknownEnum.Value_11:
        case UnknownEnum.Value_12:
            _FloorDecor = Prob(0.6);
            break;
    }
    
    if (global.Level.Rooms[arg0].TemplateClass == UnknownEnum.Value_8 || TemplateCheck(arg0, UnknownEnum.Value_9, UnknownEnum.Value_2, "TMNT") || global.SaveLevel)
        _FloorDecor = false;
    
    if (global.Level.Index == UnknownEnum.Value_0)
    {
        FloorTileX_Lower = 94;
        FloorTileX_Upper = 94;
        FloorTileY = 86;
    }
    else
    {
        switch (global.Level.Rooms[arg0].TemplateName)
        {
            case "Arcade":
                FloorTileX_Lower = 85;
                FloorTileX_Upper = 85;
                FloorTileY = 81;
                break;
            
            case "TMNT":
                FloorTileX_Lower = 19;
                FloorTileX_Upper = 19;
                FloorTileY = 93;
                break;
            
            case "FinalBossHall":
            case "FinalBoss":
                FloorTileX_Lower = 135;
                FloorTileX_Upper = 135;
                FloorTileY = 88;
                break;
            
            default:
                break;
        }
    }
    
    for (var _y = 0; _y < (global.Level.Rooms[arg0].height / 16); _y++)
    {
        for (var _x = 0; _x < (global.Level.Rooms[arg0].width / 16); _x++)
        {
            var PosX = global.Level.Rooms[arg0].x + (_x * 16);
            var PosY = global.Level.Rooms[arg0].y + (_y * 16);
            DrawTileBlock(global.TMID_Floor_Lower, PosX, PosY, FloorTileX_Lower, FloorTileY, 2, 2);
            DrawTileBlock(global.TMID_Floor_Upper, PosX, PosY, FloorTileX_Upper, FloorTileY, 2, 2);
            
            if (_FloorDecor || BossRoom)
            {
                switch (global.Level.Index)
                {
                    case UnknownEnum.Value_0:
                        if (Prob(0.16))
                            Dungeon_Draw_FloorDecor(PosX, PosY, UnknownEnum.Value_4);
                        
                        break;
                    
                    case UnknownEnum.Value_3:
                        if (!global.Gore)
                            break;
                        
                        var _Decor = BossRoom ? choose(UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_2, UnknownEnum.Value_1) : UnknownEnum.Value_0;
                        
                        if (Prob(0.03 * IncreaseFloorDecor))
                            Dungeon_Draw_FloorDecor(PosX, PosY, _Decor);
                        
                        break;
                    
                    case UnknownEnum.Value_4:
                        if (Prob(0.05 * IncreaseFloorDecor))
                            Dungeon_Draw_FloorDecor(PosX, PosY, UnknownEnum.Value_2);
                        
                        break;
                    
                    case UnknownEnum.Value_5:
                        if (Prob(0.0085 * IncreaseFloorDecor))
                            Dungeon_Draw_FloorDecor(PosX, PosY, UnknownEnum.Value_2);
                        
                        break;
                    
                    case UnknownEnum.Value_11:
                    case UnknownEnum.Value_12:
                        if (Prob(0.05 * IncreaseFloorDecor))
                        {
                            if (global.Gore)
                                Dungeon_Draw_FloorDecor(PosX, PosY, choose(UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_2, UnknownEnum.Value_1));
                            else
                                Dungeon_Draw_FloorDecor(PosX, PosY, UnknownEnum.Value_2);
                        }
                        
                        break;
                }
            }
        }
    }
    
    if (!variable_struct_exists(global.Level.Rooms[arg0].Template, "LowerFloor"))
        exit;
    
    var _LowerFloorArray = global.Level.Rooms[arg0].Template.LowerFloor;
    var LowerSections = array_length(_LowerFloorArray);
    
    for (var LowerSectionIndex = 0; LowerSectionIndex < LowerSections; LowerSectionIndex++)
    {
        var SectionX = global.Level.Rooms[arg0].x + _LowerFloorArray[LowerSectionIndex].x;
        var SectionY = global.Level.Rooms[arg0].y + _LowerFloorArray[LowerSectionIndex].y;
        var SectionW = _LowerFloorArray[LowerSectionIndex].width;
        var SectionH = _LowerFloorArray[LowerSectionIndex].height;
        
        for (var _y = 0; _y < (SectionH / 8); _y++)
        {
            for (var _x = 0; _x < (SectionW / 8); _x++)
            {
                tilemap_set_at_pixel(global.TMID_Water_Upper, 0, SectionX + (_x * 8), SectionY + (_y * 8));
                tilemap_set_at_pixel(global.TMID_Floor_Upper, 0, SectionX + (_x * 8), SectionY + (_y * 8));
            }
        }
    }
}

function Dungeon_Draw_FloorDecor(arg0, arg1, arg2)
{
    var TileStartX, Tiles, TileStartY;
    
    switch (arg2)
    {
        case UnknownEnum.Value_0:
            TileStartX = 104;
            TileStartY = 0;
            Tiles = 3;
            break;
        
        case UnknownEnum.Value_2:
            TileStartX = 104;
            TileStartY = 2;
            Tiles = 4;
            break;
        
        case UnknownEnum.Value_1:
            TileStartX = 110;
            TileStartY = 0;
            Tiles = 3;
            break;
        
        case UnknownEnum.Value_4:
            TileStartX = 112;
            TileStartY = 2;
            Tiles = 4;
            break;
    }
    
    var TileX = TileStartX + (irandom(Tiles - 1) * 2);
    var _Mirror = FlipCoin_Bool();
    DrawTileBlock(global.TMID_Water_Lower, arg0, arg1, TileX, TileStartY, 2, 2, _Mirror);
    DrawTileBlock(global.TMID_Water_Upper, arg0, arg1, TileX, TileStartY, 2, 2, _Mirror);
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_7 = 7,
    Value_8,
    Value_9,
    Value_11 = 11,
    Value_12
}
