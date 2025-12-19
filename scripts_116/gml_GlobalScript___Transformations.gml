function TransformObjArray(arg0, arg1, arg2, arg3, arg4)
{
    var ObjCount = array_length(arg0);
    
    if (ObjCount == 0)
        return arg0;
    
    var NewArray = array_create(0);
    
    for (var ObjIndex = 0; ObjIndex < ObjCount; ObjIndex++)
    {
        array_push(NewArray, StructCopy(arg0[ObjIndex]));
        var OldObj = arg0[ObjIndex];
        var OldX = OldObj.x;
        var OldY = OldObj.y;
        var OldW = OldObj.width;
        var OldH = OldObj.height;
        var NewX = OldX;
        var NewY = OldY;
        var NewW = OldW;
        var NewH = OldH;
        
        switch (arg1)
        {
            case UnknownEnum.Value_1:
                NewX = arg3 - OldX - OldW;
                break;
            
            case UnknownEnum.Value_2:
                NewY = arg4 - OldY - OldH;
                break;
            
            case UnknownEnum.Value_3:
                NewX = arg3 - OldX - OldW;
                NewY = arg4 - OldY - OldH;
                break;
            
            case UnknownEnum.Value_4:
                NewW = OldH;
                NewH = OldW;
                NewY = OldX;
                NewX = arg4 - OldY - OldH;
                break;
            
            case UnknownEnum.Value_5:
                NewW = OldH;
                NewH = OldW;
                NewX = OldY;
                NewY = arg3 - OldX - OldW;
                break;
            
            case UnknownEnum.Value_6:
                NewW = OldH;
                NewH = OldW;
                NewX = arg4 - OldY - OldH;
                NewY = arg3 - OldX - OldW;
                break;
            
            case UnknownEnum.Value_7:
                NewW = OldH;
                NewH = OldW;
                NewX = OldY;
                NewY = OldX;
                break;
        }
        
        var Properties = struct_get_from_hash(OldObj, variable_get_hash("properties"));
        var PotSpawnDir = GetPropertyValue(Properties, "SpawnDir");
        
        if (PotSpawnDir != -1)
        {
            var NewPotSpawnDir = GetTransformedPotStartingCorner(PotSpawnDir, arg1);
            SetPropertyValue(struct_get_from_hash(array_get(NewArray, ObjIndex), variable_get_hash("properties")), "SpawnDir", NewPotSpawnDir);
        }
        
        var SBShiftCode = GetPropertyValue(Properties, "SB");
        
        if (SBShiftCode != -1)
        {
            var NewShiftCode = GetTransformedSBShiftCode(SBShiftCode, arg1);
            SetPropertyValue(struct_get_from_hash(array_get(NewArray, ObjIndex), variable_get_hash("properties")), "SB", NewShiftCode);
        }
        
        SBShiftCode = GetPropertyValue(Properties, "SBShift");
        
        if (SBShiftCode != -1)
        {
            var NewShiftCode = GetTransformedSBShiftCode(SBShiftCode, arg1);
            SetPropertyValue(struct_get_from_hash(array_get(NewArray, ObjIndex), variable_get_hash("properties")), "SBShift", NewShiftCode);
        }
        
        for (var i = 1; i <= 2; i++)
        {
            var _DoorStr = (i == 1) ? "DoorsFrom" : "DoorsTo";
            var DoorsCSV = GetPropertyValue(Properties, _DoorStr);
            
            if (DoorsCSV != -1 && DoorsCSV != "")
            {
                var DoorList = CSVToList(DoorsCSV);
                var DoorCount = ds_list_size(DoorList);
                var NewDoorStr = "";
                
                for (var j = 0; j < DoorCount; j++)
                {
                    var DoorPosition = ds_list_find_value(DoorList, j);
                    var NewDoorPos = GetTransformedDoorPosition(DoorPosition, arg1);
                    NewDoorStr += (string(NewDoorPos) + ((j < (DoorCount - 1)) ? "," : ""));
                }
                
                SetPropertyValue(struct_get_from_hash(array_get(NewArray, ObjIndex), variable_get_hash("properties")), _DoorStr, NewDoorStr);
                ds_list_destroy(DoorList);
            }
        }
        
        NewArray[ObjIndex].x = NewX;
        NewArray[ObjIndex].y = NewY;
        NewArray[ObjIndex].width = NewW;
        NewArray[ObjIndex].height = NewH;
        var ObjCanRotate = ds_list_find_index(global.TemplateObjsThatCanRotate, arg2);
        
        if (ObjCanRotate != -1)
            array_get(NewArray, ObjIndex).rotation = GetTransformedObjRotation(struct_get_from_hash(OldObj, variable_get_hash("rotation")), arg1);
        
        var OldGID = variable_struct_exists(OldObj, "gid") ? OldObj.gid : -1;
        
        if (OldGID != -1)
            array_get(NewArray, ObjIndex).gid = GetTransformedObjGID(OldGID, arg1);
    }
    
    return NewArray;
}

function GetTransformedObjGID(arg0, arg1)
{
    var NewGID = arg0;
    
    switch (arg1)
    {
        case UnknownEnum.Value_1:
            switch (arg0)
            {
                case UnknownEnum.Value_2:
                    NewGID = UnknownEnum.Value_3;
                    break;
                
                case UnknownEnum.Value_3:
                    NewGID = UnknownEnum.Value_2;
                    break;
                
                case UnknownEnum.Value_9:
                    NewGID = UnknownEnum.Value_10;
                    break;
                
                case UnknownEnum.Value_10:
                    NewGID = UnknownEnum.Value_9;
                    break;
                
                case UnknownEnum.Value_11:
                    NewGID = UnknownEnum.Value_12;
                    break;
                
                case UnknownEnum.Value_12:
                    NewGID = UnknownEnum.Value_11;
                    break;
                
                case UnknownEnum.Value_17:
                    NewGID = UnknownEnum.Value_18;
                    break;
                
                case UnknownEnum.Value_18:
                    NewGID = UnknownEnum.Value_17;
                    break;
                
                case UnknownEnum.Value_19:
                    NewGID = UnknownEnum.Value_20;
                    break;
                
                case UnknownEnum.Value_20:
                    NewGID = UnknownEnum.Value_19;
                    break;
                
                case UnknownEnum.Value_306:
                    NewGID = UnknownEnum.Value_307;
                    break;
                
                case UnknownEnum.Value_307:
                    NewGID = UnknownEnum.Value_306;
                    break;
                
                case UnknownEnum.Value_308:
                    NewGID = UnknownEnum.Value_309;
                    break;
                
                case UnknownEnum.Value_309:
                    NewGID = UnknownEnum.Value_308;
                    break;
                
                case UnknownEnum.Value_13:
                    NewGID = UnknownEnum.Value_14;
                    break;
                
                case UnknownEnum.Value_14:
                    NewGID = UnknownEnum.Value_13;
                    break;
                
                case UnknownEnum.Value_15:
                    NewGID = UnknownEnum.Value_16;
                    break;
                
                case UnknownEnum.Value_16:
                    NewGID = UnknownEnum.Value_15;
                    break;
                
                case UnknownEnum.Value_21:
                    NewGID = UnknownEnum.Value_22;
                    break;
                
                case UnknownEnum.Value_22:
                    NewGID = UnknownEnum.Value_21;
                    break;
                
                case UnknownEnum.Value_23:
                    NewGID = UnknownEnum.Value_24;
                    break;
                
                case UnknownEnum.Value_24:
                    NewGID = UnknownEnum.Value_23;
                    break;
                
                case UnknownEnum.Value_310:
                    NewGID = UnknownEnum.Value_311;
                    break;
                
                case UnknownEnum.Value_311:
                    NewGID = UnknownEnum.Value_310;
                    break;
                
                case UnknownEnum.Value_312:
                    NewGID = UnknownEnum.Value_313;
                    break;
                
                case UnknownEnum.Value_313:
                    NewGID = UnknownEnum.Value_312;
                    break;
                
                case UnknownEnum.Value_30:
                    NewGID = UnknownEnum.Value_31;
                    break;
                
                case UnknownEnum.Value_31:
                    NewGID = UnknownEnum.Value_30;
                    break;
                
                case UnknownEnum.Value_26:
                    NewGID = UnknownEnum.Value_27;
                    break;
                
                case UnknownEnum.Value_27:
                    NewGID = UnknownEnum.Value_26;
                    break;
                
                case UnknownEnum.Value_303:
                    NewGID = UnknownEnum.Value_304;
                    break;
                
                case UnknownEnum.Value_304:
                    NewGID = UnknownEnum.Value_303;
                    break;
                
                case UnknownEnum.Value_240:
                    NewGID = UnknownEnum.Value_241;
                    break;
                
                case UnknownEnum.Value_241:
                    NewGID = UnknownEnum.Value_240;
                    break;
                
                case UnknownEnum.Value_242:
                    NewGID = UnknownEnum.Value_243;
                    break;
                
                case UnknownEnum.Value_243:
                    NewGID = UnknownEnum.Value_242;
                    break;
                
                case UnknownEnum.Value_246:
                    NewGID = UnknownEnum.Value_247;
                    break;
                
                case UnknownEnum.Value_247:
                    NewGID = UnknownEnum.Value_246;
                    break;
                
                case UnknownEnum.Value_49:
                    NewGID = UnknownEnum.Value_50;
                    break;
                
                case UnknownEnum.Value_50:
                    NewGID = UnknownEnum.Value_49;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_2:
            switch (arg0)
            {
                case UnknownEnum.Value_4:
                    NewGID = UnknownEnum.Value_1;
                    break;
                
                case UnknownEnum.Value_1:
                    NewGID = UnknownEnum.Value_4;
                    break;
                
                case UnknownEnum.Value_9:
                    NewGID = UnknownEnum.Value_11;
                    break;
                
                case UnknownEnum.Value_11:
                    NewGID = UnknownEnum.Value_9;
                    break;
                
                case UnknownEnum.Value_10:
                    NewGID = UnknownEnum.Value_12;
                    break;
                
                case UnknownEnum.Value_12:
                    NewGID = UnknownEnum.Value_10;
                    break;
                
                case UnknownEnum.Value_17:
                    NewGID = UnknownEnum.Value_19;
                    break;
                
                case UnknownEnum.Value_19:
                    NewGID = UnknownEnum.Value_17;
                    break;
                
                case UnknownEnum.Value_18:
                    NewGID = UnknownEnum.Value_20;
                    break;
                
                case UnknownEnum.Value_20:
                    NewGID = UnknownEnum.Value_18;
                    break;
                
                case UnknownEnum.Value_306:
                    NewGID = UnknownEnum.Value_308;
                    break;
                
                case UnknownEnum.Value_308:
                    NewGID = UnknownEnum.Value_306;
                    break;
                
                case UnknownEnum.Value_307:
                    NewGID = UnknownEnum.Value_309;
                    break;
                
                case UnknownEnum.Value_309:
                    NewGID = UnknownEnum.Value_307;
                    break;
                
                case UnknownEnum.Value_13:
                    NewGID = UnknownEnum.Value_15;
                    break;
                
                case UnknownEnum.Value_15:
                    NewGID = UnknownEnum.Value_13;
                    break;
                
                case UnknownEnum.Value_14:
                    NewGID = UnknownEnum.Value_16;
                    break;
                
                case UnknownEnum.Value_16:
                    NewGID = UnknownEnum.Value_14;
                    break;
                
                case UnknownEnum.Value_21:
                    NewGID = UnknownEnum.Value_23;
                    break;
                
                case UnknownEnum.Value_23:
                    NewGID = UnknownEnum.Value_21;
                    break;
                
                case UnknownEnum.Value_22:
                    NewGID = UnknownEnum.Value_24;
                    break;
                
                case UnknownEnum.Value_24:
                    NewGID = UnknownEnum.Value_22;
                    break;
                
                case UnknownEnum.Value_310:
                    NewGID = UnknownEnum.Value_312;
                    break;
                
                case UnknownEnum.Value_312:
                    NewGID = UnknownEnum.Value_310;
                    break;
                
                case UnknownEnum.Value_311:
                    NewGID = UnknownEnum.Value_313;
                    break;
                
                case UnknownEnum.Value_313:
                    NewGID = UnknownEnum.Value_311;
                    break;
                
                case UnknownEnum.Value_32:
                    NewGID = UnknownEnum.Value_29;
                    break;
                
                case UnknownEnum.Value_29:
                    NewGID = UnknownEnum.Value_32;
                    break;
                
                case UnknownEnum.Value_28:
                    NewGID = UnknownEnum.Value_25;
                    break;
                
                case UnknownEnum.Value_25:
                    NewGID = UnknownEnum.Value_28;
                    break;
                
                case UnknownEnum.Value_305:
                    NewGID = UnknownEnum.Value_302;
                    break;
                
                case UnknownEnum.Value_302:
                    NewGID = UnknownEnum.Value_305;
                    break;
                
                case UnknownEnum.Value_8:
                    NewGID = UnknownEnum.Value_5;
                    break;
                
                case UnknownEnum.Value_5:
                    NewGID = UnknownEnum.Value_8;
                    break;
                
                case UnknownEnum.Value_240:
                    NewGID = UnknownEnum.Value_242;
                    break;
                
                case UnknownEnum.Value_241:
                    NewGID = UnknownEnum.Value_243;
                    break;
                
                case UnknownEnum.Value_242:
                    NewGID = UnknownEnum.Value_240;
                    break;
                
                case UnknownEnum.Value_243:
                    NewGID = UnknownEnum.Value_241;
                    break;
                
                case UnknownEnum.Value_244:
                    NewGID = UnknownEnum.Value_245;
                    break;
                
                case UnknownEnum.Value_245:
                    NewGID = UnknownEnum.Value_244;
                    break;
                
                case UnknownEnum.Value_51:
                    NewGID = UnknownEnum.Value_48;
                    break;
                
                case UnknownEnum.Value_48:
                    NewGID = UnknownEnum.Value_51;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_3:
            switch (arg0)
            {
                case UnknownEnum.Value_2:
                    NewGID = UnknownEnum.Value_3;
                    break;
                
                case UnknownEnum.Value_3:
                    NewGID = UnknownEnum.Value_2;
                    break;
                
                case UnknownEnum.Value_4:
                    NewGID = UnknownEnum.Value_1;
                    break;
                
                case UnknownEnum.Value_1:
                    NewGID = UnknownEnum.Value_4;
                    break;
                
                case UnknownEnum.Value_9:
                    NewGID = UnknownEnum.Value_12;
                    break;
                
                case UnknownEnum.Value_12:
                    NewGID = UnknownEnum.Value_9;
                    break;
                
                case UnknownEnum.Value_10:
                    NewGID = UnknownEnum.Value_11;
                    break;
                
                case UnknownEnum.Value_11:
                    NewGID = UnknownEnum.Value_10;
                    break;
                
                case UnknownEnum.Value_17:
                    NewGID = UnknownEnum.Value_20;
                    break;
                
                case UnknownEnum.Value_20:
                    NewGID = UnknownEnum.Value_17;
                    break;
                
                case UnknownEnum.Value_18:
                    NewGID = UnknownEnum.Value_19;
                    break;
                
                case UnknownEnum.Value_19:
                    NewGID = UnknownEnum.Value_18;
                    break;
                
                case UnknownEnum.Value_306:
                    NewGID = UnknownEnum.Value_309;
                    break;
                
                case UnknownEnum.Value_309:
                    NewGID = UnknownEnum.Value_306;
                    break;
                
                case UnknownEnum.Value_307:
                    NewGID = UnknownEnum.Value_308;
                    break;
                
                case UnknownEnum.Value_308:
                    NewGID = UnknownEnum.Value_307;
                    break;
                
                case UnknownEnum.Value_13:
                    NewGID = UnknownEnum.Value_16;
                    break;
                
                case UnknownEnum.Value_16:
                    NewGID = UnknownEnum.Value_13;
                    break;
                
                case UnknownEnum.Value_14:
                    NewGID = UnknownEnum.Value_15;
                    break;
                
                case UnknownEnum.Value_15:
                    NewGID = UnknownEnum.Value_14;
                    break;
                
                case UnknownEnum.Value_21:
                    NewGID = UnknownEnum.Value_24;
                    break;
                
                case UnknownEnum.Value_24:
                    NewGID = UnknownEnum.Value_21;
                    break;
                
                case UnknownEnum.Value_22:
                    NewGID = UnknownEnum.Value_23;
                    break;
                
                case UnknownEnum.Value_23:
                    NewGID = UnknownEnum.Value_22;
                    break;
                
                case UnknownEnum.Value_310:
                    NewGID = UnknownEnum.Value_313;
                    break;
                
                case UnknownEnum.Value_313:
                    NewGID = UnknownEnum.Value_310;
                    break;
                
                case UnknownEnum.Value_311:
                    NewGID = UnknownEnum.Value_312;
                    break;
                
                case UnknownEnum.Value_312:
                    NewGID = UnknownEnum.Value_311;
                    break;
                
                case UnknownEnum.Value_30:
                    NewGID = UnknownEnum.Value_31;
                    break;
                
                case UnknownEnum.Value_31:
                    NewGID = UnknownEnum.Value_30;
                    break;
                
                case UnknownEnum.Value_32:
                    NewGID = UnknownEnum.Value_29;
                    break;
                
                case UnknownEnum.Value_29:
                    NewGID = UnknownEnum.Value_32;
                    break;
                
                case UnknownEnum.Value_26:
                    NewGID = UnknownEnum.Value_27;
                    break;
                
                case UnknownEnum.Value_27:
                    NewGID = UnknownEnum.Value_26;
                    break;
                
                case UnknownEnum.Value_28:
                    NewGID = UnknownEnum.Value_25;
                    break;
                
                case UnknownEnum.Value_25:
                    NewGID = UnknownEnum.Value_28;
                    break;
                
                case UnknownEnum.Value_303:
                    NewGID = UnknownEnum.Value_304;
                    break;
                
                case UnknownEnum.Value_304:
                    NewGID = UnknownEnum.Value_303;
                    break;
                
                case UnknownEnum.Value_305:
                    NewGID = UnknownEnum.Value_302;
                    break;
                
                case UnknownEnum.Value_302:
                    NewGID = UnknownEnum.Value_305;
                    break;
                
                case UnknownEnum.Value_8:
                    NewGID = UnknownEnum.Value_5;
                    break;
                
                case UnknownEnum.Value_5:
                    NewGID = UnknownEnum.Value_8;
                    break;
                
                case UnknownEnum.Value_240:
                    NewGID = UnknownEnum.Value_243;
                    break;
                
                case UnknownEnum.Value_241:
                    NewGID = UnknownEnum.Value_242;
                    break;
                
                case UnknownEnum.Value_242:
                    NewGID = UnknownEnum.Value_241;
                    break;
                
                case UnknownEnum.Value_243:
                    NewGID = UnknownEnum.Value_240;
                    break;
                
                case UnknownEnum.Value_244:
                    NewGID = UnknownEnum.Value_245;
                    break;
                
                case UnknownEnum.Value_245:
                    NewGID = UnknownEnum.Value_244;
                    break;
                
                case UnknownEnum.Value_246:
                    NewGID = UnknownEnum.Value_247;
                    break;
                
                case UnknownEnum.Value_247:
                    NewGID = UnknownEnum.Value_246;
                    break;
                
                case UnknownEnum.Value_49:
                    NewGID = UnknownEnum.Value_50;
                    break;
                
                case UnknownEnum.Value_50:
                    NewGID = UnknownEnum.Value_49;
                    break;
                
                case UnknownEnum.Value_51:
                    NewGID = UnknownEnum.Value_48;
                    break;
                
                case UnknownEnum.Value_48:
                    NewGID = UnknownEnum.Value_51;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_4:
            switch (arg0)
            {
                case UnknownEnum.Value_2:
                    NewGID = UnknownEnum.Value_4;
                    break;
                
                case UnknownEnum.Value_3:
                    NewGID = UnknownEnum.Value_1;
                    break;
                
                case UnknownEnum.Value_4:
                    NewGID = UnknownEnum.Value_3;
                    break;
                
                case UnknownEnum.Value_1:
                    NewGID = UnknownEnum.Value_2;
                    break;
                
                case UnknownEnum.Value_9:
                    NewGID = UnknownEnum.Value_11;
                    break;
                
                case UnknownEnum.Value_12:
                    NewGID = UnknownEnum.Value_10;
                    break;
                
                case UnknownEnum.Value_10:
                    NewGID = UnknownEnum.Value_9;
                    break;
                
                case UnknownEnum.Value_11:
                    NewGID = UnknownEnum.Value_12;
                    break;
                
                case UnknownEnum.Value_17:
                    NewGID = UnknownEnum.Value_19;
                    break;
                
                case UnknownEnum.Value_20:
                    NewGID = UnknownEnum.Value_18;
                    break;
                
                case UnknownEnum.Value_18:
                    NewGID = UnknownEnum.Value_17;
                    break;
                
                case UnknownEnum.Value_19:
                    NewGID = UnknownEnum.Value_20;
                    break;
                
                case UnknownEnum.Value_306:
                    NewGID = UnknownEnum.Value_308;
                    break;
                
                case UnknownEnum.Value_309:
                    NewGID = UnknownEnum.Value_307;
                    break;
                
                case UnknownEnum.Value_307:
                    NewGID = UnknownEnum.Value_306;
                    break;
                
                case UnknownEnum.Value_308:
                    NewGID = UnknownEnum.Value_309;
                    break;
                
                case UnknownEnum.Value_13:
                    NewGID = UnknownEnum.Value_15;
                    break;
                
                case UnknownEnum.Value_16:
                    NewGID = UnknownEnum.Value_14;
                    break;
                
                case UnknownEnum.Value_14:
                    NewGID = UnknownEnum.Value_13;
                    break;
                
                case UnknownEnum.Value_15:
                    NewGID = UnknownEnum.Value_16;
                    break;
                
                case UnknownEnum.Value_21:
                    NewGID = UnknownEnum.Value_23;
                    break;
                
                case UnknownEnum.Value_24:
                    NewGID = UnknownEnum.Value_22;
                    break;
                
                case UnknownEnum.Value_22:
                    NewGID = UnknownEnum.Value_21;
                    break;
                
                case UnknownEnum.Value_23:
                    NewGID = UnknownEnum.Value_24;
                    break;
                
                case UnknownEnum.Value_310:
                    NewGID = UnknownEnum.Value_312;
                    break;
                
                case UnknownEnum.Value_313:
                    NewGID = UnknownEnum.Value_311;
                    break;
                
                case UnknownEnum.Value_311:
                    NewGID = UnknownEnum.Value_310;
                    break;
                
                case UnknownEnum.Value_312:
                    NewGID = UnknownEnum.Value_313;
                    break;
                
                case UnknownEnum.Value_30:
                    NewGID = UnknownEnum.Value_32;
                    break;
                
                case UnknownEnum.Value_31:
                    NewGID = UnknownEnum.Value_29;
                    break;
                
                case UnknownEnum.Value_32:
                    NewGID = UnknownEnum.Value_31;
                    break;
                
                case UnknownEnum.Value_29:
                    NewGID = UnknownEnum.Value_30;
                    break;
                
                case UnknownEnum.Value_26:
                    NewGID = UnknownEnum.Value_28;
                    break;
                
                case UnknownEnum.Value_27:
                    NewGID = UnknownEnum.Value_25;
                    break;
                
                case UnknownEnum.Value_28:
                    NewGID = UnknownEnum.Value_27;
                    break;
                
                case UnknownEnum.Value_25:
                    NewGID = UnknownEnum.Value_26;
                    break;
                
                case UnknownEnum.Value_303:
                    NewGID = UnknownEnum.Value_305;
                    break;
                
                case UnknownEnum.Value_304:
                    NewGID = UnknownEnum.Value_302;
                    break;
                
                case UnknownEnum.Value_305:
                    NewGID = UnknownEnum.Value_304;
                    break;
                
                case UnknownEnum.Value_302:
                    NewGID = UnknownEnum.Value_303;
                    break;
                
                case UnknownEnum.Value_219:
                    NewGID = UnknownEnum.Value_218;
                    break;
                
                case UnknownEnum.Value_218:
                    NewGID = UnknownEnum.Value_219;
                    break;
                
                case UnknownEnum.Value_238:
                    NewGID = UnknownEnum.Value_239;
                    break;
                
                case UnknownEnum.Value_239:
                    NewGID = UnknownEnum.Value_238;
                    break;
                
                case UnknownEnum.Value_240:
                    NewGID = UnknownEnum.Value_241;
                    break;
                
                case UnknownEnum.Value_241:
                    NewGID = UnknownEnum.Value_243;
                    break;
                
                case UnknownEnum.Value_242:
                    NewGID = UnknownEnum.Value_240;
                    break;
                
                case UnknownEnum.Value_243:
                    NewGID = UnknownEnum.Value_242;
                    break;
                
                case UnknownEnum.Value_244:
                    NewGID = UnknownEnum.Value_247;
                    break;
                
                case UnknownEnum.Value_245:
                    NewGID = UnknownEnum.Value_246;
                    break;
                
                case UnknownEnum.Value_246:
                    NewGID = UnknownEnum.Value_244;
                    break;
                
                case UnknownEnum.Value_247:
                    NewGID = UnknownEnum.Value_245;
                    break;
                
                case UnknownEnum.Value_49:
                    NewGID = UnknownEnum.Value_51;
                    break;
                
                case UnknownEnum.Value_50:
                    NewGID = UnknownEnum.Value_48;
                    break;
                
                case UnknownEnum.Value_51:
                    NewGID = UnknownEnum.Value_50;
                    break;
                
                case UnknownEnum.Value_48:
                    NewGID = UnknownEnum.Value_49;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_5:
            switch (arg0)
            {
                case UnknownEnum.Value_2:
                    NewGID = UnknownEnum.Value_1;
                    break;
                
                case UnknownEnum.Value_3:
                    NewGID = UnknownEnum.Value_4;
                    break;
                
                case UnknownEnum.Value_4:
                    NewGID = UnknownEnum.Value_2;
                    break;
                
                case UnknownEnum.Value_1:
                    NewGID = UnknownEnum.Value_3;
                    break;
                
                case UnknownEnum.Value_9:
                    NewGID = UnknownEnum.Value_10;
                    break;
                
                case UnknownEnum.Value_12:
                    NewGID = UnknownEnum.Value_11;
                    break;
                
                case UnknownEnum.Value_10:
                    NewGID = UnknownEnum.Value_12;
                    break;
                
                case UnknownEnum.Value_11:
                    NewGID = UnknownEnum.Value_9;
                    break;
                
                case UnknownEnum.Value_17:
                    NewGID = UnknownEnum.Value_18;
                    break;
                
                case UnknownEnum.Value_20:
                    NewGID = UnknownEnum.Value_19;
                    break;
                
                case UnknownEnum.Value_18:
                    NewGID = UnknownEnum.Value_20;
                    break;
                
                case UnknownEnum.Value_19:
                    NewGID = UnknownEnum.Value_17;
                    break;
                
                case UnknownEnum.Value_306:
                    NewGID = UnknownEnum.Value_307;
                    break;
                
                case UnknownEnum.Value_309:
                    NewGID = UnknownEnum.Value_308;
                    break;
                
                case UnknownEnum.Value_307:
                    NewGID = UnknownEnum.Value_309;
                    break;
                
                case UnknownEnum.Value_308:
                    NewGID = UnknownEnum.Value_306;
                    break;
                
                case UnknownEnum.Value_13:
                    NewGID = UnknownEnum.Value_14;
                    break;
                
                case UnknownEnum.Value_16:
                    NewGID = UnknownEnum.Value_15;
                    break;
                
                case UnknownEnum.Value_14:
                    NewGID = UnknownEnum.Value_16;
                    break;
                
                case UnknownEnum.Value_15:
                    NewGID = UnknownEnum.Value_13;
                    break;
                
                case UnknownEnum.Value_21:
                    NewGID = UnknownEnum.Value_22;
                    break;
                
                case UnknownEnum.Value_24:
                    NewGID = UnknownEnum.Value_23;
                    break;
                
                case UnknownEnum.Value_22:
                    NewGID = UnknownEnum.Value_24;
                    break;
                
                case UnknownEnum.Value_23:
                    NewGID = UnknownEnum.Value_21;
                    break;
                
                case UnknownEnum.Value_310:
                    NewGID = UnknownEnum.Value_311;
                    break;
                
                case UnknownEnum.Value_313:
                    NewGID = UnknownEnum.Value_312;
                    break;
                
                case UnknownEnum.Value_311:
                    NewGID = UnknownEnum.Value_313;
                    break;
                
                case UnknownEnum.Value_312:
                    NewGID = UnknownEnum.Value_310;
                    break;
                
                case UnknownEnum.Value_30:
                    NewGID = UnknownEnum.Value_29;
                    break;
                
                case UnknownEnum.Value_31:
                    NewGID = UnknownEnum.Value_32;
                    break;
                
                case UnknownEnum.Value_32:
                    NewGID = UnknownEnum.Value_30;
                    break;
                
                case UnknownEnum.Value_29:
                    NewGID = UnknownEnum.Value_31;
                    break;
                
                case UnknownEnum.Value_26:
                    NewGID = UnknownEnum.Value_25;
                    break;
                
                case UnknownEnum.Value_27:
                    NewGID = UnknownEnum.Value_28;
                    break;
                
                case UnknownEnum.Value_28:
                    NewGID = UnknownEnum.Value_26;
                    break;
                
                case UnknownEnum.Value_25:
                    NewGID = UnknownEnum.Value_27;
                    break;
                
                case UnknownEnum.Value_303:
                    NewGID = UnknownEnum.Value_302;
                    break;
                
                case UnknownEnum.Value_304:
                    NewGID = UnknownEnum.Value_305;
                    break;
                
                case UnknownEnum.Value_305:
                    NewGID = UnknownEnum.Value_303;
                    break;
                
                case UnknownEnum.Value_302:
                    NewGID = UnknownEnum.Value_304;
                    break;
                
                case UnknownEnum.Value_219:
                    NewGID = UnknownEnum.Value_218;
                    break;
                
                case UnknownEnum.Value_218:
                    NewGID = UnknownEnum.Value_219;
                    break;
                
                case UnknownEnum.Value_238:
                    NewGID = UnknownEnum.Value_239;
                    break;
                
                case UnknownEnum.Value_239:
                    NewGID = UnknownEnum.Value_238;
                    break;
                
                case UnknownEnum.Value_240:
                    NewGID = UnknownEnum.Value_242;
                    break;
                
                case UnknownEnum.Value_241:
                    NewGID = UnknownEnum.Value_240;
                    break;
                
                case UnknownEnum.Value_242:
                    NewGID = UnknownEnum.Value_243;
                    break;
                
                case UnknownEnum.Value_243:
                    NewGID = UnknownEnum.Value_241;
                    break;
                
                case UnknownEnum.Value_244:
                    NewGID = UnknownEnum.Value_246;
                    break;
                
                case UnknownEnum.Value_245:
                    NewGID = UnknownEnum.Value_247;
                    break;
                
                case UnknownEnum.Value_246:
                    NewGID = UnknownEnum.Value_245;
                    break;
                
                case UnknownEnum.Value_247:
                    NewGID = UnknownEnum.Value_244;
                    break;
                
                case UnknownEnum.Value_49:
                    NewGID = UnknownEnum.Value_48;
                    break;
                
                case UnknownEnum.Value_50:
                    NewGID = UnknownEnum.Value_51;
                    break;
                
                case UnknownEnum.Value_51:
                    NewGID = UnknownEnum.Value_49;
                    break;
                
                case UnknownEnum.Value_48:
                    NewGID = UnknownEnum.Value_50;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_6:
            switch (arg0)
            {
                case UnknownEnum.Value_2:
                    NewGID = UnknownEnum.Value_1;
                    break;
                
                case UnknownEnum.Value_3:
                    NewGID = UnknownEnum.Value_4;
                    break;
                
                case UnknownEnum.Value_4:
                    NewGID = UnknownEnum.Value_3;
                    break;
                
                case UnknownEnum.Value_1:
                    NewGID = UnknownEnum.Value_2;
                    break;
                
                case UnknownEnum.Value_10:
                    NewGID = UnknownEnum.Value_11;
                    break;
                
                case UnknownEnum.Value_11:
                    NewGID = UnknownEnum.Value_10;
                    break;
                
                case UnknownEnum.Value_18:
                    NewGID = UnknownEnum.Value_19;
                    break;
                
                case UnknownEnum.Value_19:
                    NewGID = UnknownEnum.Value_18;
                    break;
                
                case UnknownEnum.Value_307:
                    NewGID = UnknownEnum.Value_308;
                    break;
                
                case UnknownEnum.Value_308:
                    NewGID = UnknownEnum.Value_307;
                    break;
                
                case UnknownEnum.Value_14:
                    NewGID = UnknownEnum.Value_15;
                    break;
                
                case UnknownEnum.Value_15:
                    NewGID = UnknownEnum.Value_14;
                    break;
                
                case UnknownEnum.Value_22:
                    NewGID = UnknownEnum.Value_23;
                    break;
                
                case UnknownEnum.Value_23:
                    NewGID = UnknownEnum.Value_22;
                    break;
                
                case UnknownEnum.Value_311:
                    NewGID = UnknownEnum.Value_312;
                    break;
                
                case UnknownEnum.Value_312:
                    NewGID = UnknownEnum.Value_311;
                    break;
                
                case UnknownEnum.Value_30:
                    NewGID = UnknownEnum.Value_29;
                    break;
                
                case UnknownEnum.Value_31:
                    NewGID = UnknownEnum.Value_32;
                    break;
                
                case UnknownEnum.Value_32:
                    NewGID = UnknownEnum.Value_31;
                    break;
                
                case UnknownEnum.Value_29:
                    NewGID = UnknownEnum.Value_30;
                    break;
                
                case UnknownEnum.Value_26:
                    NewGID = UnknownEnum.Value_25;
                    break;
                
                case UnknownEnum.Value_27:
                    NewGID = UnknownEnum.Value_28;
                    break;
                
                case UnknownEnum.Value_28:
                    NewGID = UnknownEnum.Value_27;
                    break;
                
                case UnknownEnum.Value_25:
                    NewGID = UnknownEnum.Value_26;
                    break;
                
                case UnknownEnum.Value_303:
                    NewGID = UnknownEnum.Value_302;
                    break;
                
                case UnknownEnum.Value_304:
                    NewGID = UnknownEnum.Value_305;
                    break;
                
                case UnknownEnum.Value_305:
                    NewGID = UnknownEnum.Value_304;
                    break;
                
                case UnknownEnum.Value_302:
                    NewGID = UnknownEnum.Value_303;
                    break;
                
                case UnknownEnum.Value_219:
                    NewGID = UnknownEnum.Value_218;
                    break;
                
                case UnknownEnum.Value_218:
                    NewGID = UnknownEnum.Value_219;
                    break;
                
                case UnknownEnum.Value_238:
                    NewGID = UnknownEnum.Value_239;
                    break;
                
                case UnknownEnum.Value_239:
                    NewGID = UnknownEnum.Value_238;
                    break;
                
                case UnknownEnum.Value_240:
                    NewGID = UnknownEnum.Value_243;
                    break;
                
                case UnknownEnum.Value_243:
                    NewGID = UnknownEnum.Value_240;
                    break;
                
                case UnknownEnum.Value_244:
                    NewGID = UnknownEnum.Value_247;
                    break;
                
                case UnknownEnum.Value_245:
                    NewGID = UnknownEnum.Value_246;
                    break;
                
                case UnknownEnum.Value_246:
                    NewGID = UnknownEnum.Value_245;
                    break;
                
                case UnknownEnum.Value_247:
                    NewGID = UnknownEnum.Value_244;
                    break;
                
                case UnknownEnum.Value_49:
                    NewGID = UnknownEnum.Value_48;
                    break;
                
                case UnknownEnum.Value_50:
                    NewGID = UnknownEnum.Value_51;
                    break;
                
                case UnknownEnum.Value_51:
                    NewGID = UnknownEnum.Value_50;
                    break;
                
                case UnknownEnum.Value_48:
                    NewGID = UnknownEnum.Value_49;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_7:
            switch (arg0)
            {
                case UnknownEnum.Value_2:
                    NewGID = UnknownEnum.Value_4;
                    break;
                
                case UnknownEnum.Value_3:
                    NewGID = UnknownEnum.Value_1;
                    break;
                
                case UnknownEnum.Value_4:
                    NewGID = UnknownEnum.Value_2;
                    break;
                
                case UnknownEnum.Value_1:
                    NewGID = UnknownEnum.Value_3;
                    break;
                
                case UnknownEnum.Value_9:
                    NewGID = UnknownEnum.Value_12;
                    break;
                
                case UnknownEnum.Value_12:
                    NewGID = UnknownEnum.Value_9;
                    break;
                
                case UnknownEnum.Value_20:
                    NewGID = UnknownEnum.Value_17;
                    break;
                
                case UnknownEnum.Value_17:
                    NewGID = UnknownEnum.Value_20;
                    break;
                
                case UnknownEnum.Value_306:
                    NewGID = UnknownEnum.Value_309;
                    break;
                
                case UnknownEnum.Value_309:
                    NewGID = UnknownEnum.Value_306;
                    break;
                
                case UnknownEnum.Value_13:
                    NewGID = UnknownEnum.Value_16;
                    break;
                
                case UnknownEnum.Value_16:
                    NewGID = UnknownEnum.Value_13;
                    break;
                
                case UnknownEnum.Value_21:
                    NewGID = UnknownEnum.Value_24;
                    break;
                
                case UnknownEnum.Value_24:
                    NewGID = UnknownEnum.Value_21;
                    break;
                
                case UnknownEnum.Value_310:
                    NewGID = UnknownEnum.Value_313;
                    break;
                
                case UnknownEnum.Value_313:
                    NewGID = UnknownEnum.Value_310;
                    break;
                
                case UnknownEnum.Value_30:
                    NewGID = UnknownEnum.Value_32;
                    break;
                
                case UnknownEnum.Value_31:
                    NewGID = UnknownEnum.Value_29;
                    break;
                
                case UnknownEnum.Value_32:
                    NewGID = UnknownEnum.Value_30;
                    break;
                
                case UnknownEnum.Value_29:
                    NewGID = UnknownEnum.Value_31;
                    break;
                
                case UnknownEnum.Value_26:
                    NewGID = UnknownEnum.Value_28;
                    break;
                
                case UnknownEnum.Value_27:
                    NewGID = UnknownEnum.Value_25;
                    break;
                
                case UnknownEnum.Value_28:
                    NewGID = UnknownEnum.Value_26;
                    break;
                
                case UnknownEnum.Value_25:
                    NewGID = UnknownEnum.Value_27;
                    break;
                
                case UnknownEnum.Value_303:
                    NewGID = UnknownEnum.Value_305;
                    break;
                
                case UnknownEnum.Value_304:
                    NewGID = UnknownEnum.Value_302;
                    break;
                
                case UnknownEnum.Value_305:
                    NewGID = UnknownEnum.Value_303;
                    break;
                
                case UnknownEnum.Value_302:
                    NewGID = UnknownEnum.Value_304;
                    break;
                
                case UnknownEnum.Value_219:
                    NewGID = UnknownEnum.Value_218;
                    break;
                
                case UnknownEnum.Value_218:
                    NewGID = UnknownEnum.Value_219;
                    break;
                
                case UnknownEnum.Value_238:
                    NewGID = UnknownEnum.Value_239;
                    break;
                
                case UnknownEnum.Value_239:
                    NewGID = UnknownEnum.Value_238;
                    break;
                
                case UnknownEnum.Value_241:
                    NewGID = UnknownEnum.Value_242;
                    break;
                
                case UnknownEnum.Value_242:
                    NewGID = UnknownEnum.Value_241;
                    break;
                
                case UnknownEnum.Value_244:
                    NewGID = UnknownEnum.Value_246;
                    break;
                
                case UnknownEnum.Value_245:
                    NewGID = UnknownEnum.Value_247;
                    break;
                
                case UnknownEnum.Value_246:
                    NewGID = UnknownEnum.Value_244;
                    break;
                
                case UnknownEnum.Value_247:
                    NewGID = UnknownEnum.Value_245;
                    break;
                
                case UnknownEnum.Value_49:
                    NewGID = UnknownEnum.Value_51;
                    break;
                
                case UnknownEnum.Value_50:
                    NewGID = UnknownEnum.Value_48;
                    break;
                
                case UnknownEnum.Value_51:
                    NewGID = UnknownEnum.Value_49;
                    break;
                
                case UnknownEnum.Value_48:
                    NewGID = UnknownEnum.Value_50;
                    break;
            }
            
            break;
    }
    
    return NewGID;
}

function GetTransformedDungeonGrid(arg0, arg1, arg2, arg3, arg4)
{
    var _NewGridX = arg0;
    var _NewGridY = arg1;
    var _NewGridW = arg2;
    var _NewGridH = arg3;
    
    switch (arg4)
    {
        case UnknownEnum.Value_1:
            _NewGridX = 8 - arg0 - arg2;
            break;
        
        case UnknownEnum.Value_2:
            _NewGridY = 8 - arg1 - arg3;
            break;
        
        case UnknownEnum.Value_3:
            _NewGridX = 8 - arg0 - arg2;
            _NewGridY = 8 - arg1 - arg3;
            break;
        
        case UnknownEnum.Value_4:
            _NewGridW = arg3;
            _NewGridH = arg2;
            _NewGridY = arg0;
            _NewGridX = 8 - arg1 - arg3;
            break;
        
        case UnknownEnum.Value_5:
            _NewGridW = arg3;
            _NewGridH = arg2;
            _NewGridX = arg1;
            _NewGridY = 8 - arg0 - arg2;
            break;
        
        case UnknownEnum.Value_6:
            _NewGridW = arg3;
            _NewGridH = arg2;
            _NewGridX = 8 - arg1 - arg3;
            _NewGridY = 8 - arg0 - arg2;
            break;
        
        case UnknownEnum.Value_7:
            _NewGridW = arg3;
            _NewGridH = arg2;
            _NewGridX = arg1;
            _NewGridY = arg0;
            break;
    }
    
    return [_NewGridX, _NewGridY, _NewGridW, _NewGridH];
}

function GetTransformedDoorPosition(arg0, arg1)
{
    if (arg0 == -1)
        return -1;
    
    var NewPosition = arg0;
    
    switch (arg1)
    {
        case UnknownEnum.Value_1:
            switch (arg0)
            {
                case 1:
                case 13:
                    NewPosition = 11;
                    break;
                
                case 2:
                case 14:
                    NewPosition = 10;
                    break;
                
                case 3:
                case 15:
                    NewPosition = 9;
                    break;
                
                case 4:
                case 16:
                    NewPosition = 8;
                    break;
                
                case 5:
                case 17:
                    NewPosition = 7;
                    break;
                
                case 6:
                case 18:
                    NewPosition = 6;
                    break;
                
                case 7:
                case 19:
                    NewPosition = 5;
                    break;
                
                case 8:
                case 20:
                    NewPosition = 4;
                    break;
                
                case 9:
                case 21:
                    NewPosition = 3;
                    break;
                
                case 10:
                case 22:
                    NewPosition = 2;
                    break;
                
                case 11:
                case 23:
                    NewPosition = 1;
                    break;
                
                case 12:
                case 24:
                    NewPosition = 12;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_2:
            switch (arg0)
            {
                case 1:
                case 13:
                    NewPosition = 5;
                    break;
                
                case 2:
                case 14:
                    NewPosition = 4;
                    break;
                
                case 3:
                case 15:
                    NewPosition = 3;
                    break;
                
                case 4:
                case 16:
                    NewPosition = 2;
                    break;
                
                case 5:
                case 17:
                    NewPosition = 1;
                    break;
                
                case 6:
                case 18:
                    NewPosition = 12;
                    break;
                
                case 7:
                case 19:
                    NewPosition = 11;
                    break;
                
                case 8:
                case 20:
                    NewPosition = 10;
                    break;
                
                case 9:
                case 21:
                    NewPosition = 9;
                    break;
                
                case 10:
                case 22:
                    NewPosition = 8;
                    break;
                
                case 11:
                case 23:
                    NewPosition = 7;
                    break;
                
                case 12:
                case 24:
                    NewPosition = 6;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_3:
            switch (arg0)
            {
                case 1:
                case 13:
                    NewPosition = 7;
                    break;
                
                case 2:
                case 14:
                    NewPosition = 8;
                    break;
                
                case 3:
                case 15:
                    NewPosition = 9;
                    break;
                
                case 4:
                case 16:
                    NewPosition = 10;
                    break;
                
                case 5:
                case 17:
                    NewPosition = 11;
                    break;
                
                case 6:
                case 18:
                    NewPosition = 12;
                    break;
                
                case 7:
                case 19:
                    NewPosition = 1;
                    break;
                
                case 8:
                case 20:
                    NewPosition = 2;
                    break;
                
                case 9:
                case 21:
                    NewPosition = 3;
                    break;
                
                case 10:
                case 22:
                    NewPosition = 4;
                    break;
                
                case 11:
                case 23:
                    NewPosition = 5;
                    break;
                
                case 12:
                case 24:
                    NewPosition = 6;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_4:
            switch (arg0)
            {
                case 1:
                case 13:
                    NewPosition = 4;
                    break;
                
                case 2:
                case 14:
                    NewPosition = 5;
                    break;
                
                case 3:
                case 15:
                    NewPosition = 6;
                    break;
                
                case 4:
                case 16:
                    NewPosition = 7;
                    break;
                
                case 5:
                case 17:
                    NewPosition = 8;
                    break;
                
                case 6:
                case 18:
                    NewPosition = 9;
                    break;
                
                case 7:
                case 19:
                    NewPosition = 10;
                    break;
                
                case 8:
                case 20:
                    NewPosition = 11;
                    break;
                
                case 9:
                case 21:
                    NewPosition = 12;
                    break;
                
                case 10:
                case 22:
                    NewPosition = 1;
                    break;
                
                case 11:
                case 23:
                    NewPosition = 2;
                    break;
                
                case 12:
                case 24:
                    NewPosition = 3;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_5:
            switch (arg0)
            {
                case 1:
                case 13:
                    NewPosition = 10;
                    break;
                
                case 2:
                case 14:
                    NewPosition = 11;
                    break;
                
                case 3:
                case 15:
                    NewPosition = 12;
                    break;
                
                case 4:
                case 16:
                    NewPosition = 1;
                    break;
                
                case 5:
                case 17:
                    NewPosition = 2;
                    break;
                
                case 6:
                case 18:
                    NewPosition = 3;
                    break;
                
                case 7:
                case 19:
                    NewPosition = 4;
                    break;
                
                case 8:
                case 20:
                    NewPosition = 5;
                    break;
                
                case 9:
                case 21:
                    NewPosition = 6;
                    break;
                
                case 10:
                case 22:
                    NewPosition = 7;
                    break;
                
                case 11:
                case 23:
                    NewPosition = 8;
                    break;
                
                case 12:
                case 24:
                    NewPosition = 9;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_6:
            switch (arg0)
            {
                case 1:
                case 13:
                    NewPosition = 2;
                    break;
                
                case 2:
                case 14:
                    NewPosition = 1;
                    break;
                
                case 3:
                case 15:
                    NewPosition = 12;
                    break;
                
                case 4:
                case 16:
                    NewPosition = 11;
                    break;
                
                case 5:
                case 17:
                    NewPosition = 10;
                    break;
                
                case 6:
                case 18:
                    NewPosition = 9;
                    break;
                
                case 7:
                case 19:
                    NewPosition = 8;
                    break;
                
                case 8:
                case 20:
                    NewPosition = 7;
                    break;
                
                case 9:
                case 21:
                    NewPosition = 6;
                    break;
                
                case 10:
                case 22:
                    NewPosition = 5;
                    break;
                
                case 11:
                case 23:
                    NewPosition = 4;
                    break;
                
                case 12:
                case 24:
                    NewPosition = 3;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_7:
            switch (arg0)
            {
                case 1:
                case 13:
                    NewPosition = 8;
                    break;
                
                case 2:
                case 14:
                    NewPosition = 7;
                    break;
                
                case 3:
                case 15:
                    NewPosition = 6;
                    break;
                
                case 4:
                case 16:
                    NewPosition = 5;
                    break;
                
                case 5:
                case 17:
                    NewPosition = 4;
                    break;
                
                case 6:
                case 18:
                    NewPosition = 3;
                    break;
                
                case 7:
                case 19:
                    NewPosition = 2;
                    break;
                
                case 8:
                case 20:
                    NewPosition = 1;
                    break;
                
                case 9:
                case 21:
                    NewPosition = 12;
                    break;
                
                case 10:
                case 22:
                    NewPosition = 11;
                    break;
                
                case 11:
                case 23:
                    NewPosition = 10;
                    break;
                
                case 12:
                case 24:
                    NewPosition = 9;
                    break;
            }
            
            break;
    }
    
    if (arg1 != UnknownEnum.Value_0)
        NewPosition += ((arg0 > 12) ? 12 : 0);
    
    return NewPosition;
}

function GetTransformedDoorLocation(arg0, arg1)
{
    switch (arg1)
    {
        case UnknownEnum.Value_1:
            switch (arg0)
            {
                case "Left":
                    return "Right";
                
                case "Right":
                    return "Left";
            }
            
            break;
        
        case UnknownEnum.Value_2:
            switch (arg0)
            {
                case "Bottom":
                    return "Top";
                
                case "Top":
                    return "Bottom";
            }
            
            break;
        
        case UnknownEnum.Value_3:
            switch (arg0)
            {
                case "Left":
                    return "Right";
                
                case "Right":
                    return "Left";
                
                case "Bottom":
                    return "Top";
                
                case "Top":
                    return "Bottom";
            }
            
            break;
        
        case UnknownEnum.Value_4:
            switch (arg0)
            {
                case "Left":
                    return "Top";
                
                case "Right":
                    return "Bottom";
                
                case "Bottom":
                    return "Left";
                
                case "Top":
                    return "Right";
            }
            
            break;
        
        case UnknownEnum.Value_5:
            switch (arg0)
            {
                case "Left":
                    return "Bottom";
                
                case "Right":
                    return "Top";
                
                case "Bottom":
                    return "Right";
                
                case "Top":
                    return "Left";
            }
            
            break;
        
        case UnknownEnum.Value_6:
            switch (arg0)
            {
                case "Left":
                    return "Bottom";
                
                case "Right":
                    return "Top";
                
                case "Bottom":
                    return "Left";
                
                case "Top":
                    return "Right";
            }
            
            break;
        
        case UnknownEnum.Value_7:
            switch (arg0)
            {
                case "Left":
                    return "Top";
                
                case "Right":
                    return "Bottom";
                
                case "Bottom":
                    return "Right";
                
                case "Top":
                    return "Left";
            }
            
            break;
    }
    
    return arg0;
}

function GetTransformedSBShiftCode(arg0, arg1)
{
    arg0 = string_upper(arg0);
    var StrLen = string_length(arg0);
    var NewShiftCode = "";
    
    for (var StrChr = 1; StrChr <= StrLen; StrChr++)
    {
        var Chr = string_copy(arg0, StrChr, 1);
        var NewChr = Chr;
        
        switch (arg1)
        {
            case UnknownEnum.Value_1:
                switch (Chr)
                {
                    case "L":
                        NewChr = "R";
                        break;
                    
                    case "R":
                        NewChr = "L";
                        break;
                }
                
                break;
            
            case UnknownEnum.Value_2:
                switch (Chr)
                {
                    case "U":
                        NewChr = "D";
                        break;
                    
                    case "D":
                        NewChr = "U";
                        break;
                }
                
                break;
            
            case UnknownEnum.Value_3:
                switch (Chr)
                {
                    case "L":
                        NewChr = "R";
                        break;
                    
                    case "R":
                        NewChr = "L";
                        break;
                    
                    case "U":
                        NewChr = "D";
                        break;
                    
                    case "D":
                        NewChr = "U";
                        break;
                }
                
                break;
            
            case UnknownEnum.Value_4:
                switch (Chr)
                {
                    case "L":
                        NewChr = "U";
                        break;
                    
                    case "R":
                        NewChr = "D";
                        break;
                    
                    case "U":
                        NewChr = "R";
                        break;
                    
                    case "D":
                        NewChr = "L";
                        break;
                }
                
                break;
            
            case UnknownEnum.Value_5:
                switch (Chr)
                {
                    case "L":
                        NewChr = "D";
                        break;
                    
                    case "R":
                        NewChr = "U";
                        break;
                    
                    case "U":
                        NewChr = "L";
                        break;
                    
                    case "D":
                        NewChr = "R";
                        break;
                }
                
                break;
            
            case UnknownEnum.Value_6:
                switch (Chr)
                {
                    case "L":
                        NewChr = "D";
                        break;
                    
                    case "R":
                        NewChr = "U";
                        break;
                    
                    case "U":
                        NewChr = "R";
                        break;
                    
                    case "D":
                        NewChr = "L";
                        break;
                }
                
                break;
            
            case UnknownEnum.Value_7:
                switch (Chr)
                {
                    case "L":
                        NewChr = "U";
                        break;
                    
                    case "R":
                        NewChr = "D";
                        break;
                    
                    case "U":
                        NewChr = "L";
                        break;
                    
                    case "D":
                        NewChr = "R";
                        break;
                }
                
                break;
        }
        
        NewShiftCode = NewShiftCode + NewChr;
    }
    
    return NewShiftCode;
}

function GetTransformedSectionID(arg0, arg1)
{
    var NewSectionID = arg0;
    
    switch (arg1)
    {
        case UnknownEnum.Value_1:
            switch (arg0)
            {
                case 1:
                    NewSectionID = 3;
                    break;
                
                case 3:
                    NewSectionID = 1;
                    break;
                
                case 4:
                    NewSectionID = 5;
                    break;
                
                case 5:
                    NewSectionID = 4;
                    break;
                
                case 6:
                    NewSectionID = 8;
                    break;
                
                case 8:
                    NewSectionID = 6;
                    break;
                
                case 9:
                    NewSectionID = 10;
                    break;
                
                case 10:
                    NewSectionID = 9;
                    break;
                
                case 11:
                    NewSectionID = 12;
                    break;
                
                case 12:
                    NewSectionID = 11;
                    break;
                
                case 13:
                    NewSectionID = 14;
                    break;
                
                case 14:
                    NewSectionID = 13;
                    break;
                
                case 15:
                    NewSectionID = 16;
                    break;
                
                case 16:
                    NewSectionID = 15;
                    break;
                
                case 19:
                    NewSectionID = 20;
                    break;
                
                case 20:
                    NewSectionID = 19;
                    break;
                
                case 21:
                    NewSectionID = 22;
                    break;
                
                case 22:
                    NewSectionID = 21;
                    break;
                
                case 23:
                    NewSectionID = 24;
                    break;
                
                case 24:
                    NewSectionID = 23;
                    break;
                
                case 27:
                    NewSectionID = 28;
                    break;
                
                case 28:
                    NewSectionID = 27;
                    break;
                
                case 29:
                    NewSectionID = 30;
                    break;
                
                case 30:
                    NewSectionID = 29;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_2:
            switch (arg0)
            {
                case 1:
                    NewSectionID = 6;
                    break;
                
                case 6:
                    NewSectionID = 1;
                    break;
                
                case 2:
                    NewSectionID = 7;
                    break;
                
                case 7:
                    NewSectionID = 2;
                    break;
                
                case 3:
                    NewSectionID = 8;
                    break;
                
                case 8:
                    NewSectionID = 3;
                    break;
                
                case 9:
                    NewSectionID = 11;
                    break;
                
                case 11:
                    NewSectionID = 9;
                    break;
                
                case 10:
                    NewSectionID = 12;
                    break;
                
                case 12:
                    NewSectionID = 10;
                    break;
                
                case 13:
                    NewSectionID = 15;
                    break;
                
                case 15:
                    NewSectionID = 13;
                    break;
                
                case 14:
                    NewSectionID = 16;
                    break;
                
                case 16:
                    NewSectionID = 14;
                    break;
                
                case 17:
                    NewSectionID = 18;
                    break;
                
                case 18:
                    NewSectionID = 17;
                    break;
                
                case 21:
                    NewSectionID = 23;
                    break;
                
                case 23:
                    NewSectionID = 21;
                    break;
                
                case 22:
                    NewSectionID = 24;
                    break;
                
                case 24:
                    NewSectionID = 22;
                    break;
                
                case 27:
                    NewSectionID = 29;
                    break;
                
                case 29:
                    NewSectionID = 27;
                    break;
                
                case 28:
                    NewSectionID = 30;
                    break;
                
                case 30:
                    NewSectionID = 28;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_3:
            switch (arg0)
            {
                case 1:
                    NewSectionID = 8;
                    break;
                
                case 8:
                    NewSectionID = 1;
                    break;
                
                case 2:
                    NewSectionID = 7;
                    break;
                
                case 7:
                    NewSectionID = 2;
                    break;
                
                case 3:
                    NewSectionID = 6;
                    break;
                
                case 6:
                    NewSectionID = 3;
                    break;
                
                case 4:
                    NewSectionID = 5;
                    break;
                
                case 5:
                    NewSectionID = 4;
                    break;
                
                case 9:
                    NewSectionID = 12;
                    break;
                
                case 12:
                    NewSectionID = 9;
                    break;
                
                case 10:
                    NewSectionID = 11;
                    break;
                
                case 11:
                    NewSectionID = 10;
                    break;
                
                case 13:
                    NewSectionID = 16;
                    break;
                
                case 16:
                    NewSectionID = 13;
                    break;
                
                case 14:
                    NewSectionID = 15;
                    break;
                
                case 15:
                    NewSectionID = 14;
                    break;
                
                case 17:
                    NewSectionID = 18;
                    break;
                
                case 18:
                    NewSectionID = 17;
                    break;
                
                case 19:
                    NewSectionID = 20;
                    break;
                
                case 20:
                    NewSectionID = 19;
                    break;
                
                case 21:
                    NewSectionID = 24;
                    break;
                
                case 24:
                    NewSectionID = 21;
                    break;
                
                case 22:
                    NewSectionID = 23;
                    break;
                
                case 23:
                    NewSectionID = 22;
                    break;
                
                case 27:
                    NewSectionID = 30;
                    break;
                
                case 30:
                    NewSectionID = 27;
                    break;
                
                case 28:
                    NewSectionID = 29;
                    break;
                
                case 29:
                    NewSectionID = 28;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_4:
            switch (arg0)
            {
                case 1:
                    NewSectionID = 3;
                    break;
                
                case 2:
                    NewSectionID = 5;
                    break;
                
                case 3:
                    NewSectionID = 8;
                    break;
                
                case 4:
                    NewSectionID = 2;
                    break;
                
                case 5:
                    NewSectionID = 7;
                    break;
                
                case 6:
                    NewSectionID = 1;
                    break;
                
                case 7:
                    NewSectionID = 4;
                    break;
                
                case 8:
                    NewSectionID = 6;
                    break;
                
                case 9:
                    NewSectionID = 14;
                    break;
                
                case 10:
                    NewSectionID = 16;
                    break;
                
                case 11:
                    NewSectionID = 13;
                    break;
                
                case 12:
                    NewSectionID = 15;
                    break;
                
                case 13:
                    NewSectionID = 10;
                    break;
                
                case 14:
                    NewSectionID = 12;
                    break;
                
                case 15:
                    NewSectionID = 9;
                    break;
                
                case 16:
                    NewSectionID = 11;
                    break;
                
                case 17:
                    NewSectionID = 20;
                    break;
                
                case 18:
                    NewSectionID = 19;
                    break;
                
                case 19:
                    NewSectionID = 17;
                    break;
                
                case 20:
                    NewSectionID = 18;
                    break;
                
                case 21:
                    NewSectionID = 22;
                    break;
                
                case 22:
                    NewSectionID = 24;
                    break;
                
                case 23:
                    NewSectionID = 21;
                    break;
                
                case 24:
                    NewSectionID = 23;
                    break;
                
                case 25:
                    NewSectionID = 26;
                    break;
                
                case 26:
                    NewSectionID = 25;
                    break;
                
                case 27:
                    NewSectionID = 28;
                    break;
                
                case 28:
                    NewSectionID = 30;
                    break;
                
                case 29:
                    NewSectionID = 27;
                    break;
                
                case 30:
                    NewSectionID = 29;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_5:
            switch (arg0)
            {
                case 1:
                    NewSectionID = 6;
                    break;
                
                case 2:
                    NewSectionID = 4;
                    break;
                
                case 3:
                    NewSectionID = 1;
                    break;
                
                case 4:
                    NewSectionID = 7;
                    break;
                
                case 5:
                    NewSectionID = 2;
                    break;
                
                case 6:
                    NewSectionID = 8;
                    break;
                
                case 7:
                    NewSectionID = 5;
                    break;
                
                case 8:
                    NewSectionID = 3;
                    break;
                
                case 9:
                    NewSectionID = 15;
                    break;
                
                case 10:
                    NewSectionID = 13;
                    break;
                
                case 11:
                    NewSectionID = 16;
                    break;
                
                case 12:
                    NewSectionID = 14;
                    break;
                
                case 13:
                    NewSectionID = 11;
                    break;
                
                case 14:
                    NewSectionID = 9;
                    break;
                
                case 15:
                    NewSectionID = 12;
                    break;
                
                case 16:
                    NewSectionID = 10;
                    break;
                
                case 17:
                    NewSectionID = 19;
                    break;
                
                case 18:
                    NewSectionID = 20;
                    break;
                
                case 19:
                    NewSectionID = 18;
                    break;
                
                case 20:
                    NewSectionID = 17;
                    break;
                
                case 21:
                    NewSectionID = 23;
                    break;
                
                case 22:
                    NewSectionID = 21;
                    break;
                
                case 23:
                    NewSectionID = 24;
                    break;
                
                case 24:
                    NewSectionID = 22;
                    break;
                
                case 25:
                    NewSectionID = 26;
                    break;
                
                case 26:
                    NewSectionID = 25;
                    break;
                
                case 27:
                    NewSectionID = 29;
                    break;
                
                case 28:
                    NewSectionID = 27;
                    break;
                
                case 29:
                    NewSectionID = 30;
                    break;
                
                case 30:
                    NewSectionID = 28;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_6:
            switch (arg0)
            {
                case 1:
                    NewSectionID = 8;
                    break;
                
                case 2:
                    NewSectionID = 5;
                    break;
                
                case 4:
                    NewSectionID = 7;
                    break;
                
                case 5:
                    NewSectionID = 2;
                    break;
                
                case 7:
                    NewSectionID = 4;
                    break;
                
                case 8:
                    NewSectionID = 1;
                    break;
                
                case 9:
                    NewSectionID = 16;
                    break;
                
                case 10:
                    NewSectionID = 14;
                    break;
                
                case 11:
                    NewSectionID = 15;
                    break;
                
                case 12:
                    NewSectionID = 13;
                    break;
                
                case 13:
                    NewSectionID = 12;
                    break;
                
                case 14:
                    NewSectionID = 10;
                    break;
                
                case 15:
                    NewSectionID = 11;
                    break;
                
                case 16:
                    NewSectionID = 9;
                    break;
                
                case 17:
                    NewSectionID = 20;
                    break;
                
                case 18:
                    NewSectionID = 19;
                    break;
                
                case 19:
                    NewSectionID = 18;
                    break;
                
                case 20:
                    NewSectionID = 17;
                    break;
                
                case 21:
                    NewSectionID = 24;
                    break;
                
                case 24:
                    NewSectionID = 21;
                    break;
                
                case 25:
                    NewSectionID = 26;
                    break;
                
                case 26:
                    NewSectionID = 25;
                    break;
                
                case 27:
                    NewSectionID = 30;
                    break;
                
                case 30:
                    NewSectionID = 27;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_7:
            switch (arg0)
            {
                case 2:
                    NewSectionID = 4;
                    break;
                
                case 3:
                    NewSectionID = 6;
                    break;
                
                case 4:
                    NewSectionID = 2;
                    break;
                
                case 5:
                    NewSectionID = 7;
                    break;
                
                case 6:
                    NewSectionID = 3;
                    break;
                
                case 7:
                    NewSectionID = 5;
                    break;
                
                case 9:
                    NewSectionID = 13;
                    break;
                
                case 10:
                    NewSectionID = 15;
                    break;
                
                case 11:
                    NewSectionID = 14;
                    break;
                
                case 12:
                    NewSectionID = 16;
                    break;
                
                case 13:
                    NewSectionID = 9;
                    break;
                
                case 14:
                    NewSectionID = 11;
                    break;
                
                case 15:
                    NewSectionID = 10;
                    break;
                
                case 16:
                    NewSectionID = 12;
                    break;
                
                case 17:
                    NewSectionID = 19;
                    break;
                
                case 18:
                    NewSectionID = 20;
                    break;
                
                case 19:
                    NewSectionID = 17;
                    break;
                
                case 20:
                    NewSectionID = 18;
                    break;
                
                case 22:
                    NewSectionID = 23;
                    break;
                
                case 23:
                    NewSectionID = 22;
                    break;
                
                case 25:
                    NewSectionID = 26;
                    break;
                
                case 26:
                    NewSectionID = 25;
                    break;
                
                case 28:
                    NewSectionID = 29;
                    break;
                
                case 29:
                    NewSectionID = 28;
                    break;
            }
            
            break;
    }
    
    return NewSectionID;
}

function GetTransformedSectionIDReversed(arg0, arg1, arg2)
{
    switch (arg0)
    {
        case 1:
            if (arg2)
            {
                switch (arg1)
                {
                    case 1:
                        return UnknownEnum.Value_7;
                    
                    case 3:
                        return UnknownEnum.Value_4;
                    
                    case 6:
                        return UnknownEnum.Value_5;
                    
                    case 8:
                        return UnknownEnum.Value_6;
                }
            }
            else
            {
                switch (arg1)
                {
                    case 3:
                        return UnknownEnum.Value_1;
                    
                    case 6:
                        return UnknownEnum.Value_2;
                    
                    case 8:
                        return UnknownEnum.Value_3;
                }
            }
            
            break;
        
        case 2:
            if (arg2)
            {
                switch (arg1)
                {
                    case 4:
                        return UnknownEnum.Value_5;
                    
                    case 5:
                        return UnknownEnum.Value_4;
                }
            }
            else
            {
                switch (arg1)
                {
                    case 4:
                        return UnknownEnum.Value_5;
                    
                    case 5:
                        return UnknownEnum.Value_4;
                    
                    case 7:
                        return UnknownEnum.Value_2;
                }
            }
            
            break;
        
        case 3:
            if (arg2)
            {
                switch (arg1)
                {
                    case 1:
                        return UnknownEnum.Value_5;
                    
                    case 3:
                        return UnknownEnum.Value_6;
                    
                    case 6:
                        return UnknownEnum.Value_7;
                    
                    case 8:
                        return UnknownEnum.Value_4;
                }
            }
            else
            {
                switch (arg1)
                {
                    case 1:
                        return UnknownEnum.Value_1;
                    
                    case 6:
                        return UnknownEnum.Value_3;
                    
                    case 8:
                        return UnknownEnum.Value_2;
                }
            }
            
            break;
        
        case 4:
            switch (arg1)
            {
                case 2:
                    return UnknownEnum.Value_4;
                
                case 5:
                    return UnknownEnum.Value_1;
                
                case 7:
                    return UnknownEnum.Value_5;
            }
            
            break;
        
        case 5:
            switch (arg1)
            {
                case 2:
                    return UnknownEnum.Value_5;
                
                case 4:
                    return UnknownEnum.Value_1;
                
                case 7:
                    return UnknownEnum.Value_4;
            }
            
            break;
        
        case 6:
            if (arg2)
            {
                switch (arg1)
                {
                    case 1:
                        return UnknownEnum.Value_4;
                    
                    case 3:
                        return UnknownEnum.Value_7;
                    
                    case 6:
                        return UnknownEnum.Value_6;
                    
                    case 8:
                        return UnknownEnum.Value_5;
                }
            }
            else
            {
                switch (arg1)
                {
                    case 1:
                        return UnknownEnum.Value_2;
                    
                    case 3:
                        return UnknownEnum.Value_3;
                    
                    case 8:
                        return UnknownEnum.Value_1;
                }
            }
            
            break;
        
        case 7:
            if (arg2)
            {
                switch (arg1)
                {
                    case 4:
                        return UnknownEnum.Value_4;
                    
                    case 5:
                        return UnknownEnum.Value_5;
                }
            }
            else
            {
                switch (arg1)
                {
                    case 2:
                        return UnknownEnum.Value_2;
                    
                    case 4:
                        return UnknownEnum.Value_4;
                    
                    case 5:
                        return UnknownEnum.Value_5;
                }
            }
            
            break;
        
        case 8:
            if (arg2)
            {
                switch (arg1)
                {
                    case 1:
                        return UnknownEnum.Value_6;
                    
                    case 3:
                        return UnknownEnum.Value_5;
                    
                    case 6:
                        return UnknownEnum.Value_4;
                    
                    case 8:
                        return UnknownEnum.Value_7;
                }
            }
            else
            {
                switch (arg1)
                {
                    case 1:
                        return UnknownEnum.Value_3;
                    
                    case 3:
                        return UnknownEnum.Value_2;
                    
                    case 6:
                        return UnknownEnum.Value_1;
                }
            }
            
            break;
        
        case 9:
            if (arg2)
            {
                switch (arg1)
                {
                    case 13:
                        return UnknownEnum.Value_7;
                    
                    case 14:
                        return UnknownEnum.Value_4;
                    
                    case 15:
                        return UnknownEnum.Value_5;
                    
                    case 16:
                        return UnknownEnum.Value_6;
                }
            }
            else
            {
                switch (arg1)
                {
                    case 10:
                        return UnknownEnum.Value_1;
                    
                    case 11:
                        return UnknownEnum.Value_2;
                    
                    case 12:
                        return UnknownEnum.Value_3;
                    
                    case 13:
                        return UnknownEnum.Value_7;
                    
                    case 14:
                        return UnknownEnum.Value_4;
                    
                    case 15:
                        return UnknownEnum.Value_5;
                    
                    case 16:
                        return UnknownEnum.Value_6;
                }
            }
            
            break;
        
        case 10:
            if (arg2)
            {
                switch (arg1)
                {
                    case 13:
                        return UnknownEnum.Value_5;
                    
                    case 14:
                        return UnknownEnum.Value_6;
                    
                    case 15:
                        return UnknownEnum.Value_7;
                    
                    case 16:
                        return UnknownEnum.Value_4;
                }
            }
            else
            {
                switch (arg1)
                {
                    case 9:
                        return UnknownEnum.Value_1;
                    
                    case 11:
                        return UnknownEnum.Value_3;
                    
                    case 12:
                        return UnknownEnum.Value_2;
                    
                    case 13:
                        return UnknownEnum.Value_5;
                    
                    case 14:
                        return UnknownEnum.Value_6;
                    
                    case 15:
                        return UnknownEnum.Value_7;
                    
                    case 16:
                        return UnknownEnum.Value_4;
                }
            }
            
            break;
        
        case 11:
            if (arg2)
            {
                switch (arg1)
                {
                    case 13:
                        return UnknownEnum.Value_4;
                    
                    case 14:
                        return UnknownEnum.Value_7;
                    
                    case 15:
                        return UnknownEnum.Value_6;
                    
                    case 16:
                        return UnknownEnum.Value_5;
                }
            }
            else
            {
                switch (arg1)
                {
                    case 9:
                        return UnknownEnum.Value_2;
                    
                    case 10:
                        return UnknownEnum.Value_3;
                    
                    case 12:
                        return UnknownEnum.Value_1;
                    
                    case 13:
                        return UnknownEnum.Value_4;
                    
                    case 14:
                        return UnknownEnum.Value_7;
                    
                    case 15:
                        return UnknownEnum.Value_6;
                    
                    case 16:
                        return UnknownEnum.Value_5;
                }
            }
            
            break;
        
        case 12:
            if (arg2)
            {
                switch (arg1)
                {
                    case 13:
                        return UnknownEnum.Value_6;
                    
                    case 14:
                        return UnknownEnum.Value_5;
                    
                    case 15:
                        return UnknownEnum.Value_4;
                    
                    case 16:
                        return UnknownEnum.Value_7;
                }
            }
            else
            {
                switch (arg1)
                {
                    case 9:
                        return UnknownEnum.Value_3;
                    
                    case 10:
                        return UnknownEnum.Value_2;
                    
                    case 11:
                        return UnknownEnum.Value_1;
                    
                    case 13:
                        return UnknownEnum.Value_6;
                    
                    case 14:
                        return UnknownEnum.Value_5;
                    
                    case 15:
                        return UnknownEnum.Value_4;
                    
                    case 16:
                        return UnknownEnum.Value_7;
                }
            }
            
            break;
        
        case 13:
            switch (arg1)
            {
                case 9:
                    return UnknownEnum.Value_7;
                
                case 10:
                    return UnknownEnum.Value_4;
                
                case 11:
                    return UnknownEnum.Value_5;
                
                case 12:
                    return UnknownEnum.Value_6;
                
                case 14:
                    return UnknownEnum.Value_1;
                
                case 15:
                    return UnknownEnum.Value_2;
                
                case 16:
                    return UnknownEnum.Value_3;
            }
            
            break;
        
        case 14:
            switch (arg1)
            {
                case 9:
                    return UnknownEnum.Value_5;
                
                case 10:
                    return UnknownEnum.Value_6;
                
                case 11:
                    return UnknownEnum.Value_7;
                
                case 12:
                    return UnknownEnum.Value_4;
                
                case 13:
                    return UnknownEnum.Value_1;
                
                case 15:
                    return UnknownEnum.Value_3;
                
                case 16:
                    return UnknownEnum.Value_2;
            }
            
            break;
        
        case 15:
            switch (arg1)
            {
                case 9:
                    return UnknownEnum.Value_4;
                
                case 10:
                    return UnknownEnum.Value_7;
                
                case 11:
                    return UnknownEnum.Value_6;
                
                case 12:
                    return UnknownEnum.Value_5;
                
                case 13:
                    return UnknownEnum.Value_2;
                
                case 14:
                    return UnknownEnum.Value_3;
                
                case 16:
                    return UnknownEnum.Value_1;
            }
            
            break;
        
        case 16:
            switch (arg1)
            {
                case 9:
                    return UnknownEnum.Value_6;
                
                case 10:
                    return UnknownEnum.Value_5;
                
                case 11:
                    return UnknownEnum.Value_4;
                
                case 12:
                    return UnknownEnum.Value_7;
                
                case 13:
                    return UnknownEnum.Value_3;
                
                case 14:
                    return UnknownEnum.Value_2;
                
                case 15:
                    return UnknownEnum.Value_1;
            }
            
            break;
        
        case 17:
            if (arg2)
            {
                switch (arg1)
                {
                    case 19:
                        return UnknownEnum.Value_5;
                    
                    case 20:
                        return UnknownEnum.Value_4;
                }
            }
            else
            {
                switch (arg1)
                {
                    case 18:
                        return UnknownEnum.Value_2;
                    
                    case 19:
                        return UnknownEnum.Value_5;
                    
                    case 20:
                        return UnknownEnum.Value_4;
                }
            }
            
            break;
        
        case 18:
            if (arg2)
            {
                switch (arg1)
                {
                    case 19:
                        return UnknownEnum.Value_4;
                    
                    case 20:
                        return UnknownEnum.Value_5;
                }
            }
            else
            {
                switch (arg1)
                {
                    case 17:
                        return UnknownEnum.Value_2;
                    
                    case 19:
                        return UnknownEnum.Value_4;
                    
                    case 20:
                        return UnknownEnum.Value_5;
                }
            }
            
            break;
        
        case 19:
            switch (arg1)
            {
                case 17:
                    return UnknownEnum.Value_4;
                
                case 18:
                    return UnknownEnum.Value_5;
                
                case 20:
                    return UnknownEnum.Value_1;
            }
            
            break;
        
        case 20:
            switch (arg1)
            {
                case 17:
                    return UnknownEnum.Value_5;
                
                case 18:
                    return UnknownEnum.Value_4;
                
                case 19:
                    return UnknownEnum.Value_1;
            }
            
            break;
        
        case 21:
            switch (arg1)
            {
                case 22:
                    return UnknownEnum.Value_1;
                
                case 23:
                    return UnknownEnum.Value_2;
                
                case 24:
                    return UnknownEnum.Value_3;
            }
            
            break;
        
        case 22:
            switch (arg1)
            {
                case 21:
                    return UnknownEnum.Value_1;
                
                case 23:
                    return UnknownEnum.Value_3;
                
                case 24:
                    return UnknownEnum.Value_2;
            }
            
            break;
        
        case 23:
            switch (arg1)
            {
                case 21:
                    return UnknownEnum.Value_2;
                
                case 22:
                    return UnknownEnum.Value_3;
                
                case 24:
                    return UnknownEnum.Value_1;
            }
            
            break;
        
        case 24:
            switch (arg1)
            {
                case 21:
                    return UnknownEnum.Value_3;
                
                case 22:
                    return UnknownEnum.Value_2;
                
                case 23:
                    return UnknownEnum.Value_1;
            }
            
            break;
        
        case 25:
            switch (arg1)
            {
                case 26:
                    return UnknownEnum.Value_4;
            }
            
            break;
        
        case 26:
            switch (arg1)
            {
                case 25:
                    return UnknownEnum.Value_4;
            }
            
            break;
        
        case 27:
            switch (arg1)
            {
                case 28:
                    return UnknownEnum.Value_1;
                
                case 29:
                    return UnknownEnum.Value_2;
                
                case 30:
                    return UnknownEnum.Value_3;
            }
            
            break;
        
        case 28:
            switch (arg1)
            {
                case 27:
                    return UnknownEnum.Value_1;
                
                case 29:
                    return UnknownEnum.Value_3;
                
                case 30:
                    return UnknownEnum.Value_2;
            }
            
            break;
        
        case 29:
            switch (arg1)
            {
                case 27:
                    return UnknownEnum.Value_2;
                
                case 28:
                    return UnknownEnum.Value_3;
                
                case 30:
                    return UnknownEnum.Value_1;
            }
            
            break;
        
        case 30:
            switch (arg1)
            {
                case 27:
                    return UnknownEnum.Value_3;
                
                case 28:
                    return UnknownEnum.Value_2;
                
                case 29:
                    return UnknownEnum.Value_1;
            }
            
            break;
    }
    
    return -1;
}

function SectionFamilyCheck(arg0, arg1)
{
    if ((arg0 == 1 || arg0 == 3 || arg0 == 6 || arg0 == 8) && (arg1 == 1 || arg1 == 3 || arg1 == 6 || arg1 == 8))
        return true;
    
    if ((arg0 == 2 || arg0 == 4 || arg0 == 5 || arg0 == 7) && (arg1 == 2 || arg1 == 4 || arg1 == 5 || arg1 == 7))
        return true;
    
    if (arg0 >= 9 && arg0 <= 16 && arg1 >= 9 && arg1 <= 16)
        return true;
    
    if (arg0 >= 17 && arg0 <= 20 && arg1 >= 17 && arg1 <= 20)
        return true;
    
    if (arg0 >= 21 && arg0 <= 24 && arg1 >= 21 && arg1 <= 24)
        return true;
    
    if (arg0 >= 25 && arg0 <= 26 && arg1 >= 25 && arg1 <= 26)
        return true;
    
    if (arg0 >= 27 && arg0 <= 30 && arg1 >= 27 && arg1 <= 30)
        return true;
    
    return false;
}

function GetTransformedObjRotation(arg0, arg1)
{
    var NewRotation = arg0;
    
    switch (arg1)
    {
        case UnknownEnum.Value_1:
            switch (arg0)
            {
                case 90:
                    return -90;
                
                case -90:
                    return 90;
            }
            
            break;
        
        case UnknownEnum.Value_2:
            switch (arg0)
            {
                case 0:
                    return 180;
                
                case 180:
                    return 0;
            }
            
            break;
        
        case UnknownEnum.Value_3:
            switch (arg0)
            {
                case 0:
                    return 180;
                
                case 90:
                    return -90;
                
                case -90:
                    return 90;
                
                case 180:
                    return 0;
            }
            
            break;
        
        case UnknownEnum.Value_4:
            switch (arg0)
            {
                case 0:
                    return 90;
                
                case 90:
                    return 180;
                
                case -90:
                    return 0;
                
                case 180:
                    return -90;
            }
            
            break;
        
        case UnknownEnum.Value_5:
            switch (arg0)
            {
                case 0:
                    return -90;
                
                case 90:
                    return 0;
                
                case -90:
                    return 180;
                
                case 180:
                    return 90;
            }
            
            break;
        
        case UnknownEnum.Value_6:
            switch (arg0)
            {
                case 0:
                    return 90;
                
                case 90:
                    return 0;
                
                case -90:
                    return 180;
                
                case 180:
                    return -90;
            }
            
            break;
        
        case UnknownEnum.Value_7:
            switch (arg0)
            {
                case 0:
                    return -90;
                
                case 90:
                    return 180;
                
                case -90:
                    return 0;
                
                case 180:
                    return 90;
            }
            
            break;
    }
    
    return NewRotation;
}

function GetTransformedPotStartingCorner(arg0, arg1)
{
    switch (arg1)
    {
        case UnknownEnum.Value_1:
            switch (arg0)
            {
                case "L":
                    return "R";
                
                case "R":
                    return "L";
            }
            
            break;
        
        case UnknownEnum.Value_2:
            switch (arg0)
            {
                case "D":
                    return "U";
                
                case "U":
                    return "D";
            }
            
            break;
        
        case UnknownEnum.Value_3:
            switch (arg0)
            {
                case "L":
                    return "R";
                
                case "R":
                    return "L";
                
                case "D":
                    return "U";
                
                case "U":
                    return "D";
            }
            
            break;
        
        case UnknownEnum.Value_4:
            switch (arg0)
            {
                case "L":
                    return "U";
                
                case "R":
                    return "D";
                
                case "D":
                    return "L";
                
                case "U":
                    return "R";
            }
            
            break;
        
        case UnknownEnum.Value_5:
            switch (arg0)
            {
                case "L":
                    return "D";
                
                case "R":
                    return "U";
                
                case "D":
                    return "R";
                
                case "U":
                    return "L";
            }
            
            break;
        
        case UnknownEnum.Value_6:
            switch (arg0)
            {
                case "L":
                    return "D";
                
                case "R":
                    return "U";
                
                case "D":
                    return "L";
                
                case "U":
                    return "R";
            }
            
            break;
        
        case UnknownEnum.Value_7:
            switch (arg0)
            {
                case "L":
                    return "U";
                
                case "R":
                    return "D";
                
                case "D":
                    return "R";
                
                case "U":
                    return "L";
            }
            
            break;
    }
    
    return arg0;
}

function TransformationStr(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_0:
            return "None";
        
        case UnknownEnum.Value_1:
            return "FlipH";
        
        case UnknownEnum.Value_2:
            return "FlipV";
        
        case UnknownEnum.Value_3:
            return "FlipHV";
        
        case UnknownEnum.Value_4:
            return "RotateCW";
        
        case UnknownEnum.Value_5:
            return "RotateCCW";
        
        case UnknownEnum.Value_6:
            return "FlipHRotateCW";
        
        case UnknownEnum.Value_7:
            return "FlipHRotateCCW";
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
    Value_48 = 48,
    Value_49,
    Value_50,
    Value_51,
    Value_218 = 218,
    Value_219,
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
    Value_302 = 302,
    Value_303,
    Value_304,
    Value_305,
    Value_306,
    Value_307,
    Value_308,
    Value_309,
    Value_310,
    Value_311,
    Value_312,
    Value_313
}
