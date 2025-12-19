Enemy_PixelRender(true, sEnemy_Soldier_Palette, ColorIndex);
draw_sprite(sShadow_Large, 0, x, y);
draw_self();

if (Dir == 1)
{
    with (WeaponInst)
        event_perform(ev_draw, ev_draw_normal);
}

draw_sprite(HeadSpr, HeadIndex, x, y - 8);

if (Dir == 3)
    draw_sprite(sSoldierArm, 0, x, y - 6);

if (Dir == 4)
    draw_sprite(sSoldierArm_Mirrored, 0, x, y - 6);

if (Dir != 1)
{
    with (WeaponInst)
        event_perform(ev_draw, ev_draw_normal);
}

shader_reset();
