if (global.MosaicDo)
{
    if (!surface_exists(Mosaic_ScreenBuffer))
        Mosaic_ScreenBuffer = surface_create(1024, 896);
    
    surface_set_target(Mosaic_ScreenBuffer);
    draw_clear_alpha(c_black, 0);
    shader_set(shd_mosaic);
    shader_set_uniform_f(uMosaic_Size, Mosaic_Size);
    shader_set_uniform_f(uMosaic_Brightness, Mosaic_Warp ? (1 - (Mosaic_SizeIndex / (Mosaic_SizeCount - 1))) : 1);
    gpu_set_blendenable(false);
    draw_surface_part(application_surface, 289, 0, 1023, 896, 0, 0);
    gpu_set_blendenable(true);
    shader_reset();
    
    with (oLink)
    {
        var _x = (x - oCamera.X) * 4;
        var _y = (y - oCamera.Y) * 4;
        draw_sprite_ext(sShadow_Large, 0, _x, _y, 4, 4, 0, c_white, 1);
        
        if (Cape)
            break;
        
        var _image_index = floor(image_index);
        var SwordSprite;
        
        if (other.Mosaic_Type == UnknownEnum.Value_1 && ShockDrawSword)
        {
            SwordSprite = asset_get_index("sSword" + string(global.Inventory_ItemData[UnknownEnum.Value_44].Index) + "_Shock");
            
            if (Facing == 1)
                draw_sprite_ext(SwordSprite, _image_index, _x, _y - 64, 4, 4, 0, c_white, 1);
            
            PixelRender(false, false, PaletteSpr != -4, PaletteSpr, global.Inventory_ItemData[UnknownEnum.Value_46].Index, image_index > 1, [-3, -3, -3]);
        }
        else if (global.Cursed)
        {
            PixelRender(false, false, PaletteSpr != -4, PaletteSpr, global.Inventory_ItemData[UnknownEnum.Value_46].Index, true, [-2, -2, -2]);
        }
        else
        {
            PixelRender(false, false, PaletteSpr != -4, PaletteSpr, global.Inventory_ItemData[UnknownEnum.Value_46].Index, false, []);
        }
        
        var _DrawShield = global.Inventory_ItemData[UnknownEnum.Value_41].Index >= 0 && ItemHolding == -4;
        var _ShieldSpr, _ShieldX, _ShieldY;
        
        if (_DrawShield)
        {
            ShieldDir = Facing;
            _ShieldSpr = ShieldSprite[global.Inventory_ItemData[UnknownEnum.Value_41].Index][ShieldDir];
            _ShieldX = _x + (ShieldOffsetX[UnknownEnum.Value_1][Facing][0] * 4);
            _ShieldY = _y + (ShieldOffsetY[UnknownEnum.Value_1][Facing][0] * 4);
            
            if (ShieldDir == 1 && other.Mosaic_Type == UnknownEnum.Value_0)
                draw_sprite_ext(_ShieldSpr, 0, _ShieldX, _ShieldY, 4, 4, 0, c_white, 1);
        }
        
        draw_sprite_ext(sprite_index, image_index, _x, _y, 4, 4, 0, c_white, 1);
        
        if (_DrawShield)
        {
            if (ShieldDir != 1 && other.Mosaic_Type == UnknownEnum.Value_0)
                draw_sprite_ext(_ShieldSpr, 0, _ShieldX, _ShieldY, 4, 4, 0, c_white, 1);
        }
        
        if (ItemHolding != -4)
        {
            var _PosX = (ItemHolding.x - oCamera.X) * 4;
            var _PosY = (ItemHolding.y - oCamera.Y) * 4;
            draw_sprite_ext(ItemHolding.sprite_index, ItemHolding.Index, _PosX, _PosY, 4, 4, 0, c_white, 1);
        }
        
        with (oPoof_NoSound)
        {
            var _PoofX = (x - oCamera.X) * 4;
            var _PoofY = (y - oCamera.Y) * 4;
            draw_sprite_ext(sprite_index, image_index, _PoofX, _PoofY, 4, 4, 0, c_white, 1);
        }
        
        shader_reset();
        
        if (other.Mosaic_Type == UnknownEnum.Value_1 && ShockDrawSword)
        {
            switch (Facing)
            {
                case 3:
                    draw_sprite_ext(SwordSprite, _image_index, _x - 32, _y - 20, 4, 4, 90, c_white, 1);
                    break;
                
                case 4:
                    draw_sprite_ext(SwordSprite, _image_index, _x + 32, _y - 20, 4, -4, 90, c_white, 1);
                    break;
                
                case 2:
                    draw_sprite_ext(SwordSprite, _image_index, _x, _y + 8, 4, -4, 0, c_white, 1);
                    break;
            }
        }
    }
    
    surface_reset_target();
    surface_set_target(application_surface);
    gpu_set_blendenable(false);
    draw_surface(Mosaic_ScreenBuffer, 288, 0);
    gpu_set_blendenable(true);
    surface_reset_target();
}

if (HeatDo)
{
    if (!surface_exists(Mosaic_ScreenBuffer))
        Mosaic_ScreenBuffer = surface_create(1024, 896);
    
    surface_set_target(Mosaic_ScreenBuffer);
    draw_clear_alpha(c_black, 0);
    draw_surface_part(application_surface, 289, 0, 1023, 896, 0, 0);
    shader_set(shd_mosaic);
    shader_set_uniform_f(uMosaic_Size, HeatIndex);
    gpu_set_blendenable(false);
    draw_surface_part(application_surface, 289, 0, 1023, 896, 0, 0);
    gpu_set_blendenable(true);
    shader_reset();
    surface_reset_target();
    surface_set_target(application_surface);
    gpu_set_blendenable(false);
    draw_surface(Mosaic_ScreenBuffer, 288, 0);
    gpu_set_blendenable(true);
    surface_reset_target();
}

if (global.RoomFadeBlackOut || global.FadeIn || global.FadeOut)
{
    if (!surface_exists(global.RoomFadeSurface))
        global.RoomFadeSurface = surface_create(256, 224);
    
    draw_set_color(c_black);
    surface_set_target(global.RoomFadeSurface);
    draw_rectangle(0, 0, 256, 224, false);
    
    if (!global.RoomFadeBlackOut)
    {
        gpu_set_blendmode(bm_subtract);
        
        if (global.FadeRadius > 0)
        {
            var CentreX = oLink.x - oCamera.X - 1;
            var CentreY = oLink.y - oCamera.Y - 8;
            draw_ellipse(CentreX - global.FadeRadius, CentreY - (global.FadeRadius * 0.5), CentreX + global.FadeRadius, CentreY + (global.FadeRadius * 0.5), false);
        }
        
        gpu_set_blendmode(bm_normal);
    }
    
    surface_reset_target();
    surface_set_target(application_surface);
    draw_surface_ext(global.RoomFadeSurface, 288, 0, 4, 4, 0, c_white, 1);
    surface_reset_target();
}

if (oCamera.ShakeAmount != 0)
{
    surface_set_target(application_surface);
    draw_set_color(c_black);
    var _x1 = 288;
    var _y1 = 0;
    var _w = 1024;
    var _h = 896;
    var _x2 = (_x1 + _w) - 1;
    var _y2 = (_y1 + _h) - 1;
    draw_rectangle(_x1, _y1, _x2, _y2, true);
    draw_rectangle(_x1 + 1, _y1 + 1, _x2 - 1, _y2 - 1, true);
    draw_rectangle(_x1 + 2, _y1 + 2, _x2 - 2, _y2 - 2, true);
    draw_rectangle(_x1 + 3, _y1 + 3, _x2 - 3, _y2 - 3, true);
    draw_set_color(c_white);
    surface_reset_target();
}

if (global.Users[global.UserIndex].Prefs[UnknownEnum.Value_3])
    CRT_Do(application_surface, 0, 0, CRT_Sizes, false, 0.04, false, 0.03, 80, true, false, true, 0.04);
else
    draw_surface(application_surface, 0, 0);

if (global.ArcadeVP_Show)
{
    draw_set_color(c_black);
    draw_set_alpha(0.5);
    draw_rectangle(View1X, 0, View1X2, View1Y2, false);
    draw_set_color(c_white);
    draw_set_alpha(1);
    CRT_Do_Stretch(global.ArcadeVP_Surface, global.ArcadeVP_RenderX, global.ArcadeVP_RenderY, global.ArcadeVP_RenderW, global.ArcadeVP_RenderH, global.ArcadeVP_Sizes, true, 0.2, true, 0.025, 80, true, true, true, 0.04);
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_3 = 3,
    Value_41 = 41,
    Value_44 = 44,
    Value_46 = 46
}
