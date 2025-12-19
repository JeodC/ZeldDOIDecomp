function Treasure_Create(arg0, arg1, arg2, arg3, arg4, arg5 = true, arg6 = false, arg7 = UnknownEnum.Value_2, arg8 = UnknownEnum.Value_2)
{
    var FloorLevelStr = GetFloorLevelString(arg1, arg2);
    var FloorLevelID = GetFloorLevelID(FloorLevelStr);
    var Layer;
    
    if (arg5)
        Layer = "ObjsFloor_" + FloorLevelStr;
    else
        Layer = "Objs_" + FloorLevelStr;
    
    var TreasureInst = instance_create_layer(arg1 + 8, arg2 + 16, Layer, oItem_Treasure, 
    {
        From: arg7,
        ContentsFrom: arg8
    });
    TreasureInst.ContentsObj = arg3;
    TreasureInst.FloorLevel = FloorLevelID;
    TreasureInst.InSection = arg6;
    TreasureInst.RoomIndex = arg0;
    
    if (arg3 == UnknownEnum.Value_20)
        TreasureInst.sprite_index = sItem_Treasure_Key;
    
    if (arg4)
    {
        TreasureInst.WallInst = WallObj_Create(Layer, arg1, arg2, 2, 2);
        TreasureInst.WallInst.FloorLevel = FloorLevelID;
        TreasureInst.WallInst.BlockProjectiles = false;
        TreasureInst.WallInst.BlockItems = false;
    }
    
    if (global.Switch_Add)
    {
        global.Level.Rooms[arg0].Switch.HiddenObjInst = TreasureInst;
        TreasureInst.visible = false;
        TreasureInst.IsSwitchTreasure = true;
        
        if (arg4)
        {
            TreasureInst.WallInst.BlockLink = false;
            TreasureInst.WallInst.BlockProjectiles = false;
            TreasureInst.WallInst.BlockEnemies = false;
            TreasureInst.WallInst.IsHiddenObj = true;
        }
    }
    
    return TreasureInst;
}

function Treasure_Open(arg0)
{
    var _DoCurse;
    
    if (global.Challenges[UnknownEnum.Value_6])
        _DoCurse = Prob(0.2 + (global.Level.Index * 0.005 * 2));
    else
        _DoCurse = Prob(0.055 + (global.Level.Index * 0.005)) && !FromAnyKinstone(arg0.ContentsFrom) && global.Level.Index != UnknownEnum.Value_1 && global.Level.Index != UnknownEnum.Value_6 && global.Level.Index != UnknownEnum.Value_10;
    
    if (!global.Cursed && arg0.ContentsObj == -99 && _DoCurse)
    {
        var CursedInst = instance_create_layer(arg0.x, arg0.y - 12, "ObjsHighest", oCursed);
        
        if (FromAnyStore(arg0.From))
            CursedInst.depth = arg0.depth - 10;
    }
    else
    {
        if (arg0.ContentsObj == -99)
        {
            arg0.ContentsObj = Probs_RandomItemClass(arg0.ContentsFrom);
            
            if (global.Swordless)
            {
                if (arg0.ContentsObj != UnknownEnum.Value_7)
                {
                    if (Item_Allowed(UnknownEnum.Value_7))
                    {
                        if (Prob(0.04))
                            arg0.ContentsObj = UnknownEnum.Value_7;
                    }
                }
            }
            else if (arg0.ContentsObj != UnknownEnum.Value_44)
            {
                if (global.Inventory_ItemData[UnknownEnum.Value_44].Index == 0 && global.Level.Index > UnknownEnum.Value_1 && !FromAnyKinstone(arg0.From))
                {
                    if (Item_Allowed(UnknownEnum.Value_44))
                    {
                        if (Prob(min(0.05 + ((global.Level.Index - 1) * 0.05), 0.28)))
                            arg0.ContentsObj = UnknownEnum.Value_44;
                    }
                }
            }
            
            if (Curse_Check(UnknownEnum.Value_6))
            {
                if (arg0.ContentsObj != UnknownEnum.Value_18)
                {
                    if (global.CurseTaskItem == UnknownEnum.Value_18)
                    {
                        if (Item_Allowed(UnknownEnum.Value_18))
                        {
                            if (Prob(0.15))
                                arg0.ContentsObj = UnknownEnum.Value_18;
                        }
                    }
                }
            }
            
            if (Curse_Check(UnknownEnum.Value_2))
            {
                if (arg0.ContentsObj == UnknownEnum.Value_18)
                {
                    if (global.CurseTask == UnknownEnum.Value_1 && global.CurseTaskCount == 1)
                        global.CurseTreasure_HeartPiece = true;
                }
            }
            
            if (Curse_Check(UnknownEnum.Value_0))
            {
                if (arg0.ContentsObj == UnknownEnum.Value_40)
                {
                    if (global.CurseTask == UnknownEnum.Value_1 && global.CurseTaskCount == 1)
                        global.CurseTreasure_Rupees = true;
                }
            }
        }
        
        var _Item = ItemSpawn(arg0.ContentsObj, arg0.x, arg0.y - 6, arg0.ContentsFrom, UnknownEnum.Value_9, 1);
        
        if (_Item != -4)
        {
            _Item.depth = 0;
            audio_play_sound(Sound_ChestOpen, 1, false);
        }
        else
        {
            audio_play_sound(Sound_Arrow_Hit, 1, false);
            MsgBox("Nothing inside");
        }
    }
    
    arg0.image_index = 1;
    global.StatsToAdd[UnknownEnum.Value_5]++;
}

function TreasureLarge_Open(arg0)
{
    var _Item = ItemSpawn((arg0.ContentsObj == -99) ? Probs_RandomItemClass(UnknownEnum.Value_3) : arg0.ContentsObj, arg0.x + 16, arg0.y + 6, UnknownEnum.Value_3, UnknownEnum.Value_9, 1);
    
    if (_Item != -4)
    {
        audio_play_sound(Sound_ChestOpen, 1, false);
    }
    else
    {
        audio_play_sound(Sound_Arrow_Hit, 1, false);
        MsgBox("Nothing inside");
    }
    
    var _TileLayer = GetFloorLevelTMID("Tiles_Decor", arg0.x, arg0.y);
    DrawTileBlock(_TileLayer, arg0.x, arg0.y, 11, 0, 4, 3);
    instance_destroy(arg0);
    global.StatsToAdd[UnknownEnum.Value_5]++;
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_5 = 5,
    Value_6,
    Value_7,
    Value_9 = 9,
    Value_10,
    Value_18 = 18,
    Value_20 = 20,
    Value_40 = 40,
    Value_44 = 44
}
