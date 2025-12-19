if (State != UnknownEnum.Value_0)
{
    surface_copy_part(global.ArcadeVP_Surface, 0, 0, GameSurface, 0, 0, CamW, CamH);
    surface_set_target(global.ArcadeVP_Surface);
    draw_sprite(sShredderTV_Face, AnimationFrame_Face, 50, 48);
    draw_sprite(sShredderTV_Mask, AnimationFrame_Mask, 48, 53 + AnimationFrame_Mask);
    
    if (AnimationIndex >= 4)
        draw_sprite(sShredderTV_Hand, 0, (AnimationIndex >= 8) ? -4 : 0, 80);
    
    surface_reset_target();
}

enum UnknownEnum
{
    Value_0
}
