PixelRender(true, true, false, -4, 0, false, []);

if (State == UnknownEnum.Value_5 && DeliveredLetter)
    draw_sprite(sItem_Letter, 0, x + 8, y + 26);

draw_self();
shader_reset();

if (TurningGrey)
{
    PixelRender(true, true, false, -4, 0, false, [], undefined, TurningGreyAlpha);
    draw_sprite(sprite_index, 3, x, y);
    shader_reset();
}

enum UnknownEnum
{
    Value_5 = 5
}
