## Initialization
```gml
function INIT()
{
    math_set_epsilon(0.000001);
    randomize();
    Data_InitGlobals();
    Dungeon_LoadTemplates();
    RoomTemplates_Load();
    Items_InitData();
    Inventory_InitData();
    Enemies_InitData();
    RupeePatterns_Init();
    PixelRender_Init();
    Music_InitData();
}
```

Template loading, change needed because of memory spikes.

## New Game - oGame_Create
```gml
global.Paused = false;
global.MenuInst = -4;
global.LinkDead = false;
global.FinalBoss = false;
global.GameBeaten = false;
global.Swordless = false;
global.ShopkeeperJustin = false;
User_UpdateMusicSFX();
Time_PlayingStart();
Time_PauseStart();

if (global.Continue)
{
    global.SaveLevel = true;
    User_LoadGame();
    Dungeon_InitSaveLevel(global.ContinueLevel);
    oRender.FadeIn();
}
else
{
    Dungeon_InitLevel(UnknownEnum.Value_0);
}

User_DelSaveData();
Time_PauseEnd();

enum UnknownEnum
{
    Value_0
}
```

DungeonInitLevel gets called with arg for Entrance.

## DungeonInitLevel
```gml
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
```

This function is where the game speed slows to a crawl. Render FPS is fine but logic stalls to a point where the game is unplayable.
