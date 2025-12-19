function RoomTemplates_Load()
{
    global.RoomTemplateObjTypes[UnknownEnum.Value_0] = ["Water", "CarpetsFull", "Carpets", "Spikes", "WallsUpper", "Doors", "ExtraCeilings", "OutOfBounds", "SplitConnections"];
    global.RoomTemplateObjTypes[UnknownEnum.Value_1] = ["Water", "CarpetsFull", "Carpets", "Spikes", "WallsLower", "WallsUpper", "Doors", "LowerFloor", "OutOfBounds", "SplitConnections"];
    global.RoomTemplateObjTypes[UnknownEnum.Value_2] = ["Water", "Spikes", "WallsLower", "WallsUpper", "WallsCommon", "Stairs", "Doors", "LowerFloor", "OutOfBounds"];
    global.RoomTemplateObjTypes[UnknownEnum.Value_3] = ["WallsUpper", "Objs", "Doors", "OutOfBounds"];
    global.RoomTemplateObjTypes[UnknownEnum.Value_6] = ["Pit", "Water", "CarpetsFull", "FloorObjs", "WallsLower", "Holes", "Spikes", "WallsUpper", "WallsCommon", "Doors"];
    global.RoomTemplateObjTypes[UnknownEnum.Value_7] = ["Pit", "Water", "Spikes", "WallsLower", "Holes", "WallsUpper", "WallsCommon", "Doors", "LowerFloor", "OutOfBounds"];
    global.RoomTemplateObjTypes[UnknownEnum.Value_8] = ["Water", "FloorObjs", "WallsLower", "WallsUpper", "Objs", "Doors", "LowerFloor", "OutOfBounds"];
    global.RoomTemplateObjTypes[UnknownEnum.Value_9] = ["Pit", "Holes", "Water", "FloorObjs", "WallsLower", "WallsUpper", "WallsCommon", "Objs", "Stairs", "Doors", "LowerFloor", "ExtraCeilings", "OutOfBounds"];
    global.RoomTemplateObjTypes[UnknownEnum.Value_4] = ["Pit", "Holes", "Water", "FloorObjs", "WallsLower", "WallsUpper", "WallsCommon", "Objs", "Doors", "LowerFloor", "ExtraCeilings", "OutOfBounds"];
    global.RoomTemplateObjTypes[UnknownEnum.Value_5] = ["Pit", "Holes", "Water", "FloorObjs", "WallsLower", "WallsUpper", "WallsCommon", "Objs", "Stairs", "Doors", "LowerFloor", "OutOfBounds"];
    global.RoomTemplateObjTypes_Section[UnknownEnum.Value_0] = ["SectionArea", "Zones", "Enemies", "SectionWalls", "MovingSpikeBlocks", "RollingSpikes", "GuruBars", "Jails", "Altars", "Kinstones", "Monuments", "Torches", "Crystals", "PotTreasures", "Treasures", "Pots"];
    global.RoomTemplateObjTypes_Section[UnknownEnum.Value_1] = ["Zones", "Enemies", "MovingSpikeBlocks", "GuruBars", "Altars", "Kinstones", "Monuments", "Torches", "Crystals", "PotTreasures", "Treasures", "Pots"];
    global.RoomTemplateObjTypes_Section[UnknownEnum.Value_2] = ["Zones", "Enemies", "MovingSpikeBlocks", "Altars", "Kinstones", "Monuments", "Torches", "Crystals", "PotTreasures", "Treasures", "Pots"];
    global.RoomTemplateObjTypes_Section[UnknownEnum.Value_3] = ["Zones", "Enemies", "Jails", "Altars", "Kinstones", "Monuments", "Torches", "PotTreasures", "Treasures", "Pots"];
    global.RoomTemplateObjTypes_Section[UnknownEnum.Value_6] = ["Zones", "Enemies", "MovingSpikeBlocks", "RollingSpikes", "GuruBars", "Altars", "Kinstones", "Monuments", "Torches", "Crystals", "PotTreasures", "Treasures", "Pots"];
    global.RoomTemplateObjTypes_Section[UnknownEnum.Value_7] = ["SectionArea", "Enemies", "SectionWalls", "MovingSpikeBlocks", "RollingSpikes", "GuruBars", "Altars", "Kinstones", "Monuments", "Torches", "Crystals", "PotTreasures", "Treasures", "Pots"];
    global.RoomTransformTypeList = ds_list_create_sequence(0, 7);
    global.MainSectionIndexes = [1, 2, 9, 17, 21, 25, 27];
    var ParsedTemplates_Buffer = buffer_load("data\\data_r");
    global.Templates_Room = json_parse(buffer_read(ParsedTemplates_Buffer, buffer_string));
    buffer_delete(ParsedTemplates_Buffer);
    ParsedTemplates_Buffer = -1;
    
    for (var _ClassIndex = 0; _ClassIndex < 10; _ClassIndex++)
    {
        var _SubClasses = array_length(global.Templates_Room[_ClassIndex]);
        
        for (var _SubClassIndex = 0; _SubClassIndex < _SubClasses; _SubClassIndex++)
        {
            global.Templates_Room_Count[_ClassIndex][_SubClassIndex] = array_length(global.Templates_Room[_ClassIndex][_SubClassIndex]);
            global.UnusedRoomTemplatesList[_ClassIndex][_SubClassIndex] = ds_list_create();
        }
    }
}

function RoomTemplate_GetNextIndex(arg0, arg1)
{
    if (ds_list_size(global.UnusedRoomTemplatesList[arg0][arg1]) == 0)
    {
        ds_list_destroy(global.UnusedRoomTemplatesList[arg0][arg1]);
        global.UnusedRoomTemplatesList[arg0][arg1] = ds_list_create_sequence_shuffled(0, global.Templates_Room_Count[arg0][arg1] - 1);
    }
    
    var _NextIndex = ds_list_find_value(array_get(array_get(global.UnusedRoomTemplatesList, arg0), arg1), 0);
    ds_list_delete(global.UnusedRoomTemplatesList[arg0][arg1], 0);
    return _NextIndex;
}

function RoomTemplates_Pick(arg0)
{
    switch (global.Level.Rooms[arg0].TemplateClass)
    {
        case UnknownEnum.Value_8:
            return RoomTemplates_PickSpecial(arg0);
        
        case UnknownEnum.Value_4:
            var _TemplateArray = global.Templates_Room[UnknownEnum.Value_4][global.Level.Rooms[arg0].TemplateSubClass];
            
            for (var _RoomTemplateIndex = 0; _RoomTemplateIndex < global.Templates_Room_Count[UnknownEnum.Value_4][global.Level.Rooms[arg0].TemplateSubClass]; _RoomTemplateIndex++)
            {
                var _Template = _TemplateArray[_RoomTemplateIndex];
                
                switch (global.Level.Rooms[arg0].TemplateSubClass)
                {
                    case UnknownEnum.Value_0:
                        if (struct_get_from_hash(_Template, variable_get_hash("name")) == string(arg0))
                            return _Template;
                        
                        break;
                    
                    case UnknownEnum.Value_3:
                        if (struct_get_from_hash(_Template, variable_get_hash("type")) == "Exit")
                            return _Template;
                        
                        break;
                    
                    case UnknownEnum.Value_2:
                        if (struct_get_from_hash(_Template, variable_get_hash("name")) == global.Level.Rooms[arg0].TemplateName)
                            return _Template;
                        
                        break;
                    
                    case UnknownEnum.Value_1:
                        if (struct_get_from_hash(_Template, variable_get_hash("type")) == "House")
                        {
                            if (GetPropertyValue(struct_get_from_hash(_Template, variable_get_hash("properties")), "House_MapGridX") == global.Level.Rooms[arg0].GridX && GetPropertyValue(struct_get_from_hash(_Template, variable_get_hash("properties")), "House_MapGridY") == global.Level.Rooms[arg0].GridY)
                            {
                                global.Level.Rooms[arg0].TemplateName = struct_get_from_hash(_Template, variable_get_hash("name"));
                                return _Template;
                            }
                        }
                        
                        break;
                }
            }
            
            break;
        
        case UnknownEnum.Value_5:
            var _TemplateArray = global.Templates_Room[UnknownEnum.Value_5][global.Level.Rooms[arg0].TemplateSubClass];
            
            for (var _RoomTemplateIndex = 0; _RoomTemplateIndex < global.Templates_Room_Count[UnknownEnum.Value_5][global.Level.Rooms[arg0].TemplateSubClass]; _RoomTemplateIndex++)
            {
                var _Template = _TemplateArray[_RoomTemplateIndex];
                
                switch (global.Level.Rooms[arg0].TemplateSubClass)
                {
                    case UnknownEnum.Value_0:
                        if (struct_get_from_hash(_Template, variable_get_hash("name")) == string(global.MainTemplates_Mine[global.Level.Rooms[arg0].GridY][global.Level.Rooms[arg0].GridX]))
                            return _Template;
                        
                        break;
                    
                    case UnknownEnum.Value_1:
                        if (struct_get_from_hash(_Template, variable_get_hash("type")) == "House")
                        {
                            if (GetPropertyValue(struct_get_from_hash(_Template, variable_get_hash("properties")), "House_MapGridX") == global.Level.Rooms[arg0].GridX && GetPropertyValue(struct_get_from_hash(_Template, variable_get_hash("properties")), "House_MapGridY") == global.Level.Rooms[arg0].GridY)
                            {
                                global.Level.Rooms[arg0].TemplateName = struct_get_from_hash(_Template, variable_get_hash("name"));
                                return _Template;
                            }
                        }
                        
                        break;
                }
            }
            
            break;
        
        case UnknownEnum.Value_9:
            var _TemplateArray = global.Templates_Room[UnknownEnum.Value_9][global.Level.Rooms[arg0].TemplateSubClass];
            
            for (var _RoomTemplateIndex = 0; _RoomTemplateIndex < global.Templates_Room_Count[UnknownEnum.Value_9][global.Level.Rooms[arg0].TemplateSubClass]; _RoomTemplateIndex++)
            {
                var _Template = _TemplateArray[_RoomTemplateIndex];
                
                switch (global.Level.Rooms[arg0].TemplateSubClass)
                {
                    case UnknownEnum.Value_1:
                        var _TemplateIndex;
                        
                        switch (arg0)
                        {
                            case 0:
                                _TemplateIndex = RoomTemplate_GetIndex(UnknownEnum.Value_9, UnknownEnum.Value_1, "South", "Start");
                                break;
                            
                            case 1:
                                _TemplateIndex = RoomTemplate_GetIndex(UnknownEnum.Value_9, UnknownEnum.Value_1, "North", "Start");
                                break;
                        }
                        
                        return global.Templates_Room[UnknownEnum.Value_9][UnknownEnum.Value_1][_TemplateIndex];
                        break;
                    
                    case UnknownEnum.Value_0:
                        switch (global.Level.Index)
                        {
                            case UnknownEnum.Value_11:
                                var _TemplateIndex = RoomTemplate_GetIndex(UnknownEnum.Value_9, UnknownEnum.Value_0, "Moldorm", "Boss");
                                return global.Templates_Room[UnknownEnum.Value_9][UnknownEnum.Value_0][_TemplateIndex];
                                break;
                            
                            default:
                                var _TemplateIndex = RoomTemplate_GetIndex(UnknownEnum.Value_9, UnknownEnum.Value_0, "Default", "Boss");
                                return global.Templates_Room[UnknownEnum.Value_9][UnknownEnum.Value_0][_TemplateIndex];
                                break;
                        }
                        
                        break;
                    
                    case UnknownEnum.Value_2:
                        if (struct_get_from_hash(_Template, variable_get_hash("name")) == global.Level.Rooms[arg0].TemplateName)
                            return _Template;
                        
                        break;
                    
                    case UnknownEnum.Value_3:
                        return global.Templates_Room[UnknownEnum.Value_9][UnknownEnum.Value_3][0];
                        break;
                }
            }
            
            break;
    }
    
    var _RoomTemplateClass = global.Level.Rooms[arg0].TemplateClass;
    var _RoomTemplateSubClass = global.Level.Rooms[arg0].TemplateSubClass;
    var _TemplateCount = global.Templates_Room_Count[_RoomTemplateClass][_RoomTemplateSubClass];
    
    if (_TemplateCount == 0)
        return -1;
    
    for (var _Tries = 0; _Tries < (_TemplateCount * 2); _Tries++)
    {
        var TemplateOk = false;
        var _RoomTemplateIndex = RoomTemplate_GetNextIndex(_RoomTemplateClass, _RoomTemplateSubClass);
        var RoomTemplate = global.Templates_Room[_RoomTemplateClass][_RoomTemplateSubClass][_RoomTemplateIndex];
        var _Properties = struct_get_from_hash(RoomTemplate, variable_get_hash("properties"));
        var _BuiltInSection;
        
        if (_RoomTemplateClass == UnknownEnum.Value_7)
        {
            _BuiltInSection = GetPropertyValue(struct_get_from_hash(RoomTemplate, variable_get_hash("properties")), "BuiltInSection");
            
            if (!SectionFamilyCheck(_BuiltInSection, global.Level.DungeonTemplate.Rooms[arg0].Section_ID))
                continue;
            
            if (global.Level.Rooms[arg0].Section_WallType == UnknownEnum.Value_1)
            {
                if (GetPropertyValue(_Properties, "SwitchBlock") == -1)
                    continue;
            }
        }
        
        if (arg0 == global.Level.RoomIndex_BossAdjacent && array_length(struct_get_from_hash(RoomTemplate, variable_get_hash("Holes"))) > 0)
            continue;
        
        ds_list_shuffle(global.RoomTransformTypeList);
        var NewRoomTemplate;
        
        for (var _TransformTypeIndex = 0; _TransformTypeIndex < 8; _TransformTypeIndex++)
        {
            var _TransformType = ds_list_find_value(global.RoomTransformTypeList, _TransformTypeIndex);
            global.Level.Rooms[arg0].UnusedZone = -1;
            
            if (!RoomTemplate.RoomTransformationsAllowed[_TransformType])
                continue;
            
            if (arg0 == global.Level.RoomIndex_BossAdjacent)
            {
                if (_TransformType != UnknownEnum.Value_0)
                    continue;
                
                if (GetPropertyValue(_Properties, "NoBossAdjacent") != -1)
                    continue;
            }
            
            if ((_RoomTemplateClass == UnknownEnum.Value_0 || _RoomTemplateClass == UnknownEnum.Value_1) && _RoomTemplateSubClass != UnknownEnum.Value_0)
            {
                switch (global.Level.Rooms[arg0].SizeIndex)
                {
                    case UnknownEnum.Value_1:
                        switch (_TransformType)
                        {
                            case UnknownEnum.Value_0:
                            case UnknownEnum.Value_1:
                            case UnknownEnum.Value_2:
                            case UnknownEnum.Value_3:
                                break;
                            
                            default:
                                continue;
                        }
                        
                        break;
                    
                    case UnknownEnum.Value_2:
                        switch (_TransformType)
                        {
                            case UnknownEnum.Value_4:
                            case UnknownEnum.Value_5:
                            case UnknownEnum.Value_6:
                            case UnknownEnum.Value_7:
                                break;
                            
                            default:
                                continue;
                        }
                        
                        break;
                }
            }
            
            var _RoomDoorCode = global.Level.Rooms[arg0].DoorCode;
            
            if ((RoomTemplate.DoorCode[_TransformType] & _RoomDoorCode) != _RoomDoorCode)
                continue;
            
            var _SectionOk = true;
            var _MainSectionID = 0;
            
            if (global.Level.DungeonTemplate.Rooms[arg0].Section_ID > 0)
            {
                if (_TransformType == UnknownEnum.Value_0)
                {
                    if (_RoomTemplateClass == UnknownEnum.Value_7)
                    {
                        if (_BuiltInSection != global.Level.DungeonTemplate.Rooms[arg0].Section_ID)
                            _SectionOk = false;
                    }
                    else if (array_get_index(RoomTemplate.Split_MainSectionIDs, global.Level.DungeonTemplate.Rooms[arg0].Section_ID) != -1)
                    {
                        _MainSectionID = global.Level.DungeonTemplate.Rooms[arg0].Section_ID;
                    }
                    else
                    {
                        _SectionOk = false;
                    }
                }
                else
                {
                    _SectionOk = false;
                    
                    if (_RoomTemplateClass == UnknownEnum.Value_7)
                    {
                        if (GetTransformedSectionIDReversed(_BuiltInSection, global.Level.DungeonTemplate.Rooms[arg0].Section_ID, global.Level.Rooms[arg0].SizeIndex == UnknownEnum.Value_2) == _TransformType)
                            _SectionOk = true;
                    }
                    else
                    {
                        for (_MainSectionIDIndex = 1; _MainSectionIDIndex < array_length(RoomTemplate.Split_MainSectionIDs); _MainSectionIDIndex++)
                        {
                            _MainSectionID = RoomTemplate.Split_MainSectionIDs[_MainSectionIDIndex];
                            
                            if (_MainSectionID == 0)
                                continue;
                            
                            if (GetTransformedSectionIDReversed(_MainSectionID, global.Level.DungeonTemplate.Rooms[arg0].Section_ID, global.Level.Rooms[arg0].SizeIndex == UnknownEnum.Value_2) == _TransformType)
                            {
                                _SectionOk = true;
                                break;
                            }
                        }
                    }
                }
            }
            
            if (!_SectionOk)
                continue;
            
            var ZonesArray = struct_get_from_hash(array_get(struct_get_from_hash(RoomTemplate, variable_get_hash("Sections")), global.Level.Rooms[arg0].Section_ID), variable_get_hash("Zones"));
            var Zones = array_length(ZonesArray);
            var ZoneStatus = array_create(Zones, false);
            var ZonesLeft = Zones;
            var Doors = array_length(struct_get_from_hash(array_get(global.Level.Rooms, arg0), variable_get_hash("Doors")));
            var _MainSectionIDsExist = variable_struct_exists(RoomTemplate, "Split_MainSectionIDs");
            var _MainSectionIDIndex = _MainSectionIDsExist ? array_get_index(RoomTemplate.Split_MainSectionIDs, _MainSectionID) : 0;
            
            if (arg0 == global.Level.RoomIndex_BossAdjacent)
            {
                Zones = 0;
                ZonesLeft = 0;
            }
            
            for (var _ZoneIndex = 0; _ZoneIndex < Zones; _ZoneIndex++)
            {
                var ZoneCode = RoomTemplate.ZoneCodes[_TransformType][_MainSectionIDIndex][_ZoneIndex];
                
                if (ZoneCode == 0)
                    continue;
                
                for (var _DoorIndex = 0; _DoorIndex < Doors; _DoorIndex++)
                {
                    var _Door = array_get(struct_get_from_hash(array_get(global.Level.Rooms, arg0), variable_get_hash("Doors")), _DoorIndex);
                    
                    if (_Door.Status == UnknownEnum.Value_11)
                        continue;
                    
                    var _DoorBit = power(2, _Door.Position - 1);
                    var _DoorInZone = _DoorBit & ZoneCode;
                    
                    if (_DoorInZone)
                    {
                        if (!ZoneStatus[_ZoneIndex])
                            ZonesLeft--;
                        
                        ZoneStatus[_ZoneIndex] = true;
                    }
                }
            }
            
            if (ZonesLeft > 1 || (ZonesLeft == 1 && (global.Level.Index == UnknownEnum.Value_1 && arg0 == global.Level.RoomIndex_Entrance)))
                continue;
            
            for (var ZoneIndex = 0; ZoneIndex < Zones; ZoneIndex++)
            {
                if (ZoneStatus[ZoneIndex] == false)
                {
                    global.Level.Rooms[arg0].UnusedZone = ZoneIndex;
                    break;
                }
            }
            
            if (ZonesLeft == 1 && (struct_get_from_hash(array_get(ZonesArray, global.Level.Rooms[arg0].UnusedZone), variable_get_hash("type")) == "NoObjects" || (!global.Level.Rooms[arg0].BonusTreasure && global.Level.Rooms[arg0].SpecialObject != UnknownEnum.Value_2 && global.Level.Rooms[arg0].SpecialObject != UnknownEnum.Value_1 && global.Level.Rooms[arg0].SpecialObject != UnknownEnum.Value_4)))
                continue;
            
            TemplateOk = true;
            NewRoomTemplate = StructCopy(RoomTemplate);
            var _TransformTemplate = _TransformType != UnknownEnum.Value_0 || _RoomTemplateClass == UnknownEnum.Value_7;
            
            if (_TransformTemplate)
            {
                switch (_TransformType)
                {
                    case UnknownEnum.Value_4:
                    case UnknownEnum.Value_5:
                    case UnknownEnum.Value_6:
                    case UnknownEnum.Value_7:
                        NewRoomTemplate.width = struct_get_from_hash(RoomTemplate, variable_get_hash("width"));
                        NewRoomTemplate.height = struct_get_from_hash(RoomTemplate, variable_get_hash("height"));
                        break;
                }
                
                for (var _ObjTypeIndex = 0; _ObjTypeIndex < array_length(global.RoomTemplateObjTypes[global.Level.Rooms[arg0].TemplateClass]); _ObjTypeIndex++)
                {
                    var _ObjType = global.RoomTemplateObjTypes[global.Level.Rooms[arg0].TemplateClass][_ObjTypeIndex];
                    variable_struct_set(NewRoomTemplate, _ObjType, TransformObjArray(variable_struct_get(NewRoomTemplate, _ObjType), _TransformType, _ObjType, struct_get_from_hash(NewRoomTemplate, variable_get_hash("width")), struct_get_from_hash(NewRoomTemplate, variable_get_hash("height"))));
                }
            }
            
            var NewSection = array_get(struct_get_from_hash(NewRoomTemplate, variable_get_hash("Sections")), global.Level.DungeonTemplate.Rooms[arg0].Section_ID);
            
            if (variable_struct_exists(NewRoomTemplate, "Sections") && _TransformTemplate)
            {
                for (var _ObjTypeIndex = 0; _ObjTypeIndex < array_length(global.RoomTemplateObjTypes_Section[global.Level.Rooms[arg0].TemplateClass]); _ObjTypeIndex++)
                {
                    var _ObjType = global.RoomTemplateObjTypes_Section[global.Level.Rooms[arg0].TemplateClass][_ObjTypeIndex];
                    var ObjArray = variable_struct_get(array_get(struct_get_from_hash(NewRoomTemplate, variable_get_hash("Sections")), _MainSectionID), _ObjType);
                    var NewObjArray = TransformObjArray(ObjArray, _TransformType, _ObjType, struct_get_from_hash(NewRoomTemplate, variable_get_hash("width")), struct_get_from_hash(NewRoomTemplate, variable_get_hash("height")));
                    variable_struct_set(NewSection, _ObjType, array_create(0));
                    
                    for (var _ObjIndex = 0; _ObjIndex < array_length(NewObjArray); _ObjIndex++)
                    {
                        var _Obj = NewObjArray[_ObjIndex];
                        array_push(variable_struct_get(NewSection, _ObjType), StructCopy(_Obj));
                    }
                }
            }
            
            break;
        }
        
        if (TemplateOk)
            return NewRoomTemplate;
    }
    
    return -1;
}

function RoomTemplates_PickSpecial(arg0)
{
    var SubClassList = ds_list_create();
    
    switch (global.Level.Index)
    {
        default:
            ds_list_add(SubClassList, UnknownEnum.Value_5, UnknownEnum.Value_5, UnknownEnum.Value_5, UnknownEnum.Value_5, UnknownEnum.Value_6, UnknownEnum.Value_6);
            
            if (global.Level.Rooms[arg0].Doors[0].Status == UnknownEnum.Value_8)
            {
                ds_list_add(SubClassList, UnknownEnum.Value_3, UnknownEnum.Value_3, UnknownEnum.Value_3, UnknownEnum.Value_3, UnknownEnum.Value_3, UnknownEnum.Value_3, UnknownEnum.Value_3, UnknownEnum.Value_6);
                
                if (!global.Level.LargeTreasureRoom)
                    ds_list_add(SubClassList, UnknownEnum.Value_4, UnknownEnum.Value_4, UnknownEnum.Value_4);
            }
            else
            {
                if (global.Level.Index > UnknownEnum.Value_1 && !global.Challenges[UnknownEnum.Value_5])
                {
                    ds_list_add(SubClassList, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1);
                    
                    if (global.Level.Index == UnknownEnum.Value_3)
                        ds_list_add(SubClassList, UnknownEnum.Value_1, UnknownEnum.Value_1, UnknownEnum.Value_1);
                }
                
                if (Prob(0.5))
                    ds_list_add(SubClassList, UnknownEnum.Value_3, UnknownEnum.Value_3, UnknownEnum.Value_3);
                
                if (Prob(0.45) && !global.Level.LargeTreasureRoom)
                    ds_list_add(SubClassList, UnknownEnum.Value_4, UnknownEnum.Value_4, UnknownEnum.Value_4);
            }
            
            if (global.Level.Index > UnknownEnum.Value_1)
                ds_list_add(SubClassList, UnknownEnum.Value_7);
            
            break;
        
        case UnknownEnum.Value_6:
            ds_list_add(SubClassList, UnknownEnum.Value_3, UnknownEnum.Value_5, UnknownEnum.Value_6);
            break;
        
        case UnknownEnum.Value_10:
            ds_list_add(SubClassList, UnknownEnum.Value_6);
            break;
    }
    
    ds_list_shuffle(SubClassList);
    var _UseList = true;
    
    if (global.Level.Rooms[arg0].FairyOrGemPond)
    {
        if (!global.Level.FairyRoom && Prob(0.5))
        {
            global.Level.Rooms[arg0].TemplateSubClass = UnknownEnum.Value_0;
            global.Level.FairyRoom = true;
            _UseList = false;
        }
        else if (!global.Level.GemPondRoom)
        {
            global.Level.Rooms[arg0].TemplateSubClass = UnknownEnum.Value_2;
            global.Level.GemPondRoom = true;
            _UseList = false;
        }
    }
    
    while (ds_list_size(SubClassList) > 0)
    {
        if (_UseList)
        {
            global.Level.Rooms[arg0].TemplateSubClass = ds_list_find_value(SubClassList, 0);
            ds_list_delete(SubClassList, 0);
        }
        
        for (var _Tries = 0; _Tries < (global.Templates_Room_Count[UnknownEnum.Value_8][global.Level.Rooms[arg0].TemplateSubClass] * 2); _Tries++)
        {
            var RoomTemplateIndex = RoomTemplate_GetNextIndex(UnknownEnum.Value_8, global.Level.Rooms[arg0].TemplateSubClass);
            var RoomTemplate = global.Templates_Room[UnknownEnum.Value_8][global.Level.Rooms[arg0].TemplateSubClass][RoomTemplateIndex];
            
            if ((RoomTemplate.DoorCode[UnknownEnum.Value_0] & global.Level.Rooms[arg0].DoorCode) == global.Level.Rooms[arg0].DoorCode)
            {
                global.Level.Rooms[arg0].TemplateIndex = RoomTemplateIndex;
                ds_list_destroy(SubClassList);
                
                if (global.Level.Rooms[arg0].TemplateSubClass == UnknownEnum.Value_4)
                    global.Level.LargeTreasureRoom = true;
                
                return RoomTemplate;
            }
        }
        
        _UseList = true;
    }
    
    ds_list_destroy(SubClassList);
    return -1;
}

function TemplateCheck(arg0, arg1, arg2, arg3 = "")
{
    if (arg3 != "")
        return global.Level.Rooms[arg0].TemplateClass == arg1 && global.Level.Rooms[arg0].TemplateSubClass == arg2 && global.Level.Rooms[arg0].TemplateName == arg3;
    else
        return global.Level.Rooms[arg0].TemplateClass == arg1 && global.Level.Rooms[arg0].TemplateSubClass == arg2;
}

function RoomTemplate_GetIndex(arg0, arg1, arg2 = "", arg3 = "")
{
    var _TemplateArray = global.Templates_Room[arg0][arg1];
    var _Templates = array_length(_TemplateArray);
    
    for (var _TemplateIndex = 0; _TemplateIndex < _Templates; _TemplateIndex++)
    {
        var _Template = _TemplateArray[_TemplateIndex];
        
        if (struct_get_from_hash(_Template, variable_get_hash("name")) == arg2 && struct_get_from_hash(_Template, variable_get_hash("type")) == arg3)
            return _TemplateIndex;
    }
    
    return -1;
}

function RoomTemplates_Parse_GenerateObjGrids(arg0)
{
    var ObjTypeArray = ["OutOfBounds", "ExtraCeilings", "WallsUpper"];
    var ObjTypes = array_length(ObjTypeArray);
    
    for (var ObjsTypeIndex = 0; ObjsTypeIndex < ObjTypes; ObjsTypeIndex++)
    {
        var ObjTypeStr = ObjTypeArray[ObjsTypeIndex];
        
        if (!variable_struct_exists(global.Level.Rooms[arg0].Template, ObjTypeStr))
            continue;
        
        var ObjType = variable_struct_get(global.Level.Rooms[arg0].Template, ObjTypeStr);
        var ObjCount = array_length(ObjType);
        var ObjGrid = variable_struct_get(global.Level.Rooms[arg0].TemplateObjGrid, ObjTypeStr);
        
        for (var ObjIndex = 0; ObjIndex < ObjCount; ObjIndex++)
        {
            var Obj = ObjType[ObjIndex];
            var ObjGridX = Obj.x / 8;
            var ObjGridY = Obj.y / 8;
            var ObjGridW = Obj.width / 8;
            var ObjGridH = Obj.height / 8;
            
            for (var TileY = 0; TileY < ObjGridH; TileY++)
            {
                for (var TileX = 0; TileX < ObjGridW; TileX++)
                    ObjGrid[ObjGridY + TileY][ObjGridX + TileX] = true;
            }
        }
    }
}

function RoomTemplates_Parse_GenerateDoorCodes(arg0)
{
    var _Doors = array_length(arg0.Doors);
    
    if (_Doors == 0)
        exit;
    
    var _DoorCode = array_create(8);
    
    for (var _DoorIndex = 0; _DoorIndex < _Doors; _DoorIndex++)
    {
        var _Door = arg0.Doors[_DoorIndex];
        
        for (var _Position = 0; _Position < 24; _Position++)
        {
            var _Coord = global.DoorCoordinates[arg0.SizeIndex][_Position + 1];
            
            if (_Door.x == _Coord.x && _Door.y == _Coord.y)
            {
                _Door.Position = _Position + 1;
                _Door.Location = _Coord.Location;
                
                for (var _TransformType = 0; _TransformType < 8; _TransformType++)
                {
                    if (!arg0.RoomTransformationsAllowed[_TransformType])
                        continue;
                    
                    var _NewDoorPos = GetTransformedDoorPosition(_Position + 1, _TransformType);
                    _DoorCode[_TransformType] = _DoorCode[_TransformType] | power(2, _NewDoorPos - 1);
                }
                
                break;
            }
        }
    }
    
    arg0.DoorCode = _DoorCode;
    var _MainSectionIDsExist = variable_struct_exists(arg0, "Split_MainSectionIDs");
    var _MainSectionIDs = _MainSectionIDsExist ? array_length(arg0.Split_MainSectionIDs) : 1;
    var _ZoneCodes = Array_Create3D(4, _MainSectionIDs, 8);
    
    for (var _TransformType = 0; _TransformType < 8; _TransformType++)
    {
        if (!arg0.RoomTransformationsAllowed[_TransformType])
            continue;
        
        for (var _MainSectionIDIndex = 0; _MainSectionIDIndex < _MainSectionIDs; _MainSectionIDIndex++)
        {
            var _MainSectionID = _MainSectionIDsExist ? arg0.Split_MainSectionIDs[_MainSectionIDIndex] : 0;
            var _ZoneArray = arg0.Sections[_MainSectionID].Zones;
            var _Zones = array_length(_ZoneArray);
            
            for (var _ZoneObjIndex = 0; _ZoneObjIndex < _Zones; _ZoneObjIndex++)
            {
                var _Zone = _ZoneArray[_ZoneObjIndex];
                
                for (var _DoorIndex = 0; _DoorIndex < _Doors; _DoorIndex++)
                {
                    var _Door = arg0.Doors[_DoorIndex];
                    var _NewDoorPos = GetTransformedDoorPosition(_Door.Position, _TransformType);
                    
                    if (rectangle_in_rectangle(_Door.x, _Door.y, (_Door.x + _Door.width) - 1, (_Door.y + _Door.height) - 1, _Zone.x, _Zone.y, (_Zone.x + _Zone.width) - 1, (_Zone.y + _Zone.height) - 1) > 0)
                        _ZoneCodes[_TransformType][_MainSectionIDIndex][_ZoneObjIndex] = _ZoneCodes[_TransformType][_MainSectionIDIndex][_ZoneObjIndex] | power(2, _NewDoorPos - 1);
                }
            }
        }
    }
    
    arg0.ZoneCodes = _ZoneCodes;
}

function RoomTemplates_GetDoorLevel(arg0, arg1)
{
    return (arg0 == 16 || arg1 == 16 || arg0 == 216 || arg1 == 216 || arg0 == 472 || arg1 == 472) ? 1 : 0;
}

function RoomTemplates_FixObjRotation(arg0)
{
    if (struct_get_from_hash(arg0, variable_get_hash("rotation")) == 90 || struct_get_from_hash(arg0, variable_get_hash("rotation")) == -90)
    {
        var OldW_Temp = struct_get_from_hash(arg0, variable_get_hash("width"));
        arg0.width = struct_get_from_hash(arg0, variable_get_hash("height"));
        arg0.height = OldW_Temp;
    }
    
    switch (struct_get_from_hash(arg0, variable_get_hash("rotation")))
    {
        case 90:
            arg0.x -= arg0.width;
            break;
        
        case -90:
            arg0.y -= arg0.height;
            break;
        
        case 180:
            arg0.x -= arg0.width;
            arg0.y -= arg0.height;
            break;
    }
}

function ObstacleRoomCheck(arg0, arg1)
{
    if (global.Level.Rooms[arg0].TemplateClass != UnknownEnum.Value_6)
        return true;
    
    return ObstacleClassCheck(arg0, arg1);
}

function ObstacleClassCheck(arg0, arg1)
{
    switch (arg1)
    {
        case UnknownEnum.Value_0:
            return global.Level.Rooms[arg0].Obstacle == UnknownEnum.Value_0;
        
        case UnknownEnum.Value_1:
            return global.Level.Rooms[arg0].Obstacle == UnknownEnum.Value_1 || global.Level.Rooms[arg0].Obstacle == UnknownEnum.Value_3;
        
        case UnknownEnum.Value_2:
            return global.Level.Rooms[arg0].Obstacle == UnknownEnum.Value_2 || global.Level.Rooms[arg0].Obstacle == UnknownEnum.Value_4;
        
        case UnknownEnum.Value_3:
            return global.Level.Rooms[arg0].Obstacle == UnknownEnum.Value_3 || global.Level.Rooms[arg0].Obstacle == UnknownEnum.Value_4 || global.Level.Rooms[arg0].Obstacle == UnknownEnum.Value_5;
        
        case UnknownEnum.Value_4:
            return global.Level.Rooms[arg0].Obstacle == UnknownEnum.Value_6 || global.Level.Rooms[arg0].Obstacle == UnknownEnum.Value_5;
    }
    
    return false;
}

function GetPropertyValue(arg0, arg1)
{
    for (var i = 0; i < array_length(arg0); i++)
    {
        if (arg0[i].name == arg1)
            return arg0[i].value;
    }
    
    return -1;
}

function SetPropertyValue(arg0, arg1, arg2)
{
    var Properties = array_length(arg0);
    
    if (Properties == 0)
        exit;
    
    for (var i = 0; i < Properties; i++)
    {
        if (struct_get_from_hash(array_get(arg0, i), variable_get_hash("name")) == arg1)
        {
            array_get(arg0, i).value = arg2;
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
    Value_7,
    Value_8,
    Value_9,
    Value_10,
    Value_11
}
