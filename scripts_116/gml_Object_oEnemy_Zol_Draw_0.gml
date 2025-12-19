if (State == UnknownEnum.Value_0)
    exit;

Enemy_DrawShadow();
Enemy_PixelRender();
draw_sprite_ext(sprite_index, image_index, x, y, LookDir, 1, 0, c_white, 1);
shader_reset();
Obj_DrawInWater();

enum UnknownEnum
{
    Value_0
}
