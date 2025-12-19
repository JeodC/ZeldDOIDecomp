PixelRender_Dim(true, true, false, -4, 0, false, []);
draw_self();

if (ShopType == UnknownEnum.Value_0 && SoldOut)
{
    draw_sprite(sShadow_Sign, 0, x, SignY);
    draw_sprite(sSoldOut, 0, x, SignY);
}

shader_reset();

enum UnknownEnum
{
    Value_0
}
