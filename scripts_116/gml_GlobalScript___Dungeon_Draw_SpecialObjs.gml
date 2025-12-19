global.SpikeTileID[0] = GetTileID(20, 0);
global.SpikeTileID[1] = GetTileID(20, 1);
global.TemplateObjsThatCanRotate = ds_list_create();
ds_list_add(global.TemplateObjsThatCanRotate, "PotTreasures", "Kinstones", "Altars", "Jails");
global.SpecialObjTemplateType = array_create(9);
global.SpecialObjTemplateType[UnknownEnum.Value_0][0] = "Pots";
global.SpecialObjTemplateType[UnknownEnum.Value_1][0] = "Treasures";
global.SpecialObjTemplateType[UnknownEnum.Value_1][1] = "PotTreasures";
global.SpecialObjTemplateType[UnknownEnum.Value_2][0] = "Crystals";
global.SpecialObjTemplateType[UnknownEnum.Value_3][0] = "Torches";
global.SpecialObjTemplateType[UnknownEnum.Value_4][0] = "Treasures";
global.SpecialObjTemplateType[UnknownEnum.Value_4][1] = "PotTreasures";
global.SpecialObjTemplateType[UnknownEnum.Value_5][0] = "PotTreasures";
global.SpecialObjTemplateType[UnknownEnum.Value_6][0] = "Crystals";
global.SpecialObjTemplateType[UnknownEnum.Value_7][0] = "Crystals";
global.SpecialObjTemplateType[UnknownEnum.Value_8][0] = "Crystals";

function Dungeon_Draw_SpecialObjs(arg0)
{
    if (global.Level.Index == UnknownEnum.Value_13)
        return true;
    
    global.UsedObjs = ds_list_create();
    global.AltarData = {};
    global.SpawnedPots = false;
    global.SpawnedTreasure = false;
    global.SpawnedCrystal = false;
    global.SpawnedMonument = false;
    global.SpawnedMonumentSpecialObj = false;
    global.SpawnedKinstone = false;
    global.SpawnedAltar = false;
    global.SpawnedShop = false;
    global.SpawnedGemPond = false;
    global.SpawnedJail = false;
    global.SpawnedTorches = false;
    global.SpawnedRollingSpikes = false;
    global.SpawnedMovingSpikeBlocks = false;
    global.SpawnedGuruBar = false;
    global.SpawnedEnemies = false;
    global.Switch_Add = false;
    global.Switch_Spawned = false;
    global.SpawnedStarInst = -4;
    global.SpawnedEnemyCountForStar = 0;
    global.PotGroupAmount = 2;
    global.PotSpawnedGroup = false;
    global.EnemyHasSpecialItem = false;
    SpawnSwitchBlocks(arg0);
    
    if (global.Level.IsBossLevel && arg0 == global.Level.RoomIndex_BossAdjacent)
        return true;
    
    if (global.Level.Index == UnknownEnum.Value_3)
    {
        if (Prob(0.8))
            global.SpawnedJail = SpawnJail(arg0, global.Level.Rooms[arg0].UnusedZone);
    }
    
    if (arg0 != global.Level.RoomIndex_Entrance && global.Level.Rooms[arg0].Section_ID == 0 && global.Level.Rooms[arg0].SpecialObject == UnknownEnum.Value_0 && global.Level.Rooms[arg0].UnusedZone == -1 && !global.Level.Rooms[arg0].WarpDest)
        global.SpawnedRollingSpikes = SpawnRollingSpikes(arg0);
    
    if (global.Level.Index == UnknownEnum.Value_1 && arg0 == global.Level.RoomIndex_Entrance)
        global.SpawnedMonument = SpawnMonuments(arg0, false, global.Level.Rooms[arg0].UnusedZone);
    
    switch (global.Level.Rooms[arg0].SpecialObject)
    {
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_9:
            var SpawnMethodList_Key = ds_list_create();
            ds_list_add(SpawnMethodList_Key, UnknownEnum.Value_0, UnknownEnum.Value_1, UnknownEnum.Value_5, UnknownEnum.Value_6);
            
            if (global.Level.Index > UnknownEnum.Value_1)
            {
                if (global.Level.Rooms[arg0].Section_ID == 0 && !(global.Level.Rooms[arg0].SizeIndex == UnknownEnum.Value_0 && global.Level.Rooms[arg0].LowerDoors))
                    ds_list_add(SpawnMethodList_Key, UnknownEnum.Value_3);
            }
            
            ds_list_shuffle(SpawnMethodList_Key);
            var _KeySpawned = false;
            
            while (!_KeySpawned && ds_list_size(SpawnMethodList_Key) > 0)
            {
                var KeySpawnMethod = ds_list_find_value(SpawnMethodList_Key, 0);
                
                switch (KeySpawnMethod)
                {
                    case UnknownEnum.Value_0:
                        global.SpawnedPots = SpawnPots(arg0, global.Level.Rooms[arg0].SpecialObject_InSection, UnknownEnum.Value_20);
                        _KeySpawned = global.SpawnedPots;
                        break;
                    
                    case UnknownEnum.Value_1:
                        global.SpawnedTreasure = SpawnObj(arg0, UnknownEnum.Value_1, global.Level.Rooms[arg0].SpecialObject_InSection, global.Level.Rooms[arg0].UnusedZone, UnknownEnum.Value_20);
                        _KeySpawned = global.SpawnedTreasure;
                        break;
                    
                    case UnknownEnum.Value_2:
                        global.Switch_Spawned = SpawnSwitch(arg0, UnknownEnum.Value_2, UnknownEnum.Value_1, global.Level.Rooms[arg0].SpecialObject_InSection, UnknownEnum.Value_20);
                        _KeySpawned = global.Switch_Spawned == UnknownEnum.Value_1;
                        break;
                    
                    case UnknownEnum.Value_3:
                        global.SpawnedEnemies = SpawnEnemies(arg0, UnknownEnum.Value_20);
                        _KeySpawned = global.SpawnedEnemies && global.EnemyHasSpecialItem;
                        break;
                    
                    case UnknownEnum.Value_5:
                        global.SpawnedMonument = SpawnMonuments(arg0, global.Level.Rooms[arg0].SpecialObject_InSection, global.Level.Rooms[arg0].UnusedZone, UnknownEnum.Value_20);
                        _KeySpawned = global.SpawnedMonument && global.SpawnedMonumentSpecialObj;
                        break;
                    
                    case UnknownEnum.Value_6:
                        global.SpawnedAltar = SpawnAltar(arg0, global.Level.Rooms[arg0].SpecialObject_InSection, global.Level.Rooms[arg0].UnusedZone, UnknownEnum.Value_20);
                        _KeySpawned = global.SpawnedAltar;
                        break;
                }
                
                ds_list_delete(SpawnMethodList_Key, 0);
            }
            
            ds_list_destroy(SpawnMethodList_Key);
            
            if (!_KeySpawned)
                return false;
            
            break;
        
        case UnknownEnum.Value_2:
        case UnknownEnum.Value_4:
            var SpawnMethodList_Obj = ds_list_create();
            ds_list_add(SpawnMethodList_Obj, UnknownEnum.Value_0, UnknownEnum.Value_0, UnknownEnum.Value_2);
            ds_list_shuffle(SpawnMethodList_Obj);
            var _ObjSpawned = false;
            
            while (!_ObjSpawned && ds_list_size(SpawnMethodList_Obj) > 0)
            {
                var _ObjSpawnMethod = ds_list_find_value(SpawnMethodList_Obj, 0);
                
                switch (_ObjSpawnMethod)
                {
                    case UnknownEnum.Value_0:
                        switch (global.Level.Rooms[arg0].SpecialObject)
                        {
                            case UnknownEnum.Value_2:
                                global.SpawnedCrystal = SpawnObj(arg0, UnknownEnum.Value_2, global.Level.Rooms[arg0].SpecialObject_InSection, -1, -1);
                                _ObjSpawned = global.SpawnedCrystal;
                                break;
                            
                            case UnknownEnum.Value_4:
                                global.SpawnedWarp = SpawnWarp(arg0);
                                _ObjSpawned = global.SpawnedWarp;
                                break;
                        }
                        
                        break;
                    
                    case UnknownEnum.Value_1:
                        var _ObjType;
                        
                        switch (global.Level.Rooms[arg0].SpecialObject)
                        {
                            case UnknownEnum.Value_2:
                                _ObjType = UnknownEnum.Value_2;
                                break;
                            
                            case UnknownEnum.Value_4:
                                _ObjType = UnknownEnum.Value_3;
                                break;
                        }
                        
                        global.Switch_Spawned = SpawnSwitch(arg0, UnknownEnum.Value_2, _ObjType, global.Level.Rooms[arg0].SpecialObject_InSection, -1);
                        _ObjSpawned = global.Switch_Spawned;
                        break;
                    
                    case UnknownEnum.Value_2:
                        var _ItemClass = (global.Level.Rooms[arg0].SpecialObject == UnknownEnum.Value_2) ? UnknownEnum.Value_11 : UnknownEnum.Value_47;
                        global.SpawnedMonument = SpawnMonuments(arg0, global.Level.Rooms[arg0].SpecialObject_InSection, global.Level.Rooms[arg0].UnusedZone, _ItemClass);
                        _ObjSpawned = global.SpawnedMonument && global.SpawnedMonumentSpecialObj;
                        break;
                }
                
                ds_list_delete(SpawnMethodList_Obj, 0);
            }
            
            ds_list_destroy(SpawnMethodList_Obj);
            
            if (!_ObjSpawned)
                return false;
            
            break;
        
        case UnknownEnum.Value_3:
            global.Switch_Spawned = SpawnSwitch(arg0, UnknownEnum.Value_1);
            
            if (global.Switch_Spawned == UnknownEnum.Value_3)
                return false;
            
            break;
        
        case UnknownEnum.Value_0:
            if (global.Level.Index > UnknownEnum.Value_1 && !(global.Level.Index == UnknownEnum.Value_12 && arg0 == global.Level.RoomIndex_BossAdjacent) && !global.Challenges[UnknownEnum.Value_5] && global.Level.Rooms[arg0].SizeIndex == UnknownEnum.Value_0 && global.Level.Rooms[arg0].Secret == -1 && global.Level.ShopCount < global.Level.MaxShops && !global.SpawnedJail && !ObstacleClassCheck(arg0, UnknownEnum.Value_3) && !global.Level.Rooms[arg0].WarpDest && !global.SpawnedRollingSpikes && !global.SpawnedMovingSpikeBlocks)
            {
                var InSection = (global.Level.Rooms[arg0].Section_ID != 0) ? FlipCoin_Bool() : false;
                global.SpawnedShop = SpawnShop(arg0, InSection, global.Level.Rooms[arg0].UnusedZone);
                
                if (!global.SpawnedShop)
                    global.SpawnedShop = SpawnShop(arg0, !InSection, global.Level.Rooms[arg0].UnusedZone);
            }
            
            break;
    }
    
    if (global.Level.Rooms[arg0].WarpDest && !global.Level.Rooms[arg0].WarpDest_Created)
    {
        var SpawnedWarpDest = SpawnWarpDest(arg0);
        
        if (!SpawnedWarpDest)
            return false;
    }
    
    global.SpawnedKinstone = SpawnKinstone(arg0, global.Level.Rooms[arg0].UnusedZone);
    global.SpawnedMonumentSpecialObj = false;
    
    if (global.Level.Index == UnknownEnum.Value_1 && global.Level.BonusTreasureCount == 0)
        global.Level.Rooms[arg0].BonusTreasure = true;
    
    if ((!global.SpawnedTreasure || ((global.Level.Rooms[arg0].SpecialObject == UnknownEnum.Value_1 || global.Level.Rooms[arg0].SpecialObject == UnknownEnum.Value_9) && global.Level.Rooms[arg0].Section_ID != 0)) && !(global.Level.Index == UnknownEnum.Value_1 && arg0 == global.Level.RoomIndex_Entrance) && global.Level.Rooms[arg0].BonusTreasure && global.Level.BonusTreasureCount < global.Level.MaxBonusTreasures && !global.SpawnedShop && !ObstacleClassCheck(arg0, UnknownEnum.Value_3))
    {
        global.SpawnedTreasure = false;
        var InSection = false;
        
        if (global.Level.Rooms[arg0].Section_ID != 0)
            InSection = (global.Level.Rooms[arg0].SpecialObject == UnknownEnum.Value_0) ? FlipCoin_Bool() : !global.Level.Rooms[arg0].SpecialObject_InSection;
        
        var SpawnMethodCount_TreasureList = ds_list_create();
        ds_list_add(SpawnMethodCount_TreasureList, UnknownEnum.Value_0, UnknownEnum.Value_0);
        
        if (global.Level.Rooms[arg0].Section_ID == 0)
        {
            ds_list_add(SpawnMethodCount_TreasureList, UnknownEnum.Value_1);
            
            if (global.SpawnedBlocks)
            {
                repeat (15)
                    ds_list_add(SpawnMethodCount_TreasureList, UnknownEnum.Value_1);
            }
        }
        
        if (!(global.Level.Rooms[arg0].SpecialObject == UnknownEnum.Value_10 && global.Level.Rooms[arg0].SizeIndex == UnknownEnum.Value_0 && global.Level.Rooms[arg0].LowerDoors))
            ds_list_add(SpawnMethodCount_TreasureList, UnknownEnum.Value_3, UnknownEnum.Value_3, UnknownEnum.Value_2, UnknownEnum.Value_2);
        
        ds_list_shuffle(SpawnMethodCount_TreasureList);
        
        while (!global.SpawnedTreasure && ds_list_size(SpawnMethodCount_TreasureList) > 0)
        {
            var TreasureSpawnMethod = ds_list_find_value(SpawnMethodCount_TreasureList, 0);
            
            switch (TreasureSpawnMethod)
            {
                case UnknownEnum.Value_0:
                    if (Prob(0.04) && global.Level.Index >= UnknownEnum.Value_4)
                        global.SpawnedTreasure = SpawnObj(arg0, UnknownEnum.Value_4, InSection, global.Level.Rooms[arg0].UnusedZone, -1);
                    
                    if (!global.SpawnedTreasure && Prob(0.12) && global.Level.Index >= UnknownEnum.Value_4 && global.Level.Index != UnknownEnum.Value_6)
                        global.SpawnedTreasure = SpawnObj(arg0, UnknownEnum.Value_5, InSection, global.Level.Rooms[arg0].UnusedZone, -1);
                    
                    if (!global.SpawnedTreasure)
                        global.SpawnedTreasure = SpawnObj(arg0, UnknownEnum.Value_1, InSection, global.Level.Rooms[arg0].UnusedZone, -99);
                    
                    break;
                
                case UnknownEnum.Value_1:
                    if (global.Switch_Spawned != UnknownEnum.Value_1)
                    {
                        global.Switch_Spawned = SpawnSwitch(arg0, UnknownEnum.Value_2, UnknownEnum.Value_1, false, -99);
                        global.SpawnedTreasure = global.Switch_Spawned == UnknownEnum.Value_1;
                    }
                    
                    break;
                
                case UnknownEnum.Value_2:
                    if (!global.SpawnedMonument)
                    {
                        global.SpawnedMonument = SpawnMonuments(arg0, InSection, global.Level.Rooms[arg0].UnusedZone, -99);
                        global.SpawnedTreasure = global.SpawnedMonument && global.SpawnedMonumentSpecialObj;
                    }
                    
                    break;
                
                case UnknownEnum.Value_3:
                    if (!global.SpawnedAltar)
                    {
                        global.SpawnedAltar = SpawnAltar(arg0, InSection, global.Level.Rooms[arg0].UnusedZone, -99);
                        global.SpawnedTreasure = global.SpawnedAltar;
                    }
                    
                    break;
            }
            
            ds_list_delete(SpawnMethodCount_TreasureList, 0);
        }
        
        if (global.SpawnedTreasure)
            global.Level.BonusTreasureCount++;
        
        ds_list_destroy(SpawnMethodCount_TreasureList);
    }
    
    if (!global.SpawnedMonument && !ObstacleClassCheck(arg0, UnknownEnum.Value_3))
    {
        if (Prob(0.85) || global.Level.Rooms[arg0].GridW == 2 || global.Level.Rooms[arg0].GridH == 2)
            global.SpawnedMonument = SpawnMonuments(arg0, false, global.Level.Rooms[arg0].UnusedZone);
    }
    
    global.SpawnedGuruBar = SpawnGuruBars(arg0);
    
    if (!global.SpawnedTorches && !ObstacleClassCheck(arg0, UnknownEnum.Value_3))
    {
        if (Prob(0.45))
            SpawnTorches(arg0);
    }
    
    if (!global.SpawnedPots && arg0 != global.Level.RoomIndex_Entrance && !ObstacleClassCheck(arg0, UnknownEnum.Value_3))
    {
        if (Prob(0.25))
            global.SpawnedPots = SpawnPots(arg0, false, -1);
    }
    
    if (global.Level.Rooms[arg0].SpecialObject == UnknownEnum.Value_10)
        global.SpawnedEnemies = SpawnEnemies(arg0);
    
    if (!global.SpawnedEnemies && arg0 != global.Level.RoomIndex_Entrance && !global.SpawnedShop)
    {
        if (global.Level.NoEnemyRoomCount >= global.Level.MaxNoEnemyRooms)
        {
            global.SpawnedEnemies = SpawnEnemies(arg0);
        }
        else
        {
            if ((global.Level.Rooms[arg0].TemplateClass == UnknownEnum.Value_6 && global.Level.Rooms[arg0].Obstacle == UnknownEnum.Value_0) || global.Level.Rooms[arg0].SizeIndex > UnknownEnum.Value_0)
            {
                if (Prob(0.9))
                    global.SpawnedEnemies = SpawnEnemies(arg0);
            }
            
            if (!global.SpawnedEnemies)
                global.Level.NoEnemyRoomCount++;
        }
    }
    
    if (!global.Level.Rooms[arg0].WarpDest && !global.SpawnedRollingSpikes && !global.SpawnedShop)
        global.SpawnedMovingSpikeBlocks = SpawnMovingSpikeBlocks(arg0);
    
    if (global.SpawnedAltar)
        global.Level.AltarCount++;
    
    if (global.SpawnedShop)
        global.Level.ShopCount++;
    
    var _DestroyRollingSpikes = false;
    var _DestroyGuruBars = false;
    var _DestroyMovingSpikeBlocks = false;
    
    if (global.Level.Stars && global.Level.Rooms[arg0].StarEnemyCount >= 9)
    {
        if (global.Level.Rooms[arg0].Section_ID == 0 && global.Level.Rooms[arg0].TemplateClass != UnknownEnum.Value_2 && global.Level.Rooms[arg0].SizeIndex > UnknownEnum.Value_0 && !global.SpawnedShop && !ObstacleClassCheck(arg0, UnknownEnum.Value_3))
        {
            SpawnObj(arg0, UnknownEnum.Value_8, false, -1, -1);
            global.Level.Stars = false;
            _DestroyRollingSpikes = true;
            _DestroyGuruBars = true;
        }
    }
    
    SpawnSpikes(arg0);
    
    if (!global.SpawnedEnemies)
    {
        if (global.Level.Rooms[arg0].SizeIndex == UnknownEnum.Value_0 && global.Level.Rooms[arg0].DoorCount == 1)
        {
            _DestroyRollingSpikes = true;
            _DestroyGuruBars = true;
            _DestroyMovingSpikeBlocks = true;
        }
    }
    
    if (_DestroyRollingSpikes)
    {
        with (oEnemy_RollingSpike)
        {
            if (RoomIndex == arg0)
            {
                UsedSpaceDelInstSpace(arg0, id);
                instance_destroy(id);
            }
        }
    }
    
    if (_DestroyGuruBars)
    {
        with (oEnemy_Guru_Bar)
        {
            if (RoomIndex == arg0)
            {
                UsedSpaceDelInstSpace(arg0, id);
                instance_destroy(id);
            }
        }
    }
    
    if (_DestroyMovingSpikeBlocks)
    {
        with (oEnemy_MovingSpikeBlock)
        {
            if (RoomIndex == arg0)
            {
                UsedSpaceDelInstSpace(arg0, id);
                instance_destroy(id);
            }
        }
    }
    
    var _EnemyCount = 0;
    var _CannonInst = -4;
    
    with (oEnemy)
    {
        if (RoomIndex == arg0)
        {
            _EnemyCount++;
            
            if (object_index == oEnemy_Cannon)
                _CannonInst = id;
        }
    }
    
    if (_EnemyCount == 1 && _CannonInst != -4)
        instance_destroy(_CannonInst);
    
    ds_list_destroy(global.UsedObjs);
    global.AltarData = undefined;
    return true;
}

function SpawnSwitch(arg0, arg1, arg2 = UnknownEnum.Value_0, arg3 = false, arg4 = -1)
{
    if (global.Level.Rooms[arg0].Section_ID != 0)
        return UnknownEnum.Value_3;
    
    global.Switch_Add = true;
    global.Level.Rooms[arg0].Switch.Action = arg1;
    
    if (global.Level.Rooms[arg0].Switch.Action == UnknownEnum.Value_2)
    {
        global.Level.Rooms[arg0].Switch.HiddenObjType = arg2;
        
        switch (global.Level.Rooms[arg0].Switch.HiddenObjType)
        {
            case UnknownEnum.Value_1:
                global.Level.Rooms[arg0].Switch.TreasureItemClass = arg4;
                global.SpawnedTreasure = SpawnObj(arg0, UnknownEnum.Value_1, arg3, global.Level.Rooms[arg0].UnusedZone, global.Level.Rooms[arg0].Switch.TreasureItemClass);
                
                if (!global.SpawnedTreasure)
                {
                    global.Switch_Add = false;
                    return UnknownEnum.Value_2;
                }
                
                break;
            
            case UnknownEnum.Value_2:
                global.SpawnedCrystal = SpawnObj(arg0, UnknownEnum.Value_2, arg3, global.Level.Rooms[arg0].UnusedZone, -1);
                
                if (!global.SpawnedCrystal)
                {
                    global.Switch_Add = false;
                    return UnknownEnum.Value_2;
                }
                
                break;
            
            case UnknownEnum.Value_3:
                global.SpawnedWarp = SpawnWarp(arg0);
                
                if (!global.SpawnedWarp)
                {
                    global.Switch_Add = false;
                    return UnknownEnum.Value_2;
                }
                
                break;
        }
    }
    
    var SwitchTypeList = ds_list_create();
    ds_list_add(SwitchTypeList, UnknownEnum.Value_4, UnknownEnum.Value_2, UnknownEnum.Value_2, UnknownEnum.Value_2);
    
    if (global.Level.Rooms[arg0].Switch.Action == UnknownEnum.Value_2 && global.Level.Rooms[arg0].Switch.HiddenObjType == UnknownEnum.Value_1 && arg4 == -99)
    {
        if (global.SpawnedBlocks)
        {
            repeat (50)
                ds_list_add(SwitchTypeList, UnknownEnum.Value_1);
        }
    }
    
    ds_list_shuffle(SwitchTypeList);
    
    for (var SwitchTypeIndex = 0; SwitchTypeIndex < ds_list_size(SwitchTypeList); SwitchTypeIndex++)
    {
        global.Level.Rooms[arg0].Switch.Type = ds_list_find_value(SwitchTypeList, SwitchTypeIndex);
        
        switch (global.Level.Rooms[arg0].Switch.Type)
        {
            case UnknownEnum.Value_2:
                global.SpawnedPots = SpawnPots(arg0, arg3, -2);
                
                if (global.SpawnedPots && global.Level.Rooms[arg0].Switch.Inst != -4)
                {
                    if (global.Level.Rooms[arg0].Switch.Action == UnknownEnum.Value_2)
                        global.Level.Rooms[arg0].Switch.Inst.HiddenObjInst = global.Level.Rooms[arg0].Switch.HiddenObjInst;
                    
                    global.Switch_Add = false;
                }
                
                break;
            
            case UnknownEnum.Value_4:
                if (!global.SpawnedTorches)
                {
                    global.SpawnedTorches = SpawnTorches(arg0);
                    
                    if (global.SpawnedTorches)
                        global.Switch_Add = false;
                }
                
                break;
            
            case UnknownEnum.Value_1:
                if (global.Level.Rooms[arg0].Switch.Action == UnknownEnum.Value_2)
                    global.Level.Rooms[arg0].Switch.Inst.HiddenObjInst = global.Level.Rooms[arg0].Switch.HiddenObjInst;
                
                global.Level.Rooms[arg0].Switch.Inst.Moved = false;
                global.Level.Rooms[arg0].Switch.Inst.Action = global.Level.Rooms[arg0].Switch.Action;
                global.Level.Rooms[arg0].Switch.Inst.image_index = 1;
                global.Switch_Add = false;
                break;
        }
        
        if (!global.Switch_Add)
            break;
        
        ds_list_finddelete_all(SwitchTypeList, global.Level.Rooms[arg0].Switch.Type);
        SwitchTypeIndex = 0;
    }
    
    if (global.Switch_Add)
    {
        if (global.Level.Rooms[arg0].Switch.Action == UnknownEnum.Value_2)
        {
            var _DestroyObj = true;
            var _DeleteUsedSpace = true;
            
            switch (global.Level.Rooms[arg0].Switch.HiddenObjType)
            {
                default:
                    _DestroyObj = false;
                    _DeleteUsedSpace = false;
                    break;
                
                case UnknownEnum.Value_1:
                    global.SpawnedTreasure = false;
                    break;
                
                case UnknownEnum.Value_2:
                    global.SpawnedCrystal = false;
                    break;
                
                case UnknownEnum.Value_3:
                    global.SpawnedWarp = false;
                    break;
            }
            
            if (_DestroyObj)
                instance_destroy(global.Level.Rooms[arg0].Switch.HiddenObjInst);
            
            if (_DeleteUsedSpace)
                array_pop(global.Level.Rooms[arg0].UsedSpace);
        }
        
        instance_destroy(global.Level.Rooms[arg0].Switch.Inst);
    }
    
    ds_list_destroy(SwitchTypeList);
    
    if (!global.Switch_Add)
    {
        return UnknownEnum.Value_1;
    }
    else
    {
        global.Switch_Add = false;
        return UnknownEnum.Value_3;
    }
}

function SpawnWarp(arg0)
{
    if (global.Level.Rooms[arg0].Warp_DestRoomIndex == -1)
        return false;
    
    var SpawnedWarp = SpawnObj(arg0, UnknownEnum.Value_6, global.Level.Rooms[arg0].SpecialObject_InSection, -1, -1);
    return SpawnedWarp;
}

function SpawnWarpDest(arg0)
{
    var SpawnedWarpDest = SpawnObj(arg0, UnknownEnum.Value_7, false, -1, -1);
    global.Level.Rooms[arg0].WarpDest_Created = SpawnedWarpDest;
    return SpawnedWarpDest;
}

function SpawnSpikes(arg0)
{
    var ObstacleSpikes = false;
    
    if (global.Level.Rooms[arg0].TemplateClass == UnknownEnum.Value_6)
    {
        if (!ObstacleClassCheck(arg0, UnknownEnum.Value_2))
            return false;
        
        ObstacleSpikes = true;
    }
    else
    {
        if (!variable_struct_exists(global.Level.Rooms[arg0].Template, "Spikes"))
            return false;
        
        switch (global.Level.Index)
        {
            case UnknownEnum.Value_1:
            case UnknownEnum.Value_2:
            case UnknownEnum.Value_3:
            case UnknownEnum.Value_5:
            case UnknownEnum.Value_9:
                return false;
        }
        
        if (!Prob(0.5 + (global.Level.Index / 30)))
            return false;
        
        if (global.Level.Rooms[arg0].Section_ID != 0 || global.Level.Rooms[arg0].Secret != -1 || TemplateCheck(arg0, UnknownEnum.Value_9, UnknownEnum.Value_0) || global.SpawnedWater || global.SpawnedMovingFloors)
            return false;
        
        if (global.Level.Rooms[arg0].SpecialObject == UnknownEnum.Value_1 || global.Level.Rooms[arg0].SpecialObject == UnknownEnum.Value_3)
            return false;
        
        if (global.Level.Rooms[arg0].Switch.Action == UnknownEnum.Value_2)
            return false;
    }
    
    var SpikesInTemplate = array_length(global.Level.Rooms[arg0].Template.Spikes);
    
    if (SpikesInTemplate == 0)
        return false;
    
    for (var SpikeIndex = 0; SpikeIndex < SpikesInTemplate; SpikeIndex++)
    {
        var Spike = global.Level.Rooms[arg0].Template.Spikes[SpikeIndex];
        var SpikeX = global.Level.Rooms[arg0].x + Spike.x;
        var SpikeY = global.Level.Rooms[arg0].y + Spike.y;
        var SpikeX2 = (SpikeX + Spike.width) - 1;
        var SpikeY2 = (SpikeY + Spike.height) - 1;
        var SpikeTileW = Spike.width / 8;
        var SpikeTileH = Spike.height / 8;
        var TMID = GetFloorLevelTMID("Tiles_Floor", SpikeX, SpikeY);
        var SpikeIsInSection = InSectionArea(arg0, SpikeX, SpikeY, global.Level.Rooms[arg0].Section_ID, true);
        
        if (!ObstacleSpikes)
        {
            if (!Prob(0.4 + (global.Level.Index / 30)))
                continue;
            
            if (global.SpawnedCarpets)
            {
                TMID = GetFloorLevelTMID("Tiles_Floor", SpikeX, SpikeY);
                
                if (CornersOnCarpet(TMID, SpikeX, SpikeY, SpikeX2, SpikeY2) > 0)
                    continue;
            }
            
            if (collision_rectangle(SpikeX, SpikeY - 24, SpikeX2, SpikeY, oDoor, false, true) != -4)
                continue;
            
            if (collision_rectangle(SpikeX, SpikeY2 + 1, SpikeX2, SpikeY2 + 24, oDoor, false, true) != -4)
                continue;
            
            if (collision_rectangle(SpikeX - 24, SpikeY, SpikeX, SpikeY2, oDoor, false, true) != -4)
                continue;
            
            if (collision_rectangle(SpikeX2 + 1, SpikeY, SpikeX2 + 24, SpikeY2, oDoor, false, true) != -4)
                continue;
        }
        
        if (UsedSpaceConflict(arg0, SpikeX, SpikeY, SpikeX2, SpikeY2, UnknownEnum.Value_2, SpikeIsInSection))
            continue;
        
        ClearTileBlock(GetFloorLevelTMID("Tiles_Water", SpikeX, SpikeY), SpikeX, SpikeY, SpikeTileW, SpikeTileH, 0);
        
        for (var _TileY = 0; _TileY < SpikeTileH; _TileY++)
        {
            for (var _TileX = 0; _TileX < SpikeTileW; _TileX++)
            {
                var _PosX = SpikeX + (_TileX * 8);
                var _PosY = SpikeY + (_TileY * 8);
                var _ID = global.SpikeTileID[((_PosX / 8) % 2) ^^ ((_PosY / 8) % 2)];
                tilemap_set_at_pixel(TMID, _ID, _PosX, _PosY);
            }
        }
    }
    
    return true;
}

function SpawnMonuments(arg0, arg1, arg2, arg3 = -1, arg4 = false)
{
    if (global.Level.Rooms[arg0].SpecialObject == UnknownEnum.Value_10 && global.Level.Rooms[arg0].SizeIndex == UnknownEnum.Value_0 && global.Level.Rooms[arg0].LowerDoors)
        return false;
    
    var MonumentsArray = struct_get_from_hash(array_get(struct_get_from_hash(global.Level.Rooms[arg0].Template, variable_get_hash("Sections")), global.Level.Rooms[arg0].Section_ID), variable_get_hash("Monuments"));
    var Monuments = array_length(MonumentsArray);
    
    if (Monuments == 0)
        return false;
    
    var MonumentsList = ds_list_create_sequence_shuffled(0, Monuments - 1);
    var ArrowTargetNeeded = global.Switch_Add && global.Level.Rooms[arg0].Switch.Type == UnknownEnum.Value_5;
    var SpawnArrowTarget = false;
    var ArrowTargetSpawned = false;
    var MainObjAdded = false;
    var BonusPots = (global.Level.Index == UnknownEnum.Value_1 && arg0 == global.Level.RoomIndex_Entrance) ? false : Prob(0.33) || arg4;
    var TotalMonuments = (global.Level.Index == UnknownEnum.Value_1 && arg0 == global.Level.RoomIndex_Entrance) ? min(Monuments, 4) : irandom_range(min(global.Level.Rooms[arg0].GridW * global.Level.Rooms[arg0].GridH, Monuments), Monuments);
    var MonumentsSpawned = 0;
    var SpawnedMonumentPositionsX = array_create(0);
    var SpawnedMonumentPositionsY = array_create(0);
    
    for (var MonumentIndex = 0; MonumentIndex < Monuments; MonumentIndex++)
    {
        var Monument = array_get(MonumentsArray, ds_list_find_value(MonumentsList, MonumentIndex));
        var MonumentX = global.Level.Rooms[arg0].x + Monument.x;
        var MonumentY = global.Level.Rooms[arg0].y + Monument.y;
        var MonumentX2 = MonumentX + 31;
        var MonumentY2 = MonumentY + 31;
        var FloorLevel = GetFloorLevelID(MonumentX, MonumentY);
        var FloorLevelStr = GetFloorLevelString(FloorLevel);
        var TMID_Floor = GetFloorLevelTMID("Tiles_Floor", MonumentX, MonumentY);
        var _UpperStairs = global.Level.Rooms[arg0].TemplateClass == UnknownEnum.Value_2 && FloorLevel == 1;
        var TMID_Walls = _UpperStairs ? global.TMID_StairMonuments : GetFloorLevelTMID("Tiles_Walls", MonumentX, MonumentY);
        var TMID_Decor = _UpperStairs ? global.TMID_StairMonumentsDecor : GetFloorLevelTMID("Tiles_Decor", MonumentX, MonumentY);
        var MonumentOk = true;
        
        if (global.SpawnedCarpetStyle == UnknownEnum.Value_1)
        {
            if (CornersOnCarpet(TMID_Floor, MonumentX, MonumentY, MonumentX2, MonumentY2) > 1)
            {
                MonumentOk = false;
                continue;
            }
        }
        
        if (collision_rectangle(MonumentX, MonumentY - 24, MonumentX2, MonumentY, oDoor, false, true) != -4)
        {
            MonumentOk = false;
        }
        else if (collision_rectangle(MonumentX, MonumentY2 + 1, MonumentX2, MonumentY2 + 24, oDoor, false, true) != -4)
        {
            MonumentOk = false;
        }
        else if (collision_rectangle(MonumentX - 24, MonumentY, MonumentX, MonumentY2, oDoor, false, true) != -4)
        {
            MonumentOk = false;
        }
        else if (collision_rectangle(MonumentX2 + 1, MonumentY, MonumentX2 + 24, MonumentY2, oDoor, false, true) != -4)
        {
            MonumentOk = false;
        }
        else
        {
            var MonumentInSection = InSectionArea(arg0, MonumentX, MonumentY, global.Level.Rooms[arg0].Section_ID, true);
            SpawnArrowTarget = false;
            
            if (ArrowTargetNeeded)
            {
                if (collision_rectangle(MonumentX, MonumentY2 + 1, MonumentX2, MonumentY2 + 64, oWall, false, true) == -4 && collision_rectangle(MonumentX, MonumentY2 + 1, MonumentX2, (global.Level.Rooms[arg0].y + global.Level.Rooms[arg0].height) - 24, global.Level.Rooms[arg0].Switch.HiddenObjInst, false, true) == -4)
                    SpawnArrowTarget = true;
            }
            
            var ObjAllowed;
            
            if (SpawnArrowTarget)
            {
                ObjAllowed = false;
            }
            else
            {
                ObjAllowed = true;
                
                if (collision_rectangle(MonumentX, MonumentY2 + 1, MonumentX2, MonumentY2 + 32, oWall, false, true))
                    ObjAllowed = false;
                
                if (collision_rectangle(MonumentX - 24, MonumentY2 + 1, MonumentX - 1, MonumentY2 + 24, oDoor, false, true))
                    ObjAllowed = false;
                
                if (collision_rectangle(MonumentX2 + 1, MonumentY2 + 1, MonumentX2 + 24, MonumentY2 + 24, oDoor, false, true))
                    ObjAllowed = false;
            }
            
            for (var i = 0; i < MonumentsSpawned; i++)
            {
                if (point_distance(MonumentX + 16, MonumentY + 16, SpawnedMonumentPositionsX[i] + 16, SpawnedMonumentPositionsY[i] + 16) < 128)
                {
                    MonumentOk = false;
                    break;
                }
            }
            
            if (!MonumentOk)
            {
            }
            else
            {
                var _UsedSpaceX1 = MonumentX;
                var _UsedSpaceY1 = MonumentY;
                var _UsedSpaceX2 = MonumentX2;
                var _UsedSpaceY2 = MonumentY2;
                
                if (ObjAllowed && (BonusPots || (arg3 != -1 && !MainObjAdded)))
                {
                    _UsedSpaceX1 -= 16;
                    _UsedSpaceY1 -= 16;
                    _UsedSpaceX2 += 16;
                    _UsedSpaceY2 += 32;
                }
                else if (SpawnArrowTarget)
                {
                    _UsedSpaceY2 += 64;
                }
                
                if (UsedSpaceConflict(arg0, _UsedSpaceX1, _UsedSpaceY1, _UsedSpaceX2, _UsedSpaceY2, UnknownEnum.Value_0, MonumentInSection))
                {
                    MonumentOk = false;
                }
                else if (MonumentOk)
                {
                    var Style = SpawnArrowTarget ? 1 : Decor_Monuments_AllowedStyle(MonumentX, MonumentY);
                    
                    if (global.Level.Index == UnknownEnum.Value_4 && Style == 2 && !global.Level.CatacombGrave)
                    {
                        if (arg3 != -1 && arg3 != UnknownEnum.Value_20 && !MainObjAdded)
                            Style = 3;
                    }
                    
                    var TileX = 116 + (Style * 4);
                    var _Mirrored = FlipCoin_Bool();
                    DrawTileBlock(TMID_Walls, MonumentX, MonumentY, TileX, 4 + ((global.Level.Index - 1) * 6), 4, 4, _Mirrored);
                    var _ItemStyle = 0;
                    
                    if (global.Level.Index == UnknownEnum.Value_4 && Style == 1 && Prob(0.3))
                        instance_create_layer(MonumentX + 16, MonumentY + 13, "ObjsFloor_" + FloorLevelStr, oTombSkeleton);
                    else
                        _ItemStyle = Decor_MonumentItems(TMID_Decor, MonumentX, MonumentY, Style, _Mirrored);
                    
                    var _Grave = global.Level.Index == UnknownEnum.Value_4 && Style == 2 && _ItemStyle == 1;
                    var WallInst1 = WallObj_Create("Objs_" + FloorLevelStr, MonumentX, MonumentY, 4, 3);
                    WallInst1.BlockProjectiles = true;
                    var WallInst2 = WallObj_Create("Objs_" + FloorLevelStr, MonumentX, MonumentY + 24, 4, 1);
                    WallInst2.BlockProjectiles = false;
                    array_push(SpawnedMonumentPositionsX, MonumentX);
                    array_push(SpawnedMonumentPositionsY, MonumentY);
                    
                    if (SpawnArrowTarget)
                    {
                        global.Level.Rooms[arg0].Switch.Inst = instance_create_layer(MonumentX + 11, MonumentY + 10, "ObjsHigher_" + FloorLevelStr, oArrowSwitch);
                        global.Level.Rooms[arg0].Switch.Action = UnknownEnum.Value_2;
                        global.Level.Rooms[arg0].Switch.Inst.Action = global.Level.Rooms[arg0].Switch.Action;
                        global.Level.Rooms[arg0].Switch.Inst.HiddenObjInst = global.Level.Rooms[arg0].Switch.HiddenObjInst;
                        ArrowTargetSpawned = true;
                        ArrowTargetNeeded = false;
                        SpawnArrowTarget = false;
                    }
                    else if (ObjAllowed)
                    {
                        if (arg3 != -1 && !MainObjAdded)
                        {
                            if (arg1 == MonumentInSection)
                            {
                                var ItemsY = MonumentY2 + 1;
                                var ItemsX = MonumentX;
                                global.SpawnedMonumentSpecialObj = true;
                                MainObjAdded = true;
                                
                                if (arg3 == UnknownEnum.Value_20 && (FlipCoin_Bool() || _Grave))
                                {
                                    var OtherItem = Probs_RandomItemClass(UnknownEnum.Value_0);
                                    var PotItem1 = choose(arg3, OtherItem);
                                    var PotItem2 = (PotItem1 == arg3) ? OtherItem : arg3;
                                    var PotInst = Pot_Create(arg0, ItemsX, ItemsY, PotItem1, arg1);
                                    PotInst = Pot_Create(arg0, ItemsX + 16, ItemsY, PotItem2, arg1);
                                }
                                else if (arg3 == UnknownEnum.Value_11)
                                {
                                    Crystal_Create(arg0, ItemsX + 8, ItemsY);
                                }
                                else if (arg3 == UnknownEnum.Value_47)
                                {
                                    Warp_Create(arg0, ItemsX + 8, ItemsY, FloorLevel);
                                }
                                else if (arg3 == UnknownEnum.Value_42)
                                {
                                    global.SpawnedStarInst = instance_create_layer(MonumentX + 16, MonumentY + 48, "Objs_" + FloorLevelStr, oItem_Star, 
                                    {
                                        From: UnknownEnum.Value_22
                                    });
                                }
                                else if (arg3 != UnknownEnum.Value_20 && !global.Switch_Add && global.Level.Index >= UnknownEnum.Value_4 && !_Grave && global.Level.Index != UnknownEnum.Value_6 && global.Level.Index != UnknownEnum.Value_10 && Prob(0.15))
                                {
                                    if (arg3 == -99)
                                        arg3 = Prob(0.75) ? Probs_RandomItemClass(UnknownEnum.Value_2) : -1;
                                    
                                    instance_create_layer(ItemsX + 16, ItemsY + 16, "Objs_" + FloorLevelStr, oDeadGuy, 
                                    {
                                        ItemHolding: arg3
                                    });
                                }
                                else
                                {
                                    var Items = (global.Switch_Add && global.Level.Rooms[arg0].Switch.Action == UnknownEnum.Value_2) ? 1 : choose(1, 2);
                                    SpawnTreasureRow(arg0, ItemsX + ((Items == 1) ? 8 : 0), ItemsY, arg1, arg3, Items);
                                }
                            }
                        }
                        else if (BonusPots)
                        {
                            var Pot1X, Pot2X;
                            
                            if (Prob(0.5))
                            {
                                Pot1X = MonumentX;
                                Pot2X = MonumentX + 16;
                            }
                            else
                            {
                                Pot1X = MonumentX + 16;
                                Pot2X = MonumentX;
                            }
                            
                            var PotsY = MonumentY2 + 1;
                            Pot_Create(arg0, Pot1X, PotsY, Probs_RandomItemClass_Pot(false), arg1);
                            Pot_Create(arg0, Pot2X, PotsY, Probs_RandomItemClass_Pot(false), arg1);
                        }
                    }
                    
                    AddUsedSpace(arg0, _UsedSpaceX1, _UsedSpaceY1, _UsedSpaceX2, _UsedSpaceY2, UnknownEnum.Value_0, MonumentInSection);
                    MonumentsSpawned++;
                    
                    if (MonumentsSpawned >= TotalMonuments)
                        break;
                }
            }
        }
    }
    
    ds_list_destroy(MonumentsList);
    return MonumentsSpawned > 0;
}

function SpawnTorches(arg0)
{
    if (global.Challenges[UnknownEnum.Value_4])
        return false;
    
    var TorchArray = struct_get_from_hash(array_get(struct_get_from_hash(global.Level.Rooms[arg0].Template, variable_get_hash("Sections")), global.Level.Rooms[arg0].Section_ID), variable_get_hash("Torches"));
    var TorchesInTemplate = array_length(TorchArray);
    
    if (TorchesInTemplate == 0)
        return false;
    
    var Success = false;
    var MinTorches = global.Switch_Add ? min(TorchesInTemplate, 3) : 1;
    var Torches = irandom_range(MinTorches, 4);
    
    for (var TorchIndex = 0; TorchIndex < Torches; TorchIndex++)
    {
        var SpawnedTorch = SpawnObj(arg0, UnknownEnum.Value_3, false, -1, -1);
        
        if (!Success && SpawnedTorch)
            Success = true;
    }
    
    if (Success)
        global.TorchGroupIndex++;
    
    return Success;
}

function SpawnAltar(arg0, arg1, arg2, arg3)
{
    if (!PlatformVerify(arg0, arg1, arg2))
        return false;
    
    var AltarX = global.AltarData.x;
    var AltarY = global.AltarData.y;
    var AltarW = global.AltarData.w;
    var AltarH = global.AltarData.h;
    var FloorTMID = GetFloorLevelTMID("Tiles_Floor", AltarX, AltarY);
    var WallTMID = GetFloorLevelTMID("Tiles_Walls", AltarX, AltarY);
    var FloorLevelStr = GetFloorLevelString(AltarX, AltarY);
    var AltarTileW = AltarW / 8;
    var AltarTileH = AltarH / 8;
    ClearTileBlock(global.TMID_Water_Upper, AltarX, AltarY, AltarTileW, AltarTileH);
    ClearTileBlock(global.TMID_Water_Lower, AltarX, AltarY, AltarTileW, AltarTileH);
    
    for (var _y = 0; _y < AltarTileH; _y++)
    {
        for (var _x = 0; _x < AltarTileW; _x++)
        {
            var FloorX = AltarX + (_x * 8);
            var FloorY = AltarY + (_y * 8);
            DrawTileBlock(FloorTMID, FloorX, FloorY, 111, 4 + ((global.Level.Index - 1) * 6) + 2, 1, 1);
        }
    }
    
    DrawTileBlock(WallTMID, AltarX, AltarY, 110, 4 + ((global.Level.Index - 1) * 6) + 1, 1, 1);
    DrawTileBlock(WallTMID, (AltarX + AltarW) - 8, AltarY, 112, 4 + ((global.Level.Index - 1) * 6) + 1, 1, 1);
    DrawTileBlock(WallTMID, AltarX, (AltarY + AltarH) - 8, 110, 4 + ((global.Level.Index - 1) * 6) + 3, 1, 1);
    DrawTileBlock(WallTMID, (AltarX + AltarW) - 8, (AltarY + AltarH) - 8, 112, 4 + ((global.Level.Index - 1) * 6) + 3, 1, 1);
    
    for (var _x = 0; _x < (AltarTileW - 2); _x++)
    {
        var SideX = AltarX + 8 + (_x * 8);
        DrawTileBlock(WallTMID, SideX, AltarY, 111, 4 + ((global.Level.Index - 1) * 6) + 1, 1, 1);
    }
    
    var WallInst = WallObj_Create("Objs_" + FloorLevelStr, AltarX, AltarY, AltarTileW, 1);
    WallInst.BlockProjectiles = false;
    WallInst.BlockItems = false;
    var SideXR;
    
    for (var _y = 0; _y < (AltarTileH - 2); _y++)
    {
        SideXR = (AltarX + AltarW) - 8;
        var SideY = AltarY + 8 + (_y * 8);
        DrawTileBlock(WallTMID, AltarX, SideY, 110, 4 + ((global.Level.Index - 1) * 6) + 2, 1, 1);
        DrawTileBlock(WallTMID, SideXR, SideY, 112, 4 + ((global.Level.Index - 1) * 6) + 2, 1, 1);
    }
    
    WallInst = WallObj_Create("Objs_" + FloorLevelStr, AltarX, AltarY, 1, AltarTileH);
    WallInst.BlockProjectiles = false;
    WallInst.BlockItems = false;
    WallInst = WallObj_Create("Objs_" + FloorLevelStr, SideXR, AltarY, 1, AltarTileH);
    WallInst.BlockProjectiles = false;
    WallInst.BlockItems = false;
    var StairsW = AltarTileW - 6;
    var StairsX = AltarX + (4 * (AltarTileW - StairsW));
    var StairsY = (AltarY + AltarH) - 16;
    
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
    var SideLen = (AltarTileW - StairsW - 4) / 2;
    
    for (var _x = 0; _x < SideLen; _x++)
    {
        DrawTileBlock(WallTMID, AltarX + 8 + (_x * 8), StairsY + 8, 111, 4 + ((global.Level.Index - 1) * 6) + 3, 1, 1);
        DrawTileBlock(WallTMID, StairsX + (StairsW * 8) + 8 + (_x * 8), StairsY + 8, 111, 4 + ((global.Level.Index - 1) * 6) + 3, 1, 1);
    }
    
    WallInst = WallObj_Create("Objs_" + FloorLevelStr, StairsX - 16, StairsY + 8, 2, 1);
    WallInst.BlockProjectiles = false;
    WallInst.BlockItems = false;
    WallInst = WallObj_Create("Objs_" + FloorLevelStr, StairsX + (StairsW * 8), StairsY + 8, 2, 1);
    WallInst.BlockProjectiles = false;
    WallInst.BlockItems = false;
    var Items = min(1 + floor((AltarTileW - 8) / 2), 5);
    var ItemsW = Items * 16;
    var ItemsX = AltarX + ((AltarW - ItemsW) / 2);
    var ItemsY = AltarY + 8 + ((AltarTileH > 8) ? ((AltarTileH > 10) ? 16 : 8) : 0);
    SpawnTreasureRow(arg0, ItemsX, ItemsY, arg1, arg3, Items);
    
    if (arg2 != -1)
        global.Level.Rooms[arg0].UnusedZone = -1;
    
    return true;
}

function SpawnShop(arg0, arg1, arg2)
{
    if (!PlatformVerify(arg0, arg1, arg2, 20))
        return false;
    
    var _ShopX = global.AltarData.x;
    var _ShopY = global.AltarData.y;
    var _ShopW = global.AltarData.w;
    var _ShopH = 64;
    var _ShopTileW = _ShopW / 8;
    var _ShopTileH = _ShopH / 8;
    var FloorTMID = GetFloorLevelTMID("Tiles_Floor", _ShopX, _ShopY);
    var _FloorLevelStr = GetFloorLevelString(_ShopX, _ShopY);
    ClearTileBlock(global.TMID_Water_Upper, _ShopX, _ShopY, _ShopTileW, _ShopTileH);
    ClearTileBlock(global.TMID_Water_Lower, _ShopX, _ShopY, _ShopTileW, _ShopTileH);
    var FarEdgeX = _ShopX + ((_ShopTileW - 1) * 8);
    var FarEdgeY = _ShopY + ((_ShopTileH - 1) * 8);
    DrawTileBlock(FloorTMID, _ShopX, _ShopY, 15, 0, 1, 1);
    DrawTileBlock(FloorTMID, FarEdgeX, _ShopY, 17, 0, 1, 1);
    DrawTileBlock(FloorTMID, _ShopX, FarEdgeY, 15, 2, 1, 1);
    DrawTileBlock(FloorTMID, FarEdgeX, FarEdgeY, 17, 2, 1, 1);
    
    for (var _x = 1; _x < (_ShopTileW - 1); _x++)
    {
        var FloorX = _ShopX + (_x * 8);
        DrawTileBlock(FloorTMID, FloorX, _ShopY, 16, 0, 1, 1);
        DrawTileBlock(FloorTMID, FloorX, FarEdgeY, 16, 2, 1, 1);
    }
    
    for (var _y = 1; _y < (_ShopTileH - 1); _y++)
    {
        var FloorY = _ShopY + (_y * 8);
        DrawTileBlock(FloorTMID, _ShopX, FloorY, 15, 1, 1, 1);
        DrawTileBlock(FloorTMID, FarEdgeX, FloorY, 17, 1, 1, 1);
    }
    
    for (var _y = 1; _y < (_ShopTileH - 1); _y++)
    {
        for (var _x = 1; _x < (_ShopTileW - 1); _x++)
        {
            var FloorX = _ShopX + (_x * 8);
            var FloorY = _ShopY + (_y * 8);
            DrawTileBlock(FloorTMID, FloorX, FloorY, 16, 1, 1, 1);
        }
    }
    
    var ShopInst = instance_create_layer(_ShopX, _ShopY, "ObjsFloor_" + _FloorLevelStr, oShop, 
    {
        RoomIndex: arg0,
        ShopW: _ShopW,
        ShopH: _ShopH,
        ShopType: UnknownEnum.Value_0
    });
    ds_list_add(global.LargeMapItems, ShopInst);
    var WallInst = WallObj_Create("Objs_" + _FloorLevelStr, _ShopX + 8, _ShopY + 8, _ShopTileW - 2, _ShopTileH - 2, undefined, undefined, oShopWall);
    WallInst.ShopInst = ShopInst;
    WallInst.BlockProjectiles = false;
    
    if (arg2 != -1)
        global.Level.Rooms[arg0].UnusedZone = -1;
    
    return true;
}

function SpawnSwitchBlocks(arg0)
{
    if (global.Level.Rooms[arg0].Section_ID == 0)
        exit;
    
    if (global.Level.Rooms[arg0].Section_WallType != UnknownEnum.Value_1)
        exit;
    
    var SectionWallsArray = struct_get_from_hash(array_get(struct_get_from_hash(global.Level.Rooms[arg0].Template, variable_get_hash("Sections")), global.Level.Rooms[arg0].Section_ID), variable_get_hash("SectionWalls"));
    var Walls = array_length(SectionWallsArray);
    
    if (Walls == 0)
        exit;
    
    var X1 = 100000;
    var Y1 = 100000;
    var X2 = -100000;
    var Y2 = -100000;
    var SBSegmentsList = ds_list_create();
    
    for (var SectionWallIndex = 0; SectionWallIndex < Walls; SectionWallIndex++)
    {
        var SB = SectionWallsArray[SectionWallIndex];
        var SwitchBoxShiftString = GetPropertyValue(struct_get_from_hash(SB, variable_get_hash("properties")), "SB");
        
        if (SwitchBoxShiftString == -1)
            continue;
        
        ds_list_add(SBSegmentsList, SB);
        var SB_X1 = global.Level.Rooms[arg0].x + SB.x;
        var SB_Y1 = global.Level.Rooms[arg0].y + SB.y;
        var SB_X2 = (SB_X1 + SB.width) - 1;
        var SB_Y2 = (SB_Y1 + SB.height) - 1;
        
        if (string_pos("L", SwitchBoxShiftString) != 0)
            SB_X1 -= 8;
        
        if (string_pos("R", SwitchBoxShiftString) != 0)
            SB_X2 += 8;
        
        if (string_pos("U", SwitchBoxShiftString) != 0)
            SB_Y1 -= 8;
        
        if (string_pos("D", SwitchBoxShiftString) != 0)
            SB_Y2 += 8;
        
        if (SB_X1 < X1)
            X1 = SB_X1;
        
        if (SB_Y1 < Y1)
            Y1 = SB_Y1;
        
        if (SB_X2 > X2)
            X2 = SB_X2;
        
        if (SB_Y2 > Y2)
            Y2 = SB_Y2;
    }
    
    var TLCorner = false;
    var TRCorner = false;
    var BLCorner = false;
    var BRCorner = false;
    var Segments = ds_list_size(SBSegmentsList);
    
    for (var i = 0; i < (Segments - 1); i++)
    {
        var SB1 = ds_list_find_value(SBSegmentsList, i);
        var Segment1_X1 = SB1.x;
        var Segment1_Y1 = SB1.y;
        var Segment1_X2 = (SB1.x + SB1.width) - 1;
        var Segment1_Y2 = (SB1.y + SB1.height) - 1;
        var j = i + 1;
        
        while (j < Segments)
        {
            var SB2 = ds_list_find_value(SBSegmentsList, j);
            var Segment2_X1 = SB2.x;
            var Segment2_Y1 = SB2.y;
            var Segment2_X2 = (SB2.x + SB2.width) - 1;
            var Segment2_Y2 = (SB2.y + SB2.height) - 1;
            
            if (Segment1_X1 == Segment2_X1 && Segment1_Y1 == Segment2_Y1)
                TLCorner = true;
            
            if (Segment1_X2 == Segment2_X2 && Segment1_Y1 == Segment2_Y1)
                TRCorner = true;
            
            if (Segment1_X1 == Segment2_X1 && Segment1_Y2 == Segment2_Y2)
                BLCorner = true;
            
            if (Segment1_X2 == Segment2_X2 && Segment1_Y2 == Segment2_Y2)
                BRCorner = true;
            
            j++;
        }
    }
    
    ds_list_destroy(SBSegmentsList);
    var inst = instance_create_layer(X1, Y1, "ObjsDoors_Upper", oSwitchBlock);
    inst.X1 = X1;
    inst.Y1 = Y1;
    inst.X2 = X2;
    inst.Y2 = Y2;
    inst.Corner_TL = TLCorner;
    inst.Corner_TR = TRCorner;
    inst.Corner_BL = BLCorner;
    inst.Corner_BR = BRCorner;
    
    if (Segments == 1)
    {
        if ((X2 - X1) == 15)
            inst.Segment_L = true;
        
        if ((Y2 - Y1) == 15)
            inst.Segment_T = true;
    }
    else
    {
        inst.Segment_L = TLCorner || BLCorner;
        inst.Segment_R = TRCorner || BRCorner;
        inst.Segment_T = TLCorner || TRCorner;
        inst.Segment_B = BLCorner || BRCorner;
    }
    
    if (inst.Segment_L)
    {
        inst.Segment_L_Y = Y1 + (inst.Corner_TL ? 16 : 0);
        var _Y2 = Y2 - (inst.Corner_BL ? 16 : 0);
        inst.Segment_L_H = (_Y2 - inst.Segment_L_Y) + 1;
        inst.Segment_L_Wall = WallObj_Create("Objs_Upper", X1, Y1, 2, ((Y2 - Y1) + 1) / 8);
        inst.Segment_L_Wall.SwitchBlockInst = inst;
        inst.Segment_L_Wall.IsSwitchBlock = true;
        inst.Segment_L_Wall.BlockProjectiles = false;
        inst.Segment_L_Wall.BlockItems = false;
    }
    
    if (inst.Segment_R)
    {
        inst.Segment_R_Y = Y1 + (inst.Corner_TR ? 16 : 0);
        var _Y2 = Y2 - (inst.Corner_BR ? 16 : 0);
        inst.Segment_R_H = (_Y2 - inst.Segment_R_Y) + 1;
        inst.Segment_R_Wall = WallObj_Create("Objs_Upper", X2 - 15, Y1, 2, ((Y2 - Y1) + 1) / 8);
        inst.Segment_R_Wall.SwitchBlockInst = inst;
        inst.Segment_R_Wall.IsSwitchBlock = true;
        inst.Segment_R_Wall.BlockProjectiles = false;
        inst.Segment_R_Wall.BlockItems = false;
    }
    
    if (inst.Segment_T)
    {
        inst.Segment_T_X = X1 + (inst.Corner_TL ? 16 : 0);
        var _X2 = X2 - (inst.Corner_TR ? 16 : 0);
        inst.Segment_T_W = (_X2 - inst.Segment_T_X) + 1;
        inst.Segment_T_Wall = WallObj_Create("Objs_Upper", X1, Y1, ((X2 - X1) + 1) / 8, 2);
        inst.Segment_T_Wall.SwitchBlockInst = inst;
        inst.Segment_T_Wall.IsSwitchBlock = true;
        inst.Segment_T_Wall.BlockProjectiles = false;
        inst.Segment_T_Wall.BlockItems = false;
    }
    
    if (inst.Segment_B)
    {
        inst.Segment_B_X = inst.X1 + (inst.Corner_BL ? 16 : 0);
        var _X2 = inst.X2 - (inst.Corner_BR ? 16 : 0);
        inst.Segment_B_W = (_X2 - inst.Segment_B_X) + 1;
        inst.Segment_B_Wall = WallObj_Create("Objs_Upper", X1, Y2 - 15, ((X2 - X1) + 1) / 8, 2);
        inst.Segment_B_Wall.SwitchBlockInst = inst;
        inst.Segment_B_Wall.IsSwitchBlock = true;
        inst.Segment_B_Wall.BlockProjectiles = false;
        inst.Segment_B_Wall.BlockItems = false;
    }
    
    inst.Color = global.Level.DungeonTemplate.Rooms[arg0].Section_Color;
    
    if (inst.Color == global.Level.SwitchBlock_ActiveColor)
    {
        inst.ImgIndex = 0;
        inst.Raised = false;
        SwitchBlock_SetWalls(inst);
    }
}

function SpawnEnemies(arg0, arg1 = -1)
{
    var EnemyAreaArray = struct_get_from_hash(array_get(struct_get_from_hash(global.Level.Rooms[arg0].Template, variable_get_hash("Sections")), global.Level.Rooms[arg0].Section_ID), variable_get_hash("Enemies"));
    var EnemyAreasInTemplate = array_length(EnemyAreaArray);
    
    if (EnemyAreasInTemplate == 0)
        return false;
    
    var RoomArea = global.Level.Rooms[arg0].GridW * global.Level.Rooms[arg0].GridH;
    var PackPoints_Min = floor((4 + (global.Level.Index / 4)) * RoomArea);
    var PackPoints_Max = floor((10 + global.Level.Index) * RoomArea);
    var _RoomSizeFactor = 1;
    
    switch (global.Level.Rooms[arg0].TemplateClass)
    {
        case UnknownEnum.Value_1:
            _RoomSizeFactor = 0.7;
            break;
        
        case UnknownEnum.Value_2:
            _RoomSizeFactor = 0.5;
            break;
    }
    
    PackPoints_Min = PackPoints_Min * _RoomSizeFactor;
    PackPoints_Max = PackPoints_Max * _RoomSizeFactor;
    var TotalPackPoints = min(irandom_range(PackPoints_Min, PackPoints_Max), 30);
    var EnemyTrap = false;
    var EnemyTrapOk = false;
    
    if (global.Level.Rooms[arg0].SpecialObject == UnknownEnum.Value_10)
    {
        var EnemyTrap_DoorsOk = true;
        
        for (var _DoorIndex = 0; _DoorIndex < array_length(global.Level.Rooms[arg0].Doors); _DoorIndex++)
        {
            var _Door = global.Level.Rooms[arg0].Doors[_DoorIndex];
            
            if (_Door.Status != UnknownEnum.Value_0)
            {
                EnemyTrap_DoorsOk = false;
                break;
            }
        }
        
        EnemyTrap = EnemyTrap_DoorsOk;
    }
    
    var EnemyList = ds_list_create();
    var EnemyTypes;
    
    for (var Pass = 0; Pass < 2; Pass++)
    {
        EnemyTypes = 0;
        
        for (var _ObjIndex = 0; _ObjIndex < array_length(global.EnemyData); _ObjIndex++)
        {
            if (Enemy_IsWall(_ObjIndex) || Enemy_IsObstacle(_ObjIndex))
                continue;
            
            if (global.Level.Index == UnknownEnum.Value_7)
            {
                if (Enemy_IsUnderground(_ObjIndex))
                {
                    if (!global.Level.Rooms[arg0].Sand || global.Level.Rooms[arg0].SpecialObject == UnknownEnum.Value_2)
                        continue;
                }
            }
            
            if (global.Level.Rooms[arg0].TemplateClass == UnknownEnum.Value_2 || global.Level.Rooms[arg0].Section_ID >= 25)
            {
                if (_ObjIndex == oEnemy_Bubble || _ObjIndex == oEnemy_Goriya || _ObjIndex == oEnemy_Kodongo || _ObjIndex == oEnemy_Wizzrobe || _ObjIndex == oEnemy_Bari)
                    continue;
                
                if (_ObjIndex == oEnemy_Soldier_Mace)
                    continue;
                
                if (Enemy_CanJump(_ObjIndex))
                {
                    if (GetPropertyValue(global.Level.Rooms[arg0].Template.properties, "NoJumpingEnemies") != -1)
                        continue;
                }
                
                if (Enemy_CanFly(_ObjIndex))
                {
                    if (GetPropertyValue(global.Level.Rooms[arg0].Template.properties, "NoFlyingEnemies") != -1)
                        continue;
                }
            }
            
            if (global.Level.Rooms[arg0].TemplateClass == UnknownEnum.Value_2)
            {
                if (_ObjIndex == oEnemy_Helmasaur || _ObjIndex == oEnemy_HardhatBeetle || _ObjIndex == oEnemy_Ropa || _ObjIndex == oEnemy_Hoarder)
                    continue;
                
                if (_ObjIndex == oEnemy_Leever)
                    continue;
            }
            
            if (EnemyTrap && !Enemy_GoodForTrap(_ObjIndex))
                continue;
            
            var _Data = global.EnemyData[_ObjIndex];
            
            if (!is_struct(_Data))
                continue;
            
            var EnemyMultiple = _Data.Levels[global.Level.Index];
            
            repeat (EnemyMultiple)
                ds_list_add(EnemyList, _ObjIndex);
            
            if (EnemyMultiple > 0)
                EnemyTypes++;
        }
        
        if (ds_list_size(EnemyList) == 0)
        {
            if (EnemyTrap)
            {
                EnemyTrap = false;
                continue;
            }
            else
            {
                ds_list_destroy(EnemyList);
                return false;
            }
        }
        
        break;
    }
    
    var EnemyTrapInst = EnemyTrap ? instance_create_layer(global.Level.Rooms[arg0].x + 16, global.Level.Rooms[arg0].y + 16, "System", oEnemyTrap, 
    {
        RoomIndex: arg0,
        X2: (global.Level.Rooms[arg0].x + global.Level.Rooms[arg0].width) - 17,
        Y2: (global.Level.Rooms[arg0].y + global.Level.Rooms[arg0].height) - 17
    }) : -4;
    var EnemyTypesSelected = irandom_range((global.Level.Rooms[arg0].SizeIndex == UnknownEnum.Value_0) ? 1 : 2, min(EnemyTypes, 3));
    ds_list_shuffle(EnemyList);
    
    if (arg1 == UnknownEnum.Value_20)
    {
        for (var _ObjIndex = 0; _ObjIndex < array_length(global.EnemyData); _ObjIndex++)
        {
            var _Data = global.EnemyData[_ObjIndex];
            
            if (!is_struct(_Data))
                continue;
            
            if (_Data.SpecialItem != 0)
            {
                var _KeyEnemyIndex = ds_list_find_index(EnemyList, _ObjIndex);
                
                if (_KeyEnemyIndex != -1)
                {
                    ds_list_delete(EnemyList, _KeyEnemyIndex);
                    ds_list_insert(EnemyList, 0, _ObjIndex);
                }
            }
        }
    }
    
    var EnemyChoiceList = ds_list_create();
    
    for (var i = 0; i < EnemyTypesSelected; i++)
        ds_list_add(EnemyChoiceList, ds_list_find_value(EnemyList, i));
    
    ds_list_destroy(EnemyList);
    var WallTypeEnemy = -1;
    var WallEnemiesList = ds_list_create();
    
    if (!global.SpawnedRollingSpikes && Prob(0.24))
    {
        if (!((global.Level.Rooms[arg0].TemplateClass == UnknownEnum.Value_1 && global.Level.Rooms[arg0].SizeIndex == UnknownEnum.Value_0) || global.Level.Rooms[arg0].TemplateClass == UnknownEnum.Value_2))
        {
            repeat (global.EnemyData[oEnemy_Beamos].Levels[global.Level.Index])
                ds_list_add(WallEnemiesList, oEnemy_Beamos);
            
            repeat (global.EnemyData[oEnemy_Cannon].Levels[global.Level.Index])
                ds_list_add(WallEnemiesList, oEnemy_Cannon);
        }
        
        repeat (global.EnemyData[oEnemy_Medusa].Levels[global.Level.Index])
            ds_list_add(WallEnemiesList, oEnemy_Medusa);
    }
    
    if (ds_list_size(WallEnemiesList) > 0)
    {
        ds_list_shuffle(WallEnemiesList);
        WallTypeEnemy = ds_list_find_value(WallEnemiesList, 0);
    }
    
    ds_list_destroy(WallEnemiesList);
    var Spawned = false;
    
    if (EnemyTrap)
        TotalPackPoints = ceil(TotalPackPoints * 1.2);
    
    while (TotalPackPoints > 0 && ds_list_size(EnemyChoiceList) > 0)
    {
        var PackPoints = 0;
        var EnemyIndex;
        
        if (WallTypeEnemy != -1)
        {
            EnemyIndex = WallTypeEnemy;
        }
        else
        {
            ds_list_shuffle(EnemyChoiceList);
            EnemyIndex = ds_list_find_value(EnemyChoiceList, 0);
            PackPoints = global.EnemyData[EnemyIndex].PackPoints;
            
            switch (EnemyIndex)
            {
                case oEnemy_Rat:
                    if (global.Level.Index == UnknownEnum.Value_5)
                        PackPoints = 1;
                    
                    break;
                
                case oEnemy_Buzz:
                    if (global.Level.Index == UnknownEnum.Value_5)
                        PackPoints = 2;
                    
                    break;
                
                case oEnemy_Bari:
                    if (global.Level.Index == UnknownEnum.Value_12)
                        PackPoints = 1.75;
                    
                    break;
            }
            
            if (PackPoints > TotalPackPoints)
            {
                ds_list_finddelete_all(EnemyChoiceList, EnemyIndex);
                continue;
            }
        }
        
        var SpawnedTry = false;
        var _ItemHolding;
        
        for (var Tries = 0; Tries < 75; Tries++)
        {
            var EnemyArea = EnemyAreaArray[irandom(EnemyAreasInTemplate - 1)];
            var EnemyAreaX = global.Level.Rooms[arg0].x + EnemyArea.x;
            var EnemyAreaY = global.Level.Rooms[arg0].y + EnemyArea.y;
            var _FloorLevel = GetFloorLevelID(EnemyAreaX, EnemyAreaY);
            var _FloorLevelStr = GetFloorLevelString(_FloorLevel);
            var EnemyX = EnemyAreaX + irandom(EnemyArea.width);
            var EnemyY = EnemyAreaY + irandom(EnemyArea.height);
            var MinDistFromWall = 8;
            var CheckForObjs = true;
            var _UsedSpaceType = UnknownEnum.Value_1;
            var _UsedSpaceBuffer = 0;
            
            switch (EnemyIndex)
            {
                case oEnemy_Beamos:
                case oEnemy_Medusa:
                case oEnemy_Cannon:
                    EnemyX = floor(EnemyX / 8) * 8;
                    EnemyY = floor(EnemyY / 8) * 8;
                    MinDistFromWall = 24;
                    _UsedSpaceType = UnknownEnum.Value_0;
                    _UsedSpaceBuffer = 16;
                    break;
                
                case oEnemy_Keese:
                case oEnemy_Zirro:
                    _FloorLevel = 2;
                    break;
                
                case oEnemy_Poe:
                    EnemyX = global.Level.Rooms[arg0].x + (128 * global.Level.Rooms[arg0].GridW);
                    EnemyY = global.Level.Rooms[arg0].y + 64;
                    _FloorLevel = 2;
                    CheckForObjs = false;
                    break;
                
                case oEnemy_Eyegore:
                case oEnemy_Hinox:
                case oEnemy_Wizzrobe:
                    _UsedSpaceBuffer = 8;
                    break;
                
                case oEnemy_Kyameron_Emitter:
                case oEnemy_Hover:
                    if (!OnWaterTile((_FloorLevel == 1) ? global.TMID_Water_Upper : global.TMID_Water_Lower, EnemyX, EnemyY))
                        continue;
                    
                    break;
                
                case oEnemy_Geldman:
                    MinDistFromWall = 24;
                
                case oEnemy_Delavant:
                case oEnemy_Leever:
                    if (!OnSandTile((_FloorLevel == 1) ? global.TMID_Floor_Upper : global.TMID_Floor_Lower, EnemyX, EnemyY))
                        continue;
                    
                    break;
            }
            
            var _EnemySprite = object_get_sprite(EnemyIndex);
            var _SpriteOffsetX = sprite_get_xoffset(_EnemySprite);
            var _SpriteOffsetY = sprite_get_yoffset(_EnemySprite);
            var _UsedSpaceX1 = (EnemyX + sprite_get_bbox_left(_EnemySprite)) - _SpriteOffsetX - _UsedSpaceBuffer;
            var _UsedSpaceY1 = (EnemyY + sprite_get_bbox_top(_EnemySprite)) - _SpriteOffsetY - _UsedSpaceBuffer;
            var _UsedSpaceX2 = ((EnemyX + sprite_get_bbox_right(_EnemySprite)) - _SpriteOffsetX) + _UsedSpaceBuffer;
            var _UsedSpaceY2 = ((EnemyY + sprite_get_bbox_bottom(_EnemySprite)) - _SpriteOffsetY) + _UsedSpaceBuffer;
            var EnemyIsInSection = InSectionArea(arg0, EnemyX, EnemyY, global.Level.Rooms[arg0].Section_ID, true);
            
            if (CheckForObjs)
            {
                if (UsedSpaceConflict(arg0, _UsedSpaceX1, _UsedSpaceY1, _UsedSpaceX2, _UsedSpaceY2, _UsedSpaceType, EnemyIsInSection))
                    continue;
            }
            
            _ItemHolding = -1;
            var CanHoldSpecialItem = (global.EnemyData[EnemyIndex].SpecialItem == 0) ? false : true;
            var CanHoldBonusItem = (global.EnemyData[EnemyIndex].Item == 0) ? false : true;
            
            if (arg1 != -1 && CanHoldSpecialItem && !global.EnemyHasSpecialItem)
                _ItemHolding = arg1;
            
            if (_ItemHolding == -1 && CanHoldBonusItem)
            {
                if (Prob(0.22))
                {
                    _ItemHolding = Probs_RandomItemClass_Pot(true, false);
                    
                    if (_ItemHolding == UnknownEnum.Value_12)
                        _ItemHolding = Probs_RandomItemClass_Pot(true, true);
                }
            }
            
            var EnemyInst = instance_create_layer(EnemyX, EnemyY, "Objs_" + _FloorLevelStr, EnemyIndex, 
            {
                FloorLevel: _FloorLevel,
                ItemHolding: _ItemHolding,
                SectionID: global.Level.Rooms[arg0].Section_ID,
                RoomIndex: arg0
            });
            
            if (CheckForObjs)
            {
                var WallCollisionInst, DistToWall, DistToDoor;
                
                with (EnemyInst)
                {
                    WallCollisionInst = ObjCollision(x, y, oWall, FloorLevel);
                    DistToWall = distance_to_object(oWall);
                    DistToDoor = distance_to_object(oDoor);
                }
                
                if (WallCollisionInst == -4 && DistToWall >= MinDistFromWall && DistToDoor >= 32)
                {
                    AddUsedSpace(arg0, _UsedSpaceX1, _UsedSpaceY1, _UsedSpaceX2, _UsedSpaceY2, _UsedSpaceType, EnemyIsInSection);
                    Spawned = true;
                    SpawnedTry = true;
                    break;
                }
                else
                {
                    instance_destroy(EnemyInst);
                }
            }
            else
            {
                Spawned = true;
                SpawnedTry = true;
                break;
            }
        }
        
        if (Spawned && _ItemHolding == arg1)
            global.EnemyHasSpecialItem = true;
        
        if (SpawnedTry)
        {
            TotalPackPoints -= PackPoints;
            
            if (Enemy_GoodForSpecialAttack(EnemyIndex))
                global.Level.Rooms[arg0].StarEnemyCount++;
            
            if (EnemyTrap && Enemy_GoodForTrap(EnemyIndex))
                EnemyTrapOk = true;
            
            if (EnemyIndex == oEnemy_Soldier_Mace)
                ds_list_finddelete_all(EnemyChoiceList, oEnemy_Soldier_Mace);
        }
        else
        {
            ds_list_finddelete_all(EnemyChoiceList, EnemyIndex);
        }
        
        WallTypeEnemy = -1;
    }
    
    ds_list_destroy(EnemyChoiceList);
    
    if (Spawned && EnemyTrapInst != -4 && EnemyTrap && EnemyTrapOk)
    {
        for (var _DoorIndex = 0; _DoorIndex < array_length(global.Level.Rooms[arg0].Doors); _DoorIndex++)
        {
            var _Door = global.Level.Rooms[arg0].Doors[_DoorIndex];
            _Door.Status = UnknownEnum.Value_1;
        }
        
        with (oDoor)
        {
            if (RoomIndex == arg0)
                Status = UnknownEnum.Value_1;
        }
    }
    else if (EnemyTrapInst != -4)
    {
        instance_destroy(EnemyTrapInst);
    }
    
    return Spawned;
}

function SpawnRollingSpikes(arg0)
{
    if (arg0 == global.Level.RoomIndex_Entrance)
        return false;
    
    if (global.Level.Rooms[arg0].Section_ID != 0)
        return false;
    
    if (array_get(struct_get_from_hash(array_get(global.EnemyData, oEnemy_RollingSpike), variable_get_hash("Levels")), global.Level.Index) == 0)
        return false;
    
    if (global.Level.MaxRollingSpikes == 0)
        return false;
    
    if (!Prob(0.3))
        return false;
    
    var RollingSpikeArray = struct_get_from_hash(array_get(struct_get_from_hash(global.Level.Rooms[arg0].Template, variable_get_hash("Sections")), global.Level.Rooms[arg0].Section_ID), variable_get_hash("RollingSpikes"));
    var RollingSpikesInTemplate = array_length(RollingSpikeArray);
    
    if (RollingSpikesInTemplate == 0)
        return false;
    
    var RollingSpikeList = ds_list_create_sequence_shuffled(0, RollingSpikesInTemplate - 1);
    var _SpawnRollingSpike = false;
    var PathWallList = ds_list_create();
    var RollingSpikeX, RollingSpikeY, RollingSpike, _PathAreaX1, _PathAreaY1, _PathAreaX2, _PathAreaY2, RollingSpikeIsInSection;
    
    for (var RollingSpikeIndex = 0; RollingSpikeIndex < RollingSpikesInTemplate; RollingSpikeIndex++)
    {
        RollingSpike = array_get(RollingSpikeArray, ds_list_find_value(RollingSpikeList, RollingSpikeIndex));
        RollingSpikeX = global.Level.Rooms[arg0].x + RollingSpike.x;
        RollingSpikeY = global.Level.Rooms[arg0].y + RollingSpike.y;
        RollingSpikeIsInSection = InSectionArea(arg0, RollingSpikeX, RollingSpikeY, global.Level.Rooms[arg0].Section_ID, true);
        
        switch (RollingSpike.gid)
        {
            case UnknownEnum.Value_219:
                _PathAreaX1 = RollingSpikeX;
                _PathAreaY1 = RollingSpikeY;
                _PathAreaX2 = _PathAreaX1 + 15;
                _PathAreaY2 = (_PathAreaY1 + RollingSpike.height) - 1;
                var tries = 60;
                
                while (--tries > 0)
                {
                    if (collision_rectangle_list(_PathAreaX1 - 8, _PathAreaY1, _PathAreaX1, _PathAreaY2, oWall, false, true, PathWallList, false) > 0)
                        break;
                    
                    _PathAreaX1 -= 8;
                }
                
                tries = 60;
                
                while (--tries > 0)
                {
                    if (collision_rectangle_list(_PathAreaX2, _PathAreaY1, _PathAreaX2 + 8, _PathAreaY2, oWall, false, true, PathWallList, false) > 0)
                        break;
                    
                    _PathAreaX2 += 8;
                }
                
                break;
            
            case UnknownEnum.Value_218:
                _PathAreaX1 = RollingSpikeX;
                _PathAreaY1 = RollingSpikeY;
                _PathAreaX2 = (_PathAreaX1 + RollingSpike.width) - 1;
                _PathAreaY2 = _PathAreaY1 + 15;
                var tries = 60;
                
                while (--tries > 0)
                {
                    if (collision_rectangle_list(_PathAreaX1, _PathAreaY1 - 8, _PathAreaX2, _PathAreaY1, oWall, false, true, PathWallList, false) > 0)
                        break;
                    
                    _PathAreaY1 -= 8;
                }
                
                tries = 60;
                
                while (--tries > 0)
                {
                    if (collision_rectangle_list(_PathAreaX1, _PathAreaY2, _PathAreaX2, _PathAreaY2 + 8, oWall, false, true, PathWallList, false) > 0)
                        break;
                    
                    _PathAreaY2 += 8;
                }
                
                break;
        }
        
        if (UsedSpaceConflict(arg0, _PathAreaX1, _PathAreaY1, _PathAreaX2, _PathAreaY2, UnknownEnum.Value_1, RollingSpikeIsInSection))
        {
            continue;
        }
        else
        {
            _SpawnRollingSpike = true;
            break;
        }
    }
    
    ds_list_destroy(PathWallList);
    ds_list_destroy(RollingSpikeList);
    
    if (!_SpawnRollingSpike)
        return false;
    
    var _FloorLevel = GetFloorLevelID(RollingSpikeX, RollingSpikeY);
    var FloorLevelStr = GetFloorLevelString(_FloorLevel);
    var RollingSpikeInst = instance_create_layer(RollingSpikeX, RollingSpikeY, "Objs_" + FloorLevelStr, oEnemy_RollingSpike, 
    {
        FloorLevel: _FloorLevel,
        ItemHolding: -4,
        SectionID: global.Level.Rooms[arg0].Section_ID,
        RoomIndex: arg0
    });
    
    switch (RollingSpike.gid)
    {
        case UnknownEnum.Value_219:
            RollingSpikeInst.sprite_index = sEnemy_RollingSpikes_H;
            RollingSpikeInst.vx = RollingSpikeInst.Speed;
            RollingSpikeInst.InitialVX = RollingSpikeInst.vx;
            RollingSpikeInst.H = RollingSpike.height;
            RollingSpikeInst.Dir = 1;
            break;
        
        case UnknownEnum.Value_218:
            RollingSpikeInst.sprite_index = sEnemy_RollingSpikes_V;
            RollingSpikeInst.vy = RollingSpikeInst.Speed;
            RollingSpikeInst.InitialVY = RollingSpikeInst.vy;
            RollingSpikeInst.W = RollingSpike.width;
            RollingSpikeInst.Dir = 2;
            break;
    }
    
    with (RollingSpikeInst)
        RollingSpikes_SetMaskSprite();
    
    AddUsedSpace(arg0, _PathAreaX1, _PathAreaY1, _PathAreaX2, _PathAreaY2, UnknownEnum.Value_1, RollingSpikeIsInSection, RollingSpikeInst);
    global.Level.MaxRollingSpikes--;
    return true;
}

function SpawnGuruBars(arg0)
{
    if (arg0 == global.Level.RoomIndex_Entrance)
        return false;
    
    if (global.Level.MaxGuruBars == 0)
        return false;
    
    if (array_get(struct_get_from_hash(array_get(global.EnemyData, oEnemy_Guru_Bar), variable_get_hash("Levels")), global.Level.Index) == 0)
        return false;
    
    if (global.Level.Rooms[arg0].Section_ID != 0)
        return false;
    
    if (global.SpawnedShop || global.SpawnedKinstone || ObstacleClassCheck(arg0, UnknownEnum.Value_3))
        return false;
    
    if (global.SpawnedRollingSpikes || global.SpawnedMovingSpikeBlocks)
        return false;
    
    if (global.Level.Rooms[arg0].SpecialObject == UnknownEnum.Value_10 && global.Level.Rooms[arg0].SizeIndex == UnknownEnum.Value_0 && global.Level.Rooms[arg0].LowerDoors)
        return false;
    
    if (!Prob(0.45))
        return false;
    
    var GuruBarArray = struct_get_from_hash(array_get(struct_get_from_hash(global.Level.Rooms[arg0].Template, variable_get_hash("Sections")), global.Level.Rooms[arg0].Section_ID), variable_get_hash("GuruBars"));
    var GuruBarsInTemplate = array_length(GuruBarArray);
    
    if (GuruBarsInTemplate == 0)
        return false;
    
    var _GuruBarList = ds_list_create_sequence_shuffled(0, GuruBarsInTemplate - 1);
    
    for (var GuruBarIndex = 0; GuruBarIndex < GuruBarsInTemplate; GuruBarIndex++)
    {
        var GuruBar = array_get(GuruBarArray, ds_list_find_value(_GuruBarList, GuruBarIndex));
        var _Angle = (GuruBar.height == 16) ? 0 : 90;
        var GuruBarX = global.Level.Rooms[arg0].x + GuruBar.x + ((_Angle == 0) ? 56 : 0);
        var GuruBarY = global.Level.Rooms[arg0].y + GuruBar.y + ((_Angle == 90) ? 56 : 0);
        var GuruBarIsInSection = InSectionArea(arg0, GuruBarX, GuruBarY, global.Level.Rooms[arg0].Section_ID, true);
        _Angle = (_Angle + irandom(360)) % 360;
        var _FloorLevel = GetFloorLevelID(GuruBarX, GuruBarY);
        var FloorLevelStr = GetFloorLevelString(_FloorLevel);
        var GuruBarInst = instance_create_layer(GuruBarX, GuruBarY, "Objs_" + FloorLevelStr, oEnemy_Guru_Bar, 
        {
            FloorLevel: _FloorLevel,
            ItemHolding: -4,
            SectionID: global.Level.Rooms[arg0].Section_ID,
            RoomIndex: arg0,
            Angle: _Angle,
            GurusDestroyed: false
        });
        var _UsedSpaceX1 = GuruBarX - 16;
        var _UsedSpaceY1 = GuruBarY - 16;
        var _UsedSpaceX2 = GuruBarX + 31;
        var _UsedSpaceY2 = GuruBarY + 31;
        
        if (!UsedSpaceConflict(arg0, _UsedSpaceX1, _UsedSpaceY1, _UsedSpaceX2, _UsedSpaceY2, UnknownEnum.Value_0, GuruBarIsInSection))
        {
            AddUsedSpace(arg0, _UsedSpaceX1, _UsedSpaceY1, _UsedSpaceX2, _UsedSpaceY2, UnknownEnum.Value_0, GuruBarIsInSection, GuruBarInst);
            break;
        }
        else
        {
            instance_destroy(GuruBarInst);
        }
    }
    
    ds_list_destroy(_GuruBarList);
    global.Level.MaxGuruBars--;
    return true;
}

function SpawnMovingSpikeBlocks(arg0)
{
    if (array_get(struct_get_from_hash(array_get(global.EnemyData, oEnemy_MovingSpikeBlock), variable_get_hash("Levels")), global.Level.Index) == 0)
        return false;
    
    if (arg0 == global.Level.RoomIndex_Entrance)
        return false;
    
    if (!Prob(0.35))
        return false;
    
    var SpikeArray = struct_get_from_hash(array_get(struct_get_from_hash(global.Level.Rooms[arg0].Template, variable_get_hash("Sections")), global.Level.Rooms[arg0].Section_ID), variable_get_hash("MovingSpikeBlocks"));
    var SpikesInTemplate = array_length(SpikeArray);
    
    if (SpikesInTemplate == 0)
        return false;
    
    var _Spikes = irandom_range(1, SpikesInTemplate);
    var _SpikeList = ds_list_create_sequence_shuffled(0, SpikesInTemplate - 1);
    
    for (var _SpikeIndex = 0; _SpikeIndex < _Spikes; _SpikeIndex++)
    {
        var Spike = array_get(SpikeArray, ds_list_find_value(_SpikeList, _SpikeIndex));
        var SpikeX = global.Level.Rooms[arg0].x + Spike.x;
        var SpikeY = global.Level.Rooms[arg0].y + Spike.y;
        var SpikeX2 = (SpikeX + Spike.width) - 1;
        var SpikeY2 = (SpikeY + Spike.height) - 1;
        var SpikeBlockInSection = InSectionArea(arg0, SpikeX, SpikeY, global.Level.Rooms[arg0].Section_ID, true);
        
        if (UsedSpaceConflict(arg0, SpikeX, SpikeY, SpikeX2, SpikeY2, UnknownEnum.Value_1, SpikeBlockInSection))
            continue;
        
        var _FloorLevel = GetFloorLevelID(SpikeX, SpikeY);
        var FloorLevelStr = GetFloorLevelString(_FloorLevel);
        var SpikeInst = instance_create_layer(SpikeX + 8, SpikeY + 8, "Objs_" + FloorLevelStr, oEnemy_MovingSpikeBlock, 
        {
            FloorLevel: _FloorLevel,
            ItemHolding: -4,
            SectionID: global.Level.Rooms[arg0].Section_ID,
            RoomIndex: arg0,
            W: Spike.width,
            H: Spike.height
        });
        AddUsedSpace(arg0, SpikeX, SpikeY, SpikeX2, SpikeY2, UnknownEnum.Value_1, SpikeBlockInSection, SpikeInst);
    }
    
    ds_list_destroy(_SpikeList);
    return true;
}

function SpawnPots(arg0, arg1, arg2)
{
    var PotsArray = struct_get_from_hash(array_get(struct_get_from_hash(global.Level.Rooms[arg0].Template, variable_get_hash("Sections")), global.Level.Rooms[arg0].Section_ID), variable_get_hash("Pots"));
    var PotsInTemplate = array_length(PotsArray);
    
    if (PotsInTemplate == 0)
        return false;
    
    global.PotGroupAmount = irandom_range(2, 4);
    global.PotSpawnedGroup = false;
    var Success = false;
    var Pots_Min = (global.Level.Rooms[arg0].SizeIndex == UnknownEnum.Value_0) ? 1 : 2;
    var Pots_Max = (global.Level.Rooms[arg0].SizeIndex == UnknownEnum.Value_0) ? 3 : 4;
    
    for (var ListIndex = 0; ListIndex < irandom_range(Pots_Min, Pots_Max); ListIndex++)
    {
        var SpawnedPot;
        
        switch (arg2)
        {
            case UnknownEnum.Value_20:
                SpawnedPot = SpawnObj(arg0, UnknownEnum.Value_0, arg1, -1, arg2);
                
                if (SpawnedPot)
                    arg2 = -1;
                
                break;
            
            case -1:
                var _InSection = FlipCoin_Bool();
                SpawnedPot = SpawnObj(arg0, UnknownEnum.Value_0, _InSection, -1, -99);
                
                if (!SpawnedPot)
                    SpawnedPot = SpawnObj(arg0, UnknownEnum.Value_0, !_InSection, -1, -99);
                
                break;
            
            case -2:
                SpawnedPot = SpawnObj(arg0, UnknownEnum.Value_0, arg1, -1, -1);
                break;
        }
        
        if (!Success && SpawnedPot)
            Success = true;
    }
    
    return Success;
}

function SpawnObj(arg0, arg1, arg2, arg3, arg4, arg5 = false)
{
    if (global.Level.Rooms[arg0].Section_ID == 0)
        arg2 = false;
    
    var Success = false;
    var _TemplateTypes = array_length(global.SpecialObjTemplateType[arg1]);
    var _TemplateTypeOrder = ds_list_create_sequence(0, _TemplateTypes - 1);
    
    if (arg1 != UnknownEnum.Value_6 && arg1 != UnknownEnum.Value_7)
        ds_list_shuffle(_TemplateTypeOrder);
    
    for (var _TemplateTypeIndex = 0; _TemplateTypeIndex < _TemplateTypes; _TemplateTypeIndex++)
    {
        var _TemplateType = array_get(array_get(global.SpecialObjTemplateType, arg1), ds_list_find_value(_TemplateTypeOrder, _TemplateTypeIndex));
        var _TemplateObjArray = variable_struct_get(array_get(struct_get_from_hash(global.Level.Rooms[arg0].Template, variable_get_hash("Sections")), global.Level.Rooms[arg0].Section_ID), _TemplateType);
        var _TemplateObjCanRotate = ds_list_find_index(global.TemplateObjsThatCanRotate, _TemplateType) != -1;
        var ObjCount = array_length(_TemplateObjArray);
        var ObjOrder = ds_list_create_sequence_shuffled(0, ObjCount - 1);
        
        for (var ObjIndex = 0; ObjIndex < ObjCount; ObjIndex++)
        {
            var Obj = array_get(_TemplateObjArray, ds_list_find_value(ObjOrder, ObjIndex));
            
            if (_TemplateObjCanRotate && struct_get_from_hash(Obj, variable_get_hash("rotation")) != 0)
                continue;
            
            var _ObjInSection = false;
            
            if (global.Level.Rooms[arg0].Section_ID != 0)
            {
                _ObjInSection = InSectionArea(arg0, Obj.x, Obj.y, global.Level.Rooms[arg0].Section_ID, false);
                
                if (arg2 && !_ObjInSection)
                    continue;
                
                if (!arg2 && _ObjInSection)
                    continue;
            }
            
            if (InUnusedZone(arg0, arg3, Obj) == UnknownEnum.Value_1)
                continue;
            
            var ObjUsed = CheckUsedObj(Obj);
            
            if (ObjUsed)
                continue;
            
            var ObjX1 = global.Level.Rooms[arg0].x + Obj.x;
            var ObjY1 = global.Level.Rooms[arg0].y + Obj.y;
            var ObjW = Obj.width;
            var ObjH = Obj.height;
            var ObjTilesW = ObjW / 8;
            var ObjTilesH = ObjH / 8;
            var ObjProperties = struct_get_from_hash(Obj, variable_get_hash("properties"));
            var xywhList = ds_list_create();
            ds_list_add(xywhList, ObjX1, ObjY1, ObjW, ObjH);
            TransformObj(arg0, Obj, xywhList);
            ObjX1 = ds_list_find_value(xywhList, 0);
            ObjY1 = ds_list_find_value(xywhList, 1);
            ObjW = ds_list_find_value(xywhList, 2);
            ObjH = ds_list_find_value(xywhList, 3);
            ds_list_destroy(xywhList);
            var ObjX = ObjX1;
            var ObjY = ObjY1;
            var ObjX2 = (ObjX1 + ObjW) - 1;
            var ObjY2 = (ObjY1 + ObjH) - 1;
            
            if (arg1 == UnknownEnum.Value_7)
            {
                if (collision_rectangle(ObjX1, ObjY1 - 8, ObjX2, ObjY1 - 1, oWall, false, true))
                    continue;
            }
            
            var _DoorDist = 16;
            var CheckDoorsLeft = collision_rectangle(ObjX1 - _DoorDist, ObjY1, ObjX1, ObjY2, oDoor, false, true);
            var CheckDoorsRight = collision_rectangle(ObjX2, ObjY1, ObjX2 + _DoorDist, ObjY2, oDoor, false, true);
            var CheckDoorsUp = collision_rectangle(ObjX1, ObjY1 - _DoorDist, ObjX2, ObjY1, oDoor, false, true);
            var CheckDoorsDown = collision_rectangle(ObjX1, ObjY2, ObjX2, ObjY2 + _DoorDist, oDoor, false, true);
            
            if (CheckDoorsLeft || CheckDoorsRight || CheckDoorsUp || CheckDoorsDown)
                continue;
            
            var SpawnItem = false;
            var _UsedSpaceX1 = ObjX1;
            var _UsedSpaceY1 = ObjY1;
            var _UsedSpaceX2 = ObjX2;
            var _UsedSpaceY2 = ObjY2;
            var _LooseKey = false;
            var TreasureItems;
            var _TorchLit;
            
            switch (arg1)
            {
                case UnknownEnum.Value_0:
                    if (global.Switch_Add && global.Level.Rooms[arg0].Switch.Action == UnknownEnum.Value_2)
                    {
                        var HiddenInstPointX, HiddenInstPointY;
                        
                        switch (global.Level.Rooms[arg0].Switch.HiddenObjInst.object_index)
                        {
                            default:
                                HiddenInstPointX = global.Level.Rooms[arg0].Switch.HiddenObjInst.x;
                                HiddenInstPointY = global.Level.Rooms[arg0].Switch.HiddenObjInst.y - 8;
                                break;
                            
                            case oWarp:
                                HiddenInstPointX = global.Level.Rooms[arg0].Switch.HiddenObjInst.x + 8;
                                HiddenInstPointY = global.Level.Rooms[arg0].Switch.HiddenObjInst.y + 8;
                                break;
                        }
                        
                        if (point_distance(ObjX + (ObjW / 2), ObjY + (ObjH / 2), HiddenInstPointX, HiddenInstPointY) < 48)
                            break;
                    }
                    
                    SpawnItem = !UsedSpaceConflict(arg0, _UsedSpaceX1, _UsedSpaceY1, _UsedSpaceX2, _UsedSpaceY2, UnknownEnum.Value_0, _ObjInSection);
                    break;
                
                case UnknownEnum.Value_1:
                    _UsedSpaceY2 += 16;
                    TreasureItems = 1;
                    
                    if (_TemplateType == "PotTreasures")
                    {
                        if (!global.Switch_Add || global.Level.Rooms[arg0].Switch.Action != UnknownEnum.Value_2)
                            TreasureItems = irandom_range(1, ObjTilesW / 2);
                        
                        while (TreasureItems > 0)
                        {
                            var ItemsW = TreasureItems * 16;
                            ObjX = ObjX1 + ((ObjW - ItemsW) / 2);
                            _UsedSpaceX1 = ObjX - 16;
                            _UsedSpaceX2 = ObjX + ItemsW + 15;
                            SpawnItem = !UsedSpaceConflict(arg0, _UsedSpaceX1, _UsedSpaceY1, _UsedSpaceX2, _UsedSpaceY2, UnknownEnum.Value_0, _ObjInSection);
                            
                            if (SpawnItem)
                                break;
                            else
                                TreasureItems--;
                        }
                    }
                    else if (arg4 == UnknownEnum.Value_20 && Prob(0.45) && !global.Switch_Add && global.Level.Rooms[arg0].Section_ID == 0 && global.Level.Rooms[arg0].TemplateClass != UnknownEnum.Value_2)
                    {
                        _LooseKey = true;
                        _UsedSpaceX1 = ObjX1 - 16;
                        _UsedSpaceY1 = ObjY1 - 16;
                        _UsedSpaceX2 = ObjX2 + 16;
                        _UsedSpaceY2 = ObjY2 + 16;
                        SpawnItem = !UsedSpaceConflict(arg0, _UsedSpaceX1, _UsedSpaceY1, _UsedSpaceX2, _UsedSpaceY2, UnknownEnum.Value_0, _ObjInSection);
                    }
                    else
                    {
                        _UsedSpaceX1 -= 16;
                        _UsedSpaceX2 += 16;
                        SpawnItem = !UsedSpaceConflict(arg0, _UsedSpaceX1, _UsedSpaceY1, _UsedSpaceX2, _UsedSpaceY2, UnknownEnum.Value_0, _ObjInSection) && !collision_rectangle(_UsedSpaceX1, _UsedSpaceY1, _UsedSpaceX2, _UsedSpaceY2, oWall, false, true);
                    }
                    
                    break;
                
                case UnknownEnum.Value_3:
                    _TorchLit = false;
                    var _TorchOk = true;
                    
                    with (oTorch)
                    {
                        if (RoomIndex == arg0)
                        {
                            if (point_distance(x + 8, y + 8, ObjX1 + 8, ObjY2 + 8) < 88)
                            {
                                _TorchOk = false;
                                break;
                            }
                        }
                    }
                    
                    if (_TorchOk)
                    {
                        if (!global.Switch_Add)
                            _TorchLit = (global.Level.Rooms[arg0].Lighting == 1) ? Prob(0.45) : true;
                        
                        if (!_TorchLit)
                        {
                            _UsedSpaceX1 = ObjX1 - 16;
                            _UsedSpaceY1 = ObjY1 - 16;
                            _UsedSpaceX2 = ObjX2 + 16;
                            _UsedSpaceY2 = ObjY2 + 16;
                        }
                        
                        SpawnItem = !UsedSpaceConflict(arg0, _UsedSpaceX1, _UsedSpaceY1, _UsedSpaceX2, _UsedSpaceY2, UnknownEnum.Value_0, _ObjInSection);
                    }
                    
                    break;
                
                case UnknownEnum.Value_2:
                case UnknownEnum.Value_6:
                    _UsedSpaceX1 = ObjX1 - 16;
                    _UsedSpaceY1 = ObjY1 - 16;
                    _UsedSpaceX2 = ObjX2 + 16;
                    _UsedSpaceY2 = ObjY2 + 16;
                    SpawnItem = !UsedSpaceConflict(arg0, _UsedSpaceX1, _UsedSpaceY1, _UsedSpaceX2, _UsedSpaceY2, UnknownEnum.Value_0, _ObjInSection);
                    break;
                
                case UnknownEnum.Value_8:
                    _UsedSpaceX1 = ObjX1 - 16;
                    _UsedSpaceY1 = ObjY1 - 16;
                    _UsedSpaceX2 = ObjX2 + 16;
                    _UsedSpaceY2 = ObjY2 + 16;
                    SpawnItem = !UsedSpaceConflict(arg0, _UsedSpaceX1, _UsedSpaceY1, _UsedSpaceX2, _UsedSpaceY2, UnknownEnum.Value_2, _ObjInSection);
                    break;
                
                case UnknownEnum.Value_7:
                    _UsedSpaceX1 = ObjX1 - 24;
                    _UsedSpaceY1 = ObjY1 - 24;
                    _UsedSpaceX2 = ObjX2 + 24;
                    _UsedSpaceY2 = ObjY2 + 24;
                    SpawnItem = !UsedSpaceConflict(arg0, _UsedSpaceX1, _UsedSpaceY1, _UsedSpaceX2, _UsedSpaceY2, UnknownEnum.Value_0, _ObjInSection);
                    break;
                
                case UnknownEnum.Value_5:
                    if (GetPropertyValue(ObjProperties, "NoDeadGuy") != -1 || (global.Level.Rooms[arg0].Section_ID > 0 && global.Level.Rooms[arg0].Section_WallType == UnknownEnum.Value_1 && GetPropertyValue(ObjProperties, "NoDeadGuySB") != -1))
                        break;
                    
                    if (collision_rectangle(ObjX1, ObjY2, ObjX2, ObjY2 + 32, oWall, false, true))
                        break;
                    
                    ObjX = (ObjX1 + (ObjW / 2)) - 8;
                    ObjW = 26;
                    _UsedSpaceX1 = ObjX;
                    _UsedSpaceY1 = ObjY;
                    _UsedSpaceX2 = (ObjX + ObjW) - 1;
                    _UsedSpaceY2 = ObjY2 + 16;
                    SpawnItem = !UsedSpaceConflict(arg0, _UsedSpaceX1, _UsedSpaceY1, _UsedSpaceX2, _UsedSpaceY2, UnknownEnum.Value_0, _ObjInSection);
                    break;
                
                case UnknownEnum.Value_4:
                    if (collision_rectangle(ObjX1, ObjY2, ObjX2, ObjY2 + 32, oWall, false, true))
                        break;
                    
                    ObjX = (ObjX1 + (ObjW / 2)) - 8;
                    ObjW = 16;
                    _UsedSpaceX1 = ObjX;
                    _UsedSpaceY1 = ObjY;
                    _UsedSpaceX2 = (ObjX + ObjW) - 1;
                    _UsedSpaceY2 = ObjY2 + 16;
                    SpawnItem = !UsedSpaceConflict(arg0, _UsedSpaceX1, _UsedSpaceY1, _UsedSpaceX2, _UsedSpaceY2, UnknownEnum.Value_0, _ObjInSection);
                    break;
            }
            
            if (SpawnItem)
            {
                var FloorLevel = GetFloorLevelID(ObjX, ObjY);
                var FloorLevelStr = GetFloorLevelString(FloorLevel);
                var _UsedSpaceType = UnknownEnum.Value_0;
                ds_list_add(global.UsedObjs, Obj);
                
                switch (arg1)
                {
                    case UnknownEnum.Value_0:
                        ObjTilesW = min(ObjTilesW / 2, global.PotGroupAmount);
                        ObjTilesH = min(ObjTilesH / 2, global.PotGroupAmount);
                        var _SpawnDir = GetPropertyValue(ObjProperties, "SpawnDir");
                        
                        if (_SpawnDir == -1 || _SpawnDir == "")
                        {
                            _SpawnDir = "R";
                            ObjTilesW = 1;
                            ObjTilesH = 1;
                        }
                        else if (_SpawnDir == "Any")
                        {
                            if (ObjTilesW > ObjTilesH)
                            {
                                _SpawnDir = choose("R", "L");
                            }
                            else if (ObjTilesH > ObjTilesW)
                            {
                                _SpawnDir = choose("U", "D");
                            }
                            else
                            {
                            }
                        }
                        else if (_SpawnDir == "Full")
                        {
                            if (global.PotSpawnedGroup)
                            {
                                continue;
                            }
                            else
                            {
                                ObjTilesW = ObjW / 16;
                                ObjTilesH = ObjH / 16;
                            }
                        }
                        
                        if (global.PotSpawnedGroup || (Prob(0.88) && _SpawnDir != "Full"))
                        {
                            ObjTilesW = 1;
                            ObjTilesH = 1;
                        }
                        
                        if (!global.PotSpawnedGroup && (ObjTilesW > 1 || ObjTilesH > 1) && !Prob(0.16))
                            global.PotSpawnedGroup = true;
                        
                        var _ObjContents = arg4;
                        var _FillWithSimpleItems = Prob(0.24);
                        var _FillItem = Probs_RandomItemClass_Pot(true, true);
                        
                        for (var _PotY = 0; _PotY < ObjTilesH; _PotY++)
                        {
                            for (var _PotX = 0; _PotX < ObjTilesW; _PotX++)
                            {
                                if (arg4 == -99)
                                    _ObjContents = _FillWithSimpleItems ? _FillItem : Probs_RandomItemClass_Pot(false, false);
                                
                                var _PosX, _PosY;
                                
                                switch (_SpawnDir)
                                {
                                    case "R":
                                    case "D":
                                    case "Full":
                                        _PosX = ObjX + (_PotX * 16);
                                        _PosY = ObjY + (_PotY * 16);
                                        break;
                                    
                                    case "L":
                                    case "U":
                                        _PosX = (ObjX + ObjW) - 16 - (_PotX * 16);
                                        _PosY = (ObjY + ObjH) - 16 - (_PotY * 16);
                                        break;
                                }
                                
                                var ObjInst = Pot_Create(arg0, _PosX, _PosY, _ObjContents, arg2);
                                arg4 = -99;
                            }
                        }
                        
                        switch (_SpawnDir)
                        {
                            case "R":
                            case "D":
                            case "Full":
                                _UsedSpaceX1 = ObjX;
                                _UsedSpaceY1 = ObjY;
                                _UsedSpaceX2 = (ObjX + (ObjTilesW * 16)) - 1;
                                _UsedSpaceY2 = (ObjY + (ObjTilesH * 16)) - 1;
                                break;
                            
                            case "L":
                            case "U":
                                _UsedSpaceX1 = (ObjX + ObjW) - (ObjTilesW * 16);
                                _UsedSpaceY1 = (ObjY + ObjH) - (ObjTilesH * 16);
                                _UsedSpaceX2 = (_UsedSpaceX1 + (ObjTilesW * 16)) - 1;
                                _UsedSpaceY2 = (_UsedSpaceY1 + (ObjTilesH * 16)) - 1;
                                break;
                        }
                        
                        break;
                    
                    case UnknownEnum.Value_1:
                        if (TreasureItems > 1)
                        {
                            SpawnTreasureRow(arg0, ObjX, ObjY, arg2, arg4, TreasureItems);
                        }
                        else if (_LooseKey)
                        {
                            FloorLevelStr = GetFloorLevelString(ObjX, ObjY);
                            instance_create_layer(ObjX + 8, ObjY + 16, "Objs_" + FloorLevelStr, oItem_Key);
                        }
                        else
                        {
                            var ObjInst = Treasure_Create(arg0, ObjX, ObjY, arg4, true, undefined, arg2);
                        }
                        
                        break;
                    
                    case UnknownEnum.Value_2:
                        var ObjInst = Crystal_Create(arg0, ObjX, ObjY);
                        break;
                    
                    case UnknownEnum.Value_4:
                        instance_create_layer(ObjX + (ObjW / 2), ObjY + 16, "Objs_" + FloorLevelStr, oHeartGuy, 
                        {
                            Type: choose(1, 2)
                        });
                        break;
                    
                    case UnknownEnum.Value_5:
                        if (Prob(0.5))
                        {
                            instance_create_layer(ObjX + (ObjW / 2), ObjY + 16, "Objs_" + FloorLevelStr, oHungryGuy);
                        }
                        else
                        {
                            if (arg4 == -1 && Prob(0.75))
                                arg4 = Probs_RandomItemClass(UnknownEnum.Value_2);
                            
                            instance_create_layer(ObjX + (ObjW / 2), ObjY + 16, "Objs_" + FloorLevelStr, oDeadGuy, 
                            {
                                ItemHolding: arg4
                            });
                        }
                        
                        break;
                    
                    case UnknownEnum.Value_3:
                        var inst = instance_create_layer(ObjX, ObjY, "Objs_" + FloorLevelStr, oTorch, 
                        {
                            RoomIndex: arg0,
                            Lit: _TorchLit
                        });
                        inst.GroupIndex = global.TorchGroupIndex;
                        
                        if (global.Switch_Add)
                        {
                            inst.Action = global.Level.Rooms[arg0].Switch.Action;
                            inst.HiddenObjInst = global.Level.Rooms[arg0].Switch.HiddenObjInst;
                            inst.IsSwitch = true;
                        }
                        
                        break;
                    
                    case UnknownEnum.Value_6:
                        var ObjInst = Warp_Create(arg0, ObjX, ObjY, FloorLevel);
                        break;
                    
                    case UnknownEnum.Value_7:
                        DrawTileBlock(GetFloorLevelTMID("Tiles_Water", ObjX, ObjY), ObjX, ObjY, 9, 0, 2, 2);
                        global.Level.Rooms[arg0].WarpDest_X = ObjX + 8;
                        global.Level.Rooms[arg0].WarpDest_Y = ObjY + 8;
                        break;
                    
                    case UnknownEnum.Value_8:
                        global.SpawnedStarInst = instance_create_layer(ObjX + (ObjW / 2), ObjY + 16, "Objs_" + FloorLevelStr, oItem_Star, 
                        {
                            From: UnknownEnum.Value_22
                        });
                        break;
                }
                
                AddUsedSpace(arg0, _UsedSpaceX1, _UsedSpaceY1, _UsedSpaceX2, _UsedSpaceY2, _UsedSpaceType, _ObjInSection);
                Success = true;
                break;
            }
            
            if (Success)
                break;
        }
        
        ds_list_destroy(ObjOrder);
        
        if (Success)
            break;
    }
    
    if (Success && arg3 != -1)
        global.Level.Rooms[arg0].UnusedZone = -1;
    
    ds_list_destroy(_TemplateTypeOrder);
    return Success;
}

function SpawnTreasureRow(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var Patterns = ds_list_create();
    
    switch (arg5)
    {
        case 1:
            ds_list_add(Patterns, "*");
            break;
        
        case 2:
            ds_list_add(Patterns, "*p", "*p", "p*", "p*", "*t", "t*");
            break;
        
        case 3:
            ds_list_add(Patterns, "p*p", "p*p", "p*p", "p*P", "p*P", "*pt", "tp*", "t*t");
            break;
        
        case 4:
            ds_list_add(Patterns, "p*tp", "p*tP", "pt*p", "pt*P", "*ppt", "tpp*", "tpP*", "*pPt", "t*tt", "tt*t");
            break;
        
        case 5:
            ds_list_add(Patterns, "pp*pp", "pp*pp", "pp*PP", "pP*Pp", "ptp*p", "P*ptP", "tp*pt", "pt*tp", "tp*pt", "pt*tp", "tt*tt");
            break;
        
        default:
            return false;
    }
    
    var Pattern = ds_list_find_value(Patterns, irandom(ds_list_size(Patterns) - 1));
    PotContents1 = Probs_RandomItemClass_Pot(true);
    PotContents2 = Probs_RandomItemClass_Pot(true);
    
    for (var StrIndex = 0; StrIndex < arg5; StrIndex++)
    {
        var ItemCode = string_copy(Pattern, StrIndex + 1, 1);
        var ItemX = arg1 + (StrIndex * 16);
        
        if (ItemCode == "*" && arg4 == -1)
            ItemCode = choose("p", "P", "t");
        
        switch (ItemCode)
        {
            case "*":
                var TreasureInst = Treasure_Create(arg0, ItemX, arg2, arg4, true, undefined, arg3);
                break;
            
            case "t":
                var TreasureInst = Treasure_Create(arg0, ItemX, arg2, -99, true, undefined, arg3);
                break;
            
            case "p":
                Pot_Create(arg0, ItemX, arg2, PotContents1, arg3);
                break;
            
            case "P":
                Pot_Create(arg0, ItemX, arg2, PotContents2, arg3);
                break;
        }
    }
    
    AddUsedSpace(arg0, arg1 - 16, arg2, arg1 + (arg5 * 16) + 15, arg2 + 31, UnknownEnum.Value_0, arg3);
    ds_list_destroy(Patterns);
    return true;
}

function SpawnKinstone(arg0, arg1)
{
    if (global.Level.Index == UnknownEnum.Value_1)
        return false;
    
    if (ObstacleClassCheck(arg0, UnknownEnum.Value_3) || global.SpawnedRollingSpikes || global.SpawnedMovingSpikeBlocks)
        return false;
    
    if (global.Level.Rooms[arg0].SpecialObject == UnknownEnum.Value_10 && global.Level.Rooms[arg0].SizeIndex == UnknownEnum.Value_0 && global.Level.Rooms[arg0].LowerDoors)
        return false;
    
    if (!Prob(0.11))
        return false;
    
    var KinstoneArray = struct_get_from_hash(array_get(struct_get_from_hash(global.Level.Rooms[arg0].Template, variable_get_hash("Sections")), global.Level.Rooms[arg0].Section_ID), variable_get_hash("Kinstones"));
    var Kinstones = array_length(KinstoneArray);
    
    if (Kinstones == 0)
        return false;
    
    var KinstoneIndexList = ds_list_create();
    
    for (var KinstoneIndex = 0; KinstoneIndex < Kinstones; KinstoneIndex++)
        ds_list_add(KinstoneIndexList, KinstoneIndex);
    
    ds_list_shuffle(KinstoneIndexList);
    var _RodCharger = !global.Level.RodCharger ? Prob(0.45) : false;
    var KinstoneOK, KinstoneX, KinstoneY, Kinstone, _UsedSpaceX1, _UsedSpaceY1, _UsedSpaceX2, _UsedSpaceY2, KinstoneInSection;
    
    for (var KinstoneIndex = 0; KinstoneIndex < ds_list_size(KinstoneIndexList); KinstoneIndex++)
    {
        KinstoneOK = true;
        Kinstone = array_get(KinstoneArray, ds_list_find_value(KinstoneIndexList, KinstoneIndex));
        KinstoneX = global.Level.Rooms[arg0].x + Kinstone.x;
        KinstoneY = global.Level.Rooms[arg0].y + Kinstone.y;
        var KinstoneX2 = KinstoneX + 31;
        var KinstoneY2 = KinstoneY + 31;
        KinstoneInSection = InSectionArea(arg0, KinstoneX, KinstoneY, global.Level.Rooms[arg0].Section_ID, true);
        var xywhList = ds_list_create();
        ds_list_add(xywhList, KinstoneX, KinstoneY, 32, 32);
        TransformObj(arg0, Kinstone, xywhList);
        KinstoneX = ds_list_find_value(xywhList, 0);
        KinstoneY = ds_list_find_value(xywhList, 1);
        ds_list_destroy(xywhList);
        
        if (InUnusedZone(arg0, arg1, Kinstone) == UnknownEnum.Value_1)
        {
            KinstoneOK = false;
        }
        else
        {
            if (global.SpawnedCarpetStyle == UnknownEnum.Value_1)
            {
                var TMID = GetFloorLevelTMID("Tiles_Floor", KinstoneX, KinstoneY);
                
                if (CornersOnCarpet(TMID, KinstoneX, KinstoneY, KinstoneX2, KinstoneY2) > 1)
                {
                    KinstoneOK = false;
                    continue;
                }
            }
            
            if (collision_rectangle(KinstoneX - 16, KinstoneY - 16, KinstoneX + 47, KinstoneY + 63, oWall, false, true))
            {
                KinstoneOK = false;
            }
            else if (collision_rectangle(KinstoneX, KinstoneY - 32, KinstoneX2, KinstoneY, oDoor, false, true))
            {
                KinstoneOK = false;
            }
            else if (collision_rectangle(KinstoneX, KinstoneY2 + 1, KinstoneX2, KinstoneY2 + 32, oDoor, false, true))
            {
                KinstoneOK = false;
            }
            else if (collision_rectangle(KinstoneX - 32, KinstoneY, KinstoneX, KinstoneY2, oDoor, false, true))
            {
                KinstoneOK = false;
            }
            else if (collision_rectangle(KinstoneX2 + 1, KinstoneY, KinstoneX2 + 32, KinstoneY2, oDoor, false, true))
            {
                KinstoneOK = false;
            }
            else
            {
                _UsedSpaceX1 = KinstoneX - 16;
                _UsedSpaceY1 = KinstoneY - 16;
                _UsedSpaceX2 = KinstoneX2 + 16;
                _UsedSpaceY2 = KinstoneY2 + (_RodCharger ? 16 : 32);
                
                if (UsedSpaceConflict(arg0, _UsedSpaceX1, _UsedSpaceY1, _UsedSpaceX2, _UsedSpaceY2, UnknownEnum.Value_0, KinstoneInSection))
                    KinstoneOK = false;
                else if (KinstoneOK)
                    break;
            }
        }
    }
    
    if (KinstoneOK)
    {
        var xywhList = ds_list_create();
        ds_list_add(xywhList, KinstoneX, KinstoneY, 32, 32);
        TransformObj(arg0, Kinstone, xywhList);
        KinstoneX = ds_list_find_value(xywhList, 0);
        KinstoneY = ds_list_find_value(xywhList, 1);
        ds_list_destroy(xywhList);
        var FloorLevelStr = GetFloorLevelString(KinstoneX, KinstoneY);
        DrawTileBlock(GetFloorLevelTMID("Tiles_Walls", KinstoneX, KinstoneY), KinstoneX, KinstoneY, 32 + (_RodCharger ? 4 : 0), 0, 4, 4);
        WallObj_Create("Objs_" + FloorLevelStr, KinstoneX, KinstoneY, 1, 4);
        WallObj_Create("Objs_" + FloorLevelStr, KinstoneX + 8, KinstoneY + 8, 2, 3);
        WallObj_Create("Objs_" + FloorLevelStr, KinstoneX + 24, KinstoneY, 1, 4);
        var WallInst = WallObj_Create("Objs_" + FloorLevelStr, KinstoneX + 8, KinstoneY, 2, 1);
        WallInst.BlockLink = false;
        var inst;
        
        if (_RodCharger)
        {
            inst = instance_create_layer(KinstoneX + 16, KinstoneY + 14, "ObjsHigher_" + FloorLevelStr, oRodCharger, 
            {
                RoomIndex: arg0
            });
            SignCreate(KinstoneX + 16, KinstoneY + 32, global.RodChargerSignText, true);
            global.Level.RodCharger = true;
        }
        else
        {
            inst = instance_create_layer(KinstoneX + 16, KinstoneY + 14, "ObjsHigher_" + FloorLevelStr, oItem_Kinstone_Main, 
            {
                Index: Kinstone_PickIndex(),
                RoomIndex: arg0
            });
            SignCreate(KinstoneX + 16, KinstoneY + 32, global.KinstoneSignText, true);
        }
        
        AddUsedSpace(arg0, _UsedSpaceX1, _UsedSpaceY1, _UsedSpaceX2, _UsedSpaceY2, UnknownEnum.Value_0, KinstoneInSection);
        ds_list_add(global.LargeMapItems, inst);
        
        if (arg1 != -1)
            global.Level.Rooms[arg0].UnusedZone = -1;
    }
    
    ds_list_destroy(KinstoneIndexList);
    return KinstoneOK;
}

function SpawnJail(arg0, arg1)
{
    var JailArray = struct_get_from_hash(array_get(struct_get_from_hash(global.Level.Rooms[arg0].Template, variable_get_hash("Sections")), global.Level.Rooms[arg0].Section_ID), variable_get_hash("Jails"));
    var Jails = array_length(JailArray);
    
    if (Jails == 0)
        return false;
    
    var JailIndexList = ds_list_create_sequence_shuffled(0, Jails - 1);
    var JailOK = false;
    
    for (var JailIndex = 0; JailIndex < Jails; JailIndex++)
    {
        var Jail = array_get(JailArray, ds_list_find_value(JailIndexList, JailIndex));
        
        if (struct_get_from_hash(Jail, variable_get_hash("rotation")) != 0)
            continue;
        
        var JailX = global.Level.Rooms[arg0].x + Jail.x;
        var JailY = global.Level.Rooms[arg0].y + Jail.y;
        var JailX2 = (JailX + Jail.width) - 1;
        var JailY2 = (JailY + Jail.height) - 1;
        var JailTileW = Jail.width / 8;
        var JailTileH = Jail.height / 8;
        var Properties = struct_get_from_hash(Jail, variable_get_hash("properties"));
        var PrisonerAllowed = GetPropertyValue(Properties, "NoPrisoner") == -1;
        var TilesW_LeftSide = floor(JailTileW / 2);
        var RightSideX = JailX + (TilesW_LeftSide * 8);
        
        if (collision_rectangle(JailX, JailY, JailX2, JailY2, oDoor, false, true))
            continue;
        
        JailOK = true;
        var FoundLockedDoor = false;
        var DoorList = ds_list_create();
        var DoorCheckWide = GetPropertyValue(Properties, "DoorCheckWide") != -1;
        var DoorCount;
        
        if (DoorCheckWide)
        {
            var _x1 = global.Level.Rooms[arg0].x + 16;
            var _y1 = global.Level.Rooms[arg0].y + 16;
            var _x2 = (_x1 + global.Level.Rooms[arg0].width) - 17;
            DoorCount = collision_rectangle_list(_x1, _y1, _x2, JailY, oDoor, false, true, DoorList, false);
        }
        else
        {
            DoorCount = collision_rectangle_list(JailX, global.Level.Rooms[arg0].y + 16, JailX2, JailY, oDoor, false, true, DoorList, false);
        }
        
        if (DoorCount == 1 && global.Level.Rooms[arg0].Section_ID == 0)
        {
            var DoorInst = ds_list_find_value(DoorList, 0);
            
            if (DoorInst.Status == UnknownEnum.Value_2)
            {
                DoorInst.Status = UnknownEnum.Value_0;
                var i = ds_list_find_index(global.LargeMapItems, DoorInst);
                
                if (i != -1)
                    ds_list_delete(global.LargeMapItems, i);
                
                FoundLockedDoor = true;
            }
        }
        
        var _JailType = (DoorCount == 0 && PrisonerAllowed) ? UnknownEnum.Value_0 : (FoundLockedDoor ? UnknownEnum.Value_2 : UnknownEnum.Value_1);
        Dungeon_Draw_Jail(arg0, JailX, JailY, JailTileW, JailTileH, _JailType);
        ds_list_destroy(DoorList);
        
        if (arg1 != -1)
            global.Level.Rooms[arg0].UnusedZone = -1;
    }
    
    ds_list_destroy(JailIndexList);
    return JailOK;
}

function CheckUsedObj(arg0)
{
    for (var ObjIndex = 0; ObjIndex < ds_list_size(global.UsedObjs); ObjIndex++)
    {
        if (ds_list_find_value(global.UsedObjs, ObjIndex) == arg0)
            return true;
    }
    
    return false;
}

function PlatformVerify(arg0, arg1, arg2, arg3 = 14)
{
    var AltarsArray = struct_get_from_hash(array_get(struct_get_from_hash(global.Level.Rooms[arg0].Template, variable_get_hash("Sections")), global.Level.Rooms[arg0].Section_ID), variable_get_hash("Altars"));
    var AltarsInTemplate = array_length(AltarsArray);
    
    if (AltarsInTemplate == 0)
        return false;
    
    var AltarsList = ds_list_create_sequence_shuffled(0, AltarsInTemplate - 1);
    var AltarValid = false;
    var AltarX2, AltarX1, Option_StickLeft, Option_StickRight, AltarY2, AltarY1, AltarInSection;
    
    for (var AltarListIndex = 0; AltarListIndex < AltarsInTemplate; AltarListIndex++)
    {
        var AltarIndex = ds_list_find_value(AltarsList, AltarListIndex);
        var Altar = AltarsArray[AltarIndex];
        
        if (struct_get_from_hash(Altar, variable_get_hash("rotation")) != 0)
            continue;
        
        AltarValid = false;
        AltarX1 = global.Level.Rooms[arg0].x + Altar.x;
        AltarY1 = global.Level.Rooms[arg0].y + Altar.y;
        AltarW = Altar.width;
        AltarH = Altar.height;
        var xywhList = ds_list_create();
        ds_list_add(xywhList, AltarX1, AltarY1, AltarW, AltarH);
        TransformObj(arg0, Altar, xywhList);
        AltarX1 = ds_list_find_value(xywhList, 0);
        AltarY1 = ds_list_find_value(xywhList, 1);
        AltarW = ds_list_find_value(xywhList, 2);
        AltarH = ds_list_find_value(xywhList, 3);
        ds_list_destroy(xywhList);
        AltarX2 = (AltarX1 + AltarW) - 1;
        AltarY2 = (AltarY1 + AltarH) - 1;
        AltarInSection = InSectionArea(arg0, AltarX1, AltarY1, global.Level.Rooms[arg0].Section_ID, true);
        
        if ((!arg1 && AltarInSection) || (arg1 && !AltarInSection))
            continue;
        
        if (InUnusedZone(arg0, arg2, Altar) == UnknownEnum.Value_1)
            continue;
        
        Option_StickLeft = true;
        Option_StickRight = true;
        var DoorCollisionList = ds_list_create();
        var Collisions = collision_rectangle_list(AltarX1 - 24, AltarY1, AltarX2 + 24, AltarY2, oDoor, false, true, DoorCollisionList, false);
        
        for (var DoorIndex = 0; DoorIndex < Collisions; DoorIndex++)
        {
            var DoorInst = ds_list_find_value(DoorCollisionList, DoorIndex);
            var DoorInSection = InSectionArea(arg0, DoorInst.x, DoorInst.y, global.Level.Rooms[arg0].Section_ID, true);
            
            if (DoorInSection != AltarInSection)
                continue;
            
            switch (DoorInst.Location)
            {
                case "Left":
                    AltarX1 = DoorInst.x + 48;
                    Option_StickLeft = false;
                    break;
                
                case "Right":
                    AltarX2 = DoorInst.x - 23;
                    Option_StickRight = false;
                    break;
            }
        }
        
        var CheckDoorCollisions = true;
        
        while (CheckDoorCollisions)
        {
            ds_list_clear(DoorCollisionList);
            Collisions = collision_rectangle_list(AltarX1, AltarY1 - 24, AltarX2, AltarY2, oDoor, false, true, DoorCollisionList, false);
            CheckDoorCollisions = false;
            
            for (var DoorIndex = 0; DoorIndex < Collisions; DoorIndex++)
            {
                var DoorInst = ds_list_find_value(DoorCollisionList, DoorIndex);
                var DoorInSection = InSectionArea(arg0, DoorInst.x, DoorInst.y, global.Level.Rooms[arg0].Section_ID, true);
                
                if (DoorInSection != AltarInSection)
                    continue;
                
                switch (DoorInst.Location)
                {
                    case "Top":
                        var DoorCenterX = DoorInst.x + 16;
                        var DistFromX1 = abs(DoorCenterX - AltarX1);
                        var DistFromX2 = abs(DoorCenterX - AltarX2);
                        
                        if (abs(DistFromX2 - DistFromX1) <= 1)
                        {
                            if (FlipCoin_Bool())
                            {
                                AltarX1 = DoorInst.x + 32;
                                CheckDoorCollisions = true;
                                Option_StickLeft = false;
                            }
                            else
                            {
                                AltarX2 = DoorInst.x - 1;
                                CheckDoorCollisions = true;
                                Option_StickRight = false;
                            }
                        }
                        else if (DistFromX1 < DistFromX2)
                        {
                            AltarX1 = DoorInst.x + 32;
                            CheckDoorCollisions = true;
                            Option_StickLeft = false;
                        }
                        else if (DistFromX2 < DistFromX1)
                        {
                            AltarX2 = DoorInst.x - 1;
                            CheckDoorCollisions = true;
                            Option_StickRight = false;
                        }
                        
                        break;
                }
                
                if (CheckDoorCollisions)
                    break;
            }
        }
        
        ds_list_destroy(DoorCollisionList);
        
        if (((AltarX2 - AltarX1) + 1) < 64)
            continue;
        
        if (UsedSpaceConflict(arg0, AltarX1 - 16, AltarY1, AltarX2 + 16, AltarY2 + 16, UnknownEnum.Value_0, AltarInSection))
            continue;
        
        AltarValid = true;
        break;
    }
    
    if (!AltarValid)
        return false;
    
    var AltarW = floor(((AltarX2 - AltarX1) + 1) / 16) * 16;
    var AltarTileW = AltarW / 8;
    var NewAltarTileW = min(arg3, irandom_range(4, AltarTileW / 2) * 2);
    var NewAltarW = NewAltarTileW * 8;
    var AltarX;
    
    if (Option_StickLeft && !Option_StickRight)
        AltarX = AltarX1;
    else if (Option_StickRight && !Option_StickLeft)
        AltarX = (AltarX2 - NewAltarW) + 1;
    else
        AltarX = AltarX1 + ((AltarW - NewAltarW) / 2);
    
    AltarW = NewAltarW;
    var AltarH = (AltarY2 - AltarY1) + 1;
    global.AltarData = 
    {
        x: AltarX,
        y: AltarY1,
        w: AltarW,
        h: AltarH,
        StickL: Option_StickLeft,
        StickR: Option_StickRight
    };
    AddUsedSpace(arg0, AltarX - 16, AltarY1, ((AltarX + AltarW) - 1) + 16, AltarY2 + 16, UnknownEnum.Value_0, AltarInSection);
    return true;
}

function AddUsedSpace(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7 = -4)
{
    array_push(global.Level.Rooms[arg0].UsedSpace, 
    {
        x1: arg1,
        y1: arg2,
        x2: arg3,
        y2: arg4,
        SpaceType: arg5,
        IsInSection: arg6,
        Inst: arg7
    });
}

function UsedSpaceConflict(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
{
    for (var UsedSpaceIndex = 0; UsedSpaceIndex < array_length(global.Level.Rooms[arg0].UsedSpace); UsedSpaceIndex++)
    {
        var _UsedSpace = global.Level.Rooms[arg0].UsedSpace[UsedSpaceIndex];
        
        if (_UsedSpace.IsInSection != arg6)
            continue;
        
        if (rectangle_in_rectangle(arg1, arg2, arg3, arg4, _UsedSpace.x1, _UsedSpace.y1, _UsedSpace.x2, _UsedSpace.y2) != 0 || rectangle_in_rectangle(_UsedSpace.x1, _UsedSpace.y1, _UsedSpace.x2, _UsedSpace.y2, arg1, arg2, arg3, arg4) != 0)
        {
            if (_UsedSpace.SpaceType == UnknownEnum.Value_0)
                return true;
            
            switch (arg5)
            {
                case UnknownEnum.Value_0:
                    return true;
                
                case UnknownEnum.Value_1:
                    if (_UsedSpace.SpaceType == UnknownEnum.Value_1)
                        return true;
                    
                    break;
                
                case UnknownEnum.Value_2:
                    if (_UsedSpace.SpaceType == UnknownEnum.Value_1)
                        continue;
                    
                    break;
            }
        }
    }
    
    return false;
}

function UsedSpaceDelInstSpace(arg0, arg1)
{
    for (var i = 0; i < array_length(global.Level.Rooms[arg0].UsedSpace); i++)
    {
        if (global.Level.Rooms[arg0].UsedSpace[i].Inst == arg1)
        {
            array_delete(global.Level.Rooms[arg0].UsedSpace, i, 1);
            break;
        }
    }
}

function InSectionArea(arg0, arg1, arg2, arg3, arg4)
{
    var SectionAreas = array_length(struct_get_from_hash(array_get(struct_get_from_hash(global.Level.Rooms[arg0].Template, variable_get_hash("Sections")), arg3), variable_get_hash("SectionArea")));
    
    for (var SectionAreaIndex = 0; SectionAreaIndex < SectionAreas; SectionAreaIndex++)
    {
        var SectionObj = array_get(struct_get_from_hash(array_get(struct_get_from_hash(global.Level.Rooms[arg0].Template, variable_get_hash("Sections")), arg3), variable_get_hash("SectionArea")), SectionAreaIndex);
        var SectionX = (arg4 ? global.Level.Rooms[arg0].x : 0) + SectionObj.x;
        var SectionY = (arg4 ? global.Level.Rooms[arg0].y : 0) + SectionObj.y;
        
        if (point_in_rectangle(arg1, arg2, SectionX, SectionY, (SectionX + SectionObj.width) - 1, (SectionY + SectionObj.height) - 1))
            return true;
    }
    
    return false;
}

function InZone(arg0, arg1)
{
    var Zones = array_length(struct_get_from_hash(array_get(struct_get_from_hash(global.Level.Rooms[arg0].Template, variable_get_hash("Sections")), global.Level.Rooms[arg0].Section_ID), variable_get_hash("Zones")));
    
    for (var ZoneIndex = 0; ZoneIndex < Zones; ZoneIndex++)
    {
        var Zone = array_get(struct_get_from_hash(array_get(struct_get_from_hash(global.Level.Rooms[arg0].Template, variable_get_hash("Sections")), global.Level.Rooms[arg0].Section_ID), variable_get_hash("Zones")), ZoneIndex);
        
        if (rectangle_in_rectangle(arg1.x, arg1.y, (arg1.x + arg1.width) - 1, (arg1.y + arg1.height) - 1, Zone.x, Zone.y, (Zone.x + Zone.width) - 1, (Zone.y + Zone.height) - 1) > 0)
            return ZoneIndex;
    }
    
    return -1;
}

function InUnusedZone(arg0, arg1, arg2)
{
    if (arg1 == -1)
        return UnknownEnum.Value_0;
    
    var _ZoneIndex = InZone(arg0, arg2);
    
    if (_ZoneIndex == arg1)
        return UnknownEnum.Value_2;
    
    return UnknownEnum.Value_1;
}

function TransformObj(arg0, arg1, arg2)
{
    var _x = ds_list_find_value(arg2, 0);
    var _y = ds_list_find_value(arg2, 1);
    var _w = ds_list_find_value(arg2, 2);
    var _h = ds_list_find_value(arg2, 3);
    
    if (struct_get_from_hash(array_get(global.Level.Rooms, arg0), variable_get_hash("Section_WallType")) == UnknownEnum.Value_1)
    {
        var Properties = struct_get_from_hash(arg1, variable_get_hash("properties"));
        var RoomTransform = struct_get_from_hash(global.Level.Rooms[arg0].Template, variable_get_hash("RoomTransformation"));
        var SBShiftCode = GetPropertyValue(Properties, "SBShift");
        
        if (SBShiftCode != -1)
        {
            var L = RealToBool(string_pos("L", SBShiftCode));
            var R = RealToBool(string_pos("R", SBShiftCode));
            var U = RealToBool(string_pos("U", SBShiftCode));
            var D = RealToBool(string_pos("D", SBShiftCode));
            
            if (L && (RoomTransform == UnknownEnum.Value_1 || RoomTransform == UnknownEnum.Value_3))
            {
                L = false;
                R = true;
            }
            else if (R && (RoomTransform == UnknownEnum.Value_1 || RoomTransform == UnknownEnum.Value_3))
            {
                R = false;
                L = true;
            }
            
            if (L)
                _x -= 8;
            
            if (R)
                _x += 8;
            
            if (U)
                _y -= 8;
            
            if (D)
                _y += 8;
        }
        
        SBShiftCode = GetPropertyValue(Properties, "SBResize");
        
        if (SBShiftCode != -1)
        {
            var L = RealToBool(string_pos("L", SBShiftCode));
            var R = RealToBool(string_pos("R", SBShiftCode));
            var U = RealToBool(string_pos("U", SBShiftCode));
            var D = RealToBool(string_pos("D", SBShiftCode));
            
            if (L && (RoomTransform == UnknownEnum.Value_1 || RoomTransform == UnknownEnum.Value_3))
            {
                L = false;
                R = true;
            }
            else if (R && (RoomTransform == UnknownEnum.Value_1 || RoomTransform == UnknownEnum.Value_3))
            {
                R = false;
                L = true;
            }
            
            if (L)
            {
                _x += 8;
                _w -= 8;
            }
            
            if (R)
                _w -= 8;
            
            if (U)
            {
                _y += 8;
                _h -= 8;
            }
            
            if (D)
                _h -= 8;
        }
    }
    
    ds_list_set(arg2, 0, _x);
    ds_list_set(arg2, 1, _y);
    ds_list_set(arg2, 2, _w);
    ds_list_set(arg2, 3, _h);
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
    Value_20 = 20,
    Value_22 = 22,
    Value_42 = 42,
    Value_47 = 47,
    Value_218 = 218,
    Value_219
}
