Enemy_DrawShadow();
Enemy_PixelRender(true, sEnemy_Soldier_Palette, ColorIndex);

if (Dir == 1)
{
    with (WeaponInst)
        event_perform(ev_draw, ev_draw_normal);
}

draw_self();
draw_sprite(HeadSpr, HeadIndex, x, y - 6 - (floor(image_index) % 2) - ((Dir == 3 || Dir == 4) ? 2 : 0));
shader_reset();
Obj_DrawInWater();
Enemy_PixelRender(true, sEnemy_Soldier_Palette, ColorIndex);

if (Dir != 1)
{
    with (WeaponInst)
        event_perform(ev_draw, ev_draw_normal);
}

shader_reset();
