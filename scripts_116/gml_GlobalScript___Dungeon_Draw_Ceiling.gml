function Dungeon_Draw_Ceiling(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
{
    tilemap_set_at_pixel(global.TMID_Tiles_Ceiling, arg0, arg1 * 8, arg2 * 8);
    tilemap_set_at_pixel(global.TMID_Walls_Lower, 0, arg1 * 8, arg2 * 8);
    tilemap_set_at_pixel(global.TMID_Walls_Upper, 0, arg1 * 8, arg2 * 8);
    
    if ((arg1 + 1) < arg5 && tilemap_get_at_pixel(global.TMID_Walls_Upper, (arg1 + 1) * 8, arg2 * 8) == 0 && tilemap_get_at_pixel(global.TMID_Tiles_Ceiling, (arg1 + 1) * 8, arg2 * 8) == 0)
        Dungeon_Draw_Ceiling(arg0, arg1 + 1, arg2, arg3, arg4, arg5, arg6);
    
    if ((arg1 - 1) > arg3 && tilemap_get_at_pixel(global.TMID_Walls_Upper, (arg1 - 1) * 8, arg2 * 8) == 0 && tilemap_get_at_pixel(global.TMID_Tiles_Ceiling, (arg1 - 1) * 8, arg2 * 8) == 0)
        Dungeon_Draw_Ceiling(arg0, arg1 - 1, arg2, arg3, arg4, arg5, arg6);
    
    if ((arg2 + 1) < arg6 && tilemap_get_at_pixel(global.TMID_Walls_Upper, arg1 * 8, (arg2 + 1) * 8) == 0 && tilemap_get_at_pixel(global.TMID_Tiles_Ceiling, arg1 * 8, (arg2 + 1) * 8) == 0)
        Dungeon_Draw_Ceiling(arg0, arg1, arg2 + 1, arg3, arg4, arg5, arg6);
    
    if ((arg2 - 1) > arg4 && tilemap_get_at_pixel(global.TMID_Walls_Upper, arg1 * 8, (arg2 - 1) * 8) == 0 && tilemap_get_at_pixel(global.TMID_Tiles_Ceiling, arg1 * 8, (arg2 - 1) * 8) == 0)
        Dungeon_Draw_Ceiling(arg0, arg1, arg2 - 1, arg3, arg4, arg5, arg6);
}
