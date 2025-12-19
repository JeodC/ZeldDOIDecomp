global.Level = 0;

function Dungeon_Clear()
{
    for (var i = 0; i < array_length(global.TMID); i++)
        tilemap_clear(global.TMID[i], 0);
    
    with (oEnemy)
        instance_destroy(id);
    
    with (oItem)
        instance_destroy(id);
    
    with (oProjectile)
        instance_destroy(id);
    
    with (oPickupObj)
        instance_destroy(id);
    
    with (oSwitch)
        instance_destroy(id);
    
    with (oSwitchBlock)
        instance_destroy(id);
    
    with (oWallLight)
        instance_destroy(id);
    
    with (oLampFlame)
        instance_destroy(id);
    
    with (oDoor)
        instance_destroy(id);
    
    with (oSign)
        instance_destroy(id);
    
    with (oEffects)
        instance_destroy(id);
    
    with (oMovingFloor)
        instance_destroy(id);
    
    with (oWall)
        instance_destroy(id);
    
    with (oCurtain)
        instance_destroy(id);
    
    with (oShop)
        instance_destroy(id);
    
    with (oHeartGuy)
        instance_destroy(id);
    
    with (oArcades)
        instance_destroy(id);
    
    with (oPoolTable)
        instance_destroy(id);
    
    with (oPopMachine)
        instance_destroy(id);
    
    with (oBoss_Armos_C)
        instance_destroy(id);
    
    with (oBoss_Lanmola_C)
        instance_destroy(id);
    
    with (oBoss_Lanmola_Dirt1)
        instance_destroy(id);
    
    with (oBoss_Lanmola_Dirt2)
        instance_destroy(id);
    
    with (oBoss_Lanmola_DirtSplash)
        instance_destroy(id);
    
    with (oBossHeartCrystal)
        instance_destroy(id);
    
    with (oFinalBossGate)
        instance_destroy(id);
    
    with (oStarfield)
        instance_destroy(id);
    
    with (oAghanim_End)
        instance_destroy(id);
    
    with (oCrystalEnd)
        instance_destroy(id);
    
    with (oItem_Kinstone_Main)
        instance_destroy(id);
    
    with (oRodCharger)
        instance_destroy(id);
    
    with (oWarp)
        instance_destroy(id);
    
    with (oCursed)
        instance_destroy(id);
    
    with (oDeadHungryGuy)
        instance_destroy(id);
    
    with (oMap)
        instance_destroy(id);
    
    with (oCape)
        instance_destroy(id);
    
    with (oInventory)
        instance_destroy(id);
    
    with (oPrisoner)
        instance_destroy(id);
    
    with (oTreasureLarge)
        instance_destroy(id);
    
    with (oFairy_Health)
        instance_destroy(id);
    
    with (oFairy_Queen)
        instance_destroy(id);
    
    with (oHouseDoor)
        instance_destroy(id);
    
    with (oCastleWallDoor)
        instance_destroy(id);
    
    with (oWaterfall)
        instance_destroy(id);
    
    with (oNPC)
        instance_destroy(id);
    
    with (oNPC_OldLady)
        instance_destroy(id);
    
    with (oChessBoard)
        instance_destroy(id);
    
    with (oBook)
        instance_destroy(id);
    
    with (oEnemy_Guru_Bar)
        instance_destroy(id);
    
    with (oEnemy_Guru)
        instance_destroy(id);
    
    with (oLinkDeath)
        instance_destroy(id);
    
    with (oLinkRevive)
        instance_destroy(id);
    
    with (oEnemyTrap)
        instance_destroy(id);
    
    with (oGemPondWater)
        instance_destroy(id);
    
    with (oZora)
        instance_destroy(id);
    
    with (oMineCart)
        instance_destroy(id);
    
    with (oMineCartDirSwitch)
        instance_destroy(id);
    
    with (oMineCartAction)
        instance_destroy(id);
    
    with (oCoal)
        instance_destroy(id);
    
    with (oCoalLight)
        instance_destroy(id);
    
    with (oDwarfWorker)
        instance_destroy(id);
    
    with (oGemRock)
        instance_destroy(id);
    
    with (oDrawBridgeArea)
        instance_destroy(id);
    
    with (oStoreSign)
        instance_destroy(id);
    
    with (oSaveTent)
        instance_destroy(id);
    
    with (oSaveTentFire)
        instance_destroy(id);
    
    with (oTombSkeleton)
        instance_destroy(id);
    
    with (oLeaf_Inside)
        instance_destroy(id);
    
    with (oSimonFrogs)
        instance_destroy(id);
    
    Inventory_DeleteItemClass(UnknownEnum.Value_28);
    Inventory_DeleteItemClass(UnknownEnum.Value_10);
    oHUD.DrawMap = false;
    oHUD.DrawCompass = false;
    ds_grid_resize(global.NonDuplicatableItemsThatExist, 2, 0);
    Map_Clear();
    ResetUnusedPrisonerList();
    ResetUnusedShopKeeperList();
    global.TorchGroupIndex = 0;
    global.LinkDead = false;
    Dungeon_DestroyLevel();
    gc_collect();
}

function Dungeon_CreateStruct_Level(arg0) constructor
{
    Index = arg0;
    Class = Dungeon_PickClass(arg0);
    Transformation = Dungeon_PickTemplateTransformation(Index);
    DungeonTemplate_Index = Dungeon_PickTemplateIndex(Index, Class, Transformation);
    DungeonTemplate = global.Templates_Dungeon[Class][Transformation][DungeonTemplate_Index];
    RoomCount = array_length(DungeonTemplate.Rooms);
    Rooms = array_create(RoomCount);
    RoomsVisted = 0;
    RoomsVistedPercent = 0;
    RoomIndex_Entrance = 0;
    RoomIndex_Boss = -1;
    RoomIndex_BossAdjacent = -1;
    Map_RoomIndex = Array_Create2D(8, 8, -1);
    Map_Sprite_All = 0;
    Map_Sprite_Explored = 0;
    Map_Sprite_Doors_All = 0;
    Map_Sprite_Doors_Explored = 0;
    StartDir = Dungeon_StartDir(Index);
    IsBossLevel = Dungeon_IsBossLevel(Index);
    SwitchBlock_Colors = 2;
    SwitchBlock_ActiveColor = UnknownEnum.Value_0;
    MaxBonusTreasures = ceil(RoomCount / 14);
    MaxShops = ceil(RoomCount / 14);
    BonusTreasureCount = 0;
    ShopCount = 0;
    MaxNoEnemyRooms = max(2, ceil(RoomCount / 8));
    NoEnemyRoomCount = 0;
    AltarCount = 0;
    RodCharger = false;
    JailMonumentItem_DeadMale = false;
    JailMonumentItem_DeadFemale = false;
    CatacombGrave = false;
    FairyRoom = false;
    GemPondRoom = false;
    TMNTRoom = false;
    LargeTreasureRoom = false;
    Stars = Prob(0.8) && Index > UnknownEnum.Value_1;
    MinEnemiesForStars = 6 + floor(Index / 3);
    MaxRollingSpikes = irandom_range(1 + floor(Index / 6), 2 + floor(Index / 4));
    MaxGuruBars = irandom_range(1 + floor(Index / 6), 2 + floor(Index / 4));
    ShopHeartPiecesCreated = 0;
    ShopKeysCreated = 0;
    ShopLargeMagicCreated = 0;
    ShopArrowsCreated = 0;
    ShopBombsCreated = 0;
    ShopOrbsCreated = 0;
    ShopPopsCreated = 0;
    PotStyle = (Index == UnknownEnum.Value_4 || Index == UnknownEnum.Value_7 || Index == UnknownEnum.Value_11 || Index == UnknownEnum.Value_12) ? 1 : 0;
}

function Dungeon_CreateStruct_Room(arg0) constructor
{
    x = global.Level.DungeonTemplate.Rooms[arg0].x;
    y = global.Level.DungeonTemplate.Rooms[arg0].y;
    width = global.Level.DungeonTemplate.Rooms[arg0].width;
    height = global.Level.DungeonTemplate.Rooms[arg0].height;
    x2 = (x + width) - 1;
    y2 = (y + height) - 1;
    TileX = x / 8;
    TileY = y / 8;
    TileW = width / 8;
    TileH = height / 8;
    GridX = global.Level.DungeonTemplate.Rooms[arg0].GridX;
    GridY = global.Level.DungeonTemplate.Rooms[arg0].GridY;
    GridW = global.Level.DungeonTemplate.Rooms[arg0].GridW;
    GridH = global.Level.DungeonTemplate.Rooms[arg0].GridH;
    Tiles = array_create(15);
    
    for (var _TileLayerIndex = 0; _TileLayerIndex < 15; _TileLayerIndex++)
        Tiles[_TileLayerIndex] = Array_Create2D(global.Level.DungeonTemplate.Rooms[arg0].GridW * 32, global.Level.DungeonTemplate.Rooms[arg0].GridH * 32);
    
    Visited = false;
    Secret = -1;
    FairyOrGemPond = false;
    Water = false;
    Sand = false;
    Heat = false;
    ForcedTheme = -1;
    ForcedTheme_Floor = -1;
    ForcedTheme_Floor_Upper = -1;
    ForcedTheme_Floor_Lower = -1;
    Section_ID = global.Level.DungeonTemplate.Rooms[arg0].Section_ID;
    Section_WallType = global.Level.DungeonTemplate.Rooms[arg0].Section_WallType;
    SizeIndex = global.RoomSizeIndex[GridW][GridH];
    UnusedZone = -1;
    UsedSpace = [];
    SpecialObject = global.Level.DungeonTemplate.Rooms[arg0].SpecialObj;
    SpecialObject_InSection = global.Level.DungeonTemplate.Rooms[arg0].SpecialObjSection > 0;
    SpecialObject_SectionType = SpecialObject_InSection ? UnknownEnum.Value_1 : UnknownEnum.Value_0;
    StarEnemyCount = 0;
    BonusTreasure = Prob(0.72);
    ShopPriceMultiplier = random_range(1, 2);
    Switch = 
    {
        Inst: -4,
        Action: UnknownEnum.Value_0,
        HiddenObjType: UnknownEnum.Value_0,
        HiddenObjInst: -4,
        TreasureItemClass: -1
    };
    Warp_DestGridPosition = global.Level.DungeonTemplate.Rooms[arg0].Warp_DestGridPosition;
    Warp_DestRoomIndex = global.Level.DungeonTemplate.Rooms[arg0].Warp_DestRoomIndex;
    WarpDest_WarpRoomIndex = global.Level.DungeonTemplate.Rooms[arg0].WarpDest_WarpRoomIndex;
    WarpDest = WarpDest_WarpRoomIndex != -1;
    WarpDest_Created = false;
    WarpDest_X = 0;
    WarpDest_Y = 0;
    RoomSongIndex = global.Music_LevelSongIndex[global.Level.Index];
    DoorCode = 0;
    DoorCount = array_length(struct_get_from_hash(array_get(global.Level.DungeonTemplate.Rooms, arg0), variable_get_hash("Doors")));
    Doors = array_create(DoorCount);
    UpperDoors = false;
    LowerDoors = false;
    
    for (var _DoorIndex = 0; _DoorIndex < DoorCount; _DoorIndex++)
    {
        Doors[_DoorIndex] = new Dungeon_CreateStruct_Door();
        Doors[_DoorIndex].Position = global.Level.DungeonTemplate.Rooms[arg0].Doors[_DoorIndex].Position;
        Doors[_DoorIndex].Location = global.Level.DungeonTemplate.Rooms[arg0].Doors[_DoorIndex].Location;
        Doors[_DoorIndex].ConnectedRoomIndex = global.Level.DungeonTemplate.Rooms[arg0].Doors[_DoorIndex].ConnectedRoomIndex;
        
        if (SpecialObject == UnknownEnum.Value_6 && Doors[_DoorIndex].ConnectedRoomIndex != global.Level.RoomIndex_BossAdjacent)
            Doors[_DoorIndex].ConnectedRoomIndex = -1;
        
        Doors[_DoorIndex].x = global.Level.DungeonTemplate.Rooms[arg0].Doors[_DoorIndex].x;
        Doors[_DoorIndex].y = global.Level.DungeonTemplate.Rooms[arg0].Doors[_DoorIndex].y;
        Doors[_DoorIndex].Level = RoomTemplates_GetDoorLevel(Doors[_DoorIndex].x, Doors[_DoorIndex].y);
        
        if (Doors[_DoorIndex].Level == 1)
            UpperDoors = true;
        
        if (Doors[_DoorIndex].Level == 0)
            LowerDoors = true;
        
        Doors[_DoorIndex].Status = global.Level.DungeonTemplate.Rooms[arg0].Doors[_DoorIndex].Status;
        
        switch (Doors[_DoorIndex].Status)
        {
            case UnknownEnum.Value_3:
                global.Level.RoomIndex_Entrance = arg0;
                break;
            
            case UnknownEnum.Value_4:
                global.Level.RoomIndex_BossAdjacent = arg0;
                break;
        }
    }
    
    Lighting = false;
    Lights_Pos = array_create(144);
    Lights_RGB = array_create(144);
    Lights_RGBOld = array_create(144);
    Lights_UnusedIndexes = [];
    Lights_LastIndex = -1;
    Obstacle = -1;
    Template = -1;
    TemplateClass = -1;
    TemplateSubClass = -1;
    TemplateIndex = 0;
    TemplateName = "";
    MapSpr = 0;
    MapSpr_Visited = 0;
    MapSpr_Doors = 0;
    MapX = GridX * 32;
    MapY = GridY * 32;
    MapW = GridW * 32;
    MapH = GridH * 32;
    TemplateObjGrid = 
    {
        WallsUpper: Array_Create2D(MapW, MapH, false),
        OutOfBounds: Array_Create2D(MapW, MapH, false),
        ExtraCeilings: Array_Create2D(MapW, MapH, false)
    };
    
    switch (global.Level.Index)
    {
        case UnknownEnum.Value_0:
            TemplateClass = UnknownEnum.Value_9;
            TemplateSubClass = UnknownEnum.Value_1;
            break;
        
        case UnknownEnum.Value_6:
            if (arg0 >= 0 && arg0 <= 5)
            {
                TemplateClass = UnknownEnum.Value_4;
                TemplateSubClass = UnknownEnum.Value_0;
            }
            
            if (GridX == 0 && GridY == 0)
            {
                TemplateClass = UnknownEnum.Value_4;
                TemplateSubClass = UnknownEnum.Value_2;
                TemplateName = "0";
            }
            
            if (GridX == 2 && GridY == 0)
            {
                TemplateClass = UnknownEnum.Value_4;
                TemplateSubClass = UnknownEnum.Value_2;
                TemplateName = "1";
            }
            
            if (GridX == 2 && GridY == 1)
            {
                TemplateClass = UnknownEnum.Value_4;
                TemplateSubClass = UnknownEnum.Value_2;
                TemplateName = "2";
            }
            
            if (GridX == 0 && GridY == 2)
            {
                TemplateClass = UnknownEnum.Value_4;
                TemplateSubClass = UnknownEnum.Value_2;
                TemplateName = "3";
            }
            
            if (GridX == 0 && GridY == 4)
            {
                TemplateClass = UnknownEnum.Value_4;
                TemplateSubClass = UnknownEnum.Value_2;
                TemplateName = "4";
            }
            
            if (GridX == 7 && GridY == 2)
            {
                TemplateClass = UnknownEnum.Value_4;
                TemplateSubClass = UnknownEnum.Value_3;
                TemplateName = "Exit";
            }
            
            break;
        
        case UnknownEnum.Value_10:
            if (global.MainTemplates_Mine[GridY][GridX] != -1)
            {
                TemplateClass = UnknownEnum.Value_5;
                TemplateSubClass = UnknownEnum.Value_0;
            }
            
            break;
        
        case UnknownEnum.Value_13:
            TemplateClass = UnknownEnum.Value_9;
            TemplateSubClass = UnknownEnum.Value_2;
            
            if (GridX == 3 && GridY == 4)
                TemplateName = "FinalBossHall";
            
            if (GridX == 3 && GridY == 3)
                TemplateName = "FinalBoss";
            
            break;
    }
    
    if (global.SaveLevel)
    {
        TemplateClass = UnknownEnum.Value_9;
        TemplateSubClass = UnknownEnum.Value_3;
    }
    
    switch (SpecialObject)
    {
        case UnknownEnum.Value_5:
            if (global.Level.Index == UnknownEnum.Value_6 && GridX == 3 && GridY == 0)
            {
                TemplateClass = UnknownEnum.Value_9;
                TemplateSubClass = UnknownEnum.Value_2;
                TemplateName = "TreasureRoom";
                break;
            }
            
            if (global.Level.Index == UnknownEnum.Value_10 && GridX == 3 && GridY == 0)
            {
                TemplateClass = UnknownEnum.Value_9;
                TemplateSubClass = UnknownEnum.Value_2;
                TemplateName = "WishRoom";
                break;
            }
            
            TemplateClass = UnknownEnum.Value_8;
            break;
        
        case UnknownEnum.Value_8:
        case UnknownEnum.Value_9:
            TemplateClass = UnknownEnum.Value_3;
            TemplateSubClass = global.RoomSizeIndex[GridW][GridH];
            break;
        
        case UnknownEnum.Value_7:
            switch (global.Level.Index)
            {
                case UnknownEnum.Value_6:
                    TemplateClass = UnknownEnum.Value_4;
                    TemplateSubClass = UnknownEnum.Value_1;
                    break;
                
                case UnknownEnum.Value_10:
                    TemplateClass = UnknownEnum.Value_5;
                    TemplateSubClass = UnknownEnum.Value_1;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_6:
            TemplateClass = UnknownEnum.Value_9;
            TemplateSubClass = UnknownEnum.Value_0;
            break;
    }
    
    if (TemplateClass != -1)
        exit;
    
    if (SizeIndex == UnknownEnum.Value_0 && (Section_ID > 20 || (Section_ID > 0 && Section_ID <= 20 && Section_WallType == UnknownEnum.Value_0 && Prob(0.2))))
        TemplateClass = UnknownEnum.Value_7;
    else if (UpperDoors && !LowerDoors)
        TemplateClass = (Section_ID == 0 && SizeIndex == UnknownEnum.Value_0 && arg0 != global.Level.RoomIndex_BossAdjacent && arg0 != global.Level.RoomIndex_Entrance && Prob(0.15 + (global.Level.Index / 38))) ? UnknownEnum.Value_6 : UnknownEnum.Value_0;
    else if (!UpperDoors && LowerDoors)
        TemplateClass = UnknownEnum.Value_1;
    else if (UpperDoors && LowerDoors)
        TemplateClass = UnknownEnum.Value_2;
    
    switch (TemplateClass)
    {
        case UnknownEnum.Value_0:
        case UnknownEnum.Value_1:
            if (GridW == 1 && GridH == 1)
                TemplateSubClass = UnknownEnum.Value_0;
            else
                TemplateSubClass = UnknownEnum.Value_1;
            
            break;
        
        case UnknownEnum.Value_6:
            var _ObstacleList = ds_list_create();
            var _AllowMovingFloors = SpecialObject == UnknownEnum.Value_0 && !WarpDest;
            
            switch (global.Level.Index)
            {
                default:
                    ds_list_add(_ObstacleList, UnknownEnum.Value_1);
                    break;
                
                case UnknownEnum.Value_3:
                    ds_list_add(_ObstacleList, UnknownEnum.Value_0);
                    break;
                
                case UnknownEnum.Value_4:
                    ds_list_add(_ObstacleList, UnknownEnum.Value_0, UnknownEnum.Value_1, UnknownEnum.Value_2);
                    break;
                
                case UnknownEnum.Value_5:
                    ds_list_add(_ObstacleList, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1);
                    break;
                
                case UnknownEnum.Value_7:
                    ds_list_add(_ObstacleList, UnknownEnum.Value_0, UnknownEnum.Value_2, UnknownEnum.Value_6);
                    break;
                
                case UnknownEnum.Value_8:
                    ds_list_add(_ObstacleList, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_2, UnknownEnum.Value_2, UnknownEnum.Value_2);
                    break;
                
                case UnknownEnum.Value_9:
                    ds_list_add(_ObstacleList, UnknownEnum.Value_0, UnknownEnum.Value_1);
                    
                    if (_AllowMovingFloors)
                        ds_list_add(_ObstacleList, UnknownEnum.Value_3, UnknownEnum.Value_3, UnknownEnum.Value_3);
                    
                    break;
                
                case UnknownEnum.Value_11:
                    ds_list_add(_ObstacleList, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_2, UnknownEnum.Value_2, UnknownEnum.Value_6, UnknownEnum.Value_6, UnknownEnum.Value_6);
                    
                    if (_AllowMovingFloors)
                        ds_list_add(_ObstacleList, UnknownEnum.Value_3, UnknownEnum.Value_4, UnknownEnum.Value_5);
                    
                    break;
                
                case UnknownEnum.Value_12:
                    ds_list_add(_ObstacleList, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_1, UnknownEnum.Value_2, UnknownEnum.Value_6, UnknownEnum.Value_6);
                    
                    if (_AllowMovingFloors)
                        ds_list_add(_ObstacleList, UnknownEnum.Value_3, UnknownEnum.Value_4, UnknownEnum.Value_5);
                    
                    break;
            }
            
            ds_list_shuffle(_ObstacleList);
            Obstacle = ds_list_find_value(_ObstacleList, 0);
            ds_list_destroy(_ObstacleList);
            
            switch (Obstacle)
            {
                case UnknownEnum.Value_0:
                    TemplateSubClass = UnknownEnum.Value_0;
                    BonusTreasure = Prob(0.9);
                    break;
                
                case UnknownEnum.Value_1:
                case UnknownEnum.Value_2:
                case UnknownEnum.Value_3:
                case UnknownEnum.Value_4:
                case UnknownEnum.Value_5:
                    TemplateSubClass = UnknownEnum.Value_1;
                    break;
                
                case UnknownEnum.Value_6:
                    TemplateSubClass = choose(UnknownEnum.Value_0, UnknownEnum.Value_1, UnknownEnum.Value_2);
                    break;
            }
            
            break;
        
        default:
            TemplateSubClass = global.RoomSizeIndex[GridW][GridH];
            break;
    }
}

function Dungeon_CreateStruct_Door() constructor
{
    x = 0;
    y = 0;
    Level = 0;
    Status = UnknownEnum.Value_0;
    Position = 0;
    Location = "";
    ConnectedRoomIndex = -1;
}

function Dungeon_InitLevel(arg0)
{
    Dungeon_Clear();
    
    if (global.Continue)
    {
        Dungeon_LoadLevel();
        Map_Init();
        Dungeon_InitDoors();
        Link_SetStartingPos();
        global.Continue = false;
        exit;
    }
    else
    {
        global.Level = new Dungeon_CreateStruct_Level(arg0);
    }
    
    var _LowestBossRoomGridY = 7;
    
    for (var _RoomIndex = 0; _RoomIndex < global.Level.RoomCount; _RoomIndex++)
    {
        global.Level.Map_RoomIndex[global.Level.DungeonTemplate.Rooms[_RoomIndex].GridY][global.Level.DungeonTemplate.Rooms[_RoomIndex].GridX] = _RoomIndex;
        
        if (global.Level.DungeonTemplate.Rooms[_RoomIndex].GridW == 2)
            global.Level.Map_RoomIndex[global.Level.DungeonTemplate.Rooms[_RoomIndex].GridY][global.Level.DungeonTemplate.Rooms[_RoomIndex].GridX + 1] = _RoomIndex;
        
        if (global.Level.DungeonTemplate.Rooms[_RoomIndex].GridH == 2)
            global.Level.Map_RoomIndex[global.Level.DungeonTemplate.Rooms[_RoomIndex].GridY + 1][global.Level.DungeonTemplate.Rooms[_RoomIndex].GridX] = _RoomIndex;
        
        if (global.Level.DungeonTemplate.Rooms[_RoomIndex].GridW == 2 && global.Level.DungeonTemplate.Rooms[_RoomIndex].GridH == 2)
            global.Level.Map_RoomIndex[global.Level.DungeonTemplate.Rooms[_RoomIndex].GridY + 1][global.Level.DungeonTemplate.Rooms[_RoomIndex].GridX + 1] = _RoomIndex;
        
        global.Level.Rooms[_RoomIndex] = new Dungeon_CreateStruct_Room(_RoomIndex);
        
        for (var _DoorIndex = 0; _DoorIndex < global.Level.Rooms[_RoomIndex].DoorCount; _DoorIndex++)
        {
            var _Door = global.Level.Rooms[_RoomIndex].Doors[_DoorIndex];
            
            switch (_Door.Status)
            {
                case UnknownEnum.Value_3:
                    if ((global.Level.StartDir == 1 && _Door.Location != "Bottom") || (global.Level.StartDir == 2 && _Door.Location != "Top"))
                        _Door.Status = UnknownEnum.Value_11;
                    
                    break;
                
                case UnknownEnum.Value_4:
                    if (global.Level.IsBossLevel && _Door.Location == "Top")
                        _Door.Status = UnknownEnum.Value_0;
                    else if ((global.Level.StartDir == 1 && _Door.Location != "Top") || (global.Level.StartDir == 2 && _Door.Location != "Bottom"))
                        _Door.Status = UnknownEnum.Value_11;
                    
                    break;
            }
            
            if (_Door.Status == UnknownEnum.Value_11)
                continue;
            
            global.Level.Rooms[_RoomIndex].DoorCode = global.Level.Rooms[_RoomIndex].DoorCode | power(2, _Door.Position - 1);
        }
        
        if (global.Level.DungeonTemplate.Rooms[_RoomIndex].SpecialObj == UnknownEnum.Value_6)
        {
            if (global.Level.DungeonTemplate.Rooms[_RoomIndex].GridY <= _LowestBossRoomGridY)
            {
                _LowestBossRoomGridY = global.Level.DungeonTemplate.Rooms[_RoomIndex].GridY;
                global.Level.RoomIndex_Boss = _RoomIndex;
            }
        }
        
        if (global.Level.Index == UnknownEnum.Value_13 && global.Level.DungeonTemplate.Rooms[_RoomIndex].GridW == 1 && global.Level.DungeonTemplate.Rooms[_RoomIndex].GridH == 1)
            global.Level.RoomIndex_Boss = _RoomIndex;
    }
    
    for (var _RoomIndex = 0; _RoomIndex < global.Level.RoomCount; _RoomIndex++)
    {
        if (global.Level.Rooms[_RoomIndex].Secret != -1)
            continue;
        
        if (global.Level.Rooms[_RoomIndex].TemplateClass == UnknownEnum.Value_8)
        {
            var _DoorPos = global.Level.DungeonTemplate.Rooms[_RoomIndex].Doors[0].Position;
            
            if (global.Level.Index == UnknownEnum.Value_5 && _DoorPos == 18 && Prob(0.18))
            {
                global.Level.Rooms[_RoomIndex].TemplateClass = UnknownEnum.Value_9;
                global.Level.Rooms[_RoomIndex].TemplateSubClass = UnknownEnum.Value_2;
                global.Level.Rooms[_RoomIndex].TemplateName = "TMNT";
                global.Level.TMNTRoom = true;
            }
            else if (global.Level.Index == UnknownEnum.Value_6 && global.Level.Rooms[_RoomIndex].GridX == 6 && global.Level.Rooms[_RoomIndex].GridY == 1)
            {
                global.Level.Rooms[_RoomIndex].TemplateClass = UnknownEnum.Value_9;
                global.Level.Rooms[_RoomIndex].TemplateSubClass = UnknownEnum.Value_2;
                global.Level.Rooms[_RoomIndex].TemplateName = "Zora";
                continue;
            }
            else if (global.Level.Index == UnknownEnum.Value_10 && global.Level.Rooms[_RoomIndex].GridX == 7 && global.Level.Rooms[_RoomIndex].GridY == 1)
            {
                global.Level.Rooms[_RoomIndex].TemplateClass = UnknownEnum.Value_9;
                global.Level.Rooms[_RoomIndex].TemplateSubClass = UnknownEnum.Value_2;
                global.Level.Rooms[_RoomIndex].TemplateName = "Zora";
                continue;
            }
            else if ((!global.Level.FairyRoom || !global.Level.GemPondRoom) && global.Level.Index != UnknownEnum.Value_1 && global.Level.Index != UnknownEnum.Value_6 && global.Level.Index != UnknownEnum.Value_10 && (_DoorPos == 6 || _DoorPos == 18))
            {
                if (Prob(0.6))
                {
                    global.Level.Rooms[_RoomIndex].FairyOrGemPond = true;
                    continue;
                }
            }
            
            if (Prob(0.65) || global.Level.Index == UnknownEnum.Value_6 || global.Level.Index == UnknownEnum.Value_10 || global.Level.Rooms[_RoomIndex].TemplateName == "TMNT")
            {
                global.Level.Rooms[_RoomIndex].Secret = 1;
                
                if (global.Level.Index == UnknownEnum.Value_6 && global.Level.Rooms[_RoomIndex].GridX == 3 && global.Level.Rooms[_RoomIndex].GridY == 0)
                {
                }
                else
                {
                    global.Level.Rooms[_RoomIndex].Doors[0].Status = UnknownEnum.Value_8;
                    var _ConnectedRoomTemplateIndex = global.Level.Rooms[_RoomIndex].Doors[0].ConnectedRoomIndex;
                    var _ConnectedRoomTemplate = global.Level.DungeonTemplate.Rooms[_ConnectedRoomTemplateIndex];
                    var _ConnectedRoomTemplateRSI = global.RoomSizeIndex[_ConnectedRoomTemplate.GridW][_ConnectedRoomTemplate.GridH];
                    var _ConnectedDoorPos = Door_GetConnectedPos(global.Level.Rooms[_RoomIndex].GridX, global.Level.Rooms[_RoomIndex].GridY, global.Level.Rooms[_RoomIndex].SizeIndex, _ConnectedRoomTemplate.GridX, _ConnectedRoomTemplate.GridY, _ConnectedRoomTemplateRSI, global.Level.Rooms[_RoomIndex].Doors[0].Position);
                    var _ConnectedRoom = global.Level.Rooms[_ConnectedRoomTemplateIndex];
                    var _ConnectedRoomTemplateDoorsArray = _ConnectedRoomTemplate.Doors;
                    var ConnectedRoomTemplateDoors = array_length(_ConnectedRoomTemplateDoorsArray);
                    
                    for (var i = 0; i < ConnectedRoomTemplateDoors; i++)
                    {
                        var _ConnectedDoor = _ConnectedRoomTemplateDoorsArray[i];
                        
                        if (_ConnectedDoor.Position == _ConnectedDoorPos)
                        {
                            _ConnectedRoom.Doors[i].Status = UnknownEnum.Value_8;
                            break;
                        }
                    }
                }
            }
        }
    }
    
    global.CarpetTileBase = GetTileID(111, 4 + ((global.Level.Index - 1) * 6) + 2);
    global.CarpetTileTrim = GetTileID(110, 4 + ((global.Level.Index - 1) * 6) + 4);
    var ShuffledRoomIndexesList = ds_list_create_sequence_shuffled(0, global.Level.RoomCount - 1);
    
    for (var _RoomListIndex = 0; _RoomListIndex < global.Level.RoomCount; _RoomListIndex++)
    {
        var _RoomIndex = ds_list_find_value(ShuffledRoomIndexesList, _RoomListIndex);
        
        if (TemplateCheck(_RoomIndex, UnknownEnum.Value_9, UnknownEnum.Value_0))
        {
            if (!global.Level.IsBossLevel)
                continue;
            
            if (_RoomIndex != global.Level.RoomIndex_Boss)
                continue;
        }
        
        global.SpawnedBlocks = false;
        global.Level.Rooms[_RoomIndex].Template = RoomTemplates_Pick(_RoomIndex);
        
        if (global.Level.Rooms[_RoomIndex].Template == -1)
        {
            Error("Error: Cannot generate level", true);
            exit;
        }
        
        Map_GenerateRoomSprite(_RoomIndex);
        global.Level.Rooms[_RoomIndex].TemplateName = struct_get_from_hash(global.Level.Rooms[_RoomIndex].Template, variable_get_hash("name"));
        global.Level.Rooms[_RoomIndex].Lighting = Lighting_GetRoomStatus(_RoomIndex);
        var RoomTemplateProperties = struct_get_from_hash(global.Level.Rooms[_RoomIndex].Template, variable_get_hash("properties"));
        global.Level.Rooms[_RoomIndex].ForcedTheme = GetPropertyValue(RoomTemplateProperties, "ForceWallTheme");
        global.Level.Rooms[_RoomIndex].ForcedTheme_Floor = GetPropertyValue(RoomTemplateProperties, "ForceFloorTheme");
        global.Level.Rooms[_RoomIndex].ForcedTheme_Floor_Upper = GetPropertyValue(RoomTemplateProperties, "ForceFloorTheme_Upper");
        global.Level.Rooms[_RoomIndex].ForcedTheme_Floor_Lower = GetPropertyValue(RoomTemplateProperties, "ForceFloorTheme_Lower");
        
        if (TemplateCheck(_RoomIndex, UnknownEnum.Value_9, UnknownEnum.Value_0))
            global.Level.Rooms[_RoomIndex].RoomSongIndex = UnknownEnum.Value_19;
        
        if (TemplateCheck(_RoomIndex, UnknownEnum.Value_9, UnknownEnum.Value_2, "FinalBoss"))
            global.Level.Rooms[_RoomIndex].RoomSongIndex = UnknownEnum.Value_21;
        
        if (TemplateCheck(_RoomIndex, UnknownEnum.Value_8, UnknownEnum.Value_0))
            global.Level.Rooms[_RoomIndex].RoomSongIndex = UnknownEnum.Value_13;
        
        if (TemplateCheck(_RoomIndex, UnknownEnum.Value_9, UnknownEnum.Value_2, "WishRoom"))
            global.Level.Rooms[_RoomIndex].RoomSongIndex = UnknownEnum.Value_15;
        
        if (TemplateCheck(_RoomIndex, UnknownEnum.Value_8, UnknownEnum.Value_2) || TemplateCheck(_RoomIndex, UnknownEnum.Value_9, UnknownEnum.Value_2, "Zora"))
            global.Level.Rooms[_RoomIndex].RoomSongIndex = UnknownEnum.Value_14;
        
        if (TemplateCheck(_RoomIndex, UnknownEnum.Value_9, UnknownEnum.Value_2, "TMNT"))
            global.Level.Rooms[_RoomIndex].RoomSongIndex = UnknownEnum.Value_18;
        
        switch (global.Level.Index)
        {
            case UnknownEnum.Value_6:
                if (TemplateCheck(_RoomIndex, UnknownEnum.Value_4, UnknownEnum.Value_0) || TemplateCheck(_RoomIndex, UnknownEnum.Value_4, UnknownEnum.Value_1))
                    global.Level.Rooms[_RoomIndex].RoomSongIndex = UnknownEnum.Value_6;
                
                if (TemplateCheck(_RoomIndex, UnknownEnum.Value_4, UnknownEnum.Value_3, "Exit"))
                    global.Level.Rooms[_RoomIndex].RoomSongIndex = UnknownEnum.Value_7;
                
                if (TemplateCheck(_RoomIndex, UnknownEnum.Value_4, UnknownEnum.Value_1, "Arcade"))
                    global.Level.Rooms[_RoomIndex].RoomSongIndex = UnknownEnum.Value_10;
                
                if (TemplateCheck(_RoomIndex, UnknownEnum.Value_4, UnknownEnum.Value_1, "Store"))
                    global.Level.Rooms[_RoomIndex].RoomSongIndex = UnknownEnum.Value_8;
                
                if (TemplateCheck(_RoomIndex, UnknownEnum.Value_4, UnknownEnum.Value_1, "Pub"))
                    global.Level.Rooms[_RoomIndex].RoomSongIndex = UnknownEnum.Value_9;
                
                break;
            
            case UnknownEnum.Value_10:
                if (TemplateCheck(_RoomIndex, UnknownEnum.Value_5, UnknownEnum.Value_1, "Store"))
                    global.Level.Rooms[_RoomIndex].RoomSongIndex = UnknownEnum.Value_8;
                
                if (global.MainTemplates_Mine[global.Level.Rooms[_RoomIndex].GridY][global.Level.Rooms[_RoomIndex].GridX] == 1 || global.MainTemplates_Mine[global.Level.Rooms[_RoomIndex].GridY][global.Level.Rooms[_RoomIndex].GridX] == 5 || global.MainTemplates_Mine[global.Level.Rooms[_RoomIndex].GridY][global.Level.Rooms[_RoomIndex].GridX] >= 8)
                    global.Level.Rooms[_RoomIndex].RoomSongIndex = UnknownEnum.Value_7;
                
                break;
        }
        
        Dungeon_Draw_Floors(_RoomIndex);
        Dungeon_Draw_Walls(_RoomIndex);
        
        if (global.Level.Index != UnknownEnum.Value_0 && !TemplateCheck(_RoomIndex, UnknownEnum.Value_4, UnknownEnum.Value_0) && global.Level.Index != UnknownEnum.Value_13)
            Dungeon_Draw_Ceiling(GetTileID(8, 4 + ((global.Level.Index - 1) * 6) + 2), global.Level.Rooms[_RoomIndex].TileX, global.Level.Rooms[_RoomIndex].TileY, global.Level.Rooms[_RoomIndex].TileX, global.Level.Rooms[_RoomIndex].TileY, global.Level.Rooms[_RoomIndex].TileX + global.Level.Rooms[_RoomIndex].TileW, global.Level.Rooms[_RoomIndex].TileY + global.Level.Rooms[_RoomIndex].TileH);
        
        Dungeon_Draw_ExtraCeilings(_RoomIndex);
        Dungeon_CreateDoors(_RoomIndex);
        Dungeon_Draw_Carpets(_RoomIndex);
        Dungeon_Draw_CarpetsFull(_RoomIndex);
        Dungeon_Draw_Pit(_RoomIndex);
        Dungeon_Draw_Holes(_RoomIndex);
        global.SpawnedWater = false;
        Dungeon_Draw_Water(_RoomIndex);
        Dungeon_Draw_Stairs(_RoomIndex);
        global.SpawnedMovingFloors = false;
        Dungeon_Draw_FloorObjs(_RoomIndex);
        global.Switch_Add = false;
        global.Switch_Spawned = false;
        Dungeon_Draw_SpecialObjs_Forced(_RoomIndex);
        SpawnBoss(_RoomIndex);
        var SpawnedSpecialObs = Dungeon_Draw_SpecialObjs(_RoomIndex);
        
        if (1 && !SpawnedSpecialObs)
        {
            var ObjsToDestroyList = ds_list_create();
            ds_list_add(ObjsToDestroyList, oWall, oDoor, oSwitch, oSwitchBlock, oMovingFloor, oWarp, oShop, oPrisoner, oItem, oPickupObj, oEnemy, oDeadHungryGuy, oHeartGuy, oTombSkeleton);
            var ObjsToDestroy = ds_list_size(ObjsToDestroyList);
            var ObjCollisionList = ds_list_create();
            
            for (var i = 0; i < ObjsToDestroy; i++)
            {
                ds_list_clear(ObjCollisionList);
                var _Obj = ds_list_find_value(ObjsToDestroyList, i);
                var _Objs = collision_rectangle_list(global.Level.Rooms[_RoomIndex].x + 0.5, global.Level.Rooms[_RoomIndex].y + 0.5, (global.Level.Rooms[_RoomIndex].x + (global.Level.Rooms[_RoomIndex].GridW * 256)) - 1, (global.Level.Rooms[_RoomIndex].y + (global.Level.Rooms[_RoomIndex].GridH * 256)) - 1, _Obj, false, true, ObjCollisionList, false);
                
                for (var j = 0; j < _Objs; j++)
                    instance_destroy(ds_list_find_value(ObjCollisionList, j));
            }
            
            ds_list_destroy(ObjCollisionList);
            ds_list_destroy(ObjsToDestroyList);
            
            for (var i = 0; i < array_length(global.TMID); i++)
                ClearTileBlock(global.TMID[i], global.Level.Rooms[_RoomIndex].x, global.Level.Rooms[_RoomIndex].y, global.Level.Rooms[_RoomIndex].TileW, global.Level.Rooms[_RoomIndex].TileH);
            
            _RoomListIndex--;
            global.Level.Rooms[_RoomIndex].UsedSpace = [];
            global.Level.Rooms[_RoomIndex].RoomTemplate = undefined;
        }
        else
        {
            Dungeon_Draw_WallDecor(_RoomIndex);
            
            if (global.Level.Index == UnknownEnum.Value_13)
            {
                switch (_RoomIndex)
                {
                    case 0:
                        instance_create_layer(global.Level.Rooms[_RoomIndex].x + 93, global.Level.Rooms[_RoomIndex].y + 60, "Objs_Upper", oFinalBossGate);
                        instance_create_layer(global.Level.Rooms[_RoomIndex].x, global.Level.Rooms[_RoomIndex].y, "ObjsFloor_Upper", oCrystalEnd);
                        DrawTileBlock(global.TMID_Decor_Upper, global.Level.Rooms[_RoomIndex].x + 88, global.Level.Rooms[_RoomIndex].y + 16, 74, 0, 3, 4);
                        DrawTileBlock(global.TMID_Decor_Upper, global.Level.Rooms[_RoomIndex].x + 144, global.Level.Rooms[_RoomIndex].y + 16, 77, 0, 3, 4);
                        break;
                    
                    case 1:
                        DrawTileBlock(global.TMID_Decor_Upper, global.Level.Rooms[_RoomIndex].x + 88, global.Level.Rooms[_RoomIndex].y + 208, 80, 0, 3, 4);
                        DrawTileBlock(global.TMID_Decor_Upper, global.Level.Rooms[_RoomIndex].x + 144, global.Level.Rooms[_RoomIndex].y + 208, 83, 0, 3, 4);
                        var VarStruct = 
                        {
                            FloorLevel: 1,
                            ItemHolding: -1,
                            SectionID: 0,
                            RoomIndex: _RoomIndex
                        };
                        instance_create_layer(global.Level.Rooms[_RoomIndex].x + 128, global.Level.Rooms[_RoomIndex].y + 74, "ObjsHigher_Upper", oBoss_Aghanim, VarStruct);
                        break;
                }
                
                instance_create_layer(global.Level.Rooms[_RoomIndex].x, global.Level.Rooms[_RoomIndex].y, "Starfield", oStarfield, 
                {
                    RoomH: global.Level.Rooms[_RoomIndex].height
                });
                layer_set_visible(global.LayerID_Starfield, true);
            }
        }
    }
    
    Map_Init();
    Dungeon_InitDoors();
    ds_list_destroy(ShuffledRoomIndexesList);
    Link_SetStartingPos();
    
    switch (global.Level.Index)
    {
        case UnknownEnum.Value_0:
            instance_create_layer(-100, -100, "System", oIntro);
            break;
        
        case UnknownEnum.Value_1:
            if (audio_is_playing(global.RainSound))
                audio_sound_gain(global.RainSound, 0.3, 200);
            
            global.StatsToAdd[UnknownEnum.Value_0]++;
            oRender.FadeIn();
            break;
    }
    
    input_clear_momentary(true);
    
    if (global.Level.Index > UnknownEnum.Value_0)
        Music_Play(global.Music_LevelSongIndex[global.Level.Index]);
}

function Dungeon_InitSaveLevel(arg0)
{
    Dungeon_Clear();
    global.Level = new Dungeon_CreateStruct_Level(arg0);
    var _RoomIndex = 0;
    var _DungeonRoom = array_get(struct_get_from_hash(global.Level.DungeonTemplate, variable_get_hash("Rooms")), _RoomIndex);
    global.Level.Map_RoomIndex[_DungeonRoom.GridY][_DungeonRoom.GridX] = 0;
    global.Level.Rooms[_RoomIndex] = new Dungeon_CreateStruct_Room(_RoomIndex);
    global.Level.Rooms[_RoomIndex].Template = RoomTemplates_Pick(_RoomIndex);
    global.Level.Rooms[_RoomIndex].TemplateName = struct_get_from_hash(global.Level.Rooms[_RoomIndex].Template, variable_get_hash("name"));
    global.Level.Rooms[_RoomIndex].Lighting = Lighting_GetRoomStatus(_RoomIndex);
    Map_GenerateRoomSprite(_RoomIndex);
    Dungeon_Draw_Floors(_RoomIndex);
    Dungeon_Draw_Walls(_RoomIndex);
    Dungeon_Draw_Ceiling(GetTileID(8, 4 + ((global.Level.Index - 1) * 6) + 2), global.Level.Rooms[_RoomIndex].TileX, global.Level.Rooms[_RoomIndex].TileY, global.Level.Rooms[_RoomIndex].TileX, global.Level.Rooms[_RoomIndex].TileY, global.Level.Rooms[_RoomIndex].TileX + global.Level.Rooms[_RoomIndex].TileW, global.Level.Rooms[_RoomIndex].TileY + global.Level.Rooms[_RoomIndex].TileH);
    Dungeon_Draw_ExtraCeilings(_RoomIndex);
    Dungeon_CreateDoors(_RoomIndex);
    Dungeon_Draw_SpecialObjs_Forced(_RoomIndex);
    Map_Init();
    Dungeon_InitDoors();
    Link_SetStartingPos();
    input_clear_momentary(true);
}

function Dungeon_LoadTemplates()
{
    var _TemplateBuffer = buffer_load("data\\data_d");
    var Templates_Dungeon_Temp = json_parse(buffer_read(_TemplateBuffer, buffer_string));
    buffer_delete(_TemplateBuffer);
    global.Templates_Dungeon = array_create(7);
    
    for (var _ClassType = 0; _ClassType < 7; _ClassType++)
    {
        if (_ClassType != UnknownEnum.Value_6)
            global.Templates_Dungeon[_ClassType] = array_create(8);
        
        global.Templates_Dungeon[_ClassType][UnknownEnum.Value_0] = StructCopy(Templates_Dungeon_Temp[_ClassType]);
        
        if (_ClassType == UnknownEnum.Value_6)
            continue;
        
        var _DungeonCount = array_length(global.Templates_Dungeon[_ClassType][UnknownEnum.Value_0]);
        
        for (var _TransformType = 1; _TransformType < 8; _TransformType++)
        {
            for (var _DungeonIndex = 0; _DungeonIndex < _DungeonCount; _DungeonIndex++)
            {
                global.Templates_Dungeon[_ClassType][_TransformType][_DungeonIndex] = StructCopy(Templates_Dungeon_Temp[_ClassType][_DungeonIndex]);
                var _Dungeon = global.Templates_Dungeon[_ClassType][_TransformType][_DungeonIndex];
                var _RoomArray = struct_get_from_hash(_Dungeon, variable_get_hash("Rooms"));
                var _Rooms = array_length(_RoomArray);
                
                for (var _RoomIndex = 0; _RoomIndex < _Rooms; _RoomIndex++)
                {
                    var _Room = _RoomArray[_RoomIndex];
                    var NewData = GetTransformedDungeonGrid(_Room.GridX, _Room.GridY, _Room.GridW, _Room.GridH, _TransformType);
                    _Room.GridX = NewData[0];
                    _Room.GridY = NewData[1];
                    _Room.GridW = NewData[2];
                    _Room.GridH = NewData[3];
                    _Room.x = _Room.GridX * 256;
                    _Room.y = _Room.GridY * 256;
                    _Room.width = _Room.GridW * 256;
                    _Room.height = _Room.GridH * 256;
                    var _RoomSizeIndex = global.RoomSizeIndex[_Room.GridW][_Room.GridH];
                    var _DoorArray = _Room.Doors;
                    var _Doors = array_length(_DoorArray);
                    
                    for (var _DoorIndex = 0; _DoorIndex < _Doors; _DoorIndex++)
                    {
                        var _Door = _DoorArray[_DoorIndex];
                        _Door.Position = GetTransformedDoorPosition(_Door.Position, _TransformType);
                        _Door.ConnectedDoorPos = GetTransformedDoorPosition(_Door.ConnectedDoorPos, _TransformType);
                        _Door.x = global.DoorCoordinates[_RoomSizeIndex][_Door.Position].x;
                        _Door.y = global.DoorCoordinates[_RoomSizeIndex][_Door.Position].y;
                        _Door.Location = GetTransformedDoorLocation(_Door.Location, _TransformType);
                        
                        if (_Door.Status == UnknownEnum.Value_3)
                            _Dungeon.EntranceRoomIndex = _RoomIndex;
                    }
                    
                    if (struct_get_from_hash(_Room, variable_get_hash("Section_ID")) > 0)
                        _Room.Section_ID = GetTransformedSectionID(struct_get_from_hash(_Room, variable_get_hash("Section_ID")), _TransformType);
                }
            }
        }
    }
    
    Templates_Dungeon_Temp = 0;
    gc_collect();
}

function Dungeon_DestroyLevel()
{
    if (is_struct(global.Level))
    {
        for (var _RoomIndex = 0; _RoomIndex < global.Level.RoomCount; _RoomIndex++)
        {
            var _Room = global.Level.Rooms[_RoomIndex];
            var _DoorCount = array_length(_Room.Doors);
            
            for (var _DoorIndex = 0; _DoorIndex < _DoorCount; _DoorIndex++)
                _Room.Doors[_DoorIndex] = undefined;
            
            _Room.Template = undefined;
            _Room = undefined;
        }
        
        global.Level.SaveData = undefined;
        global.Level = undefined;
    }
    
    global.Level = 0;
}

function Dungeon_RoomActivate(arg0)
{
    instance_activate_region(global.Level.Rooms[arg0].x + 0.25, global.Level.Rooms[arg0].y + 0.25, global.Level.Rooms[arg0].width - 0.5, global.Level.Rooms[arg0].height - 0.5, true);
}

function Dungeon_RoomDeActivate(arg0)
{
    Dungeon_DestroyUnimportantObjs();
    instance_deactivate_region(global.Level.Rooms[arg0].x + 0.25, global.Level.Rooms[arg0].y + 0.25, global.Level.Rooms[arg0].width - 0.5, global.Level.Rooms[arg0].height - 0.5, true, true);
    instance_activate_object(oSwitchBlock);
    instance_activate_object(oStarfield);
    
    if (instance_exists(oLink))
    {
        if (oLink.ItemHolding != -4)
            instance_activate_object(oLink.ItemHolding);
    }
}

function Dungeon_DestroyUnimportantObjs(arg0 = -1)
{
    var _ObjArray = [oProjectile, oEffects, oPickupObj];
    
    for (var i = 0; i < array_length(_ObjArray); i++)
    {
        var _Obj = _ObjArray[i];
        
        with (_Obj)
        {
            if (id == oLink.ItemHolding)
                continue;
            
            if (arg0 != -1 && RoomIndex != arg0)
                continue;
            
            if (_ObjArray[i] == oPickupObj)
            {
                switch (object_index)
                {
                    case oBush:
                    case oPot:
                        if (State == UnknownEnum.Value_0)
                            continue;
                        
                        break;
                    
                    case oWishStone:
                        z = 0;
                        ObjSetY(y_base);
                        PickupObj_ResetToItem(oItem_WishStone);
                        break;
                    
                    case oGem:
                        z = 0;
                        ObjSetY(y_base);
                        PickupObj_ResetToItem(oItem_Gem);
                        break;
                }
            }
            
            instance_destroy(id);
        }
    }
    
    with (oEnemy)
    {
        if (arg0 != -1 && RoomIndex != arg0)
            continue;
        
        if (State == UnknownEnum.Value_16)
        {
            Enemy_Destroy();
            
            if (ItemHolding != -1)
                Enemy_DestroySpawnItem(ItemHolding, Size, UnknownEnum.Value_0, false);
        }
    }
}

function Dungeon_IsBossLevel(arg0)
{
    if (global.SaveLevel)
        return false;
    
    return arg0 == UnknownEnum.Value_3 || arg0 == UnknownEnum.Value_7 || arg0 == UnknownEnum.Value_11 || arg0 == UnknownEnum.Value_13;
}

function Dungeon_StartDir(arg0)
{
    if (global.SaveLevel)
        return 2;
    
    return ((arg0 % 2) == 1 || arg0 == UnknownEnum.Value_0) ? 1 : 2;
}

function Dungeon_GetRoomIndex(arg0, arg1)
{
    arg0 = clamp(arg0, 0, 2047);
    arg1 = clamp(arg1, 0, 2047);
    return global.Level.Map_RoomIndex[floor(arg1 / 256)][floor(arg0 / 256)];
}

function Dungeon_PickClass(arg0)
{
    if (global.SaveLevel)
        return UnknownEnum.Value_6;
    
    switch (arg0)
    {
        case UnknownEnum.Value_1:
            return UnknownEnum.Value_0;
        
        case UnknownEnum.Value_2:
            return UnknownEnum.Value_1;
        
        case UnknownEnum.Value_3:
            return UnknownEnum.Value_2;
        
        case UnknownEnum.Value_4:
        case UnknownEnum.Value_5:
            return UnknownEnum.Value_3;
        
        case UnknownEnum.Value_7:
        case UnknownEnum.Value_8:
        case UnknownEnum.Value_9:
        case UnknownEnum.Value_11:
            return UnknownEnum.Value_4;
        
        case UnknownEnum.Value_12:
            return UnknownEnum.Value_5;
        
        case UnknownEnum.Value_0:
        case UnknownEnum.Value_6:
        case UnknownEnum.Value_10:
        case UnknownEnum.Value_13:
            return UnknownEnum.Value_6;
    }
}

function Dungeon_PickTemplateIndex(arg0, arg1, arg2)
{
    if (arg1 == UnknownEnum.Value_6)
    {
        if (global.SaveLevel)
            return 4;
        
        switch (arg0)
        {
            case UnknownEnum.Value_0:
                return 0;
            
            case UnknownEnum.Value_13:
                return 1;
            
            case UnknownEnum.Value_6:
                return 2;
            
            case UnknownEnum.Value_10:
                return 3;
        }
    }
    
    var _Templates = array_length(global.Templates_Dungeon[arg1][0]);
    var _Seq = global.Users[global.UserIndex].DungeonSeq[arg1];
    var _SeqLen = array_length(_Seq);
    
    if (_Templates < _SeqLen)
    {
        for (var i = 0; i < array_length(_Seq); i++)
        {
            if (_Seq[i] >= _Templates)
            {
                array_delete(_Seq, i, 1);
                
                if (i < global.Users[global.UserIndex].DungeonSeqIndex[arg1])
                    global.Users[global.UserIndex].DungeonSeqIndex[arg1]--;
                
                i--;
            }
        }
        
        _SeqLen = array_length(_Seq);
    }
    else if (_Templates > _SeqLen)
    {
        var _Diff = _Templates - _SeqLen;
        
        for (var i = 0; i < _Diff; i++)
            array_insert(_Seq, global.Users[global.UserIndex].DungeonSeqIndex[arg1] + i, (_Templates - _Diff) + i);
        
        _SeqLen = array_length(_Seq);
    }
    
    if (global.Users[global.UserIndex].DungeonSeqIndex[arg1] >= _SeqLen)
    {
        DungeonSeq_Randomize(arg1);
        global.Users[global.UserIndex].DungeonSeqIndex[arg1] = 0;
    }
    
    var _SeqIndex = global.Users[global.UserIndex].DungeonSeqIndex[arg1];
    var _TemplateIndex = _Seq[_SeqIndex];
    global.Users[global.UserIndex].DungeonSeqIndex[arg1]++;
    User_Save();
    return _TemplateIndex;
}

function Dungeon_PickTemplateTransformation(arg0)
{
    if (global.SaveLevel)
        return UnknownEnum.Value_0;
    
    switch (arg0)
    {
        case UnknownEnum.Value_0:
        case UnknownEnum.Value_6:
        case UnknownEnum.Value_10:
        case UnknownEnum.Value_13:
            return UnknownEnum.Value_0;
        
        default:
            var _StartDir = Dungeon_StartDir(arg0);
            
            if (_StartDir == 1)
            {
                return choose(UnknownEnum.Value_0, UnknownEnum.Value_1, UnknownEnum.Value_4, UnknownEnum.Value_5, UnknownEnum.Value_6, UnknownEnum.Value_7);
                break;
            }
            
            return choose(UnknownEnum.Value_2, UnknownEnum.Value_3, UnknownEnum.Value_4, UnknownEnum.Value_5, UnknownEnum.Value_6, UnknownEnum.Value_7);
    }
}

function Dungeon_IsSaveLevel(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_4:
        case UnknownEnum.Value_6:
        case UnknownEnum.Value_8:
        case UnknownEnum.Value_10:
        case UnknownEnum.Value_12:
            return true;
    }
    
    return false;
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
    Value_13,
    Value_14,
    Value_15,
    Value_16,
    Value_18 = 18,
    Value_19,
    Value_21 = 21,
    Value_28 = 28
}
