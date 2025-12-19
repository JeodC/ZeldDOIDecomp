function Link_SetStartingItems()
{
    global.Inventory_ItemData[UnknownEnum.Value_40].Amount = 0;
    global.Inventory_ItemData[UnknownEnum.Value_18].Amount = 4;
    global.Inventory_ItemData[UnknownEnum.Value_26].Amount = 0;
    global.Inventory_ItemData[UnknownEnum.Value_2].Index = 0;
    Inventory_CalculateSlotIndexes();
    Item_Get(UnknownEnum.Value_44, UnknownEnum.Value_0);
    
    switch (global.StartingGear)
    {
        case UnknownEnum.Value_1:
            global.Inventory_ItemData[UnknownEnum.Value_40].Amount = 100;
            break;
        
        case UnknownEnum.Value_3:
            global.Inventory_ItemData[UnknownEnum.Value_18].Amount++;
            break;
        
        case UnknownEnum.Value_4:
            Item_Get(UnknownEnum.Value_41, 0);
            break;
        
        case UnknownEnum.Value_5:
            Item_Get(UnknownEnum.Value_39, UnknownEnum.Value_0, 16);
            break;
        
        case UnknownEnum.Value_6:
            Item_Get(UnknownEnum.Value_33, UnknownEnum.Value_0, 10);
            break;
        
        case UnknownEnum.Value_7:
            Item_Get(UnknownEnum.Value_36, UnknownEnum.Value_3, 1);
            break;
    }
    
    global.Inventory_ItemData[UnknownEnum.Value_17].Amount = global.Inventory_ItemData[UnknownEnum.Value_18].Amount;
}

function Link_SetStartingPos()
{
    oCamera.SetCurrentRoom(global.Level.RoomIndex_Entrance);
    global.TransitionRoom = -1;
    global.TransitionRoomIndex = -1;
    var EntranceRoom = global.Level.Rooms[global.Level.RoomIndex_Entrance];
    var RoomX = EntranceRoom.x;
    var RoomY = EntranceRoom.y;
    var RoomGridW = EntranceRoom.GridW;
    var RoomGridH = EntranceRoom.GridH;
    var _RSI = global.RoomSizeIndex[RoomGridW][RoomGridH];
    var _EntranceDoorPos = 6;
    
    for (var _DoorIndex = 0; _DoorIndex < array_length(EntranceRoom.Doors); _DoorIndex++)
    {
        var _RoomDoor = EntranceRoom.Doors[_DoorIndex];
        
        if (_RoomDoor.Status == UnknownEnum.Value_3)
        {
            _EntranceDoorPos = _RoomDoor.Position;
            break;
        }
    }
    
    oLink.Facing = global.Level.StartDir;
    var EntranceDoorX = RoomX + global.DoorCoordinates[_RSI][_EntranceDoorPos].x;
    var EntranceDoorY = RoomY + global.DoorCoordinates[_RSI][_EntranceDoorPos].y;
    oLink.x = EntranceDoorX + 16;
    oLink.y = EntranceDoorY + 16;
    oLink.HitBox.x = oLink.x;
    oLink.HitBox.y = oLink.y;
    oLink.image_index = 0;
    oLink.image_speed = 1;
    oLink.FloorLevel = GetFloorLevelID(EntranceDoorX, EntranceDoorY);
    oLink.layer = (oLink.FloorLevel == 1) ? global.LayerID_Objs_Upper : global.LayerID_Objs_Lower;
    oLink.LampDim = oLink.FloorLevel;
    oLink.GoingThruClosedDoorID = -4;
    oLink.MoveAssist = false;
    oLink.MoveAssistDir = 0;
    oLink.Cape = false;
    oLink.ItemHolding = -4;
    Lighting_UpdateLinkLight([oLink.x, oLink.y], global.Inventory_ItemData[UnknownEnum.Value_24].Owns[0] ? 1.5 : 1, [oLink.LampLightR, oLink.LampLightG, oLink.LampLightB]);
    
    with (oHUD)
    {
        DungeonLinkY = HUD_DungeonLinkY();
        
        if (!global.SaveLevel)
            ShowLevelName = true;
    }
    
    global.Level.Rooms[global.CurrentRoomIndex].Visited = true;
    Map_UpdateExploredRooms();
    global.InWaterSprite = (global.Level.Index == UnknownEnum.Value_10) ? sInMineWater : ((global.Level.Index == UnknownEnum.Value_12) ? sInBlood : sInWater);
    
    if (global.Level.Index == UnknownEnum.Value_0)
        exit;
    
    oLink.FallSpawnX = oLink.x;
    oLink.FallSpawnY = oLink.y;
    oLink.FallSpawnFloorLevel = oLink.FloorLevel;
    oLink.FallSpawnFacing = oLink.Facing;
    var _LevelTilesY = (global.Level.Index == UnknownEnum.Value_13) ? 70 : (4 + ((global.Level.Index - 1) * 6));
    global.HoleTileID_TL = GetTileID(102, _LevelTilesY + 4);
    global.HoleTileID_TM = GetTileID(104, _LevelTilesY + 4);
    global.HoleTileID_TR = GetTileID(103, _LevelTilesY + 4);
    global.HoleTileID_ML = GetTileID(104, _LevelTilesY + 5);
    global.HoleTileID_MR = GetTileID(105, _LevelTilesY + 4);
    global.HoleTileID_BL = GetTileID(102, _LevelTilesY + 5);
    global.HoleTileID_BM = GetTileID(105, _LevelTilesY + 5);
    global.HoleTileID_BR = GetTileID(103, _LevelTilesY + 5);
    global.HoleTileID_ITL = GetTileID(106, _LevelTilesY + 4);
    global.HoleTileID_ITR = GetTileID(107, _LevelTilesY + 4);
    global.HoleTileID_IBL = GetTileID(106, _LevelTilesY + 5);
    global.HoleTileID_IBR = GetTileID(107, _LevelTilesY + 5);
    
    for (var _RoomIndex = 0; _RoomIndex < global.Level.RoomCount; _RoomIndex++)
        Dungeon_RoomDeActivate(_RoomIndex);
    
    Dungeon_RoomActivate(global.CurrentRoomIndex);
    
    if (global.Level.Index == UnknownEnum.Value_1)
    {
        with (oLink)
        {
            Link_SetAutoMove(0, (global.Level.StartDir == 1) ? -1 : 1, 0.5, 28);
            var _Leaves = irandom_range(6, 7);
            
            repeat (_Leaves)
                instance_create_layer(x + irandom_range(-3, 3), y + 8, "ObjsHigher_Upper", oLeaf_Inside);
        }
    }
    
    if (global.Continue)
    {
        with (oLink)
        {
            x = 912;
            y = 830;
            Facing = 2;
            UpdateSprites();
        }
        
        with (oDoor)
        {
            if (Status == UnknownEnum.Value_3)
            {
                Status = UnknownEnum.Value_1;
                UpdateStatus = true;
                break;
            }
        }
        
        global.Continue = false;
    }
    
    oCamera.Cam_UpdatePos();
    camera_set_view_pos(view_camera[1], oCamera.X, oCamera.Y);
}

function UpdateState(arg0, arg1 = undefined)
{
    if (StarActive)
        exit;
    
    State = arg0;
    image_index = 0;
    UpdateSprites();
    alarm[1] = -1;
    
    if (instance_exists(oSword))
        instance_destroy(oSword);
    
    if (instance_exists(oRod_Cane))
        instance_destroy(oRod_Cane);
    
    if (instance_exists(oHookshot))
        instance_destroy(oHookshot);
    
    switch (State)
    {
        case UnknownEnum.Value_1:
            AutoMoveFrames = 0;
            BounceBack = false;
            vx = 0;
            vy = 0;
            image_index = (ItemHolding != -4 && instance_exists(ItemHolding)) ? 1 : 0;
            
            if (UncurseAfterStar)
            {
                UncurseAfterStar = false;
                MsgBox("Task completed!\\You are now uncursed.", undefined, undefined, Curse_Done);
            }
            
            break;
        
        case UnknownEnum.Value_12:
            var _FloorLevelStr = GetFloorLevelString(FloorLevel);
            var SwordInst = instance_create_layer(x, y, "Objs_" + _FloorLevelStr, oSword);
            SwordInst.FloorLevel = FloorLevel;
            audio_play_sound(asset_get_index("Sound_Sword" + string(global.Inventory_ItemData[UnknownEnum.Value_44].Index + 1)), 1, false);
            
            if (SwordLevel(UnknownEnum.Value_5))
            {
                if (global.Inventory_ItemData[UnknownEnum.Value_17].Amount == global.Inventory_ItemData[UnknownEnum.Value_18].Amount)
                {
                    if (!instance_exists(oSwordBeam))
                    {
                        instance_create_layer(x, y, "ObjsHigher_" + _FloorLevelStr, oSwordBeam, 
                        {
                            FloorLevel: FloorLevel
                        });
                    }
                }
            }
            
            break;
        
        case UnknownEnum.Value_13:
            ObjSetImageSpeed(1);
            
            if (global.Inventory_ItemData[UnknownEnum.Value_0].Owns[0])
                Item_Consume(UnknownEnum.Value_1, 0, -1);
            else
                Inventory_Add(UnknownEnum.Value_1, 0, -1, Inventory_ItemClassExists(UnknownEnum.Value_1));
            
            Bow_Set();
            break;
        
        case UnknownEnum.Value_14:
            instance_create_layer(x, y, "ObjsHigher_" + GetFloorLevelString(FloorLevel), oBoomerang);
            break;
        
        case UnknownEnum.Value_16:
            Rod_Shoot();
            audio_play_sound(Sound_Rod, 1, false);
            break;
        
        case UnknownEnum.Value_15:
            instance_create_layer(x, y - 5, "ObjsHigher_" + GetFloorLevelString(FloorLevel), oHookshot);
            break;
        
        case UnknownEnum.Value_17:
            var FloorLevelStr = GetFloorLevelString(FloorLevel);
            
            switch (Facing)
            {
                case 3:
                    var PowderInst = instance_create_layer(x - 12, y - 6, "ObjsHigher_" + FloorLevelStr, oPowder);
                    PowderInst.sprite_index = sPowder_Left;
                    break;
                
                case 4:
                    var PowderInst = instance_create_layer(x + 12, y - 6, "ObjsHigher_" + FloorLevelStr, oPowder);
                    PowderInst.sprite_index = sPowder_Right;
                    break;
                
                case 1:
                    var PowderInst = instance_create_layer(x, y - 29, "ObjsHigher_" + FloorLevelStr, oPowder);
                    PowderInst.sprite_index = sPowder_Up;
                    break;
                
                case 2:
                    var PowderInst = instance_create_layer(x, y + 2, "ObjsHigher_" + FloorLevelStr, oPowder);
                    PowderInst.sprite_index = sPowder_Down;
                    break;
            }
            
            audio_play_sound(Sound_Powder, 1, false);
            audio_play_sound(Sound_FairySprinkle, 1, false);
            break;
        
        case UnknownEnum.Value_19:
            var _FloorLevelStr = GetFloorLevelString(FloorLevel);
            var SwordInst = instance_create_layer(x, y, "Objs_" + _FloorLevelStr, oSword);
            SwordInst.FloorLevel = FloorLevel;
            
            if (ItemHolding != -4)
                LinkThrow();
            
            instance_destroy(oCape);
            Invincible = true;
            HitFlashingStatus = false;
            StarActive = true;
            alarm[4] = -1;
            alarm[5] = -1;
            alarm[7] = StarColorDelay;
            alarm[8] = StarTimer;
            Music_Play(UnknownEnum.Value_16);
            break;
        
        case UnknownEnum.Value_6:
            ItemHolding = arg1;
            
            switch (ItemHolding.object_index)
            {
                case oEnemy_Chicken:
                    with (ItemHolding)
                    {
                        PickedUp = true;
                        vx = 0;
                        vy = 0;
                        Chicken_SetScared();
                        
                        if (Egg)
                        {
                            ItemDrop(x, y, UnknownEnum.Value_13, GoldenEgg ? UnknownEnum.Value_51 : UnknownEnum.Value_18, 1, UnknownEnum.Value_0);
                            Egg = false;
                            GoldenEgg = false;
                        }
                    }
                    
                    break;
                
                case oItem_Orb:
                case oItem_Gem:
                case oItem_Bombs:
                case oItem_WishStone:
                    var _Inst = instance_create_layer(ItemHolding.x, ItemHolding.y, ItemHolding.layer, ObjFromItem(ItemHolding.object_index));
                    _Inst.Index = ItemHolding.Index;
                    _Inst.FloorLevel = ItemHolding.FloorLevel;
                    _Inst.From = ItemHolding.From;
                    
                    if (ItemHolding.object_index == oItem_Bombs)
                    {
                        if (ItemHolding.Red)
                            _Inst.Red = true;
                    }
                    
                    ItemHolding.Amount--;
                    
                    if (ItemHolding.Amount <= 0)
                        instance_destroy(ItemHolding);
                    
                    ItemHolding = _Inst;
                
                default:
                    ItemHolding.State = UnknownEnum.Value_1;
                    ItemHolding.DrawShadow = false;
                    
                    if (variable_instance_exists(ItemHolding, "Amount"))
                    {
                        if (ItemHolding.Amount > 1)
                            ItemHolding.Amount--;
                        else
                            instance_destroy(ItemHolding);
                    }
                    
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_7:
            audio_play_sound(Sound_Throw, 1, false);
            break;
        
        case UnknownEnum.Value_10:
            LinkThrow();
            break;
        
        case UnknownEnum.Value_3:
            LinkEnableFlashing();
            alarm[6] = HitSoundDelay;
            break;
        
        case UnknownEnum.Value_4:
            if (!instance_exists(oLinkDeath))
                instance_create_layer(0, 0, "System", oLinkDeath);
            
            break;
        
        case UnknownEnum.Value_22:
            DescendingPhase = 1;
            x = floor(x);
            y = floor(y);
            var snd = audio_play_sound(Sound_StairsFloorDown, 1, false);
            audio_sound_gain(snd, 0, 2000);
            var NextLevelSongIndex = global.Music_LevelSongIndex[global.Level.Index + 1];
            
            if (oMusic.SongPlaying_Index != NextLevelSongIndex)
                Music_Fade(0, 80, UnknownEnum.Value_0);
            
            if (audio_is_playing(global.RainSound))
                audio_sound_gain(global.RainSound, 0, 1000);
            
            with (oCape)
                instance_destroy(id);
            
            break;
        
        case UnknownEnum.Value_18:
            alarm[2] = 30;
            Invincible = false;
            audio_play_sound(Sound_Hurt, 1, false);
            audio_play_sound(Sound_Shock, 1, false);
            break;
        
        case UnknownEnum.Value_21:
            alarm[2] = -1;
            break;
        
        case UnknownEnum.Value_20:
            alarm[2] = -1;
            audio_play_sound(Sound_LinkFall, 1, false);
            break;
    }
}

function UpdateSprites()
{
    var _HoldingItem = ItemHolding != -4 && instance_exists(ItemHolding);
    image_speed = 1;
    
    switch (State)
    {
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_25:
        case UnknownEnum.Value_24:
        case UnknownEnum.Value_8:
        case UnknownEnum.Value_23:
        case UnknownEnum.Value_0:
            switch (Facing)
            {
                case 3:
                    sprite_index = global.LinkSpr_Stand_Left;
                    break;
                
                case 4:
                    sprite_index = global.LinkSpr_Stand_Right;
                    break;
                
                case 1:
                    sprite_index = global.LinkSpr_Stand_Up;
                    break;
                
                case 2:
                    sprite_index = global.LinkSpr_Stand_Down;
                    break;
            }
            
            image_index = _HoldingItem ? 1 : 0;
            break;
        
        case UnknownEnum.Value_2:
        case UnknownEnum.Value_5:
            switch (Facing)
            {
                case 3:
                    sprite_index = _HoldingItem ? global.LinkSpr_Carrying_Left : global.LinkSpr_Walk_Left;
                    break;
                
                case 4:
                    sprite_index = _HoldingItem ? global.LinkSpr_Carrying_Right : global.LinkSpr_Walk_Right;
                    break;
                
                case 1:
                    sprite_index = _HoldingItem ? global.LinkSpr_Carrying_Up : global.LinkSpr_Walk_Up;
                    break;
                
                case 2:
                    sprite_index = _HoldingItem ? global.LinkSpr_Carrying_Down : global.LinkSpr_Walk_Down;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_3:
        case UnknownEnum.Value_4:
            switch (Facing)
            {
                case 3:
                    sprite_index = global.LinkSpr_Hurt_Left;
                    break;
                
                case 4:
                    sprite_index = global.LinkSpr_Hurt_Right;
                    break;
                
                case 1:
                    sprite_index = global.LinkSpr_Hurt_Up;
                    break;
                
                case 2:
                    sprite_index = global.LinkSpr_Hurt_Down;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_11:
            switch (Facing)
            {
                case 3:
                    sprite_index = global.LinkSpr_Push_Left;
                    break;
                
                case 4:
                    sprite_index = global.LinkSpr_Push_Right;
                    break;
                
                case 1:
                    sprite_index = global.LinkSpr_Push_Up;
                    break;
                
                case 2:
                    sprite_index = global.LinkSpr_Push_Down;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_20:
            sprite_index = global.LinkSpr_Falling;
            break;
        
        case UnknownEnum.Value_12:
            switch (Facing)
            {
                case 3:
                    sprite_index = global.LinkSpr_Sword_Left;
                    break;
                
                case 4:
                    sprite_index = global.LinkSpr_Sword_Right;
                    break;
                
                case 1:
                    sprite_index = global.LinkSpr_Sword_Up;
                    break;
                
                case 2:
                    sprite_index = global.LinkSpr_Sword_Down;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_13:
            switch (Facing)
            {
                case 3:
                    sprite_index = global.LinkSpr_Bow_Left;
                    break;
                
                case 4:
                    sprite_index = global.LinkSpr_Bow_Right;
                    break;
                
                case 1:
                    sprite_index = global.LinkSpr_Bow_Up;
                    break;
                
                case 2:
                    sprite_index = global.LinkSpr_Bow_Down;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_14:
            switch (Facing)
            {
                case 3:
                    sprite_index = global.LinkSpr_Boomerang_Left;
                    break;
                
                case 4:
                    sprite_index = global.LinkSpr_Boomerang_Right;
                    break;
                
                case 1:
                    sprite_index = global.LinkSpr_Boomerang_Up;
                    break;
                
                case 2:
                    sprite_index = global.LinkSpr_Boomerang_Down;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_15:
            switch (Facing)
            {
                case 3:
                    sprite_index = global.LinkSpr_Hookshot_Left;
                    break;
                
                case 4:
                    sprite_index = global.LinkSpr_Hookshot_Right;
                    break;
                
                case 1:
                    sprite_index = global.LinkSpr_Hookshot_Up;
                    break;
                
                case 2:
                    sprite_index = global.LinkSpr_Hookshot_Down;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_16:
            switch (Facing)
            {
                case 3:
                    sprite_index = global.LinkSpr_Rod_Left;
                    break;
                
                case 4:
                    sprite_index = global.LinkSpr_Rod_Right;
                    break;
                
                case 1:
                    sprite_index = global.LinkSpr_Rod_Up;
                    break;
                
                case 2:
                    sprite_index = global.LinkSpr_Rod_Down;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_17:
            switch (Facing)
            {
                case 3:
                    sprite_index = global.LinkSpr_Powder_Left;
                    break;
                
                case 4:
                    sprite_index = global.LinkSpr_Powder_Right;
                    break;
                
                case 1:
                    sprite_index = global.LinkSpr_Powder_Up;
                    break;
                
                case 2:
                    sprite_index = global.LinkSpr_Powder_Down;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_6:
        case UnknownEnum.Value_7:
            switch (Facing)
            {
                case 3:
                    sprite_index = global.LinkSpr_PickUp_Left;
                    break;
                
                case 4:
                    sprite_index = global.LinkSpr_PickUp_Right;
                    break;
                
                case 1:
                    sprite_index = global.LinkSpr_PickUp_Up;
                    break;
                
                case 2:
                    sprite_index = global.LinkSpr_PickUp_Down;
                    break;
            }
            
            if (State == UnknownEnum.Value_7)
            {
                image_index = sprite_get_number(sprite_index) - 0.01;
                image_speed = -1.25;
            }
            
            break;
        
        case UnknownEnum.Value_10:
            switch (Facing)
            {
                case 3:
                    sprite_index = global.LinkSpr_Throwing_Left;
                    break;
                
                case 4:
                    sprite_index = global.LinkSpr_Throwing_Right;
                    break;
                
                case 1:
                    sprite_index = global.LinkSpr_Throwing_Up;
                    break;
                
                case 2:
                    sprite_index = global.LinkSpr_Throwing_Down;
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_9:
            sprite_index = global.LinkSpr_HoldingItem;
            break;
        
        case UnknownEnum.Value_22:
            if (DescendingLocation == 1)
                sprite_index = global.LinkSpr_Descending_Top1;
            else
                sprite_index = global.LinkSpr_Descending_Bottom1;
            
            break;
        
        case UnknownEnum.Value_18:
            sprite_index = global.LinkSpr_Shock;
            break;
        
        case UnknownEnum.Value_19:
            sprite_index = global.LinkSpr_Star;
            break;
    }
}

function Facing_Check()
{
    if (MoveAssistDir != 0 || BounceBack || Action[UnknownEnum.Value_9])
        exit;
    
    if (vx == 0)
    {
        if (vy < 0)
        {
            Facing = 1;
            exit;
        }
        
        if (vy > 0)
        {
            Facing = 2;
            exit;
        }
    }
    
    if (vy == 0)
    {
        if (vx < 0)
        {
            Facing = 3;
            exit;
        }
        
        if (vx > 0)
        {
            Facing = 4;
            exit;
        }
    }
    
    if (Facing == 3 && vx > 0)
    {
        if (vy > 0)
        {
            Facing = choose(4, 2);
            exit;
        }
        
        if (vy < 0)
        {
            Facing = choose(4, 1);
            exit;
        }
    }
    
    if (Facing == 4 && vx < 0)
    {
        if (vy > 0)
        {
            Facing = choose(3, 2);
            exit;
        }
        
        if (vy < 0)
        {
            Facing = choose(3, 1);
            exit;
        }
    }
    
    if (Facing == 1 && vy > 0)
    {
        if (vx > 0)
        {
            Facing = choose(3, 2);
            exit;
        }
        
        if (vx < 0)
        {
            Facing = choose(4, 2);
            exit;
        }
    }
    
    if (Facing == 2 && vy < 0)
    {
        if (vx > 0)
        {
            Facing = choose(3, 1);
            exit;
        }
        
        if (vx < 0)
        {
            Facing = choose(4, 1);
            exit;
        }
    }
}

function CheckMoveAssist()
{
    MoveAssistDir = 0;
    
    if (MoveAssist)
    {
        MoveAssist = false;
        var _WallList = ds_list_create();
        
        if (!keyLeft && !keyRight)
        {
            KeyState[0] = keyUp;
            KeyState[1] = keyDown;
            Position1[0] = bbox_top - 1;
            Position1[1] = bbox_bottom + 1;
            
            for (var i = 0; i <= 1; i++)
            {
                if (KeyState[i] && vy == 0)
                {
                    var WallInst = -4;
                    var _Walls = instance_position_list(x, Position1[i], oWall, _WallList, false);
                    
                    for (var _WallIndex = 0; _WallIndex < _Walls; _WallIndex++)
                    {
                        if (ds_list_find_value(_WallList, _WallIndex).FloorLevel == FloorLevel || ds_list_find_value(_WallList, _WallIndex).FloorLevel == 2)
                        {
                            WallInst = ds_list_find_value(_WallList, _WallIndex);
                            break;
                        }
                    }
                    
                    var WallCollide = false;
                    
                    if (WallInst != -4 && (WallInst.BlockLink || (WallInst.BlockLinkCarry && ItemHolding != -4)))
                        WallCollide = true;
                    
                    if (!WallCollide)
                    {
                        Position2[0] = bbox_left;
                        Position2[1] = bbox_right;
                        
                        for (var j = 0; j <= 1; j++)
                        {
                            ds_list_clear(_WallList);
                            WallInst = -4;
                            _Walls = instance_position_list(Position2[j], Position1[i], oWall, _WallList, false);
                            
                            for (var _WallIndex = 0; _WallIndex < _Walls; _WallIndex++)
                            {
                                if (ds_list_find_value(_WallList, _WallIndex).FloorLevel == FloorLevel || ds_list_find_value(_WallList, _WallIndex).FloorLevel == 2)
                                {
                                    WallInst = ds_list_find_value(_WallList, _WallIndex);
                                    break;
                                }
                            }
                            
                            WallCollide = false;
                            
                            if (WallInst != -4 && WallInst.BlockLink)
                                WallCollide = true;
                            
                            if (WallCollide)
                            {
                                MoveAssistDir = (j == 0) ? 4 : 3;
                                break;
                            }
                        }
                        
                        if (MoveAssistDir != 0)
                            break;
                    }
                }
            }
        }
        
        if (MoveAssistDir != 0)
        {
            ds_list_destroy(_WallList);
            exit;
        }
        
        if (!keyDown && !keyUp)
        {
            KeyState[0] = keyLeft;
            KeyState[1] = keyRight;
            Position1[0] = bbox_left - 1;
            Position1[1] = bbox_right + 1;
            
            for (var i = 0; i <= 1; i++)
            {
                if (KeyState[i] && vx == 0)
                {
                    ds_list_clear(_WallList);
                    var WallInst = -4;
                    var _Walls = instance_position_list(Position1[i], y - 6, oWall, _WallList, false);
                    
                    for (var _WallIndex = 0; _WallIndex < _Walls; _WallIndex++)
                    {
                        if (ds_list_find_value(_WallList, _WallIndex).FloorLevel == FloorLevel || ds_list_find_value(_WallList, _WallIndex).FloorLevel == 2)
                        {
                            WallInst = ds_list_find_value(_WallList, _WallIndex);
                            break;
                        }
                    }
                    
                    var WallCollide = false;
                    
                    if (WallInst != -4 && (WallInst.BlockLink || (WallInst.BlockLinkCarry && ItemHolding != -4)))
                        WallCollide = true;
                    
                    if (!WallCollide)
                    {
                        Position2[0] = bbox_bottom;
                        Position2[1] = bbox_top;
                        
                        for (var j = 0; j <= 1; j++)
                        {
                            ds_list_clear(_WallList);
                            WallInst = -4;
                            _Walls = instance_position_list(Position1[i], Position2[j], oWall, _WallList, false);
                            
                            for (var _WallIndex = 0; _WallIndex < _Walls; _WallIndex++)
                            {
                                if (ds_list_find_value(_WallList, _WallIndex).FloorLevel == FloorLevel || ds_list_find_value(_WallList, _WallIndex).FloorLevel == 2)
                                {
                                    WallInst = ds_list_find_value(_WallList, _WallIndex);
                                    break;
                                }
                            }
                            
                            WallCollide = false;
                            
                            if (WallInst != -4 && WallInst.BlockLink)
                                WallCollide = true;
                            
                            if (WallCollide)
                            {
                                MoveAssistDir = (j == 0) ? 1 : 2;
                                break;
                            }
                        }
                        
                        if (MoveAssistDir == 1 || MoveAssistDir == 2)
                            break;
                    }
                }
            }
        }
        
        ds_list_destroy(_WallList);
    }
}

function CheckRoomTransition()
{
    if (oCamera.RoomTransition == 0)
    {
        var DoorInst = instance_place(x, y, oDoor);
        
        if (DoorInst != -4)
        {
            if (House_Inside)
            {
                if (vy > 0 && y > (((global.CurrentRoom.y + global.CurrentRoom.height) - 30) + (FloorLevel * 24)))
                {
                    Link_SetAutoMove(0, 1, 0.4);
                    var NextRoomSongIndex = global.Level.Rooms[House_OldRoomIndex].RoomSongIndex;
                    
                    if (oMusic.SongPlaying_Index != NextRoomSongIndex)
                        Music_Fade(0, 70, NextRoomSongIndex);
                    else
                        Music_Fade(1, 70);
                    
                    House_Leaving = true;
                    oRender.FadeOut();
                }
            }
            else
            {
                AutoMoveSpeed = (FloorLevel == 1) ? 0.5 : 1.25;
                
                if (vx < 0 && x < ((global.CurrentRoom.x + 40) - (FloorLevel * 24)))
                {
                    oCamera.Cam_InitTransitionRoom(3);
                }
                else if (vx > 0 && x > (((global.CurrentRoom.x + global.CurrentRoom.width) - 40) + (FloorLevel * 24)))
                {
                    oCamera.Cam_InitTransitionRoom(4);
                }
                else if (vy < 0 && y < ((global.CurrentRoom.y + 52) - (FloorLevel * 24)))
                {
                    AutoMoveSpeed = (FloorLevel == 1) ? 0.55 : 1.32;
                    oCamera.Cam_InitTransitionRoom(1);
                }
                else if (vy > 0 && y > (((global.CurrentRoom.y + global.CurrentRoom.height) - 30) + (FloorLevel * 24)))
                {
                    oCamera.Cam_InitTransitionRoom(2);
                }
            }
        }
        else if (vx < 0 && x < (global.CurrentRoom.x + 16))
        {
            AutoMoveSpeed = 0.8;
            oCamera.Cam_InitTransitionRoom(3, true);
        }
        else if (vx > 0 && x > ((global.CurrentRoom.x + global.CurrentRoom.width) - 16))
        {
            AutoMoveSpeed = 0.8;
            oCamera.Cam_InitTransitionRoom(4, true);
        }
        else if (vy < 0 && y < (global.CurrentRoom.y + 28))
        {
            AutoMoveSpeed = 1.4;
            oCamera.Cam_InitTransitionRoom(1, true);
        }
        else if (vy > 0 && y > ((global.CurrentRoom.y + global.CurrentRoom.height) - 28))
        {
            AutoMoveSpeed = 1.4;
            oCamera.Cam_InitTransitionRoom(2, true);
        }
    }
    
    if (oCamera.RoomTransition != 0)
    {
        if (!oCamera.OpenTransition)
        {
            if (LastDoorID.LinkedDoor.Status == UnknownEnum.Value_1)
            {
                GoingThruClosedDoor = true;
                GoingThruClosedDoorID = LastDoorID.LinkedDoor;
                LastDoorID.LinkedDoor.Status = UnknownEnum.Value_0;
                LastDoorID.LinkedDoor.UpdateStatus = true;
                LastDoorID.LinkedDoor.WallInst.BlockLink = true;
                LastDoorID.LinkedDoor.WallInst.BlockProjectiles = true;
            }
            
            if (LastDoorID.LinkedDoor.CurtainInst != -4)
                LastDoorID.LinkedDoor.CurtainInst.Revealed = true;
        }
    }
}

function CheckDoors()
{
    var DoorInst = instance_place(x + vx, y + vy, oDoor);
    
    if (!oCamera.RoomTransition)
        InDoorPassage = 0;
    
    if (DoorInst != -4)
    {
        LastDoorID = DoorInst;
        
        if (DoorInst.Status == UnknownEnum.Value_2)
        {
            if (global.Level.Index == UnknownEnum.Value_6 && oCamera.DungeonGridX == 3 && oCamera.DungeonGridY == 2)
            {
                if (Inventory_ItemClassExists(UnknownEnum.Value_22) != -1)
                    UnlockDoor(DoorInst, UnknownEnum.Value_22);
            }
            else if (global.Inventory_ItemData[UnknownEnum.Value_21].Owns[0])
            {
                UnlockDoor(DoorInst, UnknownEnum.Value_21);
            }
            else if (global.Inventory_ItemData[UnknownEnum.Value_20].Amount > 0)
            {
                UnlockDoor(DoorInst);
            }
        }
        
        if (DoorInst.Status == UnknownEnum.Value_4)
        {
            if (DoorInst.Location == "Top" && y < (DoorInst.y + 24))
            {
                DescendingLocation = 1;
                UpdateState(UnknownEnum.Value_22);
                return 1;
            }
            else if (DoorInst.Location == "Bottom" && y > (DoorInst.y + 4))
            {
                DescendingLocation = 2;
                UpdateState(UnknownEnum.Value_22);
                return 1;
            }
        }
        
        DoorPassage = DoorInst.PassageArea;
        InDoorPassage = rectangle_in_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, DoorPassage[0], DoorPassage[1], DoorPassage[2], DoorPassage[3]);
        
        switch (DoorInst.Location)
        {
            case "Top":
            case "Bottom":
                PassageOrientation = 0;
                break;
            
            case "Left":
            case "Right":
                PassageOrientation = 1;
                break;
        }
    }
    
    var HouseDoorInst = instance_place(x, y + 6, oHouseDoor);
    
    if (HouseDoorInst != -4)
    {
        if (State != UnknownEnum.Value_5 && vy < 0 && !InDoor_BlockItem && (ItemHolding == -4 || !instance_exists(ItemHolding)))
        {
            House_DoorInst = HouseDoorInst;
            DoorPassage = House_DoorInst.PassageArea;
            InDoorPassage = rectangle_in_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, DoorPassage[0], DoorPassage[1], DoorPassage[2], DoorPassage[3]);
            
            if (House_DoorInst.image_index != 2)
            {
                House_DoorInst.image_index = 2;
                audio_play_sound(Sound_DoorOpen, 1, false);
            }
            
            Link_SetAutoMove(0, -1, 0.4);
            House_RoomIndex = House_DoorInst.House_RoomIndex;
            House_OldRoomIndex = global.CurrentRoomIndex;
            House_X = House_DoorInst.House_X;
            House_Y = House_DoorInst.House_Y;
            House_Entering = true;
            var NextRoomSongIndex = global.Level.Rooms[House_RoomIndex].RoomSongIndex;
            
            if (oMusic.SongPlaying_Index != NextRoomSongIndex)
                Music_Fade(0, 70, NextRoomSongIndex);
            else
                Music_Fade(0.25, 70);
            
            oRender.FadeOut();
        }
    }
    
    var KeyBlockInst = instance_place(x + vx, y + vy, oKeyBlock);
    
    if (KeyBlockInst != -4)
    {
        if (global.Inventory_ItemData[UnknownEnum.Value_20].Amount > 0 || global.Inventory_ItemData[UnknownEnum.Value_21].Owns[0])
        {
            if (!KeyBlockInst.Unlocked)
            {
                if (!global.Inventory_ItemData[UnknownEnum.Value_21].Owns[0])
                    Item_Consume(UnknownEnum.Value_20, 0, -1);
                
                KeyBlockInst.alarm[0] = 6;
                audio_play_sound(Sound_DoorUnlock, 1, false);
                KeyBlockInst.Unlocked = true;
            }
        }
    }
    
    if (!Castle_Entering)
    {
        var CastleWallDoorInst = instance_place(x, y + 6, oCastleWallDoor);
        
        if (CastleWallDoorInst != -4)
        {
            DoorPassage = CastleWallDoorInst.PassageArea;
            InDoorPassage = rectangle_in_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, DoorPassage[0], DoorPassage[1], DoorPassage[2], DoorPassage[3]);
            
            if (y <= (CastleWallDoorInst.y + 4))
            {
                Castle_Entering = true;
                
                if (!global.Swordless)
                {
                    if (Inventory_ItemClassExists(UnknownEnum.Value_44) == -1)
                    {
                        MsgBox("Swordless quest enabled! No swords will be generated during the game. Good Luck!");
                        global.Swordless = true;
                        exit;
                    }
                }
            }
        }
    }
}

function UnlockDoor(arg0, arg1 = UnknownEnum.Value_20)
{
    arg0.Unlock = true;
    Item_Consume(arg1, 0, -1);
    audio_play_sound(Sound_DoorUnlock, 1, false);
}

function CheckStairs()
{
    var _OnStairs = 0;
    
    if (vy != 0)
        _OnStairs = OnStairs(x, y);
    
    if (StairsAutoMove)
    {
        var LampDimInc = (1 - LampDimMin) / 55;
        
        switch (StairsFloorLevelDir)
        {
            case 1:
                LampDim += LampDimInc;
                
                if (LampDim > 1)
                    LampDim = 1;
                
                break;
            
            case 0:
                LampDim -= LampDimInc;
                
                if (LampDim < LampDimMin)
                    LampDim = LampDimMin;
                
                break;
        }
        
        if (_OnStairs == 0)
        {
            StairsAutoMove = false;
            AutoMoveDirX = 0;
            AutoMoveDirY = sign(vy);
            AutoMoveSpeed = WalkSpeed;
            
            if (vy > 0)
                AutoMoveFrames = 9;
            
            if (vy < 0)
                AutoMoveFrames = 2;
            
            if (vy == 0)
                AutoMoveFrames = 6;
            
            UpdateState(UnknownEnum.Value_5);
            
            if (FloorLevel == 1 && tilemap_get_at_pixel(global.TMID_Floor_Upper, x, y) == 0)
                FloorLevel = 0;
            
            FloorLevelStr = GetFloorLevelString(FloorLevel);
            audio_stop_sound(Sound_StairsDown);
            audio_stop_sound(Sound_StairsFloorDown);
            audio_stop_sound(Sound_StairsUp);
            
            if (global.StairPause)
                global.Paused = false;
        }
    }
    else if (_OnStairs != 0)
    {
        Link_SetAutoMove(0, sign(vy), StairSpeed);
        StairsAutoMove = true;
        MoveAssist = false;
        
        if (FloorLevel == 0)
            FloorLevel = 1;
        
        if ((_OnStairs == 1 && Facing == 1) || (_OnStairs == 2 && Facing == 2))
        {
            StairsFloorLevelDir = 1;
            audio_play_sound(Sound_StairsUp, 1, false);
        }
        else if ((_OnStairs == 1 && Facing == 2) || (_OnStairs == 2 && Facing == 1))
        {
            StairsFloorLevelDir = 0;
            audio_play_sound(Sound_StairsDown, 1, false);
        }
        
        if (global.StairPause)
            global.Paused = true;
    }
}

function Link_SetAutoMove(arg0, arg1, arg2, arg3 = -1)
{
    AutoMoveDirX = arg0;
    AutoMoveDirY = arg1;
    AutoMoveSpeed = arg2;
    AutoMoveFrames = arg3;
    
    if (AutoMoveDirX < 0)
        Facing = 3;
    
    if (AutoMoveDirX > 0)
        Facing = 4;
    
    if (AutoMoveDirY < 0)
        Facing = 1;
    
    if (AutoMoveDirY > 0)
        Facing = 2;
    
    UpdateState(UnknownEnum.Value_5);
}

function CheckMovingFloor()
{
    if (State == UnknownEnum.Value_5 || State == UnknownEnum.Value_15 || MoveAssistDir != 0)
        exit;
    
    var MovingFloorInst = instance_position(x, y, oMovingFloor);
    
    if (MovingFloorInst != -4)
    {
        vx += (MovingFloorInst.DirX * 0.5);
        vy += (MovingFloorInst.DirY * 0.5);
    }
}

function CheckHoles()
{
    if (RoomIndex == -1)
        return false;
    
    var _TileUpper = tilemap_get_at_pixel(global.TMID_Floor_Upper, x, y);
    var _TileLower = tilemap_get_at_pixel(global.TMID_Floor_Lower, x, y);
    
    if (_TileUpper == 0 && _TileLower == 0)
    {
        if (House_Leaving)
            return false;
        
        if (FloorLevel == 1 && position_meeting(x, y, oDrawBridgeArea))
            return false;
        
        UpdateState(UnknownEnum.Value_20);
        return true;
    }
    
    var HoleEdgeID = (FloorLevel == 1) ? _TileUpper : _TileLower;
    var FallDir;
    
    switch (HoleEdgeID)
    {
        case global.HoleTileID_TL:
        case global.HoleTileID_ITL:
            FallDir = 315;
            var FallPointX = 8;
            var FallPointY = 8;
            break;
        
        case global.HoleTileID_TM:
            FallDir = 270;
            var FallPointX = 0;
            var FallPointY = 8;
            break;
        
        case global.HoleTileID_TR:
        case global.HoleTileID_ITR:
            FallDir = 225;
            var FallPointX = -8;
            var FallPointY = 8;
            break;
        
        case global.HoleTileID_ML:
            FallDir = 0;
            var FallPointX = 8;
            var FallPointY = 0;
            break;
        
        case global.HoleTileID_MR:
            FallDir = 180;
            var FallPointX = -8;
            var FallPointY = 0;
            break;
        
        case global.HoleTileID_BL:
        case global.HoleTileID_IBL:
            FallDir = 45;
            var FallPointX = 8;
            var FallPointY = -8;
            break;
        
        case global.HoleTileID_BM:
            FallDir = 90;
            var FallPointX = 0;
            var FallPointY = -8;
            break;
        
        case global.HoleTileID_BR:
        case global.HoleTileID_IBR:
            FallDir = 135;
            var FallPointX = -8;
            var FallPointY = -8;
            break;
        
        default:
            return false;
    }
    
    LinkThrow();
    UpdateState(UnknownEnum.Value_21);
    var LenDirX = lengthdir_x(8, FallDir);
    var LenDirY = lengthdir_y(8, FallDir);
    var time = 10;
    vx = LenDirX / time;
    vy = LenDirY / time;
    FallOverEdgeDelay = time;
    return true;
}

function Interact()
{
    if (State == UnknownEnum.Value_19 || State == UnknownEnum.Value_3)
        exit;
    
    if (global.SaveLevel)
    {
        if (oLink.Facing == 4)
        {
            var SaveTentInst = instance_position(bbox_right, y, oSaveTent);
            
            if (SaveTentInst != -4)
            {
                MsgBox("Take a break? Save and quit?", true);
                SaveTentInst.DB_Started = true;
            }
        }
    }
    
    var _HoldingItem = ItemHolding != -4 && instance_exists(ItemHolding);
    
    if (_HoldingItem && !InDoor_Facing && InDoor_Aligned)
    {
        UpdateState(UnknownEnum.Value_10);
        exit;
    }
    
    var TreasureInst = instance_position(x, bbox_top - 3, oItem_Treasure);
    
    if (TreasureInst != -4 && Facing == 1 && TreasureInst.visible && TreasureInst.sprite_index != sItem_TreasureBlock && TreasureInst.image_index == 0)
    {
        UpdateState(UnknownEnum.Value_8);
        Treasure_Open(TreasureInst);
        exit;
    }
    
    TreasureInst = instance_position(x, bbox_top - 3, oTreasureLarge);
    
    if (TreasureInst != -4 && Facing == 1 && TreasureInst.visible)
    {
        UpdateState(UnknownEnum.Value_8);
        TreasureLarge_Open(TreasureInst);
        exit;
    }
    
    if (oLink.Facing == 1 && !_HoldingItem)
    {
        var WallInst = instance_place(x, y - 6, oShopWall);
        
        if (WallInst != -4)
        {
            if (WallInst.FloorLevel == oLink.FloorLevel)
            {
                var ShopInst = WallInst.ShopInst;
                
                if (ShopInst != -4)
                {
                    ds_list_clear(CollidedShopItemList);
                    var _ShopItems = collision_rectangle_list(x - 4, y - 30, x + 4, y - 16, oItem, false, true, CollidedShopItemList, false);
                    
                    for (var i = 0; i < _ShopItems; i++)
                    {
                        ShopItemLook = ds_list_find_value(CollidedShopItemList, i);
                        
                        if (ShopItemLook != -4)
                        {
                            if (ShopItemLook.ShopItem && FromAnyStore(ShopItemLook.From))
                            {
                                UpdateState(UnknownEnum.Value_1);
                                ShopInst.DB_Init = true;
                                exit;
                            }
                        }
                    }
                }
            }
        }
    }
    
    if (Facing == 2)
    {
        var KinstoneInst = instance_position(x, bbox_bottom - 9, oItem_Kinstone_Main);
        
        if (KinstoneInst != -4)
        {
            if (KinstoneInst.State == UnknownEnum.Value_0)
            {
                KinstoneInst.DB_Init = true;
                exit;
            }
        }
    }
    
    if (Facing == 1)
    {
        var SignInst = instance_position(x, bbox_top - 3, oSign);
        
        if (SignInst != -4)
        {
            if (SignInst.Active)
            {
                SignInst.DB_Init = true;
                exit;
            }
        }
    }
    
    var CanPickupInst = -4;
    
    if (InventoryFullInst != -4)
    {
        if (InventoryFullInst.CanConsume)
        {
            var _ItemInst = InventoryFullInst.ItemInst;
            Item_Consume(_ItemInst.Class, _ItemInst.Index);
            
            if (_ItemInst.Class == UnknownEnum.Value_36 && _ItemInst.Index == UnknownEnum.Value_3)
                _ItemInst.Get_Sound = -4;
            
            if (_ItemInst.Get_Sound != -4)
                audio_play_sound(_ItemInst.Get_Sound, 1, false);
            
            _ItemInst.Amount--;
            
            if (_ItemInst.Amount <= 0)
            {
                instance_destroy(_ItemInst);
                instance_destroy(InventoryFullInst);
                InventoryFullInst = -4;
            }
            
            exit;
        }
        
        if (InventoryFullInst.CanPickup)
        {
            CanPickupInst = CheckPickupItem(InventoryFullInst.ItemInst);
            
            if (CanPickupInst != -4)
                exit;
        }
    }
    
    if (CanPickupInst == -4)
    {
        if (CheckPickupItem(oItem_Orb) != -4)
            exit;
        
        if (CheckPickupItem(oItem_Bombs) != -4)
            exit;
        
        if (CheckPickupItem(oItem_Gem) != -4)
            exit;
        
        if (CheckPickupItem(oItem_WishStone) != -4)
            exit;
    }
    
    var Inst;
    
    switch (Facing)
    {
        case 3:
            Inst = instance_place(bbox_left, y, oPickupObj);
            break;
        
        case 4:
            Inst = instance_place(bbox_right, y, oPickupObj);
            break;
        
        case 1:
            Inst = instance_place(x, bbox_top + 9, oPickupObj);
            break;
        
        case 2:
            Inst = instance_place(x, bbox_bottom + 2, oPickupObj);
            break;
    }
    
    if (Inst != -4)
    {
        var _Pickup = true;
        
        switch (Inst.object_index)
        {
            case oOrb:
            case oGem:
            case oWishStone:
                _Pickup = false;
                break;
            
            default:
                if (Inst.Hidden || Inst.State == UnknownEnum.Value_5)
                    _Pickup = false;
                
                if (Inst.State == UnknownEnum.Value_4 && Inst.z > 2 && Inst.Bounces > 1)
                    _Pickup = false;
                
                break;
        }
        
        if (_Pickup)
        {
            UpdateState(UnknownEnum.Value_6, Inst);
            
            if (Inst.object_index == oBomb)
            {
                if (global.Level.Index != UnknownEnum.Value_13 && !Inst.Red)
                    Inst.alarm[0] = -1;
            }
            
            exit;
        }
    }
    
    if (!instance_exists(oLampFlame))
    {
        Inst = -4;
        
        switch (Facing)
        {
            case 3:
                Inst = instance_place(bbox_left, y, oTorch);
                break;
            
            case 4:
                Inst = instance_place(bbox_right, y, oTorch);
                break;
            
            case 1:
                Inst = instance_place(x, bbox_top + 9, oTorch);
                break;
            
            case 2:
                Inst = instance_place(x, bbox_bottom + 2, oTorch);
                break;
        }
        
        if (Inst != -4)
        {
            if (!Inst.Lit)
            {
                Inst.Lighting = true;
                exit;
            }
        }
        
        Inst = -4;
        
        switch (Facing)
        {
            case 3:
                Inst = instance_place(bbox_left, y, oCurtain);
                break;
            
            case 4:
                Inst = instance_place(bbox_right, y, oCurtain);
                break;
            
            case 1:
                Inst = instance_place(x, bbox_top + 9, oCurtain);
                break;
            
            case 2:
                Inst = instance_place(x, bbox_bottom + 2, oCurtain);
                break;
        }
        
        if (Inst != -4)
        {
            if (!Inst.Revealed && Inst.FloorLevel == FloorLevel && Door_LocationToDir(Inst.Location) == Facing)
            {
                Curtain_Reveal(Inst);
                
                with (Inst)
                    instance_create_layer(ObjCenterX(), ObjCenterY(), "ObjsHigher_Upper", oLampFlame);
                
                exit;
            }
        }
    }
    
    var DeadGuyInst;
    
    switch (Facing)
    {
        case 3:
            DeadGuyInst = instance_position(bbox_left - 5, y - 6, oDeadHungryGuy);
            break;
        
        case 4:
            DeadGuyInst = instance_position(bbox_right + 5, y - 6, oDeadHungryGuy);
            break;
        
        case 1:
            DeadGuyInst = instance_position(x, bbox_top - 3, oDeadHungryGuy);
            break;
        
        case 2:
            DeadGuyInst = instance_position(x, bbox_bottom + 3, oDeadHungryGuy);
            break;
    }
    
    if (DeadGuyInst != -4)
    {
        DeadGuyInst.DB_Init = true;
        exit;
    }
    
    var HeartGuyInst;
    
    switch (Facing)
    {
        case 3:
            HeartGuyInst = instance_position(bbox_left - 5, y - 6, oHeartGuy);
            break;
        
        case 4:
            HeartGuyInst = instance_position(bbox_right + 5, y - 6, oHeartGuy);
            break;
        
        case 1:
            HeartGuyInst = instance_position(x, bbox_top - 3, oHeartGuy);
            break;
        
        case 2:
            HeartGuyInst = instance_position(x, bbox_bottom + 3, oHeartGuy);
            break;
    }
    
    if (HeartGuyInst != -4)
    {
        HeartGuyInst.DB_Init = true;
        exit;
    }
    
    var NPCInst;
    
    switch (Facing)
    {
        case 3:
            NPCInst = instance_position(bbox_left - 5, y - 6, oNPC);
            break;
        
        case 4:
            NPCInst = instance_position(bbox_right + 5, y - 6, oNPC);
            break;
        
        case 1:
            NPCInst = instance_position(x, bbox_top - 5, oNPC);
            break;
        
        case 2:
            NPCInst = instance_position(x, bbox_bottom + 5, oNPC);
            break;
    }
    
    if (NPCInst != -4)
    {
        NPCInst.DB_Init = true;
        exit;
    }
    
    if (global.Level.Index == UnknownEnum.Value_6)
    {
        if (Facing == 3)
        {
            var OldLadyInst = instance_position(bbox_left - 9, y - 6, oNPC_OldLady);
            
            if (OldLadyInst != -4)
            {
                if (OldLadyInst.State == UnknownEnum.Value_0)
                {
                    OldLadyInst.Wake_Init = true;
                    global.Paused = true;
                    UpdateState(UnknownEnum.Value_0);
                    exit;
                }
            }
        }
        
        switch (Facing)
        {
            case 3:
                Inst = instance_place(bbox_left, y, oEnemy_Chicken);
                break;
            
            case 4:
                Inst = instance_place(bbox_right, y, oEnemy_Chicken);
                break;
            
            case 1:
                Inst = instance_place(x, bbox_top - 5, oEnemy_Chicken);
                break;
            
            case 2:
                Inst = instance_place(x, bbox_bottom + 2, oEnemy_Chicken);
                break;
        }
        
        if (Inst != -4)
        {
            if (Inst.State != UnknownEnum.Value_16 && Inst.State != UnknownEnum.Value_17 && Inst.State != UnknownEnum.Value_15 && !oLink.InDoor && !oLink.InDoor_House)
            {
                UpdateState(UnknownEnum.Value_6, Inst);
                exit;
            }
        }
        
        if (global.Level.Rooms[global.CurrentRoomIndex].TemplateName == "Arcade")
        {
            if (oLink.Facing == 1)
            {
                var PopMachineInst = instance_position(x, bbox_top + 6, oPopMachine);
                
                if (PopMachineInst != -4)
                {
                    PopMachineInst.DB_Init = true;
                    exit;
                }
            }
        }
        
        if (Facing == 1)
        {
            Inst = instance_place(x, bbox_top - 5, oSimonFrogs);
            
            if (Inst != -4)
            {
                if (!Inst.PlayNote)
                {
                    Inst.Index = floor((x - Inst.x) / 18);
                    Inst.PlayNoteInit = true;
                }
            }
        }
    }
    
    if (global.Level.Index == UnknownEnum.Value_3)
    {
        if (Facing == 1)
        {
            var PrisonerInst = collision_rectangle(x - 20, y - 48, x + 20, y, oPrisoner, false, true);
            
            if (PrisonerInst != -4)
            {
                PrisonerInst.DB_Init = true;
                exit;
            }
        }
    }
}

function CheckPickupItem(arg0, arg1 = -4)
{
    if (arg1 == -4)
    {
        switch (Facing)
        {
            case 3:
                arg1 = instance_place(bbox_left, y, arg0);
                break;
            
            case 4:
                arg1 = instance_place(bbox_right, y, arg0);
                break;
            
            case 1:
                arg1 = instance_place(x, bbox_top + 9, arg0);
                break;
            
            case 2:
                arg1 = instance_place(x, bbox_bottom + 2, arg0);
                break;
        }
    }
    
    if (arg1 != -4)
    {
        if (!arg1.ShopItem)
            UpdateState(UnknownEnum.Value_6, arg1);
    }
    
    return arg1;
}

function CheckGravityBall()
{
    var _GravityBall = false;
    
    with (oAghanim_GravityBall)
    {
        var _Dir = point_direction(x, y, oLink.x, oLink.y);
        oLink.vx += lengthdir_x(1.75, _Dir);
        oLink.vy += lengthdir_y(1.75, _Dir);
        _GravityBall = true;
    }
    
    return _GravityBall;
}

function LinkThrow()
{
    if (ItemHolding == -4 || !instance_exists(ItemHolding))
    {
        ItemHolding = -4;
        exit;
    }
    
    switch (ItemHolding.object_index)
    {
        case oEnemy_Chicken:
            with (ItemHolding)
                Enemy_UpdateState(UnknownEnum.Value_5);
            
            break;
        
        case oBomb:
            if (InDoor)
            {
                ItemHolding.CheckWallCollide = false;
                ItemHolding.alarm[2] = 20;
            }
        
        default:
            ItemHolding.State = UnknownEnum.Value_3;
            break;
    }
    
    ItemHolding = -4;
}

function LinkBounceBack(arg0, arg1, arg2, arg3 = true)
{
    BounceBack = true;
    alarm[2] = arg2;
    
    if (arg3)
        audio_play_sound_stopall(Sound_Bounce);
    
    with (oWall)
    {
        if (IsStairs)
        {
            if (place_meeting(x, y, oLink))
                exit;
            
            BlockLink = true;
        }
    }
    
    if (InDoorPassage == 0)
    {
        vx = lengthdir_x(arg1, arg0);
        vy = lengthdir_y(arg1, arg0);
    }
}

function CheckEnemies()
{
    HitBox.x = x + vx;
    HitBox.y = y + vy;
    
    if (Cape)
        exit;
    
    var Inst = -4;
    
    with (HitBox)
        Inst = instance_place(x, y, oEnemy);
    
    if (Inst != -4)
    {
        if (EnemyCanHurtLink(Inst))
        {
            switch (Inst.object_index)
            {
                case oEnemy_RollingSpike:
                    LinkHit(point_direction(Inst.x, Inst.y, Inst.x + Inst.vx, Inst.y + Inst.vy), 1.75, 12, Inst.Attack);
                    break;
                
                case oEnemy_Bubble:
                    LinkHit(point_direction(Inst.x, Inst.y, x, y), 1.25, 12, Inst.Attack, 8);
                    break;
                
                case oEnemy_MovingSpikeBlock:
                    LinkHit(point_direction(Inst.x, Inst.y, x, y), 2, 12, Inst.Attack);
                    break;
                
                case oBoss_Aghanim:
                    LinkHit(point_direction(Inst.x, Inst.y, x, y), 3.5, 12, Inst.Attack);
                    break;
                
                case oEnemy_Guru:
                    LinkHit(point_direction(Inst.x, Inst.y, x, y), 1.5, 12, Inst.Attack, 4 * Inst.Type * 2);
                    break;
                
                default:
                    if (Inst.object_index == oEnemy_Bari && Inst.CanShock)
                        ShockLink(Inst);
                    else
                        LinkHit(point_direction(Inst.x, Inst.y, x, y), 1.25, 12, Inst.Attack);
                    
                    break;
            }
            
            exit;
        }
    }
    
    with (HitBox)
        Inst = instance_place(x, y, oSoldierWeapon);
    
    if (Inst != -4)
    {
        if (Inst.FloorLevel == FloorLevel && (Inst.CanHurtLinkWhenSoldierHurt || EnemyCanHurtLink(Inst.SoldierInst)))
        {
            var _Dir;
            
            switch (Inst.object_index)
            {
                default:
                    _Dir = point_direction(Inst.x, Inst.y, x, y);
                    break;
                
                case oSoldierWeapon_Mace:
                    _Dir = AngleCheck(Inst.SpinAngle + 90);
                    break;
            }
            
            LinkHit(_Dir, 1.25, 12, Inst.SoldierInst.Attack);
            exit;
        }
    }
    
    Inst = instance_place(x, y, oProjectile);
    
    if (Inst != -4)
    {
        if (Inst.Enemy && Inst.FloorLevel == FloorLevel)
        {
            var _ShieldHit = Shield_Hit(Inst, Inst.x, Inst.y);
            
            if (_ShieldHit)
            {
                switch (Inst.object_index)
                {
                    default:
                        instance_create_layer(Inst.x, Inst.y, "ObjsHigher_" + GetFloorLevelString(FloorLevel), oWallHit, 
                        {
                            PlaySound: false
                        });
                        audio_play_sound(Sound_Shield, 1, false);
                        break;
                    
                    case oBone:
                        break;
                }
            }
            else
            {
                LinkHit(point_direction(Inst.x, Inst.y, x, y), Inst.HitV, Inst.HitTime, Inst.Damage);
            }
            
            with (Inst)
            {
                if (LinkTouchDestroy)
                {
                    switch (object_index)
                    {
                        default:
                            instance_destroy(id);
                            break;
                        
                        case oBone:
                            Destroyed = true;
                            break;
                    }
                }
            }
        }
    }
}

function ShockLink(arg0, arg1 = false)
{
    with (oLink)
    {
        if (State == UnknownEnum.Value_18 || Invincible)
            exit;
        
        UpdateState(UnknownEnum.Value_18);
        ShockEnemyInst = arg0.id;
        ShockDrawSword = arg1;
    }
    
    Mosaic(UnknownEnum.Value_1);
}

function EnemyCanHurtLink(arg0)
{
    return !global.Paused && arg0.CanHurtLink && (arg0.FloorLevel == FloorLevel || arg0.FloorLevel == 2) && arg0.State != UnknownEnum.Value_10 && arg0.State != UnknownEnum.Value_11 && arg0.State != UnknownEnum.Value_0 && arg0.State != UnknownEnum.Value_1 && arg0.State != UnknownEnum.Value_8 && arg0.State != UnknownEnum.Value_13 && arg0.State != UnknownEnum.Value_15 && arg0.State != UnknownEnum.Value_16 && arg0.State != UnknownEnum.Value_17;
}

function LinkHit(arg0, arg1, arg2, arg3, arg4 = 0)
{
    if (State == UnknownEnum.Value_3 || State == UnknownEnum.Value_22 || State == UnknownEnum.Value_5 || State == UnknownEnum.Value_21 || State == UnknownEnum.Value_20 || Invincible || (Cape && State != UnknownEnum.Value_18))
        exit;
    
    var _Damage = Enemy_Attack(arg3);
    HealthAdd(-_Damage);
    
    if (global.Inventory_ItemData[UnknownEnum.Value_17].Amount <= 0)
        exit;
    
    if (arg4 > 0 && global.Inventory_ItemData[UnknownEnum.Value_26].Amount > 0)
    {
        MagicUse(arg4);
        audio_play_sound(Sound_MagicMeter, 1, false);
    }
    
    LinkThrow();
    UpdateState(UnknownEnum.Value_3);
    LinkBounceBack(arg0, arg1, arg2, false);
}

function LinkEnableFlashing()
{
    Invincible = true;
    HitFlashingStatus = true;
    alarm[4] = HitFlashingLength;
    alarm[5] = HitFlashingDelay;
}

function CheckSpikes()
{
    if (Invincible || Cape)
        exit;
    
    var SpikeBlockInst = instance_place(x + vx, y + vy, oSpikeBlock);
    
    if (SpikeBlockInst != -4)
    {
        LinkHit(point_direction(SpikeBlockInst.x + 8, SpikeBlockInst.y + 8, x, y), CarryingSpeed, 12, SpikeBlockInst.Damage);
        exit;
    }
    
    if (Pendant_Check(UnknownEnum.Value_2))
        exit;
    
    if (OnSpikeTile(GetFloorLevelTMID("Tiles_Floor", x, y), x, y))
        LinkHit(0, 0, 1, 1.5);
}

function CheckItems()
{
    if (instance_exists(oInventory))
        exit;
    
    var _InventoryFull = false;
    ObjCollision_List(CollidedObjList, x, y, oItem, FloorLevel);
    var _PickedWithSword = false;
    
    if (ds_list_size(CollidedObjList) == 0 && instance_exists(oSword))
    {
        with (oSword)
        {
            var img_index = floor(oLink.image_index);
            
            if (img_index >= 2 && img_index <= 9)
                ObjCollision_List(other.CollidedObjList, x, y, oItem, other.FloorLevel);
        }
        
        _PickedWithSword = ds_list_size(CollidedObjList) > 0;
    }
    
    var _PlayingGetSound = false;
    
    for (var i = 0; i < ds_list_size(CollidedObjList); i++)
    {
        if (global.DB_Inst != -4)
            break;
        
        var ItemInst = ds_list_find_value(CollidedObjList, i);
        StandingOnMap = ItemInst.Class == UnknownEnum.Value_28;
        StandingOnCompass = ItemInst.Class == UnknownEnum.Value_10;
        
        if ((!ItemInst.Spawning || ItemInst.Get_Allowed) && !ItemInst.ShopItem && ItemInst.Get_WhenLinkCollides)
        {
            switch (ItemInst.object_index)
            {
                case oItem_Star:
                    if (_PickedWithSword)
                        break;
                
                default:
                    var _Amount = (global.ItemData[ItemInst.Class].Type == UnknownEnum.Value_4) ? ItemInst.Amount : max(ItemInst.Amount, 1);
                    var _GetDialogue = ItemInst.Get_ShowDialogue && Item_GetDialogueClass(ItemInst.Class) && ItemInst.From != UnknownEnum.Value_19 && State != UnknownEnum.Value_19;
                    var ItemGot = Item_Get(ItemInst.Class, ItemInst.Index, _Amount);
                    
                    if (ItemGot)
                    {
                        if (_GetDialogue)
                            Item_GetDialogue(ItemInst.Class, ItemInst.Index, ItemInst.Amount);
                        
                        Curse_GetItemUncurseMsg(ItemInst.Class, ItemInst.Index);
                        
                        if (ItemInst.Get_Sound != -4 && !_PlayingGetSound && !audio_is_playing(Sound_Antidote))
                        {
                            audio_play_sound(ItemInst.Get_Sound, 1, false);
                            _PlayingGetSound = true;
                        }
                        
                        instance_destroy(ItemInst);
                    }
                    else
                    {
                        if (_PickedWithSword)
                        {
                            switch (ItemInst.Class)
                            {
                                case UnknownEnum.Value_28:
                                    StandingOnMap = false;
                                    break;
                                
                                case UnknownEnum.Value_10:
                                    StandingOnCompass = false;
                                    break;
                            }
                            
                            break;
                        }
                        
                        _InventoryFull = true;
                        
                        if (InventoryFullInst == -4)
                            InventoryFullInst = instance_create_layer(0, 0, "System", oInventoryFull);
                        
                        switch (ItemInst.Class)
                        {
                            case UnknownEnum.Value_5:
                            case UnknownEnum.Value_1:
                                var _ItemAmount = global.Inventory_ItemData[ItemInst.Class].Amount[0];
                                var _MaxAmount = Inventory_MaxAmount(ItemInst.Class);
                                InventoryFullInst.MaxedOut = _ItemAmount >= _MaxAmount;
                                break;
                        }
                        
                        InventoryFullInst.ItemInst = ItemInst;
                    }
                    
                    break;
                
                case oItem_Crystal:
                    ItemInst.SpawnAnimation = false;
                    ItemInst.SpawnAnimationFinish = true;
                    
                    if (instance_exists(ItemHolding))
                    {
                        var _DropPos = Item_DropPos();
                        var _Class = ItemClassFromObjIndex(ItemFromObj(ItemHolding.object_index));
                        var _DroppedItemInst = ItemDrop(_DropPos[0], _DropPos[1], _Class, ItemHolding.Index, 1, UnknownEnum.Value_19);
                        instance_destroy(ItemHolding);
                        ItemHolding = -4;
                    }
                    
                    with (oCape)
                        instance_destroy(id);
                    
                    Music_Stop();
                    audio_play_sound(Music_Boss_Defeated, 1, false);
                    HoldUpItem(ItemInst, undefined, false, false);
                    break;
            }
        }
    }
    
    if (!_InventoryFull && instance_exists(InventoryFullInst))
    {
        instance_destroy(InventoryFullInst);
        InventoryFullInst = -4;
    }
}

function CheckSpecialItems()
{
    if (global.Level.Index <= UnknownEnum.Value_1)
    {
        if (AllowCastleEntranceWallCollide)
        {
            var EntranceWallInst = instance_position(x, y + 4, Castle_EntranceWallInst);
            
            if (EntranceWallInst != -4)
            {
                AllowCastleEntranceWallCollide = false;
                MsgBox("Where are you going? The action is the other way!");
            }
        }
        else if (!instance_position(x, y + 4, Castle_EntranceWallInst))
        {
            AllowCastleEntranceWallCollide = true;
        }
    }
    
    if (global.CurrentRoomIndex == -1)
        exit;
    
    if (TemplateCheck(global.CurrentRoomIndex, UnknownEnum.Value_8, UnknownEnum.Value_0))
    {
        var FairyInst = collision_circle(x, y, 50, oFairy_Health, false, true);
        
        if (FairyInst != -4)
        {
            if (AllowFairy)
            {
                FairyInst.DB_Init = true;
                AllowFairy = false;
            }
        }
        else
        {
            AllowFairy = true;
        }
    }
    
    var SwitchInst = instance_position(x, y - 2, oFloorSwitch);
    
    if (SwitchInst != -4 && SwitchInst.FloorLevel == FloorLevel)
        SwitchInst.Activated = true;
    
    var WarpInst = instance_position(x, y - 2, oWarp);
    
    if (WarpInst != -4)
    {
        if (WarpInst.FloorLevel == FloorLevel && WarpInst.visible)
        {
            StopStar();
            
            with (oCape)
                instance_destroy(id);
            
            Warp_RoomIndex_From = global.CurrentRoomIndex;
            Warp_RoomIndex_To = global.Level.Rooms[WarpInst.RoomIndex].Warp_DestRoomIndex;
            Mosaic(UnknownEnum.Value_0);
            UpdateState(UnknownEnum.Value_23);
            Dungeon_RoomActivate(Warp_RoomIndex_To);
            audio_play_sound(Sound_Warp, 1, false);
        }
    }
}

function UpdateCarryItem()
{
    if (!instance_exists(ItemHolding) || ItemHolding == -4 || State == UnknownEnum.Value_6 || State == UnknownEnum.Value_7 || State == UnknownEnum.Value_9)
        exit;
    
    ItemHolding.x = x;
    var NewY = (y - 18) + ((State == UnknownEnum.Value_2 || State == UnknownEnum.Value_5) ? floor(image_index % 3) : 0);
    ItemHolding.FloorLevel = FloorLevel;
    ItemHolding.layer = (FloorLevel == 1 || OnStairs(ItemHolding.x, ItemHolding.y) != 0) ? global.LayerID_ObjsHigher_Upper : global.LayerID_ObjsHigher_Lower;
    
    switch (ItemHolding.id)
    {
        case oEnemy_Chicken:
            ObjSetY(NewY);
            break;
        
        default:
            ItemHolding.y = NewY;
            break;
    }
}

function HoldUpItem(arg0, arg1 = UnknownEnum.Value_2, arg2 = true, arg3 = true)
{
    with (oLink)
    {
        UpdateState(UnknownEnum.Value_9);
        ItemHolding = arg0;
        ItemHolding.visible = true;
        ItemHolding.layer = (arg0.Class == UnknownEnum.Value_45 && arg1 == UnknownEnum.Value_4) ? global.LayerID_ObjsHigher_Upper : global.LayerID_ObjsHighest;
        ItemHolding.From = arg1;
        ItemHolding.FloorLevel = 1;
        ItemHolding.ShowShadow = false;
        ItemHolding.ShowPrice = false;
        ItemHolding.Get_Sound = -4;
        ItemHolding.Lighting = false;
        ItemHolding.x = x + 6;
        ItemHolding.y = y - 19;
        
        if (arg3)
            alarm[0] = 92;
    }
    
    if (arg2)
        audio_play_sound(Sound_ItemGetFanfare, 1, false);
}

function ATTACK()
{
    var SwordPoints = global.Inventory_ItemData[UnknownEnum.Value_44].Index + 1;
    var GlovePoints = max(global.Inventory_ItemData[UnknownEnum.Value_16].Index, 0);
    var AttackPoints = SwordPoints + GlovePoints;
    
    if (Curse_Check(UnknownEnum.Value_9))
        AttackPoints -= 3;
    
    return max(AttackPoints, 0);
}

function DEFENSE()
{
    var TunicPoints = global.Inventory_ItemData[UnknownEnum.Value_46].Index;
    var ShieldPoints = global.Inventory_ItemData[UnknownEnum.Value_41].Index + 1;
    var GlovePoints = (global.Inventory_ItemData[UnknownEnum.Value_16].Index >= 0) ? 1 : 0;
    var DefensePoints = TunicPoints + ShieldPoints + GlovePoints;
    
    if (Curse_Check(UnknownEnum.Value_10))
        DefensePoints -= 3;
    
    return max(DefensePoints, 0);
}

function AttackOrDefenseTooHigh(arg0)
{
    if (global.Level.Index == UnknownEnum.Value_6)
        return false;
    
    if ((arg0 >= 3 && global.Level.Index <= UnknownEnum.Value_3) || (arg0 >= 4 && global.Level.Index <= UnknownEnum.Value_5) || (arg0 >= 5 && global.Level.Index <= UnknownEnum.Value_7) || (arg0 >= 6 && global.Level.Index <= UnknownEnum.Value_9))
        return true;
}

function MaxAttackPointsThatExist()
{
    var LinkSwordIndex = global.Inventory_ItemData[UnknownEnum.Value_44].Index;
    var LinkGloveIndex = global.Inventory_ItemData[UnknownEnum.Value_16].Index;
    var HighestSwordIndexThatExists = LinkSwordIndex;
    var HighestGloveIndexThatExists = LinkGloveIndex;
    var GridH = ds_grid_height(global.NonDuplicatableItemsThatExist);
    
    for (var i = 0; i < GridH; i++)
    {
        var _ItemClass = ds_grid_get(global.NonDuplicatableItemsThatExist, 0, i);
        var _ItemIndex = ds_grid_get(global.NonDuplicatableItemsThatExist, 1, i);
        
        switch (_ItemClass)
        {
            case UnknownEnum.Value_44:
                HighestSwordIndexThatExists = max(HighestSwordIndexThatExists, _ItemIndex);
                break;
            
            case UnknownEnum.Value_16:
                HighestGloveIndexThatExists = max(HighestGloveIndexThatExists, _ItemIndex);
                break;
        }
    }
    
    var SwordPoints = HighestSwordIndexThatExists + 1;
    var GlovePoints = max(HighestGloveIndexThatExists, 0);
    return SwordPoints + GlovePoints;
}

function MaxDefensePointsThatExist()
{
    var LinkGloveIndex = global.Inventory_ItemData[UnknownEnum.Value_16].Index;
    var LinkShieldIndex = global.Inventory_ItemData[UnknownEnum.Value_41].Index;
    var LinkTunicIndex = global.Inventory_ItemData[UnknownEnum.Value_46].Index;
    var HighestGloveIndexThatExists = LinkGloveIndex;
    var HighestShieldIndexThatExists = LinkShieldIndex;
    var HighestTunicIndexThatExists = LinkTunicIndex;
    var GridH = ds_grid_height(global.NonDuplicatableItemsThatExist);
    
    for (var i = 0; i < GridH; i++)
    {
        var _ItemClass = ds_grid_get(global.NonDuplicatableItemsThatExist, 0, i);
        var _ItemIndex = ds_grid_get(global.NonDuplicatableItemsThatExist, 1, i);
        
        switch (_ItemClass)
        {
            case UnknownEnum.Value_16:
                HighestGloveIndexThatExists = max(HighestGloveIndexThatExists, _ItemIndex);
                break;
            
            case UnknownEnum.Value_41:
                HighestShieldIndexThatExists = max(HighestShieldIndexThatExists, _ItemIndex);
                break;
            
            case UnknownEnum.Value_46:
                HighestTunicIndexThatExists = max(HighestTunicIndexThatExists, _ItemIndex);
                break;
        }
    }
    
    var GlovePoints = (HighestGloveIndexThatExists >= 0) ? 1 : 0;
    var ShieldPoints = HighestShieldIndexThatExists + 1;
    var TunicPoints = HighestTunicIndexThatExists;
    return TunicPoints + ShieldPoints + GlovePoints;
}

function Link_UpdateAttackDefence()
{
    oLink.AttackPoints = ATTACK();
    oLink.DefensePoints = DEFENSE();
}

function InFrontOfLink(arg0, arg1)
{
    switch (oLink.Facing)
    {
        case 1:
            if (arg1 <= oLink.y)
                return true;
            
            break;
        
        case 2:
            if (arg1 >= oLink.y)
                return true;
            
            break;
        
        case 3:
            if (arg0 <= oLink.x)
                return true;
            
            break;
        
        case 4:
            if (arg0 >= oLink.x)
                return true;
            
            break;
    }
    
    return false;
}

function Link_PickupObjPos(arg0)
{
    switch (Facing)
    {
        case 3:
            if (arg0 >= 0 && arg0 <= 2)
            {
                ItemHolding.x = x - 13;
                ItemHolding.y = y - 10;
            }
            
            if (arg0 == 3)
            {
                ItemHolding.x = x - 10;
                ItemHolding.y = y - 13;
            }
            
            if (arg0 >= 4)
            {
                ItemHolding.x = x - 5;
                ItemHolding.y = y - 16;
            }
            
            break;
        
        case 4:
            if (arg0 >= 0 && arg0 <= 2)
            {
                ItemHolding.x = x + 13;
                ItemHolding.y = y - 10;
            }
            
            if (arg0 == 3)
            {
                ItemHolding.x = x + 10;
                ItemHolding.y = y - 13;
            }
            
            if (arg0 >= 4)
            {
                ItemHolding.x = x + 5;
                ItemHolding.y = y - 16;
            }
            
            break;
        
        case 1:
            if (arg0 >= 0 && arg0 <= 2)
            {
                ItemHolding.x = x;
                ItemHolding.y = y - 15;
            }
            
            if (arg0 == 3)
            {
                ItemHolding.x = x;
                ItemHolding.y = y - 16;
            }
            
            if (arg0 >= 4)
            {
                ItemHolding.x = x;
                ItemHolding.y = y - 17;
            }
            
            break;
        
        case 2:
            if (arg0 >= 0 && arg0 <= 2)
            {
                ItemHolding.x = x;
                ItemHolding.y = y - 2;
            }
            
            if (arg0 == 3)
            {
                ItemHolding.x = x;
                ItemHolding.y = y - 12;
            }
            
            if (arg0 >= 4)
            {
                ItemHolding.x = x;
                ItemHolding.y = y - 16;
            }
            
            break;
    }
}

function Link_PauseHitFlashingTimer()
{
    with (oLink)
    {
        if (Invincible && alarm[4] != -1)
        {
            alarm[4]++;
            alarm[5]++;
            HitFlashingStatus = false;
        }
    }
}

function Link_PixelRender()
{
    if (global.Level.Index == UnknownEnum.Value_13)
    {
        with (oBoss_Aghanim)
        {
            if (Intro && TakeItems && TakeItems_ShowBag)
            {
                PixelRender(other.Lighting, other.Lighting, false, -4, 0, false, []);
                exit;
            }
        }
    }
    
    if (State == UnknownEnum.Value_19)
        PixelRender(Lighting, Lighting, PaletteSpr != -4, PaletteSpr, global.Inventory_ItemData[UnknownEnum.Value_46].Index, true, StarColors[StarColorIndex]);
    else if (global.Cursed)
        PixelRender(Lighting, Lighting, PaletteSpr != -4, PaletteSpr, global.Inventory_ItemData[UnknownEnum.Value_46].Index, true, [-2, -2, -2]);
    else
        PixelRender(Lighting, Lighting, PaletteSpr != -4, PaletteSpr, global.Inventory_ItemData[UnknownEnum.Value_46].Index, false, []);
}

function GetLinkWeaponClass(arg0, arg1 = 0)
{
    switch (arg0)
    {
        case oSword:
            return UnknownEnum.Value_0;
        
        case oArrow:
            return UnknownEnum.Value_2;
        
        case oBoomerang:
            return UnknownEnum.Value_3;
        
        case oBombExplosion:
            return UnknownEnum.Value_5;
        
        case oHookshot:
            return UnknownEnum.Value_4;
        
        case oRodBeam:
        case oCaneBeam:
            switch (arg1)
            {
                case UnknownEnum.Value_0:
                    return UnknownEnum.Value_9;
                
                case UnknownEnum.Value_1:
                    return UnknownEnum.Value_7;
                
                case UnknownEnum.Value_2:
                    return UnknownEnum.Value_6;
                
                case UnknownEnum.Value_3:
                case UnknownEnum.Value_4:
                case UnknownEnum.Value_5:
                    return UnknownEnum.Value_10;
            }
            
            break;
        
        case oFireTower:
            return UnknownEnum.Value_6;
        
        case oIceTower:
            return UnknownEnum.Value_7;
        
        case oSwordBeam:
            return UnknownEnum.Value_8;
        
        case oPot:
        case oBush:
            return UnknownEnum.Value_1;
    }
    
    return -1;
}

function GetStateName(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_0:
            return "Idle";
        
        case UnknownEnum.Value_1:
            return "Standing";
        
        case UnknownEnum.Value_2:
            return "Walking";
        
        case UnknownEnum.Value_3:
            return "Hit";
        
        case UnknownEnum.Value_4:
            return "Dead";
        
        case UnknownEnum.Value_5:
            return "AutoMove";
        
        case UnknownEnum.Value_12:
            return "Sword";
        
        case UnknownEnum.Value_13:
            return "Bow";
        
        case UnknownEnum.Value_6:
            return "PickUp";
        
        case UnknownEnum.Value_7:
            return "PutDown";
        
        case UnknownEnum.Value_8:
            return "TreasureOpening";
        
        case UnknownEnum.Value_9:
            return "HoldingItem";
        
        case UnknownEnum.Value_10:
            return "Throwing";
        
        case UnknownEnum.Value_11:
            return "Pushing";
        
        case UnknownEnum.Value_14:
            return "Boomerang";
        
        case UnknownEnum.Value_15:
            return "Hookshot";
        
        case UnknownEnum.Value_16:
            return "Rod";
        
        case UnknownEnum.Value_17:
            return "Powder";
        
        case UnknownEnum.Value_18:
            return "Shocked";
        
        case UnknownEnum.Value_23:
            return "Warping";
        
        case UnknownEnum.Value_20:
            return "Falling";
        
        case UnknownEnum.Value_21:
            return "FallingOverEdge";
        
        case UnknownEnum.Value_22:
            return "Descending";
        
        case UnknownEnum.Value_24:
            return "Inventory";
        
        case UnknownEnum.Value_25:
            return "Dialogue";
        
        case UnknownEnum.Value_26:
            return "VideoGame";
    }
    
    return "unknown";
}

function Link_LoadCharacterIndex()
{
    if (!variable_global_exists("LinkCharacterIndex"))
        global.LinkCharacterIndex = 0;
    
    PaletteSpr = global.LinkCharacterPal[global.LinkCharacterIndex];
    LinkSprites_Construct(global.LinkCharacterIndex);
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
    Value_28 = 28,
    Value_33 = 33,
    Value_36 = 36,
    Value_39 = 39,
    Value_40,
    Value_41,
    Value_44 = 44,
    Value_45,
    Value_46,
    Value_51 = 51
}
