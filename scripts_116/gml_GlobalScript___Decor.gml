global.DecorTileW[UnknownEnum.Value_0] = 4;
global.DecorTileW[UnknownEnum.Value_1] = 8;
global.DecorTileW[UnknownEnum.Value_2] = 2;
global.DecorTileW[UnknownEnum.Value_3] = 4;
global.DecorTileW[UnknownEnum.Value_4] = 4;
global.RoomLightsOn = 0;
global.RoomLightsOn_Max = 0;
global.ReplacedMuralWithLight = false;

function Decor_Draw(arg0, arg1, arg2, arg3, arg4 = 0)
{
    var PosX, PosY;
    
    switch (arg2.gid)
    {
        case UnknownEnum.Value_32:
        case UnknownEnum.Value_29:
            PosX = arg2.x + (arg3 * 8);
            PosY = arg2.y;
            break;
        
        case UnknownEnum.Value_30:
        case UnknownEnum.Value_31:
            PosX = arg2.x;
            PosY = arg2.y + (arg3 * 8);
            break;
    }
    
    switch (arg1)
    {
        case UnknownEnum.Value_2:
            var Mirror = FlipCoin_Bool();
            
            switch (arg2.gid)
            {
                case UnknownEnum.Value_32:
                    DrawTileBlock(global.TMID_Decor_Upper, PosX, PosY, 152, 4 + ((global.Level.Index - 1) * 6), 2, 3, Mirror);
                    DrawTileBlock(global.TMID_Water_Upper, PosX, PosY + 24, 152, 4 + ((global.Level.Index - 1) * 6) + 3, 2, 1, Mirror);
                    break;
                
                case UnknownEnum.Value_29:
                    DrawTileBlock(global.TMID_Water_Upper, PosX, PosY - 8, 154, 4 + ((global.Level.Index - 1) * 6), 2, 1, Mirror);
                    DrawTileBlock(global.TMID_Decor_Upper, PosX, PosY, 154, 4 + ((global.Level.Index - 1) * 6) + 1, 2, 3, Mirror);
                    break;
                
                case UnknownEnum.Value_30:
                    DrawTileBlock(global.TMID_Decor_Upper, PosX, PosY, 152, 4 + ((global.Level.Index - 1) * 6) + 4, 3, 2);
                    DrawTileBlock(global.TMID_Water_Upper, PosX + 24, PosY, 155, 4 + ((global.Level.Index - 1) * 6) + 4, 1, 2);
                    break;
                
                case UnknownEnum.Value_31:
                    DrawTileBlock(global.TMID_Water_Upper, PosX - 8, PosY, 148, 4 + ((global.Level.Index - 1) * 6) + 4, 1, 2);
                    DrawTileBlock(global.TMID_Decor_Upper, PosX, PosY, 149, 4 + ((global.Level.Index - 1) * 6) + 4, 3, 2);
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_0:
            switch (arg2.gid)
            {
                case UnknownEnum.Value_32:
                    DrawTileBlock(global.TMID_Decor_Upper, PosX, PosY, 132 + (arg4 * 10), 4 + ((global.Level.Index - 1) * 6), 4, 3);
                    break;
                
                case UnknownEnum.Value_29:
                    DrawTileBlock(global.TMID_Decor_Upper, PosX, PosY, 132 + (arg4 * 10), 4 + ((global.Level.Index - 1) * 6) + 3, 4, 3);
                    break;
                
                case UnknownEnum.Value_30:
                    DrawTileBlock(global.TMID_Decor_Upper, PosX, PosY, 136 + (arg4 * 10), 4 + ((global.Level.Index - 1) * 6), 3, 4);
                    break;
                
                case UnknownEnum.Value_31:
                    DrawTileBlock(global.TMID_Decor_Upper, PosX, PosY, 139 + (arg4 * 10), 4 + ((global.Level.Index - 1) * 6), 3, 4);
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_1:
            DrawTileBlock(global.TMID_Decor_Upper, PosX, PosY, 118 + (arg4 * 8), 84, 8, 3);
            break;
        
        case UnknownEnum.Value_4:
            var CreateLight = true;
            var LightStatus = true;
            var LightsInProximity = false;
            var LightsInProximityList = ds_list_create();
            var Lights = collision_circle_list(PosX + 16, PosY + 12, 50, oWallLight, true, true, LightsInProximityList, false);
            
            for (var i = 0; i < Lights; i++)
            {
                var Light = ds_list_find_value(LightsInProximityList, i);
                
                if (point_in_rectangle(PosX, PosY, global.Level.Rooms[arg0].x, global.Level.Rooms[arg0].y, (global.Level.Rooms[arg0].x + global.Level.Rooms[arg0].width) - 1, (global.Level.Rooms[arg0].y + global.Level.Rooms[arg0].height) - 1))
                {
                    LightsInProximity = true;
                    break;
                }
            }
            
            ds_list_clear(LightsInProximityList);
            Lights = collision_circle_list(PosX + 16, PosY + 12, 50, oTorch, true, true, LightsInProximityList, false);
            
            for (var i = 0; i < Lights; i++)
            {
                var Light = ds_list_find_value(LightsInProximityList, i);
                
                if (point_in_rectangle(PosX, PosY, global.Level.Rooms[arg0].x, global.Level.Rooms[arg0].y, (global.Level.Rooms[arg0].x + global.Level.Rooms[arg0].width) - 1, (global.Level.Rooms[arg0].y + global.Level.Rooms[arg0].height) - 1))
                {
                    LightsInProximity = true;
                    break;
                }
            }
            
            ds_list_destroy(LightsInProximityList);
            
            if (LightsInProximity)
            {
                CreateLight = false;
            }
            else if (global.Level.Rooms[arg0].Lighting)
            {
                LightStatus = (Prob(0.75) || arg4 == 1) && global.RoomLightsOn < global.RoomLightsOn_Max && !global.Challenges[UnknownEnum.Value_4];
                
                if (LightStatus)
                    global.RoomLightsOn++;
            }
            
            if (CreateLight)
            {
                switch (arg2.gid)
                {
                    case UnknownEnum.Value_32:
                        var LightInst = instance_create_layer(PosX, PosY + 8, "Objs_Upper", oWallLight, 
                        {
                            RoomIndex: arg0,
                            Location: 1,
                            Status: LightStatus
                        });
                        break;
                    
                    case UnknownEnum.Value_29:
                        var LightInst = instance_create_layer(PosX, PosY, "Objs_Upper", oWallLight, 
                        {
                            RoomIndex: arg0,
                            Location: 2,
                            Status: LightStatus
                        });
                        break;
                    
                    case UnknownEnum.Value_31:
                        var LightInst = instance_create_layer(PosX, PosY, "Objs_Upper", oWallLight, 
                        {
                            RoomIndex: arg0,
                            Location: 4,
                            Status: LightStatus
                        });
                        break;
                    
                    case UnknownEnum.Value_30:
                        var LightInst = instance_create_layer(PosX + 8, PosY, "Objs_Upper", oWallLight, 
                        {
                            RoomIndex: arg0,
                            Location: 3,
                            Status: LightStatus
                        });
                        break;
                }
            }
            
            break;
    }
}

function Decor_Draw_FillWall(arg0, arg1, arg2, arg3, arg4 = 0)
{
    var WallTileLen = Decor_WallTileLen(arg1);
    var TileW = global.DecorTileW[arg2];
    
    if (arg3 == 0)
        exit;
    
    var DecorSpaceW = arg3 * TileW;
    var Spaces = arg3 + 1;
    var SpaceW = floor((WallTileLen - DecorSpaceW) / Spaces) + 2;
    var TotalSpace = DecorSpaceW + ((Spaces - 2) * SpaceW);
    var Segment = floor((WallTileLen - TotalSpace) / 2);
    
    for (var i = 0; i < arg3; i++)
    {
        if (Decor_Wall_GetSegmentStatus(arg1, arg2, Segment, TileW))
        {
            Decor_Draw(arg0, arg2, arg1, Segment, arg4);
            Decor_Wall_SetSegmentStatus(arg1, Segment, TileW, UnknownEnum.Value_0);
        }
        
        Segment += (TileW + SpaceW);
    }
}

function Decor_FillWallFromSegment(arg0, arg1, arg2, arg3, arg4, arg5, arg6 = 0)
{
    var TileW = global.DecorTileW[arg2];
    
    while (Decor_Wall_GetSegmentStatus(arg1, arg2, arg3, TileW))
    {
        if (arg2 == UnknownEnum.Value_0 && !global.ReplacedMuralWithLight && Prob(0.4))
        {
            Decor_Draw(arg0, UnknownEnum.Value_4, arg1, arg3, arg6);
            global.ReplacedMuralWithLight = true;
        }
        else
        {
            Decor_Draw(arg0, arg2, arg1, arg3, arg6);
        }
        
        Decor_Wall_SetSegmentStatus(arg1, arg3, TileW, UnknownEnum.Value_0);
        arg3 += ((TileW + arg4) * arg5);
    }
}

function Decor_WallTileLen(arg0)
{
    switch (arg0.gid)
    {
        case UnknownEnum.Value_32:
        case UnknownEnum.Value_29:
            return arg0.TileW;
            break;
        
        case UnknownEnum.Value_30:
        case UnknownEnum.Value_31:
            return arg0.TileH;
            break;
    }
}

function Decor_Wall_GetSegmentStatus(arg0, arg1, arg2, arg3)
{
    var WallTileLen = Decor_WallTileLen(arg0);
    
    for (var i = 0; i < arg3; i++)
    {
        var SegmentIndex = arg2 + i;
        
        if (SegmentIndex >= WallTileLen || SegmentIndex < 0)
            return false;
        
        if (arg0.WallSegments[SegmentIndex] == UnknownEnum.Value_0)
            return false;
        
        if (arg1 == UnknownEnum.Value_2 && arg0.WallSegments[SegmentIndex] == UnknownEnum.Value_2)
            return false;
        
        if (arg1 != UnknownEnum.Value_0 && arg1 != UnknownEnum.Value_1 && arg0.WallSegments[SegmentIndex] == UnknownEnum.Value_3)
            return false;
    }
    
    return true;
}

function Decor_Wall_SetSegmentStatus(arg0, arg1, arg2, arg3)
{
    var WallTileLen = Decor_WallTileLen(arg0);
    
    if ((arg1 + arg2) > WallTileLen)
        arg2 = WallTileLen - arg1;
    
    for (var i = 0; i < arg2; i++)
        arg0.WallSegments[arg1 + i] = arg3;
}

function LevelCurtainType(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_3:
        case UnknownEnum.Value_12:
            return UnknownEnum.Value_0;
        
        case UnknownEnum.Value_5:
        case UnknownEnum.Value_8:
            return UnknownEnum.Value_1;
    }
    
    return -1;
}

function Decor_Monuments_AllowedStyle(arg0, arg1, arg2 = false)
{
    var _StyleList = ds_list_create_sequence(0, 3);
    var _BottomSpaceCheck = collision_rectangle(arg0, arg1 + 32, arg0 + 31, arg1 + 71, oWall, false, true);
    
    if (_BottomSpaceCheck || arg2)
    {
        switch (global.Level.Index)
        {
            case UnknownEnum.Value_1:
                ds_list_finddelete(_StyleList, 0);
                ds_list_finddelete(_StyleList, 1);
                break;
            
            case UnknownEnum.Value_4:
                ds_list_finddelete(_StyleList, 0);
                ds_list_finddelete(_StyleList, 1);
                ds_list_finddelete(_StyleList, 2);
                break;
            
            case UnknownEnum.Value_7:
                ds_list_finddelete(_StyleList, 0);
                ds_list_finddelete(_StyleList, 1);
                break;
            
            case UnknownEnum.Value_8:
                ds_list_finddelete(_StyleList, 0);
                ds_list_finddelete(_StyleList, 1);
                ds_list_finddelete(_StyleList, 2);
                break;
            
            case UnknownEnum.Value_9:
                ds_list_finddelete(_StyleList, 0);
                ds_list_finddelete(_StyleList, 1);
                ds_list_finddelete(_StyleList, 2);
                break;
            
            case UnknownEnum.Value_11:
                ds_list_finddelete(_StyleList, 0);
                ds_list_finddelete(_StyleList, 1);
                break;
            
            case UnknownEnum.Value_12:
                ds_list_finddelete(_StyleList, 0);
                ds_list_finddelete(_StyleList, 1);
                ds_list_finddelete(_StyleList, 2);
                break;
        }
    }
    
    if (global.Level.Index == UnknownEnum.Value_4 && !global.Level.CatacombGrave)
    {
        if (ds_list_find_index(_StyleList, 2) != -1)
        {
            ds_list_destroy(_StyleList);
            return 2;
        }
    }
    
    if (global.Level.Index == UnknownEnum.Value_12 && !global.Gore)
    {
        ds_list_finddelete(_StyleList, 3);
        
        if (ds_list_size(_StyleList) == 0)
            ds_list_add(_StyleList, 1, 2);
    }
    
    ds_list_shuffle(_StyleList);
    var _Style = ds_list_find_value(_StyleList, 0);
    ds_list_destroy(_StyleList);
    return _Style;
}

function Cracks_MaxAmount()
{
    var _Amount = 0;
    var _P = 0;
    
    switch (global.Level.Index)
    {
        case UnknownEnum.Value_2:
            _Amount = 1;
            _P = 0.05;
            break;
        
        case UnknownEnum.Value_3:
            _Amount = choose(1, 1, 1, 1, 2, 2, 3);
            _P = 0.1;
            break;
        
        case UnknownEnum.Value_5:
        case UnknownEnum.Value_7:
        case UnknownEnum.Value_9:
        case UnknownEnum.Value_12:
            _Amount = irandom_range(1, 5);
            _P = 0.15;
            break;
        
        case UnknownEnum.Value_4:
            _Amount = irandom_range(1, 12);
            _P = 0.35;
            break;
        
        case UnknownEnum.Value_8:
        case UnknownEnum.Value_11:
            _Amount = irandom_range(1, 20);
            _P = 0.6;
            break;
    }
    
    return Prob(_P) ? _Amount : 0;
}

function Decor_MonumentItems(arg0, arg1, arg2, arg3, arg4)
{
    var _PosX = arg1;
    var _PosY = arg2 + 8;
    var _TileX = 116 + (arg3 * 4);
    var _TileW = 4;
    var _ItemStyle = 0;
    
    switch (global.Level.Index)
    {
        default:
            exit;
        
        case UnknownEnum.Value_1:
            if (Prob(0.85))
                exit;
            
            _PosY = arg2;
            break;
        
        case UnknownEnum.Value_2:
            if (Prob(0.75))
                exit;
            
            break;
        
        case UnknownEnum.Value_3:
            if (Prob(0.6) && arg3 != 2)
                exit;
            
            if (!global.Gore)
            {
                if (Prob(0.6))
                    exit;
            }
            
            var _ItemList = ds_list_create_sequence(0, 3);
            
            if (global.Level.JailMonumentItem_DeadFemale || !global.Gore)
                ds_list_finddelete(_ItemList, 1);
            
            if (global.Level.JailMonumentItem_DeadMale || !global.Gore)
                ds_list_finddelete(_ItemList, 2);
            
            if (!global.Gore)
                ds_list_finddelete(_ItemList, 3);
            
            if (arg3 == 3)
                ds_list_finddelete(_ItemList, 0);
            
            if (ds_list_size(_ItemList) == 0)
                exit;
            
            ds_list_shuffle(_ItemList);
            _ItemStyle = ds_list_find_value(_ItemList, 0);
            ds_list_destroy(_ItemList);
            
            switch (_ItemStyle)
            {
                case 0:
                    _TileX = 116;
                    break;
                
                case 1:
                    _TileX = 120;
                    global.Level.JailMonumentItem_DeadFemale = true;
                    break;
                
                case 2:
                    _TileX = 124;
                    global.Level.JailMonumentItem_DeadMale = true;
                    break;
                
                case 3:
                    _TileX = 128;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_4:
            switch (arg3)
            {
                case 0:
                    exit;
                    break;
                
                case 1:
                    _ItemStyle = irandom(3);
                    _PosX = arg1 + 8;
                    _TileX = 116 + (_ItemStyle * 2);
                    _TileW = 2;
                    break;
                
                case 2:
                    if (global.Level.CatacombGrave)
                    {
                        _ItemStyle = 0;
                    }
                    else
                    {
                        _ItemStyle = 1;
                        var _HeadingIndex = DialogueCycle(global.CatacombGraveHeadings, global.Users[global.UserIndex].UsedCatacombGraveHeadings);
                        SignCreate(arg1 + 16, arg2 + 32, global.CatacombGraveHeadings[_HeadingIndex], true);
                        global.Level.CatacombGrave = true;
                    }
                    
                    _PosX = arg1 + 8;
                    _TileX = 124 + (_ItemStyle * 2);
                    _TileW = 2;
                    break;
                
                case 3:
                    if (Prob(0.75))
                        exit;
                    
                    _ItemStyle = irandom(1);
                    _PosX = arg1 + 8;
                    _PosY = arg2;
                    _TileX = 128 + (_ItemStyle * 2);
                    _TileW = 2;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_10:
            switch (arg3)
            {
                case 0:
                    if (Prob(0.5))
                        exit;
                    
                    break;
                
                case 1:
                    _ItemStyle = irandom(2);
                    _TileX = 120 + (_ItemStyle * 4);
                    break;
                
                case 2:
                case 3:
                    exit;
                    break;
            }
            
            break;
    }
    
    DrawTileBlock(arg0, _PosX, _PosY, _TileX, 4 + ((global.Level.Index - 1) * 6) + 4, _TileW, 2, arg4);
    return _ItemStyle;
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
    Value_10,
    Value_11,
    Value_12,
    Value_29 = 29,
    Value_30,
    Value_31,
    Value_32
}
