Enemy_DrawShadow();
Enemy_PixelRender(true, sEnemy_Soldier_Palette, ColorIndex);
draw_self();
draw_sprite(HeadSpr, HeadIndex, x, y - 10);
shader_reset();
