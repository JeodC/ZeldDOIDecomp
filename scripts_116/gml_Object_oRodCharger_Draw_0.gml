draw_sprite(sprite_index, 0, x, y);

if (RodInserted)
{
    PixelRender(false, false, false, -4, 0, alarm[0] > 0, ChargeColors[ChargeColor]);
    draw_sprite(sItem_Rod, RodIndex, x, y);
    shader_reset();
}
