if (State == UnknownEnum.Value_0 || !Visible)
    exit;

Enemy_PixelRender(true, sEnemy_Delevant_Pal, Index);
draw_sprite(sprite_index, image_index, x, y);
shader_reset();
Enemy_PixelRender();

if (State == UnknownEnum.Value_1 || State == UnknownEnum.Value_8)
    draw_sprite(sInSand, global.InWaterImgIndex, x, y + 4);

shader_reset();

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_8 = 8
}
