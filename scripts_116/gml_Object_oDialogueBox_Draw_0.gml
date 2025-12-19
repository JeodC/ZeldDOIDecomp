if (CameraExists)
{
    if (oCamera.RoomTransition != 0 || oLink.State == UnknownEnum.Value_5)
        exit;
    
    x = oCamera.X + ((oCamera.W - 200) / 2);
    y = oCamera.Y + Y;
}
else
{
    x = camera_get_view_x(view_camera[0]) + ((camera_get_view_width(view_camera[0]) - 200) / 2);
    y = camera_get_view_y(view_camera[0]) + Y;
}

TextX = x + 7;
TextY = y + 7;

if (ShowBox)
    draw_sprite_stretched(sprite_index, image_index, x, y, 200, 62);

if (SurfaceH > 0)
{
    if (!surface_exists(Surface))
        Surface = surface_create(SurfaceW, floor(SurfaceH));
    
    surface_set_target(Surface);
    draw_clear_alpha(c_black, 0);
    draw_set_color(TextColor);
    draw_set_font(global.HUDFont);
    var DialogueLen = array_length(DialogueArray);
    var _X = 0;
    
    if (CenterText)
    {
        draw_set_halign(fa_center);
        _X = BoxCenter - 2;
    }
    else
    {
        draw_set_halign(fa_left);
    }
    
    var _Y;
    
    for (var i = 0; i < DialogueLen; i++)
    {
        _Y = SurfaceY + (i * 16);
        draw_text(_X, _Y, DialogueArray[i]);
    }
    
    switch (ScriptCode)
    {
        case UnknownEnum.Value_1:
            draw_set_halign(fa_center);
            var Str = "Yes   No";
            YPos = ((DialogueLen % 3) == 2) ? (_Y + 16) : (_Y + 24);
            draw_text(BoxCenter, YPos, Str);
            draw_text(BoxCenter + ((InputChoice == 0) ? -25 : 6), YPos, "");
            break;
        
        case UnknownEnum.Value_2:
            draw_set_halign(fa_center);
            var Str = "Buy   Cancel   Info";
            draw_text(BoxCenter, _Y + 24, Str);
            
            switch (InputChoice)
            {
                case 0:
                    draw_text(BoxCenter + -52, _Y + 24, "");
                    break;
                
                case 1:
                    draw_text(BoxCenter + -21, _Y + 24, "");
                    break;
                
                case 2:
                    draw_text(BoxCenter + 24, _Y + 24, "");
                    break;
            }
            
            break;
        
        case UnknownEnum.Value_3:
            draw_set_halign(fa_center);
            var Str = "Cancel    Quit    New Game";
            draw_text(BoxCenter, _Y + 24, Str);
            
            switch (InputChoice)
            {
                case 0:
                    draw_text(BoxCenter + -72, _Y + 24, "");
                    break;
                
                case 1:
                    draw_text(BoxCenter + -23, _Y + 24, "");
                    break;
                
                case 2:
                    draw_text(BoxCenter + 14, _Y + 24, "");
                    break;
            }
            
            break;
    }
    
    surface_reset_target();
    draw_surface(Surface, TextX, TextY);
}

enum UnknownEnum
{
    Value_1 = 1,
    Value_2,
    Value_3,
    Value_5 = 5
}
