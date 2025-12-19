with (DoorInst)
    Lighting_UpdateLight_Visible(RoomIndex, FloorLight, false);

PixelRender(true, true, false, -4, 0, false, []);
draw_sprite(sprite_index, image_index, x, y);

with (DoorInst)
{
    if (Status == UnknownEnum.Value_0 || Status == UnknownEnum.Value_6 || Status == UnknownEnum.Value_9)
        Lighting_UpdateLight_Visible(RoomIndex, FloorLight, true);
}

shader_reset();

switch (Location)
{
    case "Top":
        DrawTileBlock(global.TMID_Tiles_Highest, x, y, BeamTileX, 0, 2, 1);
        DrawTileBlock(global.TMID_Tiles_Highest, x + 16, y, BeamTileX, 0, 2, 1);
        break;
    
    case "Bottom":
        DrawTileBlock(global.TMID_Tiles_Highest, x, y + 24, BeamTileX, 1, 2, 1);
        DrawTileBlock(global.TMID_Tiles_Highest, x + 16, y + 24, BeamTileX, 1, 2, 1);
        break;
    
    case "Left":
        DrawTileBlock(global.TMID_Tiles_Highest, x, y, BeamTileX + 2, 0, 1, 2);
        DrawTileBlock(global.TMID_Tiles_Highest, x, y + 16, BeamTileX + 2, 0, 1, 2);
        break;
    
    case "Right":
        DrawTileBlock(global.TMID_Tiles_Highest, x + 24, y, BeamTileX + 3, 0, 1, 2);
        DrawTileBlock(global.TMID_Tiles_Highest, x + 24, y + 16, BeamTileX + 3, 0, 1, 2);
        break;
}

enum UnknownEnum
{
    Value_0,
    Value_6 = 6,
    Value_9 = 9
}
