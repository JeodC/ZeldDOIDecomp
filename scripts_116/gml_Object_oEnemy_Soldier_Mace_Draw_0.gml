Enemy_DrawShadow();
Enemy_PixelRender(true, sEnemy_Soldier_Palette, ColorIndex);
draw_self();
draw_sprite(HeadSpr, HeadIndex, x, y - 8);

if (Dir == 3)
    draw_sprite(sSoldierArm, 0, x, y - 6);

if (Dir == 4)
    draw_sprite(sSoldierArm_Mirrored, 0, x, y - 6);

shader_reset();
Obj_DrawInWater();
