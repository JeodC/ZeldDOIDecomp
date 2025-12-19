function Dungeon_Draw_Jail(arg0, arg1, arg2, arg3, arg4, arg5)
{
    DrawTileBlock(global.TMID_Tiles_Highest, arg1, arg2, 56, 0, 1, 1);
    
    for (var i = 0; i < (arg3 - 2); i++)
        DrawTileBlock(global.TMID_Tiles_Highest, arg1 + 8 + (i * 8), arg2, 57, 0, 1, 1);
    
    DrawTileBlock(global.TMID_Tiles_Highest, arg1 + ((arg3 - 1) * 8), arg2, 61, 0, 1, 1);
    var TilesW_LeftSide = floor(arg3 / 2);
    var TilesW_RightSide = arg3 - TilesW_LeftSide;
    var RightSideX = arg1 + (TilesW_LeftSide * 8);
    var _W = arg3 * 8;
    var _ChecksX = arg1 + (_W / 2);
    var _ChecksY = arg2 + 32;
    var FloorLevelStr = GetFloorLevelString(_ChecksX, _ChecksY);
    var JailBaseWallLayer = GetFloorLevelTMID("Tiles_Walls", _ChecksX, _ChecksY);
    var JailIsInSection = InSectionArea(arg0, _ChecksX, _ChecksY, global.Level.Rooms[arg0].Section_ID, true);
    
    switch (arg5)
    {
        case UnknownEnum.Value_0:
            for (var i = 0; i < (arg3 - 4); i++)
                DrawTileBlock(global.TMID_Tiles_Higher, arg1 + 16 + (i * 8), arg2 + 8, 57, 1, 1, 1);
            
            DrawTileBlock(global.TMID_Tiles_Higher, arg1 + 8, arg2 + 16, 56, 2, 1, 1);
            DrawTileBlock(global.TMID_Tiles_Higher, RightSideX + ((TilesW_RightSide - 2) * 8), arg2 + 16, 61, 2, 1, 1);
            
            for (var i = 0; i < (arg3 - 4); i++)
                DrawTileBlock(global.TMID_Tiles_Higher, arg1 + 16 + (i * 8), arg2 + 16, 57, 2, 1, 1);
            
            for (var i = 0; i < (arg3 - 4); i++)
                DrawTileBlock(global.TMID_Decor_Upper, arg1 + 16 + (i * 8), arg2 + 24, 57, 3, 1, 1);
            
            DrawTileBlock(global.TMID_Decor_Upper, RightSideX - 8, arg2 + 16, 58, 2, 1, 1);
            DrawTileBlock(global.TMID_Decor_Upper, RightSideX - 8, arg2 + 24, 58, 3, 1, 1);
            DrawTileBlock(JailBaseWallLayer, arg1 + 24, arg2 + 32, 56, 3, 1, 1);
            
            for (var i = 0; i < (arg3 - 8); i++)
                DrawTileBlock(JailBaseWallLayer, arg1 + 32 + (i * 8), arg2 + 32, 61, 3, 1, 1);
            
            DrawTileBlock(JailBaseWallLayer, (arg1 + _W) - 32, arg2 + 32, 56, 3, 1, 1);
            var WallInst = WallObj_Create("Objs_" + FloorLevelStr, arg1 + 24, arg2 + 24, arg3 - 6, 2);
            
            if (global.Level.Rooms[arg0].Lighting && !global.Challenges[UnknownEnum.Value_4])
            {
                instance_create_layer((arg1 + (TilesW_LeftSide * 8)) - 16, arg2 - 32, "Objs_Upper", oWallLight, 
                {
                    RoomIndex: arg0,
                    Location: 1,
                    Status: true
                });
            }
            
            AddUsedSpace(arg0, arg1 + 24, arg2 - 16, (arg1 + _W) - 25, arg2 - 1, UnknownEnum.Value_0, JailIsInSection);
            var _Index;
            
            if (ds_list_size(global.UnusedPrisoners) == 0)
            {
                _Index = choose(UnknownEnum.Value_11, UnknownEnum.Value_12, UnknownEnum.Value_13);
            }
            else
            {
                _Index = ds_list_find_value(global.UnusedPrisoners, 0);
                ds_list_delete(global.UnusedPrisoners, 0);
            }
            
            if (!global.Gore && (_Index == UnknownEnum.Value_11 || _Index == UnknownEnum.Value_12 || _Index == UnknownEnum.Value_13))
                break;
            
            instance_create_layer(arg1 + 40 + (irandom(arg3 - 10) * 8), arg2 + 8, "Objs_" + FloorLevelStr, oPrisoner, 
            {
                Index: _Index
            });
            break;
        
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_2:
            for (var i = 0; i < (TilesW_LeftSide - 3); i++)
                DrawTileBlock(global.TMID_Tiles_Higher, arg1 + 16 + (i * 8), arg2 + 8, 57, 1, 1, 1);
            
            for (var i = 0; i < (TilesW_RightSide - 3); i++)
                DrawTileBlock(global.TMID_Tiles_Higher, arg1 + (TilesW_LeftSide * 8) + 8 + (i * 8), arg2 + 8, 60, 1, 1, 1);
            
            DrawTileBlock(global.TMID_Tiles_Higher, arg1 + 8, arg2 + 16, 56, 2, 1, 1);
            DrawTileBlock(global.TMID_Tiles_Higher, RightSideX + ((TilesW_RightSide - 2) * 8), arg2 + 16, 61, 2, 1, 1);
            
            for (var i = 0; i < (TilesW_LeftSide - 3); i++)
                DrawTileBlock(global.TMID_Tiles_Higher, arg1 + 16 + (i * 8), arg2 + 16, 57, 2, 1, 1);
            
            for (var i = 0; i < (TilesW_RightSide - 3); i++)
                DrawTileBlock(global.TMID_Tiles_Higher, RightSideX + 8 + (i * 8), arg2 + 16, 59, 2, 1, 1);
            
            for (var i = 0; i < (TilesW_LeftSide - 3); i++)
                DrawTileBlock(global.TMID_Decor_Upper, arg1 + 16 + (i * 8), arg2 + 24, 57, 3, 1, 1);
            
            for (var i = 0; i < (TilesW_RightSide - 3); i++)
                DrawTileBlock(global.TMID_Decor_Upper, RightSideX + 8 + (i * 8), arg2 + 24, 59, 3, 1, 1);
            
            DrawTileBlock(JailBaseWallLayer, arg1 + 24, arg2 + 32, 56, 3, 1, 1);
            
            for (var i = 0; i < (TilesW_LeftSide - 6); i++)
                DrawTileBlock(JailBaseWallLayer, arg1 + 32 + (i * 8), arg2 + 32, 61, 3, 1, 1);
            
            DrawTileBlock(JailBaseWallLayer, (arg1 + (TilesW_LeftSide * 8)) - 16, arg2 + 32, 56, 3, 1, 1);
            DrawTileBlock(JailBaseWallLayer, RightSideX + 8, arg2 + 32, 56, 3, 1, 1);
            
            for (var i = 0; i < (TilesW_RightSide - 6); i++)
                DrawTileBlock(JailBaseWallLayer, RightSideX + 16 + (i * 8), arg2 + 32, 61, 3, 1, 1);
            
            DrawTileBlock(JailBaseWallLayer, (RightSideX + (TilesW_RightSide * 8)) - 32, arg2 + 32, 56, 3, 1, 1);
            var WallInst = WallObj_Create("Objs_" + FloorLevelStr, arg1 + 24, arg2 + 24, TilesW_LeftSide - 4, 2);
            WallInst = WallObj_Create("Objs_" + FloorLevelStr, RightSideX + 8, arg2 + 24, TilesW_RightSide - 4, 2);
            
            if (arg5 == UnknownEnum.Value_2)
            {
                var KeyBlockInst = instance_create_layer(RightSideX - 8, arg2 + 16, "Objs_" + FloorLevelStr, oKeyBlock);
                KeyBlockInst.RoomIndex = arg0;
                ds_list_add(global.LargeMapItems, KeyBlockInst);
            }
            
            AddUsedSpace(arg0, RightSideX - 8, arg2 + 32, RightSideX + 8, arg2 + 64, UnknownEnum.Value_0, JailIsInSection);
            break;
    }
    
    AddUsedSpace(arg0, arg1 + 24, arg2, (arg1 + _W) - 25, arg2 + 31, UnknownEnum.Value_0, JailIsInSection);
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_4 = 4,
    Value_11 = 11,
    Value_12,
    Value_13
}
