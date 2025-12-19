function OnStairs(arg0, arg1)
{
    var TilesY = (global.Level.Rooms[global.CurrentRoomIndex].ForcedTheme == -1) ? (4 + ((global.Level.Index - 1) * 6) + 2) : (6 + (global.Level.Rooms[global.CurrentRoomIndex].ForcedTheme * 6));
    
    if (CollideTileBlock(global.TMID_Walls_Lower, arg0, arg1, 54, TilesY, 2, 4))
        return 1;
    
    if (CollideTileBlock(global.TMID_Walls_Lower, arg0, arg1, 56, TilesY, 2, 4))
        return 2;
    
    return 0;
}

function Dungeon_Draw_Stairs(arg0)
{
    if (!variable_struct_exists(global.Level.Rooms[arg0].Template, "Stairs"))
        exit;
    
    var TilesX = 50;
    var TilesY = (global.Level.Rooms[arg0].ForcedTheme == -1) ? (4 + ((global.Level.Index - 1) * 6) + 2) : (6 + (global.Level.Rooms[arg0].ForcedTheme * 6));
    
    for (var StairIndex = 0; StairIndex < array_length(global.Level.Rooms[arg0].Template.Stairs); StairIndex++)
    {
        var _Stairs = global.Level.Rooms[arg0].Template.Stairs[StairIndex];
        var TLCornerX = global.Level.Rooms[arg0].x + _Stairs.x;
        var TLCornerY = global.Level.Rooms[arg0].y + _Stairs.y;
        var _ShortStairs = _Stairs.height == 24;
        
        switch (_Stairs.gid)
        {
            case UnknownEnum.Value_8:
                DrawTileBlock(global.TMID_Walls_Lower, TLCornerX + 8, TLCornerY, TilesX + 4, TilesY, 2, 1);
                DrawTileBlock(global.TMID_Walls_Lower, TLCornerX + 8, TLCornerY + 8, TilesX + 4, TilesY + (_ShortStairs ? 2 : 1), 2, _ShortStairs ? 2 : 3);
                var inst = WallObj_Create("Objs_Upper", TLCornerX + 8, TLCornerY, 2, _ShortStairs ? 1 : 2);
                inst.FloorLevel = 1;
                inst.BlockLink = false;
                inst.BlockLinkCarry = false;
                inst.BlockProjectiles = false;
                inst.IsStairs = true;
                inst = WallObj_Create("Objs_Lower", TLCornerX + 8, TLCornerY + (_ShortStairs ? 8 : 16), 2, 2);
                inst.FloorLevel = 0;
                inst.BlockLink = false;
                inst.BlockLinkCarry = false;
                inst.BlockProjectiles = false;
                inst.IsStairs = true;
                DrawTileBlock(global.TMID_Walls_Upper, TLCornerX, TLCornerY, TilesX, TilesY, 1, 1);
                DrawTileBlock(global.TMID_Walls_Lower, TLCornerX, TLCornerY + 8, TilesX, TilesY + 1, 1, _ShortStairs ? 2 : 3);
                var WallInst = WallObj_Create("Objs_Upper", TLCornerX, TLCornerY, 1, _ShortStairs ? 3 : 4);
                WallInst.FloorLevel = 2;
                DrawTileBlock(global.TMID_Walls_Upper, TLCornerX + 24, TLCornerY, TilesX + 1, TilesY, 1, 1);
                DrawTileBlock(global.TMID_Walls_Lower, TLCornerX + 24, TLCornerY + 8, TilesX + 1, TilesY + 1, 1, _ShortStairs ? 2 : 3);
                WallInst = WallObj_Create("Objs_Upper", TLCornerX + 24, TLCornerY, 1, _ShortStairs ? 3 : 4);
                WallInst.FloorLevel = 2;
                break;
            
            case UnknownEnum.Value_5:
                DrawTileBlock(global.TMID_Walls_Lower, TLCornerX + 8, TLCornerY, TilesX + 6, TilesY, 2, _ShortStairs ? 2 : 3);
                DrawTileBlock(global.TMID_Walls_Lower, TLCornerX + 8, TLCornerY + (_ShortStairs ? 16 : 24), TilesX + 6, TilesY + 3, 2, 1);
                var inst = WallObj_Create("Objs_Lower", TLCornerX + 8, TLCornerY, 2, 2);
                inst.FloorLevel = 0;
                inst.BlockLink = false;
                inst.BlockLinkCarry = false;
                inst.BlockProjectiles = false;
                inst.IsStairs = true;
                inst = WallObj_Create("Objs_Upper", TLCornerX + 8, TLCornerY + 16, 2, _ShortStairs ? 1 : 2);
                inst.FloorLevel = 1;
                inst.BlockLink = false;
                inst.BlockLinkCarry = false;
                inst.BlockProjectiles = false;
                inst.IsStairs = true;
                DrawTileBlock(global.TMID_Walls_Lower, TLCornerX, TLCornerY, TilesX + 2, TilesY, 1, _ShortStairs ? 2 : 3);
                DrawTileBlock(global.TMID_Walls_Upper, TLCornerX, TLCornerY + (_ShortStairs ? 16 : 24), TilesX + 2, TilesY + 3, 1, 1);
                var WallInst = WallObj_Create("Objs_Upper", TLCornerX, TLCornerY, 1, _ShortStairs ? 3 : 4);
                WallInst.FloorLevel = 2;
                DrawTileBlock(global.TMID_Walls_Lower, TLCornerX + 24, TLCornerY, TilesX + 3, TilesY, 1, _ShortStairs ? 2 : 3);
                DrawTileBlock(global.TMID_Walls_Upper, TLCornerX + 24, TLCornerY + (_ShortStairs ? 16 : 24), TilesX + 3, TilesY + 3, 1, 1);
                WallInst = WallObj_Create("Objs_Upper", TLCornerX + 24, TLCornerY, 1, _ShortStairs ? 3 : 4);
                WallInst.FloorLevel = 2;
                break;
        }
    }
}

enum UnknownEnum
{
    Value_5 = 5,
    Value_8 = 8
}
