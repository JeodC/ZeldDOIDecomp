if (global.Arcade_ActiveInst.State != UnknownEnum.Value_4)
    exit;

surface_set_target(global.Arcade_ActiveInst.GameSurface);
draw_sprite_ext(sprite_index, image_index, floor(x), floor(y), 1, 1, 0, c_white, 1);
surface_reset_target();

enum UnknownEnum
{
    Value_4 = 4
}
