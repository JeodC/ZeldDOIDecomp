Enemy_DrawShadow();

switch (State)
{
    default:
        Enemy_PixelRender();
        break;
    
    case UnknownEnum.Value_1:
        PixelRender_Dim(true, true, false, -4, 0, true, WakeColors[WakeColorFrame]);
        break;
}

draw_sprite(sprite_index, image_index, x, y);
shader_reset();
Obj_DrawInWater();

enum UnknownEnum
{
    Value_1 = 1
}
