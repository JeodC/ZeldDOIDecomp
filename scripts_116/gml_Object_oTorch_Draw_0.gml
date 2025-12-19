if (Lit)
{
    draw_self();
}
else
{
    PixelRender_Dim(true, true, false, -4, 0, false, []);
    draw_self();
    shader_reset();
}
