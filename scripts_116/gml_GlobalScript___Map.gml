global.MapInst = -4;
global.MapHidden = false;
global.MapSurface = 0;

function Map_GenerateRoomSprite(arg0)
{
    if (!global.Level.IsBossLevel && TemplateCheck(arg0, UnknownEnum.Value_9, UnknownEnum.Value_0))
        exit;
    
    RoomTemplates_Parse_GenerateObjGrids(arg0);
    var RoomSprSurface = surface_create(global.Level.Rooms[arg0].MapW, global.Level.Rooms[arg0].MapH);
    var RoomSprSurface_Visited = surface_create(global.Level.Rooms[arg0].MapW, global.Level.Rooms[arg0].MapH);
    surface_set_target(RoomSprSurface);
    draw_clear_alpha(#242424, 1);
    
    for (var GridY = 2; GridY < (global.Level.Rooms[arg0].MapH - 2); GridY++)
    {
        for (var GridX = 2; GridX < (global.Level.Rooms[arg0].MapW - 2); GridX++)
        {
            if (!global.Level.Rooms[arg0].TemplateObjGrid.OutOfBounds[GridY][GridX])
                draw_sprite_ext(sPixel, 0, GridX, GridY, 1, 1, 0, c_black, 1);
            
            if (global.Level.Rooms[arg0].TemplateObjGrid.WallsUpper[GridY][GridX])
                draw_sprite_ext(sPixel, 0, GridX, GridY, 1, 1, 0, c_dkgray, 1);
            
            if (global.Level.Rooms[arg0].TemplateObjGrid.ExtraCeilings[GridY][GridX])
                draw_sprite_ext(sPixel, 0, GridX, GridY, 1, 1, 0, c_dkgray, 1);
        }
    }
    
    if (sprite_exists(global.Level.Rooms[arg0].MapSpr))
        sprite_delete(global.Level.Rooms[arg0].MapSpr);
    
    global.Level.Rooms[arg0].MapSpr = sprite_create_from_surface(RoomSprSurface, 0, 0, global.Level.Rooms[arg0].MapW, global.Level.Rooms[arg0].MapH, false, false, 0, 0);
    surface_reset_target();
    surface_free(RoomSprSurface);
    surface_set_target(RoomSprSurface_Visited);
    draw_clear_alpha(#001E3C, 1);
    
    for (var GridY = 2; GridY < (global.Level.Rooms[arg0].MapH - 2); GridY++)
    {
        for (var GridX = 2; GridX < (global.Level.Rooms[arg0].MapW - 2); GridX++)
        {
            if (!global.Level.Rooms[arg0].TemplateObjGrid.OutOfBounds[GridY][GridX])
                draw_sprite_ext(sPixel, 0, GridX, GridY, 1, 1, 0, #003C5A, 1);
            
            if (global.Level.Rooms[arg0].TemplateObjGrid.WallsUpper[GridY][GridX])
                draw_sprite_ext(sPixel, 0, GridX, GridY, 1, 1, 0, #005582, 1);
            
            if (global.Level.Rooms[arg0].TemplateObjGrid.ExtraCeilings[GridY][GridX])
                draw_sprite_ext(sPixel, 0, GridX, GridY, 1, 1, 0, #005582, 1);
        }
    }
    
    if (sprite_exists(global.Level.Rooms[arg0].MapSpr_Visited))
        sprite_delete(global.Level.Rooms[arg0].MapSpr_Visited);
    
    global.Level.Rooms[arg0].MapSpr_Visited = sprite_create_from_surface(RoomSprSurface_Visited, 0, 0, global.Level.Rooms[arg0].MapW, global.Level.Rooms[arg0].MapH, false, false, 0, 0);
    surface_reset_target();
    surface_free(RoomSprSurface_Visited);
}

function Map_Init()
{
    if (!surface_exists(global.MapSurface))
        global.MapSurface = surface_create(256, 256);
    
    surface_set_target(global.MapSurface);
    draw_clear_alpha(c_black, 0);
    var _Rooms = array_length(global.Level.Rooms);
    
    for (var _RoomIndex = 0; _RoomIndex < _Rooms; _RoomIndex++)
    {
        var _House = TemplateCheck(_RoomIndex, UnknownEnum.Value_4, UnknownEnum.Value_1) || TemplateCheck(_RoomIndex, UnknownEnum.Value_5, UnknownEnum.Value_1);
        var _BossRoom = !global.Level.IsBossLevel && TemplateCheck(_RoomIndex, UnknownEnum.Value_9, UnknownEnum.Value_0);
        var _MineCave = global.Level.Index == UnknownEnum.Value_10 && (global.Level.Rooms[_RoomIndex].GridY >= 5 || (global.Level.Rooms[_RoomIndex].GridY == 4 && global.Level.Rooms[_RoomIndex].GridX != 4 && global.Level.Rooms[_RoomIndex].GridX != 5));
        var _MineMapRoom = global.Level.Index == UnknownEnum.Value_10 && global.Level.Rooms[_RoomIndex].GridX == 5 && global.Level.Rooms[_RoomIndex].GridY == 1;
        
        if (global.Level.Rooms[_RoomIndex].Secret != -1 || _House || _BossRoom || _MineCave || _MineMapRoom)
            continue;
        
        if (sprite_exists(global.Level.Rooms[_RoomIndex].MapSpr))
            draw_sprite(global.Level.Rooms[_RoomIndex].MapSpr, 0, global.Level.Rooms[_RoomIndex].MapX, global.Level.Rooms[_RoomIndex].MapY);
    }
    
    if (sprite_exists(global.Level.Map_Sprite_All))
        sprite_delete(global.Level.Map_Sprite_All);
    
    global.Level.Map_Sprite_All = sprite_create_from_surface(global.MapSurface, 0, 0, 256, 256, false, false, 0, 0);
    draw_clear_alpha(c_black, 0);
    
    for (var _RoomIndex = 0; _RoomIndex < _Rooms; _RoomIndex++)
    {
        var _House = TemplateCheck(_RoomIndex, UnknownEnum.Value_4, UnknownEnum.Value_1) || TemplateCheck(_RoomIndex, UnknownEnum.Value_5, UnknownEnum.Value_1);
        var _BossRoom = !global.Level.IsBossLevel && TemplateCheck(_RoomIndex, UnknownEnum.Value_9, UnknownEnum.Value_0);
        
        if (_House || _BossRoom)
            continue;
        
        if (sprite_exists(global.Level.Rooms[_RoomIndex].MapSpr_Doors))
            draw_sprite(global.Level.Rooms[_RoomIndex].MapSpr_Doors, 0, global.Level.Rooms[_RoomIndex].MapX, global.Level.Rooms[_RoomIndex].MapY);
    }
    
    if (sprite_exists(global.Level.Map_Sprite_Doors_All))
        sprite_delete(global.Level.Map_Sprite_Doors_All);
    
    global.Level.Map_Sprite_Doors_All = sprite_create_from_surface(global.MapSurface, 0, 0, 256, 256, false, false, 0, 0);
    surface_reset_target();
}

function Map_UpdateExploredRooms()
{
    if (!surface_exists(global.MapSurface))
        global.MapSurface = surface_create(256, 256);
    
    surface_set_target(global.MapSurface);
    draw_clear_alpha(c_black, 0);
    global.Level.RoomsVisted = 0;
    
    for (var _RoomIndex = 0; _RoomIndex < global.Level.RoomCount; _RoomIndex++)
    {
        if (!global.Level.Rooms[_RoomIndex].Visited)
            continue;
        
        if (global.Level.Index > UnknownEnum.Value_0)
        {
            if (TemplateCheck(_RoomIndex, UnknownEnum.Value_4, UnknownEnum.Value_1) || TemplateCheck(_RoomIndex, UnknownEnum.Value_5, UnknownEnum.Value_1))
                continue;
        }
        
        draw_sprite(global.Level.Rooms[_RoomIndex].MapSpr_Visited, 0, global.Level.Rooms[_RoomIndex].MapX, global.Level.Rooms[_RoomIndex].MapY);
        global.Level.RoomsVisted++;
    }
    
    global.Level.RoomsVistedPercent = global.Level.RoomsVisted / global.Level.RoomCount;
    
    if (sprite_exists(global.Level.Map_Sprite_Explored))
        sprite_delete(global.Level.Map_Sprite_Explored);
    
    global.Level.Map_Sprite_Explored = sprite_create_from_surface(global.MapSurface, 0, 0, 256, 256, false, false, 0, 0);
    draw_clear_alpha(c_black, 0);
    
    for (var _RoomIndex = 0; _RoomIndex < global.Level.RoomCount; _RoomIndex++)
    {
        if (!global.Level.Rooms[_RoomIndex].Visited)
            continue;
        
        if (sprite_exists(global.Level.Rooms[_RoomIndex].MapSpr_Doors))
            draw_sprite(global.Level.Rooms[_RoomIndex].MapSpr_Doors, 0, global.Level.Rooms[_RoomIndex].MapX, global.Level.Rooms[_RoomIndex].MapY);
    }
    
    if (sprite_exists(global.Level.Map_Sprite_Doors_Explored))
        sprite_delete(global.Level.Map_Sprite_Doors_Explored);
    
    global.Level.Map_Sprite_Doors_Explored = sprite_create_from_surface(global.MapSurface, 0, 0, 256, 256, false, false, 0, 0);
    surface_reset_target();
}

function Map_Clear()
{
    if (is_struct(global.Level))
    {
        if (sprite_exists(global.Level.Map_Sprite_All))
            sprite_delete(global.Level.Map_Sprite_All);
        
        if (sprite_exists(global.Level.Map_Sprite_Explored))
            sprite_delete(global.Level.Map_Sprite_Explored);
        
        if (sprite_exists(global.Level.Map_Sprite_Doors_All))
            sprite_delete(global.Level.Map_Sprite_Doors_All);
        
        if (sprite_exists(global.Level.Map_Sprite_Doors_Explored))
            sprite_delete(global.Level.Map_Sprite_Doors_Explored);
        
        for (var _RoomIndex = 0; _RoomIndex < global.Level.RoomCount; _RoomIndex++)
        {
            if (sprite_exists(global.Level.Rooms[_RoomIndex].MapSpr))
                sprite_delete(global.Level.Rooms[_RoomIndex].MapSpr);
            
            if (sprite_exists(global.Level.Rooms[_RoomIndex].MapSpr_Visited))
                sprite_delete(global.Level.Rooms[_RoomIndex].MapSpr_Visited);
            
            if (sprite_exists(global.Level.Rooms[_RoomIndex].MapSpr_Doors))
                sprite_delete(global.Level.Rooms[_RoomIndex].MapSpr_Doors);
        }
    }
    
    ds_list_clear(global.LargeMapItems);
}

function Map_GetCoordinate_Small(arg0)
{
    return round(arg0 / 32);
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_4 = 4,
    Value_5,
    Value_9 = 9,
    Value_10
}
