function Dungeon_Draw_SpecialObjs_Forced(arg0)
{
    if (global.Level.Index != UnknownEnum.Value_0 && global.Level.Index != UnknownEnum.Value_13)
    {
        if (!variable_struct_exists(global.Level.Rooms[arg0].Template, "Objs"))
            exit;
    }
    
    var SpecialRoomObjsArray = global.Level.Rooms[arg0].Template.Objs;
    var ObjCount = array_length(SpecialRoomObjsArray);
    var MonumentStyleSelected = false;
    var ColumnStyle = irandom(1);
    
    for (var SpecialRoomObjIndex = 0; SpecialRoomObjIndex < ObjCount; SpecialRoomObjIndex++)
    {
        var Obj = SpecialRoomObjsArray[SpecialRoomObjIndex];
        var ObjX = global.Level.Rooms[arg0].x + Obj.x;
        var ObjY = global.Level.Rooms[arg0].y + Obj.y;
        var ObjW = Obj.width;
        var ObjH = Obj.height;
        var ObjTileW = ObjW / 8;
        var ObjTileH = ObjH / 8;
        var ObjRot = Obj.rotation;
        var ObjX2 = (ObjX + ObjW) - 8;
        var ObjY2 = (ObjY + ObjH) - 8;
        var ObjGID = variable_struct_exists(Obj, "gid") ? Obj.gid : -1;
        var FloorTMID = GetFloorLevelTMID("Tiles_Floor", ObjX, ObjY);
        var WaterTMID = GetFloorLevelTMID("Tiles_Water", ObjX, ObjY);
        var WallTMID = GetFloorLevelTMID("Tiles_Walls", ObjX, ObjY);
        var DecorTMID = GetFloorLevelTMID("Tiles_Decor", ObjX, ObjY);
        var FloorLevel = GetFloorLevelID(ObjX, ObjY);
        var FloorLevelStr = GetFloorLevelString(FloorLevel);
        var PropertiesArray = Obj.properties;
        var ObjName = struct_get_from_hash(Obj, variable_get_hash("name"));
        var ObjType = struct_get_from_hash(Obj, variable_get_hash("type"));
        
        switch (ObjGID)
        {
            case UnknownEnum.Value_34:
                Pot_Create(arg0, ObjX, ObjY, Probs_RandomItemClass_Pot(false));
                break;
            
            case UnknownEnum.Value_41:
                var MonumentStyle;
                
                if (!MonumentStyleSelected)
                {
                    MonumentStyle = Decor_Monuments_AllowedStyle(ObjX, ObjY, true);
                    
                    switch (global.Level.Index)
                    {
                        case UnknownEnum.Value_4:
                            if (MonumentStyle == 2)
                                MonumentStyle = 3;
                            
                            break;
                    }
                    
                    MonumentStyleSelected = true;
                }
                
                if (ObjType != "")
                    MonumentStyle = real(ObjType);
                
                var _DrawMonumentItems = true;
                var TileX = 116 + (MonumentStyle * 4);
                var TileY = 4 + ((global.Level.Index - 1) * 6);
                var _Mirrored = FlipCoin_Bool();
                
                switch (global.Level.Index)
                {
                    case UnknownEnum.Value_3:
                        _DrawMonumentItems = false;
                        break;
                    
                    case UnknownEnum.Value_6:
                        if ((global.Level.DungeonTemplate.Rooms[arg0].GridX == 6 && global.Level.DungeonTemplate.Rooms[arg0].GridY == 6) || (global.Level.DungeonTemplate.Rooms[arg0].GridX == 7 && global.Level.DungeonTemplate.Rooms[arg0].GridY == 1))
                        {
                            TileX = 120;
                            _DrawMonumentItems = false;
                        }
                        
                        break;
                    
                    case UnknownEnum.Value_10:
                        if ((global.Level.DungeonTemplate.Rooms[arg0].GridX == 4 && global.Level.DungeonTemplate.Rooms[arg0].GridY == 1) || (global.Level.DungeonTemplate.Rooms[arg0].GridX == 7 && global.Level.DungeonTemplate.Rooms[arg0].GridY == 3) || (global.Level.DungeonTemplate.Rooms[arg0].GridX == 7 && global.Level.DungeonTemplate.Rooms[arg0].GridY == 4))
                        {
                            TileX = 124;
                            _DrawMonumentItems = false;
                        }
                        
                        break;
                    
                    case UnknownEnum.Value_13:
                        TileX = 134;
                        TileY = 84;
                        _Mirrored = false;
                        break;
                }
                
                if (ObjName == "Fairy")
                {
                    TileX = 28;
                    TileY = 0;
                    _DrawMonumentItems = false;
                    _Mirrored = false;
                }
                
                DrawTileBlock(WallTMID, ObjX, ObjY, TileX, TileY, 4, 4, _Mirrored);
                
                if (_DrawMonumentItems)
                    Decor_MonumentItems(DecorTMID, ObjX, ObjY, MonumentStyle, _Mirrored);
                
                var WallInst1 = WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, 4, 4);
                WallInst1.BlockProjectiles = false;
                var WallInst2 = WallObj_Create("Objs_" + FloorLevelStr, ObjX + 8, ObjY + 8, 2, 2);
                WallInst2.BlockProjectiles = true;
                break;
            
            case UnknownEnum.Value_83:
                var _RodCharger = GetPropertyValue(PropertiesArray, "RodCharger") != -1 || (!global.Level.RodCharger && Prob(0.25) && GetPropertyValue(PropertiesArray, "NoCharger") == -1);
                DrawTileBlock(GetFloorLevelTMID("Tiles_Walls", ObjX, ObjY), ObjX, ObjY, 32 + (_RodCharger ? 4 : 0), 0, 4, 4);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, 1, 4);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX + 8, ObjY + 8, 2, 3);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX + 24, ObjY, 1, 4);
                var WallInst = WallObj_Create("Objs_" + FloorLevelStr, ObjX + 8, ObjY, 2, 1);
                WallInst.BlockLink = false;
                var inst;
                
                if (_RodCharger)
                {
                    inst = instance_create_layer(ObjX + 16, ObjY + 14, "ObjsHigher_" + FloorLevelStr, oRodCharger, 
                    {
                        RoomIndex: arg0
                    });
                    SignCreate(ObjX + 16, ObjY + 32, global.RodChargerSignText, true);
                    global.Level.RodCharger = true;
                }
                else
                {
                    inst = instance_create_layer(ObjX + 16, ObjY + 14, "ObjsHigher_" + FloorLevelStr, oItem_Kinstone_Main, 
                    {
                        Index: Kinstone_PickIndex(),
                        RoomIndex: arg0
                    });
                    var Color = GetPropertyValue(PropertiesArray, "Color");
                    
                    if (Color != -1)
                    {
                        with (inst)
                        {
                            switch (Color)
                            {
                                case "G":
                                    KinstoneMain_SetIndex(UnknownEnum.Value_0);
                                    break;
                                
                                case "B":
                                    KinstoneMain_SetIndex(UnknownEnum.Value_1);
                                    break;
                                
                                case "R":
                                    KinstoneMain_SetIndex(UnknownEnum.Value_2);
                                    break;
                                
                                case "Y":
                                    KinstoneMain_SetIndex(UnknownEnum.Value_3);
                                    break;
                                
                                case "Random":
                                    KinstoneMain_SetIndex(irandom(3));
                                    break;
                            }
                        }
                    }
                    
                    SignCreate(ObjX + 16, ObjY + 32, global.KinstoneSignText, true);
                }
                
                ds_list_add(global.LargeMapItems, inst);
                break;
            
            case UnknownEnum.Value_35:
                var _Item = -99;
                var _ForcedItem = GetPropertyValue(PropertiesArray, "Item");
                
                if (_ForcedItem != -1)
                {
                    var _AssetIndex = asset_get_index(_ForcedItem);
                    
                    if (_AssetIndex != -1)
                        _Item = ItemClassFromObjIndex(_AssetIndex);
                }
                
                var inst = Treasure_Create(arg0, ObjX, ObjY, _Item, true);
                break;
            
            case UnknownEnum.Value_89:
                var Inst = instance_create_layer(ObjX, ObjY, "Objs_" + FloorLevelStr, oTreasureLarge);
                break;
            
            case UnknownEnum.Value_42:
                ClearTileBlock(global.TMID_Water_Upper, ObjX, ObjY, ObjTileW, ObjTileH);
                ClearTileBlock(global.TMID_Water_Lower, ObjX, ObjY, ObjTileW, ObjTileH);
                
                for (var _y = 0; _y < ObjTileH; _y++)
                {
                    for (var _x = 0; _x < ObjTileW; _x++)
                    {
                        var FloorX = ObjX + (_x * 8);
                        var FloorY = ObjY + (_y * 8);
                        DrawTileBlock(FloorTMID, FloorX, FloorY, 111, 4 + ((global.Level.Index - 1) * 6) + 2, 1, 1);
                    }
                }
                
                DrawTileBlock(WallTMID, ObjX, ObjY, 110, 4 + ((global.Level.Index - 1) * 6) + 1, 1, 1);
                DrawTileBlock(WallTMID, (ObjX + ObjW) - 8, ObjY, 112, 4 + ((global.Level.Index - 1) * 6) + 1, 1, 1);
                DrawTileBlock(WallTMID, ObjX, (ObjY + ObjH) - 8, 110, 4 + ((global.Level.Index - 1) * 6) + 3, 1, 1);
                DrawTileBlock(WallTMID, (ObjX + ObjW) - 8, (ObjY + ObjH) - 8, 112, 4 + ((global.Level.Index - 1) * 6) + 3, 1, 1);
                
                for (var _x = 0; _x < (ObjTileW - 2); _x++)
                {
                    var SideX = ObjX + 8 + (_x * 8);
                    DrawTileBlock(WallTMID, SideX, ObjY, 111, 4 + ((global.Level.Index - 1) * 6) + 1, 1, 1);
                }
                
                var WallInst = WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, 1);
                WallInst.BlockProjectiles = false;
                WallInst.BlockItems = false;
                var SideXR;
                
                for (var _y = 0; _y < (ObjTileH - 2); _y++)
                {
                    SideXR = (ObjX + ObjW) - 8;
                    var SideY = ObjY + 8 + (_y * 8);
                    DrawTileBlock(WallTMID, ObjX, SideY, 110, 4 + ((global.Level.Index - 1) * 6) + 2, 1, 1);
                    DrawTileBlock(WallTMID, SideXR, SideY, 112, 4 + ((global.Level.Index - 1) * 6) + 2, 1, 1);
                }
                
                WallInst = WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, 1, ObjTileH);
                WallInst.BlockProjectiles = false;
                WallInst.BlockItems = false;
                WallInst = WallObj_Create("Objs_" + FloorLevelStr, SideXR, ObjY, 1, ObjTileH);
                WallInst.BlockProjectiles = false;
                WallInst.BlockItems = false;
                var StairsW = ObjTileW - 6;
                var StairsX = ObjX + (4 * (ObjTileW - StairsW));
                var StairsY = (ObjY + ObjH) - 16;
                
                for (var _y = 0; _y < 2; _y++)
                {
                    for (var _x = 0; _x < StairsW; _x++)
                    {
                        var SX = StairsX + (_x * 8);
                        var SY = StairsY + (_y * 8);
                        DrawTileBlock(FloorTMID, SX, SY, 111, 4 + ((global.Level.Index - 1) * 6), 1, 1);
                    }
                }
                
                var inst = WallObj_Create("Objs_" + FloorLevelStr, StairsX, StairsY, StairsW, 2);
                inst.FloorLevel = GetFloorLevelID(FloorLevelStr);
                inst.BlockLink = false;
                inst.BlockLinkCarry = false;
                inst.BlockProjectiles = false;
                inst.BlockItems = false;
                DrawTileBlock(WallTMID, StairsX - 8, StairsY, 112, 4 + ((global.Level.Index - 1) * 6), 1, 1);
                DrawTileBlock(WallTMID, StairsX + (StairsW * 8), StairsY, 110, 4 + ((global.Level.Index - 1) * 6), 1, 1);
                DrawTileBlock(WallTMID, StairsX - 8, StairsY + 8, 112, 4 + ((global.Level.Index - 1) * 6) + 3, 1, 1);
                DrawTileBlock(WallTMID, StairsX + (StairsW * 8), StairsY + 8, 110, 4 + ((global.Level.Index - 1) * 6) + 3, 1, 1);
                WallInst = WallObj_Create("Objs_" + FloorLevelStr, StairsX - 8, StairsY, 1, 2);
                WallInst.BlockProjectiles = false;
                WallInst.BlockItems = false;
                WallInst = WallObj_Create("Objs_" + FloorLevelStr, StairsX + (StairsW * 8), StairsY, 1, 2);
                WallInst.BlockProjectiles = false;
                WallInst.BlockItems = false;
                var SideLen = (ObjTileW - StairsW - 4) / 2;
                
                for (var _x = 0; _x < SideLen; _x++)
                {
                    DrawTileBlock(WallTMID, ObjX + 8 + (_x * 8), StairsY + 8, 111, 4 + ((global.Level.Index - 1) * 6) + 3, 1, 1);
                    DrawTileBlock(WallTMID, StairsX + (StairsW * 8) + 8 + (_x * 8), StairsY + 8, 111, 4 + ((global.Level.Index - 1) * 6) + 3, 1, 1);
                }
                
                WallInst = WallObj_Create("Objs_" + FloorLevelStr, StairsX - 16, StairsY + 8, 2, 1);
                WallInst.BlockProjectiles = false;
                WallInst.BlockItems = false;
                WallInst = WallObj_Create("Objs_" + FloorLevelStr, StairsX + (StairsW * 8), StairsY + 8, 2, 1);
                WallInst.BlockProjectiles = false;
                WallInst.BlockItems = false;
                break;
            
            case UnknownEnum.Value_85:
                var _ShopType = GetShopType(ObjType);
                var ShopInst = instance_create_layer(ObjX, ObjY, "ObjsFloor_" + FloorLevelStr, oShop, 
                {
                    RoomIndex: arg0,
                    ShopW: ObjW,
                    ShopH: ObjH,
                    ShopType: _ShopType
                });
                var WallInst;
                
                switch (_ShopType)
                {
                    case UnknownEnum.Value_1:
                    case UnknownEnum.Value_2:
                    case UnknownEnum.Value_3:
                    case UnknownEnum.Value_4:
                    case UnknownEnum.Value_5:
                    case UnknownEnum.Value_6:
                        DrawTileBlock(WallTMID, ObjX, ObjY, 82, 80, 1, 1);
                        DrawTileBlock(WallTMID, ObjX2, ObjY, 84, 80, 1, 1);
                        DrawTileBlock(WallTMID, ObjX, ObjY2 - 8, 82, 81, 1, 2);
                        DrawTileBlock(WallTMID, ObjX2, ObjY2 - 8, 84, 81, 1, 2);
                        DrawTileBlock(WallTMID, ObjX, ObjY + 8, 81, 81, 1, 1);
                        DrawTileBlock(WallTMID, ObjX2, ObjY + 8, 80, 81, 1, 1);
                        
                        for (var i = 0; i < (ObjTileW - 2); i++)
                        {
                            DrawTileBlock(WallTMID, ObjX + 8 + (i * 8), ObjY, 83, 80, 1, 1);
                            DrawTileBlock(WallTMID, ObjX + 8 + (i * 8), ObjY + 8, 85, 80, 1, 1);
                            DrawTileBlock(WallTMID, ObjX + 8 + (i * 8), ObjY2 - 8, 83, 81, 1, 2);
                        }
                        
                        WallInst = WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ShopInst.TileW, ShopInst.TileH - 1, undefined, undefined, oShopWall);
                        break;
                    
                    case UnknownEnum.Value_0:
                        ClearTileBlock(global.TMID_Water_Upper, ObjX, ObjY, ObjTileW, ObjTileH);
                        ClearTileBlock(global.TMID_Water_Lower, ObjX, ObjY, ObjTileW, ObjTileH);
                        DrawTileBlock(FloorTMID, ObjX, ObjY, 15, 0, 1, 1);
                        DrawTileBlock(FloorTMID, ObjX2, ObjY, 17, 0, 1, 1);
                        DrawTileBlock(FloorTMID, ObjX, ObjY2, 15, 2, 1, 1);
                        DrawTileBlock(FloorTMID, ObjX2, ObjY2, 17, 2, 1, 1);
                        
                        for (var _x = 1; _x < (ObjTileW - 1); _x++)
                        {
                            var FloorX = ObjX + (_x * 8);
                            DrawTileBlock(FloorTMID, FloorX, ObjY, 16, 0, 1, 1);
                            DrawTileBlock(FloorTMID, FloorX, ObjY2, 16, 2, 1, 1);
                        }
                        
                        for (var _y = 1; _y < (ObjTileH - 1); _y++)
                        {
                            var FloorY = ObjY + (_y * 8);
                            DrawTileBlock(FloorTMID, ObjX, FloorY, 15, 1, 1, 1);
                            DrawTileBlock(FloorTMID, ObjX2, FloorY, 17, 1, 1, 1);
                        }
                        
                        for (var _y = 1; _y < (ObjTileH - 1); _y++)
                        {
                            for (var _x = 1; _x < (ObjTileW - 1); _x++)
                            {
                                var FloorX = ObjX + (_x * 8);
                                var FloorY = ObjY + (_y * 8);
                                DrawTileBlock(FloorTMID, FloorX, FloorY, 16, 1, 1, 1);
                            }
                        }
                        
                        ds_list_add(global.LargeMapItems, ShopInst);
                        WallInst = WallObj_Create("Objs_" + FloorLevelStr, ObjX + 8, ObjY + 8, ShopInst.TileW - 2, ShopInst.TileH - 2, undefined, undefined, oShopWall);
                        global.Level.ShopCount++;
                        break;
                }
                
                WallInst.ShopInst = ShopInst;
                WallInst.BlockProjectiles = false;
                break;
            
            case UnknownEnum.Value_262:
            case UnknownEnum.Value_314:
                var _inst = instance_create_layer(ObjX + 8, ObjY + 8, "ObjsFloor_" + FloorLevelStr, oGemPondWater, 
                {
                    RoomIndex: arg0,
                    W: ObjW - 16,
                    H: ObjH - 16,
                    GID: ObjGID
                });
                DrawTileBlock(WallTMID, ObjX, ObjY, 110, 4 + ((global.Level.Index - 1) * 6) + 1, 1, 1);
                DrawTileBlock(WallTMID, (ObjX + ObjW) - 8, ObjY, 112, 4 + ((global.Level.Index - 1) * 6) + 1, 1, 1);
                DrawTileBlock(WallTMID, ObjX, (ObjY + ObjH) - 8, 110, 4 + ((global.Level.Index - 1) * 6) + 3, 1, 1);
                DrawTileBlock(WallTMID, (ObjX + ObjW) - 8, (ObjY + ObjH) - 8, 112, 4 + ((global.Level.Index - 1) * 6) + 3, 1, 1);
                
                for (var _x = 0; _x < (ObjTileW - 2); _x++)
                {
                    var SideX = ObjX + 8 + (_x * 8);
                    DrawTileBlock(WallTMID, SideX, ObjY, 111, 4 + ((global.Level.Index - 1) * 6) + 1, 1, 1);
                    DrawTileBlock(WallTMID, SideX, (ObjY + ObjH) - 8, 111, 4 + ((global.Level.Index - 1) * 6) + 3, 1, 1);
                }
                
                for (var _y = 0; _y < (ObjTileH - 2); _y++)
                {
                    var SideXR = (ObjX + ObjW) - 8;
                    var SideY = ObjY + 8 + (_y * 8);
                    DrawTileBlock(WallTMID, ObjX, SideY, 110, 4 + ((global.Level.Index - 1) * 6) + 2, 1, 1);
                    DrawTileBlock(WallTMID, SideXR, SideY, 112, 4 + ((global.Level.Index - 1) * 6) + 2, 1, 1);
                }
                
                var WallInst = WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                WallInst.BlockProjectiles = false;
                WallInst.BlockItems = false;
                var _SignText = "";
                
                switch (ObjGID)
                {
                    case UnknownEnum.Value_262:
                        _SignText = "-Zora's Gem Pond-^Throw in 2 gems to receive an item. No refunds!";
                        ds_list_add(global.LargeMapItems, _inst);
                        break;
                    
                    case UnknownEnum.Value_314:
                        _SignText = "-Wishing Pond-^Throw in a wishing stone and make a wish.";
                        break;
                }
                
                SignCreate(ObjX + 24, ObjY + ObjH + 16, _SignText);
                break;
            
            case UnknownEnum.Value_86:
            case UnknownEnum.Value_87:
            case UnknownEnum.Value_88:
                var RupeeCountW = ObjTileW / 2;
                var RupeeCountH = ObjTileH / 2;
                var PatternSize = global.RupeePatternSizeID[RupeeCountW][RupeeCountH];
                var Patterns = array_length(global.RupeePatterns[PatternSize]);
                var Pattern = irandom(Patterns - 1);
                var PatternArray = global.RupeePatterns[PatternSize][Pattern];
                
                for (var RupeeY = 0; RupeeY < RupeeCountH; RupeeY++)
                {
                    for (var RupeeX = 0; RupeeX < RupeeCountW; RupeeX++)
                    {
                        var PatternSymbol = string_char_at(PatternArray[RupeeY], RupeeX + 1);
                        var RupeePosX = ObjX + (RupeeX * 16);
                        var RupeePosY = ObjY + (RupeeY * 16);
                        var SpawnRupee = false;
                        var SpawnTreasure = false;
                        
                        switch (PatternSymbol)
                        {
                            case "0":
                                SpawnRupee = true;
                                break;
                            
                            case "T":
                                if (SpawnTreasure)
                                {
                                }
                                else
                                {
                                    SpawnRupee = true;
                                }
                                
                                break;
                            
                            case "t":
                                if (SpawnTreasure)
                                {
                                }
                                
                                break;
                        }
                        
                        if (SpawnRupee)
                        {
                            var Inst = instance_create_layer(RupeePosX + 8, RupeePosY + 14, "Objs_" + FloorLevelStr, oItem_Rupee, 
                            {
                                From: UnknownEnum.Value_0
                            });
                            
                            with (Inst)
                            {
                                Setup = false;
                                Rupee_Init((ObjGID == UnknownEnum.Value_86) ? 5 : ((ObjGID == UnknownEnum.Value_87) ? 10 : 20));
                                FloorLevel = GetFloorLevelID(FloorLevelStr);
                            }
                        }
                    }
                }
                
                break;
            
            case UnknownEnum.Value_60:
                var ColumnTileX_Base = 138 + (ColumnStyle * 8);
                var ColumnTileX_Top = 136 + (ColumnStyle * 4);
                DrawTileBlock(FloorTMID, ObjX, ObjY + 16, ColumnTileX_Base, 4 + ((global.Level.Index - 1) * 6) + 4, 2, 2);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY + 16, 2, 2);
                DrawTileBlock(global.TMID_Tiles_Highest, ObjX, ObjY, ColumnTileX_Top, 4 + ((global.Level.Index - 1) * 6) + 4, 2, 2);
                break;
            
            case UnknownEnum.Value_92:
                if (Prob(0.7))
                {
                    var Inst = instance_create_layer(ObjX + 16, ObjY + 14, "Objs_" + FloorLevelStr, oFairy_Health, 
                    {
                        RoomIndex: arg0
                    });
                    ds_list_add(global.LargeMapItems, Inst);
                }
                else
                {
                    repeat (choose(2, 3))
                    {
                        var Inst = instance_create_layer(ObjX + irandom_range(-8, 40), ObjY + irandom_range(16, 64), "Objs_" + FloorLevelStr, oItem_Fairy, 
                        {
                            From: UnknownEnum.Value_0
                        });
                        Inst.Setup = false;
                        Inst.ContainX1 = ObjX - 8;
                        Inst.ContainX2 = ObjX + 40;
                        Inst.ContainY1 = ObjY + 16;
                        Inst.ContainY2 = ObjY + 64;
                        ds_list_add(global.LargeMapItems, Inst);
                    }
                }
                
                var Monument1X = ObjX - 48;
                var Monument2X = ObjX + 48;
                var MonumentY = ObjY + 48;
                DrawTileBlock(WallTMID, Monument1X, MonumentY, 28, 0, 4, 4);
                WallObj_Create("Objs_" + FloorLevelStr, Monument1X, MonumentY, 4, 4);
                DrawTileBlock(WallTMID, Monument2X, MonumentY, 28, 0, 4, 4);
                WallObj_Create("Objs_" + FloorLevelStr, Monument2X, MonumentY, 4, 4);
                break;
            
            case UnknownEnum.Value_94:
                var WallStyle = GetPropertyValue(PropertiesArray, "Walls");
                var RoofStyle = GetPropertyValue(PropertiesArray, "Roof");
                
                if (WallStyle == 1 && ObjTileW != 12)
                    WallStyle = 0;
                
                var RoofX2 = (ObjX + (ObjTileW * 8)) - 8;
                var RoofY2 = (ObjY + (ObjTileH * 8)) - 32;
                
                switch (RoofStyle)
                {
                    case 0:
                    case 1:
                    case 2:
                    case 6:
                        var XOffset = 0;
                        var YOffset = 0;
                        
                        switch (RoofStyle)
                        {
                            case 1:
                                XOffset = 7;
                                break;
                            
                            case 2:
                                YOffset = 8;
                                break;
                            
                            case 6:
                                XOffset = 18;
                                YOffset = 3;
                                break;
                        }
                        
                        var TileStartY = 76 + YOffset;
                        DrawTileBlock(global.TMID_Tiles_Higher, ObjX, ObjY, XOffset, TileStartY, 3, 1);
                        
                        for (var _x = 0; _x < (ObjTileW - 6); _x++)
                        {
                            DrawTileBlock(global.TMID_Tiles_Higher, ObjX + 24 + (_x * 8), ObjY, 3 + XOffset, TileStartY, 1, 1);
                            DrawTileBlock(global.TMID_Tiles_Higher, ObjX + 24 + (_x * 8), RoofY2 - 24, 3 + XOffset, TileStartY + 2, 1, 4);
                        }
                        
                        DrawTileBlock(global.TMID_Tiles_Higher, RoofX2 - 16, ObjY, 4 + XOffset, TileStartY, 3, 1);
                        
                        for (var _y = 0; _y < (ObjTileH - 8); _y++)
                        {
                            DrawTileBlock(global.TMID_Tiles_Higher, ObjX, ObjY + 8 + (_y * 8), XOffset, TileStartY + 1, 3, 1);
                            DrawTileBlock(global.TMID_Tiles_Higher, RoofX2 - 16, ObjY + 8 + (_y * 8), 4 + XOffset, TileStartY + 1, 3, 1);
                        }
                        
                        DrawTileBlock(global.TMID_Tiles_Higher, ObjX, RoofY2 - 24, XOffset, TileStartY + 2, 3, 4);
                        DrawTileBlock(global.TMID_Tiles_Higher, RoofX2 - 16, RoofY2 - 24, 4 + XOffset, TileStartY + 2, 3, 4);
                        
                        for (var _y = 0; _y < (ObjTileH - 8); _y++)
                        {
                            for (var _x = 0; _x < (ObjTileW - 6); _x++)
                            {
                                var PosX = ObjX + 24 + (_x * 8);
                                var PosY = ObjY + 8 + (_y * 8);
                                DrawTileBlock(global.TMID_Tiles_Higher, PosX, PosY, 3 + XOffset, TileStartY + 1, 1, 1);
                            }
                        }
                        
                        DrawTileBlock(DecorTMID, ObjX + 24, ObjY + 8, 7, TileStartY + 6, 1, 1);
                        DrawTileBlock(DecorTMID, RoofX2 - 24, ObjY + 8, 7, TileStartY + 6, 1, 1);
                        DrawTileBlock(DecorTMID, ObjX + 24, RoofY2 - 32, 7, TileStartY + 6, 1, 1);
                        DrawTileBlock(DecorTMID, RoofX2 - 24, RoofY2 - 32, 7, TileStartY + 6, 1, 1);
                        break;
                    
                    case 3:
                        DrawTileBlock(global.TMID_Tiles_Higher, ObjX, ObjY, 7, 84, 1, 1);
                        
                        for (var _x = 0; _x < (ObjTileW - 2); _x++)
                        {
                            var XPos = ObjX + 8 + (_x * 8);
                            var XTile = 8 + (_x % 2);
                            DrawTileBlock(global.TMID_Tiles_Higher, XPos, ObjY, XTile, 84, 1, 1);
                            DrawTileBlock(global.TMID_Tiles_Higher, XPos, RoofY2, XTile, 87, 1, 1);
                        }
                        
                        DrawTileBlock(global.TMID_Tiles_Higher, (ObjX + (ObjTileW * 8)) - 8, ObjY, 10, 84, 1, 1);
                        
                        for (var _y = 0; _y < (ObjTileH - 4); _y++)
                        {
                            var PosY = ObjY + 8 + (_y * 8);
                            DrawTileBlock(global.TMID_Tiles_Higher, ObjX, PosY, 7, 85, 1, 1);
                            DrawTileBlock(global.TMID_Tiles_Higher, RoofX2, PosY, 10, 85, 1, 1);
                        }
                        
                        DrawTileBlock(global.TMID_Tiles_Higher, ObjX, RoofY2, 7, 87, 1, 1);
                        DrawTileBlock(global.TMID_Tiles_Higher, RoofX2, RoofY2, 10, 87, 1, 1);
                        
                        for (var _y = 0; _y < (ObjTileH - 5); _y++)
                        {
                            for (var _x = 0; _x < (ObjTileW - 2); _x++)
                            {
                                var PosX = ObjX + 8 + (_x * 8);
                                var PosY = ObjY + 8 + (_y * 8);
                                DrawTileBlock(global.TMID_Tiles_Higher, PosX, PosY, 8 + (_x % 2), 85 + (_y % 2), 1, 1);
                            }
                        }
                        
                        break;
                    
                    case 4:
                        DrawTileBlock(global.TMID_Tiles_Higher, ObjX, ObjY, 11, 82, 1, 1);
                        
                        for (var _x = 0; _x < (ObjTileW - 2); _x++)
                        {
                            var XPos = ObjX + 8 + (_x * 8);
                            DrawTileBlock(global.TMID_Tiles_Higher, XPos, ObjY, 12, 82, 1, 1);
                            DrawTileBlock(global.TMID_Tiles_Higher, XPos, RoofY2, 12, 84, 1, 1);
                        }
                        
                        DrawTileBlock(global.TMID_Tiles_Higher, (ObjX + (ObjTileW * 8)) - 8, ObjY, 13, 82, 1, 1);
                        
                        for (var _y = 0; _y < (ObjTileH - 4); _y++)
                        {
                            var PosY = ObjY + 8 + (_y * 8);
                            DrawTileBlock(global.TMID_Tiles_Higher, ObjX, PosY, 11, 83, 1, 1);
                            DrawTileBlock(global.TMID_Tiles_Higher, RoofX2, PosY, 13, 83, 1, 1);
                        }
                        
                        DrawTileBlock(global.TMID_Tiles_Higher, ObjX, RoofY2, 11, 84, 1, 1);
                        DrawTileBlock(global.TMID_Tiles_Higher, RoofX2, RoofY2, 13, 84, 1, 1);
                        
                        for (var _y = 0; _y < (ObjTileH - 5); _y++)
                        {
                            for (var _x = 0; _x < (ObjTileW - 2); _x++)
                            {
                                var PosX = ObjX + 8 + (_x * 8);
                                var PosY = ObjY + 8 + (_y * 8);
                                DrawTileBlock(global.TMID_Tiles_Higher, PosX, PosY, 12, 83, 1, 1);
                            }
                        }
                        
                        break;
                }
                
                var WallY = (ObjY + (ObjTileH * 8)) - 24;
                var WallX2 = (ObjX + (ObjTileW * 8)) - 8;
                var DoorX = (ObjX + (floor(ObjTileW / 2) * 8)) - 16;
                var DoorY = WallY - 16;
                var DoorWarpTemplateID = GetPropertyValue(PropertiesArray, "House");
                var _TemplateClass, _TemplateSubClass;
                
                switch (global.Level.Index)
                {
                    case UnknownEnum.Value_6:
                        _TemplateClass = UnknownEnum.Value_4;
                        _TemplateSubClass = UnknownEnum.Value_1;
                        break;
                    
                    case UnknownEnum.Value_10:
                        _TemplateClass = UnknownEnum.Value_5;
                        _TemplateSubClass = UnknownEnum.Value_1;
                        break;
                }
                
                var _TemplateArray = global.Templates_Room[_TemplateClass][_TemplateSubClass];
                var DoorWarpTemplateIndex;
                
                for (var _RoomTemplateIndex = 0; _RoomTemplateIndex < global.Templates_Room_Count[_TemplateClass][_TemplateSubClass]; _RoomTemplateIndex++)
                {
                    var _Template = _TemplateArray[_RoomTemplateIndex];
                    
                    if (_Template.id == DoorWarpTemplateID)
                    {
                        DoorWarpTemplateIndex = _RoomTemplateIndex;
                        break;
                    }
                }
                
                var House_MapGridX = GetPropertyValue(struct_get_from_hash(array_get(_TemplateArray, DoorWarpTemplateIndex), variable_get_hash("properties")), "House_MapGridX");
                var House_MapGridY = GetPropertyValue(struct_get_from_hash(array_get(_TemplateArray, DoorWarpTemplateIndex), variable_get_hash("properties")), "House_MapGridY");
                var DoorRoomIndexWarp = global.Level.Map_RoomIndex[House_MapGridY][House_MapGridX];
                
                switch (WallStyle)
                {
                    case 0:
                    case 1:
                        var TileStartY = 76 + ((WallStyle == 1) ? 8 : 0);
                        DrawTileBlock(WallTMID, ObjX, WallY, 0, TileStartY + 6, 1, 2);
                        
                        for (var i = 0; i < (ObjTileW - 2); i++)
                            DrawTileBlock(WallTMID, ObjX + 8 + (i * 8), WallY, 1 + (i % 2), TileStartY + 6, 1, 2);
                        
                        DrawTileBlock(WallTMID, WallX2, WallY, 6, TileStartY + 6, 1, 2);
                        DrawTileBlock(DecorTMID, DoorX, DoorY, 14, TileStartY, 4, 5);
                        var inst = instance_create_layer(DoorX + 8, DoorY + 16, "Objs_" + FloorLevelStr, oHouseDoor);
                        inst.image_index = (WallStyle == 0) ? 0 : 1;
                        inst.House_RoomIndex = DoorRoomIndexWarp;
                        inst.House_X = House_MapGridX * 256;
                        inst.House_Y = House_MapGridY * 256;
                        DrawTileBlock(DecorTMID, DoorX - 24, DoorY + 16, 8, TileStartY + 6, 3, 2);
                        DrawTileBlock(DecorTMID, DoorX + 32, DoorY + 16, 8, TileStartY + 6, 3, 2);
                        break;
                    
                    case 2:
                        DrawTileBlock(WallTMID, ObjX, WallY, 7, 88, 4, 2);
                        DrawTileBlock(WallTMID, ObjX + 32, WallY, 10, 88, 1, 2);
                        DrawTileBlock(WallTMID, ObjX + 56, WallY, 7, 88, 1, 2);
                        DrawTileBlock(WallTMID, ObjX + 40, WallY, 11, 87, 2, 2);
                        var inst = instance_create_layer(DoorX + 8, DoorY + 16, "Objs_" + FloorLevelStr, oHouseDoor);
                        inst.image_index = 0;
                        inst.House_RoomIndex = DoorRoomIndexWarp;
                        inst.House_X = House_MapGridX * 256;
                        inst.House_Y = House_MapGridY * 256;
                        inst.PassageArea[3] = inst.y;
                        DrawTileBlock(WallTMID, WallX2 - 24, WallY, 7, 88, 4, 2);
                        break;
                    
                    case 3:
                        DrawTileBlock(WallTMID, ObjX, WallY, 11, 85, 1, 2);
                        
                        for (var i = 0; i < (ObjTileW - 2); i++)
                            DrawTileBlock(WallTMID, ObjX + 8 + (i * 8), WallY, 12, 85, 1, 2);
                        
                        DrawTileBlock(DecorTMID, DoorX, DoorY, 14, 76, 4, 5);
                        var inst = instance_create_layer(DoorX + 8, DoorY + 16, "Objs_" + FloorLevelStr, oHouseDoor);
                        inst.House_RoomIndex = DoorRoomIndexWarp;
                        inst.House_X = House_MapGridX * 256;
                        inst.House_Y = House_MapGridY * 256;
                        DrawTileBlock(WallTMID, WallX2, WallY, 13, 85, 1, 2);
                        
                        for (var i = 0; i < ((WallX2 - DoorX - 32) / 8); i++)
                            DrawTileBlock(DecorTMID, DoorX + 32 + (i * 8), WallY, 13, 87, 1, 2);
                        
                        break;
                }
                
                var Wall1TileW = ObjTileW - ((DoorX - ObjX) / 8) - 3;
                var Wall2TileW = ObjTileW - Wall1TileW - 2;
                var _DoorWallInst = WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY + 8, Wall1TileW, ObjTileH - 2);
                _DoorWallInst.BlockLinkCarry = true;
                WallObj_Create("Objs_" + FloorLevelStr, DoorX + 24, ObjY + 8, Wall2TileW, ObjTileH - 2);
                WallObj_Create("Objs_" + FloorLevelStr, DoorX + 8, ObjY + 8, 2, 2);
                break;
            
            case UnknownEnum.Value_298:
                var _Index = GetPropertyValue(PropertiesArray, "Index");
                var inst = instance_create_layer(ObjX, ObjY, "ObjsHigher_Upper", oStoreSign, 
                {
                    image_index: _Index
                });
                break;
            
            case UnknownEnum.Value_214:
                DrawTileBlock(global.TMID_Tiles_Highest, ObjX, ObjY, 18, 89, 1, 1);
                
                for (var _x = 0; _x < 8; _x++)
                {
                    var XPos = ObjX + 8 + (_x * 8);
                    DrawTileBlock(global.TMID_Tiles_Highest, XPos, ObjY, 19, 89, 1, 1);
                }
                
                DrawTileBlock(global.TMID_Tiles_Highest, ObjX2, ObjY, 20, 89, 1, 1);
                
                for (var _y = 0; _y < 3; _y++)
                {
                    var PosY = ObjY + 8 + (_y * 8);
                    DrawTileBlock(global.TMID_Tiles_Highest, ObjX, PosY, 18, 90, 1, 1);
                    DrawTileBlock(global.TMID_Tiles_Highest, ObjX2, PosY, 20, 90, 1, 1);
                }
                
                DrawTileBlock(WallTMID, ObjX + 16, ObjY2 - 32, 18, 90, 1, 1);
                DrawTileBlock(WallTMID, ObjX2 - 16, ObjY2 - 32, 20, 90, 1, 1);
                DrawTileBlock(WallTMID, ObjX, ObjY + 32, 18, 91, 1, 1);
                DrawTileBlock(WallTMID, ObjX + 16, ObjY2 - 24, 18, 91, 1, 1);
                DrawTileBlock(WallTMID, ObjX2, ObjY + 32, 20, 91, 1, 1);
                DrawTileBlock(WallTMID, ObjX2 - 16, ObjY2 - 24, 20, 91, 1, 1);
                
                for (var _x = 0; _x < 4; _x++)
                {
                    var XPos = ObjX + 24 + (_x * 8);
                    DrawTileBlock(global.TMID_Tiles_Highest, XPos, ObjY2 - 24, 19, 91, 1, 1);
                }
                
                DrawTileBlock(WallTMID, ObjX + 8, ObjY + 32, 19, 91, 1, 1);
                DrawTileBlock(WallTMID, ObjX + 16, ObjY + 32, 17, 90, 1, 1);
                DrawTileBlock(WallTMID, ObjX2 - 8, ObjY + 32, 19, 91, 1, 1);
                DrawTileBlock(WallTMID, ObjX2 - 16, ObjY + 32, 17, 89, 1, 1);
                
                for (var _y = 0; _y < 3; _y++)
                {
                    for (var _x = 0; _x < 8; _x++)
                    {
                        var PosX = ObjX + 8 + (_x * 8);
                        var PosY = ObjY + 8 + (_y * 8);
                        DrawTileBlock(global.TMID_Tiles_Highest, PosX, PosY, 19, 90, 1, 1);
                    }
                }
                
                for (var _y = 0; _y < 2; _y++)
                {
                    for (var _x = 0; _x < 4; _x++)
                    {
                        var PosX = ObjX + 24 + (_x * 8);
                        var PosY = ObjY + 32 + (_y * 8);
                        DrawTileBlock(global.TMID_Tiles_Highest, PosX, PosY, 19, 90, 1, 1);
                    }
                }
                
                DrawTileBlock(WallTMID, ObjX, ObjY2 - 32, 15, 89, 2, 3);
                DrawTileBlock(WallTMID, ObjX2 - 8, ObjY2 - 32, 15, 89, 2, 3);
                DrawTileBlock(WallTMID, ObjX + 16, ObjY2 - 16, 15, 89, 2, 3);
                DrawTileBlock(WallTMID, ObjX2 - 24, ObjY2 - 16, 15, 89, 2, 3);
                DrawTileBlock(WallTMID, ObjX + 32, ObjY2 - 16, 15, 86, 2, 1);
                DrawTileBlock(WallTMID, ObjX + 32, ObjY2 - 8, 17, 91, 1, 1);
                DrawTileBlock(WallTMID, ObjX + 40, ObjY2 - 8, 17, 91, 1, 1);
                var DoorWarpTemplateID = GetPropertyValue(PropertiesArray, "House");
                var _TemplateArray = global.Templates_Room[UnknownEnum.Value_4][UnknownEnum.Value_1];
                var DoorWarpTemplateIndex;
                
                for (var _RoomTemplateIndex = 0; _RoomTemplateIndex < global.Templates_Room_Count[UnknownEnum.Value_4][UnknownEnum.Value_1]; _RoomTemplateIndex++)
                {
                    var _Template = _TemplateArray[_RoomTemplateIndex];
                    
                    if (_Template.id == DoorWarpTemplateID)
                    {
                        DoorWarpTemplateIndex = _RoomTemplateIndex;
                        break;
                    }
                }
                
                var House_MapGridX = GetPropertyValue(struct_get_from_hash(array_get(_TemplateArray, DoorWarpTemplateIndex), variable_get_hash("properties")), "House_MapGridX");
                var House_MapGridY = GetPropertyValue(struct_get_from_hash(array_get(_TemplateArray, DoorWarpTemplateIndex), variable_get_hash("properties")), "House_MapGridY");
                var DoorRoomIndexWarp = global.Level.Map_RoomIndex[House_MapGridY][House_MapGridX];
                var inst = instance_create_layer(ObjX + 32, ObjY2 - 16, "Objs_" + FloorLevelStr, oHouseDoor);
                inst.image_index = 2;
                inst.House_RoomIndex = DoorRoomIndexWarp;
                inst.House_X = House_MapGridX * 256;
                inst.House_Y = House_MapGridY * 256;
                inst.PassageArea[3] = inst.y;
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY + 8, 4, ObjTileH - 3);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX2 - 24, ObjY + 8, 4, ObjTileH - 3);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX + 32, ObjY + 8, 2, 2);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX + 16, ObjY2 - 8, 2, 2);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX2 - 24, ObjY2 - 8, 2, 2);
                break;
            
            case UnknownEnum.Value_96:
                switch (ObjRot)
                {
                    case 0:
                        for (var i = 0; i < ObjTileW; i++)
                        {
                            var PosX = ObjX + (i * 8);
                            DrawTileBlock(DecorTMID, PosX, ObjY, 27 + (i % 2), 76, 1, 2);
                            DrawTileBlock(DecorTMID, PosX, ObjY2 - 8, 27 + (i % 2), 79, 1, 2);
                        }
                        
                        for (var _y = 0; _y < (ObjTileH - 4); _y++)
                        {
                            for (var _x = 0; _x < ObjTileW; _x++)
                            {
                                var PosX = ObjX + (_x * 8);
                                var PosY = ObjY + 16 + (_y * 8);
                                DrawTileBlock(WallTMID, PosX, PosY, 28, 78, 1, 1);
                            }
                        }
                        
                        if (GetPropertyValue(PropertiesArray, "NoEnd_L") == -1)
                        {
                            DrawTileBlock(DecorTMID, ObjX, ObjY, 26, 76, 1, 2);
                            DrawTileBlock(DecorTMID, ObjX, ObjY2 - 8, 26, 79, 1, 2);
                            
                            for (var i = 0; i < (ObjTileH - 4); i++)
                                DrawTileBlock(DecorTMID, ObjX, ObjY + 16 + (i * 8), 26, 78, 1, 1);
                        }
                        
                        if (GetPropertyValue(PropertiesArray, "NoEnd_R") == -1)
                        {
                            DrawTileBlock(DecorTMID, ObjX2, ObjY, 29, 76, 1, 2);
                            DrawTileBlock(DecorTMID, ObjX2, ObjY2 - 8, 29, 79, 1, 2);
                            
                            for (var i = 0; i < (ObjTileH - 4); i++)
                                DrawTileBlock(DecorTMID, ObjX2, ObjY + 16 + (i * 8), 29, 78, 1, 1);
                        }
                        
                        WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, 1);
                        WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY2 - 8, ObjTileW, 1);
                        break;
                    
                    case 90:
                        DrawTileBlock(DecorTMID, ObjX, ObjY, 30, 76, 2, 1);
                        
                        for (var i = 0; i < (ObjTileH - 2); i++)
                        {
                            var PosY = ObjY + 8 + (i * 8);
                            DrawTileBlock(DecorTMID, ObjX, PosY, 30, 77 + (i % 2), 2, 1);
                            DrawTileBlock(DecorTMID, ObjX2 - 8, PosY, 33, 77 + (i % 2), 2, 1);
                        }
                        
                        DrawTileBlock(DecorTMID, ObjX2 - 8, ObjY, 33, 76, 2, 1);
                        DrawTileBlock(DecorTMID, ObjX, ObjY2, 30, 79, 2, 1);
                        DrawTileBlock(DecorTMID, ObjX2 - 8, ObjY2, 33, 79, 2, 1);
                        
                        for (var _y = 0; _y < ObjTileH; _y++)
                        {
                            for (var _x = 0; _x < (ObjTileW - 4); _x++)
                            {
                                var PosX = ObjX + 16 + (_x * 8);
                                var PosY = ObjY + (_y * 8);
                                var Tile = 76 + ((_y == 0) ? 0 : ((_y == (ObjTileH - 1)) ? 3 : 1));
                                DrawTileBlock(WallTMID, PosX, PosY, 32, Tile, 1, 1);
                            }
                        }
                        
                        WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, 1, ObjTileH);
                        WallObj_Create("Objs_" + FloorLevelStr, ObjX2, ObjY, 1, ObjTileH);
                        break;
                }
                
                break;
            
            case UnknownEnum.Value_97:
                var inst = instance_create_layer(ObjX, ObjY, "ObjsHigher_Upper", oWaterfall, 
                {
                    W: ObjW,
                    H: ObjH
                });
                break;
            
            case UnknownEnum.Value_268:
                for (var i = 0; i < ObjTileH; i++)
                {
                    for (var j = 0; j < ObjTileW; j++)
                        DrawTileBlock(global.TMID_Tiles_Higher, ObjX + (j * 8), ObjY + (i * 8), 37, 81, 1, 1);
                }
                
                break;
            
            case UnknownEnum.Value_151:
                DrawTileBlock(global.TMID_Tiles_Higher, ObjX, ObjY, 19, 76, 6, 3);
                
                for (var i = 0; i < ObjTileW; i++)
                    DrawTileBlock(global.TMID_Tiles_Higher, ObjX + (i * 8), ObjY + 32, 36, 81, 1, 1);
                
                break;
            
            case UnknownEnum.Value_152:
                for (var _x = 0; _x < ObjTileW; _x++)
                {
                    var PosX = ObjX + (_x * 8);
                    DrawTileBlock(global.TMID_Tiles_Higher, PosX, ObjY, 18, 76, 1, 1);
                    
                    for (var _y = 0; _y < (ObjTileH - 2); _y++)
                    {
                        var PosY = ObjY + 8 + (_y * 8);
                        DrawTileBlock(global.TMID_Tiles_Higher, PosX, PosY, 18, 77, 1, 1);
                    }
                    
                    DrawTileBlock(WallTMID, PosX, ObjY2, 18, 78, 1, 1);
                }
                
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY2 - 1, ObjTileW, 1);
                break;
            
            case UnknownEnum.Value_182:
                var PosX = ObjX + 12;
                var PosY = ObjY + 40;
                var ArcadeType;
                
                switch (ObjType)
                {
                    case "Pitfall":
                        ArcadeType = oArcade_Pitfall;
                        break;
                    
                    case "Zerberk":
                        ArcadeType = oArcade_Zerberk;
                        break;
                    
                    case "PopMachine":
                        ArcadeType = oPopMachine;
                        PosX = ObjX;
                        PosY = ObjY;
                        break;
                    
                    case "Poker":
                        ArcadeType = oArcade_Poker;
                        break;
                    
                    case "ShredderTV":
                        ArcadeType = oArcade_ShredderTV;
                        break;
                    
                    default:
                        ArcadeType = oArcade_Fake;
                }
                
                var inst = instance_create_layer(PosX, PosY, "Objs_" + FloorLevelStr, ArcadeType, 
                {
                    RoomIndex: arg0
                });
                break;
            
            case UnknownEnum.Value_217:
                var inst = instance_create_layer(ObjX, ObjY, "Objs_Upper", oPoolTable);
                var WallInst = WallObj_Create("Objs_Upper", ObjX, ObjY, ObjTileW, ObjTileH);
                WallInst.BlockProjectiles = false;
                break;
            
            case UnknownEnum.Value_180:
                DrawTileBlock(WallTMID, ObjX, ObjY, 82, 80, 1, 1);
                DrawTileBlock(WallTMID, ObjX + 8, ObjY, 83, 80, 1, 1);
                DrawTileBlock(WallTMID, ObjX, ObjY + 8, 81, 81, 1, 1);
                DrawTileBlock(WallTMID, ObjX + 8, ObjY + 8, 80, 80, 1, 1);
                var WallInst = WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                WallInst.BlockProjectiles = false;
                break;
            
            case UnknownEnum.Value_181:
                DrawTileBlock(WallTMID, ObjX, ObjY, 83, 80, 1, 1);
                DrawTileBlock(WallTMID, ObjX + 8, ObjY, 84, 80, 1, 1);
                DrawTileBlock(WallTMID, ObjX, ObjY + 8, 81, 80, 1, 1);
                DrawTileBlock(WallTMID, ObjX + 8, ObjY + 8, 80, 81, 1, 1);
                var WallInst = WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                WallInst.BlockProjectiles = false;
                break;
            
            case UnknownEnum.Value_178:
                DrawTileBlock(WallTMID, ObjX, ObjY, 81, 81, 1, 1);
                DrawTileBlock(WallTMID, ObjX + 8, ObjY, 80, 82, 1, 1);
                DrawTileBlock(WallTMID, ObjX, ObjY + 8, 82, 81, 1, 2);
                DrawTileBlock(WallTMID, ObjX + 8, ObjY + 8, 83, 81, 1, 2);
                var WallInst = WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                WallInst.BlockProjectiles = false;
                break;
            
            case UnknownEnum.Value_179:
                DrawTileBlock(WallTMID, ObjX, ObjY, 81, 82, 1, 1);
                DrawTileBlock(WallTMID, ObjX + 8, ObjY, 80, 81, 1, 1);
                DrawTileBlock(WallTMID, ObjX, ObjY + 8, 83, 81, 1, 2);
                DrawTileBlock(WallTMID, ObjX + 8, ObjY + 8, 84, 81, 1, 2);
                var WallInst = WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                WallInst.BlockProjectiles = false;
                break;
            
            case UnknownEnum.Value_173:
                for (var i = 0; i < ObjTileW; i++)
                {
                    var PosX = ObjX + (i * 8);
                    DrawTileBlock(WallTMID, PosX, ObjY, 83, 80, 1, 1);
                    DrawTileBlock(WallTMID, PosX, ObjY + 8, 83, 81, 1, 2);
                }
                
                var WallInst = WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                WallInst.BlockProjectiles = false;
                break;
            
            case UnknownEnum.Value_177:
                for (var i = 0; i < ObjTileH; i++)
                {
                    var PosY = ObjY + (i * 8);
                    DrawTileBlock(WallTMID, ObjX + 8, PosY, 80, 81, 1, 1);
                    DrawTileBlock(WallTMID, ObjX, PosY, 81, 81, 1, 1);
                }
                
                var WallInst = WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                WallInst.BlockProjectiles = false;
                break;
            
            case UnknownEnum.Value_174:
                DrawTileBlock(WallTMID, ObjX, ObjY, 82, 80, 1, 1);
                DrawTileBlock(WallTMID, ObjX, ObjY + 8, 82, 81, 1, 2);
                var WallInst = WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                WallInst.BlockProjectiles = false;
                break;
            
            case UnknownEnum.Value_175:
                DrawTileBlock(WallTMID, ObjX, ObjY, 84, 80, 1, 1);
                DrawTileBlock(WallTMID, ObjX, ObjY + 8, 84, 81, 1, 2);
                var WallInst = WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                WallInst.BlockProjectiles = false;
                break;
            
            case UnknownEnum.Value_176:
                DrawTileBlock(WallTMID, ObjX, ObjY, 82, 80, 1, 1);
                DrawTileBlock(WallTMID, ObjX + 8, ObjY, 84, 80, 1, 1);
                break;
            
            case UnknownEnum.Value_172:
                DrawTileBlock(WallTMID, ObjX, ObjY, 82, 81, 1, 2);
                DrawTileBlock(WallTMID, ObjX + 8, ObjY, 84, 81, 1, 2);
                var WallInst = WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                WallInst.BlockProjectiles = false;
                break;
            
            case UnknownEnum.Value_192:
                DrawTileBlock(DecorTMID, ObjX, ObjY, 52, 86, 2, 2, ObjType == "Flip");
                break;
            
            case UnknownEnum.Value_186:
                var Style = real(ObjType);
                DrawTileBlock(DecorTMID, ObjX, ObjY, 74 + (Style * 2), 90, 2, 3);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY + 8, ObjTileW, ObjTileH - 1);
                break;
            
            case UnknownEnum.Value_183:
                DrawTileBlock(WallTMID, ObjX, ObjY, 81, 86, 4, 4);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_185:
                DrawTileBlock(DecorTMID, ObjX, ObjY, 80, 90, 6, 3);
                break;
            
            case UnknownEnum.Value_209:
                switch (ObjType)
                {
                    default:
                        var inst = instance_create_layer(ObjX, ObjY, "Objs_" + FloorLevelStr, asset_get_index("o" + ObjName), 
                        {
                            Name: ObjName,
                            Dialogue: SplitStrToArray(GetPropertyValue(PropertiesArray, "Dialogue"), "\n"),
                            Response: SplitStrToArray(GetPropertyValue(PropertiesArray, "Response"), "\n"),
                            AddWall: GetPropertyValue(PropertiesArray, "NoWall") == -1
                        });
                        
                        if (GetPropertyValue(PropertiesArray, "RandomizeDialogue") != -1)
                            inst.Dialogue = array_shuffle(inst.Dialogue);
                        
                        break;
                    
                    case "OldLady":
                        var inst = instance_create_layer(ObjX + 8, ObjY + 3, "Objs_" + FloorLevelStr, oNPC_OldLady);
                        break;
                    
                    case "ShopKeeper":
                        var inst = instance_create_layer(ObjX, ObjY, "Objs_" + FloorLevelStr, oShopKeeper, 
                        {
                            ShopType: GetShopType(ObjName)
                        });
                        inst.sprite_index = asset_get_index("sShopKeeper_" + ObjName);
                        inst.x += sprite_get_xoffset(inst.sprite_index);
                        inst.y += sprite_get_yoffset(inst.sprite_index);
                        break;
                }
                
                break;
            
            case UnknownEnum.Value_216:
                SignCreate(ObjX + 8, ObjY + 16, GetPropertyValue(PropertiesArray, "Text"), GetPropertyValue(PropertiesArray, "Hidden") != -1);
                break;
            
            case UnknownEnum.Value_139:
                DrawTileBlock(global.TMID_Tiles_Higher, ObjX, ObjY, 36, 87, 4, 3);
                DrawTileBlock(WallTMID, ObjX, ObjY + 24, 36, 90, 4, 3);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY + 16, 4, 4);
                break;
            
            case UnknownEnum.Value_208:
                DrawTileBlock(global.TMID_Tiles_Higher, ObjX, ObjY, 30, 86, 4, 3);
                DrawTileBlock(global.TMID_Tiles_Higher, ObjX2 - 24, ObjY, 30, 86, 4, 3, true);
                
                for (var i = 0; i < ((ObjTileW - 8) / 2); i++)
                {
                    DrawTileBlock(global.TMID_Tiles_Higher, ObjX + 32 + (i * 8), ObjY, 34 + (i % 2), 86, 1, 3);
                    DrawTileBlock(global.TMID_Tiles_Higher, ObjX2 - 32 - (i * 8), ObjY, 34 + (i % 2), 86, 1, 3, true);
                }
                
                DrawTileBlock(WallTMID, ObjX, ObjY + 24, 30, 89, 4, 4);
                DrawTileBlock(WallTMID, ObjX2 - 24, ObjY + 24, 30, 89, 4, 4);
                
                for (var i = 0; i < (ObjTileW - 8); i++)
                    DrawTileBlock(global.TMID_Tiles_Higher, ObjX + 32 + (i * 8), ObjY + 40, 35, 79, 1, 2);
                
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY + 24, 4, 4);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX2 - 24, ObjY + 24, 4, 4);
                break;
            
            case UnknownEnum.Value_143:
                DrawTileBlock(WallTMID, ObjX, ObjY + 24, 40, 89, 4, 4);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY + 24, 4, 4);
                DrawTileBlock(global.TMID_Tiles_Higher, ObjX, ObjY, 40, 86, 3, 3);
                DrawTileBlock(global.TMID_Tiles_Higher, ObjX2, ObjY, 43, 87, 1, 2);
                break;
            
            case UnknownEnum.Value_135:
                for (var _y = 0; _y < floor(ObjTileH / 4); _y++)
                {
                    for (var _x = 0; _x < floor(ObjTileW / 4); _x++)
                    {
                        var _TreeX = ObjX + (_x * 32);
                        var _TreeY = ObjY + (_y * 32);
                        DrawTileBlock(WallTMID, _TreeX, _TreeY, 34 + ((GetPropertyValue(PropertiesArray, "Pink") != -1) ? 4 : 0), 82, 4, 4);
                    }
                }
                
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_136:
                for (var _y = 0; _y < floor(ObjTileH / 4); _y++)
                {
                    for (var _x = 0; _x < floor(ObjTileW / 3); _x++)
                    {
                        var _TreeX = ObjX + (_x * 24);
                        var _TreeY = ObjY + (_y * 32);
                        DrawTileBlock(WallTMID, _TreeX, _TreeY, 47, 76, 3, 4);
                    }
                }
                
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_137:
                for (var _y = 0; _y < floor(ObjTileH / 3); _y++)
                {
                    for (var _x = 0; _x < floor(ObjTileW / 2); _x++)
                    {
                        var _TreeX = ObjX + (_x * 16);
                        var _TreeY = ObjY + (_y * 24);
                        DrawTileBlock(WallTMID, _TreeX, _TreeY, 45, 76, 2, 3);
                    }
                }
                
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_138:
                for (var _y = 0; _y < floor(ObjTileH / 3); _y++)
                {
                    for (var _x = 0; _x < floor(ObjTileW / 2); _x++)
                    {
                        var _TreeX = ObjX + (_x * 16);
                        var _TreeY = ObjY + (_y * 24);
                        DrawTileBlock(WallTMID, _TreeX, _TreeY, 45, 79, 2, 3);
                    }
                }
                
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_210:
                for (var _x = 0; _x < ObjTileW; _x++)
                {
                    var PosX = ObjX + (_x * 8);
                    
                    if ((_x % 2) == 0)
                        DrawTileBlock(WallTMID, PosX, ObjY, 26, 84, 1, 2);
                    else
                        DrawTileBlock(WallTMID, PosX, ObjY, 27, 84, 1, 1);
                }
                
                var _WallInst = WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                _WallInst.BlockProjectiles = false;
                break;
            
            case UnknownEnum.Value_211:
                for (var _y = 0; _y < floor(ObjTileH / 2); _y++)
                {
                    var PosY = ObjY + (_y * 16);
                    DrawTileBlock(WallTMID, ObjX, PosY, 29, 84, 1, 2);
                }
                
                DrawTileBlock(WallTMID, ObjX, ObjY2 - 8, 26, 84, 1, 2);
                var _WallInst = WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                _WallInst.BlockProjectiles = false;
                break;
            
            case UnknownEnum.Value_204:
                DrawTileBlock(WallTMID, ObjX, ObjY, 40, 76, 2, 2);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_205:
                DrawTileBlock(WallTMID, ObjX, ObjY, 43, 76, 2, 2);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_197:
                DrawTileBlock(WallTMID, ObjX, ObjY, 40, 79, 2, 3);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_198:
                DrawTileBlock(WallTMID, ObjX, ObjY, 43, 79, 2, 3);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_203:
                for (var i = 0; i < ObjTileW; i++)
                    DrawTileBlock(WallTMID, ObjX + (i * 8), ObjY, 42, 76, 1, 3);
                
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_206:
                for (var i = 0; i < ObjTileH; i++)
                    DrawTileBlock(WallTMID, ObjX, ObjY + (i * 8), 40, 78, 2, 1);
                
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_202:
                DrawTileBlock(WallTMID, ObjX, ObjY, 40, 76, 1, 1);
                DrawTileBlock(WallTMID, ObjX + 8, ObjY, 44, 76, 1, 1);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_199:
                DrawTileBlock(WallTMID, ObjX, ObjY, 40, 80, 1, 2);
                DrawTileBlock(WallTMID, ObjX + 8, ObjY, 44, 80, 1, 2);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_200:
                DrawTileBlock(WallTMID, ObjX, ObjY, 40, 76, 1, 1);
                DrawTileBlock(WallTMID, ObjX, ObjY + 8, 40, 80, 1, 2);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_201:
                DrawTileBlock(WallTMID, ObjX, ObjY, 44, 76, 1, 1);
                DrawTileBlock(WallTMID, ObjX, ObjY + 8, 44, 80, 1, 2);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_153:
                DrawTileBlock(WallTMID, ObjX, ObjY, 46, 85, 4, 4);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_154:
                for (var _y = 0; _y < floor(ObjTileH / 2); _y++)
                {
                    for (var _x = 0; _x < floor(ObjTileW / 2); _x++)
                    {
                        var PosX = ObjX + (_x * 16);
                        var PosY = ObjY + (_y * 16);
                        DrawTileBlock(WallTMID, PosX, PosY, 48, 89, 2, 2);
                    }
                }
                
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_140:
                DrawTileBlock(global.TMID_Tiles_Higher, ObjX, ObjY, 34, 89, 2, 1);
                DrawTileBlock(WallTMID, ObjX, ObjY + 8, 34, 90, 2, 3);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY + 8, ObjTileW, ObjTileH - 1);
                break;
            
            case UnknownEnum.Value_155:
                for (var _x = 0; _x < ObjTileW; _x++)
                {
                    var PosX = ObjX + (_x * 8);
                    DrawTileBlock(WallTMID, PosX, ObjY, 48 + (_x % 2), 80, 1, 3);
                }
                
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_213:
                DrawTileBlock(WallTMID, ObjX, ObjY, 42, 82, 4, 4);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX + 8, ObjY, ObjTileW - 2, ObjTileH);
                break;
            
            case UnknownEnum.Value_149:
                DrawTileBlock(WallTMID, ObjX, ObjY, 26, 86, 4, 3);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_150:
                DrawTileBlock(WallTMID, ObjX, ObjY, 27, 89, 3, 3);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_215:
                DrawTileBlock(WallTMID, ObjX, ObjY, 142, 31, 4, 2);
                break;
            
            case UnknownEnum.Value_162:
                DrawTileBlock(WallTMID, ObjX, ObjY, 50, 80, 4, 6);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, 4, 6);
                break;
            
            case UnknownEnum.Value_163:
                DrawTileBlock(WallTMID, ObjX, ObjY, 58, 80, 4, 5);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, 4, 5);
                break;
            
            case UnknownEnum.Value_158:
                DrawTileBlock(DecorTMID, ObjX, ObjY, 50 + (real(ObjType) * 4), 76, 4, 4);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, 4, 4);
                break;
            
            case UnknownEnum.Value_159:
                DrawTileBlock(WallTMID, ObjX, ObjY, 66 + (real(ObjType) * 3), 76, 3, 4);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, 3, 4);
                break;
            
            case UnknownEnum.Value_160:
                DrawTileBlock(DecorTMID, ObjX, ObjY, 72 + (real(ObjType) * 4), 76, 4, 4);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, 4, 4);
                break;
            
            case UnknownEnum.Value_161:
                DrawTileBlock(DecorTMID, ObjX, ObjY, 80, 76, 6, 3);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, 6, 3);
                break;
            
            case UnknownEnum.Value_164:
                DrawTileBlock(DecorTMID, ObjX, ObjY, 62, 80, 6, 5);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, 6, 5);
                break;
            
            case UnknownEnum.Value_165:
                DrawTileBlock(DecorTMID, ObjX, ObjY, 58 + (real(ObjType) * 4), 85, 4, 5);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, 4, 5);
                break;
            
            case UnknownEnum.Value_166:
                DrawTileBlock(DecorTMID, ObjX, ObjY, 66 + (real(ObjType) * 3), 85, 3, 5);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, 3, 5);
                break;
            
            case UnknownEnum.Value_168:
                DrawTileBlock(DecorTMID, ObjX, ObjY, 58 + (real(ObjType) * 4), 90, 4, 3);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, 4, 3);
                break;
            
            case UnknownEnum.Value_169:
                DrawTileBlock(DecorTMID, ObjX, ObjY, 66 + (real(ObjType) * 2), 90, 2, 3);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, 2, 3);
                break;
                break;
            
            case UnknownEnum.Value_167:
                DrawTileBlock(DecorTMID, ObjX, ObjY, 68, 81, 6, 4);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY + 8, 6, 3);
                break;
            
            case UnknownEnum.Value_148:
                DrawTileBlock(DecorTMID, ObjX, ObjY, 26, 82, ObjTileW, ObjTileH);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_189:
                DrawTileBlock(DecorTMID, ObjX, ObjY, 54, 86 + (real(ObjType) * 2), ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_194:
                DrawTileBlock(DecorTMID, ObjX, ObjY, 50, 90, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_188:
                DrawTileBlock(DecorTMID, ObjX, ObjY, 48, 91, ObjTileW, ObjTileH);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_221:
                var VarStruct = 
                {
                    FloorLevel: GetFloorLevelID(ObjX, ObjY),
                    ItemHolding: -1,
                    SectionID: 0,
                    RoomIndex: arg0
                };
                instance_create_layer(ObjX, ObjY, "Objs_" + FloorLevelStr, oEnemy_Chicken, VarStruct);
                break;
            
            case UnknownEnum.Value_156:
                DrawTileBlock(WallTMID, ObjX, ObjY, 46, 83, 1, 2);
                var XPos;
                
                for (var i = 0; i < (ObjTileW - 2); i++)
                {
                    XPos = ObjX + 8 + (i * 8);
                    DrawTileBlock(WallTMID, XPos, ObjY, 47 + (i % 2), 83, 1, 2);
                }
                
                DrawTileBlock(WallTMID, XPos + 8, ObjY, 49, 83, 1, 2);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_170:
                DrawTileBlock(global.TMID_Tiles_Higher, ObjX, ObjY, 74, 81, 6, 3);
                DrawTileBlock(DecorTMID, ObjX, ObjY + 24, 74, 84, 6, 1);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY + 16, ObjTileW, 2);
                break;
            
            case UnknownEnum.Value_222:
                var inst = instance_create_layer(ObjX, ObjY, "Objs_" + FloorLevelStr, oBook);
                break;
            
            case UnknownEnum.Value_191:
                DrawTileBlock(DecorTMID, ObjX, ObjY, 52, 76 + choose(14, 16), 2, 2, FlipCoin_Bool());
                break;
            
            case UnknownEnum.Value_195:
                DrawTileBlock(DecorTMID, ObjX, ObjY, 52, 88, 1, 2);
                break;
            
            case UnknownEnum.Value_196:
                DrawTileBlock(DecorTMID, ObjX, ObjY, 53, 88, 1, 2);
                break;
            
            case UnknownEnum.Value_226:
                if (ObjType == "Light")
                {
                    var _LightInst = instance_create_layer(ObjX, ObjY + 8, "Objs_Upper", oWallLight, 
                    {
                        RoomIndex: arg0,
                        Location: 1,
                        Status: !global.Challenges[UnknownEnum.Value_4] || GetPropertyValue(PropertiesArray, "AlwaysLit") != -1
                    });
                    
                    if (global.Level.Rooms[arg0].ForcedTheme != -1)
                        _LightInst.PaletteIndex = global.Level.Rooms[arg0].ForcedTheme + 1;
                }
                else
                {
                    DrawTileBlock(DecorTMID, ObjX, ObjY, 132, 4 + ((global.Level.Index - 1) * 6), 4, 3);
                }
                
                break;
            
            case UnknownEnum.Value_223:
                if (ObjType == "Light")
                {
                    var _LightInst = instance_create_layer(ObjX, ObjY, "Objs_Upper", oWallLight, 
                    {
                        RoomIndex: arg0,
                        Location: 2,
                        Status: !global.Challenges[UnknownEnum.Value_4] || GetPropertyValue(PropertiesArray, "AlwaysLit") != -1
                    });
                    
                    if (global.Level.Rooms[arg0].ForcedTheme != -1)
                        _LightInst.PaletteIndex = global.Level.Rooms[arg0].ForcedTheme + 1;
                }
                else
                {
                    DrawTileBlock(DecorTMID, ObjX, ObjY, 132, 4 + ((global.Level.Index - 1) * 6) + 3, 4, 3);
                }
                
                break;
            
            case UnknownEnum.Value_224:
                if (ObjType == "Light")
                {
                    var _LightInst = instance_create_layer(ObjX + 8, ObjY, "Objs_Upper", oWallLight, 
                    {
                        RoomIndex: arg0,
                        Location: 3,
                        Status: !global.Challenges[UnknownEnum.Value_4] || GetPropertyValue(PropertiesArray, "AlwaysLit") != -1
                    });
                    
                    if (global.Level.Rooms[arg0].ForcedTheme != -1)
                        _LightInst.PaletteIndex = global.Level.Rooms[arg0].ForcedTheme + 1;
                }
                else
                {
                    DrawTileBlock(DecorTMID, ObjX, ObjY, 136, 4 + ((global.Level.Index - 1) * 6), 3, 4);
                }
                
                break;
            
            case UnknownEnum.Value_225:
                if (ObjType == "Light")
                {
                    var _LightInst = instance_create_layer(ObjX, ObjY, "Objs_Upper", oWallLight, 
                    {
                        RoomIndex: arg0,
                        Location: 4,
                        Status: !global.Challenges[UnknownEnum.Value_4] || GetPropertyValue(PropertiesArray, "AlwaysLit") != -1
                    });
                    
                    if (global.Level.Rooms[arg0].ForcedTheme != -1)
                        _LightInst.PaletteIndex = global.Level.Rooms[arg0].ForcedTheme + 1;
                }
                else
                {
                    DrawTileBlock(DecorTMID, ObjX, ObjY, 139, 4 + ((global.Level.Index - 1) * 6), 3, 4);
                }
                
                break;
            
            case UnknownEnum.Value_231:
                DrawTileBlock(global.TMID_Tiles_Highest, ObjX, ObjY, 94, 76, 6, 5);
                var WallInst = WallObj_Create("Objs_Upper", ObjX, ObjY + 8, ObjTileW, 8);
                WallInst.FloorLevel = 1;
                break;
            
            case UnknownEnum.Value_228:
                DrawTileBlock(global.TMID_Walls_Upper, ObjX, ObjY, 94, 81, 6, 5);
                break;
            
            case UnknownEnum.Value_229:
                DrawTileBlock(global.TMID_Tiles_Highest, ObjX, ObjY, 93, 77, 1, 5);
                DrawTileBlock(global.TMID_Walls_Upper, ObjX, ObjY + 40, 93, 82, 1, 2);
                break;
            
            case UnknownEnum.Value_230:
                DrawTileBlock(global.TMID_Tiles_Highest, ObjX, ObjY, 100, 77, 1, 5);
                DrawTileBlock(global.TMID_Walls_Upper, ObjX, ObjY + 40, 100, 82, 1, 2);
                break;
            
            case UnknownEnum.Value_232:
                for (var i = 0; i < ObjTileW; i++)
                {
                    var _PosX = ObjX + (i * 8);
                    DrawTileBlock(global.TMID_Tiles_Higher, _PosX, ObjY, 88, 87, 1, 5);
                    DrawTileBlock(global.TMID_Walls_Upper, _PosX, ObjY + 40, 88, 92, 1, 2);
                }
                
                break;
            
            case UnknownEnum.Value_233:
                DrawTileBlock(global.TMID_Walls_Upper, ObjX, ObjY, 89, 81, 4, 13);
                break;
            
            case UnknownEnum.Value_235:
                for (var _y = 0; _y < ObjTileH; _y++)
                {
                    for (var _x = 0; _x < ObjTileW; _x++)
                        DrawTileBlock(global.TMID_Walls_Upper, ObjX + (_x * 8), ObjY + (_y * 8), 93, 87, 1, 1);
                }
                
                break;
            
            case UnknownEnum.Value_236:
                instance_create_layer(ObjX, ObjY, "ObjsDoors_Upper", oCastleWallDoor);
                break;
            
            case UnknownEnum.Value_237:
                var BushInst = instance_create_layer(ObjX + 8, ObjY + 15, "ObjsDoors_" + FloorLevelStr, oBush);
                var _RandomItem = true;
                var BushItem = GetPropertyValue(PropertiesArray, "Item");
                
                if (BushItem != -1)
                {
                    var _AssetIndex = asset_get_index(BushItem);
                    
                    if (_AssetIndex != -1)
                    {
                        BushInst.ContentsObj = ItemClassFromObjIndex(_AssetIndex);
                        _RandomItem = false;
                    }
                }
                
                if (_RandomItem)
                    BushInst.ContentsObj = Probs_RandomItemClass_Pot(false, true);
                
                var BushStyle = GetPropertyValue(PropertiesArray, "Purple");
                
                if (BushStyle != -1)
                {
                    DrawTileBlock(WaterTMID, ObjX, ObjY, 7, 2, 2, 2);
                    BushInst.Index = 1;
                }
                else
                {
                    DrawTileBlock(WaterTMID, ObjX, ObjY, 7, 0, 2, 2);
                }
                
                BushInst.image_index = BushInst.Index;
                var WallInst = WallObj_Create("ObjsFloor_" + FloorLevelStr, ObjX, ObjY, 2, 2);
                WallInst.BlockItems = false;
                WallInst.BlockProjectiles = false;
                BushInst.WallObj = WallInst;
                break;
            
            case UnknownEnum.Value_250:
                DrawTileBlock(global.TMID_Walls_Lower, ObjX, ObjY, 10, 94, ObjTileW, ObjTileH);
                WallObj_Create("Objs_Lower", ObjX, ObjY, ObjTileW - 1, ObjTileH);
                break;
            
            case UnknownEnum.Value_251:
                DrawTileBlock(global.TMID_Walls_Lower, ObjX, ObjY, 13, 96, ObjTileW, ObjTileH);
                WallObj_Create("Objs_Lower", ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_252:
                DrawTileBlock(global.TMID_Decor_Upper, ObjX, ObjY, 17, 92, ObjTileW, 1);
                DrawTileBlock(global.TMID_Decor_Lower, ObjX, ObjY + 8, 17, 93, ObjTileW, ObjTileH - 1);
                break;
            
            case UnknownEnum.Value_253:
                DrawTileBlock(global.TMID_Water_Lower, ObjX, ObjY, 6, 94, ObjTileW, ObjTileH);
                WallObj_Create("Objs_Lower", ObjX + 8, ObjY, 2, 1);
                instance_create_layer(ObjX + 15, ObjY, "ObjsHigher_Lower", oEnemy_FootSoldier, 
                {
                    FloorLevel: 0,
                    ItemHolding: -1,
                    SectionID: 0,
                    RoomIndex: arg0
                });
                break;
            
            case UnknownEnum.Value_255:
                DrawTileBlock(global.TMID_Decor_Lower, ObjX, ObjY, 13, 92, ObjTileW, ObjTileH);
                WallObj_Create("Objs_Lower", ObjX, ObjY, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_256:
                DrawTileBlock(global.TMID_Decor_Upper, ObjX, ObjY, 0, 93, ObjTileW, ObjTileH - 3);
                DrawTileBlock(global.TMID_Decor_Lower, ObjX, ObjY + 24, 0, 96, ObjTileW, ObjTileH - 3);
                break;
            
            case UnknownEnum.Value_257:
                DrawTileBlock(global.TMID_Decor_Upper, ObjX, ObjY, 9, 93, ObjTileW, ObjTileH);
                break;
            
            case UnknownEnum.Value_258:
                DrawTileBlock(global.TMID_Walls_Upper, ObjX + 8, ObjY, 19, 95, 2, 1);
                DrawTileBlock(global.TMID_Walls_Lower, ObjX, ObjY + 8, 18, 96, ObjTileW, ObjTileH - 2);
                DrawTileBlock(global.TMID_Water_Lower, ObjX, ObjY + 24, 18, 98, ObjTileW, 1);
                WallObj_Create("Objs_Lower", ObjX, ObjY + 8, ObjTileW, ObjTileH - 2);
                break;
            
            case UnknownEnum.Value_260:
                var PizzaInst = instance_create_layer(ObjX + 8, ObjY + 16, "Objs_Lower", oItem_Food, 
                {
                    From: UnknownEnum.Value_2
                });
                
                with (PizzaInst)
                {
                    Item_SetIndex(UnknownEnum.Value_43);
                    FloorLevel = 0;
                    ShadowOffsetY -= 2;
                }
                
                break;
            
            case UnknownEnum.Value_266:
                var _Inst;
                
                if (global.Level.Index == UnknownEnum.Value_10)
                {
                    _Inst = instance_create_layer(ObjX + 8, ObjY + 16, "Objs_" + FloorLevelStr, oItem_Gem, 
                    {
                        From: UnknownEnum.Value_2
                    });
                }
                else
                {
                    _Inst = instance_create_layer(ObjX + 8, ObjY + 16, "Objs_" + FloorLevelStr, choose(oItem_Gem, oItem_Gem, oItem_Kinstone), 
                    {
                        From: UnknownEnum.Value_2
                    });
                }
                
                if (Prob(1))
                {
                    var _InstIndex = _Inst.Index;
                    
                    with (_Inst.object_index)
                    {
                        if (RoomIndex != arg0)
                            continue;
                        
                        if (_Inst.id == id)
                            continue;
                        
                        if (_InstIndex == Index)
                            _InstIndex = (_InstIndex + 1) % ((_Inst.object_index == oItem_Gem) ? 9 : 4);
                    }
                    
                    with (_Inst)
                        Item_SetIndex(_InstIndex);
                }
                
                break;
            
            case UnknownEnum.Value_265:
                if (global.Challenges[UnknownEnum.Value_4])
                    break;
                
                var _Lit = GetPropertyValue(PropertiesArray, "Lit");
                var TorchInst = instance_create_layer(ObjX, ObjY, "Objs_" + FloorLevelStr, oTorch, 
                {
                    RoomIndex: arg0,
                    Lit: _Lit != -1
                });
                break;
            
            case UnknownEnum.Value_272:
                DrawTileBlock(DecorTMID, ObjX, ObjY, 152, 4 + ((global.Level.Index - 1) * 6), 2, 3);
                DrawTileBlock(WaterTMID, ObjX, ObjY + 24, 152, 4 + ((global.Level.Index - 1) * 6) + 3, 2, 1);
                break;
            
            case UnknownEnum.Value_269:
                DrawTileBlock(WaterTMID, ObjX, ObjY, 154, 4 + ((global.Level.Index - 1) * 6), 2, 1);
                DrawTileBlock(DecorTMID, ObjX, ObjY + 8, 154, 4 + ((global.Level.Index - 1) * 6) + 1, 2, 3);
                break;
            
            case UnknownEnum.Value_270:
                DrawTileBlock(DecorTMID, ObjX, ObjY, 152, 4 + ((global.Level.Index - 1) * 6) + 4, 3, 2);
                DrawTileBlock(WaterTMID, ObjX + 24, ObjY, 155, 4 + ((global.Level.Index - 1) * 6) + 4, 1, 2);
                break;
            
            case UnknownEnum.Value_271:
                DrawTileBlock(WaterTMID, ObjX, ObjY, 148, 4 + ((global.Level.Index - 1) * 6) + 4, 1, 2);
                DrawTileBlock(DecorTMID, ObjX + 8, ObjY, 149, 4 + ((global.Level.Index - 1) * 6) + 4, 3, 2);
                break;
            
            case UnknownEnum.Value_273:
                var TileX2 = ObjX + ((ObjTileW - 1) * 8);
                var TileY2 = ObjY + ((ObjTileH - 2) * 8);
                DrawTileBlock(WallTMID, ObjX, ObjY, 118, 76, 1, 1);
                
                for (var _x = 0; _x < (ObjTileW - 2); _x++)
                {
                    var _PosX = ObjX + 8 + (_x * 8);
                    DrawTileBlock(WallTMID, _PosX, ObjY, 119, 76, 1, 1);
                }
                
                DrawTileBlock(WallTMID, TileX2, ObjY, 120, 76, 1, 1);
                
                for (var _y = 0; _y < (ObjTileH - 3); _y++)
                {
                    var _PosY = ObjY + 8 + (_y * 8);
                    DrawTileBlock(WallTMID, ObjX, _PosY, 118, 77, 1, 1);
                    DrawTileBlock(WallTMID, TileX2, _PosY, 120, 77, 1, 1);
                }
                
                DrawTileBlock(WallTMID, ObjX, TileY2, 118, 78, 1, 2);
                DrawTileBlock(WallTMID, TileX2, TileY2, 121, 78, 1, 2);
                
                for (var _x = 0; _x < (ObjTileW - 2); _x++)
                {
                    var _PosX = ObjX + 8 + (_x * 8);
                    DrawTileBlock(WallTMID, _PosX, TileY2, 119 + (_x % 2), 78, 1, 2);
                }
                
                for (var _y = 0; _y < (ObjTileH - 3); _y++)
                {
                    for (var _x = 0; _x < (ObjTileW - 2); _x++)
                    {
                        var _PosX = ObjX + 8 + (_x * 8);
                        var _PosY = ObjY + 8 + (_y * 8);
                        DrawTileBlock(WallTMID, _PosX, _PosY, 119, 77, 1, 1);
                    }
                }
                
                var CoalInst = instance_create_layer(ObjX + 8, ObjY + 8, "Objs_" + FloorLevelStr, oCoal, 
                {
                    RoomIndex: arg0,
                    W: ObjW - 16,
                    H: ObjH - 24
                });
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, ObjTileH - 1);
                global.Level.Rooms[arg0].Heat = true;
                break;
            
            case UnknownEnum.Value_4:
                ClearTileBlock(WallTMID, ObjX + 8, ObjY + 8, 2, 2);
                var WallObjInst = collision_point(ObjX, ObjY, oWall, false, true);
                
                if (WallObjInst != -4)
                    WallObj_Cutout_H(WallObjInst, ObjX + 8, ObjX + 23);
                
                var _DoorInst = instance_create_layer(ObjX, ObjY, "ObjsDoors_" + FloorLevelStr, oDoor);
                _DoorInst.FloorLevel = FloorLevel;
                _DoorInst.Location = "Top";
                _DoorInst.AddTracks = GetPropertyValue(PropertiesArray, "AddTrack") != -1;
                Door_SetPassageArea(_DoorInst);
                break;
            
            case UnknownEnum.Value_1:
                ClearTileBlock(WallTMID, ObjX + 8, ObjY, 2, 2);
                var WallObjInst = collision_point(ObjX, ObjY, oWall, false, true);
                
                if (WallObjInst != -4)
                    WallObj_Cutout_H(WallObjInst, ObjX + 8, ObjX + 23);
                
                var _DoorInst = instance_create_layer(ObjX, ObjY, "ObjsDoors_" + FloorLevelStr, oDoor);
                _DoorInst.FloorLevel = FloorLevel;
                _DoorInst.Location = "Bottom";
                _DoorInst.AddTracks = GetPropertyValue(PropertiesArray, "AddTrack") != -1;
                Door_SetPassageArea(_DoorInst);
                break;
            
            case UnknownEnum.Value_2:
                ClearTileBlock(WallTMID, ObjX + 16, ObjY + 8, 2, 2);
                var WallObjInst = collision_point(ObjX, ObjY, oWall, false, true);
                
                if (WallObjInst != -4)
                    WallObj_Cutout_V(WallObjInst, ObjY + 8, ObjY + 23);
                
                var _DoorInst = instance_create_layer(ObjX, ObjY, "ObjsDoors_" + FloorLevelStr, oDoor);
                _DoorInst.FloorLevel = FloorLevel;
                _DoorInst.Location = "Left";
                _DoorInst.AddTracks = GetPropertyValue(PropertiesArray, "AddTrack") != -1;
                Door_SetPassageArea(_DoorInst);
                break;
            
            case UnknownEnum.Value_3:
                ClearTileBlock(WallTMID, ObjX + 8, ObjY + 8, 2, 2);
                var WallObjInst = collision_point(ObjX, ObjY, oWall, false, true);
                
                if (WallObjInst != -4)
                    WallObj_Cutout_V(WallObjInst, ObjY + 8, ObjY + 23);
                
                var _DoorInst = instance_create_layer(ObjX, ObjY, "ObjsDoors_" + FloorLevelStr, oDoor);
                _DoorInst.FloorLevel = FloorLevel;
                _DoorInst.Location = "Right";
                _DoorInst.AddTracks = GetPropertyValue(PropertiesArray, "AddTrack") != -1;
                Door_SetPassageArea(_DoorInst);
                break;
            
            case UnknownEnum.Value_280:
                var _Dir = GetPropertyValue(PropertiesArray, "Dir");
                var CartInst = instance_create_layer(ObjX, ObjY, "Objs_" + FloorLevelStr, oMineCart, 
                {
                    Dir: _Dir
                });
                break;
            
            case UnknownEnum.Value_295:
                var _Flip = GetPropertyValue(PropertiesArray, "Flip") != -1;
                var WorkerInst = instance_create_layer(ObjX, ObjY, "Objs_" + FloorLevelStr, oDwarfWorker, 
                {
                    Flip: _Flip
                });
                break;
            
            case UnknownEnum.Value_296:
                var _Index = irandom(9);
                var GemRockInst = instance_create_layer(ObjX + 8, ObjY + 16, "ObjsFloor_" + FloorLevelStr, oGemRock, 
                {
                    image_index: _Index
                });
                break;
            
            case UnknownEnum.Value_297:
                var _Index = irandom(9);
                DrawTileBlock(DecorTMID, ObjX, ObjY, 118 + ((_Index % 5) * 2), 80 + ((_Index div 5) * 2), 2, 2, Prob(0.5));
                break;
            
            case UnknownEnum.Value_299:
                var _Index = GetPropertyValue(PropertiesArray, "Index") * 2;
                _Index = choose(_Index, _Index + 1);
                DrawTileBlock(DecorTMID, ObjX, ObjY, 128 + ((_Index % 4) * 2), 80 + ((_Index div 4) * 2), 2, 2, Prob(0.5));
                break;
            
            case UnknownEnum.Value_300:
                for (var _x = 0; _x < ObjTileW; _x++)
                {
                    var _PosX = ObjX + (_x * 8);
                    DrawTileBlock(DecorTMID, _PosX, ObjY, 134, 94, 1, 4);
                }
                
                var _ObjLayer = "Objs_" + FloorLevelStr;
                WallObj_Create(_ObjLayer, ObjX, ObjY - 12, ObjTileW, 1);
                WallObj_Create(_ObjLayer, ObjX, ObjY2, ObjTileW, 1);
                var _inst = instance_create_layer(ObjX, ObjY, _ObjLayer, oDrawBridgeArea);
                _inst.image_xscale = ObjTileW;
                _inst.image_yscale = ObjTileH;
                break;
            
            case UnknownEnum.Value_301:
                for (var _y = 0; _y < ObjTileH; _y++)
                {
                    var _PosY = ObjY + (_y * 8);
                    DrawTileBlock(DecorTMID, ObjX, _PosY, 130, 98, 4, 1);
                }
                
                var _ObjLayer = "Objs_" + FloorLevelStr;
                WallObj_Create(_ObjLayer, ObjX - 5, ObjY, 1, ObjTileH);
                WallObj_Create(_ObjLayer, ObjX2 + 5, ObjY, 1, ObjTileH);
                var _inst = instance_create_layer(ObjX, ObjY, _ObjLayer, oDrawBridgeArea);
                _inst.image_xscale = ObjTileW;
                _inst.image_yscale = ObjTileH;
                break;
            
            case UnknownEnum.Value_84:
                Dungeon_Draw_Jail(arg0, ObjX, ObjY, ObjTileW, ObjTileH, choose(UnknownEnum.Value_0, UnknownEnum.Value_1, UnknownEnum.Value_1));
                break;
            
            case UnknownEnum.Value_316:
                var TentInst = instance_create_layer(ObjX, ObjY, "Objs_" + FloorLevelStr, oSaveTent);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY + 8, 4, 3);
                break;
            
            case UnknownEnum.Value_317:
                var FrogsInst = instance_create_layer(ObjX, ObjY, "Objs_" + FloorLevelStr, oSimonFrogs);
                WallObj_Create("Objs_" + FloorLevelStr, ObjX, ObjY, ObjTileW, 1);
                break;
                break;
                continue;
        }
        
        switch (ObjName)
        {
            case "MineCartAction":
                var _Val1 = GetPropertyValue(PropertiesArray, "Val1");
                var _Val2 = GetPropertyValue(PropertiesArray, "Val2");
                var _MineCartActionInst = instance_create_layer(ObjX, ObjY, "Objs_" + FloorLevelStr, oMineCartAction, 
                {
                    Action: ObjType,
                    Value1: _Val1,
                    Value2: _Val2
                });
                break;
        }
    }
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
    Value_10 = 10,
    Value_13 = 13,
    Value_34 = 34,
    Value_35,
    Value_41 = 41,
    Value_42,
    Value_43,
    Value_60 = 60,
    Value_83 = 83,
    Value_84,
    Value_85,
    Value_86,
    Value_87,
    Value_88,
    Value_89,
    Value_92 = 92,
    Value_94 = 94,
    Value_96 = 96,
    Value_97,
    Value_135 = 135,
    Value_136,
    Value_137,
    Value_138,
    Value_139,
    Value_140,
    Value_143 = 143,
    Value_148 = 148,
    Value_149,
    Value_150,
    Value_151,
    Value_152,
    Value_153,
    Value_154,
    Value_155,
    Value_156,
    Value_158 = 158,
    Value_159,
    Value_160,
    Value_161,
    Value_162,
    Value_163,
    Value_164,
    Value_165,
    Value_166,
    Value_167,
    Value_168,
    Value_169,
    Value_170,
    Value_172 = 172,
    Value_173,
    Value_174,
    Value_175,
    Value_176,
    Value_177,
    Value_178,
    Value_179,
    Value_180,
    Value_181,
    Value_182,
    Value_183,
    Value_185 = 185,
    Value_186,
    Value_188 = 188,
    Value_189,
    Value_191 = 191,
    Value_192,
    Value_194 = 194,
    Value_195,
    Value_196,
    Value_197,
    Value_198,
    Value_199,
    Value_200,
    Value_201,
    Value_202,
    Value_203,
    Value_204,
    Value_205,
    Value_206,
    Value_208 = 208,
    Value_209,
    Value_210,
    Value_211,
    Value_213 = 213,
    Value_214,
    Value_215,
    Value_216,
    Value_217,
    Value_221 = 221,
    Value_222,
    Value_223,
    Value_224,
    Value_225,
    Value_226,
    Value_228 = 228,
    Value_229,
    Value_230,
    Value_231,
    Value_232,
    Value_233,
    Value_235 = 235,
    Value_236,
    Value_237,
    Value_250 = 250,
    Value_251,
    Value_252,
    Value_253,
    Value_255 = 255,
    Value_256,
    Value_257,
    Value_258,
    Value_260 = 260,
    Value_262 = 262,
    Value_265 = 265,
    Value_266,
    Value_268 = 268,
    Value_269,
    Value_270,
    Value_271,
    Value_272,
    Value_273,
    Value_280 = 280,
    Value_295 = 295,
    Value_296,
    Value_297,
    Value_298,
    Value_299,
    Value_300,
    Value_301,
    Value_314 = 314,
    Value_316 = 316,
    Value_317
}
