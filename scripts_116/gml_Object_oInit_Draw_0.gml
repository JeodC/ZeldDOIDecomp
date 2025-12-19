draw_set_color(c_black);
draw_rectangle(0, 0, 400, 225, false);

if (Draw)
{
    draw_set_font(global.HUDFont2);
    draw_set_color(c_white);
    draw_text(20, 20, "LOADING...");
}
