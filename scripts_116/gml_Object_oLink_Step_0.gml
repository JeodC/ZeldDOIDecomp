var _Exit = false;

switch (State)
{
    case UnknownEnum.Value_22:
        switch (DescendingPhase)
        {
            case 1:
                if (image_index > (image_number - 1))
                {
                    instance_activate_all();
                    InitNewDungeon = true;
                    DescendingPhase = 2;
                }
                
                break;
            
            case 2:
                if (image_index > (image_number - 1))
                {
                    var StartDir = Dungeon_StartDir(global.Level.Index);
                    
                    if (StartDir == 1)
                        Link_SetAutoMove(0, -1, WalkSpeed, 12);
                    else
                        Link_SetAutoMove(0, 1, WalkSpeed, 10);
                    
                    FallSpawnX = x + (AutoMoveFrames * WalkSpeed * AutoMoveDirX);
                    FallSpawnY = y + (AutoMoveFrames * WalkSpeed * AutoMoveDirY);
                    FallSpawnFacing = StartDir;
                    FallSpawnFloorLevel = FloorLevel;
                    
                    if (global.Level.Index != UnknownEnum.Value_0)
                        GoingThruClosedDoor = true;
                    
                    oHUD.CheckPendentSecret = true;
                    DescendingPhase = 0;
                }
                
                break;
        }
        
        _Exit = true;
        break;
    
    case UnknownEnum.Value_23:
        if (!Warp_Engage && oRender.Mosaic_SizeDir == -1)
        {
            Warp_Engage = true;
            var DestRoom = global.Level.Rooms[Warp_RoomIndex_To];
            x = DestRoom.WarpDest_X;
            y = DestRoom.WarpDest_Y;
            FallSpawnX = x;
            FallSpawnY = y;
            HitBox.x = x;
            HitBox.y = y;
            FloorLevel = GetFloorLevelID(x, y);
            FloorLevelStr = GetFloorLevelString(FloorLevel);
            FallSpawnFloorLevel = FloorLevel;
            LampDim = FloorLevel;
            UpdateCarryItem();
            Dungeon_DestroyUnimportantObjs();
            oCamera.SetToRoomIndex(Warp_RoomIndex_To, true, true, x - 128, y - 128);
            global.Level.Rooms[Warp_RoomIndex_To].Visited = true;
            Enemy_Reset(Warp_RoomIndex_To);
            Lighting_UpdateLinkLight([x, y - 6]);
            Map_UpdateExploredRooms();
            Dungeon_RoomDeActivate(Warp_RoomIndex_From);
        }
        
        _Exit = true;
        break;
    
    case UnknownEnum.Value_21:
        x += vx;
        y += vy;
        FallOverEdgeDelay--;
        
        if (FallOverEdgeDelay == 0)
        {
            UpdateState(UnknownEnum.Value_20);
            instance_destroy(oSword);
            instance_destroy(oRod_Cane);
        }
        
        _Exit = true;
        break;
    
    case UnknownEnum.Value_20:
        if (image_index > (image_number - 1))
        {
            x = FallSpawnX;
            y = FallSpawnY;
            FloorLevel = FallSpawnFloorLevel;
            Facing = FallSpawnFacing;
            LampDim = FloorLevel;
            BounceBack = false;
            HealthAdd(-1);
            
            if (global.Inventory_ItemData[UnknownEnum.Value_17].Amount > 0)
            {
                UpdateState(UnknownEnum.Value_1);
                LinkEnableFlashing();
            }
            
            break;
        }
        
        _Exit = true;
        break;
    
    case UnknownEnum.Value_9:
        if (ItemHolding.object_index == oItem_Crystal && !audio_is_playing(Music_Boss_Defeated))
        {
            instance_destroy(ItemHolding);
            ItemHolding = -4;
            oHUD.BossesDefeated++;
            UpdateState(UnknownEnum.Value_1);
            
            with (oDoor)
            {
                if (RoomIndex == global.CurrentRoomIndex && Location == "Top")
                {
                    Open = true;
                    Exit = true;
                    break;
                }
            }
        }
        
        _Exit = true;
        break;
    
    case UnknownEnum.Value_18:
    case UnknownEnum.Value_24:
    case UnknownEnum.Value_25:
    case UnknownEnum.Value_26:
    case UnknownEnum.Value_0:
    case UnknownEnum.Value_4:
        _Exit = true;
        break;
}

if (_Exit || State == UnknownEnum.Value_5 || oCamera.RoomTransition != 0)
{
    if (alarm[3] >= 0)
        alarm[3]++;
}

if (_Exit)
    exit;

if (State != UnknownEnum.Value_3 && !BounceBack)
{
    vx = 0;
    vy = 0;
}

if ((State == UnknownEnum.Value_1 || State == UnknownEnum.Value_2 || State == UnknownEnum.Value_11 || State == UnknownEnum.Value_19) && !BounceBack)
{
    keyUp = input_check("up");
    keyDown = input_check("down");
    keyLeft = input_check("left");
    keyRight = input_check("right");
    Action[UnknownEnum.Value_0] = keyUp || MoveAssistDir == 1;
    Action[UnknownEnum.Value_1] = keyDown || MoveAssistDir == 2;
    Action[UnknownEnum.Value_2] = keyLeft || MoveAssistDir == 3;
    Action[UnknownEnum.Value_3] = keyRight || MoveAssistDir == 4;
    
    if (!global.ArcadeVP_Show && State != UnknownEnum.Value_19)
    {
        Action[UnknownEnum.Value_4] = input_check_pressed("sword");
        Action[UnknownEnum.Value_5] = input_check_pressed("action");
        Action[UnknownEnum.Value_7] = input_check_pressed("item");
    }
    
    Action[UnknownEnum.Value_6] = input_check("action");
    Action[UnknownEnum.Value_9] = input_check("strafe");
    
    if (Action[UnknownEnum.Value_0] && Action[UnknownEnum.Value_1])
    {
        Action[UnknownEnum.Value_0] = false;
        Action[UnknownEnum.Value_1] = false;
    }
    
    if (Action[UnknownEnum.Value_2] && Action[UnknownEnum.Value_3])
    {
        Action[UnknownEnum.Value_2] = false;
        Action[UnknownEnum.Value_3] = false;
    }
    
    if (Action[UnknownEnum.Value_9])
        FacingLock = Facing;
    
    var S;
    
    if (MoveAssistDir != 0)
    {
        if (frac(x) != 0)
            x = round(x / 2) * 2;
        
        if (frac(y) != 0)
            y = round(y / 2) * 2;
        
        S = MoveAssistSpeed;
    }
    else
    {
        S = (ItemHolding == -4) ? ((Action[UnknownEnum.Value_6] && !InDoorPassage) ? RunSpeed : WalkSpeed) : CarryingSpeed;
    }
    
    vx = ((Action[UnknownEnum.Value_2] ? -1 : 0) + (Action[UnknownEnum.Value_3] ? 1 : 0)) * S;
    vy = ((Action[UnknownEnum.Value_0] ? -1 : 0) + (Action[UnknownEnum.Value_1] ? 1 : 0)) * S;
    vx_extra = 0;
    vy_extra = 0;
    
    if (ItemHolding == -4)
    {
        if (Action[UnknownEnum.Value_4] && global.Inventory_ItemData[UnknownEnum.Value_44].Index != -1)
            UpdateState(UnknownEnum.Value_12);
        else if (Action[UnknownEnum.Value_7])
            Inventory_UseItem(global.Inventory_SlotIndex_Equiped, false);
    }
    
    var _CanPutDownObj = false;
    
    if (ItemHolding != -4)
    {
        if (instance_exists(ItemHolding))
        {
            switch (ItemHolding.object_index)
            {
                case oBomb:
                    if (ItemHolding.Red)
                        break;
                
                case oOrb:
                case oGem:
                case oWishStone:
                    if (InDoor_Facing)
                        break;
                    
                    _CanPutDownObj = true;
                    break;
            }
        }
    }
    
    if (_CanPutDownObj && Action[UnknownEnum.Value_4])
        UpdateState(UnknownEnum.Value_7);
    else if (Action[UnknownEnum.Value_5])
        Interact();
}

if (State == UnknownEnum.Value_1)
{
    if (Action[UnknownEnum.Value_0] || Action[UnknownEnum.Value_1] || Action[UnknownEnum.Value_2] || Action[UnknownEnum.Value_3])
        UpdateState(UnknownEnum.Value_2);
}
else if (State == UnknownEnum.Value_2)
{
    if (!Action[UnknownEnum.Value_0] && !Action[UnknownEnum.Value_1] && !Action[UnknownEnum.Value_2] && !Action[UnknownEnum.Value_3])
        UpdateState(UnknownEnum.Value_1);
}

if (Castle_Entering && oLink.State != UnknownEnum.Value_5 && global.DB_Inst == -4)
{
    Link_SetAutoMove(0, -1, 0.4);
    Music_Fade(0, 70, UnknownEnum.Value_2);
    oRender.FadeOut();
    oIntro.alarm[1] = -1;
    oIntro.alarm[2] = -1;
    global.GlobalLighting = true;
}

switch (State)
{
    case UnknownEnum.Value_2:
        Facing_Check();
        UpdateSprites();
        
        if (CheckDoors() == 1)
            exit;
        
        CheckRoomTransition();
        
        if (InWater && !audio_is_playing(Sound_Water_Walk))
            audio_play_sound(Sound_Water_Walk, 1, false);
        
        break;
    
    case UnknownEnum.Value_19:
        if (CheckDoors() == 1)
            exit;
        
        CheckRoomTransition();
        
        if (InWater && !audio_is_playing(Sound_Water_Walk))
            audio_play_sound(Sound_Water_Walk, 1, false);
        
        break;
    
    case UnknownEnum.Value_5:
        if (Castle_Entering && global.RoomFadeBlackOut)
        {
            Castle_Entering = false;
            instance_destroy(oIntro);
            Dungeon_InitLevel(UnknownEnum.Value_1);
            break;
        }
        
        if (House_Entering && global.RoomFadeBlackOut)
        {
            House_OldX = x;
            House_OldY = y;
            var _Room = global.Level.DungeonTemplate.Rooms[House_RoomIndex];
            var HouseDoorX = _Room.x + array_get(struct_get_from_hash(_Room, variable_get_hash("Doors")), 0).x;
            var HouseDoorY = _Room.y + array_get(struct_get_from_hash(_Room, variable_get_hash("Doors")), 0).y;
            x = HouseDoorX + 16;
            y = HouseDoorY + 32;
            FloorLevel = GetFloorLevelID(x, y);
            FloorLevelStr = GetFloorLevelString(FloorLevel);
            LampDim = FloorLevel;
            UpdateState(UnknownEnum.Value_1);
            House_Inside = true;
            oCamera.SetToRoomIndex(House_RoomIndex, true, true, House_X, House_Y);
            oRender.FadeIn();
            Link_SetAutoMove(0, -1, 0.5, 35);
            House_Entering = false;
        }
        
        if (House_Leaving && global.RoomFadeBlackOut)
        {
            x = House_OldX;
            y = House_OldY;
            FloorLevel = GetFloorLevelID(x, y);
            FloorLevelStr = GetFloorLevelString(FloorLevel);
            LampDim = FloorLevel;
            oCamera.SetToRoomIndex(House_OldRoomIndex, true, true, x - 128, y - 128);
            oRender.FadeIn();
            DoorPassage = House_DoorInst.PassageArea;
            Link_SetAutoMove(0, 1, 0.5, 40);
            House_Inside = false;
            
            if (House_Leaving)
            {
                with (oWaterfall)
                    LinkLeavingHouse = true;
            }
            
            House_Leaving = false;
        }
        
        if (AutoMoveFrames != -1)
            AutoMoveFrames--;
        
        vx = AutoMoveDirX * AutoMoveSpeed;
        vy = AutoMoveDirY * AutoMoveSpeed;
        
        if (AutoMoveFrames == 0)
        {
            if (GoingThruClosedDoor)
            {
                LastDoorID.Close = true;
                GoingThruClosedDoor = false;
                UpdateState(UnknownEnum.Value_0);
                
                with (oEnemy_RollingSpike)
                {
                    switch (oLink.Facing)
                    {
                        case 1:
                            if (vy > 0)
                                vy *= -1;
                            
                            break;
                        
                        case 2:
                            if (vy < 0)
                                vy *= -1;
                            
                            break;
                        
                        case 3:
                            if (vx > 0)
                                vx *= -1;
                            
                            break;
                        
                        case 4:
                            if (vx < 0)
                                vx *= -1;
                            
                            break;
                    }
                }
            }
            else
            {
                global.Paused = false;
                UpdateState(UnknownEnum.Value_1);
            }
        }
        
        CheckDoors();
        
        switch (oCamera.RoomTransition)
        {
            case 3:
                if (x <= ((global.CurrentRoom.x - 40) + (FloorLevel * 24)))
                    UpdateState(UnknownEnum.Value_0);
                
                break;
            
            case 4:
                if (x >= ((global.CurrentRoom.x + global.CurrentRoom.width + 40) - (FloorLevel * 24)))
                    UpdateState(UnknownEnum.Value_0);
                
                break;
            
            case 1:
                if (y <= ((global.CurrentRoom.y - 28) + (FloorLevel * 24)))
                    UpdateState(UnknownEnum.Value_0);
                
                break;
            
            case 2:
                if (y >= ((global.CurrentRoom.y + global.CurrentRoom.height + 45) - (FloorLevel * 24)))
                    UpdateState(UnknownEnum.Value_0);
                
                break;
        }
        
        break;
    
    case UnknownEnum.Value_12:
        if (image_index >= (image_number - 1))
            UpdateState(UnknownEnum.Value_1);
        
        break;
    
    case UnknownEnum.Value_13:
        if (image_index >= (image_number - 1))
        {
            Arrow_Create();
            UpdateState(UnknownEnum.Value_1);
            ObjSetImageSpeed(1);
        }
        
        break;
    
    case UnknownEnum.Value_16:
    case UnknownEnum.Value_14:
    case UnknownEnum.Value_17:
        if (image_index >= (image_number - 1))
            UpdateState(UnknownEnum.Value_1);
        
        break;
    
    case UnknownEnum.Value_11:
        if (!PushingWall)
            UpdateState(UnknownEnum.Value_1);
        
        break;
    
    case UnknownEnum.Value_6:
        if (ItemHolding == -4 || !instance_exists(ItemHolding))
        {
            UpdateState(UnknownEnum.Value_1);
            ItemHolding = -4;
            break;
        }
        
        var img_index = floor(image_index);
        Link_PickupObjPos(img_index);
        
        if (img_index >= (image_number - 1))
        {
            UpdateState(UnknownEnum.Value_1);
            ItemHolding.mask_index = sEmptyMask;
        }
        
        break;
    
    case UnknownEnum.Value_7:
        if (ItemHolding == -4 || !instance_exists(ItemHolding))
        {
            UpdateState(UnknownEnum.Value_1);
            ItemHolding = -4;
            break;
        }
        
        var img_index = floor(image_index);
        Link_PickupObjPos(img_index);
        
        if (img_index <= 0)
        {
            switch (ItemHolding.object_index)
            {
                case oOrb:
                case oGem:
                case oBomb:
                case oWishStone:
                    ItemHolding.x = x;
                    ItemHolding.y = y;
                    
                    switch (oLink.Facing)
                    {
                        case 1:
                            ItemHolding.y -= 16;
                            break;
                        
                        case 2:
                            ItemHolding.y += 16;
                            break;
                        
                        case 3:
                            ItemHolding.x -= 16;
                            break;
                        
                        case 4:
                            ItemHolding.x += 16;
                            break;
                    }
                    
                    var _FallInHole = false;
                    
                    with (ItemHolding)
                    {
                        ObjSetY(y);
                        
                        if (Item_OverHole())
                        {
                            Item_FallInHole();
                            _FallInHole = true;
                        }
                    }
                    
                    if (_FallInHole)
                        break;
                    
                    var _Inst = instance_create_layer(ItemHolding.x, ItemHolding.y, oLink.layer, ItemFromObj(ItemHolding.object_index), 
                    {
                        From: UnknownEnum.Value_19,
                        FloorLevel: ItemHolding.FloorLevel
                    });
                    
                    with (_Inst)
                    {
                        Item_SetIndex(oLink.ItemHolding.Index);
                        Amount = 1;
                        Setup = false;
                    }
                    
                    break;
            }
            
            instance_destroy(ItemHolding);
            ItemHolding = -4;
            UpdateState(UnknownEnum.Value_1);
        }
        
        break;
    
    case UnknownEnum.Value_10:
        if (image_index >= (image_number - 1))
            UpdateState(UnknownEnum.Value_1);
        
        break;
}

var _DoorInst = instance_place(x, y, oDoor);
InDoor = _DoorInst != -4;
InDoor_Full = false;
InDoor_Facing = false;
InDoor_BlockItem = false;
InDoor_Aligned = true;
InDoor_House = instance_place(x, y, oHouseDoor) != -4 || instance_place(x, y, oCastleWallDoor) != -4;

if (InDoor)
{
    InDoor_Full = rectangle_in_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, _DoorInst.bbox_left, _DoorInst.bbox_top, _DoorInst.bbox_right, _DoorInst.bbox_bottom) == 1 || InDoorPassage;
    InDoor_Facing = Facing == Door_LocationToDir(_DoorInst.Location);
    _DoorInst.WallInst.BlockItems = InDoor_Facing;
    InDoor_BlockItem = _DoorInst.WallInst.BlockLinkCarry || InDoor_House;
    
    if (InDoor_Full)
        InDoor_Aligned = InDoor_Facing || Facing == Door_LocationToOppositeDir(_DoorInst.Location);
}

layer = (FloorLevel == 1) ? global.LayerID_Objs_Upper : global.LayerID_Objs_Lower;
InWater = OnWaterTile((FloorLevel == 1) ? global.TMID_Water_Upper : global.TMID_Water_Lower, x, y);
StandingOnMap = false;
StandingOnCompass = false;
var _GravityBall = false;

if (State != UnknownEnum.Value_3 && global.Level.Index != UnknownEnum.Value_0)
{
    if (CheckHoles())
        exit;
    
    if (global.Level.Index == UnknownEnum.Value_13)
        _GravityBall = CheckGravityBall();
    
    CheckEnemies();
    CheckMovingFloor();
    CheckSpikes();
}

if (InDoor && BounceBack)
{
    vx = 0;
    vy = 0;
}

PushingWall = false;
PushingDirX = 0;
PushingDirY = 0;
var _checkwalls = vx != 0;

if (_checkwalls)
{
    WallCollision(CollidedWallList, vx + sign(vx), 0, oWall);
    var Walls = ds_list_size(CollidedWallList);
    
    for (var i = 0; i < Walls; i++)
    {
        var WallInst = ds_list_find_value(CollidedWallList, i);
        
        if ((Action[UnknownEnum.Value_2] || Action[UnknownEnum.Value_3]) && !Action[UnknownEnum.Value_0] && !Action[UnknownEnum.Value_1] && ItemHolding == -4)
        {
            PushingDirX = sign(vx);
            PushingWall = (Action[UnknownEnum.Value_2] && Facing == 3 && PushingDirX < 0) || (Action[UnknownEnum.Value_3] && Facing == 4 && PushingDirX > 0);
            break;
        }
    }
    
    if (Walls > 0)
    {
        vx = 0;
        MoveAssist = true;
    }
}

x += vx;
_checkwalls = vy != 0;

if (_checkwalls)
{
    WallCollision(CollidedWallList, 0, vy + sign(vy), oWall);
    var Walls = ds_list_size(CollidedWallList);
    
    for (var i = 0; i < Walls; i++)
    {
        var WallInst = ds_list_find_value(CollidedWallList, i);
        
        if ((Action[UnknownEnum.Value_0] || Action[UnknownEnum.Value_1]) && !Action[UnknownEnum.Value_2] && !Action[UnknownEnum.Value_3] && ItemHolding == -4)
        {
            PushingDirY = sign(vy);
            PushingWall = (Action[UnknownEnum.Value_0] && Facing == 1 && PushingDirY < 0) || (Action[UnknownEnum.Value_1] && Facing == 2 && PushingDirY > 0);
            break;
        }
    }
    
    if (Walls > 0)
    {
        vy = 0;
        MoveAssist = true;
    }
}

y += vy;
x = clamp(x, 0, 2047);
y = clamp(y, 0, 2047);
RoomIndex = Dungeon_GetRoomIndex(x, y);

if (global.Inventory_ItemData[UnknownEnum.Value_31].Owns[0])
{
    ds_list_clear(CollidedWallList);
    var Walls = collision_circle_list(x, y, 32, oWall, false, true, CollidedWallList, false);
    var _PlayedSound = false;
    
    for (var i = 0; i < Walls; i++)
    {
        var WallInst = ds_list_find_value(CollidedWallList, i);
        
        if (WallInst.IsSwitchBlock)
        {
            if (WallInst.SwitchBlockInst.Raised)
            {
                global.Paused = true;
                global.Level.SwitchBlock_ActiveColor = WallInst.SwitchBlockInst.Color;
                
                with (oSwitchBlock)
                {
                    if (!Toggle)
                    {
                        Toggle = true;
                        
                        if (!_PlayedSound)
                        {
                            audio_play_sound(Sound_DoorClose, 1, false);
                            audio_play_sound(Sound_Cape_Off, 1, false, 1);
                            _PlayedSound = true;
                        }
                    }
                }
                
                break;
            }
        }
    }
}

if (State == UnknownEnum.Value_3 || BounceBack)
    exit;

if (PushingWall)
{
    if (State != UnknownEnum.Value_11 && alarm[1] == -1 && MoveAssistDir == 0 && !_GravityBall)
        alarm[1] = 24;
}
else
{
    alarm[1] = -1;
}

CheckMoveAssist();
CheckStairs();
CheckItems();
CheckSpecialItems();
UpdateCarryItem();

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
    Value_9 = 9,
    Value_10,
    Value_11,
    Value_12,
    Value_13,
    Value_14,
    Value_16 = 16,
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
    Value_31 = 31,
    Value_44 = 44
}
