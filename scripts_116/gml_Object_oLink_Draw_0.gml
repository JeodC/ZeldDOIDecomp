if (global.MosaicDo)
    exit;

if (HitFlashingStatus)
    exit;

var LinkSpr;

if (State == UnknownEnum.Value_22)
{
    LinkSpr = surface_create(sprite_width, sprite_height);
    surface_set_target(LinkSpr);
    draw_clear_alpha(c_black, 0);
}

Lighting = global.Level.Rooms[global.CurrentRoomIndex].TemplateName == "Arcade" || global.Level.Index == UnknownEnum.Value_0 || global.Level.Rooms[global.CurrentRoomIndex].Heat;
Link_PixelRender();

if (State != UnknownEnum.Value_22 && State != UnknownEnum.Value_20 && !InWater)
    draw_sprite(sShadow_Large, 0, x, y);

if (ShieldDir == 1)
    Shield_Draw();

if (Facing == 1)
{
    switch (State)
    {
        case UnknownEnum.Value_13:
            draw_sprite_ext(BowSprite, 2, x - 12, y - 8, 1, -1, 0, c_white, 1);
            break;
    }
}

draw_set_alpha(0.5);

if (State == UnknownEnum.Value_22)
    draw_sprite(sprite_index, image_index, sprite_xoffset, sprite_yoffset);
else if (!Cape)
    draw_sprite(sprite_index, image_index, x, y);

draw_set_alpha(1);
shader_reset();
PixelRender(Lighting, Lighting, false, -4, 0, false, 0);

if (InWater)
    draw_sprite(global.InWaterSprite, global.InWaterImgIndex, x, y);

shader_reset();
Link_PixelRender();

if (ShieldDir != 1)
    Shield_Draw();

if (Facing != 1)
{
    switch (State)
    {
        case UnknownEnum.Value_13:
            switch (image_index)
            {
                case 0:
                    switch (Facing)
                    {
                        case 3:
                            draw_sprite_ext(BowSprite, 0, x + 5, y - 10, -1, 1, 0, c_white, 1);
                            break;
                        
                        case 4:
                            draw_sprite(BowSprite, 0, x - 5, y - 10);
                            break;
                        
                        case 2:
                            draw_sprite(BowSprite, 1, x + 2, y - 12);
                            break;
                    }
                    
                    break;
                
                default:
                    switch (Facing)
                    {
                        case 3:
                            draw_sprite_ext(BowSprite, 1, x - 4, y - 14, -1, 1, 0, c_white, 1);
                            break;
                        
                        case 4:
                            draw_sprite(BowSprite, 1, x + 4, y - 14);
                            break;
                        
                        case 2:
                            draw_sprite(BowSprite, 2, x - 6, y - 7);
                            break;
                    }
                    
                    break;
            }
            
            break;
    }
}

if (State == UnknownEnum.Value_22)
{
    surface_reset_target();
    var c;
    
    if (DescendingPhase == 1)
        c = 255 - (image_index * 10);
    else
        c = 80 + (image_index * 10);
    
    draw_surface_ext(LinkSpr, x - sprite_xoffset, y - sprite_yoffset - ((DescendingPhase == 1 && DescendingLocation == 2) ? 1 : 0), 1, 1, 0, make_color_rgb(c, c, c), 1);
    surface_free(LinkSpr);
}

shader_reset();

enum UnknownEnum
{
    Value_0,
    Value_13 = 13,
    Value_20 = 20,
    Value_22 = 22
}
