function PixelRender_Init()
{
    global.uLighting_Status = shader_get_uniform(shd_PixelRender, "Lighting_Status");
    global.uLighting_RoomStatus = shader_get_uniform(shd_PixelRender, "Lighting_RoomStatus");
    global.uLighting_RoomBoundary[0] = shader_get_uniform(shd_PixelRender, "Lighting_RoomBoundary0");
    global.uLighting_RoomBoundary[1] = shader_get_uniform(shd_PixelRender, "Lighting_RoomBoundary1");
    global.uLighting_RoomRGB[0] = shader_get_uniform(shd_PixelRender, "Lighting_RoomRGB0");
    global.uLighting_RoomRGB[1] = shader_get_uniform(shd_PixelRender, "Lighting_RoomRGB1");
    global.uLighting_LightArray_Pos[0] = shader_get_uniform(shd_PixelRender, "Lighting_LightArray_Pos0");
    global.uLighting_LightArray_Pos[1] = shader_get_uniform(shd_PixelRender, "Lighting_LightArray_Pos1");
    global.uLighting_LightArray_RGB[0] = shader_get_uniform(shd_PixelRender, "Lighting_LightArray_RGB0");
    global.uLighting_LightArray_RGB[1] = shader_get_uniform(shd_PixelRender, "Lighting_LightArray_RGB1");
    global.uLighting_Link_Pos = shader_get_uniform(shd_PixelRender, "Lighting_Link_Pos");
    global.uLighting_Link_RGB = shader_get_uniform(shd_PixelRender, "Lighting_Link_RGB");
    global.LinkLight_Pos = array_create(3);
    global.LinkLight_RGB = array_create(3);
    global.uAlpha = shader_get_uniform(shd_PixelRender, "Alpha");
    global.uPaletteStatus = shader_get_uniform(shd_PixelRender, "PaletteStatus");
    global.uPalette_PixelSize = shader_get_uniform(shd_PixelRender, "u_pixelSize");
    global.uPalette_Uvs = shader_get_uniform(shd_PixelRender, "u_Uvs");
    global.uPalette_Index = shader_get_uniform(shd_PixelRender, "u_paletteId");
    global.uPalette_Texture = shader_get_sampler_index(shd_PixelRender, "u_palTexture");
    global.uColor_Status = shader_get_uniform(shd_PixelRender, "Color_Status");
    global.uColor = shader_get_uniform(shd_PixelRender, "Color_Index");
    global.uColor_Tint = shader_get_uniform(shd_PixelRender, "Color_Tint");
    global.uTimer = shader_get_uniform(shd_PixelRender, "uni_timer");
    global.uAlpha_Status = shader_get_uniform(shd_PixelRender, "Alpha_Status");
    global.uAlpha_Val = shader_get_uniform(shd_PixelRender, "Alpha_Val");
}

function Lighting_CreateLight(arg0, arg1, arg2, arg3, arg4, arg5 = true)
{
    if (arg0 == -1)
        return -1;
    
    var _LightIndex = array_pop(global.Level.Rooms[arg0].Lights_UnusedIndexes);
    
    if (_LightIndex == undefined)
    {
        if (global.Level.Rooms[arg0].Lights_LastIndex >= 47)
            return -1;
        
        _LightIndex = ++global.Level.Rooms[arg0].Lights_LastIndex;
    }
    
    Lighting_UpdateLight_Pos(arg0, _LightIndex, arg1, arg2);
    Lighting_UpdateLight_Radius(arg0, _LightIndex, arg3);
    Lighting_UpdateLight_RGB(arg0, _LightIndex, arg4);
    
    if (!arg5)
        Lighting_UpdateLight_Visible(arg0, _LightIndex, false);
    
    return _LightIndex;
}

function Lighting_DestroyLight(arg0, arg1)
{
    if (arg1 == -1)
        return -1;
    
    Lighting_UpdateLight_RGB(arg0, arg1, [0, 0, 0]);
    
    if (arg1 == global.Level.Rooms[arg0].Lights_LastIndex)
        global.Level.Rooms[arg0].Lights_LastIndex--;
    else
        array_push(global.Level.Rooms[arg0].Lights_UnusedIndexes, arg1);
    
    return -1;
}

function PixelRender_Dim(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7 = [0, 0, 0], arg8 = 1)
{
    if (FloorLevel == 1)
    {
        var _LinkExists = instance_exists(oLink);
        
        if (_LinkExists)
            Lighting_UpdateLinkLight(undefined, undefined, [oLink.LampLightR * oLink.LampDim, oLink.LampLightG * oLink.LampDim, oLink.LampLightB * oLink.LampDim]);
        
        PixelRender(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        
        if (_LinkExists)
            Lighting_UpdateLinkLight(undefined, undefined, [oLink.LampLightR, oLink.LampLightG, oLink.LampLightB]);
    }
    else
    {
        PixelRender(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }
}

function PixelRender(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7 = [0, 0, 0], arg8 = 1)
{
    shader_set(shd_PixelRender);
    shader_set_uniform_f(global.uAlpha, arg8);
    shader_set_uniform_i(global.uLighting_Status, global.GlobalLighting && arg0, arg1);
    shader_set_uniform_f(global.uLighting_Link_Pos, global.LinkLight_Pos[0], global.LinkLight_Pos[1], global.LinkLight_Pos[2]);
    shader_set_uniform_f(global.uLighting_Link_RGB, global.LinkLight_RGB[0], global.LinkLight_RGB[1], global.LinkLight_RGB[2]);
    var _Room0 = global.Level.Rooms[global.CurrentRoomIndex];
    shader_set_uniform_f(global.uLighting_RoomBoundary[0], _Room0.x, _Room0.y, _Room0.x2, _Room0.y2);
    shader_set_uniform_f(global.uLighting_RoomRGB[0], arg7[0], arg7[1], arg7[2], 1);
    shader_set_uniform_f_array(global.uLighting_LightArray_Pos[0], _Room0.Lights_Pos);
    shader_set_uniform_f_array(global.uLighting_LightArray_RGB[0], _Room0.Lights_RGB);
    var _DoRoom1Lights = false;
    
    if (global.TransitionRoomIndex != -1)
        _DoRoom1Lights = global.Level.Rooms[global.TransitionRoomIndex].Lighting;
    
    shader_set_uniform_i(global.uLighting_RoomStatus, _Room0.Lighting, _DoRoom1Lights);
    
    if (_DoRoom1Lights)
    {
        var _Room1 = global.Level.Rooms[global.TransitionRoomIndex];
        shader_set_uniform_f(global.uLighting_RoomBoundary[1], _Room1.x, _Room1.y, _Room1.x2, _Room1.y2);
        shader_set_uniform_f(global.uLighting_RoomRGB[1], arg7[0], arg7[1], arg7[2], 1);
        shader_set_uniform_f_array(global.uLighting_LightArray_Pos[1], _Room1.Lights_Pos);
        shader_set_uniform_f_array(global.uLighting_LightArray_RGB[1], _Room1.Lights_RGB);
    }
    
    shader_set_uniform_i(global.uPaletteStatus, arg2);
    
    if (arg2)
    {
        var Texture = sprite_get_texture(arg3, 0);
        var UVs = sprite_get_uvs(arg3, 0);
        texture_set_stage(global.uPalette_Texture, Texture);
        var TexelW = texture_get_texel_width(Texture);
        var TexelH = texture_get_texel_height(Texture);
        var TexelWx = TexelW * 0.5;
        var TexelHy = TexelH * 0.5;
        shader_set_uniform_f(global.uPalette_PixelSize, TexelW, TexelH);
        shader_set_uniform_f(global.uPalette_Uvs, UVs[0] + TexelWx, UVs[1] + TexelHy, UVs[2], UVs[3]);
        shader_set_uniform_f(global.uPalette_Index, arg4);
    }
    
    shader_set_uniform_i(global.uColor_Status, arg5);
    
    if (arg5)
        shader_set_uniform_f(global.uColor_Tint, arg6[0], arg6[1], arg6[2], 1);
}

function Lighting_UpdateLinkLight(arg0 = -1, arg1 = -1, arg2 = -1)
{
    if (arg0 != -1)
    {
        global.LinkLight_Pos[0] = arg0[0];
        global.LinkLight_Pos[1] = arg0[1];
    }
    
    if (arg1 != -1)
        global.LinkLight_Pos[2] = arg1;
    
    if (arg2 != -1)
    {
        global.LinkLight_RGB[0] = arg2[0];
        global.LinkLight_RGB[1] = arg2[1];
        global.LinkLight_RGB[2] = arg2[2];
    }
}

function Lighting_UpdateLight_Pos(arg0, arg1, arg2, arg3)
{
    if (arg1 == -1)
        exit;
    
    var _ArrayPos = arg1 * 3;
    global.Level.Rooms[arg0].Lights_Pos[_ArrayPos] = arg2;
    global.Level.Rooms[arg0].Lights_Pos[_ArrayPos + 1] = arg3;
}

function Lighting_UpdateLight_RGB(arg0, arg1, arg2)
{
    if (arg1 == -1)
        exit;
    
    var _ArrayPos = arg1 * 3;
    global.Level.Rooms[arg0].Lights_RGB[_ArrayPos] = arg2[0];
    global.Level.Rooms[arg0].Lights_RGB[_ArrayPos + 1] = arg2[1];
    global.Level.Rooms[arg0].Lights_RGB[_ArrayPos + 2] = arg2[2];
    global.Level.Rooms[arg0].Lights_RGBOld[_ArrayPos] = arg2[0];
    global.Level.Rooms[arg0].Lights_RGBOld[_ArrayPos + 1] = arg2[1];
    global.Level.Rooms[arg0].Lights_RGBOld[_ArrayPos + 2] = arg2[2];
}

function Lighting_UpdateLight_Radius(arg0, arg1, arg2)
{
    if (arg1 == -1)
        exit;
    
    var _ArrayPos = arg1 * 3;
    global.Level.Rooms[arg0].Lights_Pos[_ArrayPos + 2] = arg2;
}

function Lighting_UpdateLight_Visible(arg0, arg1, arg2)
{
    if (arg1 == -1)
        exit;
    
    var _ArrayPos = arg1 * 3;
    
    if (arg2)
    {
        global.Level.Rooms[arg0].Lights_RGB[_ArrayPos] = global.Level.Rooms[arg0].Lights_RGBOld[_ArrayPos];
        global.Level.Rooms[arg0].Lights_RGB[_ArrayPos + 1] = global.Level.Rooms[arg0].Lights_RGBOld[_ArrayPos + 1];
        global.Level.Rooms[arg0].Lights_RGB[_ArrayPos + 2] = global.Level.Rooms[arg0].Lights_RGBOld[_ArrayPos + 2];
    }
    else
    {
        global.Level.Rooms[arg0].Lights_RGB[_ArrayPos] = 0;
        global.Level.Rooms[arg0].Lights_RGB[_ArrayPos + 1] = 0;
        global.Level.Rooms[arg0].Lights_RGB[_ArrayPos + 2] = 0;
    }
}

function PixelRender_Tiles_Ceiling()
{
    if (event_type == ev_draw && event_number == 0)
        PixelRender(true, false, false, -4, 0, false, 0, [0.15, 0.15, 0.15]);
}

function PixelRender_Tiles_Simple()
{
    if (event_type == ev_draw && event_number == 0)
    {
        with (oDoor)
        {
            if (FloorLight == -1)
                continue;
            
            Lighting_UpdateLight_Visible(RoomIndex, FloorLight, false);
        }
        
        PixelRender(true, true, false, -4, 0, false, []);
        
        with (oDoor)
        {
            if (FloorLight == -1)
                continue;
            
            if (Status == UnknownEnum.Value_0 || Status == UnknownEnum.Value_6 || Status == UnknownEnum.Value_9)
                Lighting_UpdateLight_Visible(RoomIndex, FloorLight, true);
        }
    }
}

function PixelRender_Tiles_Floor_Upper()
{
    if (event_type == ev_draw && event_number == 0)
    {
        with (oDoor)
        {
            if (FloorLight == -1)
                continue;
            
            if (Status == UnknownEnum.Value_0 || Status == UnknownEnum.Value_6 || Status == UnknownEnum.Value_9)
                Lighting_UpdateLight_Visible(RoomIndex, FloorLight, true);
        }
        
        var _LinkExists = instance_exists(oLink);
        
        if (_LinkExists)
            Lighting_UpdateLinkLight(undefined, undefined, [oLink.LampLightR * oLink.LampDim, oLink.LampLightG * oLink.LampDim, oLink.LampLightB * oLink.LampDim]);
        
        with (oTorch)
        {
            if (FloorLevel == 0 && (Lit || Lighting))
                Lighting_UpdateLight_Visible(RoomIndex, LightIndex, false);
        }
        
        with (oProjectile)
        {
            if (LightIndex == -1)
                continue;
            
            if (FloorLevel == 0)
                Lighting_UpdateLight_Visible(RoomIndex, LightIndex, false);
        }
        
        with (oEffects)
        {
            if (LightIndex == -1)
                continue;
            
            if (FloorLevel == 0)
                Lighting_UpdateLight_Visible(RoomIndex, LightIndex, false);
        }
        
        PixelRender(true, true, false, -4, 0, false, []);
        
        if (_LinkExists)
            Lighting_UpdateLinkLight(undefined, undefined, [oLink.LampLightR, oLink.LampLightG, oLink.LampLightB]);
        
        with (oEffects)
        {
            if (LightIndex == -1)
                continue;
            
            if (FloorLevel == 0)
                Lighting_UpdateLight_Visible(RoomIndex, LightIndex, true);
        }
        
        with (oProjectile)
        {
            if (LightIndex == -1)
                continue;
            
            if (FloorLevel == 0)
                Lighting_UpdateLight_Visible(RoomIndex, LightIndex, true);
        }
        
        with (oTorch)
        {
            if (FloorLevel == 0 && (Lit || Lighting))
                Lighting_UpdateLight_Visible(RoomIndex, LightIndex, true);
        }
        
        with (oDoor)
        {
            if (FloorLight == -1)
                continue;
            
            Lighting_UpdateLight_Visible(RoomIndex, FloorLight, false);
        }
    }
}

function PixelRender_Tiles_Floor_Lower()
{
    if (event_type == ev_draw && event_number == 0)
    {
        with (oDoor)
        {
            if (FloorLight == -1)
                continue;
            
            if (Status == UnknownEnum.Value_0 || Status == UnknownEnum.Value_6 || Status == UnknownEnum.Value_9)
                Lighting_UpdateLight_Visible(RoomIndex, FloorLight, true);
        }
        
        PixelRender(true, true, false, -4, 0, false, []);
        
        with (oDoor)
        {
            if (FloorLight == -1)
                continue;
            
            Lighting_UpdateLight_Visible(RoomIndex, FloorLight, false);
        }
    }
}

function PixelRender_Tiles_End()
{
    if (event_type == ev_draw && event_number == 0)
        shader_reset();
}

function PixelRender_Normal()
{
    PixelRender_Dim(true, true, false, -4, 0, false, []);
    draw_self();
    shader_reset();
}

function Mosaic(arg0)
{
    global.MosaicDo = true;
    global.Paused = true;
    oRender.Mosaic_Type = arg0;
    oRender.Mosaic_SizeIndex = 0;
    
    switch (arg0)
    {
        case UnknownEnum.Value_0:
            oRender.Mosaic_Speed = 0.125;
            oRender.Mosaic_Warp = true;
            break;
        
        case UnknownEnum.Value_1:
            oRender.Mosaic_Speed = 0.65;
            break;
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_6 = 6,
    Value_9 = 9
}
