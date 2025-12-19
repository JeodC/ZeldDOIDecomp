if (global.Challenges[UnknownEnum.Value_4] && GLighting)
{
    if (!global.GlobalLighting)
    {
        draw_set_color(c_white);
        draw_set_alpha(0.5);
        draw_rectangle(oCamera.X, oCamera.Y, oCamera.X2, oCamera.Y2, false);
        draw_set_alpha(1);
    }
}
else
{
    draw_set_color(!global.GlobalLighting ? c_white : #000030);
    draw_set_alpha(0.65);
    draw_rectangle(oCamera.X, oCamera.Y, oCamera.X2, oCamera.Y2, false);
    draw_set_alpha(1);
}

draw_set_color(c_black);
draw_set_alpha(DarkScreenAlpha);
draw_rectangle(oCamera.X, oCamera.Y, oCamera.X + 256, oCamera.Y + 224, false);
draw_set_alpha(1);
draw_set_color(c_white);

enum UnknownEnum
{
    Value_4 = 4
}
